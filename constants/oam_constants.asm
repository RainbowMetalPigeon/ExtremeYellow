; old definition -----
;; OAM flags used by this game
;DEF OAMFLAG_ENDOFDATA   EQU %00000001 ; pseudo OAM flag, only used by game logic ; FACING_END   ->  DEF FACING_END  EQU 1 << BIT_END_OF_OAM_DATA
;DEF OAMFLAG_CANBEMASKED EQU %00000010 ; pseudo OAM flag, only used by game logic ; UNDER_GRASS  ->  DEF UNDER_GRASS EQU 1 << BIT_SPRITE_UNDER_GRASS

; new definition -----

; Pseudo-OAM flags used by game logic
; edit from Engeze to give color to the player
	const_def 3
	const BIT_END_OF_OAM_DATA    ; 3
	const_next 7
	const BIT_SPRITE_UNDER_GRASS ; 7

; Used in SpriteFacingAndAnimationTable (see data/sprites/facings.asm)
DEF OAMFLAG_ENDOFDATA   EQU 1 << BIT_END_OF_OAM_DATA    ; FACING_END in the newer pokeyellow
DEF OAMFLAG_CANBEMASKED EQU 1 << BIT_SPRITE_UNDER_GRASS ; UNDER_GRASS in the newer pokeyellow

; other constants, not present in the newer pokeyellow versions -----

; OAM attribute flags
DEF OAM_PALETTE   EQU %111
DEF OAM_TILE_BANK EQU 3
DEF OAM_OBP_NUM   EQU 4 ; Non CGB Mode Only
DEF OAM_X_FLIP    EQU 5
DEF OAM_Y_FLIP    EQU 6
DEF OAM_PRIORITY  EQU 7 ; 0: OBJ above BG, 1: OBJ behind BG (colors 1-3)

; OAM attribute masks
DEF OAM_HIGH_PALS EQU 1 << 2            ; palettes %100-%111 are OBP1
DEF OAM_OBP1      EQU 1 << OAM_OBP_NUM  ; OBJ palette 1
DEF OAM_HFLIP     EQU 1 << OAM_X_FLIP   ; horizontal flip
DEF OAM_VFLIP     EQU 1 << OAM_Y_FLIP   ; vertical flip
DEF OAM_BEHIND_BG EQU 1 << OAM_PRIORITY ; behind bg (except color 0)
