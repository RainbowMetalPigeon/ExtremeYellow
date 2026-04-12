Route21Dive_Script:
	call EnableAutoTextBoxDrawing
	ld hl, Route21DiveTrainerHeaders
	ld de, Route21Dive_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

Route21Dive_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

Route21Dive_TextPointers:
	dw Route21DiveText1 ; non-trainer
	dw Route21DiveText2
	dw Route21DiveText3
	dw Route21DiveText4
	dw Route21DiveText5
	dw Route21DiveText6
	dw Route21DiveText7 ; 6x MAGIKARP
	dw Route21DiveText8 ; Cooltrainer

Route21DiveTrainerHeaders:
	def_trainers 2
Route21DiveTrainerHeader0:
	trainer EVENT_BEAT_ROUTE_21_DIVE_TRAINER_0, 4, Route21DiveBattleText1, Route21DiveEndBattleText1, Route21DiveAfterBattleText1
Route21DiveTrainerHeader1:
	trainer EVENT_BEAT_ROUTE_21_DIVE_TRAINER_1, 4, Route21DiveBattleText2, Route21DiveEndBattleText2, Route21DiveAfterBattleText2
Route21DiveTrainerHeader2:
	trainer EVENT_BEAT_ROUTE_21_DIVE_TRAINER_2, 4, Route21DiveBattleText3, Route21DiveEndBattleText3, Route21DiveAfterBattleText3
Route21DiveTrainerHeader3:
	trainer EVENT_BEAT_ROUTE_21_DIVE_TRAINER_3, 4, Route21DiveBattleText4, Route21DiveEndBattleText4, Route21DiveAfterBattleText4
Route21DiveTrainerHeader4:
	trainer EVENT_BEAT_ROUTE_21_DIVE_TRAINER_4, 4, Route21DiveBattleText5, Route21DiveEndBattleText5, Route21DiveAfterBattleText5
Route21DiveTrainerHeader5:
	trainer EVENT_BEAT_ROUTE_21_DIVE_TRAINER_5, 4, Route21DiveBattleText6, Route21DiveEndBattleText6, Route21DiveAfterBattleText6
Route21DiveTrainerHeader6:
	trainer EVENT_BEAT_ROUTE_21_DIVE_TRAINER_6, 3, Route21DiveBattleText7, Route21DiveEndBattleText7, Route21DiveAfterBattleText7
	db -1 ; end

Route21DiveText1:
	text_far _Route21DiveText1
	text_end

Route21DiveText2:
	text_asm
	ld hl, Route21DiveTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

Route21DiveText3:
	text_asm
	ld hl, Route21DiveTrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

Route21DiveText4:
	text_asm
	ld hl, Route21DiveTrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

Route21DiveText5:
	text_asm
	ld hl, Route21DiveTrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

Route21DiveText6:
	text_asm
	ld hl, Route21DiveTrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

Route21DiveText7:
	text_asm
	ld hl, Route21DiveTrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

Route21DiveText8:
	text_asm
	ld hl, Route21DiveTrainerHeader6
	call TalkToTrainer
	jp TextScriptEnd

Route21DiveBattleText1:
	text_far _Route21DiveBattleText1
	text_end

Route21DiveEndBattleText1:
	text_far _Route21DiveEndBattleText1
	text_end

Route21DiveAfterBattleText1:
	text_far _Route21DiveAfterBattleText1
	text_end

Route21DiveBattleText2:
	text_far _Route21DiveBattleText2
	text_end

Route21DiveEndBattleText2:
	text_far _Route21DiveEndBattleText2
	text_end

Route21DiveAfterBattleText2:
	text_far _Route21DiveAfterBattleText2
	text_end

Route21DiveBattleText3:
	text_far _Route21DiveBattleText3
	text_end

Route21DiveEndBattleText3:
	text_far _Route21DiveEndBattleText3
	text_end

Route21DiveAfterBattleText3:
	text_far _Route21DiveAfterBattleText3
	text_end

Route21DiveBattleText4:
	text_far _Route21DiveBattleText4
	text_end

Route21DiveEndBattleText4:
	text_far _Route21DiveEndBattleText4
	text_end

Route21DiveAfterBattleText4:
	text_far _Route21DiveAfterBattleText4
	text_end

Route21DiveBattleText5:
	text_far _Route21DiveBattleText5
	text_end

Route21DiveEndBattleText5:
	text_far _Route21DiveEndBattleText5
	text_end

Route21DiveAfterBattleText5:
	text_far _Route21DiveAfterBattleText5
	text_end

Route21DiveBattleText6:
	text_far _Route21DiveBattleText6
	text_end

Route21DiveEndBattleText6:
	text_far _Route21DiveEndBattleText6
	text_end

Route21DiveAfterBattleText6:
	text_far _Route21DiveAfterBattleText6
	text_end

Route21DiveBattleText7:
	text_far _Route21DiveBattleText7
	text_end

Route21DiveEndBattleText7:
	text_far _Route21DiveEndBattleText7
	text_end

Route21DiveAfterBattleText7:
	text_far _Route21DiveAfterBattleText7
	text_end
