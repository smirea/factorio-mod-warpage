local ThermiteConstants = require("modules.thermite_mining.constants")

---@type table[]
return {
  {
    type = "recipe",
    name = ThermiteConstants.recipe_name,
    enabled = false,
    energy_required = 1,
    ingredients = {
      { type = "item", name = "iron-plate", amount = 1 },
      { type = "item", name = "copper-plate", amount = 1 },
      { type = "item", name = "calcite", amount = 1 }
    },
    results = {
      { type = "item", name = ThermiteConstants.item_name, amount = 1 }
    },
    allow_as_intermediate = false
  }
}
