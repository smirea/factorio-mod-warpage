local ShipConstants = require("modules.ship.constants")

local FREEPLAY_INTERFACE_NAME = "freeplay"

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

---@param map table<string, integer>
---@return table<string, integer>
local function copy_item_count_map(map)
  local copied = {} ---@type table<string, integer>
  for item_name, count in pairs(map) do
    copied[item_name] = count
  end

  return copied
end

local function configure_freeplay_startup()
  local created_items = copy_item_count_map(remote.call(FREEPLAY_INTERFACE_NAME, "get_created_items"))
  local respawn_items = copy_item_count_map(remote.call(FREEPLAY_INTERFACE_NAME, "get_respawn_items"))

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

---@return WarpageStartupFeatureState
local function ensure_startup_state()
  local runtime_storage = storage ---@type WarpageStorage
  if runtime_storage.startup == nil then
    runtime_storage.startup = {
      configured_player_indices = {}
    }
  end

  return runtime_storage.startup
end

---@return WarpageStartupFeatureState|nil
local function assert_startup_state()
  local runtime_storage = storage --[[@as WarpageStorage]]
  return runtime_storage.startup
end

---@param player LuaPlayer
local function remove_forbidden_player_items(player)
  for _, inventory_id in ipairs(PLAYER_INVENTORY_IDS) do
    local inventory = player.get_inventory(inventory_id)
    for _, item_name in ipairs(FORBIDDEN_START_ITEMS) do
      local count = inventory.get_item_count(item_name)
      if count > 0 then
        inventory.remove({
          name = item_name,
          count = count
        })
      end
    end
  end
end

---@param player LuaPlayer
local function grant_starting_items(player)
  for _, stack in ipairs(STARTING_ITEMS) do
    player.insert({
      name = stack.name,
      count = stack.count,
      quality = stack.quality
    })
  end
end

---@param player LuaPlayer
local function place_player_at_ship_entrance(player)
  local surface = game.surfaces[ShipConstants.hub_surface_name]
  local destination = surface.find_non_colliding_position(
    "character",
    ShipConstants.ship_entrance_position,
    16,
    0.25,
    true
  )
  player.teleport(destination, surface)
end

local function set_player_force_spawn_position()
  game.forces[ShipConstants.player_force_name].set_spawn_position(
    ShipConstants.ship_entrance_position,
    game.surfaces[ShipConstants.hub_surface_name]
  )
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
  for _, player in pairs(game.players) do
    apply_player_startup(player, startup_state)
  end
end

local function initialize_startup()
  configure_freeplay_startup()
  set_player_force_spawn_position()
  apply_startup_to_existing_players()
end

local function ensure_startup_on_configuration_change()
  configure_freeplay_startup()
  set_player_force_spawn_position()
  apply_startup_to_existing_players()
end

local function assert_startup_on_load()
  assert_startup_state()
end

---@param event EventData.on_player_created
local function handle_player_created(event)
  local startup_state = ensure_startup_state()
  local player = game.get_player(event.player_index)
  apply_player_startup(player, startup_state)
end

---@param context WarpageFeatureContext
---@type WarpageStageRunner
return function(context)
  context.events:bind({
    on_init = initialize_startup,
    on_configuration_changed = ensure_startup_on_configuration_change,
    on_load = assert_startup_on_load,
    events = {
      [defines.events.on_player_created] = handle_player_created
    }
  })

  require("modules.ship.control")(context)
  require("modules.thermite_mining.control")(context)
end
