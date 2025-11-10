SeviiRoute38DiveCavern_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SeviiRoute38DiveCavernTrainerHeaders
	ld de, SeviiRoute38DiveCavern_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

SeviiRoute38DiveCavern_TextPointers:
	dw SeviiRoute38DiveCavernText1
	dw SeviiRoute38DiveCavernText2
	dw SeviiRoute38DiveCavernText3
	dw SeviiRoute38DiveCavernText4
	dw SeviiRoute38DiveCavernText5
	dw SeviiRoute38DiveCavernText6
	dw SeviiRoute38DiveCavernText7
	dw SeviiRoute38DiveCavernText8
	dw SeviiRoute38DiveCavernText9
	dw SeviiRoute38DiveCavernText10
	dw PickUpItemText

SeviiRoute38DiveCavern_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

SeviiRoute38DiveCavernTrainerHeaders:
	def_trainers
SeviiRoute38DiveCavernTrainerHeader1:
	trainer EVENT_BEAT_SEVII_ROUTE_38_DIVE_CAVERN_TRAINER_1, 4, SeviiRoute38DiveCavernBattleText1, SeviiRoute38DiveCavernEndBattleText1, SeviiRoute38DiveCavernAfterBattleText1
SeviiRoute38DiveCavernTrainerHeader2:
	trainer EVENT_BEAT_SEVII_ROUTE_38_DIVE_CAVERN_TRAINER_2, 4, SeviiRoute38DiveCavernBattleText2, SeviiRoute38DiveCavernEndBattleText2, SeviiRoute38DiveCavernAfterBattleText2
SeviiRoute38DiveCavernTrainerHeader3:
	trainer EVENT_BEAT_SEVII_ROUTE_38_DIVE_CAVERN_TRAINER_3, 4, SeviiRoute38DiveCavernBattleText3, SeviiRoute38DiveCavernEndBattleText3, SeviiRoute38DiveCavernAfterBattleText3
SeviiRoute38DiveCavernTrainerHeader4:
	trainer EVENT_BEAT_SEVII_ROUTE_38_DIVE_CAVERN_TRAINER_4, 4, SeviiRoute38DiveCavernBattleText4, SeviiRoute38DiveCavernEndBattleText4, SeviiRoute38DiveCavernAfterBattleText4
SeviiRoute38DiveCavernTrainerHeader5:
	trainer EVENT_BEAT_SEVII_ROUTE_38_DIVE_CAVERN_TRAINER_5, 4, SeviiRoute38DiveCavernBattleText5, SeviiRoute38DiveCavernEndBattleText5, SeviiRoute38DiveCavernAfterBattleText5
SeviiRoute38DiveCavernTrainerHeader6:
	trainer EVENT_BEAT_SEVII_ROUTE_38_DIVE_CAVERN_TRAINER_6, 4, SeviiRoute38DiveCavernBattleText6, SeviiRoute38DiveCavernEndBattleText6, SeviiRoute38DiveCavernAfterBattleText6
SeviiRoute38DiveCavernTrainerHeader7:
	trainer EVENT_BEAT_SEVII_ROUTE_38_DIVE_CAVERN_TRAINER_7, 4, SeviiRoute38DiveCavernBattleText7, SeviiRoute38DiveCavernEndBattleText7, SeviiRoute38DiveCavernAfterBattleText7
SeviiRoute38DiveCavernTrainerHeader8:
	trainer EVENT_BEAT_SEVII_ROUTE_38_DIVE_CAVERN_TRAINER_8, 4, SeviiRoute38DiveCavernBattleText8, SeviiRoute38DiveCavernEndBattleText8, SeviiRoute38DiveCavernAfterBattleText8
SeviiRoute38DiveCavernTrainerHeader9:
	trainer EVENT_BEAT_SEVII_ROUTE_38_DIVE_CAVERN_TRAINER_9, 4, SeviiRoute38DiveCavernBattleText9, SeviiRoute38DiveCavernEndBattleText9, SeviiRoute38DiveCavernAfterBattleText9
SeviiRoute38DiveCavernTrainerHeader10:
	trainer EVENT_BEAT_SEVII_ROUTE_38_DIVE_CAVERN_TRAINER_10, 4, SeviiRoute38DiveCavernBattleText10, SeviiRoute38DiveCavernEndBattleText10, SeviiRoute38DiveCavernAfterBattleText10
	db -1 ; end

; ==================================

SeviiRoute38DiveCavernText1:
	text_asm
	ld hl, SeviiRoute38DiveCavernTrainerHeader1
	jr SeviiRoute38DiveCavern_TalkToTrainer

SeviiRoute38DiveCavernText2:
	text_asm
	ld hl, SeviiRoute38DiveCavernTrainerHeader2
	jr SeviiRoute38DiveCavern_TalkToTrainer

SeviiRoute38DiveCavernText3:
	text_asm
	ld hl, SeviiRoute38DiveCavernTrainerHeader3
	jr SeviiRoute38DiveCavern_TalkToTrainer

SeviiRoute38DiveCavernText4:
	text_asm
	ld hl, SeviiRoute38DiveCavernTrainerHeader4
	jr SeviiRoute38DiveCavern_TalkToTrainer

SeviiRoute38DiveCavernText5:
	text_asm
	ld hl, SeviiRoute38DiveCavernTrainerHeader5
	jr SeviiRoute38DiveCavern_TalkToTrainer

