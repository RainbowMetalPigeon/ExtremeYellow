MACRO move_choices
	IF _NARG
		db \# ; all args
	ENDC
	db 0 ; end
	DEF list_index += 1
ENDM

; move choice modification methods that are applied for each trainer class
TrainerClassMoveChoiceModifications:
	list_start TrainerClassMoveChoiceModifications
	move_choices         ; YOUNGSTER
	move_choices 1       ; BUG CATCHER
	move_choices 1       ; LASS
	move_choices 1, 3    ; SAILOR
;	move_choices 1       ; JR_TRAINER_M
	move_choices 1       ; JR_TRAINER_F
	move_choices 1, 2, 3 ; POKEMANIAC
	move_choices 1, 2    ; SUPER_NERD
	move_choices 1       ; HIKER
	move_choices 1       ; BIKER
	move_choices 1, 3    ; BURGLAR
	move_choices 1       ; ENGINEER
;	move_choices 1, 2    ; UNUSED_JUGGLER
	move_choices 1, 3    ; FISHER
	move_choices 1, 3    ; SWIMMER
	move_choices         ; CUE_BALL
	move_choices 1       ; GAMBLER
	move_choices 1, 3    ; BEAUTY
	move_choices 1, 2    ; PSYCHIC_TR
	move_choices 1       ; ROCKER
	move_choices 1       ; JUGGLER
	move_choices 1       ; TAMER
	move_choices 1       ; BIRD_KEEPER
	move_choices 1       ; BLACKBELT
	move_choices 1       ; RIVAL1
	move_choices 1, 3    ; PROF_OAK
;	move_choices 1, 2    ; CHIEF
	move_choices 1, 2, 3 ; SCIENTIST ; updated
	move_choices 1, 3    ; GIOVANNI
	move_choices 1, 2    ; ROCKET, updated, it was only 1
;	move_choices 1, 3    ; COOLTRAINER_M
	move_choices 1, 3    ; COOLTRAINER
	move_choices 1, 3    ; BRUNO ; updated
	move_choices 1, 3    ; BROCK ; updated
	move_choices 1, 3    ; MISTY
	move_choices 1, 3    ; LT_SURGE ; updated
	move_choices 1, 3    ; ERIKA
	move_choices 1, 3    ; KOGA
	move_choices 1, 3    ; BLAINE ; updated
	move_choices 1, 3    ; SABRINA ; updated
	move_choices 1, 2    ; GENTLEMAN
	move_choices 1, 3    ; RIVAL2
	move_choices 1, 3    ; RIVAL3
	move_choices 1, 2, 3 ; LORELEI
	move_choices 1       ; CHANNELER
	move_choices 1, 2, 3 ; AGATHA ; updated
	move_choices 1, 3    ; LANCE
; new classes
	move_choices 1, 2, 3 ; ORAGE
	move_choices 1, 2, 3 ; PIGEON
	move_choices 1, 2, 3 ; TRAVELER
	move_choices 1, 2, 3 ; BF_TRAINER
	move_choices 1, 2, 3 ; MISSINGNO_T
	assert_list_length NUM_TRAINERS
