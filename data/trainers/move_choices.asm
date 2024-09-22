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
	move_choices            ; YOUNGSTER
	move_choices 1          ; BUG_CATCHER
	move_choices 1          ; LASS
	move_choices 1, 3       ; SAILOR
;	move_choices 1, 2       ; JR_TRAINER_M ; edited
	move_choices 1, 2       ; JR_TRAINER_F ; edited
	move_choices 1, 2, 4    ; POKEMANIAC ; edited
	move_choices 1, 2, 3, 4 ; SUPER_NERD ; edited
	move_choices 1, 3       ; HIKER ; edited
	move_choices 1          ; BIKER
	move_choices 1, 3, 4    ; BURGLAR ; edited
	move_choices 1, 2, 3, 4 ; ENGINEER ; edited
;	move_choices 1, 2       ; UNUSED_JUGGLER
	move_choices 1, 3, 4    ; FISHER ; edited
	move_choices 1, 2, 3    ; SWIMMER ; edited
	move_choices            ; CUE_BALL
	move_choices 1, 2, 4    ; GAMBLER ; edited
	move_choices 1, 3, 4    ; BEAUTY ; edited
	move_choices 1, 2, 3, 4 ; PSYCHIC_TR ; edited
	move_choices 1, 2, 3    ; ROCKER ; edited
	move_choices 1, 2, 3, 4 ; JUGGLER ; edited
	move_choices 1, 2, 3, 4 ; TAMER ; edited
	move_choices 1, 2, 3, 4 ; BIRD_KEEPER ; edited
	move_choices 1, 2, 3    ; BLACKBELT ; edited
	move_choices 1          ; RIVAL1
	move_choices 1, 2, 3, 4 ; PROF_OAK ; edited
;	move_choices 1, 2       ; CHIEF
	move_choices 1, 2, 3, 4 ; SCIENTIST ; edited
	move_choices 1, 2, 3    ; GIOVANNI ; edited
	move_choices 1, 2, 3    ; ROCKET ; edited
;	move_choices 1, 3       ; COOLTRAINER_M
	move_choices 1, 2, 3, 4 ; COOLTRAINER ; edited
	move_choices 1, 2, 3, 4 ; BRUNO ; edited
	move_choices 1, 2, 3, 4 ; BROCK ; edited
	move_choices 1, 2, 3, 4 ; MISTY ; edited
	move_choices 1, 2, 3, 4 ; LT_SURGE ; edited
	move_choices 1, 2, 3, 4 ; ERIKA ; edited
	move_choices 1, 2, 3, 4 ; KOGA ; edited
	move_choices 1, 2, 3, 4 ; BLAINE ; edited
	move_choices 1, 2, 3, 4 ; SABRINA ; edited
	move_choices 1, 2, 3, 4 ; GENTLEMAN ; edited
	move_choices 1, 2, 3, 4 ; RIVAL2 ; edited
	move_choices 1, 2, 3    ; RIVAL3 ; edited
	move_choices 1, 2, 3, 4 ; LORELEI ; edited
	move_choices 1, 2, 3, 4 ; CHANNELER ; edited
	move_choices 1, 2, 3, 4 ; AGATHA ; edited
	move_choices 1, 2, 3, 4 ; LANCE ; edited
; new classes
	move_choices 1, 2, 3, 4 ; ORAGE
	move_choices 1, 2, 3    ; PIGEON
	move_choices 1, 2, 3, 4 ; TRAVELER
	move_choices 1, 2, 3, 4 ; BF_TRAINER
	move_choices 1, 2, 3    ; MISSINGNO_T
	assert_list_length NUM_TRAINERS
