local common = require("core.utils.common")
local StorageSchema = require("core.storage_schema")
local ShipConstants = require("modules.ship.constants")
local run_ship_setup = require("modules.ship.control")
local run_thermite_mining_setup = require("modules.thermite_mining.control")

local PLAYER_FORCE_NAME = ShipConstants.player_force_name
local HUB_SURFACE_NAME = ShipConstants.hub_surface_name
local SHIP_ENTRANCE_POSITION = ShipConstants.ship_entrance_position

local STARTUP_FEATURE_KEY = "startup"
local FREEPLAY_INTERFACE_NAME = "freeplay"

local PLAYER_CREATED_EVENT_ID = common.required_event_id("on_player_created")

---@type string[]
local FORBIDDEN_START_ITEMS = {
  "pistol",
  "submachine-gun",
  "firearm-magazine",
  "piercing-rounds-magazine",
  "uranium-rounds-magazine",
  "burner-mining-drill",
  "electric-mining-drill",
  "stone-furnace",
  "iron-plate",
  "wood",
  "small-electric-pole"
}

---@type WarpageStartupItemStack[]
local STARTING_ITEMS = {
  { name = "steel-furnace", count = 2, quality = "legendary" },
  { name = "jellynut", count = 50 }
}

---@type integer[]
local PLAYER_INVENTORY_IDS = {
  defines.inventory.character_main,
  defines.inventory.character_guns,
  defines.inventory.character_ammo,
  defines.inventory.character_trash
}

---@return LuaGameScript
local function require_game()
  if game == nil then
    error("Startup module requires runtime game context.")
  end

  return game
end

---@return LuaSurface
local function resolve_hub_surface()
  local runtime_game = require_game()
  local surface = runtime_game.surfaces[HUB_SURFACE_NAME]
  if surface == nil then
    error("Startup module requires surface '" .. HUB_SURFACE_NAME .. "'.")
  end

  return surface
end

---@return LuaForce
local function resolve_player_force()
  local runtime_game = require_game()
  local force = runtime_game.forces[PLAYER_FORCE_NAME]
  if force == nil then
    error("Startup module requires force '" .. PLAYER_FORCE_NAME .. "'.")
  end

  return force
end

---@param player_index integer
---@return LuaPlayer
local function resolve_player(player_index)
  local runtime_game = require_game()
  local player = runtime_game.get_player(player_index)
  if player == nil or player.valid ~= true then
    error("Startup module could not resolve player index '" .. tostring(player_index) .. "'.")
  end

  return player
end

---@param method_name string
local function assert_freeplay_interface_method(method_name)
  local freeplay_interface = remote.interfaces[FREEPLAY_INTERFACE_NAME]
  if freeplay_interface == nil then
    error("Missing remote interface '" .. FREEPLAY_INTERFACE_NAME .. "'.")
  end

  if freeplay_interface[method_name] == nil then
    error("Remote interface '" .. FREEPLAY_INTERFACE_NAME .. "' is missing method '" .. method_name .. "'.")
  end
end

---@param map unknown
---@param name string
---@return table<string, integer>
local function copy_item_count_map(map, name)
  common.ensure_table(map, name)
  ---@cast map table<string, unknown>

  local copied = {} ---@type table<string, integer>
  for item_name, count in pairs(map) do
    common.ensure_non_empty_string(item_name, name .. ".item_name")
    if type(count) ~= "number" or count % 1 ~= 0 or count < 0 then
      error(name .. " item '" .. item_name .. "' must have a non-negative integer count.")
    end

    copied[item_name] = count
  end

  return copied
end

local function configure_freeplay_startup()
  assert_freeplay_interface_method("get_created_items")
  assert_freeplay_interface_method("set_created_items")
  assert_freeplay_interface_method("get_respawn_items")
  assert_freeplay_interface_method("set_respawn_items")
  assert_freeplay_interface_method("set_skip_intro")
  assert_freeplay_interface_method("set_disable_crashsite")
  assert_freeplay_interface_method("set_ship_items")
  assert_freeplay_interface_method("set_debris_items")

  local created_items = copy_item_count_map(
    remote.call(FREEPLAY_INTERFACE_NAME, "get_created_items"),
    "freeplay.created_items"
  )
  local respawn_items = copy_item_count_map(
    remote.call(FREEPLAY_INTERFACE_NAME, "get_respawn_items"),
    "freeplay.respawn_items"
  )

  for _, item_name in ipairs(FORBIDDEN_START_ITEMS) do
    created_items[item_name] = nil
    respawn_items[item_name] = nil
  end

  remote.call(FREEPLAY_INTERFACE_NAME, "set_created_items", created_items)
  remote.call(FREEPLAY_INTERFACE_NAME, "set_respawn_items", respawn_items)
  remote.call(FREEPLAY_INTERFACE_NAME, "set_ship_items", {})
  remote.call(FREEPLAY_INTERFACE_NAME, "set_debris_items", {})
  remote.call(FREEPLAY_INTERFACE_NAME, "set_skip_intro", true)
  remote.call(FREEPLAY_INTERFACE_NAME, "set_disable_crashsite", true)
end

local function assert_starting_item_prototypes()
  for _, stack in ipairs(STARTING_ITEMS) do
    local item_prototype = prototypes.item[stack.name]
    if item_prototype == nil then
      error("Startup item '" .. stack.name .. "' must exist in item prototypes.")
    end

    if stack.quality ~= nil and prototypes.quality[stack.quality] == nil then
      error("Startup item quality '" .. stack.quality .. "' must exist in quality prototypes.")
    end
  end

  for _, item_name in ipairs(FORBIDDEN_START_ITEMS) do
    if prototypes.item[item_name] == nil then
      error("Forbidden startup item '" .. item_name .. "' must exist in item prototypes.")
    end
  end
