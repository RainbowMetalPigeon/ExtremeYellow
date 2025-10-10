SeviiRoute31_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SeviiRoute31TrainerHeaders
	ld de, SeviiRoute31_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

SeviiRoute31_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

SeviiRoute31_TextPointers:
	dw SeviiRoute31Text1  ;  1 person
	dw SeviiRoute31Text2  ;  2 trainer
	dw SeviiRoute31Text3  ;  3 trainer
	dw SeviiRoute31Text4  ;  4 trainer
	dw SeviiRoute31Text5  ;  5 trainer
	dw SeviiRoute31Text6  ;  6 trainer
	dw SeviiRoute31Text7  ;  7 trainer
	dw SeviiRoute31Text8  ;  8 trainer
	dw SeviiRoute31Text9  ;  9 trainer
	dw SeviiRoute31Text10 ; 10 trainer
	dw SeviiRoute31Text11 ; 11 trainer
	dw RockSmashText ; 12
	dw PickUpItemText ; 13
	dw PickUpItemText ; 14
	; signs
	dw SeviiRoute31SignText1 ; 15
	; scripts

SeviiRoute31TrainerHeaders:
	def_trainers 2
SeviiRoute31TrainerHeader1:
	trainer EVENT_BEAT_SEVII_ROUTE_31_TRAINER_1, 4, SeviiRoute31BattleText1, SeviiRoute31EndBattleText1, SeviiRoute31AfterBattleText1
SeviiRoute31TrainerHeader2:
	trainer EVENT_BEAT_SEVII_ROUTE_31_TRAINER_2, 3, SeviiRoute31BattleText2, SeviiRoute31EndBattleText2, SeviiRoute31AfterBattleText2
SeviiRoute31TrainerHeader3:
	trainer EVENT_BEAT_SEVII_ROUTE_31_TRAINER_3, 4, SeviiRoute31BattleText3, SeviiRoute31EndBattleText3, SeviiRoute31AfterBattleText3
SeviiRoute31TrainerHeader4:
	trainer EVENT_BEAT_SEVII_ROUTE_31_TRAINER_4, 4, SeviiRoute31BattleText4, SeviiRoute31EndBattleText4, SeviiRoute31AfterBattleText4
SeviiRoute31TrainerHeader5:
	trainer EVENT_BEAT_SEVII_ROUTE_31_TRAINER_5, 4, SeviiRoute31BattleText5, SeviiRoute31EndBattleText5, SeviiRoute31AfterBattleText5
SeviiRoute31TrainerHeader6:
	trainer EVENT_BEAT_SEVII_ROUTE_31_TRAINER_6, 4, SeviiRoute31BattleText6, SeviiRoute31EndBattleText6, SeviiRoute31AfterBattleText6
SeviiRoute31TrainerHeader7:
	trainer EVENT_BEAT_SEVII_ROUTE_31_TRAINER_7, 4, SeviiRoute31BattleText7, SeviiRoute31EndBattleText7, SeviiRoute31AfterBattleText7
SeviiRoute31TrainerHeader8:
	trainer EVENT_BEAT_SEVII_ROUTE_31_TRAINER_8, 4, SeviiRoute31BattleText8, SeviiRoute31EndBattleText8, SeviiRoute31AfterBattleText8
SeviiRoute31TrainerHeader9:
	trainer EVENT_BEAT_SEVII_ROUTE_31_TRAINER_9, 4, SeviiRoute31BattleText9, SeviiRoute31EndBattleText9, SeviiRoute31AfterBattleText9
SeviiRoute31TrainerHeader10:
	trainer EVENT_BEAT_SEVII_ROUTE_31_TRAINER_10, 4, SeviiRoute31BattleText10, SeviiRoute31EndBattleText10, SeviiRoute31AfterBattleText10
	db -1 ; end

SeviiRoute31_TalkToTrainer:
	call TalkToTrainer
	jp TextScriptEnd

; ---------------------------------------

SeviiRoute31Text2:
	text_asm
	ld hl, SeviiRoute31TrainerHeader1
	jr SeviiRoute31_TalkToTrainer

SeviiRoute31BattleText1:
	text_far _SeviiRoute31BattleText1
	text_end

SeviiRoute31EndBattleText1:
	text_far _SeviiRoute31EndBattleText1
	text_end

SeviiRoute31AfterBattleText1:
	text_far _SeviiRoute31AfterBattleText1
	text_end

; ---------------------------------------

SeviiRoute31Text3:
	text_asm
	ld hl, SeviiRoute31TrainerHeader2
	jr SeviiRoute31_TalkToTrainer

