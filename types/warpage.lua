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

---@class MapPosition
---@field x number
---@field y number

---@class Color
---@field r number
---@field g number
---@field b number
---@field a? number

---@class BoundingBox
---@field left_top MapPosition
---@field right_bottom MapPosition

---@class LuaFluidPrototype
---@field base_color Color

---@class LuaFluidBox
---@field get_capacity fun(index: integer): number

---@class LuaItemStack
---@field set_stack fun(stack: table): boolean

---@class LuaInventory
---@field supports_filters fun(): boolean
---@field supports_bar fun(): boolean
---@field set_filter fun(index: integer, filter: string|nil): boolean
---@field set_bar fun(bar: integer|nil)
---@field get_item_count fun(item?: string): integer
---@field remove fun(items: table): integer
---@field insert fun(items: table): integer
---@field [integer] LuaItemStack

---@class LuaWireConnector
---@field valid boolean
---@field is_connected_to fun(target: LuaWireConnector, origin?: integer): boolean
---@field connect_to fun(target: LuaWireConnector, reach_check?: boolean, origin?: integer): boolean

---@class LuaGuiElement
---@field valid boolean
---@field name string
---@field style? table
---@field caption? string|table
---@field value? number
---@field add? fun(options: table): LuaGuiElement
---@field clear? fun()
---@field destroy? fun()
---@field [string] LuaGuiElement|unknown

---@class LuaGui
---@field screen LuaGuiElement
---@field relative LuaGuiElement

---@class LuaPlayer
---@field valid boolean
---@field index integer
---@field gui LuaGui

---@class LuaForce
---@field name string

---@alias ForceIdentification string|LuaForce
---@alias QualityID string

---@class LuaEntity
---@field valid boolean
---@field name string
---@field type string
---@field direction WarpageDirection
---@field force LuaForce
---@field surface LuaSurface
---@field position MapPosition
---@field collision_box? BoundingBox
---@field selection_box? BoundingBox
---@field fluidbox LuaFluidBox
---@field minable? boolean
---@field destructible? boolean
---@field quality? QualityID
---@field energy? number
---@field electric_buffer_size? number
---@field corpse_expires? boolean
---@field corpse_immune_to_entity_placement? boolean
---@field destroy fun(): boolean
---@field teleport fun(position: MapPosition): boolean
---@field get_fluid_contents fun(): table<string, number>
---@field insert_fluid fun(fluid: table): number
---@field get_inventory fun(inventory: integer): LuaInventory|nil
---@field get_wire_connector fun(wire_connector_id: integer, or_create: boolean): LuaWireConnector|nil

---@class LuaSurface
---@field name string
---@field create_entity fun(options: table): LuaEntity|nil
---@field find_entities_filtered fun(options: table): LuaEntity[]
---@field set_tiles fun(tiles: table[])

---@class LuaGameScript
---@field surfaces table<integer|string, LuaSurface>
---@field forces table<string, LuaForce>
---@field players table<integer, LuaPlayer>
---@field fluid_prototypes table<string, LuaFluidPrototype>
---@field get_player fun(player_index: integer): LuaPlayer|nil

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
