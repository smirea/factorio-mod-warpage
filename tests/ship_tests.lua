local common = require("core.utils.common")
local StorageSchema = require("core.storage_schema")
local ShipConstants = require("modules.ship.constants")

local HUB_SURFACE_NAME = ShipConstants.hub_surface_name
local HUB_FORCE_NAME = ShipConstants.player_force_name
local HUB_MAIN_ENTITY_NAME = ShipConstants.hub_main_entity_name
local HUB_ACCUMULATOR_ENTITY_NAME = ShipConstants.hub_accumulator_entity_name
local HUB_ROBOPORT_ENTITY_NAME = ShipConstants.hub_roboport_entity_name
local HUB_POWER_POLE_ENTITY_NAME = ShipConstants.hub_power_pole_entity_name
local HUB_FLUID_PIPE_ENTITY_NAME = ShipConstants.hub_fluid_pipe_entity_name
local HUB_DESTROYED_CONTAINER_ENTITY_NAME = ShipConstants.hub_destroyed_container_entity_name
local HUB_DESTROYED_RUBBLE_ENTITY_NAME = ShipConstants.hub_destroyed_rubble_entity_name
local HUB_POSITION = { x = 0, y = 0 }
local HUB_PIPE_LEFT_OFFSET = { x = -2.5, y = 3.5 }
local HUB_PIPE_RIGHT_OFFSET = { x = 3.5, y = 3.5 }
local POSITION_EPSILON = 0.001

local TEST_TILE_NAME = "stone-path"
local TEST_TILE_RADIUS = 32
local TEST_NTH_TICK = 30
local TEST_FEATURE_KEY = "ship_tests"
local FREEPLAY_INTERFACE_NAME = "freeplay"

---@type string[]
local STARTUP_FORBIDDEN_ITEMS = {
  "stone-furnace",
  "iron-plate"
}

---@type integer[]
local PLAYER_INVENTORY_IDS = {
  defines.inventory.character_main,
  defines.inventory.character_guns,
  defines.inventory.character_ammo,
  defines.inventory.character_trash
}

---@class WarpageShipTestsRepairRequirement
---@field item_name string
---@field amount integer

---@type WarpageShipTestsRepairRequirement[]
local HUB_REPAIR_REQUIREMENTS = {
  { item_name = "stone", amount = 200 },
  { item_name = "coal", amount = 200 },
  { item_name = "copper-ore", amount = 100 },
  { item_name = "iron-plate", amount = 100 },
  { item_name = "calcite", amount = 10 }
}

