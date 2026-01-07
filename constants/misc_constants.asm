; Boolean checks
DEF FALSE EQU 0
DEF TRUE  EQU 1

; flag operations
	const_def
	const FLAG_RESET ; 0
	const FLAG_SET   ; 1
	const FLAG_TEST  ; 2

; wOptions
DEF TEXT_DELAY_FAST   EQU %001 ; 1
DEF TEXT_DELAY_MEDIUM EQU %011 ; 3
DEF TEXT_DELAY_SLOW   EQU %101 ; 5

	const_def 6
	const BIT_BATTLE_SHIFT     ; 6
	const BIT_BATTLE_ANIMATION ; 7

; new from Marcel for TM printing ----------------------
; wBagPocketsFlags
	const_def
	const BIT_KEY_ITEMS_POCKET   ; 0 ; is 1 if currently in Key Items pocket ; unnecessary
	const_skip                   ; 1 ; unused, leave space for a possible TM pocket
	const BIT_PRINT_INFO_BOX     ; 2 ; whether to print Item info box (i.e. only in start menu bag and battle)
	const_skip ; const BIT_PC_WITHDRAWING     ; 3 ; to prevent switching pockets when withdrawing from PC
	const_skip                   ; 4-7 ; unused
