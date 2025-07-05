; monochrome palette color ids
	const_def
	const SHADE_WHITE ; %00
	const SHADE_LIGHT ; %01
	const SHADE_DARK  ; %10
	const SHADE_BLACK ; %11
DEF NUM_PAL_COLORS EQU const_value

DEF PAL_COLOR_SIZE EQU 2
DEF PALETTE_SIZE EQU NUM_PAL_COLORS * PAL_COLOR_SIZE

DEF NUM_ACTIVE_PALS EQU 4

; pal/blk packets
; SetPalFunctions indexes (see engine/gfx/palettes.asm)
	const_def
	const SET_PAL_BATTLE_BLACK         ; $00
	const SET_PAL_BATTLE               ; $01
	const SET_PAL_TOWN_MAP             ; $02
	const SET_PAL_STATUS_SCREEN        ; $03
	const SET_PAL_POKEDEX              ; $04
	const SET_PAL_SLOTS                ; $05
	const SET_PAL_TITLE_SCREEN         ; $06
	const SET_PAL_NIDORINO_INTRO       ; $07
	const SET_PAL_GENERIC              ; $08
	const SET_PAL_OVERWORLD            ; $09
	const SET_PAL_PARTY_MENU           ; $0A
	const SET_PAL_POKEMON_WHOLE_SCREEN ; $0B
	const SET_PAL_GAME_FREAK_INTRO     ; $0C
	const SET_PAL_TRAINER_CARD         ; $0D
	const SET_PAL_BATTLE_METAL         ; new
	const SET_PAL_POKEDEX_SHINY        ; new

DEF SET_PAL_PARTY_MENU_HP_BARS EQU $fc
DEF SET_PAL_DEFAULT EQU $ff

; sgb palettes
; SuperPalettes indexes (see data/sgb/sgb_palettes.asm)
	const_def
	const PAL_ROUTE     ; $00
	const PAL_PALLET    ; $01
	const PAL_VIRIDIAN  ; $02
	const PAL_PEWTER    ; $03
	const PAL_CERULEAN  ; $04
	const PAL_LAVENDER  ; $05
	const PAL_VERMILION ; $06
	const PAL_CELADON   ; $07
	const PAL_OCHRE     ; $0B ; new, +1 for this and all the comments below
	const PAL_FUCHSIA   ; $08
	const PAL_OBSIDIAN  ; $0B ; new, +1 for this and all the comments below
	const PAL_CINNABAR  ; $09
	const PAL_INDIGO    ; $0A
	const PAL_SAFFRON   ; $0B
	const PAL_TOWNMAP   ; $0C
	const PAL_LOGO1     ; $0D
	const PAL_LOGO2     ; $0E
	const PAL_0F        ; $0F
	const PAL_MEWMON    ; $10
	const PAL_MEWMON2   ; $10 ; new, +1 for this and all the comments below
	const PAL_BLUEMON   ; $11
	const PAL_REDMON    ; $12
	const PAL_CYANMON   ; $13
	const PAL_PURPLEMON ; $14
	const PAL_BROWNMON  ; $15
	const PAL_GREENMON  ; $16
	const PAL_GREENLIGHTMON  ; new
	const PAL_PINKMON   ; $17
	const PAL_YELLOWMON ; $18
	const PAL_ORANGEMON ; new
	const PAL_GREYMON   ; $19
	const PAL_BLACKMON  ; new
	const PAL_SLOTS1    ; $1A
	const PAL_SLOTS2    ; $1B
	const PAL_SLOTS3    ; $1C
	const PAL_SLOTS4    ; $1D
	const PAL_BLACK     ; $1E
	const PAL_GREENBAR  ; $1F
	const PAL_YELLOWBAR ; $20
	const PAL_REDBAR    ; $21
	const PAL_BADGE     ; $22
	const PAL_CAVE      ; $23
	const PAL_GAMEFREAK ; $24
	const PAL_25        ; $25
	const PAL_26        ; $26
	const PAL_27        ; $27
	const PAL_VENUSTOISE ; $28 - new
	const PAL_PORYMON	; $29 - new
	const PAL_ZYGARDEC   ; new
	const PAL_UNECROZMA  ; new
	const PAL_MRAYQUAZA  ; new
	const PAL_EETERNATUS ; new
	const PAL_ARCEUS     ; new
	const PAL_METALMON   ; new, for STEEL moves
	const PAL_PORYMONSHINY ; new
	const PAL_VENUSTOISESHINY ; new
	const PAL_ZYGARDECSHINY ; new
	const PAL_UNECROZMASHINY ; new
	const PAL_MRAYQUAZASHINY ; new
	const PAL_EETERNATUSSHINY ; new
	const PAL_ARCEUSSHINY ; new
	const PAL_MISSINGNOSHINY ; new
	const PAL_EXTREME1 ; new
	const PAL_EXTREME2 ; new
	const PAL_MGENGAR ; new
	const PAL_MGENGARSHINY ; new
DEF NUM_SGB_PALS_HAUNTEDLESS EQU const_value ; new, used only to select palettes in Haunted maps
	const PAL_PALLET_00 ; new
	const PAL_PALLET_01 ; new
	const PAL_PALLET_02 ; new
	const PAL_PALLET_03 ; new
	const PAL_PALLET_04 ; new
	const PAL_PALLET_05 ; new
	const PAL_PALLET_06 ; new
	const PAL_PALLET_07 ; new
	const PAL_PALLET_08 ; new
	const PAL_PALLET_09 ; new
	const PAL_PALLET_10 ; new
	const PAL_PALLET_11 ; new
	const PAL_PALLET_12 ; new
	const PAL_PALLET_13 ; new
	const PAL_PALLET_14 ; new
	const PAL_PALLET_15 ; new
DEF NUM_SGB_PALS EQU const_value

; new for sevii
	const_def
	const PAL_SEVII_ROUTE        ; $00
	const PAL_SEVII_ONE_ISLAND   ; $01
	const PAL_SEVII_TWO_ISLAND   ; $02
	const PAL_SEVII_THREE_ISLAND ; $03
	const PAL_SEVII_FOUR_ISLAND  ; $04
	const PAL_SEVII_FIVE_ISLAND  ; $05
	const PAL_SEVII_SIX_ISLAND   ; $06
	const PAL_SEVII_SEVEN_ISLAND ; $07
	const PAL_SEVII_GREY         ; $08
	const PAL_SEVII_CAVE         ; $09
DEF NUM_SGB_PALS_SEVII EQU const_value
	