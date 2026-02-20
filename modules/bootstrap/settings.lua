---@type WarpageStageRunner
return function(_context)
  data:extend({
    {
      type = "bool-setting",
      name = "warpage-debug-mode",
      setting_type = "runtime-global",
      default_value = false,
      order = "a"
    },
    {
      type = "bool-setting",
      name = "warpage-enable-ship-tests",
      setting_type = "runtime-global",
      default_value = false,
      order = "b"
    }
  })
end
