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
/*
; offset wrt vanilla types
	const_next 64 ; = $40

DEF PHYSICAL EQU const_value
	const TCG_COLORLESS    ; $40
	const TCG_FIGHTING     ; $41
	const TCG_METAL        ; $42
	const TCG_TYPELESS     ; $43=10

DEF SPECIAL EQU const_value
	const TCG_FIRE         ; $44=20
	const TCG_WATER        ; $45=21
	const TCG_GRASS        ; $46=22
	const TCG_LIGHTNING    ; $47=23
	const TCG_PSYCHIC      ; $48=24
	const TCG_DRAGON       ; $4A=26
	const TCG_DARK         ; $4B=27
;	const TCG_ICE2         ; $4D=29

DEF NUM_TYPES EQU const_value
*/
