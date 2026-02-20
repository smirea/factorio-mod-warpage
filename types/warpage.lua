---@meta

---@alias WarpageStage
---| "settings"
---| "settings_updates"
---| "settings_final_fixes"
---| "data"
---| "data_updates"
---| "data_final_fixes"
---| "control"

---@alias WarpageEventId integer|string

---@alias WarpageDirection integer

---@alias ForceIdentification string|LuaForce

---@class WarpageGlobalConstants
---@field mod_namespace string
---@field entity_prefix string
---@field gui_prefix string
---@field prefixed_entity_name fun(suffix: string): string
---@field prefixed_gui_name fun(suffix: string): string
---@field prefixed_setting_name fun(suffix: string): string

---@class WarpageShipConstants
---@field player_force_name string
---@field hub_surface_name string
---@field hub_position MapPosition
---@field ship_entrance_position MapPosition
---@field ship_tests_setting_name string
---@field hub_main_entity_name string
---@field hub_accumulator_entity_name string
---@field hub_roboport_entity_name string
---@field hub_power_pole_entity_name string
---@field hub_fluid_pipe_entity_name string
---@field hub_destroyed_container_entity_name string
---@field hub_destroyed_rubble_entity_name string
---@field hub_ui_root_name string
---@field hub_ui_power_label_name string
---@field hub_ui_power_bar_name string
---@field hub_ui_fluid_table_name string
---@field hub_ui_fluid_left_icon string
---@field hub_ui_fluid_right_icon string
---@field hub_ui_fluid_empty_icon string

---@class WarpageControlModuleRegistration
---@field id string
---@field module_path string

---@class WarpageHandlerEntry
---@field handler fun(payload: table|nil)
---@field source string

---@class WarpageEventRegistration
---@field on_init? fun()
---@field on_load? fun()
---@field on_configuration_changed? fun(event: table)
---@field events? table<WarpageEventId, fun(event: table)>
---@field nth_tick? table<integer, fun(event: table)>

---@class WarpageEventBus
---@field _bound boolean
---@field _on_init WarpageHandlerEntry[]
---@field _on_load WarpageHandlerEntry[]
---@field _on_configuration_changed WarpageHandlerEntry[]
---@field _events table<WarpageEventId, WarpageHandlerEntry[]>
---@field _nth_tick table<integer, WarpageHandlerEntry[]>
---@field new fun(): WarpageEventBus
---@field _assert_not_bound fun(self: WarpageEventBus)
---@field _register_on_init fun(self: WarpageEventBus, handler: unknown, source: unknown)
---@field _register_on_load fun(self: WarpageEventBus, handler: unknown, source: unknown)
---@field _register_on_configuration_changed fun(self: WarpageEventBus, handler: unknown, source: unknown)
---@field _register_event fun(self: WarpageEventBus, event_id: unknown, handler: unknown, source: unknown)
---@field _register_nth_tick fun(self: WarpageEventBus, tick: unknown, handler: unknown, source: unknown)
---@field bind fun(self: WarpageEventBus)
---@field for_source fun(self: WarpageEventBus, source: string): WarpageScopedBinding

---@class WarpageScopedBinding
---@field _bus WarpageEventBus
---@field _source string
---@field on_init fun(self: WarpageScopedBinding, handler: fun())
---@field on_load fun(self: WarpageScopedBinding, handler: fun())
---@field on_configuration_changed fun(self: WarpageScopedBinding, handler: fun(event: table))
---@field on_event fun(self: WarpageScopedBinding, event_id: WarpageEventId, handler: fun(event: table))
---@field on_nth_tick fun(self: WarpageScopedBinding, tick: integer, handler: fun(event: table))
---@field bind fun(self: WarpageScopedBinding, registration: WarpageEventRegistration)

---@class WarpageBaseContext
---@field event_bus? WarpageEventBus
---@field [string] unknown

---@class WarpageFeatureContext: WarpageBaseContext
---@field feature_id string
---@field feature_module_path string
---@field stage WarpageStage
---@field events? WarpageScopedBinding

---@alias WarpageStageRunner fun(context: WarpageFeatureContext)

---@class WarpageFeatureStorage
---@field [string] unknown

---@class WarpageStartupFeatureState
---@field configured_player_indices table<integer, true>

---@class WarpageStartupItemStack
---@field name string
---@field count integer
---@field quality? QualityID

---@class WarpageStorageRoot
---@field schema_version integer
---@field features WarpageFeatureStorage

---@class WarpageStorageGlobal
---@field warpage? WarpageStorageRoot

---@class WarpageCompoundEntityPartDefinition
---@field id string
---@field entity_name string
---@field offset MapPosition
---@field direction? WarpageDirection
---@field direction_relative? boolean
---@field force? ForceIdentification
---@field quality? QualityID
---@field create_build_effect_smoke? boolean
---@field on_ready? fun(entity: LuaEntity, main_entity: LuaEntity, created: boolean)

---@class WarpageCompoundEntityDefinition
---@field id string
---@field main_entity_name string
---@field parts WarpageCompoundEntityPartDefinition[]
---@field matches_main_entity? fun(entity: LuaEntity): boolean
---@field on_main_entity_ready? fun(entity: LuaEntity)
---@field on_main_entity_pre_destroy? fun(entity: LuaEntity)

---@class WarpageCompoundEntityPlacement
---@field surface LuaSurface
---@field position MapPosition
---@field force ForceIdentification
---@field direction? WarpageDirection
---@field quality? QualityID
---@field create_build_effect_smoke? boolean

---@class WarpageCompoundEntity
---@field new fun(definition: WarpageCompoundEntityDefinition): WarpageCompoundEntity
---@field bind fun(self: WarpageCompoundEntity, events: WarpageScopedBinding)
---@field is_main_entity fun(self: WarpageCompoundEntity, entity: LuaEntity|nil): boolean
---@field place fun(self: WarpageCompoundEntity, placement: WarpageCompoundEntityPlacement): LuaEntity
---@field sync fun(self: WarpageCompoundEntity, main_entity: LuaEntity): LuaEntity[]
---@field reposition fun(self: WarpageCompoundEntity, main_entity, position, direction?): LuaEntity[]
---@field cleanup fun(self: WarpageCompoundEntity, main_entity: LuaEntity)

---@class WarpageHolographicTextOptions
---@field text string|table
---@field surface LuaSurface
---@field target LuaEntity
---@field target_offset? MapPosition
---@field time_to_live? integer

---@alias WarpageCleanupFn fun()
