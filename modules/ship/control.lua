local common = require("core.utils.common")
local CompoundEntity = require("core.utils.compound_entity")
local StorageSchema = require("core.storage_schema")
local ShipConstants = require("modules.ship.constants")

local PLAYER_FORCE_NAME = ShipConstants.player_force_name
local HUB_SURFACE_NAME = ShipConstants.hub_surface_name
local HUB_MAIN_ENTITY_NAME = ShipConstants.hub_main_entity_name
local HUB_ACCUMULATOR_ENTITY_NAME = ShipConstants.hub_accumulator_entity_name
local HUB_POWER_POLE_ENTITY_NAME = ShipConstants.hub_power_pole_entity_name
local HUB_FLUID_PIPE_ENTITY_NAME = ShipConstants.hub_fluid_pipe_entity_name
local HUB_DESTROYED_CONTAINER_ENTITY_NAME = ShipConstants.hub_destroyed_container_entity_name
local HUB_DESTROYED_RUBBLE_ENTITY_NAME = ShipConstants.hub_destroyed_rubble_entity_name
local HUB_POSITION = { x = 0, y = 0 }
local HUB_DIRECTION = defines.direction.north
local HUB_CLEAR_RADIUS = 4
local HUB_PIPE_LEFT_OFFSET = { x = -2.5, y = 3.5 }
local HUB_PIPE_RIGHT_OFFSET = { x = 3.5, y = 3.5 }
local HUB_UI_ROOT_NAME = ShipConstants.hub_ui_root_name

local HUB_UI_UPDATE_INTERVAL = 30
local HUB_REPAIR_TEXT_LIFETIME = 2147483647
local HUB_DESTROYED_CONTAINER_SLOT_COUNT = 48

---@class WarpageShipRepairRequirement
---@field item_name string
---@field amount integer
---@field slots integer

---@type WarpageShipRepairRequirement[]
local HUB_REPAIR_REQUIREMENTS = {
  { item_name = "stone", amount = 200, slots = 4 },
  { item_name = "coal", amount = 200, slots = 4 },
  { item_name = "copper-ore", amount = 100, slots = 2 },
  { item_name = "iron-plate", amount = 100, slots = 1 },
  { item_name = "calcite", amount = 10, slots = 1 }
}

local open_hubs_by_player = {} ---@type table<integer, LuaEntity>
local hub_repair_status_text_cleanup = nil ---@type WarpageCleanupFn|nil
local hub_repair_status_text_value = nil ---@type string|nil

local function destroy_hub_repair_status_text()
  if hub_repair_status_text_cleanup ~= nil then
    hub_repair_status_text_cleanup()
    hub_repair_status_text_cleanup = nil
  end

  hub_repair_status_text_value = nil
end

---@param entity LuaEntity
local function lock_hub_entity(entity)
  entity.destructible = false
  entity.minable = false
end

---@param entity LuaEntity
---@param _main_entity LuaEntity
local function lock_hub_part(entity, _main_entity)
  entity.destructible = false
  entity.minable = false
end

---@param entity LuaEntity
local function lock_destroyed_hub_container(entity)
  entity.destructible = false
  entity.minable = false
end

---@param entity LuaEntity
local function configure_destroyed_hub_rubble(entity)
  if entity.type ~= "corpse" then
    error("Destroyed hub rubble must be a corpse entity.")
  end

  entity.corpse_expires = false
  entity.corpse_immune_to_entity_placement = true
end

---@param main_entity LuaEntity
---@param offset MapPosition
---@return MapPosition
local function offset_from_main(main_entity, offset)
  local rotated = common.rotate_offset(offset, main_entity.direction)
  return {
    x = main_entity.position.x + rotated.x,
    y = main_entity.position.y + rotated.y
  }
end

