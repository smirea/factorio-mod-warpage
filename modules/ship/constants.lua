local Constants = require("__warpage__/constants")

---@type WarpageShipConstants
local ShipConstants = {
  player_force_name = "player",
  hub_surface_name = "nauvis",
  ship_tests_setting_name = Constants.prefixed_setting_name("enable-ship-tests"),
  hub_main_entity_name = "cargo-landing-pad",
  hub_accumulator_entity_name = Constants.prefixed_entity_name("hub-accumulator"),
  hub_power_pole_entity_name = Constants.prefixed_entity_name("hub-power-pole"),
  hub_fluid_pipe_entity_name = Constants.prefixed_entity_name("hub-fluid-pipe"),
  hub_destroyed_container_entity_name = Constants.prefixed_entity_name("destroyed-hub-container"),
  hub_destroyed_rubble_entity_name = Constants.prefixed_entity_name("destroyed-hub-rubble"),
  hub_ui_root_name = Constants.prefixed_gui_name("hub_ui"),
  hub_ui_power_label_name = Constants.prefixed_gui_name("hub_ui_power_label"),
  hub_ui_power_bar_name = Constants.prefixed_gui_name("hub_ui_power_bar"),
  hub_ui_fluid_table_name = Constants.prefixed_gui_name("hub_ui_fluid_table"),
  hub_ui_fluid_left_icon = "[virtual-signal=signal-left]",
  hub_ui_fluid_right_icon = "[virtual-signal=signal-right]",
  hub_ui_fluid_empty_icon = "[virtual-signal=signal-deny]"
}

return ShipConstants
