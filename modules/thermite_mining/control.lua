local common = require("core.utils.common")
local StorageSchema = require("core.storage_schema")
local ShipConstants = require("modules.ship.constants")
local ThermiteConstants = require("modules.thermite_mining.constants")

local THERMITE_ITEM_NAME = ThermiteConstants.item_name
local THERMITE_TOOLTIP_ANCHOR_ENTITY_NAME = ThermiteConstants.tooltip_anchor_entity_name
local THERMITE_IMPACT_EFFECT_ID = ThermiteConstants.impact_effect_id
local THERMITE_MINING_TECH_NAME = ThermiteConstants.thermite_mining_technology_name

local HUB_SURFACE_NAME = ShipConstants.hub_surface_name
local HUB_POSITION = ShipConstants.hub_position
local HUB_MAIN_ENTITY_NAME = ShipConstants.hub_main_entity_name
local HUB_DESTROYED_CONTAINER_ENTITY_NAME = ShipConstants.hub_destroyed_container_entity_name
local PLAYER_FORCE_NAME = ShipConstants.player_force_name

local ORE_DROP_STACK_SIZE = 500
local ORE_DEFAULT_MULTIPLIER = 0.5
local multiplier_by_item_name = {
  ["iron-ore"] = 1,
  ["copper-ore"] = 1,
  coal = 0.75,
  stone = 0.5,
  calcite = 0.4,
  ["tungsten-ore"] = 0.2,
  scrap = 1
}

local THERMITE_COUNTDOWN_TOOLTIP_LIFETIME = 70
local THERMITE_EMPTY_BLAST_TOOLTIP_LIFETIME = 100
local THERMITE_COUNTDOWN_TOOLTIP_OFFSET = { x = 0, y = -2.6 }
local THERMITE_EMPTY_BLAST_TOOLTIP_OFFSET = { x = 0, y = -1.5 }

local SCRIPT_TRIGGER_EFFECT_EVENT_ID = common.required_event_id("on_script_trigger_effect")
local RESEARCH_FINISHED_EVENT_ID = common.required_event_id("on_research_finished")

local countdown_seconds_by_blast_id = {} ---@type table<integer, integer>

local vanilla_mining_productivity_technology_lookup = {} ---@type table<string, true>
for _, technology_name in ipairs(ThermiteConstants.vanilla_mining_productivity_technology_names) do
  vanilla_mining_productivity_technology_lookup[technology_name] = true
end

---@class WarpageThermiteCargoStack
---@field name string
---@field count integer

---@return LuaGameScript
local function require_game()
  if game == nil then
    error("Thermite mining module requires runtime game context.")
  end

  return game
end

---@param value unknown
---@param name string
---@return WarpageThermiteQueuedBlast
local function validate_queued_blast(value, name)
  common.ensure_table(value, name)
  ---@cast value WarpageThermiteQueuedBlast

  local id = value.id
  if type(id) ~= "number" or id % 1 ~= 0 or id < 1 then
    error(name .. ".id must be a positive integer.")
  end

  local surface_index = value.surface_index
  if type(surface_index) ~= "number" or surface_index % 1 ~= 0 or surface_index < 1 then
    error(name .. ".surface_index must be a positive integer.")
  end

  common.ensure_position(value.position, name .. ".position")
  common.ensure_non_empty_string(value.force_name, name .. ".force_name")

  local trigger_tick = value.trigger_tick
  if type(trigger_tick) ~= "number" or trigger_tick % 1 ~= 0 or trigger_tick < 1 then
    error(name .. ".trigger_tick must be a positive integer.")
  end

  local flame_unit_number = value.flame_unit_number
  if flame_unit_number ~= nil then
    if type(flame_unit_number) ~= "number" or flame_unit_number % 1 ~= 0 or flame_unit_number < 1 then
      error(name .. ".flame_unit_number must be a positive integer when provided.")
    end
  end

  local tooltip_anchor_unit_number = value.tooltip_anchor_unit_number
  if tooltip_anchor_unit_number ~= nil then
    if
      type(tooltip_anchor_unit_number) ~= "number"
      or tooltip_anchor_unit_number % 1 ~= 0
      or tooltip_anchor_unit_number < 1
    then
      error(name .. ".tooltip_anchor_unit_number must be a positive integer when provided.")
    end
  end

  return value
end