---@param main_entity LuaEntity
---@param entity_name string
---@param offset MapPosition
---@return LuaEntity
local function find_hub_part(main_entity, entity_name, offset)
  local expected_position = offset_from_main(main_entity, offset)
  local candidates = main_entity.surface.find_entities_filtered({
    name = entity_name,
    position = expected_position,
    force = main_entity.force
  })

  for _, candidate in ipairs(candidates) do
    if candidate.valid and common.positions_match(candidate.position, expected_position) then
      return candidate
    end
  end

  error(
    "Hub part '"
      .. entity_name
      .. "' is missing at {x="
      .. tostring(expected_position.x)
      .. ", y="
      .. tostring(expected_position.y)
      .. "}."
  )
end

---@param source LuaEntity
---@param target LuaEntity
---@param wire_connector_id integer
local function connect_wire(source, target, wire_connector_id)
  local source_connector = source.get_wire_connector(wire_connector_id, true)
  if source_connector == nil or source_connector.valid ~= true then
    error("Source entity '" .. source.name .. "' is missing wire connector " .. tostring(wire_connector_id) .. ".")
  end

  local target_connector = target.get_wire_connector(wire_connector_id, true)
  if target_connector == nil or target_connector.valid ~= true then
    error("Target entity '" .. target.name .. "' is missing wire connector " .. tostring(wire_connector_id) .. ".")
  end

  if source_connector.is_connected_to(target_connector, defines.wire_origin.script) then
    return
  end

  source_connector.connect_to(target_connector, false, defines.wire_origin.script)
end

---@param entity LuaEntity
---@param main_entity LuaEntity
---@param created boolean
local function prepare_hub_accumulator(entity, main_entity, created)
  lock_hub_part(entity, main_entity)
  if not created then
    return
  end

  local capacity = entity.electric_buffer_size
  if type(capacity) ~= "number" then
    error("Hub accumulator must expose numeric electric_buffer_size.")
  end

  entity.energy = capacity
end

---@param entity LuaEntity
---@param main_entity LuaEntity
local function prepare_hub_fluid_pipe(entity, main_entity)
  lock_hub_part(entity, main_entity)
  local hub_power_pole = find_hub_part(main_entity, HUB_POWER_POLE_ENTITY_NAME, { x = 0, y = 0 })
  connect_wire(entity, hub_power_pole, defines.wire_connector_id.circuit_green)
end

local hub_part_definitions = {
  {
    id = "hub-accumulator",
    entity_name = HUB_ACCUMULATOR_ENTITY_NAME,
    offset = { x = 0, y = 0 },
    direction = defines.direction.north,
    direction_relative = false,
    create_build_effect_smoke = false,
    on_ready = prepare_hub_accumulator
  },
  {
    id = "hub-power-pole",
    entity_name = HUB_POWER_POLE_ENTITY_NAME,
    offset = { x = 0, y = 0 },
    direction = defines.direction.north,
    direction_relative = false,
    create_build_effect_smoke = false,
    on_ready = lock_hub_part
  },
  {
    id = "hub-fluid-pipe-bottom-left",
    entity_name = HUB_FLUID_PIPE_ENTITY_NAME,
    offset = HUB_PIPE_LEFT_OFFSET,
    direction = defines.direction.north,
    direction_relative = false,
    create_build_effect_smoke = false,
    on_ready = prepare_hub_fluid_pipe
  },
  {
    id = "hub-fluid-pipe-bottom-right",
    entity_name = HUB_FLUID_PIPE_ENTITY_NAME,
    offset = HUB_PIPE_RIGHT_OFFSET,
    direction = defines.direction.north,
    direction_relative = false,
    create_build_effect_smoke = false,
    on_ready = prepare_hub_fluid_pipe
  }
}

local hub_compound = CompoundEntity.new({
  id = "ship_hub",
  main_entity_name = HUB_MAIN_ENTITY_NAME,
  parts = hub_part_definitions,
  matches_main_entity = function(entity)
    return entity.force.name == PLAYER_FORCE_NAME and common.positions_match(entity.position, HUB_POSITION)
  end,
  on_main_entity_ready = lock_hub_entity
})

---@class Ship
---@field bind fun(events: WarpageScopedBinding)
local Ship = {}