SeviiRoute31BattleText2:
	text_far _SeviiRoute31BattleText2
	text_end

SeviiRoute31EndBattleText2:
	text_far _SeviiRoute31EndBattleText2
	text_end

SeviiRoute31AfterBattleText2:
	text_far _SeviiRoute31AfterBattleText2
	text_end

; ---------------------------------------

SeviiRoute31Text4:
	text_asm
	ld hl, SeviiRoute31TrainerHeader3
	jr SeviiRoute31_TalkToTrainer

SeviiRoute31BattleText3:
	text_far _SeviiRoute31BattleText3
	text_end

SeviiRoute31EndBattleText3:
	text_far _SeviiRoute31EndBattleText3
	text_end

SeviiRoute31AfterBattleText3:
	text_far _SeviiRoute31AfterBattleText3
	text_end

; ---------------------------------------

SeviiRoute31Text5:
	text_asm
	ld hl, SeviiRoute31TrainerHeader4
	jr SeviiRoute31_TalkToTrainer

SeviiRoute31BattleText4:
	text_far _SeviiRoute31BattleText4
	text_end

SeviiRoute31EndBattleText4:
	text_far _SeviiRoute31EndBattleText4
	text_end

SeviiRoute31AfterBattleText4:
	text_far _SeviiRoute31AfterBattleText4
	text_end

; ---------------------------------------

SeviiRoute31Text6:
	text_asm
	ld hl, SeviiRoute31TrainerHeader5
	jr SeviiRoute31_TalkToTrainer

SeviiRoute31BattleText5:
	text_far _SeviiRoute31BattleText5
	text_end

SeviiRoute31EndBattleText5:
	text_far _SeviiRoute31EndBattleText5
	text_end

SeviiRoute31AfterBattleText5:
	text_far _SeviiRoute31AfterBattleText5
	text_end

; ---------------------------------------

SeviiRoute31Text7:
	text_asm
	ld hl, SeviiRoute31TrainerHeader6
	jr SeviiRoute31_TalkToTrainer

SeviiRoute31BattleText6:
	text_far _SeviiRoute31BattleText6
	text_end

SeviiRoute31EndBattleText6:
	text_far _SeviiRoute31EndBattleText6
	text_end

SeviiRoute31AfterBattleText6:
	text_far _SeviiRoute31AfterBattleText6
	text_end

; ---------------------------------------

SeviiRoute31Text8:
	text_asm
	ld hl, SeviiRoute31TrainerHeader7
	jp SeviiRoute31_TalkToTrainer

SeviiRoute31BattleText7:
	text_far _SeviiRoute31BattleText7
	text_end

SeviiRoute31EndBattleText7:
	text_far _SeviiRoute31EndBattleText7
	text_end

SeviiRoute31AfterBattleText7:
	text_far _SeviiRoute31AfterBattleText7
	text_end

; ---------------------------------------

SeviiRoute31Text9:
	text_asm
	ld hl, SeviiRoute31TrainerHeader8
	jp SeviiRoute31_TalkToTrainer

SeviiRoute31BattleText8:
	text_far _SeviiRoute31BattleText8
	text_end

SeviiRoute31EndBattleText8:
	text_far _SeviiRoute31EndBattleText8
	text_end

SeviiRoute31AfterBattleText8:
	text_far _SeviiRoute31AfterBattleText8
	text_end

; ---------------------------------------

SeviiRoute31Text10:
	text_asm
	ld hl, SeviiRoute31TrainerHeader9
	jp SeviiRoute31_TalkToTrainer

SeviiRoute31BattleText9:
	text_far _SeviiRoute31BattleText9
	text_end

SeviiRoute31EndBattleText9:
	text_far _SeviiRoute31EndBattleText9
	text_end

SeviiRoute31AfterBattleText9:
	text_far _SeviiRoute31AfterBattleText9
	text_end

; ---------------------------------------

SeviiRoute31Text11:
	text_asm
	ld hl, SeviiRoute31TrainerHeader10
	jp SeviiRoute31_TalkToTrainer

SeviiRoute31BattleText10:
	text_far _SeviiRoute31BattleText10
	text_end

SeviiRoute31EndBattleText10:
	text_far _SeviiRoute31EndBattleText10
	text_end

SeviiRoute31AfterBattleText10:
	text_far _SeviiRoute31AfterBattleText10
	text_end

; ==============================================

SeviiRoute31Text1:
	text_far _SeviiRoute31Text1
	text_end
	
; ---------------------------------------

SeviiRoute31SignText1:
	text_far _SeviiRoute31SignText1
	text_end
	