---@param value unknown
---@param name string
---@return WarpageThermiteMiningFeatureState
local function validate_thermite_state(value, name)
  common.ensure_table(value, name)
  ---@cast value WarpageThermiteMiningFeatureState

  local next_blast_id = value.next_blast_id
  if type(next_blast_id) ~= "number" or next_blast_id % 1 ~= 0 or next_blast_id < 1 then
    error(name .. ".next_blast_id must be a positive integer.")
  end

  common.ensure_table(value.pending_blasts, name .. ".pending_blasts")
  for blast_id, queued_blast in pairs(value.pending_blasts) do
    if type(blast_id) ~= "number" or blast_id % 1 ~= 0 or blast_id < 1 then
      error(name .. ".pending_blasts keys must be positive integers.")
    end

    local validated_blast = validate_queued_blast(
      queued_blast,
      name .. ".pending_blasts[" .. tostring(blast_id) .. "]"
    )
    if validated_blast.id ~= blast_id then
      error(name .. ".pending_blasts[" .. tostring(blast_id) .. "].id must match its table key.")
    end
  end

  local tooltip_anchor_cleanup_ticks = value.tooltip_anchor_cleanup_ticks
  if tooltip_anchor_cleanup_ticks ~= nil then
    common.ensure_table(tooltip_anchor_cleanup_ticks, name .. ".tooltip_anchor_cleanup_ticks")
    for unit_number, cleanup_tick in pairs(tooltip_anchor_cleanup_ticks) do
      if type(unit_number) ~= "number" or unit_number % 1 ~= 0 or unit_number < 1 then
        error(name .. ".tooltip_anchor_cleanup_ticks keys must be positive integers.")
      end

      if type(cleanup_tick) ~= "number" or cleanup_tick % 1 ~= 0 or cleanup_tick < 0 then
        error(name .. ".tooltip_anchor_cleanup_ticks values must be non-negative integers.")
      end
    end
  end

  common.ensure_boolean(value.unlock_bonus_delivered, name .. ".unlock_bonus_delivered")

  return value
end

---@param value unknown
---@param name string
---@return integer|nil
local function validate_support_timeout(value, name)
  if value == nil then
    return nil
  end

  if type(value) ~= "number" or value % 1 ~= 0 or value < 0 then
    error(name .. " must be a non-negative integer when provided.")
  end

  return value
end

---@param value unknown
---@param name string
---@return integer|nil
local function validate_research_finished_tick(value, name)
  if value == nil then
    return nil
  end

  if type(value) ~= "number" or value % 1 ~= 0 or value < 0 then
    error(name .. " must be a non-negative integer when provided.")
  end

  return value
end

---@param runtime_storage WarpageStorage
---@return WarpageThermiteMiningFeatureState
local function ensure_thermite_state_from_storage(runtime_storage)
  local state = runtime_storage.thermite_mining
  if state == nil then
    state = {
      next_blast_id = 1,
      pending_blasts = {},
      tooltip_anchor_cleanup_ticks = {},
      unlock_bonus_delivered = false
    }
    runtime_storage.thermite_mining = state
  end

  if state.tooltip_anchor_cleanup_ticks == nil then
    state.tooltip_anchor_cleanup_ticks = {}
  end

  local legacy_state = state ---@type table<string, unknown>
  local legacy_last_rescue_tick = legacy_state.last_calcite_rescue_tick
  if legacy_last_rescue_tick ~= nil and runtime_storage.thermite_support_timeout == nil then
    local validated_tick = validate_support_timeout(
      legacy_last_rescue_tick,
      "storage.thermite_mining.last_calcite_rescue_tick"
    )
    if validated_tick ~= nil then
      runtime_storage.thermite_support_timeout = validated_tick + ThermiteConstants.rescue_cooldown_ticks
    end
  end
  legacy_state.last_calcite_rescue_tick = nil

  validate_support_timeout(runtime_storage.thermite_support_timeout, "storage.thermite_support_timeout")
  validate_research_finished_tick(
    runtime_storage.thermite_research_finished_tick,
    "storage.thermite_research_finished_tick"
  )
  return validate_thermite_state(state, "storage.thermite_mining")
end

---@param runtime_storage WarpageStorage
---@return WarpageThermiteMiningFeatureState|nil
local function assert_thermite_state_from_storage(runtime_storage)
  local state = runtime_storage.thermite_mining
  if state == nil then
    return nil
  end

  validate_support_timeout(runtime_storage.thermite_support_timeout, "storage.thermite_support_timeout")
  validate_research_finished_tick(
    runtime_storage.thermite_research_finished_tick,
    "storage.thermite_research_finished_tick"
  )
  return validate_thermite_state(state, "storage.thermite_mining")
end

---@return WarpageThermiteMiningFeatureState
local function ensure_thermite_state()
  local runtime_storage = StorageSchema.ensure()
  return ensure_thermite_state_from_storage(runtime_storage)
end

---@return WarpageThermiteMiningFeatureState|nil
local function assert_thermite_state()
  local runtime_storage = StorageSchema.assert_ready()
  return assert_thermite_state_from_storage(runtime_storage)
end

---@return LuaSurface
local function resolve_hub_surface()
  local runtime_game = require_game()
  local surface = runtime_game.surfaces[HUB_SURFACE_NAME]
  if surface == nil then
    error("Thermite mining requires surface '" .. HUB_SURFACE_NAME .. "'.")
  end

  return surface
end

---@return LuaForce
local function resolve_player_force()
  local runtime_game = require_game()
  local force = runtime_game.forces[PLAYER_FORCE_NAME]
  if force == nil then
    error("Thermite mining requires force '" .. PLAYER_FORCE_NAME .. "'.")
  end

  return force
end

