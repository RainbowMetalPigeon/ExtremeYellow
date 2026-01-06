SeviiRoute42_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SeviiRoute42TrainerHeaders
	ld de, SeviiRoute42_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

SeviiRoute42_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

SeviiRoute42_TextPointers:
	dw SeviiRoute42Text1  ;  1 person
	dw SeviiRoute42Text2  ;  2 trainer
	dw SeviiRoute42Text3  ;  3 trainer
	dw SeviiRoute42Text4  ;  4 trainer
	dw SeviiRoute42Text5  ;  5 trainer
	dw SeviiRoute42Text6  ;  6 trainer
	dw SeviiRoute42Text7  ;  7 trainer
	dw SeviiRoute42Text8  ;  8 trainer
	dw SeviiRoute42Text9  ;  9 trainer
	dw SeviiRoute42Text10 ; 10 trainer
	dw RockSmashText      ; 11 rock
	dw PickUpItemText     ; 12
	dw PickUpItemText     ; 13

SeviiRoute42Text1:
	text_far _SeviiRoute42Text1
	text_end

SeviiRoute42TrainerHeaders:
	def_trainers 2
SeviiRoute42TrainerHeader1:
	trainer EVENT_BEAT_SEVII_ROUTE_42_TRAINER_1, 4, SeviiRoute42BattleText1, SeviiRoute42EndBattleText1, SeviiRoute42AfterBattleText1
SeviiRoute42TrainerHeader2:
	trainer EVENT_BEAT_SEVII_ROUTE_42_TRAINER_2, 4, SeviiRoute42BattleText2, SeviiRoute42EndBattleText2, SeviiRoute42AfterBattleText2
SeviiRoute42TrainerHeader3:
	trainer EVENT_BEAT_SEVII_ROUTE_42_TRAINER_3, 4, SeviiRoute42BattleText3, SeviiRoute42EndBattleText3, SeviiRoute42AfterBattleText3
SeviiRoute42TrainerHeader4:
	trainer EVENT_BEAT_SEVII_ROUTE_42_TRAINER_4, 4, SeviiRoute42BattleText4, SeviiRoute42EndBattleText4, SeviiRoute42AfterBattleText4
SeviiRoute42TrainerHeader5:
	trainer EVENT_BEAT_SEVII_ROUTE_42_TRAINER_5, 4, SeviiRoute42BattleText5, SeviiRoute42EndBattleText5, SeviiRoute42AfterBattleText5
SeviiRoute42TrainerHeader6:
	trainer EVENT_BEAT_SEVII_ROUTE_42_TRAINER_6, 4, SeviiRoute42BattleText6, SeviiRoute42EndBattleText6, SeviiRoute42AfterBattleText6
SeviiRoute42TrainerHeader7:
	trainer EVENT_BEAT_SEVII_ROUTE_42_TRAINER_7, 4, SeviiRoute42BattleText7, SeviiRoute42EndBattleText7, SeviiRoute42AfterBattleText7
SeviiRoute42TrainerHeader8:
	trainer EVENT_BEAT_SEVII_ROUTE_42_TRAINER_8, 4, SeviiRoute42BattleText8, SeviiRoute42EndBattleText8, SeviiRoute42AfterBattleText8
SeviiRoute42TrainerHeader9:
	trainer EVENT_BEAT_SEVII_ROUTE_42_TRAINER_9, 4, SeviiRoute42BattleText9, SeviiRoute42EndBattleText9, SeviiRoute42AfterBattleText9
	db -1 ; end

SeviiRoute42_TalkToTrainer:
	call TalkToTrainer
	jp TextScriptEnd

; ---------------------------------------

SeviiRoute42Text2:
	text_asm
	ld hl, SeviiRoute42TrainerHeader1
	jr SeviiRoute42_TalkToTrainer

SeviiRoute42BattleText1:
	text_far _SeviiRoute42BattleText1
	text_end

SeviiRoute42EndBattleText1:
	text_far _SeviiRoute42EndBattleText1
	text_end

SeviiRoute42AfterBattleText1:
	text_far _SeviiRoute42AfterBattleText1
	text_end

