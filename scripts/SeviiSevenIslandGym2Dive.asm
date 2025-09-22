SeviiSevenIslandGym2Dive_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SeviiSevenIslandGym2DiveTrainerHeaders
	ld de, SeviiSevenIslandGym2Dive_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

SeviiSevenIslandGym2Dive_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

SeviiSevenIslandGym2Dive_TextPointers:
	dw SeviiSevenIslandGym2DiveText1
	dw SeviiSevenIslandGym2DiveText2
	dw SeviiSevenIslandGym2DiveText3
	dw SeviiSevenIslandGym2DiveText4
	dw SeviiSevenIslandGym2DiveText5
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	text_end

SeviiSevenIslandGym2DiveTrainerHeaders:
	def_trainers 1
SeviiSevenIslandGym2DiveTrainerHeader1:
	trainer EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_2_DIVE_TRAINER_1, 4, SeviiSevenIslandGym2DiveBattleText1, SeviiSevenIslandGym2DiveEndBattleText1, SeviiSevenIslandGym2DiveAfterBattleText1
SeviiSevenIslandGym2DiveTrainerHeader2:
	trainer EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_2_DIVE_TRAINER_2, 3, SeviiSevenIslandGym2DiveBattleText2, SeviiSevenIslandGym2DiveEndBattleText2, SeviiSevenIslandGym2DiveAfterBattleText2
SeviiSevenIslandGym2DiveTrainerHeader3:
	trainer EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_2_DIVE_TRAINER_3, 3, SeviiSevenIslandGym2DiveBattleText3, SeviiSevenIslandGym2DiveEndBattleText3, SeviiSevenIslandGym2DiveAfterBattleText3
SeviiSevenIslandGym2DiveTrainerHeader4:
	trainer EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_2_DIVE_TRAINER_4, 3, SeviiSevenIslandGym2DiveBattleText4, SeviiSevenIslandGym2DiveEndBattleText4, SeviiSevenIslandGym2DiveAfterBattleText4
SeviiSevenIslandGym2DiveTrainerHeader5:
	trainer EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_2_DIVE_TRAINER_5, 2, SeviiSevenIslandGym2DiveBattleText5, SeviiSevenIslandGym2DiveEndBattleText5, SeviiSevenIslandGym2DiveAfterBattleText5
	db -1 ; end

SeviiSevenIslandGym2Dive_TalkToTrainer:
	call TalkToTrainer
	jp TextScriptEnd

; ---------------------------------------

SeviiSevenIslandGym2DiveText1:
	text_asm
	ld hl, SeviiSevenIslandGym2DiveTrainerHeader1
	jr SeviiSevenIslandGym2Dive_TalkToTrainer

SeviiSevenIslandGym2DiveBattleText1:
	text_far _SeviiSevenIslandGym2DiveBattleText1
	text_end

SeviiSevenIslandGym2DiveEndBattleText1:
	text_far _SeviiSevenIslandGym2DiveEndBattleText1
	text_end

SeviiSevenIslandGym2DiveAfterBattleText1:
	text_far _SeviiSevenIslandGym2DiveAfterBattleText1
	text_end

; ---------------------------------------

SeviiSevenIslandGym2DiveText2:
	text_asm
	ld hl, SeviiSevenIslandGym2DiveTrainerHeader2
	jr SeviiSevenIslandGym2Dive_TalkToTrainer

SeviiSevenIslandGym2DiveBattleText2:
	text_far _SeviiSevenIslandGym2DiveBattleText2
	text_end

SeviiSevenIslandGym2DiveEndBattleText2:
	text_far _SeviiSevenIslandGym2DiveEndBattleText2
	text_end

SeviiSevenIslandGym2DiveAfterBattleText2:
	text_far _SeviiSevenIslandGym2DiveAfterBattleText2
	text_end

; ---------------------------------------

SeviiSevenIslandGym2DiveText3:
	text_asm
	ld hl, SeviiSevenIslandGym2DiveTrainerHeader3
	jr SeviiSevenIslandGym2Dive_TalkToTrainer

SeviiSevenIslandGym2DiveBattleText3:
	text_far _SeviiSevenIslandGym2DiveBattleText3
	text_end

SeviiSevenIslandGym2DiveEndBattleText3:
	text_far _SeviiSevenIslandGym2DiveEndBattleText3
	text_end

SeviiSevenIslandGym2DiveAfterBattleText3:
	text_far _SeviiSevenIslandGym2DiveAfterBattleText3
	text_end

; ---------------------------------------

SeviiSevenIslandGym2DiveText4:
	text_asm
	ld hl, SeviiSevenIslandGym2DiveTrainerHeader4
	jr SeviiSevenIslandGym2Dive_TalkToTrainer

SeviiSevenIslandGym2DiveBattleText4:
	text_far _SeviiSevenIslandGym2DiveBattleText4
	text_end

SeviiSevenIslandGym2DiveEndBattleText4:
	text_far _SeviiSevenIslandGym2DiveEndBattleText4
	text_end

SeviiSevenIslandGym2DiveAfterBattleText4:
	text_far _SeviiSevenIslandGym2DiveAfterBattleText4
	text_end

; ---------------------------------------

SeviiSevenIslandGym2DiveText5:
	text_asm
	ld hl, SeviiSevenIslandGym2DiveTrainerHeader5
	jr SeviiSevenIslandGym2Dive_TalkToTrainer

SeviiSevenIslandGym2DiveBattleText5:
	text_far _SeviiSevenIslandGym2DiveBattleText5
	text_end

SeviiSevenIslandGym2DiveEndBattleText5:
	text_far _SeviiSevenIslandGym2DiveEndBattleText5
	text_end

SeviiSevenIslandGym2DiveAfterBattleText5:
	text_far _SeviiSevenIslandGym2DiveAfterBattleText5
	text_end

; ---------------------------------------

;SeviiSevenIslandGym2DiveText1:
;	text_far _SeviiSevenIslandGym2DiveText1
;	text_end
