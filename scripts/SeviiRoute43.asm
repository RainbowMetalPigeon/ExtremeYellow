SeviiRoute43_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SeviiRoute43TrainerHeaders
	ld de, SeviiRoute43_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

SeviiRoute43_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

SeviiRoute43_TextPointers:
	dw SeviiRoute43Text1  ;  1 person
	dw SeviiRoute43Text2  ;  2 trainer
	dw SeviiRoute43Text3  ;  3 trainer
	dw SeviiRoute43Text4  ;  4 trainer
	dw SeviiRoute43Text5  ;  5 trainer
	dw SeviiRoute43Text6  ;  6 trainer
	dw SeviiRoute43Text7  ;  7 trainer
	dw SeviiRoute43Text8  ;  8 trainer
	dw SeviiRoute43Text9  ;  9 trainer
	dw SeviiRoute43Text10 ; 10 trainer
	dw SeviiRoute43Text11 ; 11 trainer
	dw RockSmashText ; 12
	dw RockSmashText ; 13
	dw PickUpItemText ; 14

SeviiRoute43Text1:
	text_far _SeviiRoute43Text1
	text_end

SeviiRoute43TrainerHeaders:
	def_trainers 2
SeviiRoute43TrainerHeader1:
	trainer EVENT_BEAT_SEVII_ROUTE_43_TRAINER_1, 4, SeviiRoute43BattleText1, SeviiRoute43EndBattleText1, SeviiRoute43AfterBattleText1
SeviiRoute43TrainerHeader2:
	trainer EVENT_BEAT_SEVII_ROUTE_43_TRAINER_2, 4, SeviiRoute43BattleText2, SeviiRoute43EndBattleText2, SeviiRoute43AfterBattleText2
SeviiRoute43TrainerHeader3:
	trainer EVENT_BEAT_SEVII_ROUTE_43_TRAINER_3, 4, SeviiRoute43BattleText3, SeviiRoute43EndBattleText3, SeviiRoute43AfterBattleText3
SeviiRoute43TrainerHeader4:
	trainer EVENT_BEAT_SEVII_ROUTE_43_TRAINER_4, 4, SeviiRoute43BattleText4, SeviiRoute43EndBattleText4, SeviiRoute43AfterBattleText4
SeviiRoute43TrainerHeader5:
	trainer EVENT_BEAT_SEVII_ROUTE_43_TRAINER_5, 4, SeviiRoute43BattleText5, SeviiRoute43EndBattleText5, SeviiRoute43AfterBattleText5
SeviiRoute43TrainerHeader6:
	trainer EVENT_BEAT_SEVII_ROUTE_43_TRAINER_6, 4, SeviiRoute43BattleText6, SeviiRoute43EndBattleText6, SeviiRoute43AfterBattleText6
SeviiRoute43TrainerHeader7:
	trainer EVENT_BEAT_SEVII_ROUTE_43_TRAINER_7, 4, SeviiRoute43BattleText7, SeviiRoute43EndBattleText7, SeviiRoute43AfterBattleText7
SeviiRoute43TrainerHeader8:
	trainer EVENT_BEAT_SEVII_ROUTE_43_TRAINER_8, 4, SeviiRoute43BattleText8, SeviiRoute43EndBattleText8, SeviiRoute43AfterBattleText8
SeviiRoute43TrainerHeader9:
	trainer EVENT_BEAT_SEVII_ROUTE_43_TRAINER_9, 4, SeviiRoute43BattleText9, SeviiRoute43EndBattleText9, SeviiRoute43AfterBattleText9
SeviiRoute43TrainerHeader10:
	trainer EVENT_BEAT_SEVII_ROUTE_43_TRAINER_10, 4, SeviiRoute43BattleText10, SeviiRoute43EndBattleText10, SeviiRoute43AfterBattleText10
	db -1 ; end

SeviiRoute43_TalkToTrainer:
	call TalkToTrainer
	jp TextScriptEnd

; ---------------------------------------

SeviiRoute43Text2:
	text_asm
	ld hl, SeviiRoute43TrainerHeader1
	jr SeviiRoute43_TalkToTrainer

SeviiRoute43BattleText1:
	text_far _SeviiRoute43BattleText1
	text_end

SeviiRoute43EndBattleText1:
	text_far _SeviiRoute43EndBattleText1
	text_end

SeviiRoute43AfterBattleText1:
	text_far _SeviiRoute43AfterBattleText1
	text_end

; ---------------------------------------

