local StorageSchema = {
  VERSION = 1
}

local function assert_table(value, path)
  if type(value) ~= "table" then
    error(path .. " must be a table.")
  end
end

function StorageSchema.ensure()
  if storage.warpage == nil then
    storage.warpage = {}
  end

  local root = storage.warpage
  assert_table(root, "storage.warpage")

  if root.schema_version == nil then
    root.schema_version = StorageSchema.VERSION
  elseif root.schema_version ~= StorageSchema.VERSION then
    error("Unsupported storage schema version '" .. tostring(root.schema_version) .. "'.")
  end

  if root.features == nil then
    root.features = {}
  end
  assert_table(root.features, "storage.warpage.features")

  return root
end

function StorageSchema.assert_ready()
  local root = storage.warpage
  assert_table(root, "storage.warpage")

  if root.schema_version ~= StorageSchema.VERSION then
    error("Unsupported storage schema version '" .. tostring(root.schema_version) .. "'.")
  end

  assert_table(root.features, "storage.warpage.features")

  return root
end

return StorageSchema
