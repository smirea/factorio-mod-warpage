local util = require("__core__/lualib/util")
local ThermiteConstants = require("modules.thermite_mining.constants")

local THERMITE_ITEM_NAME = ThermiteConstants.item_name
local THERMITE_PROJECTILE_NAME = ThermiteConstants.projectile_name
local THERMITE_TOOLTIP_ANCHOR_ENTITY_NAME = ThermiteConstants.tooltip_anchor_entity_name
local THERMITE_IMPACT_EFFECT_ID = ThermiteConstants.impact_effect_id

---@return table
local function make_thermite_projectile()
  local base_projectile = data.raw.projectile["grenade"]
  if base_projectile == nil then
    error("Expected data.raw.projectile.grenade to exist.")
  end

  local projectile = util.table.deepcopy(base_projectile)
  projectile.name = THERMITE_PROJECTILE_NAME
  projectile.action = {
    {
      type = "direct",
      action_delivery = {
        type = "instant",
        target_effects = {
          {
            type = "script",
            effect_id = THERMITE_IMPACT_EFFECT_ID
          }
        }
      }
    }
  }
  projectile.light = nil

  return projectile
end

---@return table
local function make_thermite_capsule()
  return {
    type = "capsule",
    name = THERMITE_ITEM_NAME,
    icon = ThermiteConstants.item_icon_path,
    icon_size = 64,
    capsule_action = {
      type = "throw",
      attack_parameters = {
        type = "projectile",
        activation_type = "throw",
        ammo_category = "grenade",
        cooldown = 30,
        projectile_creation_distance = 0.6,
        range = 15,
        ammo_type = {
          target_type = "position",
          action = {
            type = "direct",
            action_delivery = {
              type = "projectile",
              projectile = THERMITE_PROJECTILE_NAME,
              starting_speed = 0.3
            }
          }
        }
      }
    },
    subgroup = "capsule",
    order = "a[grenade]-c[warpage-thermite-miner]",
    stack_size = 100
  }
end

---@return table
local function make_thermite_tooltip_anchor()
  return {
    type = "simple-entity-with-owner",
    name = THERMITE_TOOLTIP_ANCHOR_ENTITY_NAME,
    icon = ThermiteConstants.item_icon_path,
    icon_size = 64,
    flags = {
      "not-on-map",
      "placeable-off-grid",
      "not-selectable-in-game",
      "not-deconstructable",
      "not-blueprintable",
      "not-upgradable",
      "not-flammable",
      "not-repairable",
      "no-copy-paste",
      "no-automated-item-removal",
      "no-automated-item-insertion",
      "not-in-kill-statistics",
      "get-by-unit-number"
    },
    hidden = true,
    selectable_in_game = false,
    allow_copy_paste = false,
    is_military_target = false,
    alert_when_damaged = false,
    max_health = 1,
    collision_mask = { layers = {} },
    collision_box = { { 0, 0 }, { 0, 0 } },
    selection_box = { { 0, 0 }, { 0, 0 } },
    render_layer = "object",
    picture = util.empty_sprite()
  }
end

---@type table[]
return {
  make_thermite_projectile(),
  make_thermite_capsule(),
  make_thermite_tooltip_anchor()
}
