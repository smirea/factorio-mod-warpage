local util = require("__core__/lualib/util")
local Constants = require("__warpage__/constants")
local ShipConstants = require("modules.ship.constants")

local HUB_ACCUMULATOR_ENTITY_NAME = ShipConstants.hub_accumulator_entity_name
local HUB_POWER_POLE_ENTITY_NAME = ShipConstants.hub_power_pole_entity_name
local HUB_FLUID_PIPE_ENTITY_NAME = ShipConstants.hub_fluid_pipe_entity_name
local HUB_MAIN_ENTITY_NAME = ShipConstants.hub_main_entity_name
local HUB_DESTROYED_CONTAINER_ENTITY_NAME = ShipConstants.hub_destroyed_container_entity_name
local HUB_DESTROYED_RUBBLE_ENTITY_NAME = ShipConstants.hub_destroyed_rubble_entity_name
local MOD_NAMESPACE = Constants.mod_namespace

---@param entity_type string
---@param prototype_name string
---@return table
local function copy_entity_prototype(entity_type, prototype_name)
  local prototypes_by_type = data.raw[entity_type]
  if prototypes_by_type == nil then
    error("Expected data.raw." .. entity_type .. " to exist.")
  end

  local prototype = prototypes_by_type[prototype_name]
  if prototype == nil then
    error("Expected data.raw." .. entity_type .. "." .. prototype_name .. " to exist.")
  end

  return util.table.deepcopy(prototype)
end

---@return table
local function make_hub_accumulator_prototype()
  local prototype = copy_entity_prototype("accumulator", "accumulator")

  prototype.name = HUB_ACCUMULATOR_ENTITY_NAME
  prototype.flags = { "placeable-neutral", "placeable-off-grid", "not-on-map" }
  prototype.hidden = true
  prototype.hidden_in_factoriopedia = true
  prototype.selectable_in_game = false
  prototype.minable = nil
  prototype.fast_replaceable_group = nil
  prototype.collision_box = { { 0, 0 }, { 0, 0 } }
  prototype.selection_box = { { 0, 0 }, { 0, 0 } }
  prototype.chargable_graphics = nil
  prototype.water_reflection = nil
  prototype.working_sound = nil
  prototype.open_sound = nil
  prototype.close_sound = nil
  prototype.draw_copper_wires = false
  prototype.draw_circuit_wires = false
  prototype.order = "z[" .. MOD_NAMESPACE .. "]-a[hub-accumulator]"

  return prototype
end

---@return table
local function make_hub_power_pole_prototype()
  local prototype = copy_entity_prototype("electric-pole", "small-electric-pole")

  prototype.name = HUB_POWER_POLE_ENTITY_NAME
  prototype.flags = { "placeable-neutral", "placeable-off-grid", "not-on-map" }
  prototype.hidden = true
  prototype.hidden_in_factoriopedia = true
  prototype.selectable_in_game = false
  prototype.minable = nil
  prototype.fast_replaceable_group = nil
  prototype.collision_box = { { 0, 0 }, { 0, 0 } }
  prototype.selection_box = { { 0, 0 }, { 0, 0 } }
  prototype.pictures = nil
  prototype.water_reflection = nil
  prototype.working_sound = nil
  prototype.open_sound = nil
  prototype.close_sound = nil
  prototype.maximum_wire_distance = 0
  prototype.supply_area_distance = 5
  prototype.auto_connect_up_to_n_wires = 0
  prototype.draw_copper_wires = false
  prototype.draw_circuit_wires = false
  prototype.order = "z[" .. MOD_NAMESPACE .. "]-b[hub-power-pole]"

  return prototype
end

