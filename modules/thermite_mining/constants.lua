local Constants = require("__warpage__/constants")

local THERMITE_PRODUCTIVITY_LEVELS = 5
local THERMITE_RADIUS_LEVELS = 3

local PRODUCTIVITY_TECH_PREFIX = Constants.prefixed_entity_name("thermite-mining-productivity-")
local RADIUS_TECH_PREFIX = Constants.prefixed_entity_name("thermite-mining-radius-")

local productivity_technology_names = {} ---@type string[]
for level = 1, THERMITE_PRODUCTIVITY_LEVELS do
  productivity_technology_names[#productivity_technology_names + 1] = PRODUCTIVITY_TECH_PREFIX .. tostring(level)
end

local radius_technology_names = {} ---@type string[]
for level = 1, THERMITE_RADIUS_LEVELS do
  radius_technology_names[#radius_technology_names + 1] = RADIUS_TECH_PREFIX .. tostring(level)
end

local vanilla_mining_productivity_technology_names = {
  "mining-productivity-1",
  "mining-productivity-2",
  "mining-productivity-3",
  "mining-productivity-4"
} ---@type string[]

local ThermiteConstants = {
  feature_key = "thermite_mining",
  item_name = Constants.prefixed_entity_name("thermite-miner"),
  recipe_name = Constants.prefixed_entity_name("thermite-miner"),
  projectile_name = Constants.prefixed_entity_name("thermite-miner-projectile"),
  tooltip_anchor_entity_name = Constants.prefixed_entity_name("thermite-tooltip-anchor"),
  impact_effect_id = Constants.prefixed_entity_name("thermite-impact"),
  thermite_mining_technology_name = Constants.prefixed_entity_name("thermite-mining"),
  productivity_technology_names = productivity_technology_names,
  radius_technology_names = radius_technology_names,
  vanilla_mining_productivity_technology_names = vanilla_mining_productivity_technology_names,
  item_icon_path = "__warpage__/graphics/icons/thermite-barrel.png",
  technology_icon_path = "__warpage__/graphics/technology/thermite-barrel.png",
  base_radius = 1,
  base_productivity_multiplier = 1,
  countdown_ticks = 60 * 3,
  rescue_check_interval_ticks = 60 * 10,
  rescue_cooldown_ticks = 60 * 60 * 10,
  repair_phase_support_grace_ticks = 60 * 120,
  rescue_calcite_count = 1,
  unlock_pod_count = 3,
  unlock_pod_stack_count = 2
}

return ThermiteConstants
