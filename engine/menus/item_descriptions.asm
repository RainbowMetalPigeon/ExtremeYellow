DisplayItemDescription::
	ld a, [wcf91]
	dec a
	cp a, HM01 - 1
	jr c, .ok
	sub HM01 - FLOOR_B2F
.ok
	ld hl, ItemDescriptionPointers
	ld bc, 5
	call AddNTimes
	jp PrintText

ItemDescriptionPointers:
	text_far _MasterBallDescription		; MASTER_BALL
	text_end
	text_far _UltraBallDescription		; ULTRA_BALL
	text_end
	text_far _GreatBallDescription		; GREAT_BALL
	text_end
	text_far _PokeBallDescription		; POKE_BALL
	text_end
	text_far _TownMapDescription		; TOWN_MAP
	text_end
	text_far _BicycleDescription		; BICYCLE
	text_end
	text_far _UnusedItemDescription		; SURFBOARD
	text_end
	text_far _UnusedItemDescription		; SAFARI_BALL
	text_end
	text_far _UnusedItemDescription		; POKEDEX
	text_end
	text_far _MoonStoneDescription		; MOON_STONE
	text_end
	text_far _AntidoteDescription		; ANTIDOTE
	text_end
	text_far _BurnHealDescription		; BURN_HEAL
	text_end
	text_far _IceHealDescription		; ICE_HEAL
	text_end
	text_far _AwakeningDescription		; AWAKENING
	text_end
	text_far _ParlyzHealDescription		; PARLYZ_HEAL
	text_end
	text_far _FullRestoreDescription	; FULL_RESTORE
	text_end
	text_far _MaxPotionDescription		; MAX_POTION
	text_end
	text_far _HyperPotionDescription	; HYPER_POTION
	text_end
	text_far _SuperPotionDescription	; SUPER_POTION
	text_end
	text_far _PotionDescription			; POTION
	text_end
	text_far _UnusedItemDescription		; BOULDERBADGE
	text_end
	text_far _UnusedItemDescription		; CASCADEBADGE
	text_end
	text_far _UnusedItemDescription		; THUNDERBADGE
	text_end
	text_far _UnusedItemDescription		; RAINBOWBADGE
	text_end
	text_far _UnusedItemDescription		; SOULBADGE
	text_end
	text_far _UnusedItemDescription		; MARSHBADGE
	text_end
	text_far _UnusedItemDescription		; VOLCANOBADGE
	text_end
	text_far _UnusedItemDescription		; EARTHBADGE
	text_end
	text_far _EscapeRopeDescription		; ESCAPE_ROPE
	text_end
	text_far _RepelDescription			; REPEL
	text_end
	text_far _OldAmberDescription		; OLD_AMBER
	text_end
	text_far _FireStoneDescription		; FIRE_STONE
	text_end
	text_far _ThunderStoneDescription	; THUNDER_STONE
	text_end
	text_far _WaterStoneDescription		; WATER_STONE
	text_end
	text_far _HPUpDescription			; HP_UP
	text_end
	text_far _ProteinDescription		; PROTEIN
	text_end
	text_far _IronDescription			; IRON
	text_end
	text_far _CarbosDescription			; CARBOS
	text_end
	text_far _CalciumDescription		; CALCIUM
	text_end
	text_far _RareCandyDescription		; RARE_CANDY
	text_end
	text_far _DomeFossilDescription		; DOME_FOSSIL
	text_end
	text_far _HelixFossilDescription	; HELIX_FOSSIL
	text_end
	text_far _SecretKeyDescription		; SECRET_KEY
	text_end
	text_far _UnusedItemDescription		; UNUSED_ITEM
	text_end
	text_far _BikeVoucherDescription	; BIKE_VOUCHER
	text_end
	text_far _XAccuracyDescription		; X_ACCURACY
	text_end
	text_far _LeafStoneDescription		; LEAF_STONE
	text_end
	text_far _CardKeyDescription		; CARD_KEY
	text_end
	text_far _NuggetDescription			; NUGGET
	text_end
	text_far _UnusedItemDescription		; PP_UP_2
	text_end
	text_far _PokeDollDescription		; POKE_DOLL
	text_end
	text_far _FullHealDescription		; FULL_HEAL
	text_end
	text_far _ReviveDescription			; REVIVE
	text_end
	text_far _MaxReviveDescription		; MAX_REVIVE
	text_end
	text_far _GuardSpecDescription		; GUARD_SPEC
	text_end
	text_far _SuperRepelDescription		; SUPER_REPEL
	text_end
	text_far _MaxRepelDescription		; MAX_REPEL
	text_end
	text_far _DireHitDescription		; DIRE_HIT
	text_end
	text_far _UnusedItemDescription		; COIN
	text_end
	text_far _FreshWaterDescription		; FRESH_WATER
	text_end
	text_far _SodaPopDescription		; SODA_POP
	text_end
	text_far _LemonadeDescription		; LEMONADE
	text_end
	text_far _SSTicketDescription		; S_S_TICKET
	text_end
	text_far _GoldTeethDescription		; GOLD_TEETH
	text_end
	text_far _XAttackDescription		; X_ATTACK
	text_end
	text_far _XDefendDescription		; X_DEFEND
	text_end
	text_far _XSpeedDescription			; X_SPEED
	text_end
	text_far _XSpecialDescription		; X_SPECIAL
	text_end
	text_far _CoinCaseDescription		; COIN_CASE
	text_end
	text_far _OaksParcelDescription		; OAKS_PARCEL
	text_end
	text_far _ItemfinderDescription		; ITEMFINDER
	text_end
	text_far _SilphScopeDescription		; SILPH_SCOPE
	text_end
	text_far _PokeFluteDescription		; POKE_FLUTE
	text_end
	text_far _LiftKeyDescription		; LIFT_KEY
	text_end
	text_far _ExpAllDescription			; EXP_ALL
	text_end
	text_far _OldRodDescription			; OLD_ROD
	text_end
	text_far _GoodRodDescription		; GOOD_ROD
	text_end
	text_far _SuperRodDescription		; SUPER_ROD
	text_end
	text_far _PPUpDescription			; PP_UP
	text_end
	text_far _EtherDescription			; ETHER
	text_end
	text_far _MaxEtherDescription		; MAX_ETHER
	text_end
	text_far _ElixerDescription			; ELIXER
	text_end
	text_far _MaxElixerDescription		; MAX_ELIXER
	text_end

