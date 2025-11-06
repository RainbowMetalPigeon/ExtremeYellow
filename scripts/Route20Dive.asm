Route20Dive_Script:
	call EnableAutoTextBoxDrawing
	ld hl, Route20DiveTrainerHeaders
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
	dw Route20DiveText1
	dw Route20DiveText2
	dw Route20DiveText3

Route20DiveTrainerHeaders:
	def_trainers
Route20DiveTrainerHeader0:
	trainer EVENT_BEAT_ROUTE_20_DIVE_TRAINER_0, 4, Route20DiveBattleText1, Route20DiveEndBattleText1, Route20DiveAfterBattleText1
Route20DiveTrainerHeader1:
	trainer EVENT_BEAT_ROUTE_20_DIVE_TRAINER_1, 4, Route20DiveBattleText2, Route20DiveEndBattleText2, Route20DiveAfterBattleText2
Route20DiveTrainerHeader2:
	trainer EVENT_BEAT_ROUTE_20_DIVE_TRAINER_2, 3, Route20DiveBattleText3, Route20DiveEndBattleText3, Route20DiveAfterBattleText3
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
;	jr Route20Dive_TalkToTrainer
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
