; item ids
; indexes for:
; - ItemNames (see data/items/names.asm)
; - ItemPrices (see data/items/prices.asm)
; - TechnicalMachinePrices (see data/items/tm_prices.asm)
; - KeyItemFlags (see data/items/key_items.asm)
; - ItemUsePtrTable (see engine/items/item_effects.asm)
; - ItemDescriptionPointers (see engine/menus/item_description.asm) ; new, for item description
	const_def
	const NO_ITEM       ; $00
	const MASTER_BALL   ; $01
	const ULTRA_BALL    ; $02
	const GREAT_BALL    ; $03
	const POKE_BALL     ; $04
	const TOWN_MAP      ; $05
	const BICYCLE       ; $06
	const SURFBOARD     ; $07 buggy?
	const SAFARI_BALL   ; $08
	const POKEDEX       ; $09
	const MOON_STONE    ; $0A
	const ANTIDOTE      ; $0B
	const BURN_HEAL     ; $0C
	const ICE_HEAL      ; $0D
	const AWAKENING     ; $0E
	const PARLYZ_HEAL   ; $0F
	const FULL_RESTORE  ; $10
	const MAX_POTION    ; $11
	const HYPER_POTION  ; $12
	const SUPER_POTION  ; $13
	const POTION        ; $14
	const BOULDERBADGE  ; $15
	const CASCADEBADGE  ; $16
DEF SAFARI_BAIT EQU $15 ; overload
DEF SAFARI_ROCK EQU $16 ; overload
	const THUNDERBADGE  ; $17
	const RAINBOWBADGE  ; $18
	const SOULBADGE     ; $19
	const MARSHBADGE    ; $1A
	const VOLCANOBADGE  ; $1B
	const EARTHBADGE    ; $1C
	const ESCAPE_ROPE   ; $1D
	const REPEL         ; $1E
	const OLD_AMBER     ; $1F
	const FIRE_STONE    ; $20
	const THUNDER_STONE ; $21
	const WATER_STONE   ; $22
	const HP_UP         ; $23
	const PROTEIN       ; $24
	const IRON          ; $25
	const CARBOS        ; $26
	const CALCIUM       ; $27
	const RARE_CANDY    ; $28
	const DOME_FOSSIL   ; $29
	const HELIX_FOSSIL  ; $2A
	const SECRET_KEY    ; $2B
	const CHEAT_CANDY   ; $2C ; new
	const BIKE_VOUCHER  ; $2D
	const X_ACCURACY    ; $2E
	const LEAF_STONE    ; $2F
	const CARD_KEY      ; $30
	const NUGGET        ; $31
	const PP_UP_2       ; $32
	const POKE_DOLL     ; $33
	const FULL_HEAL     ; $34
	const REVIVE        ; $35
	const MAX_REVIVE    ; $36
	const GUARD_SPEC    ; $37
	const SUPER_REPEL   ; $38
	const MAX_REPEL     ; $39
	const DIRE_HIT      ; $3A
	const COIN          ; $3B
	const FRESH_WATER   ; $3C
	const SODA_POP      ; $3D
	const LEMONADE      ; $3E
	const S_S_TICKET    ; $3F
	const GOLD_TEETH    ; $40
	const X_ATTACK      ; $41
	const X_DEFEND      ; $42
	const X_SPEED       ; $43
	const X_SPECIAL     ; $44
	const COIN_CASE     ; $45
	const OAKS_PARCEL   ; $46
	const ITEMFINDER    ; $47
	const SILPH_SCOPE   ; $48
	const POKE_FLUTE    ; $49
	const LIFT_KEY      ; $4A
	const EXP_ALL       ; $4B
	const OLD_ROD       ; $4C
	const GOOD_ROD      ; $4D
	const SUPER_ROD     ; $4E
	const PP_UP         ; $4F
	const ETHER         ; $50
	const MAX_ETHER     ; $51
	const ELIXER        ; $52
	const MAX_ELIXER    ; $53
	const MEGA_STONE_X  ; new
	const MEGA_STONE_Y  ; new
	const SUN_STONE     ; new
	const ICE_STONE     ; new
	const KINGS_ROCK	; new
	const METAL_COAT	; new
	const UPGRADE		; new
	const DUBIOUS_DISK	; new
	const FAST_BALL		; new
	const HEAVY_BALL	; new
	const LEGEND_CANDY  ; new
	const BIG_NUGGET	; new
	const PERFECTER     ; new
	const LUNAR_RELIC   ; new
	const ICE_ORB       ; new
	const THUNDER_ORB   ; new
	const FIRE_ORB      ; new
	const LIGHT_BALL    ; new
	const MYSTERY_MAP   ; new
	const LAVA_STONE    ; new
	const MAGMA_STONE   ; new
	const MOLTEN_STONE  ; new
	const ARTIFACT      ; new
	const CHROMOGENE    ; new
	const SHINY_CHARM   ; new
	const GUTSCHEIN     ; new
	const ONIGIRI_BOX   ; new
	const LINK_CABLE    ; new
	const AMULET_COIN   ; new
	const SEVII_TICKET  ; new
	const PEARL         ; new
