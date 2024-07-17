Route28_Script:
	call EnableAutoTextBoxDrawing
	ld hl, Route28TrainerHeaders
	ld de, Route28_ScriptPointers
	ld a, [wRoute28CurScript]
	call ExecuteCurMapScriptInTable
	ld [wRoute28CurScript], a
	ret

Route28_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

Route28_TextPointers:
	dw Route28Text1
	dw Route28Text2
	dw Route28Text3
	dw Route28Text4
	dw Route28Text5
	dw Route28Text6
	dw Route28Text7
	dw Route28Text8

Route28TrainerHeaders:
	def_trainers 6
Route28TrainerHeader0:
	trainer EVENT_BEAT_ROUTE_28_TRAINER_0, 0, Route28BattleText0, Route28EndBattleText0, Route28AfterBattleText0
Route28TrainerHeader1:
	trainer EVENT_BEAT_ROUTE_28_TRAINER_1, 0, Route28BattleText1, Route28EndBattleText1, Route28AfterBattleText1
Route28TrainerHeader2:
	trainer EVENT_BEAT_ROUTE_28_TRAINER_2, 0, Route28BattleText2, Route28EndBattleText2, Route28AfterBattleText2
	db -1

Route28Text1:
	text_far _Route28Text1
	text_end
	
Route28Text2:
	text_far _Route28Text2
	text_end
	
Route28Text3:
	text_far _Route28Text3
	text_end
	
Route28Text4:
	text_far _Route28Text4
	text_end
	
Route28Text5:
	text_far _Route28Text5
	text_end

; Trainers -----------------------------

Route28Text6:
	text_asm
	ld hl, Route28TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

Route28BattleText0:
	text_far _Route28BattleText0
	text_end

Route28EndBattleText0:
	text_far _Route28EndBattleText0
	text_end

Route28AfterBattleText0:
	text_far _Route28AfterBattleText0
	text_end

Route28Text7:
	text_asm
	ld hl, Route28TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

Route28BattleText1:
	text_far _Route28BattleText1
	text_end

Route28EndBattleText1:
	text_far _Route28EndBattleText1
	text_end

Route28AfterBattleText1:
	text_far _Route28AfterBattleText1
	text_end

Route28Text8:
	text_asm
	ld hl, Route28TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

Route28BattleText2:
	text_far _Route28BattleText2
	text_end

Route28EndBattleText2:
	text_far _Route28EndBattleText2
	text_end

Route28AfterBattleText2:
	text_far _Route28AfterBattleText2
	text_end
	