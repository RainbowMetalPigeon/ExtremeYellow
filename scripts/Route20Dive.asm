Route20Dive_Script:
	call EnableAutoTextBoxDrawing
;	ld hl, Route20DiveTrainerHeaders
	ld de, Route20Dive_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

Route20Dive_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

Route20Dive_TextPointers:
	text_end
/*
	dw Route20DiveText1
	dw Route20DiveText2
	dw Route20DiveText3
	dw Route20DiveText4
	dw Route20DiveText5
	dw Route20DiveText6
	dw Route20DiveText7
	dw Route20DiveText8
	dw Route20DiveText9
	dw Route20DiveText10
	dw Route20DiveText11

Route20DiveTrainerHeaders:
	def_trainers
Route20DiveTrainerHeader0:
	trainer EVENT_BEAT_ROUTE_20_DIVE_TRAINER_0, 4, Route20DiveBattleText1, Route20DiveEndBattleText1, Route20DiveAfterBattleText1
Route20DiveTrainerHeader1:
	trainer EVENT_BEAT_ROUTE_20_DIVE_TRAINER_1, 4, Route20DiveBattleText2, Route20DiveEndBattleText2, Route20DiveAfterBattleText2
Route20DiveTrainerHeader2:
	trainer EVENT_BEAT_ROUTE_20_DIVE_TRAINER_2, 3, Route20DiveBattleText3, Route20DiveEndBattleText3, Route20DiveAfterBattleText3
Route20DiveTrainerHeader3:
	trainer EVENT_BEAT_ROUTE_20_DIVE_TRAINER_3, 4, Route20DiveBattleText4, Route20DiveEndBattleText4, Route20DiveAfterBattleText4
Route20DiveTrainerHeader4:
	trainer EVENT_BEAT_ROUTE_20_DIVE_TRAINER_4, 4, Route20DiveBattleText5, Route20DiveEndBattleText5, Route20DiveAfterBattleText5
Route20DiveTrainerHeader5:
	trainer EVENT_BEAT_ROUTE_20_DIVE_TRAINER_5, 4, Route20DiveBattleText6, Route20DiveEndBattleText6, Route20DiveAfterBattleText6
Route20DiveTrainerHeader6:
	trainer EVENT_BEAT_ROUTE_20_DIVE_TRAINER_6, 3, Route20DiveBattleText7, Route20DiveEndBattleText7, Route20DiveAfterBattleText7
Route20DiveTrainerHeader7:
	trainer EVENT_BEAT_ROUTE_20_DIVE_TRAINER_7, 4, Route20DiveBattleText8, Route20DiveEndBattleText8, Route20DiveAfterBattleText8
Route20DiveTrainerHeader8:
	trainer EVENT_BEAT_ROUTE_20_DIVE_TRAINER_8, 4, Route20DiveBattleText9, Route20DiveEndBattleText9, Route20DiveAfterBattleText9
Route20DiveTrainerHeader9:
	trainer EVENT_BEAT_ROUTE_20_DIVE_TRAINER_9, 4, Route20DiveBattleText10, Route20DiveEndBattleText10, Route20DiveAfterBattleText10
	db -1 ; end

Route20DiveText1:
	text_asm
	ld hl, Route20DiveTrainerHeader0
	jr Route20Dive_TalkToTrainer

Route20DiveText2:
	text_asm
	ld hl, Route20DiveTrainerHeader1
	jr Route20Dive_TalkToTrainer

Route20DiveText3:
	text_asm
	ld hl, Route20DiveTrainerHeader2
	jr Route20Dive_TalkToTrainer

Route20DiveText4:
	text_asm
	ld hl, Route20DiveTrainerHeader3
	jr Route20Dive_TalkToTrainer

Route20DiveText5:
	text_asm
	ld hl, Route20DiveTrainerHeader4
	jr Route20Dive_TalkToTrainer

Route20DiveText6:
	text_asm
	ld hl, Route20DiveTrainerHeader5
	jr Route20Dive_TalkToTrainer

Route20DiveText7:
	text_asm
	ld hl, Route20DiveTrainerHeader6
	jr Route20Dive_TalkToTrainer

Route20DiveText8:
	text_asm
	ld hl, Route20DiveTrainerHeader7
	jr Route20Dive_TalkToTrainer

Route20DiveText9:
	text_asm
	ld hl, Route20DiveTrainerHeader8
	jr Route20Dive_TalkToTrainer

Route20DiveText10:
	text_asm
	ld hl, Route20DiveTrainerHeader9
Route20Dive_TalkToTrainer:
	call TalkToTrainer
	jp TextScriptEnd

Route20DiveBattleText1:
	text_far _Route20DiveBattleText1
	text_end

Route20DiveEndBattleText1:
	text_far _Route20DiveEndBattleText1
	text_end

Route20DiveAfterBattleText1:
	text_far _Route20DiveAfterBattleText1
	text_end

Route20DiveBattleText2:
	text_far _Route20DiveBattleText2
	text_end

Route20DiveEndBattleText2:
	text_far _Route20DiveEndBattleText2
	text_end

Route20DiveAfterBattleText2:
	text_far _Route20DiveAfterBattleText2
	text_end

Route20DiveBattleText3:
	text_far _Route20DiveBattleText3
	text_end

Route20DiveEndBattleText3:
	text_far _Route20DiveEndBattleText3
	text_end

Route20DiveAfterBattleText3:
	text_far _Route20DiveAfterBattleText3
	text_end

Route20DiveBattleText4:
	text_far _Route20DiveBattleText4
	text_end

Route20DiveEndBattleText4:
	text_far _Route20DiveEndBattleText4
	text_end

Route20DiveAfterBattleText4:
	text_far _Route20DiveAfterBattleText4
	text_end

Route20DiveBattleText5:
	text_far _Route20DiveBattleText5
	text_end

Route20DiveEndBattleText5:
	text_far _Route20DiveEndBattleText5
	text_end

Route20DiveAfterBattleText5:
	text_far _Route20DiveAfterBattleText5
	text_end

Route20DiveBattleText6:
	text_far _Route20DiveBattleText6
	text_end

Route20DiveEndBattleText6:
	text_far _Route20DiveEndBattleText6
	text_end

Route20DiveAfterBattleText6:
	text_far _Route20DiveAfterBattleText6
	text_end

Route20DiveBattleText7:
	text_far _Route20DiveBattleText7
	text_end

Route20DiveEndBattleText7:
	text_far _Route20DiveEndBattleText7
	text_end

Route20DiveAfterBattleText7:
	text_far _Route20DiveAfterBattleText7
	text_end

Route20DiveBattleText8:
	text_far _Route20DiveBattleText8
	text_end

Route20DiveEndBattleText8:
	text_far _Route20DiveEndBattleText8
	text_end

Route20DiveAfterBattleText8:
	text_far _Route20DiveAfterBattleText8
	text_end

Route20DiveBattleText9:
	text_far _Route20DiveBattleText9
	text_end

Route20DiveEndBattleText9:
	text_far _Route20DiveEndBattleText9
	text_end

Route20DiveAfterBattleText9:
	text_asm
	ld hl, Route20DiveAfterBattleText9_Internal
	call PrintText
	ld a, HS_ROUTE_20_DIVE_DROWNING_SWIMMER
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	jp TextScriptEnd

Route20DiveAfterBattleText9_Internal:
	text_far _Route20DiveAfterBattleText9
	text_end

Route20DiveBattleText10:
	text_far _Route20DiveBattleText10
	text_end

Route20DiveEndBattleText10:
	text_far _Route20DiveEndBattleText10
	text_end

Route20DiveAfterBattleText10:
	text_far _Route20DiveAfterBattleText10
	text_end

Route20DiveText11:
	text_far _Route20DiveText11
	text_end
*/