DEF NUM_ITEMS EQU const_value - 1

; elevator floors use item IDs
	const FLOOR_B2F     ; $54
	const FLOOR_B1F     ; $55
	const FLOOR_1F      ; $56
	const FLOOR_2F      ; $57
	const FLOOR_3F      ; $58
	const FLOOR_4F      ; $59
	const FLOOR_5F      ; $5A
	const FLOOR_6F      ; $5B
	const FLOOR_7F      ; $5C
	const FLOOR_8F      ; $5D
	const FLOOR_9F      ; $5E
	const FLOOR_10F     ; $5F
	const FLOOR_11F     ; $60
	const FLOOR_B4F     ; $61
; new ----- I guess I can treat the special-dialogue "items" as "floors"
	const MEGASTONE_CLUE_1
	const MEGASTONE_CLUE_2
	const MEGASTONE_CLUE_3
	const MEGASTONE_CLUE_4
	const MEGASTONE_CLUE_5
	const MEGASTONE_CLUE_6
	const DARKGUIDE_HINT_1
	const DARKGUIDE_HINT_2
	const DARKGUIDE_HINT_3
	const DARKGUIDE_HINT_4
	const DARKGUIDE_HINT_5
	const DARKGUIDE_HINT_6
	const DARKGUIDE_HINT_7
	const DARKGUIDE_HINT_8
	const BILLSPC_EEVOLUTION_EEVEE
	const BILLSPC_EEVOLUTION_VAPOREON
	const BILLSPC_EEVOLUTION_JOLTEON
	const BILLSPC_EEVOLUTION_FLAREON
	const BILLSPC_EEVOLUTION_ESPEON
	const BILLSPC_EEVOLUTION_UMBREON
	const BILLSPC_EEVOLUTION_LEAFEON
	const BILLSPC_EEVOLUTION_GLACEON
	const BILLSPC_EEVOLUTION_SYLVEON
	const FERRY_VERMILION
	const FERRY_SEVII_ONE
	const FERRY_SEVII_TWO
	const FERRY_SEVII_THREE
	const FERRY_SEVII_FOUR
	const FERRY_SEVII_FIVE
	const FERRY_SEVII_SIX
	const FERRY_SEVII_SEVEN
	const FERRY_SEVII_EIGHT
DEF NUM_FLOORS EQU const_value - 1 - NUM_ITEMS

;	const_next $C4 ; should be totally unnecessary, and damaging if we want to add a ton of items & TMs

; HMs are defined before TMs, so the actual number of TM definitions
; is not yet available. The TM quantity is hard-coded here and must
; match the actual number below.
DEF NUM_TMS EQU 55 ; edited, was 50

