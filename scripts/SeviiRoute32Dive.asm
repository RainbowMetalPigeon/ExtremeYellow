SeviiRoute32Dive_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SeviiRoute32DiveTrainerHeaders
	ld de, SeviiRoute32Dive_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

SeviiRoute32Dive_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

SeviiRoute32Dive_TextPointers:
	dw SeviiRoute32DiveText1
	dw SeviiRoute32DiveText2
	dw SeviiRoute32DiveText3
;	dw PickUpItemText

SeviiRoute32DiveTrainerHeaders:
	def_trainers
SeviiRoute32DiveTrainerHeader1:
	trainer EVENT_BEAT_SEVII_ROUTE_32_DIVE_TRAINER_1, 4, SeviiRoute32DiveBattleText1, SeviiRoute32DiveEndBattleText1, SeviiRoute32DiveAfterBattleText1
SeviiRoute32DiveTrainerHeader2:
	trainer EVENT_BEAT_SEVII_ROUTE_32_DIVE_TRAINER_2, 4, SeviiRoute32DiveBattleText2, SeviiRoute32DiveEndBattleText2, SeviiRoute32DiveAfterBattleText2
SeviiRoute32DiveTrainerHeader3:
	trainer EVENT_BEAT_SEVII_ROUTE_32_DIVE_TRAINER_3, 4, SeviiRoute32DiveBattleText3, SeviiRoute32DiveEndBattleText3, SeviiRoute32DiveAfterBattleText3
	db -1 ; end

SeviiRoute32DiveText1:
	text_asm
	ld hl, SeviiRoute32DiveTrainerHeader1
	jr SeviiRoute32Dive_TalkToTrainer

SeviiRoute32DiveText2:
	text_asm
	ld hl, SeviiRoute32DiveTrainerHeader2
	jr SeviiRoute32Dive_TalkToTrainer

SeviiRoute32DiveText3:
	text_asm
	ld hl, SeviiRoute32DiveTrainerHeader3
	jr SeviiRoute32Dive_TalkToTrainer

SeviiRoute32Dive_TalkToTrainer:
	call TalkToTrainer
	jp TextScriptEnd

; ---

SeviiRoute32DiveBattleText1:
	text_far _SeviiRoute32DiveBattleText1
	text_end

SeviiRoute32DiveEndBattleText1:
	text_far _SeviiRoute32DiveEndBattleText1
	text_end

SeviiRoute32DiveAfterBattleText1:
	text_far _SeviiRoute32DiveAfterBattleText1
	text_end

; ---

SeviiRoute32DiveBattleText2:
	text_far _SeviiRoute32DiveBattleText2
	text_end

SeviiRoute32DiveEndBattleText2:
	text_far _SeviiRoute32DiveEndBattleText2
	text_end

SeviiRoute32DiveAfterBattleText2:
	text_far _SeviiRoute32DiveAfterBattleText2
	text_end

; ---

SeviiRoute32DiveBattleText3:
	text_far _SeviiRoute32DiveBattleText3
	text_end

SeviiRoute32DiveEndBattleText3:
	text_far _SeviiRoute32DiveEndBattleText3
	text_end

SeviiRoute32DiveAfterBattleText3:
	text_far _SeviiRoute32DiveAfterBattleText3
	text_end
