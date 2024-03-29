; sprite facing directions
	const_def 0, $04
	const SPRITE_FACING_DOWN  ; $00
	const SPRITE_FACING_UP    ; $04
	const SPRITE_FACING_LEFT  ; $08
	const SPRITE_FACING_RIGHT ; $0C

	const_def 0, $40
	const NPC_MOVEMENT_DOWN  ; $00
	const NPC_MOVEMENT_UP    ; $40
	const NPC_MOVEMENT_LEFT  ; $80
	const NPC_MOVEMENT_RIGHT ; $C0

	; new, testing: "Fast south" = 4, then north= 5, west = 6, and east = 7
	const_def 4, $1
	const NPC_FAST_MOVEMENT_DOWN  ; $04
	const NPC_FAST_MOVEMENT_UP    ; $05
	const NPC_FAST_MOVEMENT_LEFT  ; $06
	const NPC_FAST_MOVEMENT_RIGHT ; $07

DEF NPC_CHANGE_FACING EQU $E0

; player direction constants
	const_def
	const PLAYER_DIR_BIT_RIGHT ; 0
	const PLAYER_DIR_BIT_LEFT  ; 1
	const PLAYER_DIR_BIT_DOWN  ; 2
	const PLAYER_DIR_BIT_UP    ; 3

DEF PLAYER_DIR_RIGHT EQU 1 << PLAYER_DIR_BIT_RIGHT
DEF PLAYER_DIR_LEFT  EQU 1 << PLAYER_DIR_BIT_LEFT
DEF PLAYER_DIR_DOWN  EQU 1 << PLAYER_DIR_BIT_DOWN
DEF PLAYER_DIR_UP    EQU 1 << PLAYER_DIR_BIT_UP
