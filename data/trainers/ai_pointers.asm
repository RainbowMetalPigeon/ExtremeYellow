TrainerAIPointers:
	table_width 3, TrainerAIPointers
	; one entry per trainer class
	; first byte, number of times (per Pokémon) it can occur
	; next two bytes, pointer to AI subroutine for trainer class
	; subroutines are defined in engine/battle/trainer_ai.asm
	dbw 3, GenericAI ; YOUNGSTER
	dbw 3, GenericAI ; BUG_CATCHER
	dbw 3, GenericAI ; LASS
	dbw 3, GenericAI ; SAILOR
;	dbw 3, GenericAI ; JR_TRAINER_M
	dbw 3, GenericAI ; JR_TRAINER_F
	dbw 3, GenericAI ; POKEMANIAC
	dbw 3, GenericAI ; SUPER_NERD
	dbw 3, GenericAI ; HIKER
	dbw 3, GenericAI ; BIKER
	dbw 3, GenericAI ; BURGLAR
	dbw 3, GenericAI ; ENGINEER
;	dbw 3, GenericAI ; UNUSED_JUGGLER
	dbw 3, GenericAI ; FISHER
	dbw 3, GenericAI ; SWIMMER
	dbw 3, GenericAI ; CUE_BALL
	dbw 3, GenericAI ; GAMBLER
	dbw 3, GenericAI ; BEAUTY
	dbw 3, GenericAI ; PSYCHIC_TR
	dbw 3, GenericAI ; ROCKER
	dbw 3, GenericAI ; JUGGLER ; edited
	dbw 3, GenericAI ; TAMER
	dbw 3, GenericAI ; BIRD_KEEPER
	dbw 2, BlackbeltAI ; BLACKBELT
	dbw 3, GenericAI ; RIVAL1
	dbw 1, ProfOakAI ; PROF_OAK
;	dbw 1, GenericAI ; CHIEF
	dbw 3, GenericAI ; SCIENTIST
	dbw 1, GiovanniAI ; GIOVANNI
	dbw 3, GenericAI ; ROCKET
;	dbw 2, CooltrainerMAI ; COOLTRAINER_M
	dbw 1, CooltrainerAI ; COOLTRAINER_F
	dbw 2, BrunoAI ; BRUNO
	dbw 5, BrockAI ; BROCK
	dbw 1, MistyAI ; MISTY
	dbw 1, LtSurgeAI ; LT_SURGE
	dbw 1, ErikaAI ; ERIKA
	dbw 2, KogaAI ; KOGA
	dbw 2, BlaineAI ; BLAINE
	dbw 1, SabrinaAI ; SABRINA
	dbw 3, GenericAI ; GENTLEMAN
	dbw 2, Rival2AI ; RIVAL2
	dbw 3, Rival3AI ; RIVAL3 ; updated
	dbw 2, LoreleiAI ; LORELEI
	dbw 3, GenericAI ; CHANNELER
	dbw 2, AgathaAI ; AGATHA
	dbw 1, LanceAI ; LANCE
; new classes
	dbw 3, GenericAI ; DIVER
	dbw 3, GenericAI ; JESSIEJAMES
	dbw 3, OrageAI   ; ORAGE
	dbw 3, GenericAI ; PIGEON
	dbw 3, GenericAI ; TRAVELER
	dbw 3, GenericAI ; BF_TRAINER
	dbw 3, GenericAI ; MISSINGNO_T

	assert_table_length NUM_TRAINERS