SeviiRoute38DiveCavernText6:
	text_asm
	ld hl, SeviiRoute38DiveCavernTrainerHeader6
	jr SeviiRoute38DiveCavern_TalkToTrainer

SeviiRoute38DiveCavernText7:
	text_asm
	ld hl, SeviiRoute38DiveCavernTrainerHeader7
	jr SeviiRoute38DiveCavern_TalkToTrainer

SeviiRoute38DiveCavernText8:
	text_asm
	ld hl, SeviiRoute38DiveCavernTrainerHeader8
	jr SeviiRoute38DiveCavern_TalkToTrainer

SeviiRoute38DiveCavernText9:
	text_asm
	ld hl, SeviiRoute38DiveCavernTrainerHeader9
	jr SeviiRoute38DiveCavern_TalkToTrainer

SeviiRoute38DiveCavernText10:
	text_asm
	ld hl, SeviiRoute38DiveCavernTrainerHeader10
	jr SeviiRoute38DiveCavern_TalkToTrainer

SeviiRoute38DiveCavern_TalkToTrainer:
	call TalkToTrainer
	jp TextScriptEnd

; -----

SeviiRoute38DiveCavernBattleText1:
	text_far _SeviiRoute38DiveCavernBattleText1
	text_end

SeviiRoute38DiveCavernEndBattleText1:
	text_far _SeviiRoute38DiveCavernEndBattleText1
	text_end

SeviiRoute38DiveCavernAfterBattleText1:
	text_far _SeviiRoute38DiveCavernAfterBattleText1
	text_end

; -----

SeviiRoute38DiveCavernBattleText2:
	text_far _SeviiRoute38DiveCavernBattleText2
	text_end

SeviiRoute38DiveCavernEndBattleText2:
	text_far _SeviiRoute38DiveCavernEndBattleText2
	text_end

SeviiRoute38DiveCavernAfterBattleText2:
	text_far _SeviiRoute38DiveCavernAfterBattleText2
	text_end

; -----

SeviiRoute38DiveCavernBattleText3:
	text_far _SeviiRoute38DiveCavernBattleText3
	text_end

SeviiRoute38DiveCavernEndBattleText3:
	text_far _SeviiRoute38DiveCavernEndBattleText3
	text_end

SeviiRoute38DiveCavernAfterBattleText3:
	text_far _SeviiRoute38DiveCavernAfterBattleText3
	text_end

; -----

SeviiRoute38DiveCavernBattleText4:
	text_far _SeviiRoute38DiveCavernBattleText4
	text_end

SeviiRoute38DiveCavernEndBattleText4:
	text_far _SeviiRoute38DiveCavernEndBattleText4
	text_end

SeviiRoute38DiveCavernAfterBattleText4:
	text_far _SeviiRoute38DiveCavernAfterBattleText4
	text_end

; -----

SeviiRoute38DiveCavernBattleText5:
	text_far _SeviiRoute38DiveCavernBattleText5
	text_end

SeviiRoute38DiveCavernEndBattleText5:
	text_far _SeviiRoute38DiveCavernEndBattleText5
	text_end

SeviiRoute38DiveCavernAfterBattleText5:
	text_far _SeviiRoute38DiveCavernAfterBattleText5
	text_end

; -----

SeviiRoute38DiveCavernBattleText6:
	text_far _SeviiRoute38DiveCavernBattleText6
	text_end

SeviiRoute38DiveCavernEndBattleText6:
	text_far _SeviiRoute38DiveCavernEndBattleText6
	text_end

SeviiRoute38DiveCavernAfterBattleText6:
	text_far _SeviiRoute38DiveCavernAfterBattleText6
	text_end

; -----

SeviiRoute38DiveCavernBattleText7:
	text_far _SeviiRoute38DiveCavernBattleText7
	text_end

SeviiRoute38DiveCavernEndBattleText7:
	text_far _SeviiRoute38DiveCavernEndBattleText7
	text_end

SeviiRoute38DiveCavernAfterBattleText7:
	text_far _SeviiRoute38DiveCavernAfterBattleText7
	text_end

; -----

SeviiRoute38DiveCavernBattleText8:
	text_far _SeviiRoute38DiveCavernBattleText8
	text_end

SeviiRoute38DiveCavernEndBattleText8:
	text_far _SeviiRoute38DiveCavernEndBattleText8
	text_end

SeviiRoute38DiveCavernAfterBattleText8:
	text_far _SeviiRoute38DiveCavernAfterBattleText8
	text_end

; -----

SeviiRoute38DiveCavernBattleText9:
	text_far _SeviiRoute38DiveCavernBattleText9
	text_end

SeviiRoute38DiveCavernEndBattleText9:
	text_far _SeviiRoute38DiveCavernEndBattleText9
	text_end

SeviiRoute38DiveCavernAfterBattleText9:
	text_far _SeviiRoute38DiveCavernAfterBattleText9
	text_end

; -----

SeviiRoute38DiveCavernBattleText10:
	text_far _SeviiRoute38DiveCavernBattleText10
	text_end

SeviiRoute38DiveCavernEndBattleText10:
	text_far _SeviiRoute38DiveCavernEndBattleText10
	text_end

SeviiRoute38DiveCavernAfterBattleText10:
	text_far _SeviiRoute38DiveCavernAfterBattleText10
	text_end