SeviiRoute43Text3:
	text_asm
	ld hl, SeviiRoute43TrainerHeader2
	jr SeviiRoute43_TalkToTrainer

SeviiRoute43BattleText2:
	text_far _SeviiRoute43BattleText2
	text_end

SeviiRoute43EndBattleText2:
	text_far _SeviiRoute43EndBattleText2
	text_end

SeviiRoute43AfterBattleText2:
	text_far _SeviiRoute43AfterBattleText2
	text_end

; ---------------------------------------

SeviiRoute43Text4:
	text_asm
	ld hl, SeviiRoute43TrainerHeader3
	jr SeviiRoute43_TalkToTrainer

SeviiRoute43BattleText3:
	text_far _SeviiRoute43BattleText3
	text_end

SeviiRoute43EndBattleText3:
	text_far _SeviiRoute43EndBattleText3
	text_end

SeviiRoute43AfterBattleText3:
	text_far _SeviiRoute43AfterBattleText3
	text_end

; ---------------------------------------

SeviiRoute43Text5:
	text_asm
	ld hl, SeviiRoute43TrainerHeader4
	jr SeviiRoute43_TalkToTrainer

SeviiRoute43BattleText4:
	text_far _SeviiRoute43BattleText4
	text_end

SeviiRoute43EndBattleText4:
	text_far _SeviiRoute43EndBattleText4
	text_end

SeviiRoute43AfterBattleText4:
	text_far _SeviiRoute43AfterBattleText4
	text_end

; ---------------------------------------

SeviiRoute43Text6:
	text_asm
	ld hl, SeviiRoute43TrainerHeader5
	jr SeviiRoute43_TalkToTrainer

SeviiRoute43BattleText5:
	text_far _SeviiRoute43BattleText5
	text_end

SeviiRoute43EndBattleText5:
	text_far _SeviiRoute43EndBattleText5
	text_end

SeviiRoute43AfterBattleText5:
	text_far _SeviiRoute43AfterBattleText5
	text_end

; ---------------------------------------

SeviiRoute43Text7:
	text_asm
	ld hl, SeviiRoute43TrainerHeader6
	jr SeviiRoute43_TalkToTrainer

SeviiRoute43BattleText6:
	text_far _SeviiRoute43BattleText6
	text_end

SeviiRoute43EndBattleText6:
	text_far _SeviiRoute43EndBattleText6
	text_end

SeviiRoute43AfterBattleText6:
	text_far _SeviiRoute43AfterBattleText6
	text_end

; ---------------------------------------

SeviiRoute43Text8:
	text_asm
	ld hl, SeviiRoute43TrainerHeader7
	jp SeviiRoute43_TalkToTrainer

SeviiRoute43BattleText7:
	text_far _SeviiRoute43BattleText7
	text_end

SeviiRoute43EndBattleText7:
	text_far _SeviiRoute43EndBattleText7
	text_end

SeviiRoute43AfterBattleText7:
	text_far _SeviiRoute43AfterBattleText7
	text_end

; ---------------------------------------

SeviiRoute43Text9:
	text_asm
	ld hl, SeviiRoute43TrainerHeader8
	jp SeviiRoute43_TalkToTrainer

SeviiRoute43BattleText8:
	text_far _SeviiRoute43BattleText8
	text_end

SeviiRoute43EndBattleText8:
	text_far _SeviiRoute43EndBattleText8
	text_end

SeviiRoute43AfterBattleText8:
	text_far _SeviiRoute43AfterBattleText8
	text_end

; ---------------------------------------

SeviiRoute43Text10:
	text_asm
	ld hl, SeviiRoute43TrainerHeader9
	jp SeviiRoute43_TalkToTrainer

SeviiRoute43BattleText9:
	text_far _SeviiRoute43BattleText9
	text_end

SeviiRoute43EndBattleText9:
	text_far _SeviiRoute43EndBattleText9
	text_end

SeviiRoute43AfterBattleText9:
	text_far _SeviiRoute43AfterBattleText9
	text_end

; ---------------------------------------

SeviiRoute43Text11:
	text_asm
	ld hl, SeviiRoute43TrainerHeader10
	jp SeviiRoute43_TalkToTrainer

SeviiRoute43BattleText10:
	text_far _SeviiRoute43BattleText10
	text_end

SeviiRoute43EndBattleText10:
	text_far _SeviiRoute43EndBattleText10
	text_end

SeviiRoute43AfterBattleText10:
	text_far _SeviiRoute43AfterBattleText10
	text_end
