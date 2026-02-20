---@meta

-- Generated from Factorio prototype JSON docs (2.0.73, api v6).

---@class ActivateEquipmentCapsuleAction
---@field type "equipment-remote"
---@field equipment EquipmentID

---@class ActivateImpactTriggerEffectItem: TriggerEffectItem
---@field type "activate-impact"
---@field deliver_category string|nil

---@class ActivatePasteTipTrigger: CountBasedTipTrigger
---@field type "activate-paste"

---@alias ActiveTriggerID string

---@class ActivityBarStyleSpecification: BaseStyleSpecification
---@field type "activity_bar_style"
---@field speed number|nil
---@field bar_width integer|nil
---@field color Color|nil
---@field bar_background ElementImageSet|nil
---@field bar ElementImageSet|nil
---@field bar_size_ratio number|nil

---@class ActivityMatchingModifiers
---@field multiplier number|nil
---@field minimum number|nil
---@field maximum number|nil
---@field offset number|nil
---@field inverted boolean|nil

---@class AdvancedVolumeControl
---@field attenuation Fade|nil
---@field fades Fades|nil
---@field darkness_threshold number|nil

---@class AggregationSpecification
---@field max_count integer
---@field progress_threshold number|nil
---@field volume_reduction_rate number|nil
---@field remove boolean
---@field count_already_playing boolean|nil
---@field priority "closest"|"farthest"|"newest"|"oldest"|nil

---@class AgriculturalCraneProperties
---@field speed AgriculturalCraneSpeed
---@field min_arm_extent number|nil
---@field min_grappler_extent number|nil
---@field operation_angle number|nil
---@field telescope_default_extention number|nil
---@field origin Vector3D
---@field shadow_direction Vector3D
---@field parts CranePart[]

---@class AgriculturalCraneSpeed
---@field arm AgriculturalCraneSpeedArm
---@field grappler AgriculturalCraneSpeedGrappler

---@class AgriculturalCraneSpeedArm
---@field turn_rate number|nil
---@field extension_speed number|nil

---@class AgriculturalCraneSpeedGrappler
---@field vertical_turn_rate number|nil
---@field horizontal_turn_rate number|nil
---@field extension_speed number|nil
---@field allow_transpolar_movement boolean|nil

---@alias AirbornePollutantID string

---@class AlternativeBuildTipTrigger: CountBasedTipTrigger
---@field type "alternative-build"

---@alias AmbientSoundType "menu-track"|"main-track"|"hero-track"|"interlude"

---@alias AmmoCategoryID string

---@class AmmoDamageModifier: BaseModifier
---@field type "ammo-damage"
---@field infer_icon boolean|nil
---@field use_icon_overlay_constant boolean|nil
---@field ammo_category AmmoCategoryID
---@field modifier number

---@alias AmmoSourceType "default"|"player"|"turret"|"vehicle"

---@class AndTipTrigger
---@field type "and"
---@field triggers TipTrigger[]

---@class AnimatedVector
---@field rotations VectorRotation[]
---@field render_layer RenderLayer|nil
---@field direction_shift DirectionShift|nil

---@class Animation: AnimationParameters
---@field layers Animation[]|nil
---@field filename FileName|nil
---@field stripes Stripe[]|nil
---@field filenames FileName[]|nil
---@field slice integer|nil
---@field lines_per_file integer|nil

---@class Animation4Way
---@field north Animation
---@field north_east Animation|nil
---@field east Animation|nil
---@field south_east Animation|nil
---@field south Animation|nil
---@field south_west Animation|nil
---@field west Animation|nil
---@field north_west Animation|nil

---@class AnimationElement
---@field render_layer RenderLayer|nil
---@field secondary_draw_order integer|nil
---@field apply_tint boolean|nil
---@field always_draw boolean|nil
---@field animation Animation|nil

---@alias AnimationFrameSequence integer[]

---@class AnimationParameters: SpriteParameters
---@field size SpriteSizeType|table|nil
---@field width SpriteSizeType|nil
---@field height SpriteSizeType|nil
---@field run_mode AnimationRunMode|nil
---@field frame_count integer|nil
---@field line_length integer|nil
---@field animation_speed number|nil
---@field max_advance number|nil
---@field repeat_count integer|nil
---@field dice integer|nil
---@field dice_x integer|nil
---@field dice_y integer|nil
---@field frame_sequence AnimationFrameSequence|nil
---@field mipmap_count integer|nil
---@field generate_sdf boolean|nil

---@alias AnimationRunMode "forward"|"backward"|"forward-then-backward"

---@class AnimationSheet: AnimationParameters
---@field variation_count integer
---@field line_length integer|nil
---@field filename FileName|nil
---@field filenames FileName[]|nil
---@field lines_per_file integer|nil

---@class AnimationVariations
---@field sheet AnimationSheet|nil
---@field sheets AnimationSheet[]|nil

---@alias AnyPrototype AccumulatorPrototype|AchievementPrototype|ActiveDefenseEquipmentPrototype|AgriculturalTowerPrototype|AirbornePollutantPrototype|AmbientSound|AmmoCategory|AmmoItemPrototype|AmmoTurretPrototype|AnimationPrototype|ArithmeticCombinatorPrototype|ArmorPrototype|ArrowPrototype|ArtilleryFlarePrototype|ArtilleryProjectilePrototype|ArtilleryTurretPrototype|ArtilleryWagonPrototype|AssemblingMachinePrototype|AsteroidChunkPrototype|AsteroidCollectorPrototype|AsteroidPrototype|AutoplaceControl|BatteryEquipmentPrototype|BeaconPrototype|BeamPrototype|BeltImmunityEquipmentPrototype|BlueprintBookPrototype|BlueprintItemPrototype|BoilerPrototype|BuildEntityAchievementPrototype|BurnerGeneratorPrototype|BurnerUsagePrototype|CapsulePrototype|CaptureRobotPrototype|CarPrototype|CargoBayPrototype|CargoLandingPadPrototype|CargoPodPrototype|CargoWagonPrototype|ChainActiveTriggerPrototype|ChangedSurfaceAchievementPrototype|CharacterCorpsePrototype|CharacterPrototype|CliffPrototype|CollisionLayerPrototype|CombatRobotCountAchievementPrototype|CombatRobotPrototype|CompleteObjectiveAchievementPrototype|ConstantCombinatorPrototype|ConstructWithRobotsAchievementPrototype|ConstructionRobotPrototype|ContainerPrototype|CopyPasteToolPrototype|CorpsePrototype|CreatePlatformAchievementPrototype|CurvedRailAPrototype|CurvedRailBPrototype|CustomEventPrototype|CustomInputPrototype|DamageType|DeciderCombinatorPrototype|DeconstructWithRobotsAchievementPrototype|DeconstructibleTileProxyPrototype|DeconstructionItemPrototype|DecorativePrototype|DelayedActiveTriggerPrototype|DeliverByRobotsAchievementPrototype|DeliverCategory|DeliverImpactCombination|DepleteResourceAchievementPrototype|DestroyCliffAchievementPrototype|DisplayPanelPrototype|DontBuildEntityAchievementPrototype|DontCraftManuallyAchievementPrototype|DontKillManuallyAchievementPrototype|DontResearchBeforeResearchingAchievementPrototype|DontUseEntityInEnergyProductionAchievementPrototype|EditorControllerPrototype|ElectricEnergyInterfacePrototype|ElectricPolePrototype|ElectricTurretPrototype|ElevatedCurvedRailAPrototype|ElevatedCurvedRailBPrototype|ElevatedHalfDiagonalRailPrototype|ElevatedStraightRailPrototype|EnemySpawnerPrototype|EnergyShieldEquipmentPrototype|EntityGhostPrototype|EquipArmorAchievementPrototype|EquipmentCategory|EquipmentGhostPrototype|EquipmentGridPrototype|ExplosionPrototype|FireFlamePrototype|FishPrototype|FluidPrototype|FluidStreamPrototype|FluidTurretPrototype|FluidWagonPrototype|FontPrototype|FuelCategory|FurnacePrototype|FusionGeneratorPrototype|FusionReactorPrototype|GatePrototype|GeneratorEquipmentPrototype|GeneratorPrototype|GodControllerPrototype|GroupAttackAchievementPrototype|GuiStyle|GunPrototype|HalfDiagonalRailPrototype|HeatInterfacePrototype|HeatPipePrototype|HighlightBoxEntityPrototype|ImpactCategory|InfinityCargoWagonPrototype|InfinityContainerPrototype|InfinityPipePrototype|InserterPrototype|InventoryBonusEquipmentPrototype|ItemEntityPrototype|ItemGroup|ItemPrototype|ItemRequestProxyPrototype|ItemSubGroup|ItemWithEntityDataPrototype|ItemWithInventoryPrototype|ItemWithLabelPrototype|ItemWithTagsPrototype|KillAchievementPrototype|LabPrototype|LampPrototype|LandMinePrototype|LaneSplitterPrototype|LegacyCurvedRailPrototype|LegacyStraightRailPrototype|LightningAttractorPrototype|LightningPrototype|LinkedBeltPrototype|LinkedContainerPrototype|Loader1x1Prototype|Loader1x2Prototype|LocomotivePrototype|LogisticContainerPrototype|LogisticRobotPrototype|MapGenPresets|MapSettings|MarketPrototype|MiningDrillPrototype|ModData|ModuleCategory|ModulePrototype|ModuleTransferAchievementPrototype|MouseCursor|MovementBonusEquipmentPrototype|NamedNoiseExpression|NamedNoiseFunction|NightVisionEquipmentPrototype|OffshorePumpPrototype|ParticlePrototype|ParticleSourcePrototype|PipePrototype|PipeToGroundPrototype|PlaceEquipmentAchievementPrototype|PlanetPrototype|PlantPrototype|PlayerDamagedAchievementPrototype|PlayerPortPrototype|PowerSwitchPrototype|ProcessionLayerInheritanceGroup|ProcessionPrototype|ProduceAchievementPrototype|ProducePerHourAchievementPrototype|ProgrammableSpeakerPrototype|ProjectilePrototype|ProxyContainerPrototype|PumpPrototype|QualityPrototype|RadarPrototype|RailChainSignalPrototype|RailPlannerPrototype|RailRampPrototype|RailRemnantsPrototype|RailSignalPrototype|RailSupportPrototype|ReactorPrototype|RecipeCategory|RecipePrototype|RemoteControllerPrototype|RepairToolPrototype|ResearchAchievementPrototype|ResearchWithSciencePackAchievementPrototype|ResourceCategory|ResourceEntityPrototype|RoboportEquipmentPrototype|RoboportPrototype|RocketSiloPrototype|RocketSiloRocketPrototype|RocketSiloRocketShadowPrototype|SegmentPrototype|SegmentedUnitPrototype|SelectionToolPrototype|SelectorCombinatorPrototype|ShootAchievementPrototype|ShortcutPrototype|SimpleEntityPrototype|SimpleEntityWithForcePrototype|SimpleEntityWithOwnerPrototype|SmokeWithTriggerPrototype|SolarPanelEquipmentPrototype|SolarPanelPrototype|SoundPrototype|SpaceConnectionDistanceTraveledAchievementPrototype|SpaceConnectionPrototype|SpaceLocationPrototype|SpacePlatformHubPrototype|SpacePlatformStarterPackPrototype|SpectatorControllerPrototype|SpeechBubblePrototype|SpiderLegPrototype|SpiderUnitPrototype|SpiderVehiclePrototype|SpidertronRemotePrototype|SplitterPrototype|SpritePrototype|StickerPrototype|StorageTankPrototype|StraightRailPrototype|SurfacePropertyPrototype|SurfacePrototype|TechnologyPrototype|TemporaryContainerPrototype|ThrusterPrototype|TileEffectDefinition|TileGhostPrototype|TilePrototype|TipsAndTricksItem|TipsAndTricksItemCategory|ToolPrototype|TrainPathAchievementPrototype|TrainStopPrototype|TransportBeltPrototype|TreePrototype|TriggerTargetType|TrivialSmokePrototype|TurretPrototype|TutorialDefinition|UndergroundBeltPrototype|UnitPrototype|UpgradeItemPrototype|UseEntityInEnergyProductionAchievementPrototype|UseItemAchievementPrototype|UtilityConstants|UtilitySounds|UtilitySprites|ValvePrototype|VirtualSignalPrototype|WallPrototype

---@class ApplyStarterPackTipTrigger: CountBasedTipTrigger
---@field type "apply-starter-pack"

---@class AreaTriggerItem: TriggerItem
---@field type "area"
---@field radius number
---@field trigger_from_target boolean|nil
---@field target_entities boolean|nil
---@field target_enemies boolean|nil
---@field show_in_tooltip boolean|nil
---@field collision_mode "distance-from-collision-box"|"distance-from-center"|nil

---@class ArtilleryRangeModifier: SimpleModifier
---@field type "artillery-range"
---@field infer_icon boolean|nil
---@field use_icon_overlay_constant boolean|nil

---@class ArtilleryRemoteCapsuleAction
---@field type "artillery-remote"
---@field flare EntityID
---@field play_sound_on_failure boolean|nil

---@class ArtilleryTriggerDelivery: TriggerDeliveryItem
---@field type "artillery"
---@field projectile EntityID
---@field starting_speed number
---@field starting_speed_deviation number|nil
---@field direction_deviation number|nil
---@field range_deviation number|nil
---@field trigger_fired_artillery boolean|nil

---@class AsteroidCollectorGraphicsSet
---@field animation Animation4Way|nil
---@field status_lamp_picture_on RotatedSprite|nil
---@field status_lamp_picture_full RotatedSprite|nil
---@field status_lamp_picture_off RotatedSprite|nil
---@field below_arm_pictures RotatedSprite|nil
---@field below_ground_pictures RotatedSprite|nil
---@field arm_head_animation RotatedAnimation|nil
---@field arm_head_top_animation RotatedAnimation|nil
---@field arm_link RotatedSprite|nil
---@field water_reflection WaterReflectionDefinition|nil

---@class AsteroidGraphicsSet
---@field rotation_speed number|nil
---@field normal_strength number|nil
---@field light_width number|nil
---@field brightness number|nil
---@field specular_strength number|nil
---@field specular_power number|nil
---@field specular_purity number|nil
---@field sss_contrast number|nil
---@field sss_amount number|nil
---@field sprite Sprite|nil
---@field variations AsteroidVariation|AsteroidVariation[]|nil
---@field lights LightProperties|LightProperties[]|nil
---@field ambient_light Color|nil
---@field water_reflection WaterReflectionDefinition|nil

---@class AsteroidSettings
---@field spawning_rate number
---@field max_ray_portals_expanded_per_tick integer

---@class AsteroidSpawnPoint
---@field probability number
---@field speed number
---@field angle_when_stopped number|nil

---@class AsteroidVariation
---@field color_texture Sprite
---@field normal_map Sprite
---@field roughness_map Sprite
---@field shadow_shift Vector|nil

---@class Attenuation
---@field curve_type AttenuationType
---@field tuning_parameter number|nil

---@alias AttenuationType "none"|"linear"|"logarithmic"|"exponential"|"cosine"|"S-curve"

---@alias AutoplaceControlID string

---@class BaseAttackParameters
---@field range number
---@field cooldown number
---@field min_range number|nil
---@field turn_range number|nil
---@field fire_penalty number|nil
---@field rotate_penalty number|nil
---@field health_penalty number|nil
---@field range_mode RangeMode|nil
---@field min_attack_distance number|nil
---@field damage_modifier number|nil
---@field ammo_consumption_modifier number|nil
---@field cooldown_deviation number|nil
---@field warmup integer|nil
---@field lead_target_for_projectile_speed number|nil
---@field lead_target_for_projectile_delay integer|nil
---@field movement_slow_down_cooldown number|nil
---@field movement_slow_down_factor number|nil
---@field ammo_type AmmoType|nil
---@field activation_type "shoot"|"throw"|"consume"|"activate"|nil
---@field sound LayeredSound|nil
---@field animation RotatedAnimation|nil
---@field cyclic_sound CyclicSound|nil
---@field use_shooter_direction boolean|nil
---@field ammo_categories AmmoCategoryID[]|nil
---@field ammo_category AmmoCategoryID|nil
---@field true_collinear_ejection boolean|nil

---@class BaseEnergySource
---@field emissions_per_minute table<AirbornePollutantID, number>|nil
---@field render_no_power_icon boolean|nil
---@field render_no_network_icon boolean|nil

---@class BaseModifier
---@field icons IconData[]|nil
---@field icon FileName|nil
---@field icon_size SpriteSizeType|nil
---@field hidden boolean|nil

---@class BaseStyleSpecification
---@field parent string|nil
---@field horizontal_align HorizontalAlign|nil
---@field vertical_align VerticalAlign|nil
---@field ignored_by_search boolean|nil
---@field never_hide_by_search boolean|nil
---@field horizontally_stretchable StretchRule|nil
---@field vertically_stretchable StretchRule|nil
---@field horizontally_squashable StretchRule|nil
---@field vertically_squashable StretchRule|nil
---@field natural_size integer|table|nil
---@field size integer|table|nil
---@field width integer|nil
---@field minimal_width integer|nil
---@field maximal_width integer|nil
---@field natural_width integer|nil
---@field height integer|nil
---@field minimal_height integer|nil
---@field maximal_height integer|nil
---@field natural_height integer|nil
---@field padding integer|nil
---@field top_padding integer|nil
---@field right_padding integer|nil
---@field bottom_padding integer|nil
---@field left_padding integer|nil
---@field margin integer|nil
---@field top_margin integer|nil
---@field right_margin integer|nil
---@field bottom_margin integer|nil
---@field left_margin integer|nil
---@field effect "compilatron-hologram"|nil
---@field effect_opacity number|nil
---@field tooltip LocalisedString|nil

---@class BeaconDistributionModifier: SimpleModifier
---@field type "beacon-distribution"
---@field infer_icon boolean|nil
---@field use_icon_overlay_constant boolean|nil

---@class BeaconGraphicsSet
---@field draw_animation_when_idle boolean|nil
---@field draw_light_when_idle boolean|nil
---@field random_animation_offset boolean|nil
---@field module_icons_suppressed boolean|nil
---@field reset_animation_when_frozen boolean|nil
---@field base_layer RenderLayer|nil
---@field animation_layer RenderLayer|nil
---@field top_layer RenderLayer|nil
---@field animation_progress number|nil
---@field apply_module_tint ModuleTint|nil
---@field no_modules_tint Color|nil
---@field animation_list AnimationElement[]|nil
---@field frozen_patch Sprite|nil
---@field light LightDefinition|nil
---@field module_visualisations BeaconModuleVisualizations[]|nil
---@field module_tint_mode "single-module"|"mix"|nil
---@field water_reflection WaterReflectionDefinition|nil

---@class BeaconModuleVisualization
---@field has_empty_slot boolean|nil
---@field secondary_draw_order integer|nil
---@field apply_module_tint ModuleTint|nil
---@field render_layer RenderLayer|nil
---@field pictures SpriteVariations|nil

---@class BeaconModuleVisualizations
---@field art_style string
---@field use_for_empty_slots boolean|nil
---@field tier_offset integer|nil
---@field slots BeaconModuleVisualization[][]|nil

---@class BeaconVisualizationTints
---@field primary Color|nil
---@field secondary Color|nil
---@field tertiary Color|nil
---@field quaternary Color|nil

---@class BeamAnimationSet
---@field start Animation|nil
---@field ending Animation|nil
---@field head Animation|nil
---@field tail Animation|nil
---@field body AnimationVariations|nil
---@field render_layer RenderLayer|nil

---@class BeamAttackParameters: BaseAttackParameters
---@field type "beam"
---@field source_direction_count integer|nil
---@field source_offset Vector|nil

---@class BeamGraphicsSet
---@field beam BeamAnimationSet|nil
---@field ground BeamAnimationSet|nil
---@field desired_segment_length number|nil
---@field random_end_animation_rotation boolean|nil
---@field transparent_start_end_animations boolean|nil
---@field randomize_animation_per_segment boolean|nil
---@field water_reflection WaterReflectionDefinition|nil

---@class BeamTriggerDelivery: TriggerDeliveryItem
---@field type "beam"
---@field beam EntityID
---@field add_to_shooter boolean|nil
---@field max_length integer|nil
---@field duration integer|nil
---@field source_offset Vector|nil
---@field destroy_with_source_or_target boolean|nil

---@class BeltReaderLayer
---@field render_layer RenderLayer|nil
---@field sprites RotatedAnimation

---@class BeltStackSizeBonusModifier: SimpleModifier
---@field type "belt-stack-size-bonus"
---@field use_icon_overlay_constant boolean|nil

---@class BeltTraverseTipTrigger: CountBasedTipTrigger
---@field type "belt-traverse"

---@alias BlendMode "normal"|"additive"|"additive-soft"|"multiplicative"|"multiplicative-with-alpha"|"overwrite"

---@class BoilerPictureSet
---@field north BoilerPictures
---@field east BoilerPictures
---@field south BoilerPictures
---@field west BoilerPictures

---@class BoilerPictures
---@field structure Animation
---@field patch Sprite|nil
---@field fire Animation|nil
---@field fire_glow Animation|nil

---@class BonusGuiOrdering
---@field artillery_range Order
---@field worker_robots Order
---@field character Order
---@field follower_robots Order
---@field research_speed Order
---@field beacon_distribution Order
---@field inserter Order
---@field stack_inserter Order
---@field bulk_inserter Order
---@field turret_attack Order
---@field mining_productivity Order
---@field train_braking_force Order

---@class BoolModifier: BaseModifier
---@field modifier boolean

---@class BorderImageSet
---@field scale number|nil
---@field border_width integer|nil
---@field vertical_line Sprite|nil
---@field horizontal_line Sprite|nil
---@field top_right_corner Sprite|nil
---@field bottom_right_corner Sprite|nil
---@field bottom_left_corner Sprite|nil
---@field top_left_coner Sprite|nil
---@field top_t Sprite|nil
---@field right_t Sprite|nil
---@field bottom_t Sprite|nil
---@field left_t Sprite|nil
---@field cross Sprite|nil
---@field top_end Sprite|nil
---@field right_end Sprite|nil
---@field bottom_end Sprite|nil
---@field left_end Sprite|nil

---@class BoxSpecification
---@field sprite Sprite
---@field is_whole_box boolean|nil
---@field side_length number|nil
---@field side_height number|nil
---@field max_side_length number|nil

---@class BuildEntityByRobotTipTrigger: CountBasedTipTrigger
---@field type "build-entity-by-robot"

---@class BuildEntityTechnologyTrigger
---@field type "build-entity"
---@field entity EntityIDFilter

---@class BuildEntityTipTrigger: CountBasedTipTrigger
---@field type "build-entity"
---@field entity EntityID|nil
---@field match_type_only boolean|nil
---@field build_by_dragging boolean|nil
---@field consecutive boolean|nil
---@field linear_power_pole_line boolean|nil
---@field build_in_line boolean|nil
---@field quality QualityID|nil

---@alias BuildMode "normal"|"forced"|"superforced"

---@class BulkInserterCapacityBonusModifier: SimpleModifier
---@field type "bulk-inserter-capacity-bonus"
---@field infer_icon boolean|nil
---@field use_icon_overlay_constant boolean|nil

---@class BurnerEnergySource: BaseEnergySource
---@field type "burner"
---@field fuel_inventory_size ItemStackIndex
---@field burnt_inventory_size ItemStackIndex|nil
---@field smoke SmokeSource[]|nil
---@field light_flicker LightFlickeringDefinition|nil
---@field effectivity number|nil
---@field burner_usage BurnerUsageID|nil
---@field fuel_categories FuelCategoryID[]|nil
---@field initial_fuel ItemID|nil
---@field initial_fuel_percent number|nil

---@alias BurnerUsageID string

---@class ButtonStyleSpecification: StyleWithClickableGraphicalSetSpecification
---@field type "button_style"
---@field font string|nil
---@field default_font_color Color|nil
---@field hovered_font_color Color|nil
---@field clicked_font_color Color|nil
---@field disabled_font_color Color|nil
---@field selected_font_color Color|nil
---@field selected_hovered_font_color Color|nil
---@field selected_clicked_font_color Color|nil
---@field strikethrough_color Color|nil
---@field pie_progress_color Color|nil
---@field clicked_vertical_offset integer|nil
---@field draw_shadow_under_picture boolean|nil
---@field draw_grayscale_picture boolean|nil
---@field invert_colors_of_picture_when_hovered_or_toggled boolean|nil
---@field invert_colors_of_picture_when_disabled boolean|nil
---@field icon_horizontal_align HorizontalAlign|nil

---@class CameraEffectTriggerEffectItem: TriggerEffectItem
---@field type "camera-effect"
---@field duration integer
---@field ease_in_duration integer|nil
---@field ease_out_duration integer|nil
---@field delay integer|nil
---@field full_strength_max_distance integer|nil
---@field max_distance integer|nil
---@field strength number|nil

---@class CameraStyleSpecification: EmptyWidgetStyleSpecification
---@field type "camera_style"

---@class CaptureSpawnerTechnologyTrigger
---@field type "capture-spawner"
---@field entity EntityID|nil

---@class CargoBayConnectableGraphicsSet
---@field picture LayeredSprite|nil
---@field animation Animation|nil
---@field animation_render_layer RenderLayer|nil
---@field connections CargoBayConnections|nil
---@field water_reflection WaterReflectionDefinition|nil

---@class CargoBayConnections
---@field top_wall LayeredSpriteVariations|nil
---@field right_wall LayeredSpriteVariations|nil
---@field bottom_wall LayeredSpriteVariations|nil
---@field left_wall LayeredSpriteVariations|nil
---@field top_left_outer_corner LayeredSpriteVariations|nil
---@field top_right_outer_corner LayeredSpriteVariations|nil
---@field bottom_left_outer_corner LayeredSpriteVariations|nil
---@field bottom_right_outer_corner LayeredSpriteVariations|nil
---@field top_left_inner_corner LayeredSpriteVariations|nil
---@field top_right_inner_corner LayeredSpriteVariations|nil
---@field bottom_left_inner_corner LayeredSpriteVariations|nil
---@field bottom_right_inner_corner LayeredSpriteVariations|nil
---@field bridge_horizontal_narrow LayeredSpriteVariations|nil
---@field bridge_horizontal_wide LayeredSpriteVariations|nil
---@field bridge_vertical_narrow LayeredSpriteVariations|nil
---@field bridge_vertical_wide LayeredSpriteVariations|nil
---@field bridge_crossing LayeredSpriteVariations|nil

---@class CargoHatchDefinition
---@field hatch_graphics Animation|nil
---@field hatch_render_layer RenderLayer|nil
---@field entering_render_layer RenderLayer|nil
---@field offset Vector|nil
---@field pod_shadow_offset Vector|nil
---@field sky_slice_height number|nil
---@field slice_height number|nil
---@field travel_height number|nil
---@field busy_timeout_ticks integer|nil
---@field hatch_opening_ticks integer|nil
---@field opening_sound InterruptibleSound|nil
---@field closing_sound InterruptibleSound|nil
---@field cargo_unit_entity_to_spawn EntityID|nil
---@field illumination_graphic_index integer|nil
---@field receiving_cargo_units EntityID[]|nil

---@class CargoLandingPadLimitModifier: SimpleModifier
---@field type "cargo-landing-pad-count"
---@field use_icon_overlay_constant boolean|nil

---@class CargoStationParameters
---@field prefer_packed_cargo_units boolean|nil
---@field hatch_definitions CargoHatchDefinition[]|nil
---@field giga_hatch_definitions GigaCargoHatchDefinition[]|nil
---@field is_input_station boolean|nil
---@field is_output_station boolean|nil

---@class ChainTriggerDelivery: TriggerDeliveryItem
---@field type "chain"
---@field chain ActiveTriggerID

---@class ChangeRecipeProductivityModifier: BaseModifier
---@field type "change-recipe-productivity"
---@field use_icon_overlay_constant boolean|nil
---@field recipe RecipeID
---@field change EffectValue

---@class ChangeSurfaceTipTrigger: CountBasedTipTrigger
---@field type "change-surface"
---@field surface string

---@class CharacterArmorAnimation
---@field idle RotatedAnimation|nil
---@field idle_with_gun RotatedAnimation
---@field running RotatedAnimation|nil
---@field running_with_gun RotatedAnimation
---@field mining_with_tool RotatedAnimation
---@field flipped_shadow_running_with_gun RotatedAnimation|nil
---@field idle_in_air RotatedAnimation|nil
---@field idle_with_gun_in_air RotatedAnimation|nil
---@field flying RotatedAnimation|nil
---@field flying_with_gun RotatedAnimation|nil
---@field take_off RotatedAnimation|nil
---@field landing RotatedAnimation|nil
---@field armors ItemID[]|nil
---@field smoke_in_air SmokeSource[]|nil
---@field smoke_cycles_per_tick number|nil
---@field extra_smoke_cycles_per_tile number|nil
---@field mining_with_tool_particles_animation_positions number[]|nil

---@class CharacterBuildDistanceModifier: SimpleModifier
---@field type "character-build-distance"
---@field use_icon_overlay_constant boolean|nil

---@class CharacterCraftingSpeedModifier: SimpleModifier
---@field type "character-crafting-speed"
---@field use_icon_overlay_constant boolean|nil

---@class CharacterHealthBonusModifier: SimpleModifier
---@field type "character-health-bonus"
---@field use_icon_overlay_constant boolean|nil

---@class CharacterInventorySlotsBonusModifier: SimpleModifier
---@field type "character-inventory-slots-bonus"
---@field use_icon_overlay_constant boolean|nil

---@class CharacterItemDropDistanceModifier: SimpleModifier
---@field type "character-item-drop-distance"
---@field use_icon_overlay_constant boolean|nil

---@class CharacterItemPickupDistanceModifier: SimpleModifier
---@field type "character-item-pickup-distance"
---@field use_icon_overlay_constant boolean|nil

---@class CharacterLogisticRequestsModifier: BoolModifier
---@field type "character-logistic-requests"
---@field use_icon_overlay_constant boolean|nil

---@class CharacterLogisticTrashSlotsModifier: SimpleModifier
---@field type "character-logistic-trash-slots"
---@field use_icon_overlay_constant boolean|nil

---@class CharacterLootPickupDistanceModifier: SimpleModifier
---@field type "character-loot-pickup-distance"
---@field use_icon_overlay_constant boolean|nil

---@class CharacterMiningSpeedModifier: SimpleModifier
---@field type "character-mining-speed"
---@field use_icon_overlay_constant boolean|nil

---@class CharacterReachDistanceModifier: SimpleModifier
---@field type "character-reach-distance"
---@field use_icon_overlay_constant boolean|nil

---@class CharacterResourceReachDistanceModifier: SimpleModifier
---@field type "character-resource-reach-distance"
---@field use_icon_overlay_constant boolean|nil

---@class CharacterRunningSpeedModifier: SimpleModifier
---@field type "character-running-speed"
---@field use_icon_overlay_constant boolean|nil

---@class ChargableGraphics
---@field picture Sprite|nil
---@field charge_animation Animation|nil
---@field charge_animation_is_looped boolean|nil
---@field charge_light LightDefinition|nil
---@field charge_cooldown integer|nil
---@field discharge_animation Animation|nil
---@field discharge_light LightDefinition|nil
---@field discharge_cooldown integer|nil

---@class ChartUtilityConstants
---@field copper_wire_color Color
---@field electric_power_pole_color Color
---@field enabled_switch_color Color
---@field disabled_switch_color Color
---@field electric_line_width number
---@field electric_line_minimum_absolute_width number
---@field red_wire_color Color
---@field green_wire_color Color
---@field circuit_network_member_color Color
---@field turret_range_color Color
---@field artillery_range_color Color
---@field default_friendly_color Color
---@field default_enemy_color Color
---@field default_enemy_territory_color Color
---@field rail_color Color
---@field elevated_rail_color Color
---@field rail_ramp_color Color
---@field entity_ghost_color Color
---@field tile_ghost_color Color
---@field vehicle_outer_color Color
---@field vehicle_outer_color_selected Color
---@field vehicle_inner_color Color
---@field vehicle_wagon_connection_color Color
---@field resource_outline_selection_color Color
---@field chart_train_stop_text_color Color
---@field chart_train_stop_disabled_text_color Color
---@field chart_train_stop_full_text_color Color
---@field red_signal_color Color
---@field green_signal_color Color
---@field blue_signal_color Color
---@field yellow_signal_color Color
---@field chart_deconstruct_tint Color
---@field chart_deconstruct_active_color Color
---@field default_friendly_color_by_type table<string, Color>|nil
---@field default_color_by_type table<string, Color>|nil
---@field explosion_visualization_duration integer
---@field train_path_color Color
---@field train_preview_path_outline_color Color
---@field train_current_path_outline_color Color
---@field chart_logistic_robot_color Color
---@field chart_construction_robot_color Color
---@field chart_mobile_construction_robot_color Color
---@field chart_personal_construction_robot_color Color
---@field chart_delivery_to_me_logistic_robot_color Color
---@field zoom_threshold_to_draw_spider_path number
---@field chart_player_circle_size number
---@field custom_tag_scale number|nil
---@field custom_tag_max_scale number|nil
---@field custom_tag_selected_overlay_tint Color|nil
---@field recipe_icon_scale number

---@class CheckBoxStyleSpecification: StyleWithClickableGraphicalSetSpecification
---@field type "checkbox_style"
---@field font string|nil
---@field font_color Color|nil
---@field disabled_font_color Color|nil
---@field checkmark Sprite|nil
---@field disabled_checkmark Sprite|nil
---@field intermediate_mark Sprite|nil
---@field text_padding integer|nil

---@class CircuitConditionConnector
---@field first SignalIDConnector|nil
---@field comparator ComparatorString|nil
---@field second SignalIDConnector|integer|nil

---@class CircuitConnectorDefinition
---@field sprites CircuitConnectorSprites|nil
---@field points WireConnectionPoint|nil

---@class CircuitConnectorLayer
---@field north RenderLayer|nil
---@field east RenderLayer|nil
---@field south RenderLayer|nil
---@field west RenderLayer|nil

---@class CircuitConnectorSecondaryDrawOrder
---@field north integer|nil
---@field east integer|nil
---@field south integer|nil
---@field west integer|nil

---@class CircuitConnectorSprites
---@field led_red Sprite
---@field led_green Sprite
---@field led_blue Sprite
---@field led_light LightDefinition
---@field connector_main Sprite|nil
---@field connector_shadow Sprite|nil
---@field wire_pins Sprite|nil
---@field wire_pins_shadow Sprite|nil
---@field led_blue_off Sprite|nil
---@field blue_led_light_offset Vector|nil
---@field red_green_led_light_offset Vector|nil

---@class CircuitNetworkModifier: BoolModifier
---@field type "unlock-circuit-network"
---@field use_icon_overlay_constant boolean|nil

---@class ClearCursorTipTrigger: CountBasedTipTrigger
---@field type "clear-cursor"

---@class CliffDeconstructionEnabledModifier: BoolModifier
---@field type "cliff-deconstruction-enabled"
---@field use_icon_overlay_constant boolean|nil

---@alias CloudEffectStyle "none"|"euclidean"|"manhattan"|"euclidean-outside"|"manhattan-outside"|"horizontal-stripe"|"texture"|"texture-outside"

---@class CloudsEffectProperties
---@field shape_noise_texture EffectTexture
---@field detail_noise_texture EffectTexture
---@field warp_sample_1 CloudsTextureCoordinateTransformation
---@field warp_sample_2 CloudsTextureCoordinateTransformation
---@field warped_shape_sample CloudsTextureCoordinateTransformation
---@field additional_density_sample CloudsTextureCoordinateTransformation
---@field detail_sample_1 CloudsTextureCoordinateTransformation
---@field detail_sample_2 CloudsTextureCoordinateTransformation
---@field scale number|nil
---@field movement_speed_multiplier number|nil
---@field shape_warp_strength number|nil
---@field shape_warp_weight number|nil
---@field opacity number|nil
---@field opacity_at_night number|nil
---@field density number|nil
---@field density_at_night number|nil
---@field detail_factor number|nil
---@field detail_factor_at_night number|nil
---@field shape_factor number|nil
---@field detail_exponent number|nil
---@field detail_sample_morph_duration integer|nil

---@class CloudsTextureCoordinateTransformation
---@field scale number
---@field wind_speed_factor number|nil

---@class ClusterTriggerItem: TriggerItem
---@field type "cluster"
---@field cluster_count integer
---@field distance number
---@field distance_deviation number|nil

---@class CollisionMaskConnector
---@field layers table<CollisionLayerID, true>
---@field not_colliding_with_itself boolean|nil
---@field consider_tile_transitions boolean|nil
---@field colliding_with_tiles_only boolean|nil

---@class ColorFilterData
---@field name string
---@field localised_name LocalisedString
---@field matrix number[][]

---@class ColorHintSpecification
---@field text string|nil
---@field text_color Color|nil

---@alias ColorLookupTable FileName|"identity"

---@class ColumnAlignment
---@field column integer
---@field alignment Alignment

---@class ColumnWidth: ColumnWidthItem
---@field column integer

---@class ColumnWidthItem
---@field minimal_width integer|nil
---@field maximal_width integer|nil
---@field width integer|nil

---@class ConnectableEntityGraphics
---@field single SpriteVariations
---@field straight_vertical SpriteVariations
---@field straight_horizontal SpriteVariations
---@field corner_right_down SpriteVariations
---@field corner_left_down SpriteVariations
---@field corner_right_up SpriteVariations
---@field corner_left_up SpriteVariations
---@field t_up SpriteVariations
---@field t_right SpriteVariations
---@field t_down SpriteVariations
---@field t_left SpriteVariations
---@field ending_up SpriteVariations
---@field ending_right SpriteVariations
---@field ending_down SpriteVariations
---@field ending_left SpriteVariations
---@field cross SpriteVariations

---@alias ConsumingType "none"|"game-only"

---@class ControlPoint
---@field control number
---@field volume_percentage number

---@class CountBasedTipTrigger
---@field count integer|nil

---@class CoverGraphicEffectData
---@field style CloudEffectStyle|nil
---@field relative_to EffectRelativeTo|nil
---@field distance_traveled_strength Vector|nil
---@field pod_movement_strength Vector|nil

---@class CoverGraphicProcessionLayer
---@field type "cover-graphic"
---@field reference_group ProcessionLayerInheritanceGroupID|nil
---@field inherit_from ProcessionLayerInheritanceGroupID|nil
---@field graphic ProcessionGraphic|nil
---@field mask_graphic ProcessionGraphic|nil
---@field effect_graphic ProcessionGraphic|nil
---@field render_layer RenderLayer|nil
---@field secondary_draw_order integer|nil
---@field is_cloud_effect_advanced boolean|nil
---@field is_quad_texture boolean|nil
---@field rotate_with_pod boolean|nil
---@field texture_relative_to EffectRelativeTo|nil
---@field distance_traveled_strength Vector|nil
---@field pod_movement_strength Vector|nil
---@field world_size Vector|nil
---@field effect CoverGraphicEffectData|nil
---@field alt_effect CoverGraphicEffectData|nil
---@field frames CoverGraphicProcessionLayerBezierControlPoint[]

---@class CoverGraphicProcessionLayerBezierControlPoint
---@field timestamp integer|nil
---@field opacity number|nil
---@field opacity_t number|nil
---@field rotation number|nil
---@field rotation_t number|nil
---@field effect_scale_min number|nil
---@field effect_scale_min_t number|nil
---@field effect_scale_max number|nil
---@field effect_scale_max_t number|nil
---@field alt_effect_scale_min number|nil
---@field alt_effect_scale_min_t number|nil
---@field alt_effect_scale_max number|nil
---@field alt_effect_scale_max_t number|nil
---@field effect_shift Vector|nil
---@field effect_shift_t Vector|nil
---@field effect_shift_rate number|nil
---@field effect_shift_rate_t number|nil
---@field alt_effect_shift Vector|nil
---@field alt_effect_shift_t Vector|nil
---@field alt_effect_shift_rate number|nil
---@field alt_effect_shift_rate_t number|nil
---@field offset Vector|nil
---@field offset_t Vector|nil
---@field offset_rate number|nil
---@field offset_rate_t number|nil

---@class CraftFluidTechnologyTrigger
---@field type "craft-fluid"
---@field fluid FluidID
---@field amount number|nil

---@class CraftItemTechnologyTrigger
---@field type "craft-item"
---@field item ItemIDFilter
---@field count ItemCountType|nil

---@class CraftItemTipTrigger: CountBasedTipTrigger
---@field type "craft-item"
---@field item ItemID|nil
---@field event_type "crafting-of-single-item-ordered"|"crafting-of-multiple-items-ordered"|"crafting-finished"
---@field consecutive boolean|nil

---@class CraftingMachineGraphicsSet: WorkingVisualisations
---@field frozen_patch Sprite4Way|nil
---@field circuit_connector_layer RenderLayer|CircuitConnectorLayer|nil
---@field circuit_connector_secondary_draw_order integer|CircuitConnectorSecondaryDrawOrder|nil
---@field animation_progress number|nil
---@field reset_animation_when_frozen boolean|nil
---@field water_reflection WaterReflectionDefinition|nil

---@class CranePart
---@field orientation_shift number|nil
---@field is_contractible_by_cropping boolean|nil
---@field should_scale_for_perspective boolean|nil
---@field scale_to_fit_model boolean|nil
---@field allow_sprite_rotation boolean|nil
---@field snap_start number|nil
---@field snap_end number|nil
---@field snap_end_arm_extent_multiplier number|nil
---@field name string|nil
---@field dying_effect CranePartDyingEffect|nil
---@field relative_position Vector3D|nil
---@field relative_position_grappler Vector3D|nil
---@field static_length Vector3D|nil
---@field extendable_length Vector3D|nil
---@field static_length_grappler Vector3D|nil
---@field extendable_length_grappler Vector3D|nil
---@field sprite Sprite|nil
---@field rotated_sprite RotatedSprite|nil
---@field sprite_shadow Sprite|nil
---@field rotated_sprite_shadow RotatedSprite|nil
---@field sprite_reflection Sprite|nil
---@field rotated_sprite_reflection RotatedSprite|nil
---@field layer integer|nil

---@class CranePartDyingEffect
---@field particle_effect_linear_distance_step number|nil
---@field explosion_linear_distance_step number|nil
---@field particle_effects CreateParticleTriggerEffectItem|CreateParticleTriggerEffectItem[]|nil
---@field explosion ExplosionDefinition|nil

---@class CraterPlacementDefinition
---@field minimum_segments_to_place integer|nil
---@field segment_probability number|nil
---@field segments CraterSegment[]

---@class CraterSegment
---@field orientation number
---@field offset Vector

---@class CreateAsteroidChunkEffectItem: TriggerEffectItem
---@field type "create-asteroid-chunk"
---@field asteroid_name AsteroidChunkID
---@field offset_deviation BoundingBox|nil
---@field offsets Vector[]|nil

---@class CreateDecorativesTriggerEffectItem: TriggerEffectItem
---@field type "create-decorative"
---@field decorative DecorativeID
---@field spawn_max integer
---@field spawn_min_radius number
---@field spawn_max_radius number
---@field spawn_min integer|nil
---@field radius_curve number|nil
---@field apply_projection boolean|nil
---@field spread_evenly boolean|nil

---@class CreateEntityTriggerEffectItem: TriggerEffectItem
---@field type "create-entity"
---@field entity_name EntityID
---@field offset_deviation BoundingBox|nil
---@field trigger_created_entity boolean|nil
---@field check_buildability boolean|nil
---@field show_in_tooltip boolean|nil
---@field only_when_visible boolean|nil
---@field tile_collision_mask CollisionMaskConnector|nil
---@field offsets Vector[]|nil
---@field as_enemy boolean|nil
---@field ignore_no_enemies_mode boolean|nil
---@field find_non_colliding_position boolean|nil
---@field abort_if_over_space boolean|nil
---@field non_colliding_search_radius number|nil
---@field non_colliding_search_precision number|nil
---@field non_colliding_fail_result Trigger|nil
---@field protected boolean|nil

---@class CreateExplosionTriggerEffectItem: CreateEntityTriggerEffectItem
---@field type "create-explosion"
---@field max_movement_distance number|nil
---@field max_movement_distance_deviation number|nil
---@field inherit_movement_distance_from_projectile boolean|nil
---@field cycle_while_moving boolean|nil

---@class CreateFireTriggerEffectItem: CreateEntityTriggerEffectItem
---@field type "create-fire"
---@field initial_ground_flame_count integer|nil

---@class CreateGhostOnEntityDeathModifier: BoolModifier
---@field type "create-ghost-on-entity-death"
---@field use_icon_overlay_constant boolean|nil

---@class CreateParticleTriggerEffectItem: TriggerEffectItem
---@field type "create-particle"
---@field particle_name ParticleID
---@field initial_height number
---@field offset_deviation SimpleBoundingBox|nil
---@field show_in_tooltip boolean|nil
---@field tile_collision_mask CollisionMaskConnector|nil
---@field offsets Vector[]|nil
---@field initial_height_deviation number|nil
---@field initial_vertical_speed number|nil
---@field initial_vertical_speed_deviation number|nil
---@field speed_from_center number|nil
---@field speed_from_center_deviation number|nil
---@field frame_speed number|nil
---@field frame_speed_deviation number|nil
---@field movement_multiplier number|nil
---@field tail_length integer|nil
---@field tail_length_deviation integer|nil
---@field tail_width number|nil
---@field rotate_offsets boolean|nil
---@field only_when_visible boolean|nil
---@field apply_tile_tint "primary"|"secondary"|nil
---@field tint Color|nil

---@class CreateSmokeTriggerEffectItem: CreateEntityTriggerEffectItem
---@field type "create-smoke"
---@field initial_height number|nil
---@field speed Vector|nil
---@field speed_multiplier number|nil
---@field speed_multiplier_deviation number|nil
---@field starting_frame number|nil
---@field starting_frame_deviation number|nil
---@field speed_from_center number|nil
---@field speed_from_center_deviation number|nil

---@class CreateSpacePlatformTechnologyTrigger
---@field type "create-space-platform"

---@class CreateStickerTriggerEffectItem: TriggerEffectItem
---@field type "create-sticker"
---@field sticker EntityID
---@field show_in_tooltip boolean|nil
---@field trigger_created_entity boolean|nil

---@class CreateTrivialSmokeEffectItem: TriggerEffectItem
---@field type "create-trivial-smoke"
---@field smoke_name TrivialSmokeID
---@field offset_deviation BoundingBox|nil
---@field offsets Vector[]|nil
---@field initial_height number|nil
---@field max_radius number|nil
---@field speed Vector|nil
---@field speed_multiplier number|nil
---@field speed_multiplier_deviation number|nil
---@field starting_frame number|nil
---@field starting_frame_deviation number|nil
---@field speed_from_center number|nil
---@field speed_from_center_deviation number|nil
---@field only_when_visible boolean|nil

---@class CursorBoxSpecification
---@field regular BoxSpecification[]
---@field multiplayer_selection BoxSpecification[]
---@field not_allowed BoxSpecification[]
---@field copy BoxSpecification[]
---@field electricity BoxSpecification[]
---@field logistics BoxSpecification[]
---@field pair BoxSpecification[]
---@field train_visualization BoxSpecification[]
---@field blueprint_snap_rectangle BoxSpecification[]
---@field spidertron_remote_selected BoxSpecification[]
---@field spidertron_remote_to_be_selected BoxSpecification[]

---@alias CursorBoxType "entity"|"multiplayer-entity"|"electricity"|"copy"|"not-allowed"|"pair"|"logistics"|"train-visualization"|"blueprint-snap-rectangle"|"spidertron-remote-selected"|"spidertron-remote-to-be-selected"

---@class CyclicSound
---@field begin_sound Sound|nil
---@field middle_sound Sound|nil
---@field end_sound Sound|nil

---@class DamageEntityTriggerEffectItem: TriggerEffectItem
---@field type "damage"
---@field damage DamageParameters
---@field apply_damage_to_trees boolean|nil
---@field vaporize boolean|nil
---@field use_substitute boolean|nil
---@field lower_distance_threshold integer|nil
---@field upper_distance_threshold integer|nil
---@field lower_damage_modifier number|nil
---@field upper_damage_modifier number|nil

---@class DamageParameters
---@field amount number
---@field type DamageTypeID

---@class DamageTileTriggerEffectItem: TriggerEffectItem
---@field type "damage-tile"
---@field damage DamageParameters
---@field radius number|nil

---@class Data
---@field raw table<string, table<string, AnyPrototype>>
---@field extend DataExtendMethod
---@field is_demo boolean

---@alias DataExtendMethod any

---@alias DaytimeColorLookupTable table[]

---@class DeconstructionTimeToLiveModifier: SimpleModifier
---@field type "deconstruction-time-to-live"
---@field use_icon_overlay_constant boolean|nil

---@class DelayedTriggerDelivery: TriggerDeliveryItem
---@field type "delayed"
---@field delayed_trigger ActiveTriggerID

---@class DependenciesMetTipTrigger
---@field type "dependencies-met"

---@class DestroyCliffsCapsuleAction
---@field type "destroy-cliffs"
---@field attack_parameters AttackParameters
---@field radius number
---@field timeout integer|nil
---@field play_sound_on_failure boolean|nil
---@field uses_stack boolean|nil

---@class DestroyCliffsTriggerEffectItem: TriggerEffectItem
---@field type "destroy-cliffs"
---@field radius number
---@field explosion_at_trigger EntityID|nil
---@field explosion_at_cliff EntityID|nil

---@class DestroyDecorativesTriggerEffectItem: TriggerEffectItem
---@field type "destroy-decoratives"
---@field radius number
---@field from_render_layer RenderLayer|nil
---@field to_render_layer RenderLayer|nil
---@field include_soft_decoratives boolean|nil
---@field include_decals boolean|nil
---@field invoke_decorative_trigger boolean|nil
---@field decoratives_with_trigger_only boolean|nil

---@class DirectTriggerItem: TriggerItem
---@field type "direct"
---@field filter_enabled boolean|nil

---@class DirectionShift
---@field north Vector|nil
---@field east Vector|nil
---@field south Vector|nil
---@field west Vector|nil

---@alias DirectionString "north"|"north_north_east"|"north_east"|"east_north_east"|"east"|"east_south_east"|"south_east"|"south_south_east"|"south"|"south_south_west"|"south_west"|"west_south_west"|"west"|"west_north_west"|"north_west"|"north_north_west"

---@class DoubleSliderStyleSpecification: SliderStyleSpecification
---@field type "double_slider_style"

---@class DropDownStyleSpecification: BaseStyleSpecification
---@field type "dropdown_style"
---@field button_style ButtonStyleSpecification|nil
---@field icon Sprite|nil
---@field list_box_style ListBoxStyleSpecification|nil
---@field selector_and_title_spacing integer|nil
---@field opened_sound Sound|nil

---@class DropItemTipTrigger: CountBasedTipTrigger
---@field type "drop-item"
---@field drop_into_entity boolean|nil

---@class Effect
---@field consumption EffectValue|nil
---@field speed EffectValue|nil
---@field productivity EffectValue|nil
---@field pollution EffectValue|nil
---@field quality EffectValue|nil

---@alias EffectRelativeTo "ground-origin"|"pod"|"spawn-origin"

---@class EffectTexture: SpriteSource

---@alias EffectTypeLimitation "speed"|"productivity"|"consumption"|"pollution"|"quality"|("speed"|"productivity"|"consumption"|"pollution"|"quality")[]

---@alias EffectValue number

---@alias EffectVariation "lava"|"wetland-water"|"oil"|"water"

---@class ElectricEnergySource: BaseEnergySource
---@field type "electric"
---@field buffer_capacity Energy|nil
---@field usage_priority ElectricUsagePriority
---@field input_flow_limit Energy|nil
---@field output_flow_limit Energy|nil
---@field drain Energy|nil

---@alias ElectricUsagePriority "primary-input"|"primary-output"|"secondary-input"|"secondary-output"|"tertiary"|"solar"|"lamp"

---@class ElementImageSet
---@field base ElementImageSetLayer|nil
---@field shadow ElementImageSetLayer|nil
---@field glow ElementImageSetLayer|nil

---@class ElementImageSetLayer
---@field draw_type "inner"|"outer"|nil
---@field type "none"|"composition"|nil
---@field tint Color|nil
---@field center Sprite|nil
---@field left Sprite|nil
---@field left_top Sprite|nil
---@field left_bottom Sprite|nil
---@field right Sprite|nil
---@field right_top Sprite|nil
---@field right_bottom Sprite|nil
---@field top Sprite|nil
---@field bottom Sprite|nil
---@field corner_size integer|table|nil
---@field filename FileName|nil
---@field position MapPosition|nil
---@field load_in_minimal_mode boolean|nil
---@field top_width SpriteSizeType|nil
---@field bottom_width SpriteSizeType|nil
---@field left_height SpriteSizeType|nil
---@field right_height SpriteSizeType|nil
---@field center_width SpriteSizeType|nil
---@field center_height SpriteSizeType|nil
---@field scale number|nil
---@field top_border integer|nil
---@field right_border integer|nil
---@field bottom_border integer|nil
---@field left_border integer|nil
---@field border integer|nil
---@field stretch_monolith_image_to_size boolean|nil
---@field left_tiling boolean|nil
---@field right_tiling boolean|nil
---@field top_tiling boolean|nil
---@field bottom_tiling boolean|nil
---@field center_tiling_vertical boolean|nil
---@field center_tiling_horizontal boolean|nil
---@field overall_tiling_horizontal_size integer|nil
---@field overall_tiling_horizontal_spacing integer|nil
---@field overall_tiling_horizontal_padding integer|nil
---@field overall_tiling_vertical_size integer|nil
---@field overall_tiling_vertical_spacing integer|nil
---@field overall_tiling_vertical_padding integer|nil
---@field custom_horizontal_tiling_sizes integer[]|nil
---@field opacity number|nil
---@field background_blur boolean|nil
---@field background_blur_sigma number|nil
---@field top_outer_border_shift integer|nil
---@field bottom_outer_border_shift integer|nil
---@field right_outer_border_shift integer|nil
---@field left_outer_border_shift integer|nil

---@class EmptyWidgetStyleSpecification: BaseStyleSpecification
---@field type "empty_widget_style"
---@field graphical_set ElementImageSet|nil

---@class EnemyEvolutionSettings
---@field enabled boolean
---@field time_factor number
---@field destroy_factor number
---@field pollution_factor number

---@class EnemyExpansionSettings
---@field enabled boolean
---@field max_expansion_distance integer
---@field friendly_base_influence_radius integer
---@field enemy_building_influence_radius integer
---@field building_coefficient number
---@field other_base_coefficient number
---@field neighbouring_chunk_coefficient number
---@field neighbouring_base_chunk_coefficient number
---@field max_colliding_tiles_coefficient number
---@field settler_group_min_size integer
---@field settler_group_max_size integer
---@field min_expansion_cooldown integer
---@field max_expansion_cooldown integer

---@class EnemySpawnerAbsorption
---@field absolute number
---@field proportional number

---@class EnemySpawnerGraphicsSet
---@field animations AnimationVariations|nil
---@field underwater_animations AnimationVariations|nil
---@field underwater_layer_offset integer|nil
---@field water_effect_map_animations AnimationVariations|nil
---@field integration SpriteVariations|nil
---@field random_animation_offset boolean|nil
---@field water_reflection WaterReflectionDefinition|nil

---@alias Energy string

---@alias EnergySource ElectricEnergySource|BurnerEnergySource|HeatEnergySource|FluidEnergySource|VoidEnergySource

---@class EnterVehicleTipTrigger: CountBasedTipTrigger
---@field type "enter-vehicle"
---@field vehicle EntityID|nil
---@field match_type_only boolean|nil

---@class EntityBuildAnimationPiece
---@field top Animation
---@field body Animation

---@class EntityBuildAnimations
---@field back_left EntityBuildAnimationPiece
---@field back_right EntityBuildAnimationPiece
---@field front_left EntityBuildAnimationPiece
---@field front_right EntityBuildAnimationPiece

---@class EntityRendererSearchBoxLimits
---@field left integer
---@field top integer
---@field right integer
---@field bottom integer

---@alias EntityStatus "working"|"normal"|"ghost"|"not-plugged-in-electric-network"|"networks-connected"|"networks-disconnected"|"no-ammo"|"waiting-for-target-to-be-built"|"waiting-for-train"|"no-power"|"low-temperature"|"charging"|"discharging"|"fully-charged"|"no-fuel"|"no-food"|"out-of-logistic-network"|"no-recipe"|"no-ingredients"|"no-input-fluid"|"no-research-in-progress"|"no-minable-resources"|"low-input-fluid"|"low-power"|"not-connected-to-rail"|"cant-divide-segments"|"recharging-after-power-outage"|"no-modules-to-transmit"|"disabled-by-control-behavior"|"opened-by-circuit-network"|"closed-by-circuit-network"|"disabled-by-script"|"disabled"|"turned-off-during-daytime"|"fluid-ingredient-shortage"|"item-ingredient-shortage"|"full-output"|"not-enough-space-in-output"|"full-burnt-result-output"|"marked-for-deconstruction"|"missing-required-fluid"|"missing-science-packs"|"waiting-for-source-items"|"waiting-for-space-in-destination"|"preparing-rocket-for-launch"|"waiting-to-launch-rocket"|"waiting-for-space-in-platform-hub"|"launching-rocket"|"thrust-not-required"|"not-enough-thrust"|"on-the-way"|"waiting-in-orbit"|"waiting-for-rocket-to-arrive"|"no-path"|"broken"|"none"|"frozen"|"paused"|"not-connected-to-hub-or-pad"|"computing-navigation"|"no-filter"|"waiting-at-stop"|"destination-stop-full"|"pipeline-overextended"|"no-spot-seedable-by-inputs"|"waiting-for-plants-to-grow"|"recipe-not-researched"

---@class EntityTransferTipTrigger: CountBasedTipTrigger
---@field type "entity-transfer"
---@field transfer "in"|"out"|nil

---@alias EquipmentCategoryID string

---@alias EquipmentGridID string

---@class EquipmentShape
---@field width integer
---@field height integer
---@field type "full"|"manual"
---@field points integer[][]|nil

---@class Fade: Attenuation
---@field from ControlPoint|nil
---@field to ControlPoint|nil

---@class Fades
---@field fade_in Fade|nil
---@field fade_out Fade|nil

---@class FastBeltBendTipTrigger: CountBasedTipTrigger
---@field type "fast-belt-bend"

---@class FastReplaceTipTrigger: CountBasedTipTrigger
---@field type "fast-replace"
---@field source EntityID|nil
---@field target EntityID|nil
---@field match_type_only boolean|nil

---@class FeatureFlags
---@field quality boolean
---@field rail_bridges boolean
---@field space_travel boolean
---@field spoiling boolean
---@field freezing boolean
---@field segmented_units boolean
---@field expansion_shaders boolean

---@alias FileName string

---@class FlipEntityTipTrigger: CountBasedTipTrigger
---@field type "flip-entity"

---@class FlowStyleSpecification: BaseStyleSpecification
---@field type "flow_style"
---@field max_on_row integer|nil
---@field horizontal_spacing integer|nil
---@field vertical_spacing integer|nil

---@class FluidBox
---@field volume FluidAmount
---@field pipe_connections PipeConnectionDefinition[]
---@field filter FluidID|nil
---@field render_layer RenderLayer|nil
---@field draw_only_when_connected boolean|nil
---@field hide_connection_info boolean|nil
---@field volume_reservation_fraction number|nil
---@field pipe_covers Sprite4Way|nil
---@field pipe_covers_frozen Sprite4Way|nil
---@field pipe_picture Sprite4Way|nil
---@field pipe_picture_frozen Sprite4Way|nil
---@field mirrored_pipe_picture Sprite4Way|nil
---@field mirrored_pipe_picture_frozen Sprite4Way|nil
---@field minimum_temperature number|nil
---@field maximum_temperature number|nil
---@field max_pipeline_extent integer|nil
---@field production_type ProductionType|nil
---@field secondary_draw_order integer|nil
---@field secondary_draw_orders FluidBoxSecondaryDrawOrders|nil
---@field always_draw_covers boolean|nil
---@field enable_working_visualisations string[]|nil

---@alias FluidBoxLinkedConnectionID integer

---@class FluidBoxSecondaryDrawOrders
---@field north integer|nil
---@field east integer|nil
---@field south integer|nil
---@field west integer|nil

---@class FluidEnergySource: BaseEnergySource
---@field type "fluid"
---@field fluid_box FluidBox
---@field smoke SmokeSource[]|nil
---@field light_flicker LightFlickeringDefinition|nil
---@field effectivity number|nil
---@field burns_fluid boolean|nil
---@field scale_fluid_usage boolean|nil
---@field destroy_non_fuel_fluid boolean|nil
---@field fluid_usage_per_tick FluidAmount|nil
---@field maximum_temperature number|nil

---@class FluidIngredientPrototype
---@field type "fluid"
---@field name FluidID
---@field amount FluidAmount
---@field temperature number|nil
---@field minimum_temperature number|nil
---@field maximum_temperature number|nil
---@field ignored_by_stats FluidAmount|nil
---@field fluidbox_index integer|nil
---@field fluidbox_multiplier integer|nil

---@class FluidProductPrototype
---@field type "fluid"
---@field name FluidID
---@field amount FluidAmount|nil
---@field amount_min FluidAmount|nil
---@field amount_max FluidAmount|nil
---@field probability number|nil
---@field ignored_by_stats FluidAmount|nil
---@field ignored_by_productivity FluidAmount|nil
---@field temperature number|nil
---@field fluidbox_index integer|nil
---@field show_details_in_recipe_tooltip boolean|nil

---@class FluidWagonConnectorGraphics
---@field load_animations PumpConnectorGraphics
---@field unload_animations PumpConnectorGraphics

---@class FogEffectProperties
---@field fog_type "vulcanus"|"gleba"|nil
---@field shape_noise_texture EffectTexture
---@field detail_noise_texture EffectTexture
---@field color1 Color|nil
---@field color2 Color|nil
---@field tick_factor number|nil

---@class FogMaskShapeDefinition
---@field rect SimpleBoundingBox
---@field falloff number|nil

---@class FollowerRobotLifetimeModifier: SimpleModifier
---@field type "follower-robot-lifetime"
---@field infer_icon boolean|nil
---@field use_icon_overlay_constant boolean|nil

---@class FootprintParticle
---@field tiles TileID[]
---@field particle_name ParticleID|nil
---@field use_as_default boolean|nil

---@class FootstepTriggerEffectItem: CreateParticleTriggerEffectItem
---@field tiles TileID[]
---@field actions CreateParticleTriggerEffectItem[]|nil
---@field use_as_default boolean|nil

---@alias FootstepTriggerEffectList FootstepTriggerEffectItem[]

---@class FrameStyleSpecification: BaseStyleSpecification
---@field type "frame_style"
---@field graphical_set ElementImageSet|nil
---@field horizontal_flow_style HorizontalFlowStyleSpecification|nil
---@field vertical_flow_style VerticalFlowStyleSpecification|nil
---@field header_flow_style HorizontalFlowStyleSpecification|nil
---@field header_filler_style EmptyWidgetStyleSpecification|nil
---@field title_style LabelStyleSpecification|nil
---@field use_header_filler boolean|nil
---@field drag_by_title boolean|nil
---@field header_background ElementImageSet|nil
---@field background_graphical_set ElementImageSet|nil
---@field border BorderImageSet|nil

---@class FrequencySizeRichness
---@field frequency MapGenSize|nil
---@field size MapGenSize|nil
---@field richness MapGenSize|nil

---@alias FuelCategoryID string

---@class FusionGeneratorDirectionGraphicsSet
---@field animation Animation|nil
---@field working_light Animation|nil
---@field fusion_effect_uv_map Sprite|nil
---@field fluid_input_graphics FusionGeneratorFluidInputGraphics[]|nil

---@class FusionGeneratorFluidInputGraphics
---@field sprite Sprite|nil
---@field working_light Sprite|nil
---@field fusion_effect_uv_map Sprite|nil

---@class FusionGeneratorGraphicsSet
---@field north_graphics_set FusionGeneratorDirectionGraphicsSet
---@field east_graphics_set FusionGeneratorDirectionGraphicsSet
---@field south_graphics_set FusionGeneratorDirectionGraphicsSet
---@field west_graphics_set FusionGeneratorDirectionGraphicsSet
---@field render_layer RenderLayer|nil
---@field light LightDefinition|nil
---@field glow_color Color|nil
---@field water_reflection WaterReflectionDefinition|nil

---@class FusionReactorConnectionGraphics
---@field pictures Animation|nil
---@field working_light_pictures Animation|nil
---@field fusion_effect_uv_map Sprite|nil

---@class FusionReactorGraphicsSet
---@field structure Sprite4Way|nil
---@field render_layer RenderLayer|nil
---@field default_fuel_glow_color Color|nil
---@field light LightDefinition|nil
---@field working_light_pictures Sprite4Way|nil
---@field use_fuel_glow_color boolean|nil
---@field fusion_effect_uv_map Sprite|nil
---@field connections_graphics FusionReactorConnectionGraphics[]|nil
---@field direction_to_connections_graphics table<DirectionString, integer[]>|nil
---@field plasma_category NeighbourConnectableConnectionCategory
---@field water_reflection WaterReflectionDefinition|nil

---@class GameControllerVibrationData
---@field low_frequency_vibration_intensity number|nil
---@field high_frequency_vibration_intensity number|nil
---@field duration integer|nil
---@field play_for PlayFor|nil

---@class GateOverRailBuildTipTrigger: CountBasedTipTrigger
---@field type "gate-over-rail-build"

---@class GeneratingPowerTipTrigger: CountBasedTipTrigger
---@field type "generating-power"

---@class GhostShimmerConfig
---@field tint Color
---@field distortion number
---@field blend_mode integer
---@field visualize_borders boolean
---@field proportional_distortion boolean
---@field world_uv_modulo integer
---@field overlay_layers GhostShimmerOverlayData[]
---@field distortion_layers GhostShimmerDistortionData[]

---@class GhostShimmerDistortionData
---@field shape integer
---@field intensity number
---@field x number
---@field y number

---@class GhostShimmerOverlayData
---@field blend_mode integer
---@field shape integer
---@field x number
---@field y number
---@field tint Color
---@field cutoff number

---@class GhostTintSet
---@field ghost_tint Color
---@field ghost_delivery_tint Color
---@field tile_ghost_tint Color
---@field tile_ghost_delivery_tint Color
---@field wire_tint Color

---@class GigaCargoHatchDefinition
---@field hatch_graphics_back Animation|nil
---@field hatch_graphics_front Animation|nil
---@field hatch_render_layer_back RenderLayer|nil
---@field hatch_render_layer_front RenderLayer|nil
---@field covered_hatches integer[]
---@field opening_sound InterruptibleSound|nil
---@field closing_sound InterruptibleSound|nil

---@class GiveItemModifier: BaseModifier
---@field type "give-item"
---@field use_icon_overlay_constant boolean|nil
---@field item ItemID
---@field quality QualityID|nil
---@field count ItemCountType|nil

---@class GlobalRecipeTints
---@field primary Color|nil
---@field secondary Color|nil
---@field tertiary Color|nil
---@field quaternary Color|nil

---@class GlobalTintEffectProperties
---@field noise_texture EffectTexture
---@field offset Vector4f
---@field intensity Vector4f
---@field scale_u Vector4f
---@field scale_v Vector4f
---@field global_intensity number
---@field global_scale number
---@field zoom_factor number
---@field zoom_intensity number

---@class GlowStyleSpecification: BaseStyleSpecification
---@field type "glow_style"
---@field image_set ElementImageSet|nil

---@class GraphStyleSpecification: BaseStyleSpecification
---@field type "graph_style"
---@field background_color Color|nil
---@field line_colors Color[]|nil
---@field horizontal_label_style LabelStyleSpecification|nil
---@field vertical_label_style LabelStyleSpecification|nil
---@field minimal_horizontal_label_spacing integer|nil
---@field minimal_vertical_label_spacing integer|nil
---@field horizontal_labels_margin integer|nil
---@field vertical_labels_margin integer|nil
---@field graph_top_margin integer|nil
---@field graph_right_margin integer|nil
---@field data_line_highlight_distance integer|nil
---@field selection_dot_radius integer|nil
---@field grid_lines_color Color|nil
---@field guide_lines_color Color|nil
---@field font string|nil

---@class GroupAttackTipTrigger: CountBasedTipTrigger
---@field type "group-attack"

---@class GunSpeedModifier: BaseModifier
---@field type "gun-speed"
---@field infer_icon boolean|nil
---@field use_icon_overlay_constant boolean|nil
---@field ammo_category AmmoCategoryID
---@field modifier number

---@class HeatBuffer
---@field max_temperature number
---@field specific_heat Energy
---@field max_transfer Energy
---@field default_temperature number|nil
---@field min_temperature_gradient number|nil
---@field min_working_temperature number|nil
---@field minimum_glow_temperature number|nil
---@field pipe_covers Sprite4Way|nil
---@field heat_pipe_covers Sprite4Way|nil
---@field heat_picture Sprite4Way|nil
---@field heat_glow Sprite4Way|nil
---@field connections HeatConnection[]|nil

---@class HeatEnergySource: BaseEnergySource
---@field type "heat"
---@field max_temperature number
---@field specific_heat Energy
---@field max_transfer Energy
---@field default_temperature number|nil
---@field min_temperature_gradient number|nil
---@field min_working_temperature number|nil
---@field minimum_glow_temperature number|nil
---@field pipe_covers Sprite4Way|nil
---@field heat_pipe_covers Sprite4Way|nil
---@field heat_picture Sprite4Way|nil
---@field heat_glow Sprite4Way|nil
---@field connections HeatConnection[]|nil
---@field emissions_per_minute table<AirbornePollutantID, number>|nil

---@alias HorizontalAlign "left"|"center"|"right"

---@class HorizontalFlowStyleSpecification: BaseStyleSpecification
---@field type "horizontal_flow_style"
---@field horizontal_spacing integer|nil

---@class HorizontalScrollBarStyleSpecification: ScrollBarStyleSpecification
---@field type "horizontal_scrollbar_style"

---@class IconData
---@field icon FileName
---@field icon_size SpriteSizeType|nil
---@field tint Color|nil
---@field shift Vector|nil
---@field scale number|nil
---@field draw_background boolean|nil
---@field floating boolean|nil

---@class ImageStyleSpecification: BaseStyleSpecification
---@field type "image_style"
---@field graphical_set ElementImageSet|nil
---@field stretch_image_to_widget_size boolean|nil
---@field invert_colors_of_picture_when_hovered_or_toggled boolean|nil

---@alias IngredientPrototype ItemIngredientPrototype|FluidIngredientPrototype

---@class InsertItemTriggerEffectItem: TriggerEffectItem
---@field type "insert-item"
---@field item ItemID
---@field quality QualityID|nil
---@field count ItemCountType|nil

---@class InserterStackSizeBonusModifier: SimpleModifier
---@field type "inserter-stack-size-bonus"
---@field infer_icon boolean|nil
---@field use_icon_overlay_constant boolean|nil

---@class InstantTriggerDelivery: TriggerDeliveryItem
---@field type "instant"

---@class InterruptibleSound
---@field sound Sound|nil
---@field minimal_change_per_tick number|nil
---@field stopped_sound Sound|nil
---@field minimal_sound_duration_for_stopped_sound integer|nil
---@field fade_ticks integer|nil

---@class InvokeTileEffectTriggerEffectItem: TriggerEffectItem
---@field type "invoke-tile-trigger"
---@field tile_collision_mask CollisionMaskConnector|nil

---@alias ItemGroupID string

---@class ItemHealthColorData
---@field threshold number
---@field color Color

---@class ItemIngredientPrototype
---@field type "item"
---@field name ItemID
---@field amount integer
---@field ignored_by_stats integer|nil

---@class ItemProductPrototype
---@field type "item"
---@field name ItemID
---@field amount integer|nil
---@field amount_min integer|nil
---@field amount_max integer|nil
---@field probability number|nil
---@field ignored_by_stats integer|nil
---@field ignored_by_productivity integer|nil
---@field show_details_in_recipe_tooltip boolean|nil
---@field extra_count_fraction number|nil
---@field percent_spoiled number|nil

---@alias ItemSubGroupID string

---@class KillTipTrigger: CountBasedTipTrigger
---@field type "kill"
---@field entity EntityID|nil
---@field match_type_only boolean|nil
---@field damage_type DamageTypeID|nil

---@class LabelStyleSpecification: BaseStyleSpecification
---@field type "label_style"
---@field font string|nil
---@field font_color Color|nil
---@field hovered_font_color Color|nil
---@field game_controller_hovered_font_color Color|nil
---@field clicked_font_color Color|nil
---@field disabled_font_color Color|nil
---@field parent_hovered_font_color Color|nil
---@field rich_text_setting RichTextSetting|nil
---@field single_line boolean|nil
---@field underlined boolean|nil
---@field rich_text_highlight_error_color Color|nil
---@field rich_text_highlight_warning_color Color|nil
---@field rich_text_highlight_ok_color Color|nil

---@class LaboratoryProductivityModifier: SimpleModifier
---@field type "laboratory-productivity"
---@field infer_icon boolean|nil
---@field use_icon_overlay_constant boolean|nil

---@class LaboratorySpeedModifier: SimpleModifier
---@field type "laboratory-speed"
---@field infer_icon boolean|nil
---@field use_icon_overlay_constant boolean|nil

---@class LayeredSound
---@field layers Sound[]

---@class LayeredSprite: Sprite
---@field render_layer RenderLayer

---@alias LayeredSpriteVariations LayeredSprite[]

---@class LightDefinition
---@field type "basic"|"oriented"|nil
---@field picture Sprite|nil
---@field rotation_shift RealOrientation|nil
---@field intensity number
---@field size number
---@field source_orientation_offset RealOrientation|nil
---@field add_perspective boolean|nil
---@field flicker_interval integer|nil
---@field flicker_min_modifier number|nil
---@field flicker_max_modifier number|nil
---@field offset_flicker boolean|nil
---@field shift Vector|nil
---@field color Color|nil
---@field minimum_darkness number|nil

---@class LightFlickeringDefinition
---@field minimum_intensity number|nil
---@field maximum_intensity number|nil
---@field derivation_change_frequency number|nil
---@field derivation_change_deviation number|nil
---@field border_fix_speed number|nil
---@field minimum_light_size number|nil
---@field light_intensity_to_size_coefficient number|nil
---@field color Color|nil

---@class LightProperties
---@field color Color|nil
---@field direction Vector3D|nil

---@class LightningGraphicsSet
---@field shader_configuration LightningShaderConfiguration[]|nil
---@field bolt_half_width number|nil
---@field bolt_midpoint_variance number|nil
---@field max_bolt_offset number|nil
---@field max_fork_probability number|nil
---@field min_relative_fork_length number|nil
---@field max_relative_fork_length number|nil
---@field fork_orientation_variance number|nil
---@field fork_intensity_multiplier number|nil
---@field relative_cloud_fork_length number|nil
---@field cloud_fork_orientation_variance number|nil
---@field min_ground_streamer_distance number|nil
---@field max_ground_streamer_distance number|nil
---@field ground_streamer_variance number|nil
---@field cloud_forks integer|nil
---@field cloud_detail_level integer|nil
---@field bolt_detail_level integer|nil
---@field cloud_background Animation|nil
---@field explosion AnimationVariations|nil
---@field attractor_hit_animation Animation|nil
---@field ground_streamers Animation[]|nil
---@field light LightDefinition|nil
---@field water_reflection WaterReflectionDefinition|nil

---@class LightningPriorityRule: LightningRuleBase
---@field priority_bonus integer

---@class LightningProperties
---@field lightnings_per_chunk_per_tick number
---@field search_radius number
---@field lightning_types EntityID[]
---@field priority_rules LightningPriorityRule[]|nil
---@field exemption_rules LightningRuleBase[]|nil
---@field lightning_multiplier_at_day number|nil
---@field lightning_multiplier_at_night number|nil
---@field multiplier_surface_property SurfacePropertyID|nil
---@field lightning_warning_icon Sprite|nil

---@class LightningRuleBase
---@field type "impact-soundset"|"prototype"|"id"|"countAsRockForFilteredDeconstruction"
---@field string string

---@class LightningShaderConfiguration
---@field color Color
---@field distortion number
---@field thickness number
---@field power number

---@class LimitChestTipTrigger: CountBasedTipTrigger
---@field type "limit-chest"

---@class LineStyleSpecification: BaseStyleSpecification
---@field type "line_style"
---@field border BorderImageSet|nil

---@class LineTriggerItem: TriggerItem
---@field type "line"
---@field range number
---@field width number
---@field range_effects TriggerEffect|nil

---@class LinkedBeltStructure
---@field direction_in Sprite4Way|nil
---@field direction_out Sprite4Way|nil
---@field back_patch Sprite4Way|nil
---@field front_patch Sprite4Way|nil
---@field direction_in_side_loading Sprite4Way|nil
---@field direction_out_side_loading Sprite4Way|nil

---@class ListBoxStyleSpecification: BaseStyleSpecification
---@field type "list_box_style"
---@field item_style ButtonStyleSpecification|nil
---@field scroll_pane_style ScrollPaneStyleSpecification|nil

---@class LoaderStructure
---@field direction_in Sprite4Way|nil
---@field direction_out Sprite4Way|nil
---@field back_patch Sprite4Way|nil
---@field front_patch Sprite4Way|nil
---@field frozen_patch_in Sprite4Way|nil
---@field frozen_patch_out Sprite4Way|nil

---@class LootItem
---@field item ItemID
---@field probability number|nil
---@field count_min number|nil
---@field count_max number|nil

---@class LowPowerTipTrigger: CountBasedTipTrigger
---@field type "low-power"

---@class MainSound
---@field sound Sound|nil
---@field probability number|nil
---@field fade_in_ticks integer|nil
---@field fade_out_ticks integer|nil
---@field activity_to_volume_modifiers ActivityMatchingModifiers|nil
---@field activity_to_speed_modifiers ActivityMatchingModifiers|nil
---@field match_progress_to_activity boolean|nil
---@field match_volume_to_activity boolean|nil
---@field match_speed_to_activity boolean|nil
---@field play_for_working_visualisations string[]|nil
---@field volume_smoothing_window_size integer|nil

---@class ManualTransferTipTrigger: CountBasedTipTrigger
---@field type "manual-transfer"

---@class ManualWireDragTipTrigger: CountBasedTipTrigger
---@field type "manual-wire-drag"
---@field source EntityID|nil
---@field target EntityID|nil
---@field match_type_only boolean|nil
---@field wire_type "red"|"green"|"copper"|nil

---@class MapEditorConstants
---@field clone_editor_copy_source_color Color
---@field clone_editor_copy_destination_allowed_color Color
---@field clone_editor_copy_destination_not_allowed_color Color
---@field clone_editor_brush_source_color Color
---@field clone_editor_brush_destination_color Color
---@field clone_editor_brush_cursor_preview_tint Color
---@field clone_editor_brush_world_preview_tint Color
---@field script_editor_select_area_color Color
---@field script_editor_drag_area_color Color
---@field force_editor_select_area_color Color
---@field cliff_editor_remove_cliffs_color Color
---@field tile_editor_selection_preview_tint Color
---@field tile_editor_area_selection_color Color
---@field decorative_editor_selection_preview_tint Color
---@field tile_editor_selection_preview_radius integer
---@field decorative_editor_selection_preview_radius integer

---@class MapGenPresetAsteroidSettings
---@field spawning_rate number|nil
---@field max_ray_portals_expanded_per_tick integer|nil

---@class MapGenPresetDifficultySettings
---@field technology_price_multiplier number|nil

---@class MapGenPresetEnemyEvolutionSettings
---@field enabled boolean|nil
---@field time_factor number|nil
---@field destroy_factor number|nil
---@field pollution_factor number|nil

---@class MapGenPresetEnemyExpansionSettings
---@field enabled boolean|nil
---@field max_expansion_distance integer|nil
---@field settler_group_min_size integer|nil
---@field settler_group_max_size integer|nil
---@field min_expansion_cooldown integer|nil
---@field max_expansion_cooldown integer|nil

---@class MapGenPresetPollutionSettings
---@field enabled boolean|nil
---@field diffusion_ratio number|nil
---@field ageing number|nil
---@field min_pollution_to_damage_trees number|nil
---@field enemy_attack_pollution_consumption_modifier number|nil
---@field pollution_restored_per_tree_damage number|nil

---@alias MaterialAmountType number

---@class MaterialTextureParameters
---@field count integer
---@field picture FileName
---@field scale number|nil
---@field x SpriteSizeType|nil
---@field y SpriteSizeType|nil
---@field line_length integer|nil

---@class MaxFailedAttemptsPerTickPerConstructionQueueModifier: SimpleModifier
---@field type "max-failed-attempts-per-tick-per-construction-queue"
---@field use_icon_overlay_constant boolean|nil

---@class MaxSuccessfulAttemptsPerTickPerConstructionQueueModifier: SimpleModifier
---@field type "max-successful-attempts-per-tick-per-construction-queue"
---@field use_icon_overlay_constant boolean|nil

---@class MaximumFollowingRobotsCountModifier: SimpleModifier
---@field type "maximum-following-robots-count"
---@field infer_icon boolean|nil
---@field use_icon_overlay_constant boolean|nil

---@class MinableProperties
---@field mining_time number
---@field include_in_show_counts boolean|nil
---@field transfer_entity_health_to_products boolean|nil
---@field results ProductPrototype[]|nil
---@field result ItemID|nil
---@field fluid_amount FluidAmount|nil
---@field mining_particle ParticleID|nil
---@field required_fluid FluidID|nil
---@field count integer|nil
---@field mining_trigger Trigger|nil

---@class MineEntityTechnologyTrigger
---@field type "mine-entity"
---@field entity EntityID

---@class MineItemByRobotTipTrigger: CountBasedTipTrigger
---@field type "mine-item-by-robot"

---@class MinimapStyleSpecification: EmptyWidgetStyleSpecification
---@field type "minimap_style"

---@class MiningDrillGraphicsSet: WorkingVisualisations
---@field frozen_patch Sprite4Way|nil
---@field reset_animation_when_frozen boolean|nil
---@field circuit_connector_layer RenderLayer|CircuitConnectorLayer|nil
---@field circuit_connector_secondary_draw_order integer|CircuitConnectorSecondaryDrawOrder|nil
---@field drilling_vertical_movement_duration integer|nil
---@field animation_progress number|nil
---@field water_reflection WaterReflectionDefinition|nil

---@class MiningDrillProductivityBonusModifier: SimpleModifier
---@field type "mining-drill-productivity-bonus"
---@field infer_icon boolean|nil
---@field use_icon_overlay_constant boolean|nil

---@class MiningWithFluidModifier: BoolModifier
---@field type "mining-with-fluid"
---@field use_icon_overlay_constant boolean|nil

---@alias Mirroring "horizontal"|"vertical"|"diagonal-pos"|"diagonal-neg"

---@alias Modifier InserterStackSizeBonusModifier|BulkInserterCapacityBonusModifier|LaboratorySpeedModifier|CharacterLogisticTrashSlotsModifier|MaximumFollowingRobotsCountModifier|WorkerRobotSpeedModifier|WorkerRobotStorageModifier|TurretAttackModifier|AmmoDamageModifier|GiveItemModifier|GunSpeedModifier|UnlockRecipeModifier|CharacterCraftingSpeedModifier|CharacterMiningSpeedModifier|CharacterRunningSpeedModifier|CharacterBuildDistanceModifier|CharacterItemDropDistanceModifier|CharacterReachDistanceModifier|CharacterResourceReachDistanceModifier|CharacterItemPickupDistanceModifier|CharacterLootPickupDistanceModifier|CharacterInventorySlotsBonusModifier|DeconstructionTimeToLiveModifier|MaxFailedAttemptsPerTickPerConstructionQueueModifier|MaxSuccessfulAttemptsPerTickPerConstructionQueueModifier|CharacterHealthBonusModifier|MiningDrillProductivityBonusModifier|TrainBrakingForceBonusModifier|WorkerRobotBatteryModifier|LaboratoryProductivityModifier|FollowerRobotLifetimeModifier|ArtilleryRangeModifier|NothingModifier|CharacterLogisticRequestsModifier|VehicleLogisticsModifier|UnlockSpaceLocationModifier|UnlockQualityModifier|SpacePlatformsModifier|CircuitNetworkModifier|CargoLandingPadLimitModifier|ChangeRecipeProductivityModifier|CliffDeconstructionEnabledModifier|MiningWithFluidModifier|RailSupportOnDeepOilOceanModifier|RailPlannerAllowElevatedRailsModifier|BeaconDistributionModifier|CreateGhostOnEntityDeathModifier|BeltStackSizeBonusModifier

---@alias Mods table<string, string>

---@alias ModuleCategoryID string

---@alias ModuleTint "primary"|"secondary"|"tertiary"|"quaternary"|"none"

---@class ModuleTransferTipTrigger: CountBasedTipTrigger
---@field type "module-transfer"
---@field module ItemID

---@alias MouseCursorID string

---@alias NeighbourConnectableConnectionCategory string

---@class NestedTriggerEffectItem: TriggerEffectItem
---@field type "nested-result"
---@field action Trigger

---@alias NoiseExpression string|boolean|number

---@class NoiseFunction
---@field parameters string[]
---@field expression NoiseExpression
---@field local_expressions table<string, NoiseExpression>|nil
---@field local_functions table<string, NoiseFunction>|nil

---@class NothingModifier: BaseModifier
---@field type "nothing"
---@field use_icon_overlay_constant boolean|nil
---@field effect_description LocalisedString|nil

---@class OffshorePumpGraphicsSet
---@field animation Animation4Way|nil
---@field base_render_layer RenderLayer|nil
---@field underwater_layer_offset integer|nil
---@field fluid_animation Animation4Way|nil
---@field glass_pictures Sprite4Way|nil
---@field base_pictures Sprite4Way|nil
---@field underwater_pictures Sprite4Way|nil
---@field water_reflection WaterReflectionDefinition|nil

---@class OrTipTrigger
---@field type "or"
---@field triggers TipTrigger[]

---@alias Order string

---@class OrientedCliffPrototype
---@field render_layer RenderLayer|nil
---@field collision_bounding_box BoundingBox
---@field pictures SpriteVariations|nil
---@field pictures_lower SpriteVariations|nil

---@class OrientedCliffPrototypeSet
---@field west_to_east OrientedCliffPrototype
---@field north_to_south OrientedCliffPrototype
---@field east_to_west OrientedCliffPrototype
---@field south_to_north OrientedCliffPrototype
---@field west_to_north OrientedCliffPrototype
---@field north_to_east OrientedCliffPrototype
---@field east_to_south OrientedCliffPrototype
---@field south_to_west OrientedCliffPrototype
---@field west_to_south OrientedCliffPrototype
---@field north_to_west OrientedCliffPrototype
---@field east_to_north OrientedCliffPrototype
---@field south_to_east OrientedCliffPrototype
---@field west_to_none OrientedCliffPrototype
---@field none_to_east OrientedCliffPrototype
---@field north_to_none OrientedCliffPrototype
---@field none_to_south OrientedCliffPrototype
---@field east_to_none OrientedCliffPrototype
---@field none_to_west OrientedCliffPrototype
---@field south_to_none OrientedCliffPrototype
---@field none_to_north OrientedCliffPrototype

---@class OtherColors
---@field less_than number
---@field color Color|nil
---@field bar ElementImageSet|nil

---@class PasteEntitySettingsTipTrigger: CountBasedTipTrigger
---@field type "paste-entity-settings"
---@field source EntityID|nil
---@field target EntityID|nil
---@field match_type_only boolean|nil

---@class PathFinderSettings
---@field fwd2bwd_ratio integer
---@field goal_pressure_ratio number
---@field use_path_cache boolean
---@field max_steps_worked_per_tick number
---@field max_work_done_per_tick integer
---@field short_cache_size integer
---@field long_cache_size integer
---@field short_cache_min_cacheable_distance number
---@field short_cache_min_algo_steps_to_cache integer
---@field long_cache_min_cacheable_distance number
---@field cache_max_connect_to_cache_steps_multiplier integer
---@field cache_accept_path_start_distance_ratio number
---@field cache_accept_path_end_distance_ratio number
---@field negative_cache_accept_path_start_distance_ratio number
---@field negative_cache_accept_path_end_distance_ratio number
---@field cache_path_start_distance_rating_multiplier number
---@field cache_path_end_distance_rating_multiplier number
---@field stale_enemy_with_same_destination_collision_penalty number
---@field ignore_moving_enemy_collision_distance number
---@field enemy_with_different_destination_collision_penalty number
---@field general_entity_collision_penalty number
---@field general_entity_subsequent_collision_penalty number
---@field extended_collision_penalty number
---@field max_clients_to_accept_any_new_request integer
---@field max_clients_to_accept_short_new_request integer
---@field direct_distance_to_consider_short_request integer
---@field short_request_max_steps integer
---@field short_request_ratio number
---@field min_steps_to_check_path_find_termination integer
---@field start_to_goal_cost_multiplier_to_terminate_path_find number
---@field overload_levels integer[]
---@field overload_multipliers number[]
---@field negative_path_cache_delay_interval integer

---@class PersistentWorldAmbientSoundDefinition
---@field sound Sound

---@class PersistentWorldAmbientSoundsDefinition
---@field base_ambience PersistentWorldAmbientSoundDefinition|PersistentWorldAmbientSoundDefinition[]|nil
---@field wind PersistentWorldAmbientSoundDefinition|PersistentWorldAmbientSoundDefinition[]|nil
---@field crossfade PersistentWorldAmbientSoundsDefinitionCrossfade|nil
---@field semi_persistent SemiPersistentWorldAmbientSoundDefinition|SemiPersistentWorldAmbientSoundDefinition[]|nil

---@class PersistentWorldAmbientSoundsDefinitionCrossfade: Fade
---@field order table

---@class PipePictures
---@field straight_vertical_single Sprite|nil
---@field straight_vertical Sprite|nil
---@field straight_vertical_window Sprite|nil
---@field straight_horizontal Sprite|nil
---@field straight_horizontal_window Sprite|nil
---@field corner_up_right Sprite|nil
---@field corner_up_left Sprite|nil
---@field corner_down_right Sprite|nil
---@field corner_down_left Sprite|nil
---@field t_up Sprite|nil
---@field t_down Sprite|nil
---@field t_right Sprite|nil
---@field t_left Sprite|nil
---@field cross Sprite|nil
---@field ending_up Sprite|nil
---@field ending_down Sprite|nil
---@field ending_right Sprite|nil
---@field ending_left Sprite|nil
---@field straight_vertical_single_frozen Sprite|nil
---@field straight_vertical_frozen Sprite|nil
---@field straight_vertical_window_frozen Sprite|nil
---@field straight_horizontal_frozen Sprite|nil
---@field straight_horizontal_window_frozen Sprite|nil
---@field corner_up_right_frozen Sprite|nil
---@field corner_up_left_frozen Sprite|nil
---@field corner_down_right_frozen Sprite|nil
---@field corner_down_left_frozen Sprite|nil
---@field t_up_frozen Sprite|nil
---@field t_down_frozen Sprite|nil
---@field t_right_frozen Sprite|nil
---@field t_left_frozen Sprite|nil
---@field cross_frozen Sprite|nil
---@field ending_up_frozen Sprite|nil
---@field ending_down_frozen Sprite|nil
---@field ending_right_frozen Sprite|nil
---@field ending_left_frozen Sprite|nil
---@field straight_vertical_single_visualization Sprite|nil
---@field straight_vertical_visualization Sprite|nil
---@field straight_vertical_window_visualization Sprite|nil
---@field straight_horizontal_visualization Sprite|nil
---@field straight_horizontal_window_visualization Sprite|nil
---@field corner_up_right_visualization Sprite|nil
---@field corner_up_left_visualization Sprite|nil
---@field corner_down_right_visualization Sprite|nil
---@field corner_down_left_visualization Sprite|nil
---@field t_up_visualization Sprite|nil
---@field t_down_visualization Sprite|nil
---@field t_right_visualization Sprite|nil
---@field t_left_visualization Sprite|nil
---@field cross_visualization Sprite|nil
---@field ending_up_visualization Sprite|nil
---@field ending_down_visualization Sprite|nil
---@field ending_right_visualization Sprite|nil
---@field ending_left_visualization Sprite|nil
---@field straight_vertical_single_disabled_visualization Sprite|nil
---@field straight_vertical_disabled_visualization Sprite|nil
---@field straight_vertical_window_disabled_visualization Sprite|nil
---@field straight_horizontal_disabled_visualization Sprite|nil
---@field straight_horizontal_window_disabled_visualization Sprite|nil
---@field corner_up_right_disabled_visualization Sprite|nil
---@field corner_up_left_disabled_visualization Sprite|nil
---@field corner_down_right_disabled_visualization Sprite|nil
---@field corner_down_left_disabled_visualization Sprite|nil
---@field t_up_disabled_visualization Sprite|nil
---@field t_down_disabled_visualization Sprite|nil
---@field t_right_disabled_visualization Sprite|nil
---@field t_left_disabled_visualization Sprite|nil
---@field cross_disabled_visualization Sprite|nil
---@field ending_up_disabled_visualization Sprite|nil
---@field ending_down_disabled_visualization Sprite|nil
---@field ending_right_disabled_visualization Sprite|nil
---@field ending_left_disabled_visualization Sprite|nil
---@field horizontal_window_background Sprite|nil
---@field vertical_window_background Sprite|nil
---@field fluid_background Sprite|nil
---@field low_temperature_flow Sprite|nil
---@field middle_temperature_flow Sprite|nil
---@field high_temperature_flow Sprite|nil
---@field gas_flow Animation|nil

---@class PlaceAsTile
---@field result TileID
---@field condition CollisionMaskConnector
---@field invert boolean|nil
---@field condition_size integer
---@field tile_condition TileID[]|nil

---@class PlaceEquipmentTipTrigger: CountBasedTipTrigger
---@field type "place-equipment"
---@field equipment EquipmentID|nil

---@class PlanTrainPathTipTrigger
---@field type "plan-train-path"
---@field distance number

---@class PlanetPrototypeMapGenSettings
---@field cliff_settings CliffPlacementSettings|nil
---@field territory_settings TerritorySettings|nil
---@field autoplace_controls table<AutoplaceControlID, FrequencySizeRichness>|nil
---@field autoplace_settings table<"entity"|"tile"|"decorative", AutoplaceSettings>|nil
---@field property_expression_names table<string, string|boolean|number>|nil
---@field moisture_climate_control boolean|nil
---@field aux_climate_control boolean|nil

---@alias PlayFor "character_actions"|"everything"

---@class PlaySoundTriggerEffectItem: TriggerEffectItem
---@field type "play-sound"
---@field sound Sound
---@field min_distance number|nil
---@field max_distance number|nil
---@field play_on_target_position boolean|nil

---@class PlayerColorData
---@field name string
---@field player_color Color
---@field chat_color Color

---@alias PlayerInputMethodFilter "all"|"keyboard_and_mouse"|"game_controller"

---@class PlumeEffect: StatelessVisualisation
---@field age_discrimination integer|nil

---@class PlumesSpecification
---@field render_box BoundingBox|nil
---@field min_probability number|nil
---@field max_probability number|nil
---@field min_y_offset number|nil
---@field max_y_offset number|nil
---@field stateless_visualisations PlumeEffect|PlumeEffect[]|nil

---@class PodAnimationProcessionBezierControlPoint
---@field timestamp integer
---@field frame number

---@class PodAnimationProcessionLayer
---@field type "pod-animation"
---@field graphic ProcessionGraphic|nil
---@field frames PodAnimationProcessionBezierControlPoint[]

---@class PodDistanceTraveledProcessionBezierControlPoint
---@field timestamp integer|nil
---@field distance number|nil
---@field distance_t number|nil

---@class PodDistanceTraveledProcessionLayer
---@field type "pod-distance-traveled"
---@field reference_group ProcessionLayerInheritanceGroupID|nil
---@field contribute_to_distance_traveled boolean|nil
---@field distance_traveled_contribution number|nil
---@field frames PodDistanceTraveledProcessionBezierControlPoint[]

---@class PodMovementProcessionBezierControlPoint
---@field timestamp integer|nil
---@field tilt number|nil
---@field tilt_t number|nil
---@field offset Vector|nil
---@field offset_t Vector|nil
---@field offset_rate number|nil
---@field offset_rate_t number|nil

---@class PodMovementProcessionLayer
---@field type "pod-movement"
---@field reference_group ProcessionLayerInheritanceGroupID|nil
---@field inherit_from ProcessionLayerInheritanceGroupID|nil
---@field contribute_to_distance_traveled boolean|nil
---@field distance_traveled_contribution number|nil
---@field frames PodMovementProcessionBezierControlPoint[]

---@class PodOpacityProcessionBezierControlPoint
---@field timestamp integer|nil
---@field cutscene_opacity number|nil
---@field cutscene_opacity_t number|nil
---@field outside_opacity number|nil
---@field outside_opacity_t number|nil
---@field lut_blend number|nil
---@field lut_blend_t number|nil

---@class PodOpacityProcessionLayer
---@field type "pod-opacity"
---@field lut ColorLookupTable
---@field frames PodOpacityProcessionBezierControlPoint[]

---@class PollutionSettings
---@field enabled boolean
---@field diffusion_ratio number
---@field min_to_diffuse number
---@field ageing number
---@field expected_max_per_chunk number
---@field min_to_show_per_chunk number
---@field min_pollution_to_damage_trees number
---@field pollution_with_max_forest_damage number
---@field pollution_restored_per_tree_damage number
---@field pollution_per_tree_damage number
---@field max_pollution_to_restore_trees number
---@field enemy_attack_pollution_consumption_modifier number

---@alias ProbabilityTable ProbabilityTableItem[]

---@alias ProbabilityTableItem table

---@class ProcessionAudio
---@field type ProcessionAudioType
---@field sound Sound|nil
---@field looped_sound InterruptibleSound|nil
---@field catalogue_id integer|nil

---@alias ProcessionAudioCatalogue ProcessionAudioCatalogueItem[]

---@class ProcessionAudioCatalogueItem
---@field index integer
---@field sound Sound|nil
---@field looped_sound InterruptibleSound|nil

---@class ProcessionAudioEvent
---@field type ProcessionAudioEventType
---@field usage ProcessionAudioUsage|nil
---@field audio ProcessionAudio|nil
---@field loop_id integer|nil

---@alias ProcessionAudioEventType "play-sound"|"start-looped-sound"|"stop-looped-sound"

---@alias ProcessionAudioType "none"|"sound"|"looped-sound"|"pod-catalogue"|"location-catalogue"

---@alias ProcessionAudioUsage "both"|"passenger"|"outside"

---@class ProcessionGraphic
---@field type ProcessionGraphicType
---@field sprite Sprite|nil
---@field animation Animation|nil
---@field catalogue_id integer|nil

---@alias ProcessionGraphicCatalogue ProcessionGraphicCatalogueItem[]

---@class ProcessionGraphicCatalogueItem
---@field index integer
---@field animation Animation|nil
---@field sprite Sprite|nil

---@alias ProcessionGraphicType "none"|"sprite"|"animation"|"pod-catalogue"|"location-catalogue"|"hatch-location-catalogue-index"

---@alias ProcessionID string

---@alias ProcessionLayer PodDistanceTraveledProcessionLayer|PodMovementProcessionLayer|PodOpacityProcessionLayer|SingleGraphicProcessionLayer|CoverGraphicProcessionLayer|TintProcessionLayer|PodAnimationProcessionLayer

---@alias ProcessionLayerInheritanceGroupID string

---@class ProcessionSet
---@field arrival ProcessionID[]
---@field departure ProcessionID[]

---@class ProcessionTimeline
---@field duration integer
---@field special_action_tick integer|nil
---@field draw_switch_tick integer|nil
---@field intermezzo_min_duration integer|nil
---@field intermezzo_max_duration integer|nil
---@field layers ProcessionLayer[]
---@field audio_events ProcessionAudioEvent[]|nil

---@alias ProductPrototype ItemProductPrototype|FluidProductPrototype

---@class ProductionHealthEffect
---@field producing number|nil
---@field not_producing number|nil

---@class ProgrammableSpeakerNote
---@field name string
---@field sound Sound|nil
---@field cyclic_sound CyclicSound|nil

---@class ProgressBarStyleSpecification: BaseStyleSpecification
---@field type "progressbar_style"
---@field bar_width integer|nil
---@field color Color|nil
---@field other_colors OtherColors[]|nil
---@field bar ElementImageSet|nil
---@field bar_background ElementImageSet|nil
---@field font string|nil
---@field font_color Color|nil
---@field filled_font_color Color|nil
---@field embed_text_in_bar boolean|nil
---@field side_text_padding integer|nil

---@class ProjectileAttackParameters: BaseAttackParameters
---@field type "projectile"
---@field apply_projection_to_projectile_creation_position boolean|nil
---@field projectile_center Vector|nil
---@field projectile_creation_distance number|nil
---@field shell_particle CircularParticleCreationSpecification|nil
---@field projectile_creation_parameters CircularProjectileCreationSpecification|nil
---@field projectile_orientation_offset RealOrientation|nil
---@field projectile_creation_offsets Vector[]|nil

---@class ProjectileTriggerDelivery: TriggerDeliveryItem
---@field type "projectile"
---@field projectile EntityID
---@field starting_speed number
---@field starting_speed_deviation number|nil
---@field direction_deviation number|nil
---@field range_deviation number|nil
---@field max_range number|nil
---@field min_range number|nil

---@class PrototypeStrafeSettings
---@field max_distance number|nil
---@field ideal_distance number|nil
---@field ideal_distance_tolerance number|nil
---@field ideal_distance_variance number|nil
---@field ideal_distance_importance number|nil
---@field ideal_distance_importance_variance number|nil
---@field clockwise_chance number|nil
---@field face_target boolean|nil

---@class PuddleTileEffectParameters
---@field puddle_noise_texture EffectTexture
---@field water_effect_parameters WaterTileEffectParameters|nil
---@field water_effect TileEffectDefinitionID|nil

---@class PumpConnectorGraphics
---@field north PumpConnectorGraphicsAnimation[]
---@field east PumpConnectorGraphicsAnimation[]
---@field south PumpConnectorGraphicsAnimation[]
---@field west PumpConnectorGraphicsAnimation[]

---@class PumpConnectorGraphicsAnimation
---@field standup_base Animation|nil
---@field standup_top Animation|nil
---@field standup_shadow Animation|nil
---@field connector Animation|nil
---@field connector_shadow Animation|nil

---@class PushBackTriggerEffectItem: TriggerEffectItem
---@field type "push-back"
---@field distance number

---@class RadioButtonStyleSpecification: StyleWithClickableGraphicalSetSpecification
---@field type "radiobutton_style"
---@field font string|nil
---@field font_color Color|nil
---@field disabled_font_color Color|nil
---@field text_padding integer|nil

---@class RailFenceDirectionSet
---@field north SpriteVariations|nil
---@field northeast SpriteVariations|nil
---@field east SpriteVariations|nil
---@field southeast SpriteVariations|nil
---@field south SpriteVariations|nil
---@field southwest SpriteVariations|nil
---@field west SpriteVariations|nil
---@field northwest SpriteVariations|nil

---@class RailFenceGraphicsSet
---@field segment_count integer
---@field back_fence_render_layer RenderLayer|nil
---@field front_fence_render_layer RenderLayer|nil
---@field back_fence_render_layer_secondary RenderLayer|nil
---@field front_fence_render_layer_secondary RenderLayer|nil
---@field side_A RailFencePictureSet
---@field side_B RailFencePictureSet

---@class RailFencePictureSet
---@field ends table
---@field fence RailFenceDirectionSet
---@field ends_upper table|nil
---@field fence_upper RailFenceDirectionSet|nil

---@class RailPictureSet
---@field north RailPieceLayers
---@field northeast RailPieceLayers
---@field east RailPieceLayers
---@field southeast RailPieceLayers
---@field south RailPieceLayers
---@field southwest RailPieceLayers
---@field west RailPieceLayers
---@field northwest RailPieceLayers
---@field front_rail_endings Sprite16Way|nil
---@field back_rail_endings Sprite16Way|nil
---@field rail_endings Sprite16Way|nil
---@field segment_visualisation_endings RotatedAnimation|nil
---@field render_layers RailRenderLayers
---@field secondary_render_layers RailRenderLayers|nil
---@field slice_origin RailsSliceOffsets|nil
---@field fog_mask RailsFogMaskDefinitions|nil

---@class RailPieceLayers
---@field metals SpriteVariations|nil
---@field backplates SpriteVariations|nil
---@field ties SpriteVariations|nil
---@field stone_path SpriteVariations|nil
---@field stone_path_background SpriteVariations|nil
---@field segment_visualisation_middle Sprite|nil
---@field water_reflection Sprite|nil
---@field underwater_structure Sprite|nil
---@field shadow_subtract_mask Sprite|nil
---@field shadow_mask Sprite|nil

---@class RailPlannerAllowElevatedRailsModifier: BoolModifier
---@field type "rail-planner-allow-elevated-rails"
---@field use_icon_overlay_constant boolean|nil

---@class RailRenderLayers
---@field stone_path_lower RenderLayer|nil
---@field stone_path RenderLayer|nil
---@field tie RenderLayer|nil
---@field screw RenderLayer|nil
---@field metal RenderLayer|nil
---@field front_end RenderLayer|nil
---@field back_end RenderLayer|nil
---@field underwater_layer_offset integer|nil

---@class RailSignalColorToFrameIndex
---@field none integer|nil
---@field red integer|nil
---@field green integer|nil
---@field blue integer|nil
---@field yellow integer|nil

---@class RailSignalLightDefinition
---@field light LightDefinition
---@field shift Vector|nil

---@class RailSignalLights
---@field red RailSignalLightDefinition|nil
---@field green RailSignalLightDefinition|nil
---@field blue RailSignalLightDefinition|nil
---@field yellow RailSignalLightDefinition|nil

---@class RailSignalPictureSet
---@field structure RotatedAnimation
---@field structure_render_layer RenderLayer|nil
---@field signal_color_to_structure_frame_index RailSignalColorToFrameIndex
---@field rail_piece RailSignalStaticSpriteLayer|nil
---@field upper_rail_piece RailSignalStaticSpriteLayer|nil
---@field lights RailSignalLights
---@field circuit_connector CircuitConnectorDefinition[]|nil
---@field circuit_connector_render_layer RenderLayer|nil
---@field structure_align_to_animation_index integer[]|nil
---@field selection_box_shift Vector[]|nil

---@class RailSignalStaticSpriteLayer
---@field sprites Animation
---@field render_layer RenderLayer|nil
---@field hide_if_simulation boolean|nil
---@field hide_if_not_connected_to_rails boolean|nil
---@field shifts MapPosition[]|nil
---@field align_to_frame_index integer[]|nil

---@class RailSupportGraphicsSet
---@field underwater_structure RotatedSprite|nil
---@field structure RotatedSprite
---@field render_layer RenderLayer|nil
---@field underwater_layer_offset integer|nil
---@field water_reflection WaterReflectionDefinition|nil

---@class RailSupportOnDeepOilOceanModifier: BoolModifier
---@field type "rail-support-on-deep-oil-ocean"
---@field use_icon_overlay_constant boolean|nil

---@class RailsFogMaskDefinitions
---@field north FogMaskShapeDefinition|nil
---@field east FogMaskShapeDefinition|nil
---@field south FogMaskShapeDefinition|nil
---@field west FogMaskShapeDefinition|nil

---@class RailsSliceOffsets
---@field north Vector|nil
---@field east Vector|nil
---@field south Vector|nil
---@field west Vector|nil

---@alias RandomRange table|integer

---@alias RangedValue table|number

---@class RecipeTints
---@field primary Color|nil
---@field secondary Color|nil
---@field tertiary Color|nil
---@field quaternary Color|nil

---@class ResearchTechnologyTipTrigger
---@field type "research"
---@field technology TechnologyID

---@class ResearchWithSciencePackTipTrigger
---@field type "research-with-science-pack"
---@field science_pack ItemID

---@alias ResourceCategoryID string

---@alias RichTextSetting "enabled"|"disabled"|"highlight"

---@class RollingStockRotatedSlopedGraphics
---@field rotated RotatedSprite
---@field sloped RotatedSprite|nil
---@field slope_back_equals_front boolean|nil
---@field slope_angle_between_frames number|nil

---@class RotateEntityTipTrigger: CountBasedTipTrigger
---@field type "rotate-entity"

---@class RotatedAnimation: AnimationParameters
---@field layers RotatedAnimation[]|nil
---@field direction_count integer|nil
---@field filename FileName|nil
---@field filenames FileName[]|nil
---@field lines_per_file integer|nil
---@field slice integer|nil
---@field still_frame integer|nil
---@field counterclockwise boolean|nil
---@field middle_orientation RealOrientation|nil
---@field orientation_range number|nil
---@field apply_projection boolean|nil
---@field stripes Stripe[]|nil

---@class RotatedAnimation8Way
---@field north RotatedAnimation
---@field north_east RotatedAnimation|nil
---@field east RotatedAnimation|nil
---@field south_east RotatedAnimation|nil
---@field south RotatedAnimation|nil
---@field south_west RotatedAnimation|nil
---@field west RotatedAnimation|nil
---@field north_west RotatedAnimation|nil

---@alias RotatedAnimationVariations RotatedAnimation|RotatedAnimation[]

---@class RotatedSprite: SpriteParameters
---@field layers RotatedSprite[]|nil
---@field direction_count integer|nil
---@field filename FileName|nil
---@field filenames FileName[]|nil
---@field lines_per_file integer|nil
---@field dice SpriteSizeType|nil
---@field dice_x SpriteSizeType|nil
---@field dice_y SpriteSizeType|nil
---@field generate_sdf boolean|nil
---@field back_equals_front boolean|nil
---@field apply_projection boolean|nil
---@field counterclockwise boolean|nil
---@field line_length integer|nil
---@field allow_low_quality_rotation boolean|nil
---@field frames RotatedSpriteFrame[]|nil

---@class RotatedSpriteFrame
---@field width SpriteSizeType|nil
---@field height SpriteSizeType|nil
---@field x SpriteSizeType|nil
---@field y SpriteSizeType|nil
---@field shift Vector|nil

---@class ScriptTriggerEffectItem: TriggerEffectItem
---@field type "script"
---@field effect_id string

---@class ScriptedTechnologyTrigger
---@field type "scripted"
---@field trigger_description LocalisedString|nil
---@field icons IconData[]|nil
---@field icon FileName|nil
---@field icon_size SpriteSizeType|nil

---@class ScrollBarStyleSpecification: BaseStyleSpecification
---@field background_graphical_set ElementImageSet|nil
---@field thumb_button_style ButtonStyleSpecification|nil

---@class ScrollPaneStyleSpecification: BaseStyleSpecification
---@field type "scroll_pane_style"
---@field vertical_flow_style VerticalFlowStyleSpecification|nil
---@field horizontal_scrollbar_style HorizontalScrollBarStyleSpecification|nil
---@field vertical_scrollbar_style VerticalScrollBarStyleSpecification|nil
---@field graphical_set ElementImageSet|nil
---@field background_graphical_set ElementImageSet|nil
---@field extra_padding_when_activated integer|nil
---@field extra_top_padding_when_activated integer|nil
---@field extra_bottom_padding_when_activated integer|nil
---@field extra_left_padding_when_activated integer|nil
---@field extra_right_padding_when_activated integer|nil
---@field extra_margin_when_activated integer|nil
---@field extra_top_margin_when_activated integer|nil
---@field extra_bottom_margin_when_activated integer|nil
---@field extra_left_margin_when_activated integer|nil
---@field extra_right_margin_when_activated integer|nil
---@field dont_force_clipping_rect_for_contents boolean|nil
---@field always_draw_borders boolean|nil
---@field scrollbars_go_outside boolean|nil

---@class SelectionModeData
---@field border_color Color
---@field count_button_color Color|nil
---@field chart_color Color|nil
---@field cursor_box_type CursorBoxType
---@field mode SelectionModeFlags
---@field entity_filters EntityID[]|nil
---@field entity_type_filters string[]|nil
---@field tile_filters TileID[]|nil
---@field started_sound Sound|nil
---@field ended_sound Sound|nil
---@field play_ended_sound_when_nothing_selected boolean|nil
---@field entity_filter_mode "whitelist"|"blacklist"|nil
---@field tile_filter_mode "whitelist"|"blacklist"|nil

---@class SemiPersistentWorldAmbientSoundDefinition
---@field sound Sound
---@field delay_mean_seconds number|nil
---@field delay_variance_seconds number|nil

---@class SendItemToOrbitTechnologyTrigger
---@field type "send-item-to-orbit"
---@field item ItemIDFilter

---@class SendSpidertronTipTrigger: CountBasedTipTrigger
---@field type "send-spidertron"
---@field append boolean|nil

---@alias SendToOrbitMode "not-sendable"|"manual"|"automated"

---@class SequenceTipTrigger
---@field type "sequence"
---@field triggers TipTrigger[]

---@class SetFilterTipTrigger: CountBasedTipTrigger
---@field type "set-filter"
---@field entity EntityID|nil
---@field match_type_only boolean|nil
---@field consecutive boolean|nil

---@class SetLogisticRequestTipTrigger: CountBasedTipTrigger
---@field type "set-logistic-request"
---@field logistic_chest_only boolean|nil
---@field entity EntityID|nil

---@class SetRecipeTipTrigger: CountBasedTipTrigger
---@field type "set-recipe"
---@field recipe RecipeID|nil
---@field machine EntityID|nil
---@field consecutive boolean|nil
---@field any_quality boolean|nil
---@field uses_fluid boolean|nil

---@class SetTileTriggerEffectItem: TriggerEffectItem
---@field type "set-tile"
---@field tile_name TileID
---@field radius number
---@field apply_projection boolean|nil
---@field apply_on_space_platform boolean|nil
---@field tile_collision_mask CollisionMaskConnector|nil

---@class Settings
---@field startup table<string, ModSetting>

---@class ShiftAnimationWaypoints
---@field north Vector[]
---@field east Vector[]
---@field south Vector[]
---@field west Vector[]

---@class ShootTipTrigger: CountBasedTipTrigger
---@field type "shoot"
---@field target "enemy"|"entity"|nil

---@class ShowExplosionOnChartTriggerEffectItem: TriggerEffectItem
---@field type "show-explosion-on-chart"
---@field scale number

---@class SignalColorMapping: SignalIDConnector
---@field color Color

---@class SignalIDConnector
---@field type "virtual"|"item"|"fluid"|"recipe"|"entity"|"space-location"|"asteroid-chunk"|"quality"
---@field name VirtualSignalID|ItemID|FluidID|RecipeID|EntityID|SpaceLocationID|AsteroidChunkID|QualityID

---@class SimpleBoundingBox
---@field left_top MapPosition
---@field right_bottom MapPosition

---@class SimpleModifier: BaseModifier
---@field modifier number

---@class SimulationDefinition
---@field planet SpaceLocationID|nil
---@field game_view_settings GameViewSettings|nil
---@field save FileName|nil
---@field init_file FileName|nil
---@field init string|nil
---@field update_file FileName|nil
---@field update string|nil
---@field mods string[]|nil
---@field init_update_count integer|nil
---@field length integer|nil
---@field generate_map boolean|nil
---@field checkboard boolean|nil
---@field hide_health_bars boolean|nil
---@field mute_technology_finished_sound boolean|nil
---@field mute_alert_sounds boolean|nil
---@field volume_modifier number|nil
---@field override_volume boolean|nil
---@field mute_wind_sounds boolean|nil
---@field hide_factoriopedia_gradient boolean|nil

---@class SingleGraphicLayerProcessionBezierControlPoint
---@field timestamp integer|nil
---@field opacity number|nil
---@field opacity_t number|nil
---@field tint Color|nil
---@field tint_t Color|nil
---@field rotation number|nil
---@field rotation_t number|nil
---@field scale number|nil
---@field scale_t number|nil
---@field shift Vector|nil
---@field shift_t Vector|nil
---@field shift_rate number|nil
---@field shift_rate_t number|nil
---@field frame number|nil

---@class SingleGraphicProcessionLayer
---@field type "single-graphic"
---@field graphic ProcessionGraphic
---@field render_layer RenderLayer|nil
---@field secondary_draw_order integer|nil
---@field relative_to EffectRelativeTo|nil
---@field compensated_pivot boolean|nil
---@field rotates_with_pod boolean|nil
---@field shift_rotates_with_pod boolean|nil
---@field is_passenger_only boolean|nil
---@field clip_with_hatches boolean|nil
---@field animation_driven_by_curve boolean|nil
---@field frames SingleGraphicLayerProcessionBezierControlPoint[]

---@class SliderStyleSpecification: BaseStyleSpecification
---@field type "slider_style"
---@field full_bar ElementImageSet|nil
---@field full_bar_disabled ElementImageSet|nil
---@field empty_bar ElementImageSet|nil
---@field empty_bar_disabled ElementImageSet|nil
---@field draw_notches boolean|nil
---@field notch ElementImageSet|nil
---@field button ButtonStyleSpecification|nil
---@field high_button ButtonStyleSpecification|nil

---@class Sound
---@field category SoundType|nil
---@field priority integer|nil
---@field aggregation AggregationSpecification|nil
---@field allow_random_repeat boolean|nil
---@field audible_distance_modifier number|nil
---@field game_controller_vibration_data GameControllerVibrationData|nil
---@field advanced_volume_control AdvancedVolumeControl|nil
---@field speed_smoothing_window_size integer|nil
---@field variations SoundDefinition|SoundDefinition[]|nil
---@field filename FileName|nil
---@field volume number|nil
---@field min_volume number|nil
---@field max_volume number|nil
---@field preload boolean|nil
---@field speed number|nil
---@field min_speed number|nil
---@field max_speed number|nil
---@field modifiers SoundModifier|SoundModifier[]|nil

---@class SoundAccent
---@field sound Sound|nil
---@field frame integer|nil
---@field play_for_working_visualisation string|nil

---@class SoundDefinition
---@field filename FileName
---@field volume number|nil
---@field min_volume number|nil
---@field max_volume number|nil
---@field preload boolean|nil
---@field speed number|nil
---@field min_speed number|nil
---@field max_speed number|nil
---@field modifiers SoundModifier|SoundModifier[]|nil

---@class SoundModifier
---@field type SoundModifierType
---@field volume_multiplier number

---@alias SoundModifierType "game"|"main-menu"|"tips-and-tricks"|"driving"|"elevation"|"space-platform"

---@class SpaceDustEffectProperties
---@field noise_texture EffectTexture
---@field asteroid_texture EffectTexture
---@field asteroid_normal_texture EffectTexture
---@field animation_speed number|nil

---@class SpacePlatformsModifier: BoolModifier
---@field type "unlock-space-platforms"
---@field use_icon_overlay_constant boolean|nil

---@class SpaceTileEffectParameters
---@field scroll_factor number|nil
---@field zoom_base_factor number|nil
---@field zoom_base_offset number|nil
---@field zoom_exponent number|nil
---@field zoom_factor number|nil
---@field zoom_offset number|nil
---@field nebula_scale number|nil
---@field nebula_brightness number|nil
---@field nebula_saturation number|nil
---@field star_density number|nil
---@field star_scale number|nil
---@field star_parallax number|nil
---@field star_shape number|nil
---@field star_brightness number|nil
---@field star_saturations number|nil

---@class SpacingItem
---@field index integer
---@field spacing integer

---@class SpawnPoint
---@field evolution_factor number
---@field spawn_weight number

---@class SpeechBubbleStyleSpecification: BaseStyleSpecification
---@field type "speech_bubble_style"
---@field frame_style FrameStyleSpecification|nil
---@field label_style LabelStyleSpecification|nil
---@field arrow_graphical_set ElementImageSet|nil
---@field close_color Color|nil
---@field arrow_indent number|nil
---@field pass_through_mouse boolean|nil

---@class SpiderLegGraphicsSet
---@field joint_turn_offset number|nil
---@field joint_render_layer RenderLayer|nil
---@field joint RotatedSprite|nil
---@field joint_shadow RotatedSprite|nil
---@field upper_part SpiderLegPart|nil
---@field lower_part SpiderLegPart|nil
---@field upper_part_shadow SpiderLegPart|nil
---@field lower_part_shadow SpiderLegPart|nil
---@field upper_part_water_reflection SpiderLegPart|nil
---@field lower_part_water_reflection SpiderLegPart|nil
---@field foot RotatedSprite|nil
---@field foot_shadow RotatedSprite|nil
---@field water_reflection WaterReflectionDefinition|nil

---@class SpiderLegPart
---@field top_end RotatedSprite|nil
---@field middle RotatedSprite|nil
---@field bottom_end RotatedSprite|nil
---@field middle_offset_from_top number|nil
---@field middle_offset_from_bottom number|nil
---@field top_end_length number|nil
---@field bottom_end_length number|nil
---@field top_end_offset number|nil
---@field bottom_end_offset number|nil
---@field render_layer RenderLayer|nil

---@class SpiderLegTriggerEffect
---@field position number
---@field effect TriggerEffect

---@class SpiderTorsoGraphicsSet
---@field base_animation RotatedAnimation|nil
---@field shadow_base_animation RotatedAnimation|nil
---@field animation RotatedAnimation|nil
---@field shadow_animation RotatedAnimation|nil
---@field base_render_layer RenderLayer|nil
---@field render_layer RenderLayer|nil
---@field water_reflection WaterReflectionDefinition|nil

---@class SpiderVehicleGraphicsSet: SpiderTorsoGraphicsSet
---@field autopilot_destination_visualisation_render_layer RenderLayer|nil
---@field light LightDefinition|nil
---@field eye_light LightDefinition|nil
---@field autopilot_destination_on_map_visualisation Animation|nil
---@field autopilot_destination_queue_on_map_visualisation Animation|nil
---@field autopilot_destination_visualisation Animation|nil
---@field autopilot_destination_queue_visualisation Animation|nil
---@field autopilot_path_visualisation_line_width number|nil
---@field autopilot_path_visualisation_on_map_line_width number|nil
---@field light_positions Vector[][]|nil
---@field default_color number|nil

---@class Sprite: SpriteParameters
---@field layers Sprite[]|nil
---@field filename FileName|nil
---@field dice SpriteSizeType|nil
---@field dice_x SpriteSizeType|nil
---@field dice_y SpriteSizeType|nil

---@class Sprite16Way
---@field sheets SpriteNWaySheet[]|nil
---@field sheet SpriteNWaySheet|nil
---@field north Sprite|nil
---@field north_north_east Sprite|nil
---@field north_east Sprite|nil
---@field east_north_east Sprite|nil
---@field east Sprite|nil
---@field east_south_east Sprite|nil
---@field south_east Sprite|nil
---@field south_south_east Sprite|nil
---@field south Sprite|nil
---@field south_south_west Sprite|nil
---@field south_west Sprite|nil
---@field west_south_west Sprite|nil
---@field west Sprite|nil
---@field west_north_west Sprite|nil
---@field north_west Sprite|nil
---@field north_north_west Sprite|nil

---@class Sprite4Way
---@field sheets SpriteNWaySheet[]|nil
---@field sheet SpriteNWaySheet|nil
---@field north Sprite|nil
---@field east Sprite|nil
---@field south Sprite|nil
---@field west Sprite|nil

---@alias SpriteFlags ("no-crop"|"not-compressed"|"always-compressed"|"mipmap"|"linear-minification"|"linear-magnification"|"linear-mip-level"|"alpha-mask"|"no-scale"|"mask"|"icon"|"gui"|"gui-icon"|"light"|"terrain"|"terrain-effect-map"|"reflection-effect-map"|"shadow"|"smoke"|"decal"|"low-object"|"corpse-decay"|"trilinear-filtering"|"group=none"|"group=terrain"|"group=shadow"|"group=smoke"|"group=decal"|"group=low-object"|"group=gui"|"group=icon"|"group=icon-background"|"group=effect-texture")[]

---@class SpriteNWaySheet: SpriteParameters
---@field frames integer|nil
---@field generate_sdf boolean|nil

---@class SpriteParameters: SpriteSource
---@field priority SpritePriority|nil
---@field flags SpriteFlags|nil
---@field shift Vector|nil
---@field rotate_shift boolean|nil
---@field apply_special_effect boolean|nil
---@field scale number|nil
---@field draw_as_shadow boolean|nil
---@field draw_as_glow boolean|nil
---@field draw_as_light boolean|nil
---@field occludes_light boolean|nil
---@field mipmap_count integer|nil
---@field apply_runtime_tint boolean|nil
---@field tint_as_overlay boolean|nil
---@field invert_colors boolean|nil
---@field tint Color|nil
---@field blend_mode BlendMode|nil
---@field generate_sdf boolean|nil
---@field surface SpriteUsageSurfaceHint|nil
---@field usage SpriteUsageHint|nil

---@alias SpritePriority "extra-high-no-scale"|"extra-high"|"high"|"medium"|"low"|"very-low"|"no-atlas"

---@class SpriteSheet: SpriteParameters
---@field layers SpriteSheet[]|nil
---@field variation_count integer|nil
---@field repeat_count integer|nil
---@field line_length integer|nil
---@field filenames FileName[]|nil
---@field lines_per_file integer|nil
---@field dice SpriteSizeType|nil
---@field dice_x SpriteSizeType|nil
---@field dice_y SpriteSizeType|nil
---@field filename FileName|nil

---@alias SpriteSizeType integer

---@class SpriteSource
---@field filename FileName
---@field size SpriteSizeType|table|nil
---@field width SpriteSizeType|nil
---@field height SpriteSizeType|nil
---@field x SpriteSizeType|nil
---@field y SpriteSizeType|nil
---@field position table|nil
---@field load_in_minimal_mode boolean|nil
---@field premul_alpha boolean|nil
---@field allow_forced_downscale boolean|nil

---@alias SpriteUsageHint "any"|"mining"|"tile-artifical"|"corpse-decay"|"enemy"|"player"|"train"|"vehicle"|"explosion"|"rail"|"elevated-rail"|"air"|"remnant"|"decorative"

---@alias SpriteUsageSurfaceHint "any"|"nauvis"|"vulcanus"|"gleba"|"fulgora"|"aquilo"|"space"

---@class SpriteVariations
---@field sheet SpriteSheet

---@class StackTransferTipTrigger: CountBasedTipTrigger
---@field type "stack-transfer"
---@field transfer "stack"|"inventory"|"whole-inventory"|nil

---@class StateSteeringSettings
---@field radius number
---@field separation_factor number
---@field separation_force number
---@field force_unit_fuzzy_goto_behavior boolean

---@class StatelessVisualisation
---@field animation AnimationVariations|nil
---@field shadow AnimationVariations|nil
---@field light LightDefinition|nil
---@field count integer|nil
---@field min_count integer|nil
---@field max_count integer|nil
---@field period integer|nil
---@field particle_tick_offset number|nil
---@field probability number|nil
---@field offset_x RangedValue|nil
---@field offset_y RangedValue|nil
---@field offset_z RangedValue|nil
---@field speed_x RangedValue|nil
---@field speed_y RangedValue|nil
---@field speed_z RangedValue|nil
---@field acceleration_x number|nil
---@field acceleration_y number|nil
---@field acceleration_z number|nil
---@field movement_slowdown_factor_x number|nil
---@field movement_slowdown_factor_y number|nil
---@field movement_slowdown_factor_z number|nil
---@field scale RangedValue|nil
---@field begin_scale number|nil
---@field end_scale number|nil
---@field fade_in_progress_duration number|nil
---@field fade_out_progress_duration number|nil
---@field spread_progress_duration number|nil
---@field adjust_animation_speed_by_base_scale boolean|nil
---@field affected_by_wind boolean|nil
---@field render_layer RenderLayer|nil
---@field positions Vector[]|nil
---@field nested_visualisations StatelessVisualisation|StatelessVisualisation[]|nil
---@field can_lay_on_the_ground boolean|nil

---@class StatusColors
---@field idle Color|nil
---@field no_minable_resources Color|nil
---@field full_output Color|nil
---@field insufficient_input Color|nil
---@field disabled Color|nil
---@field no_power Color|nil
---@field working Color|nil
---@field low_power Color|nil

---@class SteeringSettings
---@field default StateSteeringSettings
---@field moving StateSteeringSettings

---@class StorageTankPictures
---@field picture Sprite4Way|nil
---@field frozen_patch Sprite4Way|nil
---@field window_background Sprite|nil
---@field fluid_background Sprite|nil
---@field flow_sprite Sprite|nil
---@field gas_flow Animation|nil

---@class StreamAttackParameters: BaseAttackParameters
---@field type "stream"
---@field fluid_consumption FluidAmount|nil
---@field gun_barrel_length number|nil
---@field projectile_creation_parameters CircularProjectileCreationSpecification|nil
---@field gun_center_shift Vector|GunShift4Way|nil
---@field fluids StreamFluidProperties[]|nil

---@class StreamFluidProperties
---@field type FluidID
---@field damage_modifier number|nil

---@class StreamTriggerDelivery: TriggerDeliveryItem
---@field type "stream"
---@field stream EntityID
---@field source_offset Vector|nil

---@alias StretchRule "on"|"off"|"auto"|"stretch_and_expand"

---@class Stripe
---@field width_in_frames integer
---@field height_in_frames integer
---@field filename FileName
---@field x integer|nil
---@field y integer|nil

---@alias StyleSpecification ActivityBarStyleSpecification|ButtonStyleSpecification|CameraStyleSpecification|CheckBoxStyleSpecification|DropDownStyleSpecification|FlowStyleSpecification|FrameStyleSpecification|GraphStyleSpecification|HorizontalFlowStyleSpecification|LineStyleSpecification|ImageStyleSpecification|LabelStyleSpecification|ListBoxStyleSpecification|ProgressBarStyleSpecification|RadioButtonStyleSpecification|HorizontalScrollBarStyleSpecification|VerticalScrollBarStyleSpecification|ScrollPaneStyleSpecification|SliderStyleSpecification|SwitchStyleSpecification|TableStyleSpecification|TabStyleSpecification|TextBoxStyleSpecification|VerticalFlowStyleSpecification|TabbedPaneStyleSpecification|EmptyWidgetStyleSpecification|MinimapStyleSpecification|TechnologySlotStyleSpecification|GlowStyleSpecification|SpeechBubbleStyleSpecification|DoubleSliderStyleSpecification

---@class StyleWithClickableGraphicalSetSpecification: BaseStyleSpecification
---@field default_graphical_set ElementImageSet|nil
---@field hovered_graphical_set ElementImageSet|nil
---@field clicked_graphical_set ElementImageSet|nil
---@field disabled_graphical_set ElementImageSet|nil
---@field selected_graphical_set ElementImageSet|nil
---@field selected_hovered_graphical_set ElementImageSet|nil
---@field game_controller_selected_hovered_graphical_set ElementImageSet|nil
---@field selected_clicked_graphical_set ElementImageSet|nil
---@field left_click_sound Sound|nil

---@alias SurfaceID string

---@class SurfaceRenderParameters
---@field day_night_cycle_color_lookup DaytimeColorLookupTable|nil
---@field shadow_opacity number|nil
---@field draw_sprite_clouds boolean|nil
---@field clouds CloudsEffectProperties|nil
---@field fog FogEffectProperties|nil
---@field terrain_tint_effect GlobalTintEffectProperties|nil
---@field space_dust_background SpaceDustEffectProperties|nil
---@field space_dust_foreground SpaceDustEffectProperties|nil

---@class SwitchStyleSpecification: BaseStyleSpecification
---@field type "switch_style"
---@field left_button_position integer|nil
---@field middle_button_position integer|nil
---@field right_button_position integer|nil
---@field default_background Sprite|nil
---@field hover_background Sprite|nil
---@field disabled_background Sprite|nil
---@field button ButtonStyleSpecification|nil
---@field active_label LabelStyleSpecification|nil
---@field inactive_label LabelStyleSpecification|nil

---@class TabStyleSpecification: StyleWithClickableGraphicalSetSpecification
---@field type "tab_style"
---@field font string|nil
---@field badge_font string|nil
---@field badge_horizontal_spacing integer|nil
---@field default_font_color Color|nil
---@field selected_font_color Color|nil
---@field disabled_font_color Color|nil
---@field default_badge_font_color Color|nil
---@field selected_badge_font_color Color|nil
---@field disabled_badge_font_color Color|nil
---@field override_graphics_on_edges boolean|nil
---@field increase_height_when_selected boolean|nil
---@field left_edge_selected_graphical_set ElementImageSet|nil
---@field right_edge_selected_graphical_set ElementImageSet|nil
---@field default_badge_graphical_set ElementImageSet|nil
---@field selected_badge_graphical_set ElementImageSet|nil
---@field hover_badge_graphical_set ElementImageSet|nil
---@field press_badge_graphical_set ElementImageSet|nil
---@field disabled_badge_graphical_set ElementImageSet|nil
---@field draw_grayscale_picture boolean|nil

---@class TabbedPaneStyleSpecification: BaseStyleSpecification
---@field type "tabbed_pane_style"
---@field vertical_spacing integer|nil
---@field tab_content_frame FrameStyleSpecification|nil
---@field tab_container TableStyleSpecification|nil

---@class TableStyleSpecification: BaseStyleSpecification
---@field type "table_style"
---@field horizontal_spacing integer|SpacingItem[]|nil
---@field vertical_spacing integer|SpacingItem[]|nil
---@field cell_padding integer|nil
---@field top_cell_padding integer|nil
---@field right_cell_padding integer|nil
---@field bottom_cell_padding integer|nil
---@field left_cell_padding integer|nil
---@field apply_row_graphical_set_per_column boolean|nil
---@field wide_as_column_count boolean|nil
---@field column_graphical_set ElementImageSet|nil
---@field default_row_graphical_set ElementImageSet|nil
---@field even_row_graphical_set ElementImageSet|nil
---@field odd_row_graphical_set ElementImageSet|nil
---@field hovered_graphical_set ElementImageSet|nil
---@field clicked_graphical_set ElementImageSet|nil
---@field selected_graphical_set ElementImageSet|nil
---@field selected_hovered_graphical_set ElementImageSet|nil
---@field selected_clicked_graphical_set ElementImageSet|nil
---@field background_graphical_set ElementImageSet|nil
---@field column_alignments ColumnAlignment[]|nil
---@field column_widths ColumnWidthItem|ColumnWidth[]|nil
---@field hovered_row_color Color|nil
---@field selected_row_color Color|nil
---@field vertical_line_color Color|nil
---@field horizontal_line_color Color|nil
---@field column_ordering_ascending_button_style ButtonStyleSpecification|nil
---@field column_ordering_descending_button_style ButtonStyleSpecification|nil
---@field inactive_column_ordering_ascending_button_style ButtonStyleSpecification|nil
---@field inactive_column_ordering_descending_button_style ButtonStyleSpecification|nil
---@field border BorderImageSet|nil

---@class TechnologySlotStyleSpecification: ButtonStyleSpecification
---@field type "technology_slot_style"
---@field highlighted_graphical_set ElementImageSet|nil
---@field default_background_shadow ElementImageSet|nil
---@field level_band ElementImageSet|nil
---@field hovered_level_band ElementImageSet|nil
---@field level_offset_x integer|nil
---@field level_offset_y integer|nil
---@field level_band_width integer|nil
---@field level_band_height integer|nil
---@field level_font string|nil
---@field level_range_font string|nil
---@field level_font_color Color|nil
---@field hovered_level_font_color Color|nil
---@field level_range_font_color Color|nil
---@field hovered_level_range_font_color Color|nil
---@field level_range_band ElementImageSet|nil
---@field hovered_level_range_band ElementImageSet|nil
---@field level_range_offset_x integer|nil
---@field level_range_offset_y integer|nil
---@field ingredients_height integer|nil
---@field default_ingredients_background ElementImageSet|nil
---@field hovered_ingredients_background ElementImageSet|nil
---@field clicked_ingredients_background ElementImageSet|nil
---@field disabled_ingredients_background ElementImageSet|nil
---@field highlighted_ingredients_background ElementImageSet|nil
---@field ingredients_padding integer|nil
---@field ingredient_icon_size integer|nil
---@field ingredient_icon_overlap integer|nil
---@field clicked_overlay ElementImageSet|nil
---@field progress_bar_background ElementImageSet|nil
---@field progress_bar ElementImageSet|nil
---@field progress_bar_shadow ElementImageSet|nil
---@field progress_bar_height integer|nil
---@field progress_bar_color Color|nil
---@field drag_handle_style EmptyWidgetStyleSpecification|nil

---@alias TechnologyTrigger MineEntityTechnologyTrigger|CraftItemTechnologyTrigger|CraftFluidTechnologyTrigger|SendItemToOrbitTechnologyTrigger|CaptureSpawnerTechnologyTrigger|BuildEntityTechnologyTrigger|CreateSpacePlatformTechnologyTrigger|ScriptedTechnologyTrigger

---@class TechnologyUnit
---@field count integer|nil
---@field count_formula MathExpression|nil
---@field time number
---@field ingredients ResearchIngredient[]

---@class TextBoxStyleSpecification: BaseStyleSpecification
---@field type "textbox_style"
---@field font string|nil
---@field font_color Color|nil
---@field disabled_font_color Color|nil
---@field selection_background_color Color|nil
---@field default_background ElementImageSet|nil
---@field active_background ElementImageSet|nil
---@field game_controller_hovered_background ElementImageSet|nil
---@field disabled_background ElementImageSet|nil
---@field rich_text_setting RichTextSetting|nil
---@field rich_text_highlight_error_color Color|nil
---@field rich_text_highlight_warning_color Color|nil
---@field rich_text_highlight_ok_color Color|nil
---@field selected_rich_text_highlight_error_color Color|nil
---@field selected_rich_text_highlight_warning_color Color|nil
---@field selected_rich_text_highlight_ok_color Color|nil

---@class ThrowCapsuleAction
---@field type "throw"
---@field attack_parameters AttackParameters
---@field uses_stack boolean|nil

---@class ThrusterGraphicsSet: WorkingVisualisations
---@field flame Sprite|nil
---@field flame_effect EffectTexture|nil
---@field flame_position Vector|nil
---@field flame_effect_height number|nil
---@field flame_effect_width number|nil
---@field flame_half_height number|nil
---@field flame_effect_offset number|nil
---@field water_reflection WaterReflectionDefinition|nil

---@class TileAndAlpha
---@field tile TileID
---@field alpha number

---@class TileBasedParticleTints
---@field primary Color|nil
---@field secondary Color|nil

---@class TileBuildSound
---@field small Sound|nil
---@field medium Sound|nil
---@field large Sound|nil
---@field animated Sound|nil

---@alias TileEffectDefinitionID string

---@alias TileIDRestriction TileID|table

---@class TileLightPictures: TileSpriteLayout
---@field size integer

---@class TileMainPictures: TileSpriteLayout
---@field size integer
---@field probability number|nil
---@field weights number[]|nil

---@alias TileRenderLayer "zero"|"water"|"water-overlay"|"ground-natural"|"ground-artificial"|"top"

---@class TileSpriteLayout
---@field picture FileName
---@field scale number|nil
---@field x SpriteSizeType|nil
---@field y SpriteSizeType|nil
---@field line_length integer|nil
---@field count integer|nil

---@class TileSpriteLayoutVariant
---@field spritesheet FileName|nil
---@field scale number|nil
---@field x SpriteSizeType|nil
---@field y SpriteSizeType|nil
---@field tile_height integer|nil
---@field line_length integer|nil
---@field count integer|nil

---@class TileTransitionSpritesheetLayout: TileSpriteLayoutVariant
---@field overlay TileTransitionVariantLayout|nil
---@field mask TileTransitionVariantLayout|nil
---@field background TileTransitionVariantLayout|nil
---@field background_mask TileTransitionVariantLayout|nil
---@field effect_map TileTransitionVariantLayout|nil
---@field lightmap TileTransitionVariantLayout|nil
---@field auxiliary_effect_mask TileTransitionVariantLayout|nil
---@field inner_corner_scale number|nil
---@field inner_corner_x SpriteSizeType|nil
---@field inner_corner_y SpriteSizeType|nil
---@field inner_corner_tile_height integer|nil
---@field inner_corner_line_length integer|nil
---@field inner_corner_count integer|nil
---@field outer_corner_scale number|nil
---@field outer_corner_x SpriteSizeType|nil
---@field outer_corner_y SpriteSizeType|nil
---@field outer_corner_tile_height integer|nil
---@field outer_corner_line_length integer|nil
---@field outer_corner_count integer|nil
---@field side_scale number|nil
---@field side_x SpriteSizeType|nil
---@field side_y SpriteSizeType|nil
---@field side_tile_height integer|nil
---@field side_line_length integer|nil
---@field side_count integer|nil
---@field double_side_scale number|nil
---@field double_side_x SpriteSizeType|nil
---@field double_side_y SpriteSizeType|nil
---@field double_side_tile_height integer|nil
---@field double_side_line_length integer|nil
---@field double_side_count integer|nil
---@field u_transition_scale number|nil
---@field u_transition_x SpriteSizeType|nil
---@field u_transition_y SpriteSizeType|nil
---@field u_transition_tile_height integer|nil
---@field u_transition_line_length integer|nil
---@field u_transition_count integer|nil
---@field o_transition_scale number|nil
---@field o_transition_x SpriteSizeType|nil
---@field o_transition_y SpriteSizeType|nil
---@field o_transition_tile_height integer|nil
---@field o_transition_line_length integer|nil
---@field o_transition_count integer|nil

---@class TileTransitionVariantLayout: TileSpriteLayoutVariant
---@field x_offset SpriteSizeType|nil
---@field y_offset SpriteSizeType|nil
---@field inner_corner TileSpriteLayoutVariant|nil
---@field outer_corner TileSpriteLayoutVariant|nil
---@field side TileSpriteLayoutVariant|nil
---@field double_side TileSpriteLayoutVariant|nil
---@field u_transition TileSpriteLayoutVariant|nil
---@field o_transition TileSpriteLayoutVariant|nil
---@field inner_corner_scale number|nil
---@field inner_corner_x SpriteSizeType|nil
---@field inner_corner_y SpriteSizeType|nil
---@field inner_corner_tile_height integer|nil
---@field inner_corner_line_length integer|nil
---@field inner_corner_count integer|nil
---@field outer_corner_scale number|nil
---@field outer_corner_x SpriteSizeType|nil
---@field outer_corner_y SpriteSizeType|nil
---@field outer_corner_tile_height integer|nil
---@field outer_corner_line_length integer|nil
---@field outer_corner_count integer|nil
---@field side_scale number|nil
---@field side_x SpriteSizeType|nil
---@field side_y SpriteSizeType|nil
---@field side_tile_height integer|nil
---@field side_line_length integer|nil
---@field side_count integer|nil
---@field double_side_scale number|nil
---@field double_side_x SpriteSizeType|nil
---@field double_side_y SpriteSizeType|nil
---@field double_side_tile_height integer|nil
---@field double_side_line_length integer|nil
---@field double_side_count integer|nil
---@field u_transition_scale number|nil
---@field u_transition_x SpriteSizeType|nil
---@field u_transition_y SpriteSizeType|nil
---@field u_transition_tile_height integer|nil
---@field u_transition_line_length integer|nil
---@field u_transition_count integer|nil
---@field o_transition_scale number|nil
---@field o_transition_x SpriteSizeType|nil
---@field o_transition_y SpriteSizeType|nil
---@field o_transition_tile_height integer|nil
---@field o_transition_line_length integer|nil
---@field o_transition_count integer|nil

---@class TileTransitions
---@field layout TileTransitionSpritesheetLayout|nil
---@field spritesheet FileName|nil
---@field overlay_enabled boolean|nil
---@field mask_enabled boolean|nil
---@field background_enabled boolean|nil
---@field background_mask_enabled boolean|nil
---@field effect_map_enabled boolean|nil
---@field lightmap_enabled boolean|nil
---@field auxiliary_effect_mask_enabled boolean|nil
---@field overlay_layout TileTransitionVariantLayout|nil
---@field mask_layout TileTransitionVariantLayout|nil
---@field background_layout TileTransitionVariantLayout|nil
---@field background_mask_layout TileTransitionVariantLayout|nil
---@field effect_map_layout TileTransitionVariantLayout|nil
---@field lightmap_layout TileTransitionVariantLayout|nil
---@field auxiliary_effect_mask_layout TileTransitionVariantLayout|nil
---@field mask_spritesheet FileName|nil
---@field background_spritesheet FileName|nil
---@field background_mask_spritesheet FileName|nil
---@field effect_map_spritesheet FileName|nil
---@field lightmap_spritesheet FileName|nil
---@field auxiliary_effect_mask_spritesheet FileName|nil
---@field water_patch Sprite|nil
---@field overlay_layer_group TileRenderLayer|nil
---@field background_layer_group TileRenderLayer|nil
---@field waving_effect_time_scale number|nil
---@field overlay_layer_offset integer|nil
---@field masked_overlay_layer_offset integer|nil
---@field background_layer_offset integer|nil
---@field masked_background_layer_offset integer|nil
---@field draw_background_layer_under_tiles boolean|nil
---@field background_layer_occludes_light boolean|nil
---@field apply_effect_color_to_overlay boolean|nil
---@field apply_waving_effect_on_masks boolean|nil
---@field apply_waving_effect_on_background_mask boolean|nil
---@field draw_simple_outer_corner_over_diagonal boolean|nil
---@field offset_background_layer_by_tile_layer boolean|nil
---@field inner_corner_weights number[]|nil
---@field outer_corner_weights number[]|nil
---@field side_weights number[]|nil
---@field side_variations_in_group integer|nil
---@field double_side_weights number[]|nil
---@field double_side_variations_in_group integer|nil
---@field u_transition_weights number[]|nil

---@class TileTransitionsBetweenTransitions: TileTransitions
---@field transition_group1 integer
---@field transition_group2 integer

---@class TileTransitionsToTiles: TileTransitions
---@field to_tiles TileID[]
---@field transition_group integer

---@class TileTransitionsVariants
---@field main TileMainPictures[]|nil
---@field material_texture_width_in_tiles integer|nil
---@field material_texture_height_in_tiles integer|nil
---@field material_background MaterialTextureParameters|nil
---@field light TileLightPictures[]|nil
---@field material_light MaterialTextureParameters|nil
---@field empty_transitions boolean|nil
---@field transition TileTransitions|nil

---@class TimeElapsedTipTrigger
---@field type "time-elapsed"
---@field ticks integer

---@class TimeSinceLastTipActivationTipTrigger
---@field type "time-since-last-tip-activation"
---@field ticks integer

---@class TintProcessionBezierControlPoint
---@field timestamp integer|nil
---@field opacity number|nil
---@field opacity_t number|nil
---@field tint_upper Color|nil
---@field tint_upper_t Color|nil
---@field tint_lower Color|nil
---@field tint_lower_t Color|nil

---@class TintProcessionLayer
---@field type "tint"
---@field render_layer RenderLayer|nil
---@field frames TintProcessionBezierControlPoint[]

---@alias TipStatus "locked"|"optional"|"dependencies-not-met"|"unlocked"|"suggested"|"not-to-be-suggested"|"completed-without-tutorial"|"completed"

---@alias TipTrigger OrTipTrigger|AndTipTrigger|SequenceTipTrigger|DependenciesMetTipTrigger|TimeElapsedTipTrigger|TimeSinceLastTipActivationTipTrigger|ResearchTechnologyTipTrigger|ResearchWithSciencePackTipTrigger|UnlockRecipeTipTrigger|CraftItemTipTrigger|BuildEntityTipTrigger|ManualTransferTipTrigger|ModuleTransferTipTrigger|StackTransferTipTrigger|EntityTransferTipTrigger|DropItemTipTrigger|SetRecipeTipTrigger|SetFilterTipTrigger|LimitChestTipTrigger|UsePipetteTipTrigger|SetLogisticRequestTipTrigger|UseConfirmTipTrigger|ToggleShowEntityInfoTipTrigger|GeneratingPowerTipTrigger|LowPowerTipTrigger|PasteEntitySettingsTipTrigger|FastReplaceTipTrigger|GroupAttackTipTrigger|FastBeltBendTipTrigger|BeltTraverseTipTrigger|PlaceEquipmentTipTrigger|ClearCursorTipTrigger|RotateEntityTipTrigger|FlipEntityTipTrigger|AlternativeBuildTipTrigger|GateOverRailBuildTipTrigger|ManualWireDragTipTrigger|ShootTipTrigger|ChangeSurfaceTipTrigger|ApplyStarterPackTipTrigger|MineItemByRobotTipTrigger|BuildEntityByRobotTipTrigger|PlanTrainPathTipTrigger|UseRailPlannerTipTrigger|ToggleRailLayerTipTrigger|EnterVehicleTipTrigger|SendSpidertronTipTrigger|ActivatePasteTipTrigger|KillTipTrigger

---@class ToggleRailLayerTipTrigger: CountBasedTipTrigger
---@field type "toggle-rail-layer"

---@class ToggleShowEntityInfoTipTrigger: CountBasedTipTrigger
---@field type "toggle-show-entity-info"

---@class TrainBrakingForceBonusModifier: SimpleModifier
---@field type "train-braking-force-bonus"
---@field infer_icon boolean|nil
---@field use_icon_overlay_constant boolean|nil

---@class TrainPathFinderConstants
---@field train_stop_penalty integer
---@field stopped_manually_controlled_train_penalty integer
---@field stopped_manually_controlled_train_without_passenger_penalty integer
---@field signal_reserved_by_circuit_network_penalty integer
---@field train_in_station_penalty integer
---@field train_in_station_with_no_other_valid_stops_in_schedule integer
---@field train_arriving_to_station_penalty integer
---@field train_arriving_to_signal_penalty integer
---@field train_waiting_at_signal_penalty integer
---@field train_waiting_at_signal_tick_multiplier_penalty number
---@field train_with_no_path_penalty integer
---@field train_auto_without_schedule_penalty integer

---@class TrainStopDrawingBoxes
---@field north BoundingBox
---@field east BoundingBox
---@field south BoundingBox
---@field west BoundingBox

---@class TrainStopLight
---@field picture Sprite4Way
---@field red_picture Sprite4Way
---@field light LightDefinition

---@class TrainVisualizationConstants
---@field not_last_box_color Color
---@field last_box_color Color
---@field reverse_box_color Color
---@field last_reverse_box_color Color
---@field box_width number
---@field box_length number
---@field joint_distance number
---@field connection_distance number
---@field final_margin number
---@field stock_number_scale number

---@class TransitionApplication
---@field offset boolean|nil
---@field pod_offset boolean|nil
---@field rotation boolean|nil

---@class TransportBeltAnimationSet
---@field animation_set RotatedAnimation
---@field east_index integer|nil
---@field west_index integer|nil
---@field north_index integer|nil
---@field south_index integer|nil
---@field starting_south_index integer|nil
---@field ending_south_index integer|nil
---@field starting_west_index integer|nil
---@field ending_west_index integer|nil
---@field starting_north_index integer|nil
---@field ending_north_index integer|nil
---@field starting_east_index integer|nil
---@field ending_east_index integer|nil
---@field frozen_patch RotatedSprite|nil
---@field east_index_frozen integer|nil
---@field west_index_frozen integer|nil
---@field north_index_frozen integer|nil
---@field south_index_frozen integer|nil
---@field starting_south_index_frozen integer|nil
---@field ending_south_index_frozen integer|nil
---@field starting_west_index_frozen integer|nil
---@field ending_west_index_frozen integer|nil
---@field starting_north_index_frozen integer|nil
---@field ending_north_index_frozen integer|nil
---@field starting_east_index_frozen integer|nil
---@field ending_east_index_frozen integer|nil
---@field alternate boolean|nil
---@field belt_reader BeltReaderLayer[]|nil

---@class TransportBeltAnimationSetWithCorners: TransportBeltAnimationSet
---@field east_to_north_index integer|nil
---@field north_to_east_index integer|nil
---@field west_to_north_index integer|nil
---@field north_to_west_index integer|nil
---@field south_to_east_index integer|nil
---@field east_to_south_index integer|nil
---@field south_to_west_index integer|nil
---@field west_to_south_index integer|nil
---@field east_to_north_index_frozen integer|nil
---@field north_to_east_index_frozen integer|nil
---@field west_to_north_index_frozen integer|nil
---@field north_to_west_index_frozen integer|nil
---@field south_to_east_index_frozen integer|nil
---@field east_to_south_index_frozen integer|nil
---@field south_to_west_index_frozen integer|nil
---@field west_to_south_index_frozen integer|nil

---@class TransportBeltConnectorFrame
---@field frame_main AnimationVariations
---@field frame_shadow AnimationVariations
---@field frame_main_scanner Animation
---@field frame_main_scanner_movement_speed number
---@field frame_main_scanner_horizontal_start_shift Vector
---@field frame_main_scanner_horizontal_end_shift Vector
---@field frame_main_scanner_horizontal_y_scale number
---@field frame_main_scanner_horizontal_rotation RealOrientation
---@field frame_main_scanner_vertical_start_shift Vector
---@field frame_main_scanner_vertical_end_shift Vector
---@field frame_main_scanner_vertical_y_scale number
---@field frame_main_scanner_vertical_rotation RealOrientation
---@field frame_main_scanner_cross_horizontal_start_shift Vector
---@field frame_main_scanner_cross_horizontal_end_shift Vector
---@field frame_main_scanner_cross_horizontal_y_scale number
---@field frame_main_scanner_cross_horizontal_rotation RealOrientation
---@field frame_main_scanner_cross_vertical_start_shift Vector
---@field frame_main_scanner_cross_vertical_end_shift Vector
---@field frame_main_scanner_cross_vertical_y_scale number
---@field frame_main_scanner_cross_vertical_rotation RealOrientation
---@field frame_main_scanner_nw_ne Animation
---@field frame_main_scanner_sw_se Animation
---@field frame_back_patch SpriteVariations|nil
---@field frame_front_patch SpriteVariations|nil

---@class TreeVariation
---@field trunk Animation
---@field leaves Animation
---@field leaf_generation CreateParticleTriggerEffectItem
---@field branch_generation CreateParticleTriggerEffectItem
---@field shadow Animation|nil
---@field disable_shadow_distortion_beginning_at_frame integer|nil
---@field normal Animation|nil
---@field overlay Animation|nil
---@field underwater Animation|nil
---@field underwater_layer_offset integer|nil
---@field leaves_when_mined_manually integer|nil
---@field leaves_when_mined_automatically integer|nil
---@field leaves_when_damaged integer|nil
---@field leaves_when_destroyed integer|nil
---@field branches_when_mined_manually integer|nil
---@field branches_when_mined_automatically integer|nil
---@field branches_when_damaged integer|nil
---@field branches_when_destroyed integer|nil
---@field water_reflection WaterReflectionDefinition|nil

---@alias Trigger DirectTriggerItem|AreaTriggerItem|LineTriggerItem|ClusterTriggerItem|(DirectTriggerItem|AreaTriggerItem|LineTriggerItem|ClusterTriggerItem)[]

---@class TriggerDeliveryItem
---@field source_effects TriggerEffect|nil
---@field target_effects TriggerEffect|nil

---@alias TriggerEffect DamageEntityTriggerEffectItem|DamageTileTriggerEffectItem|CreateEntityTriggerEffectItem|CreateExplosionTriggerEffectItem|CreateFireTriggerEffectItem|CreateSmokeTriggerEffectItem|CreateTrivialSmokeEffectItem|CreateAsteroidChunkEffectItem|CreateParticleTriggerEffectItem|CreateStickerTriggerEffectItem|CreateDecorativesTriggerEffectItem|NestedTriggerEffectItem|PlaySoundTriggerEffectItem|PushBackTriggerEffectItem|DestroyCliffsTriggerEffectItem|ShowExplosionOnChartTriggerEffectItem|InsertItemTriggerEffectItem|ScriptTriggerEffectItem|SetTileTriggerEffectItem|InvokeTileEffectTriggerEffectItem|DestroyDecorativesTriggerEffectItem|CameraEffectTriggerEffectItem|ActivateImpactTriggerEffectItem|(DamageEntityTriggerEffectItem|DamageTileTriggerEffectItem|CreateEntityTriggerEffectItem|CreateExplosionTriggerEffectItem|CreateFireTriggerEffectItem|CreateSmokeTriggerEffectItem|CreateTrivialSmokeEffectItem|CreateAsteroidChunkEffectItem|CreateParticleTriggerEffectItem|CreateStickerTriggerEffectItem|CreateDecorativesTriggerEffectItem|NestedTriggerEffectItem|PlaySoundTriggerEffectItem|PushBackTriggerEffectItem|DestroyCliffsTriggerEffectItem|ShowExplosionOnChartTriggerEffectItem|InsertItemTriggerEffectItem|ScriptTriggerEffectItem|SetTileTriggerEffectItem|InvokeTileEffectTriggerEffectItem|DestroyDecorativesTriggerEffectItem|CameraEffectTriggerEffectItem|ActivateImpactTriggerEffectItem)[]

---@class TurretAttackModifier: BaseModifier
---@field type "turret-attack"
---@field infer_icon boolean|nil
---@field use_icon_overlay_constant boolean|nil
---@field turret_id EntityID
---@field modifier number

---@class TurretBaseVisualisation
---@field render_layer RenderLayer|nil
---@field secondary_draw_order integer|nil
---@field enabled_states TurretState[]|nil
---@field draw_when_has_energy boolean|nil
---@field draw_when_no_energy boolean|nil
---@field draw_when_has_ammo boolean|nil
---@field draw_when_no_ammo boolean|nil
---@field draw_when_frozen boolean|nil
---@field draw_when_not_frozen boolean|nil
---@field animation Animation4Way

---@class TurretGraphicsSet
---@field base_visualisation TurretBaseVisualisation|TurretBaseVisualisation[]|nil
---@field water_reflection WaterReflectionDefinition|nil

---@class TurretSpecialEffect
---@field type "mask-by-circle"
---@field center TurretSpecialEffectCenter|nil
---@field min_radius number|nil
---@field max_radius number|nil
---@field falloff number|nil
---@field attacking_min_radius number|nil
---@field attacking_max_radius number|nil
---@field attacking_falloff number|nil

---@class TurretSpecialEffectCenter
---@field default Vector|nil
---@field north Vector|nil
---@field north_east Vector|nil
---@field east Vector|nil
---@field south_east Vector|nil
---@field south Vector|nil
---@field south_west Vector|nil
---@field west Vector|nil
---@field north_west Vector|nil

---@alias TurretState "folded"|"preparing"|"prepared"|"starting-attack"|"attacking"|"ending-attack"|"rotate-for-folding"|"folding"

---@class UndergroundBeltStructure
---@field direction_in Sprite4Way|nil
---@field direction_out Sprite4Way|nil
---@field back_patch Sprite4Way|nil
---@field front_patch Sprite4Way|nil
---@field direction_in_side_loading Sprite4Way|nil
---@field direction_out_side_loading Sprite4Way|nil
---@field frozen_patch_in Sprite4Way|nil
---@field frozen_patch_out Sprite4Way|nil

---@class UnitAISettings
---@field destroy_when_commands_fail boolean|nil
---@field allow_try_return_to_spawner boolean|nil
---@field do_separation boolean|nil
---@field path_resolution_modifier integer|nil
---@field strafe_settings PrototypeStrafeSettings|nil
---@field size_in_group number|nil
---@field join_attacks boolean|nil

---@class UnitAlternativeFrameSequence
---@field warmup_frame_sequence integer[]
---@field warmup2_frame_sequence integer[]
---@field attacking_frame_sequence integer[]
---@field cooldown_frame_sequence integer[]
---@field prepared_frame_sequence integer[]
---@field back_to_walk_frame_sequence integer[]
---@field warmup_animation_speed number
---@field attacking_animation_speed number
---@field cooldown_animation_speed number
---@field prepared_animation_speed number
---@field back_to_walk_animation_speed number

---@class UnitGroupSettings
---@field min_group_gathering_time integer
---@field max_group_gathering_time integer
---@field max_wait_time_for_late_members integer
---@field max_group_radius number
---@field min_group_radius number
---@field max_member_speedup_when_behind number
---@field max_member_slowdown_when_ahead number
---@field max_group_slowdown_factor number
---@field max_group_member_fallback_factor number
---@field member_disown_distance number
---@field tick_tolerance_when_member_arrives integer
---@field max_gathering_unit_groups integer
---@field max_unit_group_size integer

---@class UnlockQualityModifier: BaseModifier
---@field type "unlock-quality"
---@field use_icon_overlay_constant boolean|nil
---@field quality QualityID

---@class UnlockRecipeModifier: BaseModifier
---@field type "unlock-recipe"
---@field use_icon_overlay_constant boolean|nil
---@field recipe RecipeID

---@class UnlockRecipeTipTrigger
---@field type "unlock-recipe"
---@field recipe RecipeID

---@class UnlockSpaceLocationModifier: BaseModifier
---@field type "unlock-space-location"
---@field use_icon_overlay_constant boolean|nil
---@field space_location SpaceLocationID

---@class UseConfirmTipTrigger: CountBasedTipTrigger
---@field type "use-confirm"

---@class UseOnSelfCapsuleAction
---@field type "use-on-self"
---@field attack_parameters AttackParameters
---@field uses_stack boolean|nil

---@class UsePipetteTipTrigger: CountBasedTipTrigger
---@field type "use-pipette"

---@class UseRailPlannerTipTrigger: CountBasedTipTrigger
---@field type "use-rail-planner"
---@field build_mode BuildMode

---@alias VariableAmbientSoundCompositionMode "randomized"|"semi-randomized"|"shuffled"|"layer-controlled"

---@class VariableAmbientSoundLayer
---@field name string
---@field variants Sound[]
---@field composition_mode VariableAmbientSoundCompositionMode
---@field control_layer string|nil
---@field control_layer_sample_mapping integer[][]|nil
---@field has_start_sample boolean|nil
---@field has_end_sample boolean|nil
---@field number_of_sublayers integer|nil
---@field sublayer_starting_offset RandomRange|ProbabilityTable|nil
---@field sublayer_offset RandomRange|ProbabilityTable|nil
---@field sample_length RandomRange|nil

---@alias VariableAmbientSoundLayerSample table

---@class VariableAmbientSoundLayerStateProperties
---@field enabled boolean|nil
---@field variant integer|nil
---@field sequence_length RandomRange|nil
---@field number_of_repetitions RandomRange|ProbabilityTable|nil
---@field start_pause RandomRange|nil
---@field pause_between_samples RandomRange|nil
---@field pause_between_repetitions RandomRange|nil
---@field end_pause RandomRange|nil
---@field silence_instead_of_sample_probability number|nil

---@class VariableAmbientSoundNextStateConditions
---@field weight integer
---@field layer_sample VariableAmbientSoundLayerSample|nil
---@field previous_state string|nil

---@class VariableAmbientSoundNextStateItem
---@field state string
---@field conditions VariableAmbientSoundNextStateConditions

---@alias VariableAmbientSoundNextStateTrigger "layers-finished"|"duration"

---@class VariableAmbientSoundState
---@field name string
---@field type VariableAmbientSoundStateType|nil
---@field next_state string|nil
---@field next_states VariableAmbientSoundNextStateItem[]|nil
---@field next_state_trigger VariableAmbientSoundNextStateTrigger|nil
---@field next_state_layers_finished_layers string[]|nil
---@field state_duration_seconds integer|nil
---@field layers_properties VariableAmbientSoundLayerStateProperties[]|nil
---@field start_pause RandomRange|nil
---@field end_pause RandomRange|nil
---@field number_of_enabled_layers RandomRange|nil

---@alias VariableAmbientSoundStateType "regular"|"intermezzo"|"final"|"stop"

---@class VariableAmbientSoundVariableSound
---@field layers VariableAmbientSoundLayer[]
---@field intermezzo Sound|nil
---@field states VariableAmbientSoundState[]
---@field length_seconds integer
---@field alignment_samples integer|nil

---@class Vector4f
---@field x number
---@field y number
---@field z number
---@field w number

---@class VectorRotation
---@field frames Vector[]
---@field render_layer RenderLayer|nil

---@class VehicleLogisticsModifier: BoolModifier
---@field type "vehicle-logistics"
---@field use_icon_overlay_constant boolean|nil

---@alias VerticalAlign "top"|"center"|"bottom"

---@class VerticalFlowStyleSpecification: BaseStyleSpecification
---@field type "vertical_flow_style"
---@field vertical_spacing integer|nil

---@class VerticalScrollBarStyleSpecification: ScrollBarStyleSpecification
---@field type "vertical_scrollbar_style"

---@class VisualState
---@field name string
---@field next_active string
---@field next_inactive string
---@field duration integer
---@field color Color|nil

---@class VoidEnergySource: BaseEnergySource
---@field type "void"

---@class WallPictures
---@field single SpriteVariations|nil
---@field straight_vertical SpriteVariations|nil
---@field straight_horizontal SpriteVariations|nil
---@field corner_right_down SpriteVariations|nil
---@field corner_left_down SpriteVariations|nil
---@field t_up SpriteVariations|nil
---@field ending_right SpriteVariations|nil
---@field ending_left SpriteVariations|nil
---@field filling SpriteVariations|nil
---@field water_connection_patch Sprite4Way|nil
---@field gate_connection_patch Sprite4Way|nil

---@class WaterReflectionDefinition
---@field pictures SpriteVariations|nil
---@field orientation_to_variation boolean|nil
---@field rotate boolean|nil

---@class WaterTileEffectParameters
---@field specular_lightness Color
---@field foam_color Color
---@field foam_color_multiplier number
---@field tick_scale number
---@field animation_speed number
---@field animation_scale number|table
---@field dark_threshold number|table
---@field reflection_threshold number|table
---@field specular_threshold number|table
---@field textures EffectTexture[]
---@field near_zoom number|nil
---@field far_zoom number|nil
---@field lightmap_alpha number|nil
---@field shader_variation EffectVariation|nil
---@field texture_variations_rows integer|nil
---@field texture_variations_columns integer|nil
---@field secondary_texture_variations_rows integer|nil
---@field secondary_texture_variations_columns integer|nil

---@class WireConnectionPoint
---@field wire WirePosition
---@field shadow WirePosition

---@class WirePosition
---@field copper Vector|nil
---@field red Vector|nil
---@field green Vector|nil

---@class WorkerRobotBatteryModifier: SimpleModifier
---@field type "worker-robot-battery"
---@field infer_icon boolean|nil
---@field use_icon_overlay_constant boolean|nil

---@class WorkerRobotSpeedModifier: SimpleModifier
---@field type "worker-robot-speed"
---@field infer_icon boolean|nil
---@field use_icon_overlay_constant boolean|nil

---@class WorkerRobotStorageModifier: SimpleModifier
---@field type "worker-robot-storage"
---@field infer_icon boolean|nil
---@field use_icon_overlay_constant boolean|nil

---@class WorkingSound: MainSound
---@field main_sounds MainSound|MainSound[]|nil
---@field max_sounds_per_prototype integer|nil
---@field extra_sounds_ignore_limit boolean|nil
---@field persistent boolean|nil
---@field use_doppler_shift boolean|nil
---@field idle_sound Sound|nil
---@field activate_sound Sound|nil
---@field deactivate_sound Sound|nil
---@field sound_accents SoundAccent|SoundAccent[]|nil

---@class WorkingVisualisation
---@field render_layer RenderLayer|nil
---@field fadeout boolean|nil
---@field synced_fadeout boolean|nil
---@field constant_speed boolean|nil
---@field always_draw boolean|nil
---@field animated_shift boolean|nil
---@field align_to_waypoint boolean|nil
---@field mining_drill_scorch_mark boolean|nil
---@field secondary_draw_order integer|nil
---@field light LightDefinition|nil
---@field effect "flicker"|"uranium-glow"|"none"|nil
---@field apply_recipe_tint "primary"|"secondary"|"tertiary"|"quaternary"|"none"|nil
---@field apply_tint "resource-color"|"input-fluid-base-color"|"input-fluid-flow-color"|"status"|"none"|"visual-state-color"|nil
---@field north_animation Animation|nil
---@field east_animation Animation|nil
---@field south_animation Animation|nil
---@field west_animation Animation|nil
---@field north_position Vector|nil
---@field east_position Vector|nil
---@field south_position Vector|nil
---@field west_position Vector|nil
---@field north_secondary_draw_order integer|nil
---@field east_secondary_draw_order integer|nil
---@field south_secondary_draw_order integer|nil
---@field west_secondary_draw_order integer|nil
---@field north_fog_mask FogMaskShapeDefinition|nil
---@field east_fog_mask FogMaskShapeDefinition|nil
---@field south_fog_mask FogMaskShapeDefinition|nil
---@field west_fog_mask FogMaskShapeDefinition|nil
---@field fog_mask FogMaskShapeDefinition|nil
---@field animation Animation|nil
---@field draw_in_states string[]|nil
---@field draw_when_state_filter_matches boolean|nil
---@field enabled_by_name boolean|nil
---@field name string|nil
---@field enabled_in_animated_shift_during_waypoint_stop boolean|nil
---@field enabled_in_animated_shift_during_transition boolean|nil
---@field frame_based_on_shift_animation_progress boolean|nil
---@field scorch_mark_fade_out_duration integer|nil
---@field scorch_mark_lifetime integer|nil
---@field scorch_mark_fade_in_frames integer|nil

---@class WorkingVisualisations
---@field animation Animation4Way|nil
---@field idle_animation Animation4Way|nil
---@field always_draw_idle_animation boolean|nil
---@field default_recipe_tint GlobalRecipeTints|nil
---@field recipe_not_set_tint GlobalRecipeTints|nil
---@field states VisualState[]|nil
---@field working_visualisations WorkingVisualisation[]|nil
---@field shift_animation_waypoints ShiftAnimationWaypoints|nil
---@field shift_animation_waypoint_stop_duration integer|nil
---@field shift_animation_transition_duration integer|nil
---@field status_colors StatusColors|nil

---@class WorldAmbientSoundDefinition
---@field sound Sound|nil
---@field radius number|nil
---@field min_entity_count integer|nil
---@field max_entity_count integer|nil
---@field entity_to_sound_ratio number|nil
---@field average_pause_seconds number|nil

---@class AccumulatorPrototype: EntityWithOwnerPrototype
---@field energy_source ElectricEnergySource
---@field chargable_graphics ChargableGraphics|nil
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field circuit_connector CircuitConnectorDefinition|nil
---@field default_output_signal SignalIDConnector|nil

---@class AchievementPrototype: Prototype
---@field icons IconData[]|nil
---@field icon FileName|nil
---@field icon_size SpriteSizeType|nil
---@field steam_stats_name string|nil
---@field allowed_without_fight boolean|nil

---@class AchievementPrototypeWithCondition: AchievementPrototype
---@field objective_condition "game-finished"|"rocket-launched"|"late-research"|nil

---@class ActiveDefenseEquipmentPrototype: EquipmentPrototype
---@field automatic boolean
---@field attack_parameters AttackParameters

---@class ActiveTriggerPrototype: Prototype

---@class AgriculturalTowerPrototype: EntityWithOwnerPrototype
---@field graphics_set CraftingMachineGraphicsSet|nil
---@field crane AgriculturalCraneProperties
---@field energy_source EnergySource
---@field input_inventory_size ItemStackIndex
---@field output_inventory_size ItemStackIndex|nil
---@field energy_usage Energy
---@field crane_energy_usage Energy
---@field radius number
---@field growth_grid_tile_size integer|nil
---@field growth_area_radius number|nil
---@field random_growth_offset number|nil
---@field randomize_planting_tile boolean|nil
---@field radius_visualisation_picture Sprite|nil
---@field central_orienting_sound InterruptibleSound|nil
---@field arm_extending_sound InterruptibleSound|nil
---@field grappler_orienting_sound InterruptibleSound|nil
---@field grappler_extending_sound InterruptibleSound|nil
---@field planting_sound Sound|nil
---@field harvesting_sound Sound|nil
---@field central_orienting_sound_source string|nil
---@field arm_extending_sound_source string|nil
---@field grappler_orienting_sound_source string|nil
---@field grappler_extending_sound_source string|nil
---@field planting_procedure_points Vector3D[]|nil
---@field harvesting_procedure_points Vector3D[]|nil
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field circuit_connector CircuitConnectorDefinition|nil
---@field accepted_seeds ItemID[]|nil

---@class AirbornePollutantPrototype: Prototype
---@field localised_name_with_amount string|nil
---@field chart_color Color
---@field icon Sprite
---@field affects_evolution boolean
---@field affects_water_tint boolean
---@field damages_trees boolean|nil

---@class AmbientSound
---@field type "ambient-sound"
---@field name string
---@field weight number|nil
---@field track_type AmbientSoundType
---@field planet SpaceLocationID|nil
---@field sound Sound|nil
---@field variable_sound VariableAmbientSoundVariableSound|nil

---@class AmmoCategory: Prototype
---@field bonus_gui_order Order|nil
---@field icons IconData[]|nil
---@field icon FileName|nil
---@field icon_size SpriteSizeType|nil

---@class AmmoItemPrototype: ItemPrototype
---@field ammo_type AmmoType|AmmoType[]
---@field magazine_size number|nil
---@field reload_time number|nil
---@field ammo_category AmmoCategoryID
---@field shoot_protected boolean|nil

---@class AmmoTurretPrototype: TurretPrototype
---@field energy_source ElectricEnergySource|nil
---@field energy_per_shot Energy|nil
---@field inventory_size ItemStackIndex
---@field automated_ammo_count ItemCountType
---@field prepare_with_no_ammo boolean|nil

---@class AnimationPrototype
---@field type "animation"
---@field name string
---@field layers Animation[]|nil
---@field filename FileName|nil
---@field priority SpritePriority|nil
---@field flags SpriteFlags|nil
---@field size SpriteSizeType|table|nil
---@field width SpriteSizeType|nil
---@field height SpriteSizeType|nil
---@field x SpriteSizeType|nil
---@field y SpriteSizeType|nil
---@field position table|nil
---@field shift Vector|nil
---@field rotate_shift boolean|nil
---@field apply_special_effect boolean|nil
---@field scale number|nil
---@field draw_as_shadow boolean|nil
---@field draw_as_glow boolean|nil
---@field draw_as_light boolean|nil
---@field mipmap_count integer|nil
---@field apply_runtime_tint boolean|nil
---@field tint_as_overlay boolean|nil
---@field invert_colors boolean|nil
---@field tint Color|nil
---@field blend_mode BlendMode|nil
---@field load_in_minimal_mode boolean|nil
---@field premul_alpha boolean|nil
---@field allow_forced_downscale boolean|nil
---@field generate_sdf boolean|nil
---@field surface SpriteUsageSurfaceHint|nil
---@field usage SpriteUsageHint|nil
---@field run_mode AnimationRunMode|nil
---@field frame_count integer|nil
---@field line_length integer|nil
---@field animation_speed number|nil
---@field max_advance number|nil
---@field repeat_count integer|nil
---@field dice integer|nil
---@field dice_x integer|nil
---@field dice_y integer|nil
---@field frame_sequence AnimationFrameSequence|nil
---@field stripes Stripe[]|nil
---@field filenames FileName[]|nil
---@field slice integer|nil
---@field lines_per_file integer|nil

---@class ArithmeticCombinatorPrototype: CombinatorPrototype
---@field plus_symbol_sprites Sprite4Way|nil
---@field minus_symbol_sprites Sprite4Way|nil
---@field multiply_symbol_sprites Sprite4Way|nil
---@field divide_symbol_sprites Sprite4Way|nil
---@field modulo_symbol_sprites Sprite4Way|nil
---@field power_symbol_sprites Sprite4Way|nil
---@field left_shift_symbol_sprites Sprite4Way|nil
---@field right_shift_symbol_sprites Sprite4Way|nil
---@field and_symbol_sprites Sprite4Way|nil
---@field or_symbol_sprites Sprite4Way|nil
---@field xor_symbol_sprites Sprite4Way|nil

---@class ArmorPrototype: ToolPrototype
---@field equipment_grid EquipmentGridID|nil
---@field resistances Resistance[]|nil
---@field inventory_size_bonus ItemStackIndex|nil
---@field provides_flight boolean|nil
---@field collision_box BoundingBox|nil
---@field drawing_box BoundingBox|nil
---@field takeoff_sound Sound|nil
---@field flight_sound InterruptibleSound|nil
---@field landing_sound Sound|nil
---@field steps_sound Sound|nil
---@field moving_sound Sound|nil

---@class ArrowPrototype: EntityPrototype
---@field arrow_picture Sprite
---@field circle_picture Sprite|nil
---@field blinking boolean|nil

---@class ArtilleryFlarePrototype: EntityPrototype
---@field pictures AnimationVariations|nil
---@field life_time integer
---@field shadows AnimationVariations|nil
---@field render_layer RenderLayer|nil
---@field render_layer_when_on_ground RenderLayer|nil
---@field regular_trigger_effect TriggerEffect|nil
---@field regular_trigger_effect_frequency integer|nil
---@field ended_in_water_trigger_effect TriggerEffect|nil
---@field movement_modifier_when_on_ground number|nil
---@field movement_modifier number|nil
---@field creation_shift Vector|nil
---@field initial_speed Vector|nil
---@field initial_height number|nil
---@field initial_vertical_speed number|nil
---@field initial_frame_speed number|nil
---@field shots_per_flare integer|nil
---@field early_death_ticks integer|nil
---@field shot_category AmmoCategoryID|nil
---@field map_color Color
---@field selection_priority integer|nil

---@class ArtilleryProjectilePrototype: EntityPrototype
---@field reveal_map boolean
---@field picture Sprite|nil
---@field shadow Sprite|nil
---@field chart_picture Sprite|nil
---@field action Trigger|nil
---@field final_action Trigger|nil
---@field height_from_ground number|nil
---@field rotatable boolean|nil
---@field map_color Color
---@field collision_box BoundingBox|nil

---@class ArtilleryTurretPrototype: EntityWithOwnerPrototype
---@field gun ItemID
---@field inventory_size ItemStackIndex
---@field ammo_stack_limit ItemCountType
---@field automated_ammo_count ItemCountType|nil
---@field turret_rotation_speed number
---@field manual_range_modifier number
---@field alert_when_attacking boolean|nil
---@field disable_automatic_firing boolean|nil
---@field base_picture_secondary_draw_order integer|nil
---@field base_picture_render_layer RenderLayer|nil
---@field base_picture Animation4Way|nil
---@field cannon_base_shift Vector3D
---@field cannon_base_pictures RotatedSprite|nil
---@field cannon_barrel_pictures RotatedSprite|nil
---@field rotating_sound InterruptibleSound|nil
---@field turn_after_shooting_cooldown integer|nil
---@field cannon_parking_frame_count integer|nil
---@field cannon_parking_speed number|nil
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field circuit_connector CircuitConnectorDefinition|nil
---@field cannon_barrel_recoil_shiftings Vector3D[]|nil
---@field cannon_barrel_recoil_shiftings_load_correction_matrix Vector3D[]|nil
---@field cannon_barrel_light_direction Vector3D|nil
---@field is_military_target boolean|nil

---@class ArtilleryWagonPrototype: RollingStockPrototype
---@field gun ItemID
---@field inventory_size ItemStackIndex
---@field ammo_stack_limit ItemCountType
---@field automated_ammo_count ItemCountType|nil
---@field turret_rotation_speed number
---@field manual_range_modifier number
---@field disable_automatic_firing boolean|nil
---@field cannon_base_pictures RollingStockRotatedSlopedGraphics|nil
---@field cannon_base_height number|nil
---@field cannon_base_shift_when_vertical number|nil
---@field cannon_base_shift_when_horizontal number|nil
---@field cannon_barrel_pictures RollingStockRotatedSlopedGraphics|nil
---@field rotating_sound InterruptibleSound|nil
---@field turn_after_shooting_cooldown integer|nil
---@field cannon_parking_frame_count integer|nil
---@field cannon_parking_speed number|nil
---@field cannon_barrel_recoil_shiftings Vector3D[]|nil
---@field cannon_barrel_recoil_shiftings_load_correction_matrix Vector3D[]|nil
---@field cannon_barrel_light_direction Vector3D|nil

---@class AssemblingMachinePrototype: CraftingMachinePrototype
---@field fixed_recipe RecipeID|nil
---@field fixed_quality QualityID|nil
---@field gui_title_key string|nil
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field default_recipe_finished_signal SignalIDConnector|nil
---@field default_working_signal SignalIDConnector|nil
---@field enable_logistic_control_behavior boolean|nil
---@field ingredient_count integer|nil
---@field max_item_product_count integer|nil
---@field circuit_connector table|nil
---@field circuit_connector_flipped table|nil
---@field fluid_boxes_off_when_no_fluid_recipe boolean|nil
---@field disabled_when_recipe_not_researched boolean|nil

---@class AsteroidChunkPrototype: Prototype
---@field minable MinableProperties|nil
---@field dying_trigger_effect TriggerEffect|nil
---@field graphics_set AsteroidGraphicsSet|nil
---@field icons IconData[]|nil
---@field icon FileName|nil
---@field icon_size SpriteSizeType|nil
---@field hide_from_signal_gui boolean|nil

---@class AsteroidCollectorPrototype: EntityWithOwnerPrototype
---@field arm_inventory_size ItemStackIndex|nil
---@field arm_inventory_size_quality_increase ItemStackIndex|nil
---@field inventory_size ItemStackIndex|nil
---@field inventory_size_quality_increase ItemStackIndex|nil
---@field graphics_set AsteroidCollectorGraphicsSet
---@field passive_energy_usage Energy
---@field arm_energy_usage Energy
---@field arm_slow_energy_usage Energy
---@field energy_usage_quality_scaling number|nil
---@field arm_count_base integer|nil
---@field arm_count_quality_scaling integer|nil
---@field head_collection_radius number|nil
---@field collection_box_offset number|nil
---@field deposit_radius number|nil
---@field arm_speed_base number|nil
---@field arm_speed_quality_scaling number|nil
---@field arm_angular_speed_cap_base number|nil
---@field arm_angular_speed_cap_quality_scaling number|nil
---@field tether_size number|nil
---@field unpowered_arm_speed_scale number|nil
---@field minimal_arm_swing_segment_retraction integer|nil
---@field held_items_offset number|nil
---@field held_items_spread number|nil
---@field held_items_display_count integer|nil
---@field munch_sound Sound|nil
---@field deposit_sound Sound|nil
---@field arm_extend_sound Sound|nil
---@field arm_retract_sound Sound|nil
---@field energy_source ElectricEnergySource|VoidEnergySource
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field radius_visualisation_picture Sprite|nil
---@field collection_radius number
---@field circuit_connector table|nil
---@field arm_color_gradient Color[]|nil

---@class AsteroidPrototype: EntityWithOwnerPrototype
---@field mass number|nil
---@field graphics_set AsteroidGraphicsSet|nil
---@field emissions_per_second table<AirbornePollutantID, number>|nil

---@class AutoplaceControl: Prototype
---@field category "resource"|"terrain"|"cliff"|"enemy"
---@field richness boolean|nil
---@field can_be_disabled boolean|nil
---@field related_to_fight_achievements boolean|nil
---@field hidden boolean|nil

---@class BatteryEquipmentPrototype: EquipmentPrototype

---@class BeaconPrototype: EntityWithOwnerPrototype
---@field energy_usage Energy
---@field energy_source ElectricEnergySource|VoidEnergySource
---@field supply_area_distance integer
---@field distribution_effectivity number
---@field distribution_effectivity_bonus_per_quality_level number|nil
---@field module_slots ItemStackIndex
---@field quality_affects_module_slots boolean|nil
---@field quality_affects_supply_area_distance boolean|nil
---@field graphics_set BeaconGraphicsSet|nil
---@field animation Animation|nil
---@field base_picture Animation|nil
---@field perceived_performance PerceivedPerformance|nil
---@field radius_visualisation_picture Sprite|nil
---@field allowed_effects EffectTypeLimitation|nil
---@field allowed_module_categories ModuleCategoryID[]|nil
---@field profile number[]|nil
---@field beacon_counter "total"|"same_type"|nil

---@class BeamPrototype: EntityPrototype
---@field action Trigger|nil
---@field width number
---@field damage_interval integer
---@field target_offset Vector|nil
---@field random_target_offset boolean|nil
---@field action_triggered_automatically boolean|nil
---@field graphics_set BeamGraphicsSet

---@class BeltImmunityEquipmentPrototype: EquipmentPrototype
---@field energy_consumption Energy

---@class BlueprintBookPrototype: ItemWithInventoryPrototype
---@field inventory_size ItemStackIndex|"dynamic"
---@field stack_size 1
---@field draw_label_for_cursor_render boolean|nil

---@class BlueprintItemPrototype: SelectionToolPrototype
---@field stack_size 1
---@field draw_label_for_cursor_render boolean|nil
---@field select SelectionModeData
---@field alt_select SelectionModeData
---@field always_include_tiles boolean|nil

---@class BoilerPrototype: EntityWithOwnerPrototype
---@field pictures BoilerPictureSet|nil
---@field energy_source EnergySource
---@field fluid_box FluidBox
---@field output_fluid_box FluidBox
---@field energy_consumption Energy
---@field burning_cooldown integer
---@field target_temperature number|nil
---@field fire_glow_flicker_enabled boolean|nil
---@field fire_flicker_enabled boolean|nil
---@field mode "heat-fluid-inside"|"output-to-separate-pipe"|nil

---@class BuildEntityAchievementPrototype: AchievementPrototype
---@field to_build EntityID
---@field amount integer|nil
---@field limited_to_one_game boolean|nil
---@field within integer|nil

---@class BurnerGeneratorPrototype: EntityWithOwnerPrototype
---@field energy_source ElectricEnergySource
---@field burner BurnerEnergySource
---@field animation Animation4Way|nil
---@field max_power_output Energy
---@field idle_animation Animation4Way|nil
---@field always_draw_idle_animation boolean|nil
---@field perceived_performance PerceivedPerformance|nil

---@class BurnerUsagePrototype: Prototype
---@field empty_slot_sprite Sprite
---@field empty_slot_caption LocalisedString
---@field empty_slot_description LocalisedString|nil
---@field icon Sprite
---@field no_fuel_status LocalisedString|nil
---@field accepted_fuel_key string
---@field burned_in_key string

---@class CapsulePrototype: ItemPrototype
---@field capsule_action CapsuleAction
---@field radius_color Color|nil

---@class CaptureRobotPrototype: FlyingRobotPrototype
---@field capture_speed number|nil
---@field search_radius number|nil
---@field destroy_action Trigger|nil
---@field capture_animation Animation|nil

---@class CarPrototype: VehiclePrototype
---@field animation RotatedAnimation|nil
---@field effectivity number
---@field consumption Energy
---@field rotation_speed number
---@field rotation_snap_angle number
---@field energy_source BurnerEnergySource|VoidEnergySource
---@field turret_animation RotatedAnimation|nil
---@field light_animation RotatedAnimation|nil
---@field render_layer RenderLayer|nil
---@field tank_driving boolean|nil
---@field auto_sort_inventory boolean|nil
---@field has_belt_immunity boolean|nil
---@field immune_to_tree_impacts boolean|nil
---@field immune_to_rock_impacts boolean|nil
---@field immune_to_cliff_impacts boolean|nil
---@field turret_rotation_speed number|nil
---@field turret_return_timeout integer|nil
---@field inventory_size ItemStackIndex
---@field trash_inventory_size ItemStackIndex|nil
---@field light LightDefinition|nil
---@field sound_no_fuel Sound|nil
---@field darkness_to_render_light_animation number|nil
---@field track_particle_triggers FootstepTriggerEffectList|nil
---@field guns ItemID[]|nil

---@class CargoBayPrototype: EntityWithOwnerPrototype
---@field graphics_set CargoBayConnectableGraphicsSet|nil
---@field platform_graphics_set CargoBayConnectableGraphicsSet|nil
---@field inventory_size_bonus ItemStackIndex
---@field hatch_definitions CargoHatchDefinition[]|nil
---@field build_grid_size 2|nil

---@class CargoLandingPadPrototype: EntityWithOwnerPrototype
---@field graphics_set CargoBayConnectableGraphicsSet|nil
---@field inventory_size ItemStackIndex
---@field trash_inventory_size ItemStackIndex|nil
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field circuit_connector CircuitConnectorDefinition|nil
---@field cargo_station_parameters CargoStationParameters
---@field robot_animation Animation|nil
---@field robot_landing_location_offset Vector|nil
---@field robot_opened_duration integer|nil
---@field robot_animation_sound Sound|nil
---@field radar_range integer|nil
---@field radar_visualisation_color Color|nil

---@class CargoPodPrototype: EntityWithOwnerPrototype
---@field default_graphic ProcessionGraphic|nil
---@field default_shadow_graphic ProcessionGraphic|nil
---@field procession_graphic_catalogue ProcessionGraphicCatalogue|nil
---@field procession_audio_catalogue ProcessionAudioCatalogue|nil
---@field shadow_slave_entity EntityID|nil
---@field inventory_size ItemStackIndex
---@field spawned_container EntityID
---@field impact_trigger Trigger|nil

---@class CargoWagonPrototype: RollingStockPrototype
---@field inventory_size ItemStackIndex
---@field quality_affects_inventory_size boolean|nil

---@class ChainActiveTriggerPrototype: ActiveTriggerPrototype
---@field action Trigger|nil
---@field max_jumps integer|nil
---@field max_range_per_jump number|nil
---@field max_range number|nil
---@field jump_delay_ticks integer|nil
---@field fork_chance number|nil
---@field fork_chance_increase_per_quality_level number|nil
---@field max_forks_per_jump integer|nil
---@field max_forks integer|nil

---@class ChangedSurfaceAchievementPrototype: AchievementPrototype
---@field surface string|nil

---@class CharacterCorpsePrototype: EntityPrototype
---@field time_to_live integer
---@field render_layer RenderLayer|nil
---@field pictures AnimationVariations|nil
---@field picture Animation|nil
---@field armor_picture_mapping table<ItemID, integer>|nil

---@class CharacterPrototype: EntityWithOwnerPrototype
---@field crafting_speed number|nil
---@field mining_speed number
---@field running_speed number
---@field distance_per_frame number
---@field maximum_corner_sliding_distance number
---@field heartbeat Sound|nil
---@field inventory_size ItemStackIndex
---@field guns_inventory_size ItemStackIndex|nil
---@field build_distance integer
---@field drop_item_distance integer
---@field reach_distance integer
---@field reach_resource_distance number
---@field item_pickup_distance number
---@field loot_pickup_distance number
---@field ticks_to_keep_gun integer
---@field ticks_to_keep_aiming_direction integer
---@field ticks_to_stay_in_combat integer
---@field damage_hit_tint Color
---@field mining_with_tool_particles_animation_positions number[]
---@field running_sound_animation_positions number[]
---@field moving_sound_animation_positions number[]
---@field animations CharacterArmorAnimation[]
---@field crafting_categories RecipeCategoryID[]|nil
---@field mining_categories ResourceCategoryID[]|nil
---@field light LightDefinition|nil
---@field flying_bob_speed number|nil
---@field grounded_landing_search_radius number|nil
---@field enter_vehicle_distance number|nil
---@field tool_attack_distance number|nil
---@field respawn_time integer|nil
---@field has_belt_immunity boolean|nil
---@field character_corpse EntityID|nil
---@field flying_collision_mask CollisionMaskConnector|nil
---@field tool_attack_result Trigger|nil
---@field footstep_particle_triggers FootstepTriggerEffectList|nil
---@field synced_footstep_particle_triggers FootstepTriggerEffectList|nil
---@field footprint_particles FootprintParticle[]|nil
---@field left_footprint_offset Vector|nil
---@field right_footprint_offset Vector|nil
---@field right_footprint_frames number[]|nil
---@field left_footprint_frames number[]|nil
---@field is_military_target boolean|nil

---@class CliffPrototype: EntityPrototype
---@field orientations OrientedCliffPrototypeSet
---@field grid_size Vector
---@field grid_offset Vector
---@field cliff_explosive ItemID|nil
---@field place_as_crater CraterPlacementDefinition|nil

---@class CollisionLayerPrototype: Prototype

---@class CombatRobotCountAchievementPrototype: AchievementPrototype
---@field count integer|nil

---@class CombatRobotPrototype: FlyingRobotPrototype
---@field time_to_live integer
---@field attack_parameters AttackParameters
---@field idle RotatedAnimation|nil
---@field shadow_idle RotatedAnimation|nil
---@field in_motion RotatedAnimation|nil
---@field shadow_in_motion RotatedAnimation|nil
---@field range_from_player number|nil
---@field friction number|nil
---@field destroy_action Trigger|nil
---@field follows_player boolean|nil
---@field light LightDefinition|nil

---@class CombinatorPrototype: EntityWithOwnerPrototype
---@field energy_source ElectricEnergySource|VoidEnergySource
---@field active_energy_usage Energy
---@field sprites Sprite4Way|nil
---@field frozen_patch Sprite4Way|nil
---@field activity_led_sprites Sprite4Way|nil
---@field input_connection_bounding_box BoundingBox
---@field output_connection_bounding_box BoundingBox
---@field activity_led_light_offsets table
---@field screen_light_offsets table
---@field input_connection_points table
---@field output_connection_points table
---@field activity_led_light LightDefinition|nil
---@field screen_light LightDefinition|nil
---@field activity_led_hold_time integer|nil
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field emissions_per_second table<AirbornePollutantID, number>|nil

---@class CompleteObjectiveAchievementPrototype: AchievementPrototypeWithCondition
---@field within integer|nil

---@class ConstantCombinatorPrototype: EntityWithOwnerPrototype
---@field sprites Sprite4Way|nil
---@field activity_led_sprites Sprite4Way|nil
---@field activity_led_light_offsets table
---@field circuit_wire_connection_points table
---@field activity_led_light LightDefinition|nil
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field pulse_duration integer|nil

---@class ConstructWithRobotsAchievementPrototype: AchievementPrototype
---@field limited_to_one_game boolean
---@field amount integer|nil
---@field more_than_manually boolean|nil

---@class ConstructionRobotPrototype: RobotWithLogisticInterfacePrototype
---@field construction_vector Vector
---@field working RotatedAnimation|nil
---@field shadow_working RotatedAnimation|nil
---@field smoke Animation|nil
---@field sparks AnimationVariations|nil
---@field repairing_sound Sound|nil
---@field mined_sound_volume_modifier number|nil
---@field working_light LightDefinition|nil
---@field collision_box BoundingBox|nil

---@class ContainerPrototype: EntityWithOwnerPrototype
---@field inventory_size ItemStackIndex
---@field quality_affects_inventory_size boolean|nil
---@field picture Sprite|nil
---@field inventory_type "normal"|"with_bar"|"with_filters_and_bar"|"with_custom_stack_size"|"with_weight_limit"|nil
---@field inventory_properties InventoryWithCustomStackSizeSpecification|nil
---@field inventory_weight_limit Weight|nil
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field circuit_connector CircuitConnectorDefinition|nil
---@field default_status EntityStatus|nil

---@class CopyPasteToolPrototype: SelectionToolPrototype
---@field cuts boolean|nil
---@field stack_size 1
---@field always_include_tiles boolean|nil
---@field select SelectionModeData
---@field alt_select SelectionModeData

---@class CorpsePrototype: EntityPrototype
---@field dying_speed number|nil
---@field splash_speed number|nil
---@field time_before_shading_off integer|nil
---@field time_before_removed integer|nil
---@field expires boolean|nil
---@field protected_from_tile_building boolean|nil
---@field remove_on_entity_placement boolean|nil
---@field remove_on_tile_placement boolean|nil
---@field auto_setup_collision_box boolean|nil
---@field final_render_layer RenderLayer|nil
---@field ground_patch_render_layer RenderLayer|nil
---@field animation_render_layer RenderLayer|nil
---@field splash_render_layer RenderLayer|nil
---@field animation_overlay_render_layer RenderLayer|nil
---@field animation_overlay_final_render_layer RenderLayer|nil
---@field shuffle_directions_at_frame integer|nil
---@field use_tile_color_for_ground_patch_tint boolean|nil
---@field use_decay_layer boolean|nil
---@field underwater_layer_offset integer|nil
---@field ground_patch_fade_in_delay number|nil
---@field ground_patch_fade_in_speed number|nil
---@field ground_patch_fade_out_start number|nil
---@field decay_frame_transition_duration number|nil
---@field animation RotatedAnimationVariations|nil
---@field animation_overlay RotatedAnimationVariations|nil
---@field decay_animation RotatedAnimationVariations|nil
---@field splash AnimationVariations|nil
---@field ground_patch AnimationVariations|nil
---@field ground_patch_higher AnimationVariations|nil
---@field ground_patch_decay AnimationVariations|nil
---@field underwater_patch RotatedSprite|nil
---@field ground_patch_fade_out_duration number|nil
---@field direction_shuffle integer[][]|nil

---@class CraftingMachinePrototype: EntityWithOwnerPrototype
---@field quality_affects_energy_usage boolean|nil
---@field energy_usage Energy
---@field crafting_speed number
---@field crafting_categories RecipeCategoryID[]
---@field energy_source EnergySource
---@field fluid_boxes FluidBox[]|nil
---@field effect_receiver EffectReceiver|nil
---@field module_slots ItemStackIndex|nil
---@field quality_affects_module_slots boolean|nil
---@field allowed_effects EffectTypeLimitation|nil
---@field allowed_module_categories ModuleCategoryID[]|nil
---@field show_recipe_icon boolean|nil
---@field return_ingredients_on_change boolean|nil
---@field draw_entity_info_icon_background boolean|nil
---@field match_animation_speed_to_activity boolean|nil
---@field show_recipe_icon_on_map boolean|nil
---@field fast_transfer_modules_into_module_slots_only boolean|nil
---@field ignore_output_full boolean|nil
---@field graphics_set CraftingMachineGraphicsSet|nil
---@field graphics_set_flipped CraftingMachineGraphicsSet|nil
---@field perceived_performance PerceivedPerformance|nil
---@field production_health_effect ProductionHealthEffect|nil
---@field trash_inventory_size ItemStackIndex|nil
---@field vector_to_place_result Vector|nil
---@field forced_symmetry Mirroring|nil
---@field crafting_speed_quality_multiplier table<QualityID, number>|nil
---@field module_slots_quality_bonus table<QualityID, ItemStackIndex>|nil
---@field energy_usage_quality_multiplier table<QualityID, number>|nil

---@class CreatePlatformAchievementPrototype: AchievementPrototype
---@field amount integer|nil

---@class CurvedRailAPrototype: RailPrototype
---@field collision_box BoundingBox|nil

---@class CurvedRailBPrototype: RailPrototype
---@field collision_box BoundingBox|nil

---@class CustomEventPrototype: Prototype

---@class CustomInputPrototype: Prototype
---@field name string
---@field key_sequence string
---@field alternative_key_sequence string|nil
---@field controller_key_sequence string|nil
---@field controller_alternative_key_sequence string|nil
---@field linked_game_control LinkedGameControl|nil
---@field consuming ConsumingType|nil
---@field enabled boolean|nil
---@field enabled_while_spectating boolean|nil
---@field enabled_while_in_cutscene boolean|nil
---@field include_selected_prototype boolean|nil
---@field item_to_spawn ItemID|nil
---@field action "lua"|"spawn-item"|"toggle-personal-roboport"|"toggle-personal-logistic-requests"|"toggle-equipment-movement-bonus"|nil
---@field block_modifiers boolean|nil

---@class DamageType: Prototype

---@class DeciderCombinatorPrototype: CombinatorPrototype
---@field equal_symbol_sprites Sprite4Way|nil
---@field greater_symbol_sprites Sprite4Way|nil
---@field less_symbol_sprites Sprite4Way|nil
---@field not_equal_symbol_sprites Sprite4Way|nil
---@field greater_or_equal_symbol_sprites Sprite4Way|nil
---@field less_or_equal_symbol_sprites Sprite4Way|nil

---@class DeconstructWithRobotsAchievementPrototype: AchievementPrototype
---@field amount integer

---@class DeconstructibleTileProxyPrototype: EntityPrototype

---@class DeconstructionItemPrototype: SelectionToolPrototype
---@field entity_filter_count ItemStackIndex|nil
---@field tile_filter_count ItemStackIndex|nil
---@field stack_size 1
---@field select SelectionModeData
---@field alt_select SelectionModeData
---@field always_include_tiles boolean|nil

---@class DecorativePrototype: Prototype
---@field pictures SpriteVariations
---@field stateless_visualisation StatelessVisualisation|StatelessVisualisation[]|nil
---@field stateless_visualisation_variations (StatelessVisualisation|StatelessVisualisation[])[]|nil
---@field collision_box BoundingBox|nil
---@field render_layer RenderLayer|nil
---@field grows_through_rail_path boolean|nil
---@field opacity_over_water number|nil
---@field tile_layer integer|nil
---@field decal_overdraw_priority integer|nil
---@field collision_mask CollisionMaskConnector|nil
---@field walking_sound Sound|nil
---@field trigger_effect TriggerEffect|nil
---@field minimal_separation number|nil
---@field target_count integer|nil
---@field placed_effect TriggerEffect|nil
---@field autoplace AutoplaceSpecification|nil

---@class DelayedActiveTriggerPrototype: ActiveTriggerPrototype
---@field action Trigger
---@field delay integer
---@field repeat_count integer|nil
---@field repeat_delay integer|nil
---@field cancel_when_source_is_destroyed boolean|nil

---@class DeliverByRobotsAchievementPrototype: AchievementPrototype
---@field amount integer

---@class DeliverCategory
---@field type "deliver-category"
---@field name string

---@class DeliverImpactCombination
---@field type "deliver-impact-combination"
---@field name string
---@field impact_category string
---@field deliver_category string
---@field trigger_effect_item TriggerEffect

---@class DepleteResourceAchievementPrototype: AchievementPrototype
---@field amount integer|nil
---@field limited_to_one_game boolean|nil

---@class DestroyCliffAchievementPrototype: AchievementPrototype
---@field amount integer|nil
---@field limited_to_one_game boolean|nil

---@class DisplayPanelPrototype: EntityWithOwnerPrototype
---@field sprites Sprite4Way|nil
---@field max_text_width integer|nil
---@field text_shift Vector|nil
---@field text_color Color|nil
---@field background_color Color|nil
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field circuit_connector table|nil

---@class DontBuildEntityAchievementPrototype: AchievementPrototypeWithCondition
---@field dont_build EntityID|EntityID[]
---@field amount integer|nil
---@field research_with ItemID|ItemID[]|nil

---@class DontCraftManuallyAchievementPrototype: AchievementPrototypeWithCondition
---@field amount integer

---@class DontKillManuallyAchievementPrototype: AchievementPrototypeWithCondition
---@field to_kill EntityID|nil
---@field type_not_to_kill string|nil

---@class DontResearchBeforeResearchingAchievementPrototype: AchievementPrototypeWithCondition
---@field dont_research ItemID|ItemID[]
---@field research_with ItemID|ItemID[]

---@class DontUseEntityInEnergyProductionAchievementPrototype: AchievementPrototypeWithCondition
---@field excluded EntityID|EntityID[]
---@field included EntityID|EntityID[]|nil
---@field last_hour_only boolean|nil
---@field minimum_energy_produced Energy|nil

---@class EditorControllerPrototype
---@field type "editor-controller"
---@field name string
---@field inventory_size ItemStackIndex
---@field gun_inventory_size ItemStackIndex
---@field movement_speed number
---@field item_pickup_distance number
---@field loot_pickup_distance number
---@field mining_speed number
---@field enable_flash_light boolean
---@field adjust_speed_based_off_zoom boolean
---@field render_as_day boolean
---@field instant_blueprint_building boolean
---@field instant_deconstruction boolean
---@field instant_upgrading boolean
---@field instant_rail_planner boolean
---@field show_status_icons boolean
---@field show_hidden_entities boolean
---@field show_entity_tags boolean
---@field show_entity_health_bars boolean
---@field show_additional_entity_info_gui boolean
---@field generate_neighbor_chunks boolean
---@field fill_built_entity_energy_buffers boolean
---@field show_character_tab_in_controller_gui boolean
---@field show_infinity_filters_in_controller_gui boolean
---@field placed_corpses_never_expire boolean
---@field ignore_tile_conditions boolean

---@class ElectricEnergyInterfacePrototype: EntityWithOwnerPrototype
---@field energy_source ElectricEnergySource
---@field energy_production Energy|nil
---@field energy_usage Energy|nil
---@field gui_mode "all"|"none"|"admins"|nil
---@field continuous_animation boolean|nil
---@field render_layer RenderLayer|nil
---@field light LightDefinition|nil
---@field picture Sprite|nil
---@field pictures Sprite4Way|nil
---@field animation Animation|nil
---@field animations Animation4Way|nil
---@field allow_copy_paste boolean|nil

---@class ElectricPolePrototype: EntityWithOwnerPrototype
---@field pictures RotatedSprite|nil
---@field supply_area_distance number
---@field connection_points WireConnectionPoint[]
---@field radius_visualisation_picture Sprite|nil
---@field active_picture Sprite|nil
---@field maximum_wire_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field light LightDefinition|nil
---@field track_coverage_during_build_by_moving boolean|nil
---@field auto_connect_up_to_n_wires integer|nil
---@field rewire_neighbours_when_destroying boolean|nil

---@class ElectricTurretPrototype: TurretPrototype
---@field energy_source ElectricEnergySource|VoidEnergySource

---@class ElevatedCurvedRailAPrototype: CurvedRailAPrototype
---@field name string

---@class ElevatedCurvedRailBPrototype: CurvedRailBPrototype
---@field name string

---@class ElevatedHalfDiagonalRailPrototype: HalfDiagonalRailPrototype
---@field name string

---@class ElevatedStraightRailPrototype: StraightRailPrototype
---@field name string

---@class EnemySpawnerPrototype: EntityWithOwnerPrototype
---@field graphics_set EnemySpawnerGraphicsSet
---@field max_count_of_owned_units integer
---@field max_count_of_owned_defensive_units integer|nil
---@field max_friends_around_to_spawn integer
---@field max_defensive_friends_around_to_spawn integer|nil
---@field spawning_cooldown table
---@field spawning_radius number
---@field spawning_spacing number
---@field max_richness_for_spawn_shift number
---@field max_spawn_shift number
---@field call_for_help_radius number
---@field time_to_capture integer|nil
---@field result_units UnitSpawnDefinition[]
---@field dying_sound Sound|nil
---@field absorptions_per_second table<AirbornePollutantID, EnemySpawnerAbsorption>|nil
---@field min_darkness_to_spawn number|nil
---@field max_darkness_to_spawn number|nil
---@field spawn_decorations_on_expansion boolean|nil
---@field spawn_decoration CreateDecorativesTriggerEffectItem[]|nil
---@field captured_spawner_entity EntityID|nil
---@field is_military_target true|nil
---@field allow_run_time_change_of_is_military_target false|nil

---@class EnergyShieldEquipmentPrototype: EquipmentPrototype
---@field max_shield_value number
---@field energy_per_shield Energy

---@class EntityGhostPrototype: EntityPrototype
---@field medium_build_sound Sound|nil
---@field large_build_sound Sound|nil
---@field huge_build_sound Sound|nil
---@field small_build_animated_sound Sound|nil
---@field medium_build_animated_sound Sound|nil
---@field large_build_animated_sound Sound|nil
---@field huge_build_animated_sound Sound|nil

---@class EntityPrototype: Prototype
---@field icons IconData[]|nil
---@field icon FileName|nil
---@field icon_size SpriteSizeType|nil
---@field collision_box BoundingBox|nil
---@field collision_mask CollisionMaskConnector|nil
---@field map_generator_bounding_box BoundingBox|nil
---@field selection_box BoundingBox|nil
---@field drawing_box_vertical_extension number|nil
---@field sticker_box BoundingBox|nil
---@field hit_visualization_box BoundingBox|nil
---@field trigger_target_mask TriggerTargetMask|nil
---@field flags EntityPrototypeFlags|nil
---@field tile_buildability_rules TileBuildabilityRule[]|nil
---@field minable MinableProperties|nil
---@field surface_conditions SurfaceCondition[]|nil
---@field deconstruction_alternative EntityID|nil
---@field selection_priority integer|nil
---@field build_grid_size integer|nil
---@field remove_decoratives "automatic"|"true"|"false"|nil
---@field emissions_per_second table<AirbornePollutantID, number>|nil
---@field shooting_cursor_size number|nil
---@field created_smoke CreateTrivialSmokeEffectItem|nil
---@field working_sound WorkingSound|nil
---@field created_effect Trigger|nil
---@field build_sound Sound|nil
---@field mined_sound Sound|nil
---@field mining_sound Sound|nil
---@field rotated_sound Sound|nil
---@field impact_category string|nil
---@field open_sound Sound|nil
---@field close_sound Sound|nil
---@field placeable_position_visualization Sprite|nil
---@field radius_visualisation_specification RadiusVisualisationSpecification|nil
---@field stateless_visualisation StatelessVisualisation|StatelessVisualisation[]|nil
---@field draw_stateless_visualisations_in_ghost boolean|nil
---@field build_base_evolution_requirement number|nil
---@field alert_icon_shift Vector|nil
---@field alert_icon_scale number|nil
---@field fast_replaceable_group string|nil
---@field next_upgrade EntityID|nil
---@field protected_from_tile_building boolean|nil
---@field heating_energy Energy|nil
---@field allow_copy_paste boolean|nil
---@field selectable_in_game boolean|nil
---@field placeable_by ItemToPlace|ItemToPlace[]|nil
---@field remains_when_mined EntityID|EntityID[]|nil
---@field additional_pastable_entities EntityID[]|nil
---@field tile_width integer|nil
---@field tile_height integer|nil
---@field diagonal_tile_grid_size TilePosition|nil
---@field autoplace AutoplaceSpecification|nil
---@field map_color Color|nil
---@field friendly_map_color Color|nil
---@field enemy_map_color Color|nil
---@field water_reflection WaterReflectionDefinition|nil
---@field ambient_sounds_group EntityID|nil
---@field ambient_sounds WorldAmbientSoundDefinition|WorldAmbientSoundDefinition[]|nil
---@field icon_draw_specification IconDrawSpecification|nil
---@field icons_positioning IconSequencePositioning[]|nil
---@field order Order|nil

---@class EntityWithHealthPrototype: EntityPrototype
---@field max_health number|nil
---@field healing_per_tick number|nil
---@field repair_speed_modifier number|nil
---@field dying_explosion ExplosionDefinition|ExplosionDefinition[]|nil
---@field dying_trigger_effect TriggerEffect|nil
---@field damaged_trigger_effect TriggerEffect|nil
---@field loot LootItem[]|nil
---@field resistances Resistance[]|nil
---@field attack_reaction AttackReactionItem|AttackReactionItem[]|nil
---@field repair_sound Sound|nil
---@field alert_when_damaged boolean|nil
---@field hide_resistances boolean|nil
---@field create_ghost_on_death boolean|nil
---@field random_corpse_variation boolean|nil
---@field integration_patch_render_layer RenderLayer|nil
---@field corpse EntityID|EntityID[]|nil
---@field integration_patch Sprite4Way|nil
---@field overkill_fraction number|nil

---@class EntityWithOwnerPrototype: EntityWithHealthPrototype
---@field is_military_target boolean|nil
---@field allow_run_time_change_of_is_military_target boolean|nil
---@field quality_indicator_shift Vector|nil
---@field quality_indicator_scale number|nil

---@class EquipArmorAchievementPrototype: AchievementPrototype
---@field armor ItemID
---@field alternative_armor ItemID
---@field limit_quality QualityID
---@field amount integer|nil
---@field limited_to_one_game boolean|nil

---@class EquipmentCategory: Prototype

---@class EquipmentGhostPrototype: EquipmentPrototype
---@field energy_source ElectricEnergySource|nil
---@field shape EquipmentShape|nil
---@field categories EquipmentCategoryID[]|nil
---@field take_result ItemID|nil

---@class EquipmentGridPrototype: Prototype
---@field equipment_categories EquipmentCategoryID[]
---@field width integer
---@field height integer
---@field locked boolean|nil

---@class EquipmentPrototype: Prototype
---@field sprite Sprite
---@field shape EquipmentShape
---@field categories EquipmentCategoryID[]
---@field energy_source ElectricEnergySource
---@field take_result ItemID|nil
---@field background_color Color|nil
---@field background_border_color Color|nil
---@field grabbed_background_color Color|nil

---@class ExplosionPrototype: EntityPrototype
---@field animations AnimationVariations
---@field sound Sound|nil
---@field smoke TrivialSmokeID|nil
---@field height number|nil
---@field smoke_slow_down_factor number|nil
---@field smoke_count integer|nil
---@field rotate boolean|nil
---@field beam boolean|nil
---@field correct_rotation boolean|nil
---@field scale_animation_speed boolean|nil
---@field fade_in_duration integer|nil
---@field fade_out_duration integer|nil
---@field render_layer RenderLayer|nil
---@field scale_in_duration integer|nil
---@field scale_out_duration integer|nil
---@field scale_end number|nil
---@field scale_increment_per_tick number|nil
---@field light_intensity_factor_initial number|nil
---@field light_intensity_factor_final number|nil
---@field light_size_factor_initial number|nil
---@field light_size_factor_final number|nil
---@field light LightDefinition|nil
---@field light_intensity_peak_start_progress number|nil
---@field light_intensity_peak_end_progress number|nil
---@field light_size_peak_start_progress number|nil
---@field light_size_peak_end_progress number|nil
---@field scale_initial number|nil
---@field scale_initial_deviation number|nil
---@field scale number|nil
---@field scale_deviation number|nil
---@field delay integer|nil
---@field delay_deviation integer|nil
---@field explosion_effect Trigger|nil

---@class FireFlamePrototype: EntityPrototype
---@field damage_per_tick DamageParameters
---@field spread_delay integer
---@field spread_delay_deviation integer
---@field render_layer RenderLayer|nil
---@field initial_render_layer RenderLayer|nil
---@field secondary_render_layer RenderLayer|nil
---@field small_tree_fire_pictures AnimationVariations|nil
---@field pictures AnimationVariations|nil
---@field smoke_source_pictures AnimationVariations|nil
---@field secondary_pictures AnimationVariations|nil
---@field burnt_patch_pictures SpriteVariations|nil
---@field secondary_picture_fade_out_start integer|nil
---@field secondary_picture_fade_out_duration integer|nil
---@field spawn_entity EntityID|nil
---@field smoke SmokeSource[]|nil
---@field maximum_spread_count integer|nil
---@field initial_flame_count integer|nil
---@field uses_alternative_behavior boolean|nil
---@field limit_overlapping_particles boolean|nil
---@field tree_dying_factor number|nil
---@field fade_in_duration integer|nil
---@field fade_out_duration integer|nil
---@field initial_lifetime integer|nil
---@field damage_multiplier_decrease_per_tick number|nil
---@field damage_multiplier_increase_per_added_fuel number|nil
---@field maximum_damage_multiplier number|nil
---@field lifetime_increase_by integer|nil
---@field lifetime_increase_cooldown integer|nil
---@field maximum_lifetime integer|nil
---@field add_fuel_cooldown integer|nil
---@field delay_between_initial_flames integer|nil
---@field smoke_fade_in_duration integer|nil
---@field smoke_fade_out_duration integer|nil
---@field on_fuel_added_action Trigger|nil
---@field on_damage_tick_effect Trigger|nil
---@field light LightDefinition|nil
---@field light_size_modifier_per_flame number|nil
---@field light_size_modifier_maximum number|nil
---@field particle_alpha_blend_duration integer|nil
---@field burnt_patch_lifetime integer|nil
---@field burnt_patch_alpha_default number|nil
---@field particle_alpha number|nil
---@field particle_alpha_deviation number|nil
---@field flame_alpha number|nil
---@field flame_alpha_deviation number|nil
---@field burnt_patch_alpha_variations TileAndAlpha[]|nil

---@class FishPrototype: EntityWithHealthPrototype
---@field pictures SpriteVariations|nil

---@class FluidPrototype: Prototype
---@field icons IconData[]|nil
---@field icon FileName|nil
---@field icon_size SpriteSizeType|nil
---@field default_temperature number
---@field base_color Color
---@field flow_color Color
---@field visualization_color Color|nil
---@field max_temperature number|nil
---@field heat_capacity Energy|nil
---@field fuel_value Energy|nil
---@field emissions_multiplier number|nil
---@field gas_temperature number|nil
---@field auto_barrel boolean|nil
---@field hidden boolean|nil

---@class FluidStreamPrototype: EntityPrototype
---@field particle_spawn_interval integer
---@field particle_horizontal_speed number
---@field particle_horizontal_speed_deviation number
---@field particle_vertical_acceleration number
---@field initial_action Trigger|nil
---@field action Trigger|nil
---@field special_neutral_target_damage DamageParameters|nil
---@field width number|nil
---@field particle_buffer_size integer|nil
---@field particle_spawn_timeout integer|nil
---@field particle_start_alpha number|nil
---@field particle_end_alpha number|nil
---@field particle_start_scale number|nil
---@field particle_alpha_per_part number|nil
---@field particle_scale_per_part number|nil
---@field particle_fade_out_threshold number|nil
---@field particle_loop_exit_threshold number|nil
---@field particle_loop_frame_count integer|nil
---@field particle_fade_out_duration integer|nil
---@field spine_animation Animation|nil
---@field particle Animation|nil
---@field shadow Animation|nil
---@field smoke_sources SmokeSource[]|nil
---@field progress_to_create_smoke number|nil
---@field stream_light LightDefinition|nil
---@field ground_light LightDefinition|nil
---@field target_position_deviation number|nil
---@field oriented_particle boolean|nil
---@field shadow_scale_enabled boolean|nil
---@field target_initial_position_only boolean|nil

---@class FluidTurretPrototype: TurretPrototype
---@field fluid_buffer_size FluidAmount
---@field fluid_buffer_input_flow FluidAmount
---@field activation_buffer_ratio FluidAmount
---@field fluid_box FluidBox
---@field muzzle_light LightDefinition|nil
---@field enough_fuel_indicator_light LightDefinition|nil
---@field not_enough_fuel_indicator_light LightDefinition|nil
---@field muzzle_animation Animation|nil
---@field folded_muzzle_animation_shift AnimatedVector|nil
---@field preparing_muzzle_animation_shift AnimatedVector|nil
---@field prepared_muzzle_animation_shift AnimatedVector|nil
---@field starting_attack_muzzle_animation_shift AnimatedVector|nil
---@field attacking_muzzle_animation_shift AnimatedVector|nil
---@field ending_attack_muzzle_animation_shift AnimatedVector|nil
---@field folding_muzzle_animation_shift AnimatedVector|nil
---@field enough_fuel_indicator_picture Sprite4Way|nil
---@field not_enough_fuel_indicator_picture Sprite4Way|nil
---@field out_of_ammo_alert_icon Sprite|nil
---@field turret_base_has_direction true
---@field attack_parameters StreamAttackParameters

---@class FluidWagonPrototype: RollingStockPrototype
---@field capacity FluidAmount
---@field quality_affects_capacity boolean|nil
---@field tank_count integer|nil
---@field connection_category string|string[]|nil

---@class FlyingRobotPrototype: EntityWithOwnerPrototype
---@field speed number
---@field max_speed number|nil
---@field max_energy Energy|nil
---@field energy_per_move Energy|nil
---@field energy_per_tick Energy|nil
---@field min_to_charge number|nil
---@field max_to_charge number|nil
---@field speed_multiplier_when_out_of_energy number|nil
---@field is_military_target boolean|nil

---@class FontPrototype
---@field type "font"
---@field name string
---@field size integer
---@field from string
---@field spacing number|nil
---@field border boolean|nil
---@field filtered boolean|nil
---@field border_color Color|nil

---@class FuelCategory: Prototype
---@field fuel_value_type LocalisedString|nil

---@class FurnacePrototype: CraftingMachinePrototype
---@field result_inventory_size ItemStackIndex
---@field source_inventory_size ItemStackIndex
---@field cant_insert_at_source_message_key string|nil
---@field custom_input_slot_tooltip_key string|nil
---@field circuit_connector table|nil
---@field circuit_connector_flipped table|nil
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field default_recipe_finished_signal SignalIDConnector|nil
---@field default_working_signal SignalIDConnector|nil

---@class FusionGeneratorPrototype: EntityWithOwnerPrototype
---@field energy_source ElectricEnergySource
---@field graphics_set FusionGeneratorGraphicsSet|nil
---@field input_fluid_box FluidBox
---@field output_fluid_box FluidBox
---@field max_fluid_usage FluidAmount
---@field perceived_performance PerceivedPerformance|nil
---@field burns_fluid boolean|nil
---@field effectivity number|nil

---@class FusionReactorPrototype: EntityWithOwnerPrototype
---@field energy_source ElectricEnergySource
---@field burner BurnerEnergySource
---@field graphics_set FusionReactorGraphicsSet
---@field input_fluid_box FluidBox
---@field output_fluid_box FluidBox
---@field neighbour_connectable NeighbourConnectable|nil
---@field two_direction_only boolean|nil
---@field neighbour_bonus number|nil
---@field power_input Energy
---@field max_fluid_usage FluidAmount
---@field target_temperature number|nil
---@field perceived_performance PerceivedPerformance|nil

---@class GatePrototype: EntityWithOwnerPrototype
---@field vertical_animation Animation|nil
---@field horizontal_animation Animation|nil
---@field vertical_rail_animation_left Animation|nil
---@field vertical_rail_animation_right Animation|nil
---@field horizontal_rail_animation_left Animation|nil
---@field horizontal_rail_animation_right Animation|nil
---@field vertical_rail_base Animation|nil
---@field horizontal_rail_base Animation|nil
---@field wall_patch Animation|nil
---@field opening_speed number
---@field activation_distance number
---@field timeout_to_close integer
---@field opening_sound Sound|nil
---@field closing_sound Sound|nil
---@field fadeout_interval integer|nil
---@field opened_collision_mask CollisionMaskConnector|nil

---@class GeneratorEquipmentPrototype: EquipmentPrototype
---@field power Energy
---@field burner BurnerEnergySource|nil

---@class GeneratorPrototype: EntityWithOwnerPrototype
---@field energy_source ElectricEnergySource
---@field fluid_box FluidBox
---@field horizontal_animation Animation|nil
---@field vertical_animation Animation|nil
---@field horizontal_frozen_patch Sprite|nil
---@field vertical_frozen_patch Sprite|nil
---@field effectivity number|nil
---@field fluid_usage_per_tick FluidAmount
---@field maximum_temperature number
---@field smoke SmokeSource[]|nil
---@field burns_fluid boolean|nil
---@field scale_fluid_usage boolean|nil
---@field destroy_non_fuel_fluid boolean|nil
---@field perceived_performance PerceivedPerformance|nil
---@field max_power_output Energy|nil

---@class GodControllerPrototype
---@field type "god-controller"
---@field name string
---@field inventory_size ItemStackIndex
---@field movement_speed number
---@field item_pickup_distance number
---@field loot_pickup_distance number
---@field mining_speed number
---@field crafting_categories RecipeCategoryID[]|nil
---@field mining_categories ResourceCategoryID[]|nil

---@class GroupAttackAchievementPrototype: AchievementPrototype
---@field amount integer|nil
---@field entities EntityID[]|nil
---@field attack_type "autonomous"|"distraction"|"scripted"|nil

---@class GuiStyle: PrototypeBase
---@field default_tileset FileName|nil
---@field default_sprite_scale number|nil
---@field default_sprite_priority SpritePriority|nil
---@field [string] StyleSpecification

---@class GunPrototype: ItemPrototype
---@field attack_parameters AttackParameters

---@class HalfDiagonalRailPrototype: RailPrototype
---@field collision_box BoundingBox|nil

---@class HeatInterfacePrototype: EntityWithOwnerPrototype
---@field heat_buffer HeatBuffer
---@field picture Sprite|nil
---@field gui_mode "all"|"none"|"admins"|nil
---@field heating_radius number|nil

---@class HeatPipePrototype: EntityWithOwnerPrototype
---@field connection_sprites ConnectableEntityGraphics|nil
---@field heat_glow_sprites ConnectableEntityGraphics|nil
---@field heat_buffer HeatBuffer
---@field heating_radius number|nil

---@class HighlightBoxEntityPrototype: EntityPrototype

---@class ImpactCategory
---@field type "impact-category"
---@field name string

---@class InfinityCargoWagonPrototype: CargoWagonPrototype
---@field erase_contents_when_mined boolean|nil
---@field preserve_contents_when_created boolean|nil
---@field gui_mode "all"|"none"|"admins"|nil

---@class InfinityContainerPrototype: LogisticContainerPrototype
---@field erase_contents_when_mined boolean
---@field preserve_contents_when_created boolean|nil
---@field gui_mode "all"|"none"|"admins"|nil
---@field logistic_mode "active-provider"|"passive-provider"|"requester"|"storage"|"buffer"|nil
---@field render_not_in_network_icon boolean|nil
---@field inventory_size ItemStackIndex

---@class InfinityPipePrototype: PipePrototype
---@field gui_mode "all"|"none"|"admins"|nil

---@class InserterPrototype: EntityWithOwnerPrototype
---@field extension_speed number
---@field rotation_speed number
---@field starting_distance number|nil
---@field insert_position Vector
---@field pickup_position Vector
---@field platform_picture Sprite4Way|nil
---@field platform_frozen Sprite4Way|nil
---@field hand_base_picture Sprite|nil
---@field hand_open_picture Sprite|nil
---@field hand_closed_picture Sprite|nil
---@field hand_base_frozen Sprite|nil
---@field hand_open_frozen Sprite|nil
---@field hand_closed_frozen Sprite|nil
---@field hand_base_shadow Sprite|nil
---@field hand_open_shadow Sprite|nil
---@field hand_closed_shadow Sprite|nil
---@field energy_source EnergySource
---@field energy_per_movement Energy|nil
---@field energy_per_rotation Energy|nil
---@field bulk boolean|nil
---@field uses_inserter_stack_size_bonus boolean|nil
---@field allow_custom_vectors boolean|nil
---@field allow_burner_leech boolean|nil
---@field draw_held_item boolean|nil
---@field use_easter_egg boolean|nil
---@field grab_less_to_match_belt_stack boolean|nil
---@field wait_for_full_hand boolean|nil
---@field enter_drop_mode_if_held_stack_spoiled boolean|nil
---@field max_belt_stack_size integer|nil
---@field filter_count integer|nil
---@field hand_size number|nil
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field default_stack_control_input_signal SignalIDConnector|nil
---@field draw_inserter_arrow boolean|nil
---@field chases_belt_items boolean|nil
---@field stack_size_bonus integer|nil
---@field circuit_connector table|nil

---@class InventoryBonusEquipmentPrototype: EquipmentPrototype
---@field inventory_size_bonus ItemStackIndex
---@field energy_source ElectricEnergySource|nil

---@class ItemEntityPrototype: EntityPrototype
---@field collision_box BoundingBox|nil

---@class ItemGroup: Prototype
---@field icons IconData[]|nil
---@field icon FileName|nil
---@field icon_size SpriteSizeType|nil
---@field order_in_recipe Order|nil

---@class ItemPrototype: Prototype
---@field stack_size ItemCountType
---@field icons IconData[]|nil
---@field icon FileName|nil
---@field icon_size SpriteSizeType|nil
---@field dark_background_icons IconData[]|nil
---@field dark_background_icon FileName|nil
---@field dark_background_icon_size SpriteSizeType|nil
---@field place_result EntityID|nil
---@field place_as_equipment_result EquipmentID|nil
---@field fuel_category FuelCategoryID|nil
---@field burnt_result ItemID|nil
---@field spoil_result ItemID|nil
---@field plant_result EntityID|nil
---@field place_as_tile PlaceAsTile|nil
---@field pictures SpriteVariations|nil
---@field flags ItemPrototypeFlags|nil
---@field spoil_ticks integer|nil
---@field fuel_value Energy|nil
---@field fuel_acceleration_multiplier number|nil
---@field fuel_top_speed_multiplier number|nil
---@field fuel_emissions_multiplier number|nil
---@field fuel_acceleration_multiplier_quality_bonus number|nil
---@field fuel_top_speed_multiplier_quality_bonus number|nil
---@field weight Weight|nil
---@field ingredient_to_weight_coefficient number|nil
---@field fuel_glow_color Color|nil
---@field open_sound Sound|nil
---@field close_sound Sound|nil
---@field pick_sound Sound|nil
---@field drop_sound Sound|nil
---@field inventory_move_sound Sound|nil
---@field default_import_location SpaceLocationID|nil
---@field color_hint ColorHintSpecification|nil
---@field has_random_tint boolean|nil
---@field spoil_to_trigger_result SpoilToTriggerResult|nil
---@field destroyed_by_dropping_trigger Trigger|nil
---@field rocket_launch_products ItemProductPrototype[]|nil
---@field send_to_orbit_mode SendToOrbitMode|nil
---@field moved_to_hub_when_building boolean|nil
---@field random_tint_color Color|nil
---@field spoil_level integer|nil
---@field auto_recycle boolean|nil
---@field hidden boolean|nil

---@class ItemRequestProxyPrototype: EntityPrototype
---@field use_target_entity_alert_icon_shift boolean|nil

---@class ItemSubGroup: Prototype
---@field group ItemGroupID

---@class ItemWithEntityDataPrototype: ItemPrototype
---@field icon_tintable_masks IconData[]|nil
---@field icon_tintable_mask FileName|nil
---@field icon_tintable_mask_size SpriteSizeType|nil
---@field icon_tintables IconData[]|nil
---@field icon_tintable FileName|nil
---@field icon_tintable_size SpriteSizeType|nil

---@class ItemWithInventoryPrototype: ItemWithLabelPrototype
---@field inventory_size ItemStackIndex
---@field item_filters ItemID[]|nil
---@field item_group_filters ItemGroupID[]|nil
---@field item_subgroup_filters ItemSubGroupID[]|nil
---@field filter_mode "blacklist"|"whitelist"|nil
---@field filter_message_key string|nil
---@field stack_size 1

---@class ItemWithLabelPrototype: ItemPrototype
---@field default_label_color Color|nil
---@field draw_label_for_cursor_render boolean|nil

---@class ItemWithTagsPrototype: ItemWithLabelPrototype

---@class KillAchievementPrototype: AchievementPrototype
---@field to_kill EntityID|EntityID[]|nil
---@field type_to_kill string|nil
---@field damage_type DamageTypeID|nil
---@field damage_dealer EntityID|EntityID[]|nil
---@field amount integer|nil
---@field in_vehicle boolean|nil
---@field personally boolean|nil

---@class LabPrototype: EntityWithOwnerPrototype
---@field energy_usage Energy
---@field energy_source EnergySource
---@field on_animation Animation|nil
---@field off_animation Animation|nil
---@field frozen_patch Sprite|nil
---@field inputs ItemID[]
---@field researching_speed number|nil
---@field effect_receiver EffectReceiver|nil
---@field module_slots ItemStackIndex|nil
---@field quality_affects_module_slots boolean|nil
---@field uses_quality_drain_modifier boolean|nil
---@field science_pack_drain_rate_percent integer|nil
---@field allowed_effects EffectTypeLimitation|nil
---@field allowed_module_categories ModuleCategoryID[]|nil
---@field light LightDefinition|nil
---@field trash_inventory_size ItemStackIndex|nil

---@class LampPrototype: EntityWithOwnerPrototype
---@field picture_on Sprite|nil
---@field picture_off Sprite|nil
---@field energy_usage_per_tick Energy
---@field energy_source ElectricEnergySource|VoidEnergySource
---@field light LightDefinition|nil
---@field light_when_colored LightDefinition|nil
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field circuit_connector CircuitConnectorDefinition|nil
---@field glow_size number|nil
---@field glow_color_intensity number|nil
---@field darkness_for_all_lamps_on number|nil
---@field darkness_for_all_lamps_off number|nil
---@field always_on boolean|nil
---@field signal_to_color_mapping SignalColorMapping[]|nil
---@field glow_render_mode "additive"|"multiplicative"|nil
---@field default_red_signal SignalIDConnector|nil
---@field default_green_signal SignalIDConnector|nil
---@field default_blue_signal SignalIDConnector|nil
---@field default_rgb_signal SignalIDConnector|nil

---@class LandMinePrototype: EntityWithOwnerPrototype
---@field picture_safe Sprite|nil
---@field picture_set Sprite|nil
---@field trigger_radius number
---@field picture_set_enemy Sprite|nil
---@field timeout integer|nil
---@field trigger_interval integer|nil
---@field action Trigger|nil
---@field ammo_category AmmoCategoryID|nil
---@field force_die_on_attack boolean|nil
---@field trigger_force ForceCondition|nil
---@field trigger_collision_mask CollisionMaskConnector|nil
---@field is_military_target boolean|nil

---@class LaneSplitterPrototype: TransportBeltConnectablePrototype
---@field structure_animation_speed_coefficient number|nil
---@field structure_animation_movement_cooldown integer|nil
---@field structure Animation4Way
---@field structure_patch Animation4Way|nil

---@class LegacyCurvedRailPrototype: RailPrototype
---@field collision_box BoundingBox|nil

---@class LegacyStraightRailPrototype: RailPrototype
---@field collision_box BoundingBox|nil

---@class LightningAttractorPrototype: EntityWithOwnerPrototype
---@field chargable_graphics ChargableGraphics|nil
---@field lightning_strike_offset MapPosition|nil
---@field efficiency number|nil
---@field range_elongation number|nil
---@field energy_source ElectricEnergySource|nil

---@class LightningPrototype: EntityPrototype
---@field graphics_set LightningGraphicsSet|nil
---@field sound Sound|nil
---@field attracted_volume_modifier number|nil
---@field strike_effect Trigger|nil
---@field attractor_hit_effect Trigger|nil
---@field source_offset Vector|nil
---@field source_variance Vector|nil
---@field damage number|nil
---@field energy Energy|nil
---@field time_to_damage integer|nil
---@field effect_duration integer

---@class LinkedBeltPrototype: TransportBeltConnectablePrototype
---@field structure LinkedBeltStructure|nil
---@field structure_render_layer RenderLayer|nil
---@field allow_clone_connection boolean|nil
---@field allow_blueprint_connection boolean|nil
---@field allow_side_loading boolean|nil

---@class LinkedContainerPrototype: EntityWithOwnerPrototype
---@field inventory_size ItemStackIndex
---@field picture Sprite|nil
---@field inventory_type "normal"|"with_bar"|"with_filters_and_bar"|"with_custom_stack_size"|"with_weight_limit"|nil
---@field inventory_properties InventoryWithCustomStackSizeSpecification|nil
---@field inventory_weight_limit Weight|nil
---@field gui_mode "all"|"none"|"admins"|nil
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field circuit_connector CircuitConnectorDefinition|nil

---@class Loader1x1Prototype: LoaderPrototype

---@class Loader1x2Prototype: LoaderPrototype

---@class LoaderPrototype: TransportBeltConnectablePrototype
---@field structure LoaderStructure|nil
---@field filter_count integer
---@field structure_render_layer RenderLayer|nil
---@field circuit_connector_layer RenderLayer|nil
---@field container_distance number|nil
---@field allow_rail_interaction boolean|nil
---@field allow_container_interaction boolean|nil
---@field per_lane_filters boolean|nil
---@field max_belt_stack_size integer|nil
---@field adjustable_belt_stack_size boolean|nil
---@field wait_for_full_stack boolean|nil
---@field respect_insert_limits boolean|nil
---@field belt_length number|nil
---@field energy_source ElectricEnergySource|HeatEnergySource|FluidEnergySource|VoidEnergySource|nil
---@field energy_per_item Energy|nil
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field circuit_connector CircuitConnectorDefinition[]|nil

---@class LocomotivePrototype: RollingStockPrototype
---@field max_power Energy
---@field reversing_power_modifier number
---@field energy_source BurnerEnergySource|VoidEnergySource
---@field front_light LightDefinition|nil
---@field front_light_pictures RollingStockRotatedSlopedGraphics|nil
---@field darkness_to_render_light_animation number|nil
---@field max_snap_to_train_stop_distance number|nil

---@class LogisticContainerPrototype: ContainerPrototype
---@field logistic_mode "active-provider"|"passive-provider"|"requester"|"storage"|"buffer"
---@field max_logistic_slots integer|nil
---@field trash_inventory_size ItemStackIndex|nil
---@field render_not_in_network_icon boolean|nil
---@field opened_duration integer|nil
---@field animation Animation|nil
---@field landing_location_offset Vector|nil
---@field use_exact_mode boolean|nil
---@field animation_sound Sound|nil

---@class LogisticRobotPrototype: RobotWithLogisticInterfacePrototype
---@field idle_with_cargo RotatedAnimation|nil
---@field in_motion_with_cargo RotatedAnimation|nil
---@field shadow_idle_with_cargo RotatedAnimation|nil
---@field shadow_in_motion_with_cargo RotatedAnimation|nil
---@field collision_box BoundingBox|nil

---@class MapGenPresets
---@field type "map-gen-presets"
---@field name string
---@field [string] MapGenPreset

---@class MapSettings
---@field type "map-settings"
---@field name string
---@field pollution PollutionSettings
---@field steering SteeringSettings
---@field enemy_evolution EnemyEvolutionSettings
---@field enemy_expansion EnemyExpansionSettings
---@field unit_group UnitGroupSettings
---@field path_finder PathFinderSettings
---@field max_failed_behavior_count integer
---@field difficulty_settings DifficultySettings
---@field asteroids AsteroidSettings

---@class MarketPrototype: EntityWithOwnerPrototype
---@field picture Sprite|nil
---@field allow_access_to_all_forces boolean|nil

---@class MiningDrillPrototype: EntityWithOwnerPrototype
---@field vector_to_place_result Vector
---@field resource_searching_radius number
---@field resource_searching_offset Vector|nil
---@field energy_usage Energy
---@field mining_speed number
---@field energy_source EnergySource
---@field resource_categories ResourceCategoryID[]
---@field output_fluid_box FluidBox|nil
---@field input_fluid_box FluidBox|nil
---@field graphics_set MiningDrillGraphicsSet|nil
---@field wet_mining_graphics_set MiningDrillGraphicsSet|nil
---@field perceived_performance PerceivedPerformance|nil
---@field base_picture Sprite4Way|nil
---@field effect_receiver EffectReceiver|nil
---@field module_slots ItemStackIndex|nil
---@field quality_affects_module_slots boolean|nil
---@field allowed_effects EffectTypeLimitation|nil
---@field allowed_module_categories ModuleCategoryID[]|nil
---@field radius_visualisation_picture Sprite|nil
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field base_render_layer RenderLayer|nil
---@field resource_drain_rate_percent integer|nil
---@field shuffle_resources_to_mine boolean|nil
---@field drops_full_belt_stacks boolean|nil
---@field uses_force_mining_productivity_bonus boolean|nil
---@field quality_affects_mining_radius boolean|nil
---@field moving_sound InterruptibleSound|nil
---@field drilling_sound InterruptibleSound|nil
---@field drilling_sound_animation_start_frame integer|nil
---@field drilling_sound_animation_end_frame integer|nil
---@field monitor_visualization_tint Color|nil
---@field circuit_connector table|nil
---@field filter_count integer|nil

---@class ModData: Prototype
---@field data_type string|nil
---@field data table<string, any>

---@class ModuleCategory: Prototype

---@class ModulePrototype: ItemPrototype
---@field category ModuleCategoryID
---@field tier integer
---@field effect Effect
---@field requires_beacon_alt_mode boolean|nil
---@field art_style string|nil
---@field beacon_tint BeaconVisualizationTints|nil

---@class ModuleTransferAchievementPrototype: AchievementPrototype
---@field module ItemID|ItemID[]
---@field amount integer|nil
---@field limited_to_one_game boolean|nil

---@class MouseCursor
---@field type "mouse-cursor"
---@field name string
---@field system_cursor "arrow"|"i-beam"|"crosshair"|"wait-arrow"|"size-all"|"no"|"hand"|nil
---@field filename FileName|nil
---@field hot_pixel_x integer|nil
---@field hot_pixel_y integer|nil

---@class MovementBonusEquipmentPrototype: EquipmentPrototype
---@field energy_consumption Energy
---@field movement_bonus number

---@class NamedNoiseExpression: Prototype
---@field expression NoiseExpression
---@field local_expressions table<string, NoiseExpression>|nil
---@field local_functions table<string, NoiseFunction>|nil
---@field intended_property string|nil
---@field order Order|nil

---@class NamedNoiseFunction: Prototype
---@field parameters string[]
---@field expression NoiseExpression
---@field local_expressions table<string, NoiseExpression>|nil
---@field local_functions table<string, NoiseFunction>|nil

---@class NightVisionEquipmentPrototype: EquipmentPrototype
---@field energy_input Energy
---@field color_lookup DaytimeColorLookupTable
---@field darkness_to_turn_on number|nil
---@field activate_sound Sound|nil
---@field deactivate_sound Sound|nil

---@class OffshorePumpPrototype: EntityWithOwnerPrototype
---@field fluid_box FluidBox
---@field pumping_speed FluidAmount
---@field fluid_source_offset Vector
---@field perceived_performance PerceivedPerformance|nil
---@field graphics_set OffshorePumpGraphicsSet|nil
---@field energy_source EnergySource
---@field energy_usage Energy
---@field remove_on_tile_collision boolean|nil
---@field always_draw_fluid boolean|nil
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field circuit_connector table|nil

---@class ParticlePrototype: Prototype
---@field pictures AnimationVariations|nil
---@field life_time integer
---@field shadows AnimationVariations|nil
---@field draw_shadow_when_on_ground boolean|nil
---@field regular_trigger_effect TriggerEffect|nil
---@field ended_in_water_trigger_effect TriggerEffect|nil
---@field ended_on_ground_trigger_effect TriggerEffect|nil
---@field render_layer RenderLayer|nil
---@field render_layer_when_on_ground RenderLayer|nil
---@field regular_trigger_effect_frequency integer|nil
---@field movement_modifier_when_on_ground number|nil
---@field movement_modifier number|nil
---@field vertical_acceleration number|nil
---@field mining_particle_frame_speed number|nil
---@field fade_away_duration integer|nil

---@class ParticleSourcePrototype: EntityPrototype
---@field time_to_live number
---@field time_before_start number
---@field height number
---@field vertical_speed number
---@field horizontal_speed number
---@field particle ParticleID|nil
---@field smoke SmokeSource[]|nil
---@field time_to_live_deviation number|nil
---@field time_before_start_deviation number|nil
---@field height_deviation number|nil
---@field vertical_speed_deviation number|nil
---@field horizontal_speed_deviation number|nil

---@class PipePrototype: EntityWithOwnerPrototype
---@field fluid_box FluidBox
---@field horizontal_window_bounding_box BoundingBox
---@field vertical_window_bounding_box BoundingBox
---@field pictures PipePictures|nil

---@class PipeToGroundPrototype: EntityWithOwnerPrototype
---@field fluid_box FluidBox
---@field pictures Sprite4Way|nil
---@field frozen_patch Sprite4Way|nil
---@field visualization Sprite4Way|nil
---@field disabled_visualization Sprite4Way|nil
---@field draw_fluid_icon_override boolean|nil

---@class PlaceEquipmentAchievementPrototype: AchievementPrototype
---@field armor ItemID
---@field limit_quality QualityID
---@field limit_equip_quality QualityID
---@field amount integer|nil
---@field limited_to_one_game boolean|nil

---@class PlanetPrototype: SpaceLocationPrototype
---@field map_seed_offset integer|nil
---@field entities_require_heating boolean|nil
---@field pollutant_type AirbornePollutantID|nil
---@field persistent_ambient_sounds PersistentWorldAmbientSoundsDefinition|nil
---@field surface_render_parameters SurfaceRenderParameters|nil
---@field player_effects Trigger|nil
---@field ticks_between_player_effects integer|nil
---@field map_gen_settings PlanetPrototypeMapGenSettings|nil
---@field surface_properties table<SurfacePropertyID, number>|nil
---@field lightning_properties LightningProperties|nil

---@class PlantPrototype: TreePrototype
---@field growth_ticks integer
---@field harvest_emissions table<AirbornePollutantID, number>|nil
---@field agricultural_tower_tint RecipeTints|nil

---@class PlayerDamagedAchievementPrototype: AchievementPrototype
---@field minimum_damage number
---@field should_survive boolean
---@field type_of_dealer string|nil

---@class PlayerPortPrototype: EntityWithOwnerPrototype

---@class PowerSwitchPrototype: EntityWithOwnerPrototype
---@field power_on_animation Animation|nil
---@field overlay_start Animation|nil
---@field overlay_loop Animation|nil
---@field led_on Sprite|nil
---@field led_off Sprite|nil
---@field frozen_patch Sprite|nil
---@field overlay_start_delay integer
---@field circuit_wire_connection_point WireConnectionPoint
---@field left_wire_connection_point WireConnectionPoint
---@field right_wire_connection_point WireConnectionPoint
---@field wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil

---@class ProcessionLayerInheritanceGroup: Prototype
---@field intermezzo_application TransitionApplication|nil
---@field arrival_application TransitionApplication|nil

---@class ProcessionPrototype: Prototype
---@field timeline ProcessionTimeline
---@field ground_timeline ProcessionTimeline|nil
---@field usage "departure"|"arrival"|"intermezzo"
---@field procession_style integer|integer[]

---@class ProduceAchievementPrototype: AchievementPrototype
---@field amount MaterialAmountType
---@field limited_to_one_game boolean
---@field item_product ItemIDFilter|nil
---@field fluid_product FluidID|nil

---@class ProducePerHourAchievementPrototype: AchievementPrototype
---@field amount MaterialAmountType
---@field item_product ItemIDFilter|nil
---@field fluid_product FluidID|nil

---@class ProgrammableSpeakerPrototype: EntityWithOwnerPrototype
---@field energy_source ElectricEnergySource|VoidEnergySource
---@field energy_usage_per_tick Energy
---@field sprite Sprite|nil
---@field maximum_polyphony integer
---@field instruments ProgrammableSpeakerInstrument[]
---@field audible_distance_modifier number|nil
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field circuit_connector CircuitConnectorDefinition|nil

---@class ProjectilePrototype: EntityPrototype
---@field acceleration number
---@field animation RotatedAnimationVariations|nil
---@field rotatable boolean|nil
---@field enable_drawing_with_mask boolean|nil
---@field direction_only boolean|nil
---@field hit_at_collision_position boolean|nil
---@field force_condition ForceCondition|nil
---@field piercing_damage number|nil
---@field max_speed number|nil
---@field turn_speed number|nil
---@field speed_modifier Vector|nil
---@field height number|nil
---@field action Trigger|nil
---@field final_action Trigger|nil
---@field light LightDefinition|nil
---@field smoke SmokeSource[]|nil
---@field hit_collision_mask CollisionMaskConnector|nil
---@field turning_speed_increases_exponentially_with_projectile_speed boolean|nil
---@field shadow RotatedAnimationVariations|nil

---@class Prototype: PrototypeBase
---@field factoriopedia_alternative string|nil
---@field custom_tooltip_fields CustomTooltipField[]|nil

---@class PrototypeBase
---@field type string
---@field name string
---@field order Order|nil
---@field localised_name LocalisedString|nil
---@field localised_description LocalisedString|nil
---@field factoriopedia_description LocalisedString|nil
---@field subgroup ItemSubGroupID|nil
---@field hidden boolean|nil
---@field hidden_in_factoriopedia boolean|nil
---@field parameter boolean|nil
---@field factoriopedia_simulation SimulationDefinition|nil

---@class ProxyContainerPrototype: EntityWithOwnerPrototype
---@field picture Sprite|nil
---@field draw_inventory_content boolean|nil
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field circuit_connector CircuitConnectorDefinition|nil

---@class PumpPrototype: EntityWithOwnerPrototype
---@field fluid_box FluidBox
---@field energy_source EnergySource
---@field energy_usage Energy
---@field pumping_speed FluidAmount
---@field animations Animation4Way|nil
---@field fluid_wagon_connector_speed number|nil
---@field fluid_wagon_connector_alignment_tolerance number|nil
---@field fluid_wagon_connector_frame_count integer|nil
---@field flow_scaling boolean|nil
---@field fluid_animation Animation4Way|nil
---@field glass_pictures Sprite4Way|nil
---@field frozen_patch Sprite4Way|nil
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field circuit_connector table|nil
---@field fluid_wagon_connector_graphics FluidWagonConnectorGraphics|nil

---@class QualityPrototype: Prototype
---@field draw_sprite_by_default boolean|nil
---@field color Color
---@field level integer
---@field next QualityID|nil
---@field next_probability number|nil
---@field icons IconData[]|nil
---@field icon FileName|nil
---@field icon_size SpriteSizeType|nil
---@field beacon_power_usage_multiplier number|nil
---@field mining_drill_resource_drain_multiplier number|nil
---@field science_pack_drain_multiplier number|nil
---@field name string
---@field default_multiplier number|nil
---@field inserter_speed_multiplier number|nil
---@field fluid_wagon_capacity_multiplier number|nil
---@field inventory_size_multiplier number|nil
---@field lab_research_speed_multiplier number|nil
---@field crafting_machine_speed_multiplier number|nil
---@field crafting_machine_energy_usage_multiplier number|nil
---@field logistic_cell_charging_energy_multiplier number|nil
---@field tool_durability_multiplier number|nil
---@field accumulator_capacity_multiplier number|nil
---@field flying_robot_max_energy_multiplier number|nil
---@field range_multiplier number|nil
---@field asteroid_collector_collection_radius_bonus number|nil
---@field equipment_grid_width_bonus integer|nil
---@field equipment_grid_height_bonus integer|nil
---@field electric_pole_wire_reach_bonus number|nil
---@field electric_pole_supply_area_distance_bonus number|nil
---@field beacon_supply_area_distance_bonus number|nil
---@field mining_drill_mining_radius_bonus number|nil
---@field logistic_cell_charging_station_count_bonus integer|nil
---@field beacon_module_slots_bonus ItemStackIndex|nil
---@field crafting_machine_module_slots_bonus ItemStackIndex|nil
---@field mining_drill_module_slots_bonus ItemStackIndex|nil
---@field lab_module_slots_bonus ItemStackIndex|nil

---@class RadarPrototype: EntityWithOwnerPrototype
---@field energy_usage Energy
---@field energy_per_sector Energy
---@field energy_per_nearby_scan Energy
---@field energy_source EnergySource
---@field pictures RotatedSprite|nil
---@field frozen_patch Sprite|nil
---@field max_distance_of_sector_revealed integer
---@field max_distance_of_nearby_sector_revealed integer
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field circuit_connector CircuitConnectorDefinition|nil
---@field radius_minimap_visualisation_color Color|nil
---@field rotation_speed number|nil
---@field connects_to_other_radars boolean|nil
---@field reset_orientation_when_frozen boolean|nil
---@field energy_fraction_to_connect number|nil
---@field energy_fraction_to_disconnect number|nil
---@field is_military_target boolean|nil

---@class RailChainSignalPrototype: RailSignalBasePrototype

---@class RailPlannerPrototype: ItemPrototype
---@field rails EntityID[]
---@field support EntityID|nil
---@field manual_length_limit number|nil

---@class RailPrototype: EntityWithOwnerPrototype
---@field walking_sound Sound|nil
---@field pictures RailPictureSet
---@field fence_pictures RailFenceGraphicsSet|nil
---@field extra_planner_penalty number|nil
---@field extra_planner_goal_penalty number|nil
---@field forced_fence_segment_count integer|nil
---@field ending_shifts Vector[]|nil
---@field deconstruction_marker_positions Vector[]|nil
---@field removes_soft_decoratives boolean|nil
---@field build_grid_size 2|nil
---@field selection_box BoundingBox|nil

---@class RailRampPrototype: RailPrototype
---@field support_range number|nil
---@field collision_mask_allow_on_deep_oil_ocean CollisionMaskConnector|nil
---@field collision_box BoundingBox|nil
---@field name string

---@class RailRemnantsPrototype: CorpsePrototype
---@field pictures RailPictureSet
---@field related_rail EntityID
---@field secondary_collision_box BoundingBox|nil
---@field build_grid_size 2|nil
---@field collision_box BoundingBox|nil

---@class RailSignalBasePrototype: EntityWithOwnerPrototype
---@field ground_picture_set RailSignalPictureSet
---@field elevated_picture_set RailSignalPictureSet
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field default_red_output_signal SignalIDConnector|nil
---@field default_orange_output_signal SignalIDConnector|nil
---@field default_green_output_signal SignalIDConnector|nil
---@field default_blue_output_signal SignalIDConnector|nil
---@field elevated_collision_mask CollisionMaskConnector|nil
---@field elevated_selection_priority integer|nil
---@field collision_box BoundingBox|nil
---@field flags EntityPrototypeFlags|nil

---@class RailSignalPrototype: RailSignalBasePrototype

---@class RailSupportPrototype: EntityWithOwnerPrototype
---@field graphics_set RailSupportGraphicsSet
---@field support_range number|nil
---@field not_buildable_if_no_rails boolean|nil
---@field snap_to_spots_distance number|nil
---@field collision_mask_allow_on_deep_oil_ocean CollisionMaskConnector|nil
---@field elevated_selection_boxes BoundingBox[]|nil
---@field build_grid_size 2|nil
---@field name string

---@class ReactorPrototype: EntityWithOwnerPrototype
---@field working_light_picture Animation|nil
---@field heat_buffer HeatBuffer
---@field heating_radius number|nil
---@field energy_source EnergySource
---@field consumption Energy
---@field connection_patches_connected SpriteVariations|nil
---@field connection_patches_disconnected SpriteVariations|nil
---@field heat_connection_patches_connected SpriteVariations|nil
---@field heat_connection_patches_disconnected SpriteVariations|nil
---@field lower_layer_picture Sprite|nil
---@field heat_lower_layer_picture Sprite|nil
---@field picture Sprite|nil
---@field light LightDefinition|nil
---@field meltdown_action Trigger|nil
---@field neighbour_bonus number|nil
---@field scale_energy_usage boolean|nil
---@field use_fuel_glow_color boolean|nil
---@field default_fuel_glow_color Color|nil
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field circuit_connector CircuitConnectorDefinition|nil
---@field default_temperature_signal SignalIDConnector|nil

---@class RecipeCategory: Prototype

---@class RecipePrototype: Prototype
---@field category RecipeCategoryID|nil
---@field additional_categories RecipeCategoryID[]|nil
---@field crafting_machine_tint RecipeTints|nil
---@field icons IconData[]|nil
---@field icon FileName|nil
---@field icon_size SpriteSizeType|nil
---@field ingredients IngredientPrototype[]|nil
---@field results ProductPrototype[]|nil
---@field main_product string|nil
---@field energy_required number|nil
---@field emissions_multiplier number|nil
---@field maximum_productivity number|nil
---@field requester_paste_multiplier integer|nil
---@field overload_multiplier integer|nil
---@field allow_inserter_overload boolean|nil
---@field enabled boolean|nil
---@field hide_from_stats boolean|nil
---@field hide_from_player_crafting boolean|nil
---@field hide_from_bonus_gui boolean|nil
---@field allow_decomposition boolean|nil
---@field allow_as_intermediate boolean|nil
---@field allow_intermediates boolean|nil
---@field always_show_made_in boolean|nil
---@field show_amount_in_title boolean|nil
---@field always_show_products boolean|nil
---@field unlock_results boolean|nil
---@field preserve_products_in_machine_output boolean|nil
---@field result_is_always_fresh boolean|nil
---@field reset_freshness_on_craft boolean|nil
---@field allow_consumption_message LocalisedString|nil
---@field allow_speed_message LocalisedString|nil
---@field allow_productivity_message LocalisedString|nil
---@field allow_pollution_message LocalisedString|nil
---@field allow_quality_message LocalisedString|nil
---@field surface_conditions SurfaceCondition[]|nil
---@field hide_from_signal_gui boolean|nil
---@field allow_consumption boolean|nil
---@field allow_speed boolean|nil
---@field allow_productivity boolean|nil
---@field allow_pollution boolean|nil
---@field allow_quality boolean|nil
---@field allowed_module_categories ModuleCategoryID[]|nil
---@field alternative_unlock_methods TechnologyID[]|nil
---@field auto_recycle boolean|nil
---@field hidden boolean|nil

---@class RemoteControllerPrototype
---@field type "remote-controller"
---@field name string
---@field movement_speed number

---@class RepairToolPrototype: ToolPrototype
---@field speed number

---@class ResearchAchievementPrototype: AchievementPrototype
---@field technology TechnologyID|nil
---@field research_all boolean|nil

---@class ResearchWithSciencePackAchievementPrototype: AchievementPrototype
---@field science_pack ItemID
---@field amount integer|nil

---@class ResourceCategory: Prototype

---@class ResourceEntityPrototype: EntityPrototype
---@field stages AnimationVariations|nil
---@field stage_counts integer[]
---@field infinite boolean|nil
---@field highlight boolean|nil
---@field randomize_visual_position boolean|nil
---@field map_grid boolean|nil
---@field draw_stateless_visualisation_under_building boolean|nil
---@field minimum integer|nil
---@field normal integer|nil
---@field infinite_depletion_amount integer|nil
---@field resource_patch_search_radius integer|nil
---@field category ResourceCategoryID|nil
---@field walking_sound Sound|nil
---@field driving_sound InterruptibleSound|nil
---@field stages_effect AnimationVariations|nil
---@field effect_animation_period number|nil
---@field effect_animation_period_deviation number|nil
---@field effect_darkness_multiplier number|nil
---@field min_effect_alpha number|nil
---@field max_effect_alpha number|nil
---@field tree_removal_probability number|nil
---@field cliff_removal_probability number|nil
---@field tree_removal_max_distance number|nil
---@field mining_visualisation_tint Color|nil

---@class RoboportEquipmentPrototype: EquipmentPrototype
---@field recharging_animation Animation|nil
---@field spawn_and_station_height number
---@field charge_approach_distance number
---@field construction_radius number
---@field charging_energy Energy
---@field spawn_and_station_shadow_height_offset number|nil
---@field stationing_render_layer_swap_height number|nil
---@field draw_logistic_radius_visualization boolean|nil
---@field draw_construction_radius_visualization boolean|nil
---@field recharging_light LightDefinition|nil
---@field charging_station_count integer|nil
---@field charging_station_count_affected_by_quality boolean|nil
---@field charging_distance number|nil
---@field charging_station_shift Vector|nil
---@field charging_threshold_distance number|nil
---@field robot_vertical_acceleration number|nil
---@field stationing_offset Vector|nil
---@field robot_limit ItemCountType|nil
---@field robots_shrink_when_entering_and_exiting boolean|nil
---@field charging_offsets Vector[]|nil
---@field spawn_minimum Energy|nil
---@field burner BurnerEnergySource|nil
---@field power Energy|nil

---@class RoboportPrototype: EntityWithOwnerPrototype
---@field energy_source ElectricEnergySource|VoidEnergySource
---@field energy_usage Energy
---@field recharge_minimum Energy
---@field robot_slots_count ItemStackIndex
---@field material_slots_count ItemStackIndex
---@field base Sprite|nil
---@field base_patch Sprite|nil
---@field frozen_patch Sprite|nil
---@field base_animation Animation|nil
---@field door_animation_up Animation|nil
---@field door_animation_down Animation|nil
---@field request_to_open_door_timeout integer
---@field radar_range integer|nil
---@field radar_visualisation_color Color|nil
---@field recharging_animation Animation|nil
---@field spawn_and_station_height number
---@field charge_approach_distance number
---@field logistics_radius number
---@field construction_radius number
---@field charging_energy Energy
---@field open_door_trigger_effect TriggerEffect|nil
---@field close_door_trigger_effect TriggerEffect|nil
---@field default_available_logistic_output_signal SignalIDConnector|nil
---@field default_total_logistic_output_signal SignalIDConnector|nil
---@field default_available_construction_output_signal SignalIDConnector|nil
---@field default_total_construction_output_signal SignalIDConnector|nil
---@field default_roboport_count_output_signal SignalIDConnector|nil
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field circuit_connector CircuitConnectorDefinition|nil
---@field render_recharge_icon boolean|nil
---@field max_logistic_slots LogisticFilterIndex|nil
---@field spawn_and_station_shadow_height_offset number|nil
---@field stationing_render_layer_swap_height number|nil
---@field draw_logistic_radius_visualization boolean|nil
---@field draw_construction_radius_visualization boolean|nil
---@field recharging_light LightDefinition|nil
---@field charging_station_count integer|nil
---@field charging_station_count_affected_by_quality boolean|nil
---@field charging_distance number|nil
---@field charging_station_shift Vector|nil
---@field charging_threshold_distance number|nil
---@field robot_vertical_acceleration number|nil
---@field stationing_offset Vector|nil
---@field robot_limit ItemCountType|nil
---@field robots_shrink_when_entering_and_exiting boolean|nil
---@field charging_offsets Vector[]|nil
---@field logistics_connection_distance number|nil

---@class RobotWithLogisticInterfacePrototype: FlyingRobotPrototype
---@field max_payload_size ItemCountType
---@field max_payload_size_after_bonus ItemCountType|nil
---@field idle RotatedAnimation|nil
---@field in_motion RotatedAnimation|nil
---@field shadow_idle RotatedAnimation|nil
---@field shadow_in_motion RotatedAnimation|nil
---@field destroy_action Trigger|nil
---@field draw_cargo boolean|nil
---@field charging_sound InterruptibleSound|nil

---@class RocketSiloPrototype: AssemblingMachinePrototype
---@field active_energy_usage Energy
---@field lamp_energy_usage Energy
---@field rocket_entity EntityID
---@field arm_02_right_animation Animation|nil
---@field arm_01_back_animation Animation|nil
---@field arm_03_front_animation Animation|nil
---@field shadow_sprite Sprite|nil
---@field hole_sprite Sprite|nil
---@field hole_light_sprite Sprite|nil
---@field rocket_shadow_overlay_sprite Sprite|nil
---@field rocket_glow_overlay_sprite Sprite|nil
---@field door_back_sprite Sprite|nil
---@field door_front_sprite Sprite|nil
---@field base_day_sprite Sprite|nil
---@field base_front_sprite Sprite|nil
---@field red_lights_back_sprites Sprite|nil
---@field red_lights_front_sprites Sprite|nil
---@field base_frozen Sprite|nil
---@field base_front_frozen Sprite|nil
---@field hole_frozen Sprite|nil
---@field door_back_frozen Sprite|nil
---@field door_front_frozen Sprite|nil
---@field hole_clipping_box BoundingBox
---@field door_back_open_offset Vector
---@field door_front_open_offset Vector
---@field silo_fade_out_start_distance number
---@field silo_fade_out_end_distance number
---@field times_to_blink integer
---@field light_blinking_speed number
---@field door_opening_speed number
---@field rocket_parts_required integer
---@field rocket_quick_relaunch_start_offset number
---@field satellite_animation Animation|nil
---@field satellite_shadow_animation Animation|nil
---@field base_night_sprite Sprite|nil
---@field base_light LightDefinition|nil
---@field base_engine_light LightDefinition|nil
---@field rocket_rising_delay integer|nil
---@field launch_wait_time integer|nil
---@field render_not_in_network_icon boolean|nil
---@field rocket_parts_storage_cap integer|nil
---@field alarm_trigger TriggerEffect|nil
---@field clamps_on_trigger TriggerEffect|nil
---@field clamps_off_trigger TriggerEffect|nil
---@field doors_trigger TriggerEffect|nil
---@field raise_rocket_trigger TriggerEffect|nil
---@field alarm_sound Sound|nil
---@field quick_alarm_sound Sound|nil
---@field clamps_on_sound Sound|nil
---@field clamps_off_sound Sound|nil
---@field doors_sound Sound|nil
---@field raise_rocket_sound Sound|nil
---@field to_be_inserted_to_rocket_inventory_size ItemStackIndex|nil
---@field logistic_trash_inventory_size ItemStackIndex|nil
---@field cargo_station_parameters CargoStationParameters
---@field launch_to_space_platforms boolean|nil
---@field can_launch_without_landing_pads boolean|nil

---@class RocketSiloRocketPrototype: EntityPrototype
---@field shadow_slave_entity EntityID|nil
---@field cargo_pod_entity EntityID
---@field dying_explosion EntityID|nil
---@field glow_light LightDefinition|nil
---@field rocket_sprite Sprite|nil
---@field rocket_shadow_sprite Sprite|nil
---@field rocket_glare_overlay_sprite Sprite|nil
---@field rocket_smoke_bottom1_animation Animation|nil
---@field rocket_smoke_bottom2_animation Animation|nil
---@field rocket_smoke_top1_animation Animation|nil
---@field rocket_smoke_top2_animation Animation|nil
---@field rocket_smoke_top3_animation Animation|nil
---@field rocket_flame_animation Animation|nil
---@field rocket_flame_left_animation Animation|nil
---@field rocket_flame_right_animation Animation|nil
---@field rocket_initial_offset Vector|nil
---@field rocket_rise_offset Vector
---@field cargo_attachment_offset Vector|nil
---@field rocket_flame_left_rotation number
---@field rocket_flame_right_rotation number
---@field rocket_render_layer_switch_distance number
---@field full_render_layer_switch_distance number
---@field rocket_launch_offset Vector
---@field effects_fade_in_start_distance number
---@field effects_fade_in_end_distance number
---@field shadow_fade_out_start_ratio number
---@field shadow_fade_out_end_ratio number
---@field rocket_visible_distance_from_center number
---@field rocket_above_wires_slice_offset_from_center number|nil
---@field rocket_air_object_slice_offset_from_center number|nil
---@field rocket_fog_mask FogMaskShapeDefinition|nil
---@field rising_speed number
---@field engine_starting_speed number
---@field flying_speed number
---@field flying_acceleration number
---@field flying_trigger TriggerEffect|nil
---@field flying_sound Sound|nil
---@field inventory_size ItemStackIndex

---@class RocketSiloRocketShadowPrototype: EntityPrototype

---@class RollingStockPrototype: VehiclePrototype
---@field max_speed number
---@field air_resistance number
---@field joint_distance number
---@field connection_distance number
---@field pictures RollingStockRotatedSlopedGraphics|nil
---@field wheels RollingStockRotatedSlopedGraphics|nil
---@field vertical_selection_shift number
---@field drive_over_tie_trigger TriggerEffect|nil
---@field drive_over_tie_trigger_minimal_speed number|nil
---@field tie_distance number|nil
---@field back_light LightDefinition|nil
---@field stand_by_light LightDefinition|nil
---@field horizontal_doors Animation|nil
---@field vertical_doors Animation|nil
---@field color Color|nil
---@field allow_manual_color boolean|nil
---@field allow_robot_dispatch_in_automatic_mode boolean|nil
---@field default_copy_color_from_train_stop boolean|nil
---@field transition_collision_mask CollisionMaskConnector|nil
---@field elevated_collision_mask CollisionMaskConnector|nil
---@field elevated_selection_priority integer|nil
---@field elevated_rail_sound MainSound|nil
---@field drive_over_elevated_tie_trigger TriggerEffect|nil
---@field door_opening_sound InterruptibleSound|nil
---@field door_closing_sound InterruptibleSound|nil

---@class SegmentPrototype: EntityWithOwnerPrototype
---@field dying_sound Sound|nil
---@field dying_sound_volume_modifier number|nil
---@field animation RotatedAnimation
---@field render_layer RenderLayer|nil
---@field forward_overlap integer|nil
---@field backward_overlap integer|nil
---@field forward_padding number|nil
---@field backward_padding number|nil
---@field update_effects TriggerEffectWithCooldown[]|nil
---@field update_effects_while_enraged TriggerEffectWithCooldown[]|nil

---@class SegmentedUnitPrototype: SegmentPrototype
---@field vision_distance number
---@field attack_parameters AttackParameters|nil
---@field revenge_attack_parameters AttackParameters|nil
---@field territory_radius integer
---@field enraged_duration integer
---@field patrolling_speed number
---@field investigating_speed number
---@field attacking_speed number
---@field enraged_speed number
---@field acceleration_rate number
---@field turn_radius number
---@field patrolling_turn_radius number|nil
---@field turn_smoothing number|nil
---@field ticks_per_scan integer|nil
---@field segment_engine SegmentEngineSpecification
---@field roar Sound|nil
---@field roar_probability number|nil
---@field hurt_roar Sound|nil
---@field hurt_thresholds number[]|nil

---@class SelectionToolPrototype: ItemWithLabelPrototype
---@field select SelectionModeData
---@field alt_select SelectionModeData
---@field super_forced_select SelectionModeData|nil
---@field reverse_select SelectionModeData|nil
---@field alt_reverse_select SelectionModeData|nil
---@field always_include_tiles boolean|nil
---@field mouse_cursor MouseCursorID|nil
---@field skip_fog_of_war boolean|nil

---@class SelectorCombinatorPrototype: CombinatorPrototype
---@field max_symbol_sprites Sprite4Way|nil
---@field min_symbol_sprites Sprite4Way|nil
---@field count_symbol_sprites Sprite4Way|nil
---@field random_symbol_sprites Sprite4Way|nil
---@field stack_size_sprites Sprite4Way|nil
---@field rocket_capacity_sprites Sprite4Way|nil
---@field quality_symbol_sprites Sprite4Way|nil

---@class ShootAchievementPrototype: AchievementPrototype
---@field ammo_type ItemID|nil
---@field amount integer|nil

---@class ShortcutPrototype: Prototype
---@field action "toggle-alt-mode"|"undo"|"redo"|"paste"|"import-string"|"toggle-personal-roboport"|"toggle-personal-logistic-requests"|"toggle-equipment-movement-bonus"|"spawn-item"|"lua"
---@field icons IconData[]|nil
---@field icon FileName|nil
---@field icon_size SpriteSizeType|nil
---@field small_icons IconData[]|nil
---@field small_icon FileName|nil
---@field small_icon_size SpriteSizeType|nil
---@field item_to_spawn ItemID|nil
---@field technology_to_unlock TechnologyID|nil
---@field unavailable_until_unlocked boolean|nil
---@field toggleable boolean|nil
---@field associated_control_input string|nil
---@field style "default"|"blue"|"red"|"green"|nil
---@field order Order|nil

---@class SimpleEntityPrototype: EntityWithHealthPrototype
---@field count_as_rock_for_filtered_deconstruction boolean|nil
---@field render_layer RenderLayer|nil
---@field secondary_draw_order integer|nil
---@field random_animation_offset boolean|nil
---@field random_variation_on_create boolean|nil
---@field pictures SpriteVariations|nil
---@field picture Sprite4Way|nil
---@field animations AnimationVariations|nil
---@field lower_render_layer RenderLayer|nil
---@field lower_pictures SpriteVariations|nil
---@field stateless_visualisation_variations (StatelessVisualisation|StatelessVisualisation[])[]|nil

---@class SimpleEntityWithForcePrototype: SimpleEntityWithOwnerPrototype
---@field is_military_target boolean|nil

---@class SimpleEntityWithOwnerPrototype: EntityWithOwnerPrototype
---@field render_layer RenderLayer|nil
---@field secondary_draw_order integer|nil
---@field random_animation_offset boolean|nil
---@field random_variation_on_create boolean|nil
---@field pictures SpriteVariations|nil
---@field picture Sprite4Way|nil
---@field animations AnimationVariations|nil
---@field lower_render_layer RenderLayer|nil
---@field lower_pictures SpriteVariations|nil
---@field stateless_visualisation_variations (StatelessVisualisation|StatelessVisualisation[])[]|nil
---@field force_visibility ForceCondition|nil

---@class SmokePrototype: EntityPrototype
---@field animation Animation|nil
---@field cyclic boolean|nil
---@field duration integer|nil
---@field spread_duration integer|nil
---@field fade_away_duration integer|nil
---@field fade_in_duration integer|nil
---@field start_scale number|nil
---@field end_scale number|nil
---@field color Color|nil
---@field affected_by_wind boolean|nil
---@field show_when_smoke_off boolean|nil
---@field render_layer RenderLayer|nil
---@field movement_slow_down_factor number|nil
---@field glow_fade_away_duration integer|nil
---@field glow_animation Animation|nil
---@field collision_box BoundingBox|nil

---@class SmokeWithTriggerPrototype: SmokePrototype
---@field action Trigger|nil
---@field action_cooldown integer|nil
---@field particle_count integer|nil
---@field particle_distance_scale_factor number|nil
---@field spread_duration_variation integer|nil
---@field particle_duration_variation integer|nil
---@field particle_spread Vector|nil
---@field particle_scale_factor Vector|nil
---@field wave_distance Vector|nil
---@field wave_speed Vector|nil
---@field attach_to_target boolean|nil
---@field fade_when_attachment_is_destroyed boolean|nil

---@class SolarPanelEquipmentPrototype: EquipmentPrototype
---@field power Energy
---@field performance_at_day number|nil
---@field performance_at_night number|nil
---@field solar_coefficient_property SurfacePropertyID|nil

---@class SolarPanelPrototype: EntityWithOwnerPrototype
---@field energy_source ElectricEnergySource
---@field picture SpriteVariations|nil
---@field production Energy
---@field overlay SpriteVariations|nil
---@field performance_at_day number|nil
---@field performance_at_night number|nil
---@field solar_coefficient_property SurfacePropertyID|nil

---@class SoundPrototype
---@field type "sound"
---@field name string
---@field category SoundType|nil
---@field priority integer|nil
---@field aggregation AggregationSpecification|nil
---@field allow_random_repeat boolean|nil
---@field audible_distance_modifier number|nil
---@field game_controller_vibration_data GameControllerVibrationData|nil
---@field advanced_volume_control AdvancedVolumeControl|nil
---@field speed_smoothing_window_size integer|nil
---@field variations SoundDefinition|SoundDefinition[]|nil
---@field filename FileName|nil
---@field volume number|nil
---@field min_volume number|nil
---@field max_volume number|nil
---@field preload boolean|nil
---@field speed number|nil
---@field min_speed number|nil
---@field max_speed number|nil
---@field modifiers SoundModifier|SoundModifier[]|nil

---@class SpaceConnectionDistanceTraveledAchievementPrototype: AchievementPrototype
---@field tracked_connection SpaceConnectionID
---@field distance integer
---@field reversed boolean

---@class SpaceConnectionPrototype: Prototype
---@field from SpaceLocationID
---@field to SpaceLocationID
---@field length integer|nil
---@field asteroid_spawn_definitions SpaceConnectionAsteroidSpawnDefinition[]|nil
---@field icons IconData[]|nil
---@field icon FileName|nil
---@field icon_size SpriteSizeType|nil

---@class SpaceLocationPrototype: Prototype
---@field gravity_pull number|nil
---@field distance number
---@field orientation RealOrientation
---@field magnitude number|nil
---@field parked_platforms_orientation RealOrientation|nil
---@field label_orientation RealOrientation|nil
---@field draw_orbit boolean|nil
---@field solar_power_in_space number|nil
---@field asteroid_spawn_influence number|nil
---@field fly_condition boolean|nil
---@field auto_save_on_first_trip boolean|nil
---@field procession_graphic_catalogue ProcessionGraphicCatalogue|nil
---@field procession_audio_catalogue ProcessionAudioCatalogue|nil
---@field platform_procession_set ProcessionSet|nil
---@field planet_procession_set ProcessionSet|nil
---@field icons IconData[]|nil
---@field icon FileName|nil
---@field icon_size SpriteSizeType|nil
---@field starmap_icons IconData[]|nil
---@field starmap_icon FileName|nil
---@field starmap_icon_size SpriteSizeType|nil
---@field starmap_icon_orientation RealOrientation|nil
---@field asteroid_spawn_definitions SpaceLocationAsteroidSpawnDefinition[]|nil
---@field hidden boolean|nil

---@class SpacePlatformHubPrototype: EntityWithOwnerPrototype
---@field graphics_set CargoBayConnectableGraphicsSet|nil
---@field inventory_size ItemStackIndex
---@field dump_container EntityID
---@field persistent_ambient_sounds PersistentWorldAmbientSoundsDefinition|nil
---@field surface_render_parameters SurfaceRenderParameters|nil
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field circuit_connector CircuitConnectorDefinition|nil
---@field default_speed_signal SignalIDConnector|nil
---@field default_damage_taken_signal SignalIDConnector|nil
---@field platform_repair_speed_modifier number|nil
---@field weight Weight|nil
---@field cargo_station_parameters CargoStationParameters
---@field build_grid_size 256|nil

---@class SpacePlatformStarterPackPrototype: ItemPrototype
---@field trigger Trigger|nil
---@field surface SurfaceID|nil
---@field create_electric_network boolean|nil
---@field tiles SpacePlatformTileDefinition[]|nil
---@field initial_items ItemProductPrototype[]|nil

---@class SpectatorControllerPrototype
---@field type "spectator-controller"
---@field name string
---@field movement_speed number

---@class SpeechBubblePrototype: EntityPrototype
---@field style string
---@field wrapper_flow_style string|nil
---@field y_offset number|nil
---@field fade_in_out_ticks integer|nil

---@class SpiderLegPrototype: EntityWithOwnerPrototype
---@field stretch_force_scalar number|nil
---@field hip_flexibility number|nil
---@field knee_height number
---@field knee_distance_factor number
---@field ankle_height number|nil
---@field initial_movement_speed number
---@field movement_acceleration number
---@field target_position_randomisation_distance number
---@field minimal_step_size number
---@field base_position_selection_distance number
---@field movement_based_position_selection_distance number
---@field graphics_set SpiderLegGraphicsSet|nil
---@field walking_sound_volume_modifier number|nil
---@field walking_sound_speed_modifier number|nil
---@field upper_leg_dying_trigger_effects SpiderLegTriggerEffect[]|nil
---@field lower_leg_dying_trigger_effects SpiderLegTriggerEffect[]|nil

---@class SpiderUnitPrototype: EntityWithOwnerPrototype
---@field spider_engine SpiderEngineSpecification
---@field height number
---@field torso_bob_speed number|nil
---@field torso_rotation_speed number|nil
---@field graphics_set SpiderTorsoGraphicsSet|nil
---@field absorptions_to_join_attack table<AirbornePollutantID, number>|nil
---@field spawning_time_modifier number|nil
---@field radar_range integer|nil
---@field attack_parameters AttackParameters
---@field dying_sound Sound|nil
---@field warcry Sound|nil
---@field vision_distance number
---@field distraction_cooldown integer
---@field min_pursue_time integer|nil
---@field max_pursue_distance number|nil
---@field ai_settings UnitAISettings|nil

---@class SpiderVehiclePrototype: VehiclePrototype
---@field energy_source BurnerEnergySource|VoidEnergySource
---@field inventory_size ItemStackIndex
---@field graphics_set SpiderVehicleGraphicsSet|nil
---@field spider_engine SpiderEngineSpecification
---@field height number
---@field movement_energy_consumption Energy
---@field automatic_weapon_cycling boolean
---@field chain_shooting_cooldown_modifier number
---@field torso_rotation_speed number|nil
---@field torso_bob_speed number|nil
---@field trash_inventory_size ItemStackIndex|nil
---@field guns ItemID[]|nil

---@class SpidertronRemotePrototype: SelectionToolPrototype
---@field icon_color_indicator_mask FileName|nil
---@field stack_size 1

---@class SplitterPrototype: TransportBeltConnectablePrototype
---@field structure Animation4Way|nil
---@field structure_patch Animation4Way|nil
---@field frozen_patch Sprite4Way|nil
---@field structure_animation_speed_coefficient number|nil
---@field structure_animation_movement_cooldown integer|nil
---@field related_transport_belt EntityID|nil
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field circuit_connector table|nil
---@field default_input_left_condition CircuitConditionConnector|nil
---@field default_input_right_condition CircuitConditionConnector|nil
---@field default_output_left_condition CircuitConditionConnector|nil
---@field default_output_right_condition CircuitConditionConnector|nil

---@class SpritePrototype
---@field type "sprite"
---@field name string
---@field layers Sprite[]|nil
---@field filename FileName|nil
---@field dice SpriteSizeType|nil
---@field dice_x SpriteSizeType|nil
---@field dice_y SpriteSizeType|nil
---@field priority SpritePriority|nil
---@field flags SpriteFlags|nil
---@field size SpriteSizeType|table|nil
---@field width SpriteSizeType|nil
---@field height SpriteSizeType|nil
---@field x SpriteSizeType|nil
---@field y SpriteSizeType|nil
---@field position table|nil
---@field shift Vector|nil
---@field rotate_shift boolean|nil
---@field apply_special_effect boolean|nil
---@field scale number|nil
---@field draw_as_shadow boolean|nil
---@field draw_as_glow boolean|nil
---@field draw_as_light boolean|nil
---@field mipmap_count integer|nil
---@field apply_runtime_tint boolean|nil
---@field tint_as_overlay boolean|nil
---@field invert_colors boolean|nil
---@field tint Color|nil
---@field blend_mode BlendMode|nil
---@field load_in_minimal_mode boolean|nil
---@field premul_alpha boolean|nil
---@field allow_forced_downscale boolean|nil
---@field generate_sdf boolean|nil
---@field surface SpriteUsageSurfaceHint|nil
---@field usage SpriteUsageHint|nil

---@class StickerPrototype: EntityPrototype
---@field duration_in_ticks integer
---@field animation Animation|nil
---@field render_layer RenderLayer|nil
---@field damage_interval integer|nil
---@field spread_fire_entity EntityID|nil
---@field fire_spread_cooldown integer|nil
---@field fire_spread_radius number|nil
---@field stickers_per_square_meter number|nil
---@field force_visibility ForceCondition|nil
---@field single_particle boolean|nil
---@field use_damage_substitute boolean|nil
---@field damage_per_tick DamageParameters|nil
---@field target_movement_modifier number|nil
---@field target_movement_modifier_from number|nil
---@field target_movement_modifier_to number|nil
---@field target_movement_max number|nil
---@field target_movement_max_from number|nil
---@field target_movement_max_to number|nil
---@field ground_target boolean|nil
---@field vehicle_speed_modifier number|nil
---@field vehicle_speed_modifier_from number|nil
---@field vehicle_speed_modifier_to number|nil
---@field vehicle_speed_max number|nil
---@field vehicle_speed_max_from number|nil
---@field vehicle_speed_max_to number|nil
---@field vehicle_friction_modifier number|nil
---@field vehicle_friction_modifier_from number|nil
---@field vehicle_friction_modifier_to number|nil
---@field selection_box_type CursorBoxType|nil
---@field update_effects TriggerEffectWithCooldown[]|nil
---@field hidden true
---@field hidden_in_factoriopedia true

---@class StorageTankPrototype: EntityWithOwnerPrototype
---@field fluid_box FluidBox
---@field window_bounding_box BoundingBox
---@field pictures StorageTankPictures|nil
---@field flow_length_in_ticks integer
---@field two_direction_only boolean|nil
---@field show_fluid_icon boolean|nil
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field circuit_connector table|nil

---@class StraightRailPrototype: RailPrototype
---@field collision_box BoundingBox|nil

---@class SurfacePropertyPrototype: Prototype
---@field localised_unit_key string|nil
---@field default_value number
---@field is_time boolean|nil

---@class SurfacePrototype: Prototype
---@field surface_properties table<SurfacePropertyID, number>|nil
---@field icons IconData[]|nil
---@field icon FileName|nil
---@field icon_size SpriteSizeType|nil

---@class TechnologyPrototype: Prototype
---@field name string
---@field icons IconData[]|nil
---@field icon FileName|nil
---@field icon_size SpriteSizeType|nil
---@field upgrade boolean|nil
---@field enabled boolean|nil
---@field essential boolean|nil
---@field visible_when_disabled boolean|nil
---@field ignore_tech_cost_multiplier boolean|nil
---@field allows_productivity boolean|nil
---@field research_trigger TechnologyTrigger|nil
---@field unit TechnologyUnit|nil
---@field max_level integer|"infinite"|nil
---@field prerequisites TechnologyID[]|nil
---@field show_levels_info boolean|nil
---@field effects Modifier[]|nil
---@field hidden boolean|nil

---@class TemporaryContainerPrototype: ContainerPrototype
---@field destroy_on_empty boolean|nil
---@field time_to_live integer|nil
---@field alert_after_time integer|nil

---@class ThrusterPrototype: EntityWithOwnerPrototype
---@field min_performance ThrusterPerformancePoint
---@field max_performance ThrusterPerformancePoint
---@field fuel_fluid_box FluidBox
---@field oxidizer_fluid_box FluidBox
---@field graphics_set ThrusterGraphicsSet|nil
---@field plumes PlumesSpecification|nil

---@class TileEffectDefinition
---@field type "tile-effect"
---@field name string
---@field shader "water"|"space"|"puddle"
---@field water WaterTileEffectParameters|nil
---@field space SpaceTileEffectParameters|nil
---@field puddle PuddleTileEffectParameters|nil

---@class TileGhostPrototype: EntityPrototype

---@class TilePrototype: Prototype
---@field collision_mask CollisionMaskConnector
---@field layer integer
---@field build_animations Animation4Way|nil
---@field build_animations_background Animation4Way|nil
---@field built_animation_frame integer|nil
---@field variants TileTransitionsVariants
---@field map_color Color
---@field icons IconData[]|nil
---@field icon FileName|nil
---@field icon_size SpriteSizeType|nil
---@field lowland_fog boolean|nil
---@field transition_overlay_layer_offset integer|nil
---@field sprite_usage_surface SpriteUsageSurfaceHint|nil
---@field layer_group TileRenderLayer|nil
---@field transition_merges_with_tile TileID|nil
---@field effect_color Color|nil
---@field tint Color|nil
---@field particle_tints TileBasedParticleTints|nil
---@field walking_sound Sound|nil
---@field landing_steps_sound Sound|nil
---@field driving_sound InterruptibleSound|nil
---@field build_sound Sound|TileBuildSound|nil
---@field mined_sound Sound|nil
---@field walking_speed_modifier number|nil
---@field vehicle_friction_modifier number|nil
---@field decorative_removal_probability number|nil
---@field allowed_neighbors TileID[]|nil
---@field needs_correction boolean|nil
---@field minable MinableProperties|nil
---@field fluid FluidID|nil
---@field next_direction TileID|nil
---@field can_be_part_of_blueprint boolean|nil
---@field is_foundation boolean|nil
---@field destroys_dropped_items boolean|nil
---@field allows_being_covered boolean|nil
---@field searchable boolean|nil
---@field max_health number|nil
---@field weight Weight|nil
---@field dying_explosion ExplosionDefinition|ExplosionDefinition[]|nil
---@field absorptions_per_second table<AirbornePollutantID, number>|nil
---@field default_cover_tile TileID|nil
---@field frozen_variant TileID|nil
---@field thawed_variant TileID|nil
---@field effect TileEffectDefinitionID|nil
---@field trigger_effect TriggerEffect|nil
---@field default_destroyed_dropped_item_trigger Trigger|nil
---@field scorch_mark_color Color|nil
---@field check_collision_with_entities boolean|nil
---@field effect_color_secondary Color|nil
---@field effect_is_opaque boolean|nil
---@field transitions TileTransitionsToTiles[]|nil
---@field transitions_between_transitions TileTransitionsBetweenTransitions[]|nil
---@field autoplace AutoplaceSpecification|nil
---@field placeable_by ItemToPlace|ItemToPlace[]|nil
---@field bound_decoratives DecorativeID|DecorativeID[]|nil
---@field ambient_sounds_group TileID|nil
---@field ambient_sounds WorldAmbientSoundDefinition|WorldAmbientSoundDefinition[]|nil

---@class TipsAndTricksItem: PrototypeBase
---@field image FileName|nil
---@field simulation SimulationDefinition|nil
---@field tag string|nil
---@field category string|nil
---@field indent integer|nil
---@field is_title boolean|nil
---@field trigger TipTrigger|nil
---@field skip_trigger TipTrigger|nil
---@field tutorial string|nil
---@field starting_status TipStatus|nil
---@field dependencies string[]|nil
---@field player_input_method_filter PlayerInputMethodFilter|nil
---@field icons IconData[]|nil
---@field icon FileName|nil
---@field icon_size SpriteSizeType|nil
---@field order Order|nil

---@class TipsAndTricksItemCategory
---@field type "tips-and-tricks-item-category"
---@field name string
---@field order Order

---@class ToolPrototype: ItemPrototype
---@field durability number|nil
---@field durability_description_key string|nil
---@field durability_description_value string|nil
---@field infinite boolean|nil

---@class TrainPathAchievementPrototype: AchievementPrototype
---@field minimum_distance number

---@class TrainStopPrototype: EntityWithOwnerPrototype
---@field animation_ticks_per_frame integer
---@field rail_overlay_animations Animation4Way|nil
---@field animations Animation4Way|nil
---@field top_animations Animation4Way|nil
---@field default_train_stopped_signal SignalIDConnector|nil
---@field default_trains_count_signal SignalIDConnector|nil
---@field default_trains_limit_signal SignalIDConnector|nil
---@field default_priority_signal SignalIDConnector|nil
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field color Color|nil
---@field chart_name boolean|nil
---@field light1 TrainStopLight|nil
---@field light2 TrainStopLight|nil
---@field drawing_boxes TrainStopDrawingBoxes|nil
---@field circuit_connector table|nil
---@field build_grid_size 2|nil

---@class TransportBeltConnectablePrototype: EntityWithOwnerPrototype
---@field belt_animation_set TransportBeltAnimationSet|nil
---@field speed number
---@field animation_speed_coefficient number|nil
---@field collision_box BoundingBox|nil
---@field flags EntityPrototypeFlags|nil

---@class TransportBeltPrototype: TransportBeltConnectablePrototype
---@field connector_frame_sprites TransportBeltConnectorFrame|nil
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field circuit_connector CircuitConnectorDefinition[]|nil
---@field belt_animation_set TransportBeltAnimationSetWithCorners|nil
---@field related_underground_belt EntityID|nil

---@class TreePrototype: EntityWithHealthPrototype
---@field variation_weights number[]|nil
---@field darkness_of_burnt_tree number|nil
---@field pictures SpriteVariations|nil
---@field variations TreeVariation[]|nil
---@field colors Color[]|nil
---@field stateless_visualisation_variations (StatelessVisualisation|StatelessVisualisation[])[]|nil
---@field healing_per_tick number|nil

---@class TriggerTargetType
---@field type "trigger-target-type"
---@field name string

---@class TrivialSmokePrototype: Prototype
---@field animation Animation
---@field duration integer
---@field glow_animation Animation|nil
---@field color Color|nil
---@field start_scale number|nil
---@field end_scale number|nil
---@field movement_slow_down_factor number|nil
---@field spread_duration integer|nil
---@field fade_away_duration integer|nil
---@field fade_in_duration integer|nil
---@field glow_fade_away_duration integer|nil
---@field cyclic boolean|nil
---@field affected_by_wind boolean|nil
---@field show_when_smoke_off boolean|nil
---@field render_layer RenderLayer|nil

---@class TurretPrototype: EntityWithOwnerPrototype
---@field attack_parameters AttackParameters
---@field folded_animation RotatedAnimation8Way
---@field call_for_help_radius number
---@field attack_target_mask TriggerTargetMask|nil
---@field ignore_target_mask TriggerTargetMask|nil
---@field shoot_in_prepare_state boolean|nil
---@field start_attacking_only_when_can_shoot boolean|nil
---@field turret_base_has_direction boolean|nil
---@field random_animation_offset boolean|nil
---@field attack_from_start_frame boolean|nil
---@field allow_turning_when_starting_attack boolean|nil
---@field gun_animation_secondary_draw_order integer|nil
---@field gun_animation_render_layer RenderLayer|nil
---@field graphics_set TurretGraphicsSet
---@field preparing_animation RotatedAnimation8Way|nil
---@field prepared_animation RotatedAnimation8Way|nil
---@field prepared_alternative_animation RotatedAnimation8Way|nil
---@field starting_attack_animation RotatedAnimation8Way|nil
---@field attacking_animation RotatedAnimation8Way|nil
---@field energy_glow_animation RotatedAnimation8Way|nil
---@field resource_indicator_animation RotatedAnimation8Way|nil
---@field ending_attack_animation RotatedAnimation8Way|nil
---@field folding_animation RotatedAnimation8Way|nil
---@field integration Sprite|nil
---@field special_effect TurretSpecialEffect|nil
---@field glow_light_intensity number|nil
---@field energy_glow_animation_flicker_strength number|nil
---@field starting_attack_sound Sound|nil
---@field dying_sound Sound|nil
---@field preparing_sound Sound|nil
---@field folding_sound Sound|nil
---@field prepared_sound Sound|nil
---@field prepared_alternative_sound Sound|nil
---@field rotating_sound InterruptibleSound|nil
---@field default_speed number|nil
---@field default_speed_secondary number|nil
---@field default_speed_when_killed number|nil
---@field default_starting_progress_when_killed number|nil
---@field rotation_speed number|nil
---@field rotation_speed_secondary number|nil
---@field rotation_speed_when_killed number|nil
---@field rotation_starting_progress_when_killed number|nil
---@field preparing_speed number|nil
---@field preparing_speed_secondary number|nil
---@field preparing_speed_when_killed number|nil
---@field preparing_starting_progress_when_killed number|nil
---@field folded_speed number|nil
---@field folded_speed_secondary number|nil
---@field folded_speed_when_killed number|nil
---@field folded_starting_progress_when_killed number|nil
---@field prepared_speed number|nil
---@field prepared_speed_secondary number|nil
---@field prepared_speed_when_killed number|nil
---@field prepared_starting_progress_when_killed number|nil
---@field prepared_alternative_speed number|nil
---@field prepared_alternative_speed_secondary number|nil
---@field prepared_alternative_speed_when_killed number|nil
---@field prepared_alternative_starting_progress_when_killed number|nil
---@field prepared_alternative_chance number|nil
---@field starting_attack_speed number|nil
---@field starting_attack_speed_secondary number|nil
---@field starting_attack_speed_when_killed number|nil
---@field starting_attack_starting_progress_when_killed number|nil
---@field attacking_speed number|nil
---@field ending_attack_speed number|nil
---@field ending_attack_speed_secondary number|nil
---@field ending_attack_speed_when_killed number|nil
---@field ending_attack_starting_progress_when_killed number|nil
---@field folding_speed number|nil
---@field folding_speed_secondary number|nil
---@field folding_speed_when_killed number|nil
---@field folding_starting_progress_when_killed number|nil
---@field prepare_range number|nil
---@field alert_when_attacking boolean|nil
---@field spawn_decorations_on_expansion boolean|nil
---@field folded_animation_is_stateless boolean|nil
---@field unfolds_before_dying boolean|nil
---@field spawn_decoration CreateDecorativesTriggerEffectItem[]|nil
---@field folded_state_corpse EntityID|EntityID[]|nil
---@field can_retarget_while_starting_attack boolean|nil
---@field is_military_target boolean|nil
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field circuit_connector CircuitConnectorDefinition[]|nil

---@class TutorialDefinition: PrototypeBase
---@field scenario string
---@field order Order|nil

---@class UndergroundBeltPrototype: TransportBeltConnectablePrototype
---@field max_distance integer
---@field structure UndergroundBeltStructure|nil
---@field underground_sprite Sprite|nil
---@field underground_remove_belts_sprite Sprite|nil
---@field max_distance_underground_remove_belts_sprite Sprite|nil
---@field underground_collision_mask CollisionMaskConnector|nil
---@field max_distance_tint Color|nil

---@class UnitPrototype: EntityWithOwnerPrototype
---@field run_animation RotatedAnimation
---@field attack_parameters AttackParameters
---@field warcry Sound|nil
---@field movement_speed number
---@field distance_per_frame number
---@field distraction_cooldown integer
---@field vision_distance number
---@field rotation_speed number|nil
---@field dying_sound Sound|nil
---@field min_pursue_time integer|nil
---@field has_belt_immunity boolean|nil
---@field max_pursue_distance number|nil
---@field radar_range integer|nil
---@field ai_settings UnitAISettings|nil
---@field move_while_shooting boolean|nil
---@field can_open_gates boolean|nil
---@field affected_by_tiles boolean|nil
---@field render_layer RenderLayer|nil
---@field light LightDefinition|nil
---@field absorptions_to_join_attack table<AirbornePollutantID, number>|nil
---@field spawning_time_modifier number|nil
---@field walking_sound Sound|nil
---@field alternative_attacking_frame_sequence UnitAlternativeFrameSequence|nil
---@field running_sound_animation_positions number[]|nil
---@field is_military_target true|nil
---@field allow_run_time_change_of_is_military_target false|nil

---@class UpgradeItemPrototype: SelectionToolPrototype
---@field stack_size 1
---@field draw_label_for_cursor_render boolean|nil
---@field select SelectionModeData
---@field alt_select SelectionModeData
---@field always_include_tiles boolean|nil

---@class UseEntityInEnergyProductionAchievementPrototype: AchievementPrototype
---@field entity EntityID
---@field consumed_condition ItemIDFilter|nil
---@field produced_condition ItemIDFilter|nil
---@field required_to_build EntityID|nil

---@class UseItemAchievementPrototype: AchievementPrototype
---@field to_use ItemID
---@field limit_quality QualityID
---@field amount integer|nil
---@field limited_to_one_game boolean|nil

---@class UtilityConstants: PrototypeBase
---@field entity_button_background_color Color
---@field building_buildable_too_far_tint Color
---@field building_buildable_tint Color
---@field building_not_buildable_tint Color
---@field building_ignorable_tint Color
---@field building_no_tint Color
---@field underground_belt_max_distance_tint Color
---@field underground_pipe_max_distance_tint Color
---@field ghost_shader_tint GhostTintSet
---@field ghost_shaderless_tint GhostTintSet
---@field ghost_shimmer_settings GhostShimmerConfig
---@field probability_product_count_tint Color
---@field zero_count_value_tint Color
---@field equipment_default_background_color Color
---@field equipment_default_background_border_color Color
---@field equipment_default_grabbed_background_color Color
---@field turret_range_visualization_color Color
---@field capsule_range_visualization_color Color
---@field agricultural_range_visualization_color Color
---@field artillery_range_visualization_color Color
---@field chart ChartUtilityConstants
---@field gui_remark_color Color
---@field gui_search_match_foreground_color Color
---@field gui_search_match_background_color Color
---@field default_player_force_color Color
---@field default_enemy_force_color Color
---@field default_other_force_color Color
---@field deconstruct_mark_tint Color
---@field rail_planner_count_button_color Color
---@field count_button_size integer
---@field logistic_gui_unselected_network_highlight_tint Color
---@field logistic_gui_selected_network_highlight_tint Color
---@field chart_search_highlight Color
---@field selected_chart_search_highlight Color
---@field zoom_to_world_can_use_nightvision boolean
---@field zoom_to_world_effect_strength number
---@field max_logistic_filter_count LogisticFilterIndex
---@field max_terrain_building_size integer
---@field small_area_size number
---@field medium_area_size number
---@field large_area_size number
---@field huge_platform_animation_sound_area number
---@field small_blueprint_area_size number
---@field medium_blueprint_area_size number
---@field large_blueprint_area_size number
---@field enabled_recipe_slot_tint Color
---@field disabled_recipe_slot_tint Color
---@field disabled_recipe_slot_background_tint Color
---@field forced_enabled_recipe_slot_background_tint Color
---@field rail_segment_colors Color[]
---@field player_colors PlayerColorData[]
---@field server_command_console_chat_color Color
---@field script_command_console_chat_color Color
---@field default_alert_icon_scale number
---@field default_alert_icon_shift_by_type table<string, Vector>|nil
---@field default_alert_icon_scale_by_type table<string, number>|nil
---@field bonus_gui_ordering BonusGuiOrdering
---@field merge_bonus_gui_production_bonuses boolean|nil
---@field daytime_color_lookup DaytimeColorLookupTable
---@field zoom_to_world_daytime_color_lookup DaytimeColorLookupTable
---@field frozen_color_lookup ColorLookupTable
---@field map_editor MapEditorConstants
---@field drop_item_radius number
---@field checkerboard_white Color
---@field checkerboard_black Color
---@field item_outline_color Color
---@field item_outline_radius number
---@field item_outline_inset number
---@field item_outline_sharpness number
---@field item_default_random_tint_strength Color
---@field spawner_evolution_factor_health_modifier number
---@field item_health_bar_colors ItemHealthColorData[]
---@field item_ammo_magazine_left_bar_color Color
---@field item_tool_durability_bar_color Color
---@field filter_outline_color Color
---@field icon_shadow_radius number
---@field icon_shadow_inset number
---@field icon_shadow_sharpness number
---@field icon_shadow_color Color
---@field clipboard_history_size integer
---@field recipe_step_limit integer
---@field manual_rail_building_reach_modifier number
---@field train_temporary_stop_wait_time integer
---@field train_time_wait_condition_default integer
---@field train_inactivity_wait_condition_default integer
---@field default_trigger_target_mask_by_type table<string, TriggerTargetMask>|nil
---@field unit_group_pathfind_resolution integer
---@field unit_group_max_pursue_distance number
---@field dynamic_recipe_overload_factor number
---@field minimum_recipe_overload_multiplier integer
---@field maximum_recipe_overload_multiplier integer
---@field entity_renderer_search_box_limits EntityRendererSearchBoxLimits
---@field light_renderer_search_distance_limit integer
---@field tree_leaf_distortion_strength_far Vector
---@field tree_leaf_distortion_distortion_far Vector
---@field tree_leaf_distortion_speed_far Vector
---@field tree_leaf_distortion_strength_near Vector
---@field tree_leaf_distortion_distortion_near Vector
---@field tree_leaf_distortion_speed_near Vector
---@field tree_shadow_roughness number
---@field tree_shadow_speed number
---@field missing_preview_sprite_location FileName
---@field main_menu_background_image_location FileName
---@field main_menu_simulations table<string, SimulationDefinition>|nil
---@field main_menu_background_vignette_intensity number
---@field main_menu_background_vignette_sharpness number
---@field feedback_screenshot_subfolder_name string
---@field feedback_screenshot_file_name string
---@field default_scorch_mark_color Color
---@field color_filters ColorFilterData[]|nil
---@field minimap_slot_hovered_tint Color
---@field minimap_slot_clicked_tint Color
---@field clear_cursor_volume_modifier number
---@field weapons_in_simulation_volume_modifier number
---@field explosions_in_simulation_volume_modifier number
---@field enemies_in_simulation_volume_modifier number
---@field low_energy_robot_estimate_multiplier number
---@field asteroid_spawning_offset SimpleBoundingBox
---@field asteroid_fading_range number
---@field asteroid_spawning_with_random_orientation_max_speed number
---@field asteroid_position_offset_to_speed_coefficient number
---@field asteroid_collector_navmesh_refresh_tick_interval integer
---@field asteroid_collector_blockage_update_tile_distance integer
---@field asteroid_collector_max_nurbs_control_point_separation number
---@field asteroid_collector_static_head_swing_strength_scale number
---@field asteroid_collector_static_head_swing_segment_count integer
---@field space_platform_acceleration_expression MathExpression
---@field space_platform_relative_speed_factor number
---@field space_platform_starfield_movement_vector Vector
---@field space_platform_max_size SimpleBoundingBox
---@field space_platform_dump_cooldown integer
---@field space_platform_manual_dump_cooldown integer
---@field space_platform_max_relative_speed_deviation_for_asteroid_chunks_update number
---@field space_platform_asteroid_chunk_trajectory_updates_per_tick integer
---@field default_item_weight Weight
---@field rocket_lift_weight Weight
---@field factoriopedia_recycling_recipe_categories RecipeCategoryID[]
---@field max_fluid_flow FluidAmount
---@field default_pipeline_extent number
---@field default_platform_procession_set ProcessionSet
---@field default_planet_procession_set ProcessionSet
---@field landing_area_clear_zone_radius number
---@field landing_area_max_radius number
---@field lightning_attractor_collection_range_color Color
---@field lightning_attractor_protection_range_color Color
---@field landing_squash_immunity integer
---@field ejected_item_lifetime integer
---@field ejected_item_speed number
---@field ejected_item_direction_variation number
---@field ejected_item_friction number
---@field train_visualization TrainVisualizationConstants
---@field default_collision_masks table<string, CollisionMaskConnector>
---@field show_chunk_components_collision_mask CollisionMaskConnector
---@field building_collision_mask CollisionMaskConnector
---@field water_collision_mask CollisionMaskConnector
---@field ghost_layer CollisionLayerID
---@field train_pushed_by_player_max_speed number
---@field train_pushed_by_player_max_acceleration number
---@field train_pushed_by_player_ignores_friction boolean
---@field freezing_temperature number
---@field train_on_elevated_rail_shadow_shift_multiplier Vector
---@field max_belt_stack_size integer
---@field inserter_hand_stack_items_per_sprite ItemCountType
---@field inserter_hand_stack_max_sprites ItemCountType
---@field remote_view_LPF_min_cutoff_frequency number
---@field remote_view_LPF_max_cutoff_frequency number
---@field space_LPF_min_cutoff_frequency number
---@field space_LPF_max_cutoff_frequency number
---@field walking_sound_count_reduction_rate number
---@field moving_sound_count_reduction_rate number
---@field environment_sounds_transition_fade_in_ticks integer
---@field starmap_orbit_default_color Color
---@field starmap_orbit_hovered_color Color
---@field starmap_orbit_clicked_color Color
---@field starmap_orbit_disabled_color Color
---@field time_to_show_full_health_bar integer
---@field capture_water_mask_at_layer integer
---@field logistic_robots_use_busy_robots_queue boolean
---@field construction_robots_use_busy_robots_queue boolean
---@field quality_selector_dropdown_threshold integer
---@field maximum_quality_jump integer
---@field select_group_row_count integer
---@field select_slot_row_count integer
---@field crafting_queue_slots_per_row integer
---@field logistic_slots_per_row integer
---@field blueprint_big_slots_per_row integer
---@field blueprint_small_slots_per_row integer
---@field inventory_width integer
---@field module_inventory_width integer
---@field trash_inventory_width integer
---@field tooltip_monitor_edge_border integer
---@field flying_text_ttl integer
---@field train_path_finding TrainPathFinderConstants

---@class UtilitySounds: PrototypeBase
---@field gui_click Sound
---@field list_box_click Sound
---@field build_small Sound
---@field build_medium Sound
---@field build_large Sound
---@field build_huge Sound
---@field cannot_build Sound
---@field build_blueprint_small Sound
---@field build_blueprint_medium Sound
---@field build_blueprint_large Sound
---@field build_blueprint_huge Sound
---@field build_ghost_upgrade Sound
---@field build_ghost_upgrade_cancel Sound
---@field build_animated_small Sound
---@field build_animated_medium Sound
---@field build_animated_large Sound
---@field build_animated_huge Sound
---@field deconstruct_small Sound
---@field deconstruct_medium Sound
---@field deconstruct_large Sound
---@field deconstruct_huge Sound
---@field deconstruct_robot Sound
---@field rotated_small Sound
---@field rotated_medium Sound
---@field rotated_large Sound
---@field rotated_huge Sound
---@field axe_mining_ore Sound
---@field axe_mining_stone Sound
---@field mining_wood Sound
---@field axe_fighting Sound
---@field alert_destroyed Sound
---@field console_message Sound
---@field scenario_message Sound
---@field new_objective Sound
---@field game_lost Sound
---@field game_won Sound
---@field metal_walking_sound Sound
---@field research_completed Sound
---@field default_manual_repair Sound
---@field crafting_finished Sound
---@field inventory_click Sound
---@field inventory_move Sound
---@field clear_cursor Sound
---@field armor_insert Sound
---@field armor_remove Sound
---@field achievement_unlocked Sound
---@field wire_connect_pole Sound
---@field wire_disconnect Sound
---@field wire_pickup Sound
---@field tutorial_notice Sound
---@field smart_pipette Sound
---@field switch_gun Sound
---@field picked_up_item Sound
---@field paste_activated Sound
---@field item_deleted Sound
---@field entity_settings_pasted Sound
---@field entity_settings_copied Sound
---@field item_spawned Sound
---@field confirm Sound
---@field undo Sound
---@field drop_item Sound
---@field rail_plan_start Sound
---@field default_driving_sound InterruptibleSound
---@field default_landing_steps Sound
---@field segment_dying_sound Sound|nil

---@class UtilitySprites: PrototypeBase
---@field cursor_box CursorBoxSpecification
---@field platform_entity_build_animations EntityBuildAnimations|nil
---@field bookmark Sprite
---@field center Sprite
---@field check_mark Sprite
---@field check_mark_white Sprite
---@field check_mark_green Sprite
---@field check_mark_dark_green Sprite
---@field not_played_yet_green Sprite
---@field not_played_yet_dark_green Sprite
---@field played_green Sprite
---@field played_dark_green Sprite
---@field close_fat Sprite
---@field close Sprite
---@field close_black Sprite
---@field backward_arrow Sprite
---@field backward_arrow_black Sprite
---@field forward_arrow Sprite
---@field forward_arrow_black Sprite
---@field recipe_arrow Sprite
---@field close_map_preview Sprite
---@field color_picker Sprite
---@field change_recipe Sprite
---@field dropdown Sprite
---@field downloading Sprite
---@field downloaded Sprite
---@field equipment_grid Sprite
---@field equipment_grid_small Sprite
---@field expand_dots Sprite
---@field export Sprite
---@field import Sprite
---@field map Sprite
---@field map_exchange_string Sprite
---@field missing_mod_icon Sprite
---@field not_available Sprite
---@field not_available_black Sprite
---@field play Sprite
---@field stop Sprite
---@field preset Sprite
---@field refresh Sprite
---@field reset Sprite
---@field reset_white Sprite
---@field shuffle Sprite
---@field station_name Sprite
---@field search Sprite
---@field sync_mods Sprite
---@field trash Sprite
---@field trash_white Sprite
---@field copy Sprite
---@field reassign Sprite
---@field warning Sprite
---@field warning_white Sprite
---@field list_view Sprite
---@field grid_view Sprite
---@field slots_view Sprite
---@field reference_point Sprite
---@field mouse_cursor Sprite
---@field mouse_cursor_macos Sprite
---@field mod_category Sprite
---@field mod_last_updated Sprite
---@field mod_downloads_count Sprite
---@field item_to_be_delivered_symbol Sprite
---@field rebuild_mark Sprite
---@field any_quality Sprite
---@field mod_dependency_arrow Sprite
---@field add Sprite
---@field add_white Sprite
---@field clone Sprite
---@field go_to_arrow Sprite
---@field pause Sprite
---@field speed_down Sprite
---@field speed_up Sprite
---@field editor_speed_down Sprite
---@field editor_pause Sprite
---@field editor_play Sprite
---@field editor_speed_up Sprite
---@field tick_once Sprite
---@field tick_sixty Sprite
---@field tick_custom Sprite
---@field search_icon Sprite
---@field too_far Sprite
---@field shoot_cursor_green Sprite
---@field shoot_cursor_red Sprite
---@field electricity_icon Sprite
---@field lightning_warning_icon Sprite
---@field fuel_icon Sprite
---@field ammo_icon Sprite
---@field fluid_icon Sprite
---@field warning_icon Sprite
---@field danger_icon Sprite
---@field destroyed_icon Sprite
---@field recharge_icon Sprite
---@field no_path_icon Sprite
---@field destination_full_icon Sprite
---@field too_far_from_roboport_icon Sprite
---@field pump_cannot_connect_icon Sprite
---@field not_enough_repair_packs_icon Sprite
---@field not_enough_construction_robots_icon Sprite
---@field no_building_material_icon Sprite
---@field no_storage_space_icon Sprite
---@field no_platform_storage_space_icon Sprite
---@field asteroid_collector_path_blocked_icon Sprite
---@field unclaimed_cargo_icon Sprite
---@field no_roboport_storage_space_icon Sprite
---@field cargo_bay_not_connected_icon Sprite
---@field frozen_icon Sprite
---@field pipeline_disabled_icon Sprite
---@field electricity_icon_unplugged Sprite
---@field tooltip_category_spoilable Sprite
---@field resources_depleted_icon Sprite
---@field game_stopped_visualization Sprite
---@field health_bar_green_pip Sprite
---@field health_bar_yellow_pip Sprite
---@field health_bar_red_pip Sprite
---@field ghost_bar_pip Sprite
---@field bar_gray_pip Sprite
---@field shield_bar_pip Sprite
---@field hand Sprite
---@field hand_black Sprite
---@field entity_info_dark_background Sprite
---@field medium_gui_arrow Sprite
---@field small_gui_arrow Sprite
---@field light_medium Sprite
---@field light_small Sprite
---@field light_cone Sprite
---@field color_effect Sprite
---@field clock Sprite
---@field default_ammo_damage_modifier_icon Sprite
---@field default_gun_speed_modifier_icon Sprite
---@field default_turret_attack_modifier_icon Sprite
---@field hint_arrow_up Sprite
---@field hint_arrow_down Sprite
---@field hint_arrow_right Sprite
---@field hint_arrow_left Sprite
---@field fluid_indication_arrow Sprite
---@field fluid_indication_arrow_both_ways Sprite
---@field heat_exchange_indication Sprite
---@field indication_arrow Sprite
---@field rail_planner_indication_arrow Sprite
---@field rail_planner_indication_arrow_anchored Sprite
---@field rail_planner_indication_arrow_too_far Sprite
---@field rail_path_not_possible Sprite
---@field indication_line Sprite
---@field short_indication_line Sprite
---@field short_indication_line_green Sprite
---@field empty_module_slot Sprite
---@field empty_armor_slot Sprite
---@field empty_gun_slot Sprite
---@field empty_ammo_slot Sprite
---@field empty_robot_slot Sprite
---@field empty_robot_material_slot Sprite
---@field empty_inserter_hand_slot Sprite
---@field empty_trash_slot Sprite
---@field empty_drop_cargo_slot Sprite
---@field upgrade_blueprint Sprite
---@field slot Sprite
---@field equipment_slot Sprite
---@field equipment_collision Sprite
---@field battery Sprite
---@field green_circle Sprite
---@field green_dot Sprite
---@field robot_slot Sprite
---@field set_bar_slot Sprite
---@field missing_icon Sprite
---@field deconstruction_mark Sprite
---@field buildability_collision Sprite
---@field buildability_elevated_collision_line Sprite
---@field buildability_elevated_collision_top Sprite
---@field buildability_elevated_collision_bottom Sprite
---@field buildability_collision_elevated Sprite
---@field upgrade_mark Sprite
---@field confirm_slot Sprite
---@field export_slot Sprite
---@field import_slot Sprite
---@field none_editor_icon Sprite
---@field cable_editor_icon Sprite
---@field tile_editor_icon Sprite
---@field decorative_editor_icon Sprite
---@field asteroid_chunk_editor_icon Sprite
---@field resource_editor_icon Sprite
---@field entity_editor_icon Sprite
---@field item_editor_icon Sprite
---@field force_editor_icon Sprite
---@field clone_editor_icon Sprite
---@field scripting_editor_icon Sprite
---@field paint_bucket_icon Sprite
---@field surface_editor_icon Sprite
---@field time_editor_icon Sprite
---@field cliff_editor_icon Sprite
---@field brush_icon Sprite
---@field spray_icon Sprite
---@field cursor_icon Sprite
---@field area_icon Sprite
---@field line_icon Sprite
---@field variations_tool_icon Sprite
---@field lua_snippet_tool_icon Sprite
---@field editor_selection Sprite
---@field brush_square_shape Sprite
---@field brush_circle_shape Sprite
---@field player_force_icon Sprite
---@field neutral_force_icon Sprite
---@field enemy_force_icon Sprite
---@field nature_icon Sprite
---@field no_nature_icon Sprite
---@field multiplayer_waiting_icon Sprite
---@field spawn_flag Sprite
---@field questionmark Sprite
---@field copper_wire Sprite
---@field green_wire Sprite
---@field red_wire Sprite
---@field copper_wire_highlight Sprite
---@field green_wire_highlight Sprite
---@field red_wire_highlight Sprite
---@field wire_shadow Sprite
---@field and_or Sprite
---@field left_arrow Sprite
---@field right_arrow Sprite
---@field down_arrow Sprite
---@field enter Sprite
---@field move_tag Sprite
---@field side_menu_blueprint_library_icon Sprite
---@field side_menu_production_icon Sprite
---@field side_menu_bonus_icon Sprite
---@field side_menu_tutorials_icon Sprite
---@field side_menu_factoriopedia_icon Sprite
---@field side_menu_train_icon Sprite
---@field side_menu_achievements_icon Sprite
---@field side_menu_menu_icon Sprite
---@field side_menu_map_icon Sprite
---@field side_menu_space_platforms_icon Sprite
---@field side_menu_technology_icon Sprite
---@field side_menu_logistic_networks_icon Sprite
---@field side_menu_players_icon Sprite
---@field circuit_network_panel Sprite
---@field logistic_network_panel_white Sprite
---@field logistic_network_panel_black Sprite
---@field rename_icon Sprite
---@field achievement_warning Sprite
---@field achievement_label Sprite
---@field achievement_label_completed Sprite
---@field achievement_label_failed Sprite
---@field rail_signal_placement_indicator Sprite
---@field train_stop_placement_indicator Sprite
---@field rail_support_placement_indicator Sprite
---@field placement_indicator_leg Sprite
---@field grey_rail_signal_placement_indicator Sprite
---@field grey_placement_indicator_leg Sprite
---@field logistic_radius_visualization Sprite
---@field construction_radius_visualization Sprite
---@field track_button Sprite
---@field track_button_white Sprite
---@field show_logistics_network_in_map_view Sprite
---@field show_electric_network_in_map_view Sprite
---@field show_turret_range_in_map_view Sprite
---@field show_train_station_names_in_map_view Sprite
---@field show_player_names_in_map_view Sprite
---@field show_tags_in_map_view Sprite
---@field show_worker_robots_in_map_view Sprite
---@field show_rail_signal_states_in_map_view Sprite
---@field show_recipe_icons_in_map_view Sprite
---@field show_pipelines_in_map_view Sprite
---@field train_stop_in_map_view Sprite
---@field train_stop_disabled_in_map_view Sprite
---@field train_stop_full_in_map_view Sprite
---@field custom_tag_in_map_view Sprite
---@field covered_chunk Sprite
---@field white_square Sprite
---@field white_square_icon Sprite
---@field white_mask Sprite
---@field crafting_machine_recipe_not_unlocked Sprite
---@field filter_blacklist Sprite
---@field gps_map_icon Sprite
---@field custom_tag_icon Sprite
---@field space_age_icon Sprite
---@field tip_icon Sprite
---@field underground_remove_belts Sprite
---@field max_distance_underground_remove_belts Sprite
---@field underground_remove_pipes Sprite
---@field underground_pipe_connection Sprite
---@field ghost_cursor Sprite
---@field tile_ghost_cursor Sprite
---@field force_ghost_cursor Sprite
---@field force_tile_ghost_cursor Sprite
---@field cross_select Sprite
---@field crosshair Sprite
---@field expand Sprite
---@field collapse Sprite
---@field collapse_dark Sprite
---@field status_working Sprite
---@field status_not_working Sprite
---@field status_yellow Sprite
---@field status_blue Sprite
---@field status_inactive Sprite
---@field gradient Sprite
---@field output_console_gradient Sprite
---@field select_icon_white Sprite
---@field select_icon_black Sprite
---@field notification Sprite
---@field alert_arrow Sprite
---@field pin_arrow Sprite
---@field pin_center Sprite
---@field technology_white Sprite
---@field feedback Sprite
---@field sort_by_name Sprite
---@field sort_by_time Sprite
---@field parametrise Sprite
---@field fluid_visualization_connection Sprite
---@field fluid_visualization_connection_both_ways Sprite
---@field fluid_visualization_connection_underground Sprite
---@field fluid_visualization_extent_arrow Sprite
---@field starmap_platform_moving Sprite
---@field starmap_platform_moving_hovered Sprite
---@field starmap_platform_moving_clicked Sprite
---@field starmap_platform_stopped Sprite
---@field starmap_platform_stopped_hovered Sprite
---@field starmap_platform_stopped_clicked Sprite
---@field starmap_platform_stacked Sprite
---@field starmap_platform_stacked_hovered Sprite
---@field starmap_platform_stacked_clicked Sprite
---@field starmap_star Sprite
---@field controller_joycon_a Sprite
---@field controller_joycon_b Sprite
---@field controller_joycon_x Sprite
---@field controller_joycon_y Sprite
---@field controller_joycon_back Sprite
---@field controller_joycon_start Sprite
---@field controller_joycon_leftstick Sprite
---@field controller_joycon_rightstick Sprite
---@field controller_joycon_leftshoulder Sprite
---@field controller_joycon_rightshoulder Sprite
---@field controller_joycon_dpup Sprite
---@field controller_joycon_dpdown Sprite
---@field controller_joycon_dpleft Sprite
---@field controller_joycon_dpright Sprite
---@field controller_joycon_paddle1 Sprite
---@field controller_joycon_paddle2 Sprite
---@field controller_joycon_paddle3 Sprite
---@field controller_joycon_paddle4 Sprite
---@field controller_joycon_righttrigger Sprite
---@field controller_joycon_lefttrigger Sprite
---@field controller_joycon_left_stick Sprite
---@field controller_joycon_right_stick Sprite
---@field controller_joycon_black_a Sprite
---@field controller_joycon_black_b Sprite
---@field controller_joycon_black_x Sprite
---@field controller_joycon_black_y Sprite
---@field controller_joycon_black_back Sprite
---@field controller_joycon_black_start Sprite
---@field controller_joycon_black_leftstick Sprite
---@field controller_joycon_black_rightstick Sprite
---@field controller_joycon_black_leftshoulder Sprite
---@field controller_joycon_black_rightshoulder Sprite
---@field controller_joycon_black_dpup Sprite
---@field controller_joycon_black_dpdown Sprite
---@field controller_joycon_black_dpleft Sprite
---@field controller_joycon_black_dpright Sprite
---@field controller_joycon_black_paddle1 Sprite
---@field controller_joycon_black_paddle2 Sprite
---@field controller_joycon_black_paddle3 Sprite
---@field controller_joycon_black_paddle4 Sprite
---@field controller_joycon_black_righttrigger Sprite
---@field controller_joycon_black_lefttrigger Sprite
---@field controller_joycon_black_left_stick Sprite
---@field controller_joycon_black_right_stick Sprite
---@field controller_xbox_a Sprite
---@field controller_xbox_b Sprite
---@field controller_xbox_x Sprite
---@field controller_xbox_y Sprite
---@field controller_xbox_back Sprite
---@field controller_xbox_start Sprite
---@field controller_xbox_leftstick Sprite
---@field controller_xbox_rightstick Sprite
---@field controller_xbox_leftshoulder Sprite
---@field controller_xbox_rightshoulder Sprite
---@field controller_xbox_dpup Sprite
---@field controller_xbox_dpdown Sprite
---@field controller_xbox_dpleft Sprite
---@field controller_xbox_dpright Sprite
---@field controller_xbox_righttrigger Sprite
---@field controller_xbox_lefttrigger Sprite
---@field controller_xbox_left_stick Sprite
---@field controller_xbox_right_stick Sprite
---@field controller_xbox_black_a Sprite
---@field controller_xbox_black_b Sprite
---@field controller_xbox_black_x Sprite
---@field controller_xbox_black_y Sprite
---@field controller_xbox_black_back Sprite
---@field controller_xbox_black_start Sprite
---@field controller_xbox_black_leftstick Sprite
---@field controller_xbox_black_rightstick Sprite
---@field controller_xbox_black_leftshoulder Sprite
---@field controller_xbox_black_rightshoulder Sprite
---@field controller_xbox_black_dpup Sprite
---@field controller_xbox_black_dpdown Sprite
---@field controller_xbox_black_dpleft Sprite
---@field controller_xbox_black_dpright Sprite
---@field controller_xbox_black_righttrigger Sprite
---@field controller_xbox_black_lefttrigger Sprite
---@field controller_xbox_black_left_stick Sprite
---@field controller_xbox_black_right_stick Sprite
---@field controller_ps_a Sprite
---@field controller_ps_b Sprite
---@field controller_ps_x Sprite
---@field controller_ps_y Sprite
---@field controller_ps_back Sprite
---@field controller_ps_start Sprite
---@field controller_ps_leftstick Sprite
---@field controller_ps_rightstick Sprite
---@field controller_ps_leftshoulder Sprite
---@field controller_ps_rightshoulder Sprite
---@field controller_ps_dpup Sprite
---@field controller_ps_dpdown Sprite
---@field controller_ps_dpleft Sprite
---@field controller_ps_dpright Sprite
---@field controller_ps_righttrigger Sprite
---@field controller_ps_lefttrigger Sprite
---@field controller_ps_left_stick Sprite
---@field controller_ps_right_stick Sprite
---@field controller_ps_black_a Sprite
---@field controller_ps_black_b Sprite
---@field controller_ps_black_x Sprite
---@field controller_ps_black_y Sprite
---@field controller_ps_black_back Sprite
---@field controller_ps_black_start Sprite
---@field controller_ps_black_leftstick Sprite
---@field controller_ps_black_rightstick Sprite
---@field controller_ps_black_leftshoulder Sprite
---@field controller_ps_black_rightshoulder Sprite
---@field controller_ps_black_dpup Sprite
---@field controller_ps_black_dpdown Sprite
---@field controller_ps_black_dpleft Sprite
---@field controller_ps_black_dpright Sprite
---@field controller_ps_black_righttrigger Sprite
---@field controller_ps_black_lefttrigger Sprite
---@field controller_ps_black_left_stick Sprite
---@field controller_ps_black_right_stick Sprite
---@field controller_steamdeck_a Sprite
---@field controller_steamdeck_b Sprite
---@field controller_steamdeck_x Sprite
---@field controller_steamdeck_y Sprite
---@field controller_steamdeck_back Sprite
---@field controller_steamdeck_start Sprite
---@field controller_steamdeck_leftstick Sprite
---@field controller_steamdeck_rightstick Sprite
---@field controller_steamdeck_leftshoulder Sprite
---@field controller_steamdeck_rightshoulder Sprite
---@field controller_steamdeck_dpup Sprite
---@field controller_steamdeck_dpdown Sprite
---@field controller_steamdeck_dpleft Sprite
---@field controller_steamdeck_dpright Sprite
---@field controller_steamdeck_paddle1 Sprite
---@field controller_steamdeck_paddle2 Sprite
---@field controller_steamdeck_paddle3 Sprite
---@field controller_steamdeck_paddle4 Sprite
---@field controller_steamdeck_righttrigger Sprite
---@field controller_steamdeck_lefttrigger Sprite
---@field controller_steamdeck_left_stick Sprite
---@field controller_steamdeck_right_stick Sprite
---@field controller_steamdeck_black_a Sprite
---@field controller_steamdeck_black_b Sprite
---@field controller_steamdeck_black_x Sprite
---@field controller_steamdeck_black_y Sprite
---@field controller_steamdeck_black_back Sprite
---@field controller_steamdeck_black_start Sprite
---@field controller_steamdeck_black_leftstick Sprite
---@field controller_steamdeck_black_rightstick Sprite
---@field controller_steamdeck_black_leftshoulder Sprite
---@field controller_steamdeck_black_rightshoulder Sprite
---@field controller_steamdeck_black_dpup Sprite
---@field controller_steamdeck_black_dpdown Sprite
---@field controller_steamdeck_black_dpleft Sprite
---@field controller_steamdeck_black_dpright Sprite
---@field controller_steamdeck_black_paddle1 Sprite
---@field controller_steamdeck_black_paddle2 Sprite
---@field controller_steamdeck_black_paddle3 Sprite
---@field controller_steamdeck_black_paddle4 Sprite
---@field controller_steamdeck_black_righttrigger Sprite
---@field controller_steamdeck_black_lefttrigger Sprite
---@field controller_steamdeck_black_left_stick Sprite
---@field controller_steamdeck_black_right_stick Sprite
---@field clouds Animation
---@field arrow_button Animation
---@field explosion_chart_visualization Animation
---@field refresh_white Animation
---@field navmesh_pending_icon Animation
---@field inserter_stack_size_bonus_modifier_icon Sprite
---@field inserter_stack_size_bonus_modifier_constant Sprite|nil
---@field bulk_inserter_capacity_bonus_modifier_icon Sprite
---@field bulk_inserter_capacity_bonus_modifier_constant Sprite|nil
---@field laboratory_speed_modifier_icon Sprite
---@field laboratory_speed_modifier_constant Sprite|nil
---@field character_logistic_trash_slots_modifier_icon Sprite
---@field character_logistic_trash_slots_modifier_constant Sprite|nil
---@field maximum_following_robots_count_modifier_icon Sprite
---@field maximum_following_robots_count_modifier_constant Sprite|nil
---@field worker_robot_speed_modifier_icon Sprite
---@field worker_robot_speed_modifier_constant Sprite|nil
---@field worker_robot_storage_modifier_icon Sprite
---@field worker_robot_storage_modifier_constant Sprite|nil
---@field create_ghost_on_entity_death_modifier_icon Sprite
---@field create_ghost_on_entity_death_modifier_constant Sprite|nil
---@field turret_attack_modifier_icon Sprite
---@field turret_attack_modifier_constant Sprite|nil
---@field ammo_damage_modifier_icon Sprite
---@field ammo_damage_modifier_constant Sprite|nil
---@field give_item_modifier_icon Sprite
---@field give_item_modifier_constant Sprite|nil
---@field gun_speed_modifier_icon Sprite
---@field gun_speed_modifier_constant Sprite|nil
---@field unlock_recipe_modifier_icon Sprite
---@field unlock_recipe_modifier_constant Sprite|nil
---@field character_crafting_speed_modifier_icon Sprite
---@field character_crafting_speed_modifier_constant Sprite|nil
---@field character_mining_speed_modifier_icon Sprite
---@field character_mining_speed_modifier_constant Sprite|nil
---@field character_running_speed_modifier_icon Sprite
---@field character_running_speed_modifier_constant Sprite|nil
---@field character_build_distance_modifier_icon Sprite
---@field character_build_distance_modifier_constant Sprite|nil
---@field character_item_drop_distance_modifier_icon Sprite
---@field character_item_drop_distance_modifier_constant Sprite|nil
---@field character_reach_distance_modifier_icon Sprite
---@field character_reach_distance_modifier_constant Sprite|nil
---@field character_resource_reach_distance_modifier_icon Sprite
---@field character_resource_reach_distance_modifier_constant Sprite|nil
---@field character_item_pickup_distance_modifier_icon Sprite
---@field character_item_pickup_distance_modifier_constant Sprite|nil
---@field character_loot_pickup_distance_modifier_icon Sprite
---@field character_loot_pickup_distance_modifier_constant Sprite|nil
---@field character_inventory_slots_bonus_modifier_icon Sprite
---@field character_inventory_slots_bonus_modifier_constant Sprite|nil
---@field deconstruction_time_to_live_modifier_icon Sprite
---@field deconstruction_time_to_live_modifier_constant Sprite|nil
---@field max_failed_attempts_per_tick_per_construction_queue_modifier_icon Sprite
---@field max_failed_attempts_per_tick_per_construction_queue_modifier_constant Sprite|nil
---@field max_successful_attempts_per_tick_per_construction_queue_modifier_icon Sprite
---@field max_successful_attempts_per_tick_per_construction_queue_modifier_constant Sprite|nil
---@field character_health_bonus_modifier_icon Sprite
---@field character_health_bonus_modifier_constant Sprite|nil
---@field mining_drill_productivity_bonus_modifier_icon Sprite
---@field mining_drill_productivity_bonus_modifier_constant Sprite|nil
---@field train_braking_force_bonus_modifier_icon Sprite
---@field train_braking_force_bonus_modifier_constant Sprite|nil
---@field worker_robot_battery_modifier_icon Sprite
---@field worker_robot_battery_modifier_constant Sprite|nil
---@field laboratory_productivity_modifier_icon Sprite
---@field laboratory_productivity_modifier_constant Sprite|nil
---@field follower_robot_lifetime_modifier_icon Sprite
---@field follower_robot_lifetime_modifier_constant Sprite|nil
---@field artillery_range_modifier_icon Sprite
---@field artillery_range_modifier_constant Sprite|nil
---@field nothing_modifier_icon Sprite
---@field nothing_modifier_constant Sprite|nil
---@field character_additional_mining_categories_modifier_icon Sprite
---@field character_additional_mining_categories_modifier_constant Sprite|nil
---@field character_logistic_requests_modifier_icon Sprite
---@field character_logistic_requests_modifier_constant Sprite|nil
---@field unlock_space_location_modifier_icon Sprite
---@field unlock_space_location_modifier_constant Sprite|nil
---@field unlock_quality_modifier_icon Sprite
---@field unlock_quality_modifier_constant Sprite|nil
---@field unlock_space_platforms_modifier_icon Sprite
---@field unlock_space_platforms_modifier_constant Sprite|nil
---@field unlock_circuit_network_modifier_icon Sprite
---@field unlock_circuit_network_modifier_constant Sprite|nil
---@field cargo_landing_pad_count_modifier_icon Sprite
---@field cargo_landing_pad_count_modifier_constant Sprite|nil
---@field change_recipe_productivity_modifier_icon Sprite
---@field change_recipe_productivity_modifier_constant Sprite|nil
---@field cliff_deconstruction_enabled_modifier_icon Sprite
---@field cliff_deconstruction_enabled_modifier_constant Sprite|nil
---@field mining_with_fluid_modifier_icon Sprite
---@field mining_with_fluid_modifier_constant Sprite|nil
---@field rail_support_on_deep_oil_ocean_modifier_icon Sprite
---@field rail_support_on_deep_oil_ocean_modifier_constant Sprite|nil
---@field rail_planner_allow_elevated_rails_modifier_icon Sprite
---@field rail_planner_allow_elevated_rails_modifier_constant Sprite|nil
---@field beacon_distribution_modifier_icon Sprite
---@field beacon_distribution_modifier_constant Sprite|nil
---@field belt_stack_size_bonus_modifier_icon Sprite
---@field belt_stack_size_bonus_modifier_constant Sprite|nil
---@field vehicle_logistics_modifier_icon Sprite
---@field vehicle_logistics_modifier_constant Sprite|nil

---@class ValvePrototype: EntityWithOwnerPrototype
---@field mode ValveMode
---@field threshold number|nil
---@field fluid_box FluidBox
---@field flow_rate FluidAmount
---@field animations Animation4Way|nil
---@field frozen_patch Sprite4Way|nil

---@class VehiclePrototype: EntityWithOwnerPrototype
---@field weight number
---@field braking_power Energy|number
---@field braking_force Energy|number
---@field friction number
---@field friction_force number
---@field energy_per_hit_point number
---@field terrain_friction_modifier number|nil
---@field impact_speed_to_volume_ratio number|nil
---@field stop_trigger_speed number|nil
---@field crash_trigger TriggerEffect|nil
---@field stop_trigger TriggerEffect|nil
---@field equipment_grid EquipmentGridID|nil
---@field minimap_representation Sprite|nil
---@field selected_minimap_representation Sprite|nil
---@field allow_passengers boolean|nil
---@field deliver_category string|nil
---@field chunk_exploration_radius integer|nil
---@field allow_remote_driving boolean|nil

---@class VirtualSignalPrototype: Prototype
---@field icons IconData[]|nil
---@field icon FileName|nil
---@field icon_size SpriteSizeType|nil

---@class WallPrototype: EntityWithOwnerPrototype
---@field pictures WallPictures|nil
---@field visual_merge_group integer|nil
---@field circuit_wire_max_distance number|nil
---@field draw_copper_wires boolean|nil
---@field draw_circuit_wires boolean|nil
---@field circuit_connector CircuitConnectorDefinition|nil
---@field default_output_signal SignalIDConnector|nil
---@field wall_diode_green Sprite4Way|nil
---@field wall_diode_red Sprite4Way|nil
---@field wall_diode_green_light_top LightDefinition|nil
---@field wall_diode_green_light_right LightDefinition|nil
---@field wall_diode_green_light_bottom LightDefinition|nil
---@field wall_diode_green_light_left LightDefinition|nil
---@field wall_diode_red_light_top LightDefinition|nil
---@field wall_diode_red_light_right LightDefinition|nil
---@field wall_diode_red_light_bottom LightDefinition|nil
---@field wall_diode_red_light_left LightDefinition|nil
---@field connected_gate_visualization Sprite|nil

---@class data
---@field raw table<string, table<string, table>>
---@field extend fun(self: data, prototypes: table[])
---@type data
data = nil

---@type table<string, string>
mods = nil
