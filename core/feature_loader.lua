local feature_names = require("feature_index")

local VALID_STAGES = {
  settings = true,
  settings_updates = true,
  settings_final_fixes = true,
  data = true,
  data_updates = true,
  data_final_fixes = true,
  control = true
}

local function ensure_table(value, name)
  if type(value) ~= "table" then
    error(name .. " must be a table.")
  end
end

local function ensure_non_empty_string(value, name)
  if type(value) ~= "string" or value == "" then
    error(name .. " must be a non-empty string.")
  end
end

local function ensure_valid_stage(stage)
  if type(stage) ~= "string" or not VALID_STAGES[stage] then
    error("Unsupported stage '" .. tostring(stage) .. "'.")
  end
end

local function load_feature(feature_folder_name, seen_ids)
  ensure_non_empty_string(feature_folder_name, "feature index entry")

  local feature_module_path = "features." .. feature_folder_name .. ".feature"
  local feature_manifest = require(feature_module_path)
  ensure_table(feature_manifest, feature_module_path)

  ensure_non_empty_string(feature_manifest.id, feature_module_path .. ".id")

  if seen_ids[feature_manifest.id] then
    error("Duplicate feature id '" .. feature_manifest.id .. "' in " .. feature_module_path .. ".")
  end
  seen_ids[feature_manifest.id] = true

  local stages = feature_manifest.stages or {}
  ensure_table(stages, feature_module_path .. ".stages")

  for stage_name, stage_module_path in pairs(stages) do
    ensure_valid_stage(stage_name)
    ensure_non_empty_string(stage_module_path, feature_module_path .. ".stages." .. stage_name)
  end

  return {
    id = feature_manifest.id,
    module_path = feature_module_path,
    stages = stages
  }
end

local function load_features()
  ensure_table(feature_names, "feature_index")

  local features = {}
  local seen_ids = {}
  for _, feature_folder_name in ipairs(feature_names) do
    features[#features + 1] = load_feature(feature_folder_name, seen_ids)
  end

  return features
end

local function build_feature_context(base_context, feature, stage)
  local feature_context = {}
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

    if type(event_bus.for_source) ~= "function" then
      error("context.event_bus must define for_source(source).")
    end

    feature_context.events = event_bus:for_source(feature.id)
  end

  return feature_context
end

local FeatureLoader = {}

function FeatureLoader.run_stage(stage, context)
  ensure_valid_stage(stage)

  local base_context = context or {}
  ensure_table(base_context, "context")

  for _, feature in ipairs(load_features()) do
    local stage_module_path = feature.stages[stage]
    if stage_module_path ~= nil then
      local runner = require(stage_module_path)
      if type(runner) ~= "function" then
        error(stage_module_path .. " must return a function.")
      end

      runner(build_feature_context(base_context, feature, stage))
    end
  end
end

return FeatureLoader
