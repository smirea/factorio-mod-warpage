local ThermiteConstants = require("modules.thermite_mining.constants")

local PRODUCTIVITY_OVERLAY_ICON = "__core__/graphics/icons/technology/constants/constant-capacity.png"
local RADIUS_OVERLAY_ICON = "__core__/graphics/icons/technology/constants/constant-range.png"

---@param overlay_icon string
---@return IconData[]
local function make_technology_icons(overlay_icon)
  return {
    {
      icon = ThermiteConstants.technology_icon_path,
      icon_size = 256
    },
    {
      icon = overlay_icon,
      icon_size = 128,
      scale = 0.4,
      shift = { -50, -50 },
      floating = true
    }
  }
end

local function disable_vanilla_mining_productivity()
  for _, technology_name in ipairs(ThermiteConstants.vanilla_mining_productivity_technology_names) do
    local technology = data.raw.technology[technology_name]
    technology.enabled = false
    technology.visible_when_disabled = false
    technology.hidden = true
    technology.prerequisites = {}
  end
end

local function disable_conventional_miners()
  local burner_recipe = data.raw.recipe["burner-mining-drill"]
  burner_recipe.enabled = false
  burner_recipe.hidden = true
  burner_recipe.hide_from_player_crafting = true

  local electric_recipe = data.raw.recipe["electric-mining-drill"]
  electric_recipe.enabled = false
  electric_recipe.hidden = true
  electric_recipe.hide_from_player_crafting = true

  local electric_technology = data.raw.technology["electric-mining-drill"]
  electric_technology.enabled = false
  electric_technology.visible_when_disabled = false
  electric_technology.hidden = true
  electric_technology.prerequisites = {}

  local burner_item = data.raw.item["burner-mining-drill"]
  burner_item.hidden = true
  burner_item.hidden_in_factoriopedia = true

  local electric_item = data.raw.item["electric-mining-drill"]
  electric_item.hidden = true
  electric_item.hidden_in_factoriopedia = true
end

---@param level integer
---@return table
local function make_productivity_technology(level)
  local technology_name = ThermiteConstants.productivity_technology_names[level]

  local prerequisites
  if level == 1 then
    prerequisites = { ThermiteConstants.thermite_mining_technology_name }
  else
    local previous_name = ThermiteConstants.productivity_technology_names[level - 1]
    prerequisites = { previous_name }
  end

  return {
    type = "technology",
    name = technology_name,
    icons = make_technology_icons(PRODUCTIVITY_OVERLAY_ICON),
    effects = {
      {
        type = "nothing",
        effect_description = { "technology-effect.warpage-thermite-mining-productivity-bonus", "1" }
      }
    },
    prerequisites = prerequisites,
    unit = {
      count = 100 + ((level - 1) * 100),
      ingredients = {
        { "automation-science-pack", 1 }
      },
      time = 30
    },
    upgrade = true
  }
end

---@param level integer
---@return table
local function make_radius_technology(level)
  local technology_name = ThermiteConstants.radius_technology_names[level]

  local prerequisites
  if level == 1 then
    prerequisites = { ThermiteConstants.thermite_mining_technology_name }
  else
    local previous_name = ThermiteConstants.radius_technology_names[level - 1]
    prerequisites = { previous_name }
  end

  local ingredients_by_level = {
    [1] = { { "automation-science-pack", 1 } },
    [2] = { { "logistic-science-pack", 1 } },
    [3] = { { "chemical-science-pack", 1 } }
  }

  local ingredients = ingredients_by_level[level]

  return {
    type = "technology",
    name = technology_name,
    icons = make_technology_icons(RADIUS_OVERLAY_ICON),
    effects = {
      {
        type = "nothing",
        effect_description = { "technology-effect.warpage-thermite-mining-radius-bonus", "1" }
      }
    },
    prerequisites = prerequisites,
    unit = {
      count = 500,
      ingredients = ingredients,
      time = 30
    },
    upgrade = true
  }
end

disable_vanilla_mining_productivity()
disable_conventional_miners()

local prototypes = {
  {
    type = "technology",
    name = ThermiteConstants.thermite_mining_technology_name,
    icon = ThermiteConstants.technology_icon_path,
    icon_size = 256,
    effects = {
      {
        type = "unlock-recipe",
        recipe = ThermiteConstants.recipe_name
      }
    },
    research_trigger = {
      type = "mine-entity",
      entity = "iron-ore"
    }
  }
} ---@type table[]

for level = 1, #ThermiteConstants.productivity_technology_names do
  prototypes[#prototypes + 1] = make_productivity_technology(level)
end

for level = 1, #ThermiteConstants.radius_technology_names do
  prototypes[#prototypes + 1] = make_radius_technology(level)
end

return prototypes
