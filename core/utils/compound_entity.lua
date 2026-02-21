local common = require("core.utils.common")

---@class WarpageCompoundEntityImpl: WarpageCompoundEntity
---@field _definition WarpageCompoundEntityDefinition
---@field _bound boolean
local CompoundEntity = {}
CompoundEntity.__index = CompoundEntity

---@param definition unknown
---@return WarpageCompoundEntityDefinition
local function normalize_definition(definition)
  common.ensure_table(definition, "definition")
  ---@cast definition WarpageCompoundEntityDefinition

  common.ensure_non_empty_string(definition.id, "definition.id")
  common.ensure_non_empty_string(definition.main_entity_name, "definition.main_entity_name")
  common.ensure_table(definition.parts, "definition.parts")

  if #definition.parts == 0 then
    error("definition.parts must include at least one part.")
  end

  local normalized_parts = {} ---@type WarpageCompoundEntityPartDefinition[]
  local seen_ids = {} ---@type table<string, true>

  for index = 1, #definition.parts do
    local path = "definition.parts[" .. tostring(index) .. "]"
    local part = definition.parts[index]
    if part == nil then
      error(path .. " is required.")
    end

    common.ensure_table(part, path)
    ---@cast part WarpageCompoundEntityPartDefinition

    common.ensure_non_empty_string(part.id, path .. ".id")
    common.ensure_non_empty_string(part.entity_name, path .. ".entity_name")
    common.ensure_position(part.offset, path .. ".offset")

    if seen_ids[part.id] then
      error("Duplicate part id '" .. part.id .. "' in definition.parts.")
    end
    seen_ids[part.id] = true

    local direction = part.direction
    if direction ~= nil then
      common.ensure_direction(direction, path .. ".direction")
      ---@cast direction WarpageDirection
    end

    local direction_relative = true
    if part.direction_relative ~= nil then
      common.ensure_boolean(part.direction_relative, path .. ".direction_relative")
      direction_relative = part.direction_relative
    end

    if part.create_build_effect_smoke ~= nil then
      common.ensure_boolean(part.create_build_effect_smoke, path .. ".create_build_effect_smoke")
    end

    if part.on_ready ~= nil then
      common.ensure_function(part.on_ready, path .. ".on_ready")
    end

    normalized_parts[#normalized_parts + 1] = {
      id = part.id,
      entity_name = part.entity_name,
      offset = common.copy_position(part.offset),
      direction = direction,
      direction_relative = direction_relative,
      force = part.force,
      quality = part.quality,
      create_build_effect_smoke = part.create_build_effect_smoke,
      on_ready = part.on_ready
    }
  end

  if definition.matches_main_entity ~= nil then
    common.ensure_function(definition.matches_main_entity, "definition.matches_main_entity")
  end

  if definition.on_main_entity_ready ~= nil then
    common.ensure_function(definition.on_main_entity_ready, "definition.on_main_entity_ready")
  end

  if definition.on_main_entity_pre_destroy ~= nil then
    common.ensure_function(definition.on_main_entity_pre_destroy, "definition.on_main_entity_pre_destroy")
  end

  return {
    id = definition.id,
    main_entity_name = definition.main_entity_name,
    parts = normalized_parts,
    matches_main_entity = definition.matches_main_entity,
    on_main_entity_ready = definition.on_main_entity_ready,
    on_main_entity_pre_destroy = definition.on_main_entity_pre_destroy
  }
end

---@param definition WarpageCompoundEntityDefinition
---@return WarpageCompoundEntity
function CompoundEntity.new(definition)
  local normalized_definition = normalize_definition(definition)

  return setmetatable({
    _definition = normalized_definition,
    _bound = false
  }, CompoundEntity --[[@as metatable]])
end

---@param entity LuaEntity|nil
---@return boolean
function CompoundEntity:is_main_entity(entity)
  if entity == nil or not entity.valid then
    return false
  end

  if entity.name ~= self._definition.main_entity_name then
    return false
  end

  local matcher = self._definition.matches_main_entity
  if matcher ~= nil and matcher(entity) ~= true then
    return false
  end

  return true
end

---@param main_entity unknown
---@return LuaEntity
function CompoundEntity:_assert_main_entity(main_entity)
  local main_entity_type = type(main_entity)
  if main_entity_type ~= "table" and main_entity_type ~= "userdata" then
    error("main_entity must be a valid LuaEntity.")
  end

  ---@cast main_entity LuaEntity
  if main_entity.valid ~= true or type(main_entity.name) ~= "string" then
    error("main_entity must be a valid LuaEntity.")
  end

  if not self:is_main_entity(main_entity) then
    error(
      "Entity '"
        .. main_entity.name
        .. "' does not match compound main entity '"
        .. self._definition.main_entity_name
        .. "'."
    )
  end

  return main_entity
end

