SeviiRoute33_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SeviiRoute33TrainerHeaders
	ld de, SeviiRoute33_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

SeviiRoute33_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

SeviiRoute33_TextPointers:
	dw SeviiRoute33Text1 ; 1 Biker grunt
	dw SeviiRoute33Text2 ; 2 Biker grunt
	dw SeviiRoute33Text3 ; 3 Biker grunt
	dw SeviiRoute33Text4 ; 4 Biker grunt
	dw SeviiRoute33Text5 ; 5 trainer
	dw SeviiRoute33Text6 ; 6 trainer
	dw SeviiRoute33Text7 ; 7 trainer
	dw SeviiRoute33Text8 ; 8 trainer
	dw SeviiRoute33Text9 ; 9 trainer
	dw RockSmashText ; 10
	dw RockSmashText ; 11
	dw PickUpItemText ; 12
	dw PickUpItemText ; 13
	dw PickUpItemText ; 14
	; signs
	dw SeviiRoute33SignText1 ; 15
	dw SeviiRoute33SignText2 ; 16

SeviiRoute33TrainerHeaders:
	def_trainers 5
SeviiRoute33TrainerHeader1:
	trainer EVENT_BEAT_SEVII_ROUTE_33_TRAINER_1, 2, SeviiRoute33BattleText1, SeviiRoute33EndBattleText1, SeviiRoute33AfterBattleText1
SeviiRoute33TrainerHeader2:
	trainer EVENT_BEAT_SEVII_ROUTE_33_TRAINER_2, 4, SeviiRoute33BattleText2, SeviiRoute33EndBattleText2, SeviiRoute33AfterBattleText2
SeviiRoute33TrainerHeader3:
	trainer EVENT_BEAT_SEVII_ROUTE_33_TRAINER_3, 4, SeviiRoute33BattleText3, SeviiRoute33EndBattleText3, SeviiRoute33AfterBattleText3
SeviiRoute33TrainerHeader4:
	trainer EVENT_BEAT_SEVII_ROUTE_33_TRAINER_4, 4, SeviiRoute33BattleText4, SeviiRoute33EndBattleText4, SeviiRoute33AfterBattleText4
SeviiRoute33TrainerHeader5:
	trainer EVENT_BEAT_SEVII_ROUTE_33_TRAINER_5, 4, SeviiRoute33BattleText5, SeviiRoute33EndBattleText5, SeviiRoute33AfterBattleText5
	db -1 ; end

SeviiRoute33_TalkToTrainer:
	call TalkToTrainer
	jp TextScriptEnd

; ---------------------------------------

SeviiRoute33Text5:
	text_asm
	ld hl, SeviiRoute33TrainerHeader1
	jr SeviiRoute33_TalkToTrainer

SeviiRoute33BattleText1:
	text_far _SeviiRoute33BattleText1
	text_end

SeviiRoute33EndBattleText1:
	text_far _SeviiRoute33EndBattleText1
	text_end

SeviiRoute33AfterBattleText1:
	text_far _SeviiRoute33AfterBattleText1
	text_end

; ---------------------------------------

SeviiRoute33Text6:
	text_asm
	ld hl, SeviiRoute33TrainerHeader2
	jr SeviiRoute33_TalkToTrainer

SeviiRoute33BattleText2:
	text_far _SeviiRoute33BattleText2
	text_end

SeviiRoute33EndBattleText2:
	text_far _SeviiRoute33EndBattleText2
	text_end

SeviiRoute33AfterBattleText2:
	text_far _SeviiRoute33AfterBattleText2
	text_end

; ---------------------------------------

SeviiRoute33Text7:
	text_asm
	ld hl, SeviiRoute33TrainerHeader3
	jr SeviiRoute33_TalkToTrainer

SeviiRoute33BattleText3:
	text_far _SeviiRoute33BattleText3
	text_end

SeviiRoute33EndBattleText3:
	text_far _SeviiRoute33EndBattleText3
	text_end

SeviiRoute33AfterBattleText3:
	text_far _SeviiRoute33AfterBattleText3
	text_end

; ---------------------------------------

SeviiRoute33Text8:
	text_asm
	ld hl, SeviiRoute33TrainerHeader4
	jr SeviiRoute33_TalkToTrainer

SeviiRoute33BattleText4:
	text_far _SeviiRoute33BattleText4
	text_end

SeviiRoute33EndBattleText4:
	text_far _SeviiRoute33EndBattleText4
	text_end

SeviiRoute33AfterBattleText4:
	text_far _SeviiRoute33AfterBattleText4
	text_end

; ---------------------------------------

SeviiRoute33Text9:
	text_asm
	ld hl, SeviiRoute33TrainerHeader5
	jr SeviiRoute33_TalkToTrainer

SeviiRoute33BattleText5:
	text_far _SeviiRoute33BattleText5
	text_end

SeviiRoute33EndBattleText5:
	text_far _SeviiRoute33EndBattleText5
	text_end

SeviiRoute33AfterBattleText5:
	text_far _SeviiRoute33AfterBattleText5
	text_end

; ---------------------------------------

SeviiRoute33Text1:
	text_far _SeviiRoute33Text1
	text_end
	
SeviiRoute33Text2:
SeviiRoute33Text3:
SeviiRoute33Text4:
	text_far _SeviiRoute33Text2
	text_end

; ---------------------------------------

SeviiRoute33SignText1:
	text_far _SeviiRoute33SignText1
	text_end
	
SeviiRoute33SignText2:
	text_far _SeviiRoute33SignText2
	text_end
	