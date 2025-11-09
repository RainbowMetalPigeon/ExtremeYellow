SeviiRoute33Dive_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SeviiRoute33DiveTrainerHeaders
	ld de, SeviiRoute33Dive_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

SeviiRoute33Dive_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

SeviiRoute33Dive_TextPointers:
	dw SeviiRoute33DiveText0
	dw SeviiRoute33DiveText1
	dw SeviiRoute33DiveText2
	dw SeviiRoute33DiveText3
	dw SeviiRoute33DiveText4
	dw PickUpItemText
	dw PickUpItemText

SeviiRoute33DiveTrainerHeaders:
	def_trainers 2
SeviiRoute33DiveTrainerHeader1:
	trainer EVENT_BEAT_SEVII_ROUTE_33_DIVE_TRAINER_1, 4, SeviiRoute33DiveBattleText1, SeviiRoute33DiveEndBattleText1, SeviiRoute33DiveAfterBattleText1
SeviiRoute33DiveTrainerHeader2:
	trainer EVENT_BEAT_SEVII_ROUTE_33_DIVE_TRAINER_2, 4, SeviiRoute33DiveBattleText2, SeviiRoute33DiveEndBattleText2, SeviiRoute33DiveAfterBattleText2
SeviiRoute33DiveTrainerHeader3:
	trainer EVENT_BEAT_SEVII_ROUTE_33_DIVE_TRAINER_3, 4, SeviiRoute33DiveBattleText3, SeviiRoute33DiveEndBattleText3, SeviiRoute33DiveAfterBattleText3
SeviiRoute33DiveTrainerHeader4:
	trainer EVENT_BEAT_SEVII_ROUTE_33_DIVE_TRAINER_4, 4, SeviiRoute33DiveBattleText4, SeviiRoute33DiveEndBattleText4, SeviiRoute33DiveAfterBattleText4
	db -1 ; end

SeviiRoute33DiveText0:
	text_asm
	ld hl, SeviiRoute33DiveText0_Internal
	call PrintText
	ld a, HS_SEVII_ROUTE_33_VERBOSE_DIVER
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	jp TextScriptEnd

SeviiRoute33DiveText0_Internal:
	text_far _SeviiRoute33DiveText0
	text_end

SeviiRoute33DiveText1:
	text_asm
	ld hl, SeviiRoute33DiveTrainerHeader1
	jr SeviiRoute33Dive_TalkToTrainer

SeviiRoute33DiveText2:
	text_asm
	ld hl, SeviiRoute33DiveTrainerHeader2
	jr SeviiRoute33Dive_TalkToTrainer

SeviiRoute33DiveText3:
	text_asm
	ld hl, SeviiRoute33DiveTrainerHeader3
	jr SeviiRoute33Dive_TalkToTrainer

SeviiRoute33DiveText4:
	text_asm
	ld hl, SeviiRoute33DiveTrainerHeader4
	jr SeviiRoute33Dive_TalkToTrainer

SeviiRoute33Dive_TalkToTrainer:
	call TalkToTrainer
	jp TextScriptEnd

; ---

SeviiRoute33DiveBattleText1:
	text_far _SeviiRoute33DiveBattleText1
	text_end

SeviiRoute33DiveEndBattleText1:
	text_far _SeviiRoute33DiveEndBattleText1
	text_end

SeviiRoute33DiveAfterBattleText1:
	text_far _SeviiRoute33DiveAfterBattleText1
	text_end

; ---

SeviiRoute33DiveBattleText2:
	text_far _SeviiRoute33DiveBattleText2
	text_end

SeviiRoute33DiveEndBattleText2:
	text_far _SeviiRoute33DiveEndBattleText2
	text_end

SeviiRoute33DiveAfterBattleText2:
	text_far _SeviiRoute33DiveAfterBattleText2
	text_end

; ---

SeviiRoute33DiveBattleText3:
	text_far _SeviiRoute33DiveBattleText3
	text_end

SeviiRoute33DiveEndBattleText3:
	text_far _SeviiRoute33DiveEndBattleText3
	text_end

SeviiRoute33DiveAfterBattleText3:
	text_far _SeviiRoute33DiveAfterBattleText3
	text_end

; ---

SeviiRoute33DiveBattleText4:
	text_far _SeviiRoute33DiveBattleText4
	text_end

SeviiRoute33DiveEndBattleText4:
	text_far _SeviiRoute33DiveEndBattleText4
	text_end

SeviiRoute33DiveAfterBattleText4:
	text_far _SeviiRoute33DiveAfterBattleText4
	text_end