DEF __tmhm_value__ = NUM_TMS + 1

MACRO add_tmnum
	DEF \1_TMNUM EQU __tmhm_value__
	DEF __tmhm_value__ += 1
ENDM

MACRO add_hm
; Defines three constants:
; - HM_\1: the item id, starting at $C4 ; edited, they now start right after the other items
; - \1_TMNUM: the learnable TM/HM flag, starting at 56 ; edited was 51
; - HM##_MOVE: alias for the move id, equal to the value of \1
	const HM_\1
	DEF HM_VALUE = __tmhm_value__ - NUM_TMS
	DEF HM{02d:HM_VALUE}_MOVE EQU \1
	add_tmnum \1
ENDM

DEF HM01 EQU const_value ; edited, the numbers below are now wrong
	add_hm CUT          ; $C4
	add_hm FLY          ; $C5
	add_hm SURF         ; $C6
	add_hm STRENGTH     ; $C7
	add_hm FLASH        ; $C8
	add_hm ROCK_SMASH   ; new
	add_hm ROCK_CLIMB   ; new
	add_hm WATERFALL    ; new
	add_hm DIVE         ; new
	add_hm WHIRLPOOL    ; new
DEF NUM_HMS EQU const_value - HM01

DEF __tmhm_value__ = 1

MACRO add_tm
; Defines three constants:
; - TM_\1: the item id, starting at $C9
; - \1_TMNUM: the learnable TM/HM flag, starting at 1
; - TM##_MOVE: alias for the move id, equal to the value of \1
	const TM_\1
	DEF TM{02d:__tmhm_value__}_MOVE EQU \1
	add_tmnum \1
ENDM