; Extreme Yellow new Items

	text_far _MegaStoneXDescription		; MEGA_STONE_X
	text_end
	text_far _MegaStoneYDescription		; MEGA_STONE_Y
	text_end
	text_far _SunStoneDescription		; SUN_STONE
	text_end
	text_far _IceStoneDescription		; ICE_STONE
	text_end
	text_far _KingsRockDescription		; KINGS_ROCK
	text_end
	text_far _MetalCoatDescription		; METAL_COAT
	text_end
	text_far _UpgradeDescription		; UPGRADE
	text_end
	text_far _DubiousDiskDescription	; DUBIOUS_DISK
	text_end
	text_far _FastBallDescription		; FAST_BALL
	text_end
	text_far _HeavyBallDescription		; HEAVY_BALL
	text_end
	text_far _LegendCandyDescription	; LEGEND_CANDY
	text_end
	text_far _BigNuggetDescription		; BIG_NUGGET
	text_end
	text_far _PerfecterDescription		; PERFECTER
	text_end
	text_far _LunarRelicDescription		; LUNAR_RELIC
	text_end
	text_far _IceOrbDescription			; ICE_ORB
	text_end
	text_far _ThunderOrbDescription		; THUNDER_ORB
	text_end
	text_far _FireOrbDescription		; FIRE_ORB
	text_end
	text_far _LightBallDescription		; LIGHT_BALL
	text_end
	text_far _MysteryMapDescription		; MYSTERY_MAP
	text_end
	text_far _LavaStoneDescription		; LAVA_STONE
	text_end
	text_far _MagmaStoneDescription		; MAGMA_STONE
	text_end
	text_far _MoltenStoneDescription	; MOLTEN_STONE
	text_end
	text_far _ArtifactDescription		; ARTIFACT
	text_end
	text_far _ChromogeneDescription		; CHROMOGENE
	text_end
	text_far _ShinyCharmDescription		; SHINY_CHARM
	text_end
	text_far _GutscheinDescription		; GUTSCHEIN
	text_end
	text_far _OnigiriBoxDescription		; ONIGIRI_BOX
	text_end
	text_far _LinkCableDescription		; LINK_CABLE
	text_end

; HMs

	text_far _HM01Description
	text_end
	text_far _HM02Description
	text_end
	text_far _HM03Description
	text_end
	text_far _HM04Description
	text_end
	text_far _HM05Description
	text_end

; TMs

	text_far _TM01Description
	text_end
	text_far _TM02Description
	text_end
	text_far _TM03Description
	text_end
	text_far _TM04Description
	text_end
	text_far _TM05Description
	text_end
	text_far _TM06Description
	text_end
	text_far _TM07Description
	text_end
	text_far _TM08Description
	text_end
	text_far _TM09Description
	text_end
	text_far _TM10Description
	text_end
	text_far _TM11Description
	text_end
	text_far _TM12Description
	text_end
	text_far _TM13Description
	text_end
	text_far _TM14Description
	text_end
	text_far _TM15Description
	text_end
	text_far _TM16Description
	text_end
	text_far _TM17Description
	text_end
	text_far _TM18Description
	text_end
	text_far _TM19Description
	text_end
	text_far _TM20Description
	text_end
	text_far _TM21Description
	text_end
	text_far _TM22Description
	text_end
	text_far _TM23Description
	text_end
	text_far _TM24Description
	text_end
	text_far _TM25Description
	text_end
	text_far _TM26Description
	text_end
	text_far _TM27Description
	text_end
	text_far _TM28Description
	text_end
	text_far _TM29Description
	text_end
	text_far _TM30Description
	text_end
	text_far _TM31Description
	text_end
	text_far _TM32Description
	text_end
	text_far _TM33Description
	text_end
	text_far _TM34Description
	text_end
	text_far _TM35Description
	text_end
	text_far _TM36Description
	text_end
	text_far _TM37Description
	text_end
	text_far _TM38Description
	text_end
	text_far _TM39Description
	text_end
	text_far _TM40Description
	text_end
	text_far _TM41Description
	text_end
	text_far _TM42Description
	text_end
	text_far _TM43Description
	text_end
	text_far _TM44Description
	text_end
	text_far _TM45Description
	text_end
	text_far _TM46Description
	text_end
	text_far _TM47Description
	text_end
	text_far _TM48Description
	text_end
	text_far _TM49Description
	text_end
	text_far _TM50Description
	text_end
	text_far _TM51Description
	text_end
	text_far _TM52Description
	text_end
	text_far _TM53Description
	text_end
	text_far _TM54Description
	text_end
	text_far _TM55Description
	text_end
