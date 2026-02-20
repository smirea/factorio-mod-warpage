local Constants = {
  mod_namespace = "warpage",
  entity_prefix = "warpage-",
  gui_prefix = "warpage_"
}

---@param suffix string
---@return string
function Constants.prefixed_entity_name(suffix)
  return Constants.entity_prefix .. suffix
end

---@param suffix string
---@return string
function Constants.prefixed_gui_name(suffix)
  return Constants.gui_prefix .. suffix
end

---@param suffix string
---@return string
function Constants.prefixed_setting_name(suffix)
  return Constants.entity_prefix .. suffix
end

---@cast Constants WarpageGlobalConstants
return Constants
