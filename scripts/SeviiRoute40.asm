SeviiRoute40_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SeviiRoute40TrainerHeaders
	ld de, SeviiRoute40_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

SeviiRoute40_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

SeviiRoute40_TextPointers:
	dw SeviiRoute40Text1  ;  1 person
	dw SeviiRoute40Text2  ;  2 trainer
	dw SeviiRoute40Text3  ;  3 trainer
	dw SeviiRoute40Text4  ;  4 trainer
	dw SeviiRoute40Text5  ;  5 trainer
	dw SeviiRoute40Text6  ;  6 trainer
	dw SeviiRoute40Text7  ;  7 trainer
	dw SeviiRoute40Text8  ;  8 trainer
	dw SeviiRoute40Text9  ;  9 trainer
	dw RockSmashText ; 10
	dw PickUpItemText ; 11
	dw PickUpItemText ; 12
	dw PickUpItemText ; 13
	dw PickUpItemText ; 14

SeviiRoute40Text1:
	text_far _SeviiRoute40Text1
	text_end

SeviiRoute40TrainerHeaders:
	def_trainers 2
SeviiRoute40TrainerHeader1:
	trainer EVENT_BEAT_SEVII_ROUTE_40_TRAINER_1, 4, SeviiRoute40BattleText1, SeviiRoute40EndBattleText1, SeviiRoute40AfterBattleText1
SeviiRoute40TrainerHeader2:
	trainer EVENT_BEAT_SEVII_ROUTE_40_TRAINER_2, 4, SeviiRoute40BattleText2, SeviiRoute40EndBattleText2, SeviiRoute40AfterBattleText2
SeviiRoute40TrainerHeader3:
	trainer EVENT_BEAT_SEVII_ROUTE_40_TRAINER_3, 4, SeviiRoute40BattleText3, SeviiRoute40EndBattleText3, SeviiRoute40AfterBattleText3
SeviiRoute40TrainerHeader4:
	trainer EVENT_BEAT_SEVII_ROUTE_40_TRAINER_4, 4, SeviiRoute40BattleText4, SeviiRoute40EndBattleText4, SeviiRoute40AfterBattleText4
SeviiRoute40TrainerHeader5:
	trainer EVENT_BEAT_SEVII_ROUTE_40_TRAINER_5, 4, SeviiRoute40BattleText5, SeviiRoute40EndBattleText5, SeviiRoute40AfterBattleText5
SeviiRoute40TrainerHeader6:
	trainer EVENT_BEAT_SEVII_ROUTE_40_TRAINER_6, 4, SeviiRoute40BattleText6, SeviiRoute40EndBattleText6, SeviiRoute40AfterBattleText6
SeviiRoute40TrainerHeader7:
	trainer EVENT_BEAT_SEVII_ROUTE_40_TRAINER_7, 4, SeviiRoute40BattleText7, SeviiRoute40EndBattleText7, SeviiRoute40AfterBattleText7
SeviiRoute40TrainerHeader8:
	trainer EVENT_BEAT_SEVII_ROUTE_40_TRAINER_8, 4, SeviiRoute40BattleText8, SeviiRoute40EndBattleText8, SeviiRoute40AfterBattleText8
	db -1 ; end

SeviiRoute40_TalkToTrainer:
	call TalkToTrainer
	jp TextScriptEnd

; ---------------------------------------

SeviiRoute40Text2:
	text_asm
	ld hl, SeviiRoute40TrainerHeader1
	jr SeviiRoute40_TalkToTrainer

SeviiRoute40BattleText1:
	text_far _SeviiRoute40BattleText1
	text_end

SeviiRoute40EndBattleText1:
	text_far _SeviiRoute40EndBattleText1
	text_end

SeviiRoute40AfterBattleText1:
	text_far _SeviiRoute40AfterBattleText1
	text_end

; ---------------------------------------

SeviiRoute40Text3:
	text_asm
	ld hl, SeviiRoute40TrainerHeader2
	jr SeviiRoute40_TalkToTrainer

SeviiRoute40BattleText2:
	text_far _SeviiRoute40BattleText2
	text_end

SeviiRoute40EndBattleText2:
	text_far _SeviiRoute40EndBattleText2
	text_end

SeviiRoute40AfterBattleText2:
	text_far _SeviiRoute40AfterBattleText2
	text_end

; ---------------------------------------

SeviiRoute40Text4:
	text_asm
	ld hl, SeviiRoute40TrainerHeader3
	jr SeviiRoute40_TalkToTrainer

SeviiRoute40BattleText3:
	text_far _SeviiRoute40BattleText3
	text_end

SeviiRoute40EndBattleText3:
	text_far _SeviiRoute40EndBattleText3
	text_end

SeviiRoute40AfterBattleText3:
	text_far _SeviiRoute40AfterBattleText3
	text_end

; ---------------------------------------

SeviiRoute40Text5:
	text_asm
	ld hl, SeviiRoute40TrainerHeader4
	jr SeviiRoute40_TalkToTrainer

SeviiRoute40BattleText4:
	text_far _SeviiRoute40BattleText4
	text_end

SeviiRoute40EndBattleText4:
	text_far _SeviiRoute40EndBattleText4
	text_end

SeviiRoute40AfterBattleText4:
	text_far _SeviiRoute40AfterBattleText4
	text_end

; ---------------------------------------

SeviiRoute40Text6:
	text_asm
	ld hl, SeviiRoute40TrainerHeader5
	jr SeviiRoute40_TalkToTrainer

SeviiRoute40BattleText5:
	text_far _SeviiRoute40BattleText5
	text_end

SeviiRoute40EndBattleText5:
	text_far _SeviiRoute40EndBattleText5
	text_end

SeviiRoute40AfterBattleText5:
	text_far _SeviiRoute40AfterBattleText5
	text_end

; ---------------------------------------

SeviiRoute40Text7:
	text_asm
	ld hl, SeviiRoute40TrainerHeader6
	jr SeviiRoute40_TalkToTrainer

SeviiRoute40BattleText6:
	text_far _SeviiRoute40BattleText6
	text_end

SeviiRoute40EndBattleText6:
	text_far _SeviiRoute40EndBattleText6
	text_end

SeviiRoute40AfterBattleText6:
	text_far _SeviiRoute40AfterBattleText6
	text_end

; ---------------------------------------

SeviiRoute40Text8:
	text_asm
	ld hl, SeviiRoute40TrainerHeader7
	jp SeviiRoute40_TalkToTrainer

SeviiRoute40BattleText7:
	text_far _SeviiRoute40BattleText7
	text_end

SeviiRoute40EndBattleText7:
	text_far _SeviiRoute40EndBattleText7
	text_end

SeviiRoute40AfterBattleText7:
	text_far _SeviiRoute40AfterBattleText7
	text_end

; ---------------------------------------

SeviiRoute40Text9:
	text_asm
	ld hl, SeviiRoute40TrainerHeader8
	jp SeviiRoute40_TalkToTrainer

SeviiRoute40BattleText8:
	text_far _SeviiRoute40BattleText8
	text_end

SeviiRoute40EndBattleText8:
	text_far _SeviiRoute40EndBattleText8
	text_end

SeviiRoute40AfterBattleText8:
	text_far _SeviiRoute40AfterBattleText8
	text_end