---@return LuaGameScript
local function require_game()
  if game == nil then
    error("Ship module requires runtime game context.")
  end

  return game
end

---@return LuaForce
local function resolve_player_force()
  local runtime_game = require_game()
  local force = runtime_game.forces[PLAYER_FORCE_NAME]
  if force == nil then
    error("Ship hub requires force '" .. PLAYER_FORCE_NAME .. "'.")
  end

  return force
end

---@return LuaSurface
local function resolve_hub_surface()
  local runtime_game = require_game()

  local surface = runtime_game.surfaces[HUB_SURFACE_NAME]
  if surface == nil then
    error("Ship hub requires surface '" .. HUB_SURFACE_NAME .. "'.")
  end

  return surface
end

---@param player_index integer
---@return LuaPlayer
local function resolve_player(player_index)
  local runtime_game = require_game()
  local player = runtime_game.get_player(player_index)
  if player == nil or player.valid ~= true then
    error("Unable to resolve player '" .. tostring(player_index) .. "'.")
  end

  return player
end

---@param surface LuaSurface
---@param force LuaForce
---@return LuaEntity|nil
local function find_existing_hub(surface, force)
  local candidates = surface.find_entities_filtered({
    name = HUB_MAIN_ENTITY_NAME,
    position = HUB_POSITION,
    force = force
  })

  local matched = {} ---@type LuaEntity[]
  for _, entity in ipairs(candidates) do
    if hub_compound:is_main_entity(entity) then
      matched[#matched + 1] = entity
    end
  end

  if #matched > 1 then
    error("Expected at most one hub main entity at the hub origin, got " .. tostring(#matched) .. ".")
  end

  return matched[1]
end

---@param surface LuaSurface
---@return LuaEntity|nil
local function find_destroyed_hub_container(surface)
  local area = {
    { HUB_POSITION.x - 1, HUB_POSITION.y - 1 },
    { HUB_POSITION.x + 1, HUB_POSITION.y + 1 }
  }
  local candidates = surface.find_entities_filtered({
    name = HUB_DESTROYED_CONTAINER_ENTITY_NAME,
    area = area
  })

  local matched = {} ---@type LuaEntity[]
  for _, entity in ipairs(candidates) do
    if entity.valid then
      matched[#matched + 1] = entity
    end
  end

  if #matched > 1 then
    error("Expected at most one destroyed hub container at the hub origin, got " .. tostring(#matched) .. ".")
  end

  return matched[1]
end

---@param surface LuaSurface
---@return LuaEntity|nil
local function find_destroyed_hub_rubble(surface)
  local area = {
    { HUB_POSITION.x - 1, HUB_POSITION.y - 1 },
    { HUB_POSITION.x + 1, HUB_POSITION.y + 1 }
  }
  local candidates = surface.find_entities_filtered({
    name = HUB_DESTROYED_RUBBLE_ENTITY_NAME,
    area = area
  })

  local matched = {} ---@type LuaEntity[]
  for _, entity in ipairs(candidates) do
    if entity.valid then
      matched[#matched + 1] = entity
    end
  end

  if #matched > 1 then
    error("Expected at most one destroyed hub rubble entity at the hub origin, got " .. tostring(#matched) .. ".")
  end

  return matched[1]
end

---@param surface LuaSurface
---@param center MapPosition
local function clear_hub_placement_area(surface, center)
  local area = {
    { center.x - HUB_CLEAR_RADIUS, center.y - HUB_CLEAR_RADIUS },
    { center.x + HUB_CLEAR_RADIUS, center.y + HUB_CLEAR_RADIUS }
  }

  local entities = surface.find_entities_filtered({ area = area })
  for _, entity in ipairs(entities) do
    if entity.valid then
      local destroyed = entity.destroy()
      if destroyed ~= true and entity.valid then
        error(
          "Unable to clear entity '"
            .. entity.name
            .. "' at {x="
            .. tostring(entity.position.x)
            .. ", y="
            .. tostring(entity.position.y)
            .. "} before hub placement."
        )
      end
    end
  end
end

---@param surface LuaSurface
---@param force LuaForce
---@return LuaEntity
local function place_hub(surface, force)
  clear_hub_placement_area(surface, HUB_POSITION)

  return hub_compound:place({
    surface = surface,
    position = HUB_POSITION,
    force = force,
    direction = HUB_DIRECTION,
    create_build_effect_smoke = false
  })
end

---@param destroyed_hub_container LuaEntity
---@return LuaInventory
local function require_destroyed_hub_inventory(destroyed_hub_container)
  local inventory = destroyed_hub_container.get_inventory(defines.inventory.chest)
  if inventory == nil then
    error("Destroyed hub container must expose a chest inventory.")
  end

  if inventory.supports_filters() ~= true then
    error("Destroyed hub container inventory must support filters.")
  end

  if inventory.supports_bar() ~= true then
    error("Destroyed hub container inventory must support bar limits.")
  end

  return inventory
end

---@return integer
local function compute_required_repair_slots()
  local total_slots = 0

  for _, requirement in ipairs(HUB_REPAIR_REQUIREMENTS) do
    if type(requirement.slots) ~= "number" or requirement.slots % 1 ~= 0 or requirement.slots < 1 then
      error("Hub repair requirement '" .. requirement.item_name .. "' must define a positive integer slot count.")
    end

    total_slots = total_slots + requirement.slots
  end

  return total_slots + 1
end

---@param destroyed_hub_container LuaEntity
local function configure_destroyed_hub_container(destroyed_hub_container)
  local inventory = require_destroyed_hub_inventory(destroyed_hub_container)
  local required_slots = compute_required_repair_slots()

  if required_slots > HUB_DESTROYED_CONTAINER_SLOT_COUNT then
    error(
      "Hub repair slot requirements exceed destroyed hub inventory size: required="
        .. tostring(required_slots)
        .. ", size="
        .. tostring(HUB_DESTROYED_CONTAINER_SLOT_COUNT)
        .. "."
    )
  end

  for slot_index = 1, HUB_DESTROYED_CONTAINER_SLOT_COUNT do
    local cleared = inventory.set_filter(slot_index, nil)
    if cleared ~= true then
      error("Failed to clear destroyed hub inventory filter slot " .. tostring(slot_index) .. ".")
    end
  end

  inventory.set_bar(required_slots)

  local slot_index = 1
  for _, requirement in ipairs(HUB_REPAIR_REQUIREMENTS) do
    if type(requirement.slots) ~= "number" or requirement.slots % 1 ~= 0 or requirement.slots < 1 then
      error("Hub repair requirement '" .. requirement.item_name .. "' must define a positive integer slot count.")
    end

    for _ = 1, requirement.slots do
      local set = inventory.set_filter(slot_index, requirement.item_name)
      if set ~= true then
        error(
          "Failed to set destroyed hub inventory filter slot "
            .. tostring(slot_index)
            .. " to item '"
            .. requirement.item_name
            .. "'."
        )
      end
      slot_index = slot_index + 1
    end
  end
end

---@param surface LuaSurface
---@param force LuaForce
---@return LuaEntity, LuaEntity
local function create_destroyed_hub(surface, force)
  clear_hub_placement_area(surface, HUB_POSITION)

  local destroyed_hub_container = surface.create_entity({
    name = HUB_DESTROYED_CONTAINER_ENTITY_NAME,
    position = HUB_POSITION,
    force = force,
    create_build_effect_smoke = false
  })
  if destroyed_hub_container == nil then
    error("Unable to create destroyed hub container at the hub origin.")
  end

  local destroyed_hub_rubble = surface.create_entity({
    name = HUB_DESTROYED_RUBBLE_ENTITY_NAME,
    position = HUB_POSITION
  })
  if destroyed_hub_rubble == nil then
    error("Unable to create destroyed hub rubble at the hub origin.")
  end

  lock_destroyed_hub_container(destroyed_hub_container)
  configure_destroyed_hub_rubble(destroyed_hub_rubble)
  configure_destroyed_hub_container(destroyed_hub_container)

  return destroyed_hub_container, destroyed_hub_rubble
end

---@class WarpageShipRepairStatus
---@field item_name string
---@field required integer
---@field current integer
---@field remaining integer

---@param destroyed_hub_container LuaEntity
---@return boolean, WarpageShipRepairStatus[]
local function collect_hub_repair_status(destroyed_hub_container)
  local inventory = require_destroyed_hub_inventory(destroyed_hub_container)
  local repair_complete = true
  local status = {} ---@type WarpageShipRepairStatus[]

  for _, requirement in ipairs(HUB_REPAIR_REQUIREMENTS) do
    local current = inventory.get_item_count(requirement.item_name)
    if type(current) ~= "number" then
      error("Destroyed hub inventory count for '" .. requirement.item_name .. "' must be numeric.")
    end

    local remaining = requirement.amount - current
    if remaining < 0 then
      remaining = 0
    end

    if remaining > 0 then
      repair_complete = false
    end

    status[#status + 1] = {
      item_name = requirement.item_name,
      required = requirement.amount,
      current = current,
      remaining = remaining
    }
  end

  return repair_complete, status
end

---@param destroyed_hub_container LuaEntity
---@param repair_status WarpageShipRepairStatus[]
local function draw_destroyed_hub_repair_status(destroyed_hub_container, repair_status)
  local lines = {} ---@type string[]

  for _, entry in ipairs(repair_status) do
    if entry.remaining > 0 then
      lines[#lines + 1] = "[item=" .. entry.item_name .. "] " .. tostring(entry.remaining)
    end
  end

  if #lines == 0 then
    destroy_hub_repair_status_text()
    return
  end

  local text = table.concat(lines, " ")
  if hub_repair_status_text_cleanup ~= nil and hub_repair_status_text_value == text then
    return
  end

  destroy_hub_repair_status_text()
  hub_repair_status_text_cleanup = common.create_holographic_text({
    text = text,
    surface = destroyed_hub_container.surface,
    target = destroyed_hub_container,
    target_offset = { x = 0, y = -4.5 },
    time_to_live = HUB_REPAIR_TEXT_LIFETIME
  })
  hub_repair_status_text_value = text
end

---@param entity LuaEntity
---@param description string
local function destroy_entity_or_fail(entity, description)
  if entity.valid ~= true then
    return
  end

  local destroyed = entity.destroy()
  if destroyed ~= true and entity.valid then
    error("Unable to destroy " .. description .. " at the hub origin.")
  end
end

---@param destroyed_hub_container LuaEntity
local function consume_hub_repair_items(destroyed_hub_container)
  local inventory = require_destroyed_hub_inventory(destroyed_hub_container)
  for _, requirement in ipairs(HUB_REPAIR_REQUIREMENTS) do
    local removed = inventory.remove({
      name = requirement.item_name,
      count = requirement.amount
    })
    if removed ~= requirement.amount then
      error(
        "Failed to consume hub repair item '"
          .. requirement.item_name
          .. "': expected "
          .. tostring(requirement.amount)
          .. ", removed "
          .. tostring(removed)
          .. "."
      )
    end
  end
end

---@return LuaSurface, LuaForce, LuaEntity|nil, LuaEntity|nil, LuaEntity|nil
local function ensure_hub_lifecycle_entities()
  local surface = resolve_hub_surface()
  local force = resolve_player_force()
  local existing_hub = find_existing_hub(surface, force)

  local destroyed_hub_container = find_destroyed_hub_container(surface)
  local destroyed_hub_rubble = find_destroyed_hub_rubble(surface)

  if existing_hub ~= nil then
    if destroyed_hub_container ~= nil or destroyed_hub_rubble ~= nil then
      error("Hub main entity and destroyed hub entities cannot coexist at the hub origin.")
    end

    hub_compound:sync(existing_hub)
    return surface, force, existing_hub, nil, nil
  end

  if destroyed_hub_container == nil and destroyed_hub_rubble == nil then
    destroyed_hub_container, destroyed_hub_rubble = create_destroyed_hub(surface, force)
  elseif destroyed_hub_container == nil or destroyed_hub_rubble == nil then
    error("Destroyed hub state is invalid: container and rubble must either both exist or both be absent.")
  end

  lock_destroyed_hub_container(destroyed_hub_container)
  configure_destroyed_hub_rubble(destroyed_hub_rubble)
  configure_destroyed_hub_container(destroyed_hub_container)
  return surface, force, nil, destroyed_hub_container, destroyed_hub_rubble
end

---@return LuaEntity|nil
local function update_hub_lifecycle()
  local surface, force, hub, destroyed_hub_container, destroyed_hub_rubble = ensure_hub_lifecycle_entities()
  if hub ~= nil then
    destroy_hub_repair_status_text()
    return hub
  end

  if destroyed_hub_container == nil or destroyed_hub_rubble == nil then
    error("Destroyed hub lifecycle update requires both container and rubble entities.")
  end

  local repair_complete, repair_status = collect_hub_repair_status(destroyed_hub_container)
  draw_destroyed_hub_repair_status(destroyed_hub_container, repair_status)
  if not repair_complete then
    return nil
  end

  destroy_hub_repair_status_text()
  consume_hub_repair_items(destroyed_hub_container)
  destroy_entity_or_fail(destroyed_hub_rubble, "destroyed hub rubble")
  destroy_entity_or_fail(destroyed_hub_container, "destroyed hub container")
  return place_hub(surface, force)
end

---@param player LuaPlayer
local function destroy_hub_ui(player)
  local relative_root = player.gui.relative[HUB_UI_ROOT_NAME]
  if relative_root ~= nil then
    relative_root.destroy()
  end

  local screen_root = player.gui.screen[HUB_UI_ROOT_NAME]
  if screen_root ~= nil then
    screen_root.destroy()
  end
end

---@param player LuaPlayer
---@return LuaGuiElement
local function ensure_hub_ui(player)
  local root = player.gui.relative[HUB_UI_ROOT_NAME]
  if root ~= nil then
    return root
  end

  root = player.gui.relative.add({
    type = "frame",
    name = HUB_UI_ROOT_NAME,
    direction = "vertical",
    caption = "Hub",
    anchor = {
      gui = defines.relative_gui_type.cargo_landing_pad_gui,
      position = defines.relative_gui_position.right
    }
  })

  root.style.width = 320

  root.add({
    type = "label",
    name = ShipConstants.hub_ui_power_label_name,
    caption = ""
  })

  local power_bar = root.add({
    type = "progressbar",
    name = ShipConstants.hub_ui_power_bar_name,
    value = 0
  })
  power_bar.style.horizontally_stretchable = true

  local fluid_table = root.add({
    type = "table",
    name = ShipConstants.hub_ui_fluid_table_name,
    column_count = 4
  })
  fluid_table.style.horizontal_spacing = 6

  return root
end

---@param entity LuaEntity
---@return string|nil, number
local function extract_fluid(entity)
  local fluid_name, amount = next(entity.get_fluid_contents())
  if fluid_name == nil or type(amount) ~= "number" then
    return nil, 0
  end

  return fluid_name, amount
end

---@param value number
---@return string
local function format_compact_int(value)
  local rounded = math.floor(value + 0.5)
  local sign = ""
  if rounded < 0 then
    sign = "-"
    rounded = -rounded
  end

  if rounded >= 1000000 then
    return sign .. tostring(math.floor(rounded / 1000000)) .. "M"
  end

  if rounded >= 1000 then
    return sign .. tostring(math.floor(rounded / 1000)) .. "k"
  end

  return sign .. tostring(rounded)
end

---@param fluid_name string
---@return Color
local function resolve_fluid_bar_color(fluid_name)
  local fluid_prototype = prototypes.fluid[fluid_name]
  if fluid_prototype == nil then
    error("Hub UI could not resolve fluid prototype '" .. fluid_name .. "'.")
  end

  local base_color = fluid_prototype.base_color
  local red = base_color.r
  local green = base_color.g
  local blue = base_color.b
  if type(red) ~= "number" or type(green) ~= "number" or type(blue) ~= "number" then
    error("Hub fluid '" .. fluid_name .. "' must expose numeric base_color.")
  end

  return { r = red, g = green, b = blue }
end

---@param fluid_table LuaGuiElement
---@param direction_icon string
---@param fluid_pipe LuaEntity
local function add_fluid_row(fluid_table, direction_icon, fluid_pipe)
  local fluid_name, amount = extract_fluid(fluid_pipe)
  local capacity = fluid_pipe.fluidbox.get_capacity(1)
  if type(capacity) ~= "number" then
    error("Hub fluid pipe must expose a numeric fluid capacity.")
  end

  local direction_cell = fluid_table.add({
    type = "label",
    caption = direction_icon
  })
  direction_cell.style.minimal_width = 22
  direction_cell.style.maximal_width = 22
  direction_cell.style.horizontal_align = "center"

  local amount_ratio = 0
  if capacity > 0 then
    amount_ratio = amount / capacity
    if amount_ratio < 0 then
      amount_ratio = 0
    elseif amount_ratio > 1 then
      amount_ratio = 1
    end
  end

  local fluid_icon = ShipConstants.hub_ui_fluid_empty_icon
  local bar_color = { r = 0.35, g = 0.35, b = 0.35 }
  if fluid_name ~= nil then
    fluid_icon = "[fluid=" .. fluid_name .. "]"
    bar_color = resolve_fluid_bar_color(fluid_name)
  end

  local fluid_icon_cell = fluid_table.add({
    type = "label",
    caption = fluid_icon
  })
  fluid_icon_cell.style.minimal_width = 22
  fluid_icon_cell.style.maximal_width = 22
  fluid_icon_cell.style.horizontal_align = "center"

  local fluid_bar = fluid_table.add({
    type = "progressbar",
    value = amount_ratio
  })
  fluid_bar.style.minimal_width = 140
  fluid_bar.style.maximal_width = 140
  fluid_bar.style.color = bar_color

  local totals_cell = fluid_table.add({
    type = "label",
    caption = format_compact_int(amount) .. " / " .. format_compact_int(capacity)
  })
  totals_cell.style.minimal_width = 88
  totals_cell.style.maximal_width = 88
  totals_cell.style.horizontal_align = "right"
  totals_cell.style.font = "default-mono"
end

---@param player LuaPlayer
---@param hub_entity LuaEntity
local function update_hub_ui(player, hub_entity)
  hub_compound:sync(hub_entity)
  local root = ensure_hub_ui(player)

  local accumulator = find_hub_part(hub_entity, HUB_ACCUMULATOR_ENTITY_NAME, { x = 0, y = 0 })
  local left_pipe = find_hub_part(hub_entity, HUB_FLUID_PIPE_ENTITY_NAME, HUB_PIPE_LEFT_OFFSET)
  local right_pipe = find_hub_part(hub_entity, HUB_FLUID_PIPE_ENTITY_NAME, HUB_PIPE_RIGHT_OFFSET)

  local energy = accumulator.energy
  local capacity = accumulator.electric_buffer_size
  if type(energy) ~= "number" or type(capacity) ~= "number" then
    error("Hub accumulator must expose numeric energy fields.")
  end

  local power_label = root[ShipConstants.hub_ui_power_label_name]
  if power_label == nil then
    error("Hub UI is missing power label.")
  end

  power_label.caption = "Accumulator: " .. string.format("%.1fMJ / %.1fMJ", energy / 1000000, capacity / 1000000)

  local power_bar = root[ShipConstants.hub_ui_power_bar_name]
  if power_bar == nil then
    error("Hub UI is missing power bar.")
  end

  if capacity <= 0 then
    power_bar.value = 0
  else
    local ratio = energy / capacity
    if ratio < 0 then
      ratio = 0
    elseif ratio > 1 then
      ratio = 1
    end
    power_bar.value = ratio
  end

  local fluid_table = root[ShipConstants.hub_ui_fluid_table_name]
  if fluid_table == nil then
    error("Hub UI is missing fluid table.")
  end

  fluid_table.clear()
  add_fluid_row(fluid_table, ShipConstants.hub_ui_fluid_left_icon, left_pipe)
  add_fluid_row(fluid_table, ShipConstants.hub_ui_fluid_right_icon, right_pipe)
end

local function reset_open_hub_state()
  open_hubs_by_player = {}
end

local function clear_open_hub_state_for_players()
  local runtime_game = require_game()
  for _, player in pairs(runtime_game.players) do
    destroy_hub_ui(player)
  end
  destroy_hub_repair_status_text()
  reset_open_hub_state()
end

local function update_open_hub_uis()
  for player_index, hub_entity in pairs(open_hubs_by_player) do
    local player = resolve_player(player_index)
    if hub_entity.valid ~= true or not hub_compound:is_main_entity(hub_entity) then
      open_hubs_by_player[player_index] = nil
      destroy_hub_ui(player)
    else
      update_hub_ui(player, hub_entity)
    end
  end
end

---@param event table
local function handle_gui_opened(event)
  local player = resolve_player(event.player_index)
  local opened_entity = event.entity
  if not hub_compound:is_main_entity(opened_entity) then
    open_hubs_by_player[player.index] = nil
    destroy_hub_ui(player)
    return
  end

  hub_compound:sync(opened_entity)
  open_hubs_by_player[player.index] = opened_entity
  update_hub_ui(player, opened_entity)
end

---@param event table
local function handle_gui_closed(event)
  local player = resolve_player(event.player_index)
  open_hubs_by_player[player.index] = nil
  destroy_hub_ui(player)
end

---@param events WarpageScopedBinding
function Ship.bind(events)
  common.ensure_table(events, "events")
  if type(events.bind) ~= "function" then
    error("events must define bind(registration).")
  end

  hub_compound:bind(events)

  local event_handlers = {} ---@type table<WarpageEventId, fun(event: table)>

  event_handlers[common.required_event_id("on_gui_opened")] = handle_gui_opened
  event_handlers[common.required_event_id("on_gui_closed")] = handle_gui_closed

  events:bind({
    on_init = function()
      clear_open_hub_state_for_players()
      update_hub_lifecycle()
    end,
    on_load = function()
      destroy_hub_repair_status_text()
      reset_open_hub_state()
    end,
    on_configuration_changed = function()
      clear_open_hub_state_for_players()
      update_hub_lifecycle()
    end,
    events = event_handlers,
    nth_tick = {
      [HUB_UI_UPDATE_INTERVAL] = function()
        update_hub_lifecycle()
        update_open_hub_uis()
      end
    }
  })
end

---@return boolean
local function is_ship_tests_enabled()
  local setting = settings.global[ShipConstants.ship_tests_setting_name]
  if setting == nil then
    error("Missing runtime-global setting '" .. ShipConstants.ship_tests_setting_name .. "'.")
  end

  if type(setting.value) ~= "boolean" then
    error("Runtime-global setting '" .. ShipConstants.ship_tests_setting_name .. "' must be a boolean.")
  end

  return setting.value == true
end

local function ensure_storage_schema()
  StorageSchema.ensure()
end

local function assert_storage_schema()
  StorageSchema.assert_ready()
end

---@param context WarpageFeatureContext
---@type WarpageStageRunner
return function(context)
  local events = context.events
  if events == nil then
    error(context.feature_id .. " requires context.events.")
  end

  events:bind({
    on_init = ensure_storage_schema,
    on_configuration_changed = ensure_storage_schema,
    on_load = assert_storage_schema
  })

  if is_ship_tests_enabled() then
    local ShipTests = require("tests.ship_tests")
    ShipTests.bind(events)
  end

  Ship.bind(events)
end
