local common = require("core.utils.common")
local StorageSchema = require("core.storage_schema")

local HUB_SURFACE_NAME = "nauvis"
local HUB_FORCE_NAME = "player"
local HUB_MAIN_ENTITY_NAME = "cargo-landing-pad"
local HUB_ACCUMULATOR_ENTITY_NAME = "warpage-hub-accumulator"
local HUB_POWER_POLE_ENTITY_NAME = "warpage-hub-power-pole"
local HUB_FLUID_PIPE_ENTITY_NAME = "warpage-hub-fluid-pipe"
local HUB_POSITION = { x = 0, y = 0 }
local HUB_PIPE_LEFT_OFFSET = { x = -2.5, y = 3.5 }
local HUB_PIPE_RIGHT_OFFSET = { x = 3.5, y = 3.5 }

local TEST_TILE_NAME = "stone-path"
local TEST_TILE_RADIUS = 32
local TEST_NTH_TICK = 1
local TEST_FEATURE_KEY = "ship_tests"

---@class WarpageShipTestsFeatureState
---@field enabled boolean
---@field completed boolean

---@class ShipTests
---@field bind fun(events: WarpageScopedBinding)
local ShipTests = {}

---@return LuaGameScript
local function require_game()
  if game == nil then
    error("Ship tests require runtime game context.")
  end

  return game
end

---@return LuaSurface
local function resolve_hub_surface()
  local runtime_game = require_game()
  local surface = runtime_game.surfaces[HUB_SURFACE_NAME]
  if surface == nil then
    error("Ship tests require surface '" .. HUB_SURFACE_NAME .. "'.")
  end

  return surface
end

---@return LuaForce
local function resolve_hub_force()
  local runtime_game = require_game()
  local force = runtime_game.forces[HUB_FORCE_NAME]
  if force == nil then
    error("Ship tests require force '" .. HUB_FORCE_NAME .. "'.")
  end

  return force
end

---@return boolean
local function is_test_environment()
  local runtime_game = require_game()
  local player_count = 0
  for _ in pairs(runtime_game.players) do
    player_count = player_count + 1
  end
  return player_count == 0
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

---@param surface LuaSurface
---@param position MapPosition
---@param radius number
local function clear_entities_in_area(surface, position, radius)
  local area = {
    { position.x - radius, position.y - radius },
    { position.x + radius, position.y + radius }
  }

  local entities = surface.find_entities_filtered({ area = area })
  for _, entity in ipairs(entities) do
    if entity.valid then
      local destroyed = entity.destroy()
      if destroyed ~= true and entity.valid then
        error(
          "Ship tests failed to destroy entity '"
            .. entity.name
            .. "' at {x="
            .. tostring(entity.position.x)
            .. ", y="
            .. tostring(entity.position.y)
            .. "}."
        )
      end
    end
  end
end

---@param surface LuaSurface
---@param center MapPosition
---@param radius integer
local function fill_test_tiles(surface, center, radius)
  local tiles = {} ---@type table[]
  for x = -radius, radius do
    for y = -radius, radius do
      tiles[#tiles + 1] = {
        name = TEST_TILE_NAME,
        position = { x = center.x + x, y = center.y + y }
      }
    end
  end

  surface.set_tiles(tiles)
end

---@return WarpageShipTestsFeatureState
local function ensure_test_state()
  local root = StorageSchema.ensure()
  local state = root.features[TEST_FEATURE_KEY]
  if state == nil then
    state = {
      enabled = true,
      completed = false
    }
    root.features[TEST_FEATURE_KEY] = state
    return state
  end

  if type(state) ~= "table" then
    error("storage.features." .. TEST_FEATURE_KEY .. " must be a table.")
  end

  if type(state.enabled) ~= "boolean" then
    error("storage.features." .. TEST_FEATURE_KEY .. ".enabled must be a boolean.")
  end

  if type(state.completed) ~= "boolean" then
    error("storage.features." .. TEST_FEATURE_KEY .. ".completed must be a boolean.")
  end

  return state
end

