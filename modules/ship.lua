local common = require("core.utils.common")
local CompoundEntity = require("core.utils.compound_entity")

local PLAYER_FORCE_NAME = "player"
local HUB_SURFACE_NAME = "nauvis"
local HUB_MAIN_ENTITY_NAME = "cargo-landing-pad"
local HUB_POSITION = { x = 0, y = 0 }
local HUB_DIRECTION = defines.direction.north

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

local hub_part_definitions = {
  {
    id = "power-buffer-west",
    entity_name = "accumulator",
    offset = { x = -2, y = 0 },
    direction = defines.direction.north,
    direction_relative = false,
    create_build_effect_smoke = false,
    on_ready = lock_hub_part
  },
  {
    id = "power-buffer-east",
    entity_name = "accumulator",
    offset = { x = 2, y = 0 },
    direction = defines.direction.north,
    direction_relative = false,
    create_build_effect_smoke = false,
    on_ready = lock_hub_part
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

---@return LuaEntity
local function ensure_initial_hub()
  local surface = resolve_hub_surface()
  local force = resolve_player_force()
  local existing_hub = find_existing_hub(surface, force)
  if existing_hub ~= nil then
    hub_compound:sync(existing_hub)
    return existing_hub
  end

  return hub_compound:place({
    surface = surface,
    position = HUB_POSITION,
    force = force,
    direction = HUB_DIRECTION,
    create_build_effect_smoke = false
  })
end

---@param events WarpageScopedBinding
function Ship.bind(events)
  common.ensure_table(events, "events")
  if type(events.bind) ~= "function" then
    error("events must define bind(registration).")
  end

  hub_compound:bind(events)

  events:bind({
    on_init = function()
      ensure_initial_hub()
    end,
    on_configuration_changed = function()
      ensure_initial_hub()
    end
  })
end

return Ship