---@return table
local function make_hub_fluid_pipe_prototype()
  local prototype = copy_entity_prototype("storage-tank", "storage-tank")

  prototype.name = HUB_FLUID_PIPE_ENTITY_NAME
  prototype.icon = "__base__/graphics/icons/pipe.png"
  prototype.flags = { "placeable-neutral", "placeable-player", "player-creation" }
  prototype.hidden = true
  prototype.hidden_in_factoriopedia = true
  prototype.minable = nil
  prototype.fast_replaceable_group = nil
  prototype.collision_box = { { -0.29, -0.29 }, { 0.29, 0.29 } }
  prototype.selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } }
  prototype.two_direction_only = false
  prototype.window_bounding_box = { { -0.25, -0.25 }, { 0.25, 0.25 } }
  prototype.fluid_box.volume = 2000
  prototype.fluid_box.pipe_connections = {
    { direction = defines.direction.north, position = { 0, 0 } },
    { direction = defines.direction.east, position = { 0, 0 } },
    { direction = defines.direction.south, position = { 0, 0 } },
    { direction = defines.direction.west, position = { 0, 0 } }
  }
  prototype.pictures = {
    picture = {
      filename = "__base__/graphics/entity/pipe/pipe-cross.png",
      priority = "extra-high",
      width = 128,
      height = 128,
      scale = 0.5
    },
    fluid_background = {
      filename = "__base__/graphics/entity/pipe/fluid-background.png",
      priority = "extra-high",
      width = 64,
      height = 40,
      scale = 0.5
    },
    window_background = {
      filename = "__base__/graphics/entity/pipe/pipe-horizontal-window-background.png",
      priority = "extra-high",
      width = 128,
      height = 128,
      scale = 0.5
    },
    flow_sprite = {
      filename = "__base__/graphics/entity/pipe/fluid-flow-low-temperature.png",
      priority = "extra-high",
      width = 160,
      height = 18
    },
    gas_flow = {
      filename = "__base__/graphics/entity/pipe/steam.png",
      priority = "extra-high",
      line_length = 10,
      width = 48,
      height = 30,
      frame_count = 60,
      animation_speed = 0.25,
      scale = 0.5
    }
  }
  prototype.order = "z[" .. MOD_NAMESPACE .. "]-c[hub-fluid-pipe]"

  return prototype
end

---@return table
local function make_destroyed_hub_container_prototype()
  local prototype = copy_entity_prototype("container", "steel-chest")
  local main_hub_prototype = copy_entity_prototype("cargo-landing-pad", HUB_MAIN_ENTITY_NAME)
  if main_hub_prototype.collision_box == nil then
    error("Expected cargo landing pad collision_box to exist.")
  end
  if main_hub_prototype.selection_box == nil then
    error("Expected cargo landing pad selection_box to exist.")
  end

  prototype.name = HUB_DESTROYED_CONTAINER_ENTITY_NAME
  prototype.icon = "__base__/graphics/icons/cargo-landing-pad.png"
  prototype.flags = { "placeable-neutral", "player-creation" }
  prototype.minable = nil
  prototype.max_health = 1000000
  prototype.inventory_size = 48
  prototype.inventory_type = "with_filters_and_bar"
  prototype.fast_replaceable_group = nil
  prototype.collision_box = main_hub_prototype.collision_box
  prototype.selection_box = main_hub_prototype.selection_box
  prototype.picture = {
    layers = {
      util.empty_sprite()
    }
  }
  prototype.order = "z[" .. MOD_NAMESPACE .. "]-d[destroyed-hub-container]"

  return prototype
end

---@return table
local function make_destroyed_hub_rubble_prototype()
  local prototype = copy_entity_prototype("corpse", "cargo-landing-pad-remnants")

  prototype.name = HUB_DESTROYED_RUBBLE_ENTITY_NAME
  prototype.time_before_removed = 60 * 60 * 24 * 365 * 100
  prototype.time_before_shading_off = 60 * 60 * 24 * 365 * 100
  prototype.expires = false
  prototype.remove_on_entity_placement = false
  prototype.remove_on_tile_placement = false
  prototype.order = "z[" .. MOD_NAMESPACE .. "]-e[destroyed-hub-rubble]"

  return prototype
end

---@type table[]
return {
  make_hub_accumulator_prototype(),
  make_hub_power_pole_prototype(),
  make_hub_fluid_pipe_prototype(),
  make_destroyed_hub_container_prototype(),
  make_destroyed_hub_rubble_prototype()
}
