return function()
  data:extend({
    {
      type = "bool-setting",
      name = "warpage-debug-mode",
      setting_type = "runtime-global",
      default_value = false,
      order = "a"
    }
  })
end