---@class WarpageShipTestsFeatureState
---@field enabled boolean
---@field completed boolean
---@field repair_seeded boolean

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
      completed = false,
      repair_seeded = false
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

  if type(state.repair_seeded) ~= "boolean" then
    error("storage.features." .. TEST_FEATURE_KEY .. ".repair_seeded must be a boolean.")
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

  if type(state.repair_seeded) ~= "boolean" then
    error("storage.features." .. TEST_FEATURE_KEY .. ".repair_seeded must be a boolean.")
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
---@param force LuaForce|nil
---@param entity_name string
---@return LuaEntity|nil
local function find_unique_entity_at_hub_origin(surface, force, entity_name)
  local area = {
    { HUB_POSITION.x - 1, HUB_POSITION.y - 1 },
    { HUB_POSITION.x + 1, HUB_POSITION.y + 1 }
  }
  local find_options = {
    name = entity_name,
    area = area
  }
  if force ~= nil then
    find_options.force = force
  end

  local candidates = surface.find_entities_filtered(find_options)
  local matched = {} ---@type LuaEntity[]
  for _, candidate in ipairs(candidates) do
    if candidate.valid then
      matched[#matched + 1] = candidate
    end
  end

  if #matched > 1 then
    error(
      "Ship tests expected at most one entity '"
        .. entity_name
        .. "' at {x="
        .. tostring(HUB_POSITION.x)
        .. ", y="
        .. tostring(HUB_POSITION.y)
        .. "}, got "
        .. tostring(#matched)
        .. "."
    )
  end

  return matched[1]
end

---@param surface LuaSurface
---@param force LuaForce
---@return LuaEntity|nil
local function find_main_hub_optional(surface, force)
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

  if #matched > 1 then
    error("Ship tests expected at most one hub main entity, got " .. tostring(#matched) .. ".")
  end

  return matched[1]
end

---@param surface LuaSurface
---@param force LuaForce
---@return LuaEntity
local function find_main_hub(surface, force)
  local hub = find_main_hub_optional(surface, force)
  if hub == nil then
    error("Ship tests expected one hub main entity, got 0.")
  end

  return hub
end

---@param surface LuaSurface
---@return LuaEntity
local function find_destroyed_hub_container(surface)
  local container = find_unique_entity_at_hub_origin(surface, nil, HUB_DESTROYED_CONTAINER_ENTITY_NAME)
  if container == nil then
    error("Ship tests expected destroyed hub container at the hub origin.")
  end

  return container
end

---@param surface LuaSurface
---@return LuaEntity
local function find_destroyed_hub_rubble(surface)
  local rubble = find_unique_entity_at_hub_origin(surface, nil, HUB_DESTROYED_RUBBLE_ENTITY_NAME)
  if rubble == nil then
    error("Ship tests expected destroyed hub rubble at the hub origin.")
  end

  return rubble
end

---@return LuaEntityPrototype
local function require_hub_main_prototype()
  local prototype = prototypes.entity[HUB_MAIN_ENTITY_NAME]
  if prototype == nil then
    error("Ship tests require prototype '" .. HUB_MAIN_ENTITY_NAME .. "'.")
  end

  return prototype
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

local function assert_destroyed_hub_state()
  local surface = resolve_hub_surface()
  local force = resolve_hub_force()

  local hub = find_main_hub_optional(surface, force)
  if hub ~= nil then
    error("Ship tests expected no hub main entity before repair completion.")
  end

  local container = find_destroyed_hub_container(surface)
  local rubble = find_destroyed_hub_rubble(surface)

  if container.destructible ~= false then
    error("Ship tests expected destroyed hub container to be non-destructible.")
  end

  if container.minable ~= false then
    error("Ship tests expected destroyed hub container to be non-minable.")
  end

  local collision_box = container.prototype.collision_box
  local collision_width = collision_box.right_bottom.x - collision_box.left_top.x
  local expected_collision_box = require_hub_main_prototype().collision_box
  local expected_collision_width = expected_collision_box.right_bottom.x - expected_collision_box.left_top.x
  if math.abs(collision_width - expected_collision_width) > POSITION_EPSILON then
    error("Ship tests expected destroyed hub collision width to match cargo landing pad bounds.")
  end

  local selection_box = container.prototype.selection_box
  local selection_width = selection_box.right_bottom.x - selection_box.left_top.x
  local expected_selection_box = require_hub_main_prototype().selection_box
  local expected_selection_width = expected_selection_box.right_bottom.x - expected_selection_box.left_top.x
  if math.abs(selection_width - expected_selection_width) > POSITION_EPSILON then
    error("Ship tests expected destroyed hub selection width to match cargo landing pad bounds.")
  end

  if rubble.type ~= "corpse" then
    error("Ship tests expected destroyed hub rubble to be a corpse entity.")
  end

  if rubble.corpse_expires ~= false then
    error("Ship tests expected destroyed hub rubble to never expire.")
  end

  if rubble.corpse_immune_to_entity_placement ~= true then
    error("Ship tests expected destroyed hub rubble to be immune to entity placement.")
  end
end

---@param requirement WarpageShipTestsRepairRequirement
---@return integer
local function compute_repair_requirement_slots(requirement)
  if type(requirement.amount) ~= "number" or requirement.amount % 1 ~= 0 or requirement.amount < 1 then
    error("Ship tests repair requirement '" .. requirement.item_name .. "' must define a positive integer amount.")
  end

  local item_prototype = prototypes.item[requirement.item_name]
  if item_prototype == nil then
    error("Ship tests repair requirement item '" .. requirement.item_name .. "' must exist in item prototypes.")
  end

  local stack_size = item_prototype.stack_size
  if type(stack_size) ~= "number" or stack_size % 1 ~= 0 or stack_size < 1 then
    error(
      "Ship tests repair requirement item '" .. requirement.item_name .. "' must expose a positive integer stack size."
    )
  end

  return math.ceil(requirement.amount / stack_size)
end

local function seed_destroyed_hub_repair_items()
  local surface = resolve_hub_surface()
  local container = find_destroyed_hub_container(surface)
  local inventory = container.get_inventory(defines.inventory.chest)
  if inventory == nil then
    error("Ship tests expected destroyed hub container to expose a chest inventory.")
  end

  local slot_index = 1
  for _, requirement in ipairs(HUB_REPAIR_REQUIREMENTS) do
    if requirement.item_name == "calcite" then
      local stack = inventory[slot_index]
      if stack == nil then
        error("Ship tests could not resolve calcite repair slot in destroyed hub inventory.")
      end

      local set = stack.set_stack({
        name = requirement.item_name,
        count = requirement.amount,
        quality = "normal"
      })
      if set ~= true then
        error("Ship tests could not directly set calcite stack into destroyed hub inventory.")
      end
    else
      local inserted = inventory.insert({
        name = requirement.item_name,
        count = requirement.amount,
        quality = "normal"
      })
      if inserted ~= requirement.amount then
        error(
          "Ship tests could not seed destroyed hub requirement item '"
            .. requirement.item_name
            .. "': expected "
            .. tostring(requirement.amount)
            .. ", inserted "
            .. tostring(inserted)
            .. "."
        )
      end
    end

    slot_index = slot_index + compute_repair_requirement_slots(requirement)
  end
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
  local roboport = find_hub_part(hub, HUB_ROBOPORT_ENTITY_NAME, { x = 0, y = 0 })
  local power_pole = find_hub_part(hub, HUB_POWER_POLE_ENTITY_NAME, { x = 0, y = 0 })
  local left_pipe = find_hub_part(hub, HUB_FLUID_PIPE_ENTITY_NAME, HUB_PIPE_LEFT_OFFSET)
  local right_pipe = find_hub_part(hub, HUB_FLUID_PIPE_ENTITY_NAME, HUB_PIPE_RIGHT_OFFSET)

  local capacity = accumulator.electric_buffer_size
  local energy = accumulator.energy
  if type(capacity) ~= "number" or type(energy) ~= "number" then
    error("Ship tests expected accumulator energy fields to be numeric.")
  end

  if energy <= 0 then
    error("Ship tests expected hub accumulator to retain a positive charge.")
  end

  if energy > capacity then
    error("Ship tests expected hub accumulator charge to not exceed capacity.")
  end

  local robot_inventory = roboport.get_inventory(defines.inventory.roboport_robot)
  if robot_inventory == nil then
    error("Ship tests expected hub roboport to expose robot inventory.")
  end

  local logistic_network = force.find_logistic_network_by_position(hub.position, hub.surface)
  if logistic_network == nil then
    error("Ship tests expected hub roboport to create a logistic network at the hub origin.")
  end

  assert_wire_connection(left_pipe, power_pole, defines.wire_connector_id.circuit_green)
  assert_wire_connection(right_pipe, power_pole, defines.wire_connector_id.circuit_green)
  assert_pipe_accepts_fluid(left_pipe, "water", 250)
  assert_pipe_accepts_fluid(right_pipe, "crude-oil", 250)

  local destroyed_container = find_unique_entity_at_hub_origin(surface, force, HUB_DESTROYED_CONTAINER_ENTITY_NAME)
  if destroyed_container ~= nil then
    error("Ship tests expected destroyed hub container to be removed after repair completion.")
  end

  local destroyed_rubble = find_unique_entity_at_hub_origin(surface, nil, HUB_DESTROYED_RUBBLE_ENTITY_NAME)
  if destroyed_rubble ~= nil then
    error("Ship tests expected destroyed hub rubble to be removed after repair completion.")
  end
end

local function assert_forbidden_startup_items_removed_from_players()
  local runtime_game = require_game()
  if #runtime_game.players < 1 then
    return
  end

  for _, player in pairs(runtime_game.players) do
    for _, inventory_id in ipairs(PLAYER_INVENTORY_IDS) do
      local inventory = player.get_inventory(inventory_id)
      if inventory == nil then
        error("Ship tests expected player '" .. player.name .. "' to have inventory " .. tostring(inventory_id) .. ".")
      end

      for _, item_name in ipairs(STARTUP_FORBIDDEN_ITEMS) do
        local count = inventory.get_item_count(item_name)
        if count ~= 0 then
          error(
            "Ship tests expected startup item '"
              .. item_name
              .. "' to be removed from player '"
              .. player.name
              .. "' inventory "
              .. tostring(inventory_id)
              .. ", found "
              .. tostring(count)
              .. "."
          )
        end
      end
    end
  end
end

local function assert_forbidden_startup_items_removed_from_freeplay()
  local freeplay_interface = remote.interfaces[FREEPLAY_INTERFACE_NAME]
  if freeplay_interface == nil then
    error("Ship tests expected freeplay remote interface.")
  end

  if freeplay_interface.get_created_items == nil then
    error("Ship tests expected freeplay.get_created_items remote method.")
  end

  local created_items = remote.call(FREEPLAY_INTERFACE_NAME, "get_created_items")
  common.ensure_table(created_items, "freeplay.created_items")
  ---@cast created_items table<string, unknown>

  for _, item_name in ipairs(STARTUP_FORBIDDEN_ITEMS) do
    if created_items[item_name] ~= nil then
      error("Ship tests expected freeplay created items to exclude '" .. item_name .. "'.")
    end
  end
end

---@param events WarpageScopedBinding
function ShipTests.bind(events)
  common.ensure_table(events, "events")
  if type(events.bind) ~= "function" then
    error("events must define bind(registration).")
  end

  events:bind({
    on_init = function()
      local state = ensure_test_state()
      state.enabled = true
      state.completed = false
      state.repair_seeded = false
      prepare_test_environment()
    end,
    on_configuration_changed = function()
      local state = ensure_test_state()
      state.enabled = true
      state.completed = false
      state.repair_seeded = false
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

        assert_forbidden_startup_items_removed_from_freeplay()
        assert_forbidden_startup_items_removed_from_players()

        if state.repair_seeded ~= true then
          assert_destroyed_hub_state()
          seed_destroyed_hub_repair_items()
          state.repair_seeded = true
          return
        end

        local hub = find_main_hub_optional(resolve_hub_surface(), resolve_hub_force())
        if hub == nil then
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
