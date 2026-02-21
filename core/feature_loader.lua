---@type WarpageControlModuleRegistration[]
local control_modules = {
  {
    id = "startup",
    module_path = "modules.startup"
  }
}

---@type string[]
local shared_entity_module_paths = {
  "data.entities.init"
}

---@type string[]
local shared_recipe_module_paths = {
  "data.recipes.init"
}

---@type string[]
local module_entity_module_paths = {
  "modules.ship.entities",
  "modules.thermite_mining.entities"
}

---@type string[]
local module_recipe_module_paths = {
  "modules.ship.recipes",
  "modules.thermite_mining.recipes"
}

---@type string[]
local module_technology_module_paths = {
  "modules.thermite_mining.technologies"
}

---@param module_path string
local function extend_prototypes(module_path)
  local prototypes = require(module_path)
  if next(prototypes) == nil then
    return
  end

  data:extend(prototypes)
end

---@param module_paths string[]
local function extend_prototype_modules(module_paths)
  for _, module_path in ipairs(module_paths) do
    extend_prototypes(module_path)
  end
end

local function run_data_stage()
  extend_prototype_modules(shared_entity_module_paths)
  extend_prototype_modules(shared_recipe_module_paths)
  extend_prototype_modules(module_entity_module_paths)
  extend_prototype_modules(module_recipe_module_paths)
  extend_prototype_modules(module_technology_module_paths)
end

---@param base_context WarpageBaseContext
---@param module_registration WarpageControlModuleRegistration
---@param stage WarpageStage
---@return WarpageFeatureContext
local function build_feature_context(base_context, module_registration, stage)
  local feature_context = {
    feature_id = module_registration.id,
    feature_module_path = module_registration.module_path,
    stage = stage
  } ---@type WarpageFeatureContext

  for key, value in pairs(base_context) do
    feature_context[key] = value
  end

  if stage == "control" then
    feature_context.events = feature_context.event_bus:for_source(module_registration.id)
  end

  return feature_context
end

---@param base_context WarpageBaseContext
local function run_control_stage(base_context)
  for _, module_registration in ipairs(control_modules) do
    local runner = require(module_registration.module_path)
    runner(build_feature_context(base_context, module_registration, "control"))
  end
end

---@class FeatureLoader
---@field run_stage fun(stage: WarpageStage, context?: WarpageBaseContext)
local FeatureLoader = {}

---@param stage WarpageStage
---@param context? WarpageBaseContext
function FeatureLoader.run_stage(stage, context)
  local base_context = context or {}

  if stage == "data" then
    run_data_stage()
    return
  end

  if stage == "control" then
    run_control_stage(base_context)
  end
end

return FeatureLoader
