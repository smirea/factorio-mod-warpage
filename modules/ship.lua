local common = require("core.utils.common")
local CompoundEntity = require("core.utils.compound_entity")

local PLAYER_FORCE_NAME = "player"
local HUB_SURFACE_NAME = "nauvis"
local HUB_MAIN_ENTITY_NAME = "cargo-landing-pad"
local HUB_ACCUMULATOR_ENTITY_NAME = "warpage-hub-accumulator"
local HUB_POWER_POLE_ENTITY_NAME = "warpage-hub-power-pole"
local HUB_FLUID_PIPE_ENTITY_NAME = "warpage-hub-fluid-pipe"
local HUB_POSITION = { x = 0, y = 0 }
local HUB_DIRECTION = defines.direction.north
local HUB_CLEAR_RADIUS = 4
local HUB_PIPE_LEFT_OFFSET = { x = -2.5, y = 3.5 }
local HUB_PIPE_RIGHT_OFFSET = { x = 3.5, y = 3.5 }
local HUB_UI_ROOT_NAME = "warpage_hub_ui"
local HUB_UI_POWER_LABEL_NAME = "warpage_hub_ui_power_label"
local HUB_UI_POWER_BAR_NAME = "warpage_hub_ui_power_bar"
local HUB_UI_FLUID_TABLE_NAME = "warpage_hub_ui_fluid_table"

local HUB_UI_UPDATE_INTERVAL = 30

local open_hubs_by_player = {} ---@type table<integer, LuaEntity>

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

  for _, entity in ipairs(candidates) do
    if hub_compound:is_main_entity(entity) then
      return entity
    end
  end

  return nil
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

---@return LuaEntity
local function ensure_initial_hub()
  local surface = resolve_hub_surface()
  local force = resolve_player_force()
  local existing_hub = find_existing_hub(surface, force)
  if existing_hub ~= nil then
    hub_compound:sync(existing_hub)
    return existing_hub
  end

  clear_hub_placement_area(surface, HUB_POSITION)

  return hub_compound:place({
    surface = surface,
    position = HUB_POSITION,
    force = force,
    direction = HUB_DIRECTION,
    create_build_effect_smoke = false
  })
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
    name = HUB_UI_POWER_LABEL_NAME,
    caption = ""
  })

  local power_bar = root.add({
    type = "progressbar",
    name = HUB_UI_POWER_BAR_NAME,
    value = 0
  })
  power_bar.style.horizontally_stretchable = true

  local fluid_table = root.add({
    type = "table",
    name = HUB_UI_FLUID_TABLE_NAME,
    column_count = 2
  })
  fluid_table.style.horizontal_spacing = 12

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

---@param fluid_table LuaGuiElement
---@param label string
---@param fluid_pipe LuaEntity
local function add_fluid_row(fluid_table, label, fluid_pipe)
  local fluid_name, amount = extract_fluid(fluid_pipe)
  local capacity = fluid_pipe.fluidbox.get_capacity(1)
  if type(capacity) ~= "number" then
    error("Hub fluid pipe must expose a numeric fluid capacity.")
  end

  fluid_table.add({
    type = "label",
    caption = label
  })

  if fluid_name == nil then
    fluid_table.add({
      type = "label",
      caption = "Empty (0 / " .. string.format("%.1f", capacity) .. ")"
    })
    return
  end

  fluid_table.add({
    type = "label",
    caption = "[fluid=" .. fluid_name .. "] " .. string.format("%.1f / %.1f", amount, capacity)
  })
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

  local power_label = root[HUB_UI_POWER_LABEL_NAME]
  if power_label == nil then
    error("Hub UI is missing power label.")
  end

  power_label.caption = "Accumulator: " .. string.format("%.1fMJ / %.1fMJ", energy / 1000000, capacity / 1000000)

  local power_bar = root[HUB_UI_POWER_BAR_NAME]
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

  local fluid_table = root[HUB_UI_FLUID_TABLE_NAME]
  if fluid_table == nil then
    error("Hub UI is missing fluid table.")
  end

  fluid_table.clear()
  add_fluid_row(fluid_table, "Bottom Left", left_pipe)
  add_fluid_row(fluid_table, "Bottom Right", right_pipe)
end

local function reset_open_hub_state()
  open_hubs_by_player = {}
end

local function clear_open_hub_state_for_players()
  local runtime_game = require_game()
  for _, player in pairs(runtime_game.players) do
    destroy_hub_ui(player)
  end
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
      ensure_initial_hub()
    end,
    on_load = function()
      reset_open_hub_state()
    end,
    on_configuration_changed = function()
      clear_open_hub_state_for_players()
      ensure_initial_hub()
    end,
    events = event_handlers,
    nth_tick = {
      [HUB_UI_UPDATE_INTERVAL] = function()
        update_open_hub_uis()
      end
    }
  })
end

return Ship
