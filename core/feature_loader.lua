local common = require("core.utils.common")

---@type table<WarpageStage, true>
local VALID_STAGES = {
  settings = true,
  settings_updates = true,
  settings_final_fixes = true,
  data = true,
  data_updates = true,
  data_final_fixes = true,
  control = true
}

-- Keep registrations explicit; add new module files to these lists as they are created.
---@type WarpageControlModuleRegistration[]
local control_modules = {
  {
    id = "ship",
    module_path = "modules.ship.control"
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
  "modules.ship.entities"
}

---@type string[]
local module_recipe_module_paths = {
  "modules.ship.recipes"
}

---@param stage unknown
local function ensure_valid_stage(stage)
  if type(stage) ~= "string" or not VALID_STAGES[stage] then
    error("Unsupported stage '" .. tostring(stage) .. "'.")
  end
end

---@param module_path string
local function extend_prototypes(module_path)
  local prototypes = require(module_path)
  common.ensure_table(prototypes, module_path)
  if next(prototypes) == nil then
    return
  end

  data:extend(prototypes)
end

---@param module_paths string[]
---@param name string
local function extend_prototype_modules(module_paths, name)
  common.ensure_table(module_paths, name)

  for index, module_path in ipairs(module_paths) do
    local path = name .. "[" .. tostring(index) .. "]"
    common.ensure_non_empty_string(module_path, path)
    extend_prototypes(module_path)
  end
end

local function run_data_stage()
  if data == nil or type(data.extend) ~= "function" then
    error("data stage requires global data.extend.")
  end

  extend_prototype_modules(shared_entity_module_paths, "shared_entity_module_paths")
  extend_prototype_modules(shared_recipe_module_paths, "shared_recipe_module_paths")
  extend_prototype_modules(module_entity_module_paths, "module_entity_module_paths")
  extend_prototype_modules(module_recipe_module_paths, "module_recipe_module_paths")
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
    local event_bus = feature_context.event_bus
    if event_bus == nil then
      error("control stage requires context.event_bus.")
    end

    if type(event_bus.for_source) ~= "function" then
      error("context.event_bus must define for_source(source).")
    end

    feature_context.events = event_bus:for_source(module_registration.id)
  end

  return feature_context
end

---@param base_context WarpageBaseContext
local function run_control_stage(base_context)
  common.ensure_table(control_modules, "control_modules")

  for index, module_registration in ipairs(control_modules) do
    local path = "control_modules[" .. tostring(index) .. "]"
    common.ensure_table(module_registration, path)
    common.ensure_non_empty_string(module_registration.id, path .. ".id")
    common.ensure_non_empty_string(module_registration.module_path, path .. ".module_path")

    local runner = require(module_registration.module_path)
    if type(runner) ~= "function" then
      error(module_registration.module_path .. " must return a function.")
    end

    runner(build_feature_context(base_context, module_registration, "control"))
  end
end

---@class FeatureLoader
---@field run_stage fun(stage: WarpageStage, context?: WarpageBaseContext)
local FeatureLoader = {}

---@param stage unknown
---@param context? WarpageBaseContext
function FeatureLoader.run_stage(stage, context)
  ensure_valid_stage(stage)
  stage = stage --[[@as WarpageStage]]

  local base_context = context or {}
  common.ensure_table(base_context, "context")
  base_context = base_context --[[@as WarpageBaseContext]]

  if stage == "data" then
    run_data_stage()
    return
  end

  if stage == "control" then
    run_control_stage(base_context)
  end
end

return FeatureLoader