DEF TM01 EQU const_value
	add_tm MEGA_PUNCH   ; $C9 = TM01 - ground item: MtMoonB2F ; CeladonMart
	add_tm MEGAHORN     ; $CA = TM02 - ground item: RocketHideoutB4F
	add_tm SWORDS_DANCE ; $CB = TM03 - ground item: SilphCo7F
	add_tm COUNTER      ; $CC = TM04 - ground item: Route4 ; CeladonMart
	add_tm DRAGON_CLAW  ; $CD = TM05 - ground item: VictoryRoad2F
	add_tm TOXIC        ; $CE = TM06 - Gym prize Koga
	add_tm DARK_PULSE   ; $CF = TM07 - ground item: RocketHideoutB2F
	add_tm BODY_SLAM    ; $D0 = TM08 - ground item: SSAnne1FRooms ; CeladonMart
	add_tm METEOR_MASH  ; $D1 = TM09 - ground item: ObsidianWarehouse
	add_tm DOUBLE_EDGE  ; $D2 = TM10 - ground item: RocketHideoutB3F
	add_tm BUBBLEBEAM   ; $D3 = TM11 - Gym prize Misty ; CeladonMart
	add_tm METRONOME    ; $D4 = TM12 - ground item: MtMoon1F ; CeladonMart
	add_tm ICE_BEAM     ; $D5 = TM13 - gifted: CeladonMartRoof
	add_tm BLIZZARD     ; $D6 = TM14 - ground item: PokemonMansionB1F
	add_tm HYPER_BEAM   ; $D7 = TM15 - Casino prize, 5500
	add_tm MIRROR_COAT  ; $D8 = TM16 - ground item: Route12
	add_tm DRAININGKISS ; $D9 = TM17 - ground item: VictoryRoad2F
	add_tm FLASH_CANNON ; $DA = TM18 - gifted: CeladonMart3F
	add_tm SEISMIC_TOSS ; $DB = TM19 - ground item: Route25
	add_tm FEINT_ATTACK ; $DC = TM20 - ground item: Route15
	add_tm GIGA_DRAIN   ; $DD = TM21 - Gym prize Erika
	add_tm STONE_EDGE   ; $DE = TM22 - ground item: PokemonMansionB1F
	add_tm WILL_O_WISP  ; $DF = TM23 - Casino prize, 3300
	add_tm THUNDERBOLT  ; $E0 = TM24 - Gym prize LtSurge ; CeladonMart
	add_tm THUNDER      ; $E1 = TM25 - ground item: PowerPlant
	add_tm EARTHQUAKE   ; $E2 = TM26 - ground item: SilphCo10F
	add_tm FISSURE      ; $E3 = TM27 - Gym prize Giovanni
	add_tm DIG          ; $E4 = TM28 - gifted: CeruleanCity ; CeladonMart
	add_tm PSYCHIC_M    ; $E5 = TM29 - gifted: MrPsychicsHouse
	add_tm MOONBLAST    ; $E6 = TM30 - ground item: Route9
	add_tm MIMIC        ; $E7 = TM31 - gifted: CopycatsHouse2F
	add_tm DOUBLE_TEAM  ; $E8 = TM32 - ground item: SafariZoneWest
	add_tm REFLECT      ; $E9 = TM33 - ground item: Route24
	add_tm BIDE         ; $EA = TM34 - Gym prize Brock ; CeladonMart
	add_tm HYDRO_PUMP   ; $EB = TM35 - gifted: CinnabarLabMetronomeRoom
	add_tm SELFDESTRUCT ; $EC = TM36 - gifted: SilphCo2F
	add_tm CLOSE_COMBAT ; $ED = TM37 - ground item: SafariZoneEast
	add_tm FIRE_BLAST   ; $EE = TM38 - Gym prize Blaine
	add_tm SHADOW_SNEAK ; $EF = TM39 - gifted: Route12Gate2F
	add_tm OUTRAGE      ; $F0 = TM40 - ground item: SafariZoneNorth
	add_tm BRAVE_BIRD   ; $F1 = TM41 - gifted: CeladonCity
	add_tm REST         ; $F2 = TM42 - gifted: ViridianCity
	add_tm GUNK_SHOT    ; $F3 = TM43 - ground item: VictoryRoad1F
	add_tm X_SCISSOR    ; $F4 = TM44 - ground item: SSAnneB1FRooms ; CeladonMart
	add_tm THUNDER_WAVE ; $F5 = TM45 - ground item: PowerPlant
	add_tm PSYWAVE      ; $F6 = TM46 - Gym prize Sabrina
	add_tm EXPLOSION    ; $F7 = TM47 - ground item: VictoryRoad3F
	add_tm ROCK_SLIDE   ; $F8 = TM48 - gifted: CeladonMartRoof
	add_tm SHADOW_BALL  ; $F9 = TM49 - gifted: CeladonMartRoof
	add_tm SUBSTITUTE   ; $FA = TM50 - Casino prize: 7700
	; new TMs, 51-55
	add_tm FREEZE_DRY   ; $FB = TM51 - TBE
	add_tm GYRO_BALL    ; $FC = TM52 - TBE
	add_tm BODY_PRESS   ; $FD = TM53 - TBE
	add_tm FLAIL        ; $FE = TM54 - TBE
	add_tm CURSE        ; $FF = TM55 - TBE
ASSERT NUM_TMS == const_value - TM01, "NUM_TMS ({d:NUM_TMS}) does not match the number of add_tm definitions"

DEF NUM_TM_HM EQU NUM_TMS + NUM_HMS

; 55 (50) TMs + 5 HMs = 60 (55) learnable TM/HM flags per Pokémon.
; These fit in 8 (7) bytes, with four (one) unused bit(s) left over.
DEF __tmhm_value__ = NUM_TM_HM + 1
DEF UNUSED_TMNUM EQU __tmhm_value__

; used for Time Capsule held item compatibility
DEF TWISTEDSPOON_GSC EQU $60
DEF LIGHT_BALL_GSC   EQU $a3
