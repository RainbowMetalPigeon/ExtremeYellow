; TypeNames indexes (see data/types/names.asm)
	const_def

DEF PHYSICAL EQU const_value
	const NORMAL       ; $00
	const FIGHTING     ; $01
	const FLYING       ; $02
	const POISON       ; $03
	const GROUND       ; $04
	const ROCK         ; $05
	const BIRD         ; $06
	const BUG          ; $07
	const GHOST        ; $08
	const STEEL        ; $09
	const TYPELESS     ; $0A=10
	const GROUND2      ; $0B=11 ; new, for THOUSANDARROWS

DEF UNUSED_TYPES EQU const_value
	const_next 20
DEF UNUSED_TYPES_END EQU const_value

DEF SPECIAL EQU const_value
	const FIRE         ; $14=20
	const WATER        ; $15=21
	const GRASS        ; $16=22
	const ELECTRIC     ; $17=23
	const PSYCHIC_TYPE ; $18=24
	const ICE          ; $19=25
	const DRAGON       ; $1A=26
	const DARK         ; $1B=27
	const FAIRY        ; $1C=28
	const ICE2         ; $1D=29 ; new, for FREEZE_DRY

DEF NUM_TYPES EQU const_value

; new, for TCG mode ==================================

; reset the "counter"
	const_def

DEF PHYSICAL_TCG EQU const_value
	const TCG_COLORLESS    ; $00
	const TCG_FIGHTING     ; $01
	const TCG_METAL        ; $02
	const TCG_TYPELESS     ; $03

DEF SPECIAL_TCG EQU const_value
	const TCG_FIRE         ; $04
	const TCG_WATER        ; $05
	const TCG_GRASS        ; $06
	const TCG_LIGHTNING    ; $07
	const TCG_PSYCHIC      ; $08
	const TCG_DRAGON       ; $0A
	const TCG_DARK         ; $0B
	const TCG_WATER2       ; $0D

DEF NUM_TYPES_TCG EQU const_value - PHYSICAL_TCG
