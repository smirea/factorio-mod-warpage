local common = require("core.utils.common")

---@class StorageSchema
---@field VERSION integer
local StorageSchema = {
  VERSION = 1
}

---@return WarpageStorage
function StorageSchema.ensure()
  local runtime_storage = storage
  common.ensure_table(runtime_storage, "storage")
  ---@cast runtime_storage WarpageStorage

  local legacy_root = runtime_storage.warpage
  if legacy_root ~= nil then
    common.ensure_table(legacy_root, "storage.warpage")
    ---@cast legacy_root table<string, unknown>

    local legacy_schema_version = legacy_root.schema_version
    if legacy_schema_version ~= nil then
      if type(legacy_schema_version) ~= "number" or legacy_schema_version % 1 ~= 0 or legacy_schema_version < 1 then
        error("Unsupported legacy storage schema version '" .. tostring(legacy_schema_version) .. "'.")
      end

      if runtime_storage.schema_version == nil then
        runtime_storage.schema_version = legacy_schema_version
      end
    end

    local legacy_features = legacy_root.features
    if legacy_features ~= nil then
      common.ensure_table(legacy_features, "storage.warpage.features")
      ---@cast legacy_features table<string, unknown>

      if runtime_storage.startup == nil and legacy_features.startup ~= nil then
        runtime_storage.startup = legacy_features.startup
      end

      if runtime_storage.thermite_mining == nil and legacy_features.thermite_mining ~= nil then
        runtime_storage.thermite_mining = legacy_features.thermite_mining
      end

      if runtime_storage.ship_tests == nil and legacy_features.ship_tests ~= nil then
        runtime_storage.ship_tests = legacy_features.ship_tests
      end
    end

    runtime_storage.warpage = nil
  end

  if runtime_storage.schema_version == nil then
    runtime_storage.schema_version = StorageSchema.VERSION
  elseif runtime_storage.schema_version ~= StorageSchema.VERSION then
    error("Unsupported storage schema version '" .. tostring(runtime_storage.schema_version) .. "'.")
  end

  return runtime_storage
end

---@return WarpageStorage
function StorageSchema.assert_ready()
  local runtime_storage = storage
  common.ensure_table(runtime_storage, "storage")
  ---@cast runtime_storage WarpageStorage

  local schema_version = runtime_storage.schema_version
  if schema_version ~= nil and schema_version ~= StorageSchema.VERSION then
    error("Unsupported storage schema version '" .. tostring(schema_version) .. "'.")
  end

  local legacy_root = runtime_storage.warpage
  if legacy_root ~= nil then
    common.ensure_table(legacy_root, "storage.warpage")
    ---@cast legacy_root table<string, unknown>

    local legacy_schema_version = legacy_root.schema_version
    if
      legacy_schema_version ~= nil
      and legacy_schema_version ~= StorageSchema.VERSION
    then
      error("Unsupported legacy storage schema version '" .. tostring(legacy_schema_version) .. "'.")
    end
  end

  return runtime_storage
end

return StorageSchema
