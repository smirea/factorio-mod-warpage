local Constants = require("__warpage__/constants")

data:extend({
  {
    type = "bool-setting",
    name = Constants.prefixed_setting_name("enable-ship-tests"),
    setting_type = "runtime-global",
    default_value = false,
    order = "a"
  }
})
