local common = require("core.utils.common")

---@class StorageSchema
---@field VERSION integer
local StorageSchema = {
  VERSION = 1
}

---@return WarpageStorageRoot
function StorageSchema.ensure()
  if storage.warpage == nil then
    storage.warpage = {}
  end

  local root = storage.warpage
  common.ensure_table(root, "storage.warpage")
  ---@cast root WarpageStorageRoot

  if root.schema_version == nil then
    root.schema_version = StorageSchema.VERSION
  elseif root.schema_version ~= StorageSchema.VERSION then
    error("Unsupported storage schema version '" .. tostring(root.schema_version) .. "'.")
  end

  if root.features == nil then
    root.features = {}
  end
  common.ensure_table(root.features, "storage.warpage.features")

  return root
end

---@return WarpageStorageRoot
function StorageSchema.assert_ready()
  local root = storage.warpage
  common.ensure_table(root, "storage.warpage")
  ---@cast root WarpageStorageRoot

  if root.schema_version ~= StorageSchema.VERSION then
    error("Unsupported storage schema version '" .. tostring(root.schema_version) .. "'.")
  end

  common.ensure_table(root.features, "storage.warpage.features")

  return root
end

return StorageSchema
