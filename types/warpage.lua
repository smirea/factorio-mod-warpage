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

---@class WarpageFeatureManifest
---@field id string
---@field stages table<WarpageStage, string?>

---@class WarpageLoadedFeature
---@field id string
---@field module_path string
---@field stages table<WarpageStage, string?>

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

---@class WarpageBootstrapState
---@field initialized_at_tick integer

---@class WarpageFeatureStorage
---@field bootstrap? WarpageBootstrapState
---@field [string] unknown

---@class WarpageStorageRoot
---@field schema_version integer
---@field features WarpageFeatureStorage

---@class WarpageStorageGlobal
---@field warpage? WarpageStorageRoot
