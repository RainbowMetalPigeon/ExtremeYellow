Route19Dive_Script:
	call EnableAutoTextBoxDrawing
	ld hl, Route19DiveTrainerHeaders
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
	dw Route19DiveText1

Route19DiveTrainerHeaders:
	def_trainers
Route19DiveTrainerHeader0:
	trainer EVENT_BEAT_ROUTE_19_DIVE_TRAINER_0, 4, Route19DiveBattleText1, Route19DiveEndBattleText1, Route19DiveAfterBattleText1
	db -1 ; end

Route19DiveText1:
	text_asm
	ld hl, Route19DiveTrainerHeader0
;	jr Route19Dive_TalkToTrainer
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