---@param surface LuaSurface
---@param force LuaForce
---@return LuaEntity|nil
local function find_main_hub(surface, force)
  local candidates = surface.find_entities_filtered({
    name = HUB_MAIN_ENTITY_NAME,
    position = HUB_POSITION,
    force = force
  })

  local matched = {} ---@type LuaEntity[]
  for _, entity in ipairs(candidates) do
    if entity.valid and common.positions_match(entity.position, HUB_POSITION) then
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

---@param entity LuaEntity
---@param inventory_id integer
---@param description string
---@return LuaInventory
local function require_inventory(entity, inventory_id, description)
  local inventory = entity.get_inventory(inventory_id)
  if inventory == nil then
    error(description .. " is missing inventory '" .. tostring(inventory_id) .. "'.")
  end

  return inventory
end

---@param force LuaForce
---@param item_name string
---@return integer
local function count_item_in_hub(force, item_name)
  local surface = resolve_hub_surface()
  local main_hub = find_main_hub(surface, force)
  local destroyed_container = find_destroyed_hub_container(surface)

  if main_hub ~= nil and destroyed_container ~= nil then
    error("Hub main entity and destroyed hub container cannot coexist at the hub origin.")
  end

  if main_hub ~= nil then
    local main_inventory = require_inventory(
      main_hub,
      defines.inventory.cargo_landing_pad_main,
      "Hub main entity"
    )
    local trash_inventory = require_inventory(
      main_hub,
      defines.inventory.cargo_landing_pad_trash,
      "Hub main entity"
    )
    return main_inventory.get_item_count(item_name) + trash_inventory.get_item_count(item_name)
  end

  if destroyed_container ~= nil then
    local inventory = require_inventory(destroyed_container, defines.inventory.chest, "Destroyed hub container")
    return inventory.get_item_count(item_name)
  end

  error("Thermite mining could not find hub delivery storage at the hub origin.")
end

---@param item_name string
---@return integer
local function count_item_in_all_players(item_name)
  local runtime_game = require_game()
  local total = 0
  for _, player in pairs(runtime_game.players) do
    local count = player.get_item_count(item_name)
    if type(count) ~= "number" then
      error("player.get_item_count('" .. item_name .. "') must return a number.")
    end
    total = total + count
  end

  return total
end

---@param force LuaForce
---@return LuaPlayer|nil
local function resolve_repair_phase_drop_target_player(force)
  local runtime_game = require_game()
  local connected_target = nil ---@type LuaPlayer|nil
  local any_target = nil ---@type LuaPlayer|nil

  for _, player in pairs(runtime_game.players) do
    if player.valid and player.force == force and player.character ~= nil and player.character.valid then
      if player.connected and player.surface.name == HUB_SURFACE_NAME then
        return player
      end

      if connected_target == nil and player.connected then
        connected_target = player
      end

      if any_target == nil then
        any_target = player
      end
    end
  end

  if connected_target ~= nil then
    return connected_target
  end

  return any_target
end

---@param source_entity LuaEntity
---@param destination_station LuaEntity
---@param stacks WarpageThermiteCargoStack[]
---@return boolean
local function send_cargo_pod(source_entity, destination_station, stacks)
  local pod = source_entity.create_cargo_pod(nil)
  if pod == nil then
    return false
  end

  local cargo_inventory = require_inventory(pod, defines.inventory.cargo_unit, "Cargo pod")
  for _, stack in ipairs(stacks) do
    local inserted = cargo_inventory.insert({
      name = stack.name,
      count = stack.count
    })
    if inserted ~= stack.count then
      error(
        "Failed to load cargo pod stack '"
          .. stack.name
          .. "': expected "
          .. tostring(stack.count)
          .. ", inserted "
          .. tostring(inserted)
          .. "."
      )
    end
  end

  pod.cargo_pod_origin = source_entity
  pod.cargo_pod_destination = {
    type = defines.cargo_destination.station,
    station = destination_station
  }
  pod.force_finish_ascending()
  return true
end

---@param force LuaForce
---@param player LuaPlayer
---@param stacks WarpageThermiteCargoStack[]
local function drop_stacks_on_player_via_cargo_pod(force, player, stacks)
  if player.valid ~= true then
    error("Repair-phase support drop requires a valid player.")
  end

  local pod = player.surface.create_entity({
    name = "cargo-pod",
    position = player.position,
    force = force
  })
  if pod == nil then
    error("Failed to create repair-phase cargo pod.")
  end

  local cargo_inventory = require_inventory(pod, defines.inventory.cargo_unit, "Repair-phase cargo pod")
  for _, stack in ipairs(stacks) do
    local inserted = cargo_inventory.insert({
      name = stack.name,
      count = stack.count
    })
    if inserted ~= stack.count then
      error(
        "Failed to load repair-phase cargo pod stack '"
          .. stack.name
          .. "': expected "
          .. tostring(stack.count)
          .. ", inserted "
          .. tostring(inserted)
          .. "."
      )
    end
  end

  pod.cargo_pod_destination = {
    type = defines.cargo_destination.surface,
    surface = player.surface,
    position = {
      x = player.position.x,
      y = player.position.y
    },
    land_at_exact_position = true
  }
  pod.force_finish_descending()