; ---------------------------------------

SeviiRoute42Text3:
	text_asm
	ld hl, SeviiRoute42TrainerHeader2
	jr SeviiRoute42_TalkToTrainer

SeviiRoute42BattleText2:
	text_far _SeviiRoute42BattleText2
	text_end

SeviiRoute42EndBattleText2:
	text_far _SeviiRoute42EndBattleText2
	text_end

SeviiRoute42AfterBattleText2:
	text_far _SeviiRoute42AfterBattleText2
	text_end

; ---------------------------------------

SeviiRoute42Text4:
	text_asm
	ld hl, SeviiRoute42TrainerHeader3
	jr SeviiRoute42_TalkToTrainer

SeviiRoute42BattleText3:
	text_far _SeviiRoute42BattleText3
	text_end

SeviiRoute42EndBattleText3:
	text_far _SeviiRoute42EndBattleText3
	text_end

SeviiRoute42AfterBattleText3:
	text_far _SeviiRoute42AfterBattleText3
	text_end

; ---------------------------------------

SeviiRoute42Text5:
	text_asm
	ld hl, SeviiRoute42TrainerHeader4
	jr SeviiRoute42_TalkToTrainer

SeviiRoute42BattleText4:
	text_far _SeviiRoute42BattleText4
	text_end

SeviiRoute42EndBattleText4:
	text_far _SeviiRoute42EndBattleText4
	text_end

SeviiRoute42AfterBattleText4:
	text_far _SeviiRoute42AfterBattleText4
	text_end

; ---------------------------------------

SeviiRoute42Text6:
	text_asm
	ld hl, SeviiRoute42TrainerHeader5
	jr SeviiRoute42_TalkToTrainer

SeviiRoute42BattleText5:
	text_far _SeviiRoute42BattleText5
	text_end

SeviiRoute42EndBattleText5:
	text_far _SeviiRoute42EndBattleText5
	text_end

SeviiRoute42AfterBattleText5:
	text_far _SeviiRoute42AfterBattleText5
	text_end

; ---------------------------------------

SeviiRoute42Text7:
	text_asm
	ld hl, SeviiRoute42TrainerHeader6
	jr SeviiRoute42_TalkToTrainer

SeviiRoute42BattleText6:
	text_far _SeviiRoute42BattleText6
	text_end

SeviiRoute42EndBattleText6:
	text_far _SeviiRoute42EndBattleText6
	text_end

SeviiRoute42AfterBattleText6:
	text_far _SeviiRoute42AfterBattleText6
	text_end

; ---------------------------------------

SeviiRoute42Text8:
	text_asm
	ld hl, SeviiRoute42TrainerHeader7
	jp SeviiRoute42_TalkToTrainer

SeviiRoute42BattleText7:
	text_far _SeviiRoute42BattleText7
	text_end

SeviiRoute42EndBattleText7:
	text_far _SeviiRoute42EndBattleText7
	text_end

SeviiRoute42AfterBattleText7:
	text_far _SeviiRoute42AfterBattleText7
	text_end

; ---------------------------------------

SeviiRoute42Text9:
	text_asm
	ld hl, SeviiRoute42TrainerHeader8
	jp SeviiRoute42_TalkToTrainer

SeviiRoute42BattleText8:
	text_far _SeviiRoute42BattleText8
	text_end

SeviiRoute42EndBattleText8:
	text_far _SeviiRoute42EndBattleText8
	text_end

SeviiRoute42AfterBattleText8:
	text_far _SeviiRoute42AfterBattleText8
	text_end

; ---------------------------------------

SeviiRoute42Text10:
	text_asm
	ld hl, SeviiRoute42TrainerHeader9
	jp SeviiRoute42_TalkToTrainer

SeviiRoute42BattleText9:
	text_far _SeviiRoute42BattleText9
	text_end

SeviiRoute42EndBattleText9:
	text_far _SeviiRoute42EndBattleText9
	text_end

SeviiRoute42AfterBattleText9:
	text_far _SeviiRoute42AfterBattleText9
	text_end