---@param main_entity LuaEntity
---@param part WarpageCompoundEntityPartDefinition
---@return MapPosition
local function part_position(main_entity, part)
  local rotated = common.rotate_offset(part.offset, main_entity.direction)
  return {
    x = main_entity.position.x + rotated.x,
    y = main_entity.position.y + rotated.y
  }
end

---@param main_entity LuaEntity
---@param part WarpageCompoundEntityPartDefinition
---@return WarpageDirection|nil
local function part_direction(main_entity, part)
  local base_direction = part.direction
  if base_direction == nil then
    if part.direction_relative == false then
      return nil
    end

    return main_entity.direction
  end

  if part.direction_relative == false then
    return base_direction
  end

  local direction = common.normalize_direction(main_entity.direction + base_direction)
  return direction
end

---@param main_entity LuaEntity
---@param part WarpageCompoundEntityPartDefinition
---@return ForceIdentification
local function part_force(main_entity, part)
  if part.force ~= nil then
    return part.force
  end

  return main_entity.force
end

---@param main_entity LuaEntity
---@param part WarpageCompoundEntityPartDefinition
---@param expected_position MapPosition
---@param expected_force ForceIdentification
---@return LuaEntity[]
local function find_part_entities(main_entity, part, expected_position, expected_force)
  local candidates = main_entity.surface.find_entities_filtered({
    position = expected_position,
    name = part.entity_name,
    force = expected_force
  })

  local matches = {} ---@type LuaEntity[]
  for _, candidate in ipairs(candidates) do
    if candidate.valid and common.positions_match(candidate.position, expected_position) then
      matches[#matches + 1] = candidate
    end
  end

  return matches
end

---@param main_entity LuaEntity
---@param part WarpageCompoundEntityPartDefinition
---@param expected_position MapPosition
---@param expected_direction WarpageDirection|nil
---@param expected_force ForceIdentification
---@return LuaEntity
function CompoundEntity:_create_part_entity(main_entity, part, expected_position, expected_direction, expected_force)
  local create_options = {
    name = part.entity_name,
    position = expected_position,
    force = expected_force
  }

  if expected_direction ~= nil then
    create_options.direction = expected_direction
  end

  if part.quality ~= nil then
    create_options.quality = part.quality
  end

  if part.create_build_effect_smoke ~= nil then
    create_options.create_build_effect_smoke = part.create_build_effect_smoke
  end

  local created_entity = main_entity.surface.create_entity(create_options)
  if created_entity == nil then
    error(
      "Unable to create part '"
        .. part.id
        .. "' for compound '"
        .. self._definition.id
        .. "' on surface '"
        .. main_entity.surface.name
        .. "'."
    )
  end

  return created_entity
end

---@param main_entity LuaEntity
---@param part WarpageCompoundEntityPartDefinition
---@return LuaEntity
function CompoundEntity:_ensure_part_entity(main_entity, part)
  local expected_position = part_position(main_entity, part)
  local expected_direction = part_direction(main_entity, part)
  local expected_force = part_force(main_entity, part)

  local existing_entities = find_part_entities(main_entity, part, expected_position, expected_force)
  local part_entity = existing_entities[1] ---@type LuaEntity|nil
  local created = false

  for index = 2, #existing_entities do
    local duplicate = existing_entities[index]
    if duplicate.valid then
      duplicate.destroy()
    end
  end

  if part_entity ~= nil and part.quality ~= nil and part_entity.quality ~= part.quality then
    part_entity.destroy()
    part_entity = nil
  end

  if part_entity == nil then
    part_entity = self:_create_part_entity(main_entity, part, expected_position, expected_direction, expected_force)
    created = true
  elseif expected_direction ~= nil and part_entity.direction ~= expected_direction then
    part_entity.direction = expected_direction
  end

  if part.on_ready ~= nil then
    part.on_ready(part_entity, main_entity, created)
  end

  return part_entity
end

---@param main_entity LuaEntity
function CompoundEntity:_run_main_ready_hook(main_entity)
  local on_main_entity_ready = self._definition.on_main_entity_ready
  if on_main_entity_ready ~= nil then
    on_main_entity_ready(main_entity)
  end
end

---@param main_entity LuaEntity
---@return LuaEntity[]
function CompoundEntity:sync(main_entity)
  main_entity = self:_assert_main_entity(main_entity)
  self:_run_main_ready_hook(main_entity)

  local part_entities = {} ---@type LuaEntity[]
  for _, part in ipairs(self._definition.parts) do
    part_entities[#part_entities + 1] = self:_ensure_part_entity(main_entity, part)
  end

  return part_entities
end

---@param main_entity LuaEntity
function CompoundEntity:cleanup(main_entity)
  main_entity = self:_assert_main_entity(main_entity)

  local on_main_entity_pre_destroy = self._definition.on_main_entity_pre_destroy
  if on_main_entity_pre_destroy ~= nil then
    on_main_entity_pre_destroy(main_entity)
  end

  for _, part in ipairs(self._definition.parts) do
    local expected_position = part_position(main_entity, part)
    local expected_force = part_force(main_entity, part)
    local existing_entities = find_part_entities(main_entity, part, expected_position, expected_force)

    for _, part_entity in ipairs(existing_entities) do
      if part_entity.valid and part_entity ~= main_entity then
        part_entity.destroy()
      end
    end
  end
end

---@param placement WarpageCompoundEntityPlacement
---@return LuaEntity
function CompoundEntity:place(placement)
  local surface = placement.surface

  local create_options = {
    name = self._definition.main_entity_name,
    position = common.copy_position(placement.position),
    force = placement.force
  }

  if placement.direction ~= nil then
    create_options.direction = placement.direction
  end

  if placement.quality ~= nil then
    create_options.quality = placement.quality
  end

  if placement.create_build_effect_smoke ~= nil then
    create_options.create_build_effect_smoke = placement.create_build_effect_smoke
  end

  local main_entity = surface.create_entity(create_options)
  if main_entity == nil then
    error(
      "Unable to create main entity '"
        .. self._definition.main_entity_name
        .. "' for compound '"
        .. self._definition.id
        .. "'."
    )
  end

  self:sync(main_entity)
  return main_entity
end

---@param main_entity LuaEntity
---@param position MapPosition
---@param direction? WarpageDirection
---@return LuaEntity[]
function CompoundEntity:reposition(main_entity, position, direction)
  main_entity = self:_assert_main_entity(main_entity)
  common.ensure_position(position, "position")

  if direction ~= nil then
    common.ensure_direction(direction, "direction")
  end

  self:cleanup(main_entity)

  if direction ~= nil and main_entity.direction ~= direction then
    main_entity.direction = direction
  end

  local target_position = common.copy_position(position)
  local teleported = main_entity.teleport(target_position)
  if teleported ~= true then
    error(
      "Unable to teleport main entity '"
        .. self._definition.main_entity_name
        .. "' for compound '"
        .. self._definition.id
        .. "'."
    )
  end

  return self:sync(main_entity)
end

function CompoundEntity:_sync_existing_main_entities()
  for _, surface in pairs(game.surfaces) do
    local main_entities = surface.find_entities_filtered({
      name = self._definition.main_entity_name
    })

    for _, main_entity in ipairs(main_entities) do
      if self:is_main_entity(main_entity) then
        self:sync(main_entity)
      end
    end
  end
end

---@param entity LuaEntity|nil
function CompoundEntity:_handle_created_entity(entity)
  if entity == nil or not entity.valid then
    return
  end

  if self:is_main_entity(entity) then
    self:sync(entity)
  end
end

---@param entity LuaEntity|nil
function CompoundEntity:_handle_destroyed_entity(entity)
  if entity == nil or not entity.valid then
    return
  end

  if self:is_main_entity(entity) then
    self:cleanup(entity)
  end
end

---@param events WarpageScopedBinding
function CompoundEntity:bind(events)
  if self._bound then
    error("CompoundEntity '" .. self._definition.id .. "' is already bound.")
  end

  local event_handlers = {} ---@type table<WarpageEventId, fun(event: table)>

  event_handlers[common.required_event_id("on_built_entity")] = function(event)
    self:_handle_created_entity(event.entity)
  end

  event_handlers[common.required_event_id("on_robot_built_entity")] = function(event)
    self:_handle_created_entity(event.entity)
  end

  event_handlers[common.required_event_id("script_raised_built")] = function(event)
    self:_handle_created_entity(event.entity)
  end

  event_handlers[common.required_event_id("script_raised_revive")] = function(event)
    self:_handle_created_entity(event.entity)
  end

  local on_entity_cloned = common.optional_event_id("on_entity_cloned")
  if on_entity_cloned ~= nil then
    event_handlers[on_entity_cloned] = function(event)
      self:_handle_created_entity(event.destination)
    end
  end

  event_handlers[common.required_event_id("on_pre_player_mined_item")] = function(event)
    self:_handle_destroyed_entity(event.entity)
  end

  event_handlers[common.required_event_id("on_robot_pre_mined")] = function(event)
    self:_handle_destroyed_entity(event.entity)
  end

  event_handlers[common.required_event_id("on_entity_died")] = function(event)
    self:_handle_destroyed_entity(event.entity)
  end

  event_handlers[common.required_event_id("script_raised_destroy")] = function(event)
    self:_handle_destroyed_entity(event.entity)
  end

  events:bind({
    on_init = function()
      self:_sync_existing_main_entities()
    end,
    on_configuration_changed = function()
      self:_sync_existing_main_entities()
    end,
    events = event_handlers
  })

  self._bound = true
end

return CompoundEntity