end

---@param main_hub LuaEntity
---@param stacks WarpageThermiteCargoStack[]
---@param multiplier integer
local function insert_into_main_hub(main_hub, stacks, multiplier)
  local main_inventory = require_inventory(main_hub, defines.inventory.cargo_landing_pad_main, "Hub main entity")
  local trash_inventory = require_inventory(main_hub, defines.inventory.cargo_landing_pad_trash, "Hub main entity")

  for _, stack in ipairs(stacks) do
    local total_count = stack.count * multiplier
    local inserted_main = main_inventory.insert({
      name = stack.name,
      count = total_count
    })
    if inserted_main < 0 or inserted_main > total_count then
      error("Hub main inventory insert returned an invalid count.")
    end

    local remaining = total_count - inserted_main
    if remaining > 0 then
      local inserted_trash = trash_inventory.insert({
        name = stack.name,
        count = remaining
      })
      if inserted_trash ~= remaining then
        error(
          "Failed to insert stack '"
            .. stack.name
            .. "' into hub storage: expected "
            .. tostring(total_count)
            .. ", inserted "
            .. tostring(inserted_main + inserted_trash)
            .. "."
        )
      end
    end
  end
end

---@param destroyed_container LuaEntity
---@param stacks WarpageThermiteCargoStack[]
local function insert_into_destroyed_hub_container(destroyed_container, stacks)
  local inventory = require_inventory(destroyed_container, defines.inventory.chest, "Destroyed hub container")
  for _, stack in ipairs(stacks) do
    local inserted = inventory.insert({
      name = stack.name,
      count = stack.count
    })
    if inserted ~= stack.count then
      error(
        "Failed to insert stack '"
          .. stack.name
          .. "' into destroyed hub container: expected "
          .. tostring(stack.count)
          .. ", inserted "
          .. tostring(inserted)
          .. "."
      )
    end
  end
end

---@param force LuaForce
---@param stacks WarpageThermiteCargoStack[]
---@param pod_count integer
---@return boolean
local function deliver_stacks_to_hub(force, stacks, pod_count)
  local surface = resolve_hub_surface()
  local main_hub = find_main_hub(surface, force)
  local destroyed_container = find_destroyed_hub_container(surface)

  if main_hub ~= nil and destroyed_container ~= nil then
    error("Hub main entity and destroyed hub container cannot coexist at the hub origin.")
  end

  if main_hub ~= nil then
    local delivered_pods = 0
    for _ = 1, pod_count do
      if not send_cargo_pod(main_hub, main_hub, stacks) then
        break
      end

      delivered_pods = delivered_pods + 1
    end

    local remaining_pods = pod_count - delivered_pods
    if remaining_pods > 0 then
      insert_into_main_hub(main_hub, stacks, remaining_pods)
    end
    return true
  end

  if destroyed_container == nil then
    error("Cannot deliver thermite cargo: hub delivery target is missing.")
  end

  insert_into_destroyed_hub_container(destroyed_container, stacks)
  return false
end

---@param force LuaForce
---@return integer
local function count_researched_productivity_levels(force)
  local researched_levels = 0
  for _, technology_name in ipairs(ThermiteConstants.productivity_technology_names) do
    local technology = force.technologies[technology_name]
    if technology == nil then
      error("Thermite productivity technology '" .. technology_name .. "' is missing for force '" .. force.name .. "'.")
    end

    if technology.researched then
      researched_levels = researched_levels + 1
    end
  end

  return researched_levels
end

---@param force LuaForce
---@return integer
local function count_researched_radius_levels(force)
  local researched_levels = 0
  for _, technology_name in ipairs(ThermiteConstants.radius_technology_names) do
    local technology = force.technologies[technology_name]
    if technology == nil then
      error("Thermite radius technology '" .. technology_name .. "' is missing for force '" .. force.name .. "'.")
    end

    if technology.researched then
      researched_levels = researched_levels + 1
    end
  end

  return researched_levels
end

---@param force LuaForce
---@return integer
local function compute_productivity_multiplier(force)
  return ThermiteConstants.base_productivity_multiplier + count_researched_productivity_levels(force)
end

---@param force LuaForce
---@return integer
local function compute_blast_radius(force)
  return ThermiteConstants.base_radius + count_researched_radius_levels(force)
end

---@param removed_amount number
---@param productivity_multiplier integer
---@param ore_multiplier number
---@return integer
local function ore_yield_formula(removed_amount, productivity_multiplier, ore_multiplier)
  return math.ceil(math.max(5, math.min(removed_amount / 100, 25)) * productivity_multiplier * ore_multiplier)
end

---@param item_name string
---@return number
local function resolve_ore_multiplier(item_name)
  local configured = multiplier_by_item_name[item_name]
  if configured ~= nil then
    return configured
  end

  return ORE_DEFAULT_MULTIPLIER
end

