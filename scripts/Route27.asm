Route27_Script:
	call EnableAutoTextBoxDrawing
	ld hl, Route27TrainerHeaders
	ld de, Route27_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

Route27_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

Route27_TextPointers:
	dw Route27Text1
	dw Route27Text2
	dw Route27Text3
	dw Route27Text4
	dw Route27Text5
	dw Route27Text6

Route27TrainerHeaders:
	def_trainers 4
Route27TrainerHeader0:
	trainer EVENT_BEAT_ROUTE_27_TRAINER_0, 0, Route27BattleText0, Route27EndBattleText0, Route27AfterBattleText0
Route27TrainerHeader1:
	trainer EVENT_BEAT_ROUTE_27_TRAINER_1, 0, Route27BattleText1, Route27EndBattleText1, Route27AfterBattleText1
Route27TrainerHeader2:
	trainer EVENT_BEAT_ROUTE_27_TRAINER_2, 0, Route27BattleText2, Route27EndBattleText2, Route27AfterBattleText2
	db -1

Route27Text1:
	text_far _Route27Text1
	text_end
	
Route27Text2:
	text_far _Route27Text2
	text_end
	
Route27Text3:
	text_far _Route27Text3
	text_end
	
; Trainers -----------------------------

Route27Text4:
	text_asm
	ld hl, Route27TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

Route27BattleText0:
	text_far _Route27BattleText0
	text_end

Route27EndBattleText0:
	text_far _Route27EndBattleText0
	text_end

Route27AfterBattleText0:
	text_far _Route27AfterBattleText0
	text_end

Route27Text5:
	text_asm
	ld hl, Route27TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

Route27BattleText1:
	text_far _Route27BattleText1
	text_end

Route27EndBattleText1:
	text_far _Route27EndBattleText1
	text_end

Route27AfterBattleText1:
	text_far _Route27AfterBattleText1
	text_end

Route27Text6:
	text_asm
	ld hl, Route27TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

Route27BattleText2:
	text_far _Route27BattleText2
	text_end

Route27EndBattleText2:
	text_far _Route27EndBattleText2
	text_end

Route27AfterBattleText2:
	text_far _Route27AfterBattleText2
	text_end
	