end

---@param value unknown
---@param name string
---@return WarpageStartupFeatureState
local function validate_startup_state(value, name)
  common.ensure_table(value, name)
  ---@cast value WarpageStartupFeatureState

  local configured_player_indices = value.configured_player_indices
  common.ensure_table(configured_player_indices, name .. ".configured_player_indices")
  for player_index, configured in pairs(configured_player_indices) do
    if type(player_index) ~= "number" or player_index % 1 ~= 0 or player_index < 1 then
      error(name .. ".configured_player_indices must use positive integer player indexes.")
    end

    if configured ~= true then
      error(name .. ".configured_player_indices[" .. tostring(player_index) .. "] must be true.")
    end
  end

  return value
end

---@return WarpageStartupFeatureState
local function ensure_startup_state()
  local root = StorageSchema.ensure()
  local state = root.features[STARTUP_FEATURE_KEY]
  if state == nil then
    state = {
      configured_player_indices = {}
    }
    root.features[STARTUP_FEATURE_KEY] = state
  end

  return validate_startup_state(state, "storage.warpage.features.startup")
end

---@return WarpageStartupFeatureState|nil
local function assert_startup_state()
  local root = StorageSchema.assert_ready()
  local state = root.features[STARTUP_FEATURE_KEY]
  if state == nil then
    return nil
  end

  return validate_startup_state(state, "storage.warpage.features.startup")
end

---@param player LuaPlayer
---@param inventory_id integer
---@return LuaInventory
local function require_player_inventory(player, inventory_id)
  local inventory = player.get_inventory(inventory_id)
  if inventory == nil then
    error("Player '" .. player.name .. "' is missing inventory '" .. tostring(inventory_id) .. "'.")
  end

  return inventory
end

---@param player LuaPlayer
local function remove_forbidden_player_items(player)
  for _, inventory_id in ipairs(PLAYER_INVENTORY_IDS) do
    local inventory = require_player_inventory(player, inventory_id)
    for _, item_name in ipairs(FORBIDDEN_START_ITEMS) do
      local count = inventory.get_item_count(item_name)
      if count > 0 then
        local removed = inventory.remove({
          name = item_name,
          count = count
        })
        if removed ~= count then
          error(
            "Failed to remove forbidden startup item '"
              .. item_name
              .. "' from inventory "
              .. tostring(inventory_id)
              .. "."
          )
        end
      end
    end
  end
end

---@param player LuaPlayer
local function grant_starting_items(player)
  for _, stack in ipairs(STARTING_ITEMS) do
    local inserted = player.insert({
      name = stack.name,
      count = stack.count,
      quality = stack.quality
    })
    if inserted ~= stack.count then
      error(
        "Failed to grant startup item '"
          .. stack.name
          .. "': expected "
          .. tostring(stack.count)
          .. ", inserted "
          .. tostring(inserted)
          .. "."
      )
    end
  end
end

---@param player LuaPlayer
local function place_player_at_ship_entrance(player)
  local surface = resolve_hub_surface()
  local destination = surface.find_non_colliding_position("character", SHIP_ENTRANCE_POSITION, 16, 0.25, true)
  if destination == nil then
    error(
      "Could not find non-colliding startup position near ship entrance at {x="
        .. tostring(SHIP_ENTRANCE_POSITION.x)
        .. ", y="
        .. tostring(SHIP_ENTRANCE_POSITION.y)
        .. "}."
    )
  end

  local teleported = player.teleport(destination, surface)
  if teleported ~= true then
    error("Failed to place player '" .. player.name .. "' at the ship entrance.")
  end
end

local function set_player_force_spawn_position()
  local force = resolve_player_force()
  local surface = resolve_hub_surface()
  force.set_spawn_position(SHIP_ENTRANCE_POSITION, surface)
end

---@param player LuaPlayer
---@param startup_state WarpageStartupFeatureState
local function apply_player_startup(player, startup_state)
  if startup_state.configured_player_indices[player.index] == true then
    return
  end

  remove_forbidden_player_items(player)
  grant_starting_items(player)
  place_player_at_ship_entrance(player)

  startup_state.configured_player_indices[player.index] = true
end

local function apply_startup_to_existing_players()
  local startup_state = ensure_startup_state()
  local runtime_game = require_game()
  for _, player in pairs(runtime_game.players) do
    apply_player_startup(player, startup_state)
  end
end

local function initialize_startup()
  StorageSchema.ensure()
  assert_starting_item_prototypes()
  configure_freeplay_startup()
  set_player_force_spawn_position()
  apply_startup_to_existing_players()
end

local function ensure_startup_on_configuration_change()
  StorageSchema.ensure()
  assert_starting_item_prototypes()
  configure_freeplay_startup()
  set_player_force_spawn_position()
  apply_startup_to_existing_players()
end

local function assert_startup_on_load()
  StorageSchema.assert_ready()
  assert_startup_state()
end

---@param event table
local function handle_player_created(event)
  local startup_state = ensure_startup_state()
  local player = resolve_player(event.player_index)
  apply_player_startup(player, startup_state)
end

---@param context WarpageFeatureContext
---@type WarpageStageRunner
return function(context)
  local events = context.events
  if events == nil then
    error(context.feature_id .. " requires context.events.")
  end

  events:bind({
    on_init = initialize_startup,
    on_configuration_changed = ensure_startup_on_configuration_change,
    on_load = assert_startup_on_load,
    events = {
      [PLAYER_CREATED_EVENT_ID] = handle_player_created
    }
  })

  run_ship_setup(context)
  run_thermite_mining_setup(context)
end