---@param surface LuaSurface
---@param force LuaForce
---@param position MapPosition
---@param item_name string
---@param item_count integer
local function spill_item_in_stacks(surface, force, position, item_name, item_count)
  if item_count < 1 then
    error("Thermite item spill count for '" .. item_name .. "' must be at least 1.")
  end

  local remaining = item_count
  while remaining > 0 do
    local stack_count = math.min(remaining, ORE_DROP_STACK_SIZE)
    surface.spill_item_stack({
      position = position,
      stack = {
        name = item_name,
        count = stack_count
      },
      enable_looted = true,
      force = force,
      allow_belts = true
    })

    remaining = remaining - stack_count
  end
end

---@param position MapPosition
---@param radius integer
---@return BoundingBox
---@return MapPosition
local function resolve_blast_area_and_center(position, radius)
  local left_top_x = position.x - radius
  local left_top_y = position.y - radius
  local right_bottom_x = position.x + radius
  local right_bottom_y = position.y + radius
  return {
    { left_top_x, left_top_y },
    { right_bottom_x, right_bottom_y }
  }, {
    x = (left_top_x + right_bottom_x) / 2,
    y = (left_top_y + right_bottom_y) / 2
  }
end

---@param surface LuaSurface
---@param area BoundingBox
---@return table<string, number>
local function remove_ore_resources(surface, area)
  local resources = surface.find_entities_filtered({
    area = area,
    type = "resource"
  })

  local removed_by_item = {} ---@type table<string, number>
  for _, resource in ipairs(resources) do
    if resource.valid then
      local resource_prototype = prototypes.entity[resource.name]
      if resource_prototype == nil then
        error("Thermite mining could not resolve resource prototype '" .. resource.name .. "'.")
      end

      if resource_prototype.resource_category == "basic-solid" then
        local amount = resource.amount
        if type(amount) ~= "number" then
          error("Resource '" .. resource.name .. "' must expose numeric amount.")
        end

        if amount > 0 then
          if prototypes.item[resource.name] == nil then
            error("Thermite mining requires item prototype '" .. resource.name .. "' for drop conversion.")
          end
          removed_by_item[resource.name] = (removed_by_item[resource.name] or 0) + amount
        end

        local destroyed = resource.destroy()
        if destroyed ~= true and resource.valid then
          error("Failed to remove ore resource '" .. resource.name .. "' at thermite blast position.")
        end
      end
    end
  end

  return removed_by_item
end

---@param surface LuaSurface
---@param force LuaForce
---@param position MapPosition
---@param removed_by_item table<string, number>
---@param productivity_multiplier integer
---@return boolean
local function drop_ore_yield(surface, force, position, removed_by_item, productivity_multiplier)
  local removed_any = false
  for item_name, removed_amount in pairs(removed_by_item) do
    if removed_amount > 0 then
      removed_any = true
      local ore_multiplier = resolve_ore_multiplier(item_name)
      local yield_count = ore_yield_formula(removed_amount, productivity_multiplier, ore_multiplier)
      if yield_count < 1 then
        error("Thermite ore yield for item '" .. item_name .. "' must be at least 1.")
      end

      spill_item_in_stacks(surface, force, position, item_name, yield_count)
    end
  end

  return removed_any
end

---@param surface LuaSurface
---@param force LuaForce
---@param position MapPosition
---@param productivity_multiplier integer
local function drop_calcite_bonus(surface, force, position, productivity_multiplier)
  local calcite_count = math.random(1, 5) * productivity_multiplier
  spill_item_in_stacks(surface, force, position, "calcite", calcite_count)
end

---@param force LuaForce
---@return boolean
local function is_hub_rebuilt(force)
  local surface = resolve_hub_surface()
  local main_hub = find_main_hub(surface, force)
  local destroyed_container = find_destroyed_hub_container(surface)
  if main_hub ~= nil and destroyed_container ~= nil then
    error("Hub main entity and destroyed hub container cannot coexist at the hub origin.")
  end

  return main_hub ~= nil
end

---@param blast WarpageThermiteQueuedBlast
---@return LuaSurface, LuaForce
local function resolve_blast_surface_and_force(blast)
  local runtime_game = require_game()
  local surface = runtime_game.surfaces[blast.surface_index]
  if surface == nil then
    error("Thermite blast surface index '" .. tostring(blast.surface_index) .. "' is missing.")
  end

  local force = runtime_game.forces[blast.force_name]
  if force == nil then
    error("Thermite blast force '" .. blast.force_name .. "' is missing.")
  end

  return surface, force
end

---@param blast WarpageThermiteQueuedBlast
local function cleanup_blast_flame(blast)
  local flame_unit_number = blast.flame_unit_number
  if flame_unit_number == nil then
    return
  end

  local runtime_game = require_game()
  local flame = runtime_game.get_entity_by_unit_number(flame_unit_number)
  if flame ~= nil and flame.valid then
    local destroyed = flame.destroy()
    if destroyed ~= true and flame.valid then
      error("Failed to destroy thermite flame entity.")
    end
  end
end

