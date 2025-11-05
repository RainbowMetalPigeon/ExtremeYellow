Route19Dive_Script:
	call EnableAutoTextBoxDrawing
;	ld hl, Route19DiveTrainerHeaders
	ld de, Route19Dive_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

Route19Dive_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

Route19Dive_TextPointers:
	text_end
/*
	dw Route19DiveText1
	dw Route19DiveText2
	dw Route19DiveText3
	dw Route19DiveText4
	dw Route19DiveText5
	dw Route19DiveText6
	dw Route19DiveText7
	dw Route19DiveText8
	dw Route19DiveText9
	dw Route19DiveText10
	dw Route19DiveText11

Route19DiveTrainerHeaders:
	def_trainers
Route19DiveTrainerHeader0:
	trainer EVENT_BEAT_ROUTE_19_DIVE_TRAINER_0, 4, Route19DiveBattleText1, Route19DiveEndBattleText1, Route19DiveAfterBattleText1
Route19DiveTrainerHeader1:
	trainer EVENT_BEAT_ROUTE_19_DIVE_TRAINER_1, 4, Route19DiveBattleText2, Route19DiveEndBattleText2, Route19DiveAfterBattleText2
Route19DiveTrainerHeader2:
	trainer EVENT_BEAT_ROUTE_19_DIVE_TRAINER_2, 3, Route19DiveBattleText3, Route19DiveEndBattleText3, Route19DiveAfterBattleText3
Route19DiveTrainerHeader3:
	trainer EVENT_BEAT_ROUTE_19_DIVE_TRAINER_3, 4, Route19DiveBattleText4, Route19DiveEndBattleText4, Route19DiveAfterBattleText4
Route19DiveTrainerHeader4:
	trainer EVENT_BEAT_ROUTE_19_DIVE_TRAINER_4, 4, Route19DiveBattleText5, Route19DiveEndBattleText5, Route19DiveAfterBattleText5
Route19DiveTrainerHeader5:
	trainer EVENT_BEAT_ROUTE_19_DIVE_TRAINER_5, 4, Route19DiveBattleText6, Route19DiveEndBattleText6, Route19DiveAfterBattleText6
Route19DiveTrainerHeader6:
	trainer EVENT_BEAT_ROUTE_19_DIVE_TRAINER_6, 3, Route19DiveBattleText7, Route19DiveEndBattleText7, Route19DiveAfterBattleText7
Route19DiveTrainerHeader7:
	trainer EVENT_BEAT_ROUTE_19_DIVE_TRAINER_7, 4, Route19DiveBattleText8, Route19DiveEndBattleText8, Route19DiveAfterBattleText8
Route19DiveTrainerHeader8:
	trainer EVENT_BEAT_ROUTE_19_DIVE_TRAINER_8, 4, Route19DiveBattleText9, Route19DiveEndBattleText9, Route19DiveAfterBattleText9
Route19DiveTrainerHeader9:
	trainer EVENT_BEAT_ROUTE_19_DIVE_TRAINER_9, 4, Route19DiveBattleText10, Route19DiveEndBattleText10, Route19DiveAfterBattleText10
	db -1 ; end

Route19DiveText1:
	text_asm
	ld hl, Route19DiveTrainerHeader0
	jr Route19Dive_TalkToTrainer

Route19DiveText2:
	text_asm
	ld hl, Route19DiveTrainerHeader1
	jr Route19Dive_TalkToTrainer

Route19DiveText3:
	text_asm
	ld hl, Route19DiveTrainerHeader2
	jr Route19Dive_TalkToTrainer

Route19DiveText4:
	text_asm
	ld hl, Route19DiveTrainerHeader3
	jr Route19Dive_TalkToTrainer

Route19DiveText5:
	text_asm
	ld hl, Route19DiveTrainerHeader4
	jr Route19Dive_TalkToTrainer

Route19DiveText6:
	text_asm
	ld hl, Route19DiveTrainerHeader5
	jr Route19Dive_TalkToTrainer

Route19DiveText7:
	text_asm
	ld hl, Route19DiveTrainerHeader6
	jr Route19Dive_TalkToTrainer

Route19DiveText8:
	text_asm
	ld hl, Route19DiveTrainerHeader7
	jr Route19Dive_TalkToTrainer

Route19DiveText9:
	text_asm
	ld hl, Route19DiveTrainerHeader8
	jr Route19Dive_TalkToTrainer

Route19DiveText10:
	text_asm
	ld hl, Route19DiveTrainerHeader9
Route19Dive_TalkToTrainer:
	call TalkToTrainer
	jp TextScriptEnd

Route19DiveBattleText1:
	text_far _Route19DiveBattleText1
	text_end

Route19DiveEndBattleText1:
	text_far _Route19DiveEndBattleText1
	text_end

Route19DiveAfterBattleText1:
	text_far _Route19DiveAfterBattleText1
	text_end

Route19DiveBattleText2:
	text_far _Route19DiveBattleText2
	text_end

Route19DiveEndBattleText2:
	text_far _Route19DiveEndBattleText2
	text_end

Route19DiveAfterBattleText2:
	text_far _Route19DiveAfterBattleText2
	text_end

Route19DiveBattleText3:
	text_far _Route19DiveBattleText3
	text_end

Route19DiveEndBattleText3:
	text_far _Route19DiveEndBattleText3
	text_end

Route19DiveAfterBattleText3:
	text_far _Route19DiveAfterBattleText3
	text_end

Route19DiveBattleText4:
	text_far _Route19DiveBattleText4
	text_end

Route19DiveEndBattleText4:
	text_far _Route19DiveEndBattleText4
	text_end

Route19DiveAfterBattleText4:
	text_far _Route19DiveAfterBattleText4
	text_end

Route19DiveBattleText5:
	text_far _Route19DiveBattleText5
	text_end

Route19DiveEndBattleText5:
	text_far _Route19DiveEndBattleText5
	text_end

Route19DiveAfterBattleText5:
	text_far _Route19DiveAfterBattleText5
	text_end

Route19DiveBattleText6:
	text_far _Route19DiveBattleText6
	text_end

Route19DiveEndBattleText6:
	text_far _Route19DiveEndBattleText6
	text_end

Route19DiveAfterBattleText6:
	text_far _Route19DiveAfterBattleText6
	text_end

Route19DiveBattleText7:
	text_far _Route19DiveBattleText7
	text_end

Route19DiveEndBattleText7:
	text_far _Route19DiveEndBattleText7
	text_end

Route19DiveAfterBattleText7:
	text_far _Route19DiveAfterBattleText7
	text_end

Route19DiveBattleText8:
	text_far _Route19DiveBattleText8
	text_end

Route19DiveEndBattleText8:
	text_far _Route19DiveEndBattleText8
	text_end

Route19DiveAfterBattleText8:
	text_far _Route19DiveAfterBattleText8
	text_end

Route19DiveBattleText9:
	text_far _Route19DiveBattleText9
	text_end

Route19DiveEndBattleText9:
	text_far _Route19DiveEndBattleText9
	text_end

Route19DiveAfterBattleText9:
	text_asm
	ld hl, Route19DiveAfterBattleText9_Internal
	call PrintText
	ld a, HS_ROUTE_19_DIVE_DROWNING_SWIMMER
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	jp TextScriptEnd

Route19DiveAfterBattleText9_Internal:
	text_far _Route19DiveAfterBattleText9
	text_end

Route19DiveBattleText10:
	text_far _Route19DiveBattleText10
	text_end

Route19DiveEndBattleText10:
	text_far _Route19DiveEndBattleText10
	text_end

Route19DiveAfterBattleText10:
	text_far _Route19DiveAfterBattleText10
	text_end

Route19DiveText11:
	text_far _Route19DiveText11
	text_end

*/