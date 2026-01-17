SeviiRoute39_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SeviiRoute39TrainerHeaders
	ld de, SeviiRoute39_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

SeviiRoute39_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

SeviiRoute39_TextPointers:
	dw SeviiRoute39Text1
	dw SeviiRoute39Text2
	; trainers
	dw SeviiRoute39Text3
	dw SeviiRoute39Text4
	dw SeviiRoute39Text5
	dw SeviiRoute39Text6
	dw SeviiRoute39Text7
	dw SeviiRoute39Text8
	; non-persons
;	dw RockSmashText
	dw PickUpItemText ; 9
	dw PickUpItemText ; 10
	dw PickUpItemText ; 11
	dw PickUpItemText ; 12
	dw SeviiRoute39Text13 ; 13
	; signs
	dw SeviiRoute39SignText1 ; 14

SeviiRoute39Text1:
	text_far _SeviiRoute39Text1
	text_end

SeviiRoute39Text2:
	text_far _SeviiRoute39Text2
	text_end

SeviiRoute39SignText1:
	text_far _SeviiRoute39SignText1
	text_end

SeviiRoute39Text13:
	text_far _SeviiUndergroundCaveGuardText
	text_end

; ----------------------------------

SeviiRoute39TrainerHeaders:
	def_trainers 3
SeviiRoute39TrainerHeader1:
	trainer EVENT_BEAT_SEVII_ROUTE_39_TRAINER_1, 3, SeviiRoute39BattleText1, SeviiRoute39EndBattleText1, SeviiRoute39AfterBattleText1
SeviiRoute39TrainerHeader2:
	trainer EVENT_BEAT_SEVII_ROUTE_39_TRAINER_2, 1, SeviiRoute39BattleText2, SeviiRoute39EndBattleText2, SeviiRoute39AfterBattleText2
SeviiRoute39TrainerHeader3:
	trainer EVENT_BEAT_SEVII_ROUTE_39_TRAINER_3, 3, SeviiRoute39BattleText3, SeviiRoute39EndBattleText3, SeviiRoute39AfterBattleText3
SeviiRoute39TrainerHeader4:
	trainer EVENT_BEAT_SEVII_ROUTE_39_TRAINER_4, 4, SeviiRoute39BattleText4, SeviiRoute39EndBattleText4, SeviiRoute39AfterBattleText4
SeviiRoute39TrainerHeader5:
	trainer EVENT_BEAT_SEVII_ROUTE_39_TRAINER_5, 3, SeviiRoute39BattleText5, SeviiRoute39EndBattleText5, SeviiRoute39AfterBattleText5
SeviiRoute39TrainerHeader6:
	trainer EVENT_BEAT_SEVII_ROUTE_39_TRAINER_6, 4, SeviiRoute39BattleText6, SeviiRoute39EndBattleText6, SeviiRoute39AfterBattleText6
	db -1 ; end

SeviiRoute39_TalkToTrainer:
	call TalkToTrainer
	jp TextScriptEnd

; ---------------------------------------

SeviiRoute39Text3:
	text_asm
	ld hl, SeviiRoute39TrainerHeader1
	jr SeviiRoute39_TalkToTrainer

SeviiRoute39BattleText1:
	text_far _SeviiRoute39BattleText1
	text_end

SeviiRoute39EndBattleText1:
	text_far _SeviiRoute39EndBattleText1
	text_end

SeviiRoute39AfterBattleText1:
	text_far _SeviiRoute39AfterBattleText1
	text_end

; ---------------------------------------

SeviiRoute39Text4:
	text_asm
	ld hl, SeviiRoute39TrainerHeader2
	jr SeviiRoute39_TalkToTrainer

SeviiRoute39BattleText2:
	text_far _SeviiRoute39BattleText2
	text_end

SeviiRoute39EndBattleText2:
	text_far _SeviiRoute39EndBattleText2
	text_end

SeviiRoute39AfterBattleText2:
	text_far _SeviiRoute39AfterBattleText2
	text_end

; ---------------------------------------

SeviiRoute39Text5:
	text_asm
	ld hl, SeviiRoute39TrainerHeader3
	jr SeviiRoute39_TalkToTrainer

SeviiRoute39BattleText3:
	text_far _SeviiRoute39BattleText3
	text_end

SeviiRoute39EndBattleText3:
	text_far _SeviiRoute39EndBattleText3
	text_end

SeviiRoute39AfterBattleText3:
	text_far _SeviiRoute39AfterBattleText3
	text_end

; ---------------------------------------

SeviiRoute39Text6:
	text_asm
	ld hl, SeviiRoute39TrainerHeader4
	jr SeviiRoute39_TalkToTrainer

SeviiRoute39BattleText4:
	text_far _SeviiRoute39BattleText4
	text_end

SeviiRoute39EndBattleText4:
	text_far _SeviiRoute39EndBattleText4
	text_end

SeviiRoute39AfterBattleText4:
	text_far _SeviiRoute39AfterBattleText4
	text_end

; ---------------------------------------

SeviiRoute39Text7:
	text_asm
	ld hl, SeviiRoute39TrainerHeader5
	jr SeviiRoute39_TalkToTrainer

SeviiRoute39BattleText5:
	text_far _SeviiRoute39BattleText5
	text_end

SeviiRoute39EndBattleText5:
	text_far _SeviiRoute39EndBattleText5
	text_end

SeviiRoute39AfterBattleText5:
	text_far _SeviiRoute39AfterBattleText5
	text_end

; ---------------------------------------

SeviiRoute39Text8:
	text_asm
	ld hl, SeviiRoute39TrainerHeader6
	jr SeviiRoute39_TalkToTrainer

SeviiRoute39BattleText6:
	text_far _SeviiRoute39BattleText6
	text_end

SeviiRoute39EndBattleText6:
	text_far _SeviiRoute39EndBattleText6
	text_end

SeviiRoute39AfterBattleText6:
	text_far _SeviiRoute39AfterBattleText6
	text_end