---@param state WarpageThermiteMiningFeatureState
---@param blast WarpageThermiteQueuedBlast
---@param tick integer
local function schedule_blast_tooltip_anchor_cleanup(state, blast, tick)
  local tooltip_anchor_unit_number = blast.tooltip_anchor_unit_number
  if tooltip_anchor_unit_number == nil then
    return
  end

  state.tooltip_anchor_cleanup_ticks[tooltip_anchor_unit_number] = tick + THERMITE_EMPTY_BLAST_TOOLTIP_LIFETIME
end

---@param blast WarpageThermiteQueuedBlast
---@return LuaEntity|nil
local function resolve_blast_tooltip_anchor_entity(blast)
  local tooltip_anchor_unit_number = blast.tooltip_anchor_unit_number
  if tooltip_anchor_unit_number == nil then
    return nil
  end

  local tooltip_anchor = require_game().get_entity_by_unit_number(tooltip_anchor_unit_number)
  if tooltip_anchor == nil or tooltip_anchor.valid ~= true then
    return nil
  end

  return tooltip_anchor
end

---@param state WarpageThermiteMiningFeatureState
---@param blast_id integer
---@param blast WarpageThermiteQueuedBlast
---@param tick integer
local function detonate_blast(state, blast_id, blast, tick)
  local surface, force = resolve_blast_surface_and_force(blast)
  local radius = compute_blast_radius(force)
  local productivity_multiplier = compute_productivity_multiplier(force)
  local blast_area, drop_position = resolve_blast_area_and_center(blast.position, radius)

  drop_calcite_bonus(surface, force, drop_position, productivity_multiplier)
  local removed_by_item = remove_ore_resources(surface, blast_area)
  local removed_any = drop_ore_yield(surface, force, drop_position, removed_by_item, productivity_multiplier)

  local explosion = surface.create_entity({
    name = "grenade-explosion",
    position = blast.position
  })
  if explosion == nil then
    error("Failed to create thermite blast explosion entity.")
  end

  if not removed_any then
    local tooltip_anchor = resolve_blast_tooltip_anchor_entity(blast)
    if tooltip_anchor ~= nil then
      common.create_holographic_text({
        text = "x.x",
        surface = surface,
        target = tooltip_anchor,
        target_offset = THERMITE_EMPTY_BLAST_TOOLTIP_OFFSET,
        time_to_live = THERMITE_EMPTY_BLAST_TOOLTIP_LIFETIME
      })
    end
  end

  schedule_blast_tooltip_anchor_cleanup(state, blast, tick)
  cleanup_blast_flame(blast)
  state.pending_blasts[blast_id] = nil
  countdown_seconds_by_blast_id[blast_id] = nil
end

---@param state WarpageThermiteMiningFeatureState
---@param tick integer
local function process_tooltip_anchor_cleanup(state, tick)
  for unit_number, cleanup_tick in pairs(state.tooltip_anchor_cleanup_ticks) do
    if tick >= cleanup_tick then
      local tooltip_anchor = require_game().get_entity_by_unit_number(unit_number)
      if tooltip_anchor ~= nil and tooltip_anchor.valid then
        local destroyed = tooltip_anchor.destroy()
        if destroyed ~= true and tooltip_anchor.valid then
          error("Failed to destroy thermite tooltip anchor entity.")
        end
      end

      state.tooltip_anchor_cleanup_ticks[unit_number] = nil
    end
  end
end

---@param blast_id integer
---@param blast WarpageThermiteQueuedBlast
---@param tick integer
local function update_blast_countdown(blast_id, blast, tick)
  local remaining_ticks = blast.trigger_tick - tick
  if remaining_ticks <= 0 then
    return
  end

  local seconds_remaining = math.ceil(remaining_ticks / 60)
  if seconds_remaining < 1 or seconds_remaining > 3 then
    return
  end

  if countdown_seconds_by_blast_id[blast_id] == seconds_remaining then
    return
  end

  local surface, _ = resolve_blast_surface_and_force(blast)
  local tooltip_anchor = resolve_blast_tooltip_anchor_entity(blast)
  if tooltip_anchor == nil then
    countdown_seconds_by_blast_id[blast_id] = seconds_remaining
    return
  end

  if tooltip_anchor.surface ~= surface then
    error("Thermite tooltip anchor surface mismatch for blast id '" .. tostring(blast.id) .. "'.")
  end

  common.create_holographic_text({
    text = tostring(seconds_remaining),
    surface = surface,
    target = tooltip_anchor,
    target_offset = THERMITE_COUNTDOWN_TOOLTIP_OFFSET,
    time_to_live = THERMITE_COUNTDOWN_TOOLTIP_LIFETIME
  })
  countdown_seconds_by_blast_id[blast_id] = seconds_remaining
end

---@param state WarpageThermiteMiningFeatureState
local function grant_unlock_bonus_if_needed(state)
  if state.unlock_bonus_delivered then
    return
  end

  local force = resolve_player_force()
  local technology = force.technologies[THERMITE_MINING_TECH_NAME]
  if technology == nil then
    error("Missing technology '" .. THERMITE_MINING_TECH_NAME .. "' for force '" .. force.name .. "'.")
  end

  if not technology.researched then
    return
  end

  deliver_stacks_to_hub(force, {
    { name = THERMITE_ITEM_NAME, count = ThermiteConstants.unlock_pod_stack_count }
  }, ThermiteConstants.unlock_pod_count)
  state.unlock_bonus_delivered = true
  require_game().print("psst, look up, check the hub")