---@return WarpageShipTestsFeatureState|nil
local function assert_test_state()
  local root = StorageSchema.assert_ready()
  local state = root.features[TEST_FEATURE_KEY]
  if state == nil then
    return nil
  end

  if type(state) ~= "table" then
    error("storage.features." .. TEST_FEATURE_KEY .. " must be a table.")
  end

  if type(state.enabled) ~= "boolean" then
    error("storage.features." .. TEST_FEATURE_KEY .. ".enabled must be a boolean.")
  end

  if type(state.completed) ~= "boolean" then
    error("storage.features." .. TEST_FEATURE_KEY .. ".completed must be a boolean.")
  end

  return state
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

  local matched = {} ---@type LuaEntity[]
  for _, candidate in ipairs(candidates) do
    if candidate.valid and common.positions_match(candidate.position, expected_position) then
      matched[#matched + 1] = candidate
    end
  end

  if #matched ~= 1 then
    error(
      "Ship tests expected exactly one hub part '"
        .. entity_name
        .. "' at {x="
        .. tostring(expected_position.x)
        .. ", y="
        .. tostring(expected_position.y)
        .. "}, got "
        .. tostring(#matched)
        .. "."
    )
  end

  return matched[1]
end

---@param surface LuaSurface
---@param force LuaForce
---@return LuaEntity
local function find_main_hub(surface, force)
  local candidates = surface.find_entities_filtered({
    name = HUB_MAIN_ENTITY_NAME,
    position = HUB_POSITION,
    force = force
  })

  local matched = {} ---@type LuaEntity[]
  for _, candidate in ipairs(candidates) do
    if candidate.valid and common.positions_match(candidate.position, HUB_POSITION) then
      matched[#matched + 1] = candidate
    end
  end

  if #matched ~= 1 then
    error("Ship tests expected exactly one hub main entity, got " .. tostring(#matched) .. ".")
  end

  return matched[1]
end

---@param source LuaEntity
---@param target LuaEntity
---@param wire_connector_id integer
local function assert_wire_connection(source, target, wire_connector_id)
  local source_connector = source.get_wire_connector(wire_connector_id, true)
  if source_connector == nil or source_connector.valid ~= true then
    error("Ship tests could not resolve source connector on '" .. source.name .. "'.")
  end

  local target_connector = target.get_wire_connector(wire_connector_id, true)
  if target_connector == nil or target_connector.valid ~= true then
    error("Ship tests could not resolve target connector on '" .. target.name .. "'.")
  end

  if source_connector.is_connected_to(target_connector, defines.wire_origin.script) ~= true then
    error("Ship tests expected script wire connection between '" .. source.name .. "' and '" .. target.name .. "'.")
  end
end

---@param entity LuaEntity
---@param fluid_name string
---@param amount number
local function assert_pipe_accepts_fluid(entity, fluid_name, amount)
  local inserted = entity.insert_fluid({ name = fluid_name, amount = amount })
  if type(inserted) ~= "number" or inserted <= 0 then
    error("Ship tests could not insert fluid '" .. fluid_name .. "' into '" .. entity.name .. "'.")
  end

  local contents = entity.get_fluid_contents()
  local stored_amount = contents[fluid_name]
  if type(stored_amount) ~= "number" or stored_amount <= 0 then
    error("Ship tests expected '" .. entity.name .. "' to store fluid '" .. fluid_name .. "'.")
  end
end

local function prepare_test_environment()
  local surface = resolve_hub_surface()
  clear_entities_in_area(surface, HUB_POSITION, TEST_TILE_RADIUS)
  fill_test_tiles(surface, HUB_POSITION, TEST_TILE_RADIUS)
end

local function run_ship_hub_assertions()
  local surface = resolve_hub_surface()
  local force = resolve_hub_force()
  local hub = find_main_hub(surface, force)

  if hub.destructible ~= false then
    error("Ship tests expected hub to be non-destructible.")
  end

  if hub.minable ~= false then
    error("Ship tests expected hub to be non-minable.")
  end

  local accumulator = find_hub_part(hub, HUB_ACCUMULATOR_ENTITY_NAME, { x = 0, y = 0 })
  local power_pole = find_hub_part(hub, HUB_POWER_POLE_ENTITY_NAME, { x = 0, y = 0 })
  local left_pipe = find_hub_part(hub, HUB_FLUID_PIPE_ENTITY_NAME, HUB_PIPE_LEFT_OFFSET)
  local right_pipe = find_hub_part(hub, HUB_FLUID_PIPE_ENTITY_NAME, HUB_PIPE_RIGHT_OFFSET)

  local capacity = accumulator.electric_buffer_size
  local energy = accumulator.energy
  if type(capacity) ~= "number" or type(energy) ~= "number" then
    error("Ship tests expected accumulator energy fields to be numeric.")
  end

  if energy < capacity then
    error("Ship tests expected accumulator to start fully charged.")
  end

  assert_wire_connection(left_pipe, power_pole, defines.wire_connector_id.circuit_green)
  assert_wire_connection(right_pipe, power_pole, defines.wire_connector_id.circuit_green)
  assert_pipe_accepts_fluid(left_pipe, "water", 250)
  assert_pipe_accepts_fluid(right_pipe, "crude-oil", 250)
end

---@param events WarpageScopedBinding
function ShipTests.bind(events)
  common.ensure_table(events, "events")
  if type(events.bind) ~= "function" then
    error("events must define bind(registration).")
  end

  events:bind({
    on_init = function()
      if not is_test_environment() then
        return
      end

      local state = ensure_test_state()
      state.enabled = true
      state.completed = false
      prepare_test_environment()
    end,
    on_configuration_changed = function()
      if not is_test_environment() then
        return
      end

      local state = ensure_test_state()
      state.enabled = true
      state.completed = false
      prepare_test_environment()
    end,
    on_load = function()
      assert_test_state()
    end,
    nth_tick = {
      [TEST_NTH_TICK] = function()
        local state = assert_test_state()
        if state == nil or state.enabled ~= true or state.completed == true then
          return
        end

        run_ship_hub_assertions()
        state.completed = true
        log("[warpage] ship tests passed")
      end
    }
  })
end

return ShipTests
