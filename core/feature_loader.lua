local common = require("core.utils.common")

---@type string[]
local feature_names = {
  "bootstrap"
}

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

---@param stage unknown
local function ensure_valid_stage(stage)
  if type(stage) ~= "string" or not VALID_STAGES[stage] then
    error("Unsupported stage '" .. tostring(stage) .. "'.")
  end
end

---@param feature_folder_name unknown
---@param seen_ids table<string, true>
---@return WarpageLoadedFeature
local function load_feature(feature_folder_name, seen_ids)
  common.ensure_non_empty_string(feature_folder_name, "feature list entry")
  ---@cast feature_folder_name string

  local feature_module_path = "modules." .. feature_folder_name .. ".feature"
  local feature_manifest = require(feature_module_path)
  common.ensure_table(feature_manifest, feature_module_path)
  common.ensure_non_empty_string(feature_manifest.id, feature_module_path .. ".id")
  ---@cast feature_manifest WarpageFeatureManifest

  if seen_ids[feature_manifest.id] then
    error("Duplicate feature id '" .. feature_manifest.id .. "' in " .. feature_module_path .. ".")
  end
  seen_ids[feature_manifest.id] = true

  local stages = feature_manifest.stages or {}
  common.ensure_table(stages, feature_module_path .. ".stages")

  for stage_name, stage_module_path in pairs(stages) do
    ensure_valid_stage(stage_name)
    ---@cast stage_name WarpageStage
    common.ensure_non_empty_string(stage_module_path, feature_module_path .. ".stages." .. stage_name)
  end

  return {
    id = feature_manifest.id,
    module_path = feature_module_path,
    stages = stages
  }
end

---@return WarpageLoadedFeature[]
local function load_features()
  common.ensure_table(feature_names, "feature list")

  local features = {} ---@type WarpageLoadedFeature[]
  local seen_ids = {} ---@type table<string, true>
  for _, feature_folder_name in ipairs(feature_names) do
    features[#features + 1] = load_feature(feature_folder_name, seen_ids)
  end

  return features
end

---@param base_context WarpageBaseContext
---@param feature WarpageLoadedFeature
---@param stage WarpageStage
---@return WarpageFeatureContext
local function build_feature_context(base_context, feature, stage)
  local feature_context = {} ---@type WarpageBaseContext
  for key, value in pairs(base_context) do
    feature_context[key] = value
  end

  feature_context.feature_id = feature.id
  feature_context.feature_module_path = feature.module_path
  feature_context.stage = stage

  if stage == "control" then
    local event_bus = feature_context.event_bus
    if event_bus == nil then
      error("control stage requires context.event_bus.")
    end
    ---@cast event_bus WarpageEventBus

    if type(event_bus.for_source) ~= "function" then
      error("context.event_bus must define for_source(source).")
    end

    feature_context.events = event_bus:for_source(feature.id)
  end

  ---@cast feature_context WarpageFeatureContext
  return feature_context
end

---@class FeatureLoader
---@field run_stage fun(stage: WarpageStage, context?: WarpageBaseContext)
local FeatureLoader = {}

---@param stage unknown
---@param context? WarpageBaseContext
function FeatureLoader.run_stage(stage, context)
  ensure_valid_stage(stage)
  ---@cast stage WarpageStage

  local base_context = context or {}
  common.ensure_table(base_context, "context")
  ---@cast base_context WarpageBaseContext

  for _, feature in ipairs(load_features()) do
    local stage_module_path = feature.stages[stage]
    if stage_module_path ~= nil then
      local runner = require(stage_module_path)
      if type(runner) ~= "function" then
        error(stage_module_path .. " must return a function.")
      end
      ---@cast runner WarpageStageRunner

      runner(build_feature_context(base_context, feature, stage))
    end
  end
end

return FeatureLoader