end

---@param runtime_storage WarpageStorage
---@param force LuaForce
---@param tick integer
local function ensure_research_finished_tick(runtime_storage, force, tick)
  validate_research_finished_tick(
    runtime_storage.thermite_research_finished_tick,
    "storage.thermite_research_finished_tick"
  )

  if runtime_storage.thermite_research_finished_tick ~= nil then
    return
  end

  local technology = force.technologies[THERMITE_MINING_TECH_NAME]
  if technology == nil then
    error("Missing technology '" .. THERMITE_MINING_TECH_NAME .. "' for force '" .. force.name .. "'.")
  end

  if technology.researched then
    runtime_storage.thermite_research_finished_tick =
      math.max(0, tick - ThermiteConstants.repair_phase_support_grace_ticks)
  end
end

---@param force LuaForce
local function enforce_mining_productivity_removal_for_force(force)
  force.mining_drill_productivity_bonus = 0
  for _, technology_name in ipairs(ThermiteConstants.vanilla_mining_productivity_technology_names) do
    local technology = force.technologies[technology_name]
    if technology ~= nil then
      technology.enabled = false
      technology.visible_when_disabled = false
      technology.saved_progress = 0
      if technology.researched then
        technology.researched = false
      end
    end
  end
  force.mining_drill_productivity_bonus = 0
end

local function enforce_mining_productivity_removal()
  local runtime_game = require_game()
  for _, force in pairs(runtime_game.forces) do
    enforce_mining_productivity_removal_for_force(force)
  end
end

local function initialize_feature()
  local runtime_storage = StorageSchema.ensure()
  local state = ensure_thermite_state()
  enforce_mining_productivity_removal()
  ensure_research_finished_tick(runtime_storage, resolve_player_force(), require_game().tick)
  grant_unlock_bonus_if_needed(state)
end

local function configure_feature()
  local runtime_storage = StorageSchema.ensure()
  local state = ensure_thermite_state()
  enforce_mining_productivity_removal()
  ensure_research_finished_tick(runtime_storage, resolve_player_force(), require_game().tick)
  grant_unlock_bonus_if_needed(state)
end

local function assert_feature_loaded()
  StorageSchema.assert_ready()
  assert_thermite_state()
  countdown_seconds_by_blast_id = {}
end

---@param event table
local function handle_script_trigger_effect(event)
  if event.effect_id ~= THERMITE_IMPACT_EFFECT_ID then
    return
  end

  local surface_index = event.surface_index
  if type(surface_index) ~= "number" or surface_index % 1 ~= 0 or surface_index < 1 then
    error("Thermite script trigger event requires a positive integer surface_index.")
  end

  local position = event.target_position
  if position == nil then
    position = event.source_position
  end
  if position == nil then
    error("Thermite script trigger event requires target_position or source_position.")
  end
  common.ensure_position(position, "thermite_event.position")

  local source_entity = event.source_entity
  local cause_entity = event.cause_entity
  local source_force = nil ---@type LuaForce|nil
  if source_entity ~= nil and source_entity.valid then
    source_force = source_entity.force
  elseif cause_entity ~= nil and cause_entity.valid then
    source_force = cause_entity.force
  end
  if source_force == nil then
    error("Thermite script trigger event requires a valid source force.")
  end

  local runtime_game = require_game()
  local surface = runtime_game.surfaces[surface_index]
  if surface == nil then
    error("Thermite script trigger event surface index '" .. tostring(surface_index) .. "' is missing.")
  end

  local state = ensure_thermite_state()
  local blast_id = state.next_blast_id
  state.next_blast_id = blast_id + 1

  local flame = surface.create_entity({
    name = "fire-flame",
    position = position,
    force = source_force
  })
  if flame == nil then
    error("Failed to create thermite flame entity.")
  end

  local flame_unit_number = flame.unit_number
  if flame_unit_number ~= nil then
    if type(flame_unit_number) ~= "number" or flame_unit_number % 1 ~= 0 or flame_unit_number < 1 then
      error("Thermite flame unit_number must be a positive integer when provided.")
    end
  end

  local tooltip_anchor = surface.create_entity({
    name = THERMITE_TOOLTIP_ANCHOR_ENTITY_NAME,
    position = position,
    force = source_force
  })
  if tooltip_anchor == nil then
    error("Failed to create thermite tooltip anchor entity.")
  end

  tooltip_anchor.destructible = false
  tooltip_anchor.minable = false

  if tooltip_anchor.health == nil then
    error("Thermite tooltip anchor entity must have health.")
  end

  local tooltip_anchor_unit_number = tooltip_anchor.unit_number
  if tooltip_anchor_unit_number ~= nil then
    if
      type(tooltip_anchor_unit_number) ~= "number"
      or tooltip_anchor_unit_number % 1 ~= 0
      or tooltip_anchor_unit_number < 1
    then
      error("Thermite tooltip anchor unit_number must be a positive integer when provided.")
    end
  end

  state.pending_blasts[blast_id] = {
    id = blast_id,
    surface_index = surface_index,
    position = {
      x = position.x,
      y = position.y
    },
    force_name = source_force.name,
    trigger_tick = event.tick + ThermiteConstants.countdown_ticks,
    flame_unit_number = flame_unit_number,
    tooltip_anchor_unit_number = tooltip_anchor_unit_number
  }

  countdown_seconds_by_blast_id[blast_id] = 3
  common.create_holographic_text({
    text = "3",
    surface = surface,
    target = tooltip_anchor,
    target_offset = THERMITE_COUNTDOWN_TOOLTIP_OFFSET,
    time_to_live = THERMITE_COUNTDOWN_TOOLTIP_LIFETIME
  })
end

---@param event table
local function handle_research_finished(event)
  local research = event.research
  if research == nil then
    error("on_research_finished event requires event.research.")
  end

  local research_name = research.name
  if vanilla_mining_productivity_technology_lookup[research_name] == true then
    enforce_mining_productivity_removal_for_force(research.force)
    return
  end

  if research_name ~= THERMITE_MINING_TECH_NAME then
    return
  end

  local runtime_storage = StorageSchema.ensure()
  if runtime_storage.thermite_research_finished_tick == nil then
    runtime_storage.thermite_research_finished_tick = event.tick
  end

  local state = ensure_thermite_state()
  grant_unlock_bonus_if_needed(state)
end

---@param event table
local function handle_blast_updates(event)
  local state = ensure_thermite_state()
  process_tooltip_anchor_cleanup(state, event.tick)
  if next(state.pending_blasts) == nil then
    return
  end

  local due_blast_ids = {} ---@type integer[]
  for blast_id, blast in pairs(state.pending_blasts) do
    if event.tick >= blast.trigger_tick then
      due_blast_ids[#due_blast_ids + 1] = blast_id
    else
      update_blast_countdown(blast_id, blast, event.tick)
    end
  end

  for _, blast_id in ipairs(due_blast_ids) do
    local blast = state.pending_blasts[blast_id]
    if blast ~= nil then
      detonate_blast(state, blast_id, blast, event.tick)
    end
  end
end

---@param event table
local function handle_calcite_rescue_check(event)
  local runtime_storage = StorageSchema.ensure()
  local support_timeout =
    validate_support_timeout(runtime_storage.thermite_support_timeout, "storage.thermite_support_timeout")
  ensure_thermite_state_from_storage(runtime_storage)
  local force = resolve_player_force()
  local hub_rebuilt = is_hub_rebuilt(force)

  if hub_rebuilt and support_timeout ~= nil and event.tick < support_timeout then
    return
  end

  local calcite_count = count_item_in_all_players("calcite") + count_item_in_hub(force, "calcite")
  local thermite_count = count_item_in_all_players(THERMITE_ITEM_NAME) + count_item_in_hub(force, THERMITE_ITEM_NAME)
  if calcite_count > 0 or thermite_count > 0 then
    return
  end

  if not hub_rebuilt then
    ensure_research_finished_tick(runtime_storage, force, event.tick)
    local research_finished_tick = validate_research_finished_tick(
      runtime_storage.thermite_research_finished_tick,
      "storage.thermite_research_finished_tick"
    )
    if research_finished_tick == nil then
      return
    end

    if event.tick < (research_finished_tick + ThermiteConstants.repair_phase_support_grace_ticks) then
      return
    end

    local target_player = resolve_repair_phase_drop_target_player(force)
    if target_player == nil then
      return
    end

    drop_stacks_on_player_via_cargo_pod(force, target_player, {
      { name = "calcite", count = ThermiteConstants.rescue_calcite_count }
    })
    runtime_storage.thermite_support_timeout = nil
    require_game().print("look, you should never run out of [item=calcite], sending you some how")
    return
  end

  local delivered_to_rebuilt_hub = deliver_stacks_to_hub(force, {
    { name = "calcite", count = ThermiteConstants.rescue_calcite_count }
  }, 1)
  if delivered_to_rebuilt_hub then
    runtime_storage.thermite_support_timeout = event.tick + ThermiteConstants.rescue_cooldown_ticks
  else
    runtime_storage.thermite_support_timeout = nil
  end
  require_game().print("look, you should never run out of [item=calcite], sending you some how")
end

---@param context WarpageFeatureContext
---@type WarpageStageRunner
return function(context)
  local events = context.events
  if events == nil then
    error(context.feature_id .. " requires context.events.")
  end

  events:bind({
    on_init = initialize_feature,
    on_configuration_changed = configure_feature,
    on_load = assert_feature_loaded,
    events = {
      [SCRIPT_TRIGGER_EFFECT_EVENT_ID] = handle_script_trigger_effect,
      [RESEARCH_FINISHED_EVENT_ID] = handle_research_finished
    },
    nth_tick = {
      [1] = handle_blast_updates,
      [ThermiteConstants.rescue_check_interval_ticks] = handle_calcite_rescue_check
    }
  })
end
