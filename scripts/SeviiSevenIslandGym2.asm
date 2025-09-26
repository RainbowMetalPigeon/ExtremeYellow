SeviiSevenIslandGym2_Script:
	call HandleBag
	call EnableAutoTextBoxDrawing
	ld hl, SeviiSevenIslandGym2TrainerHeaders
	ld de, SeviiSevenIslandGym2_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

HandleBag:
    ld hl, wCurrentMapScriptFlags
    bit 5, [hl]
    res 5, [hl]
    ret z
	CheckAndResetEvent EVENT_SEVII_JUST_ENTERED_SEVEN_GYM
	ret z
	call SaveBagIntoSpecialSRAM
	call ClearPlayersBag
	ret

SeviiSevenIslandGym2_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

SeviiSevenIslandGym2_TextPointers:
	dw SeviiSevenIslandGym2Text1
	dw SeviiSevenIslandGym2Text2
	dw SeviiSevenIslandGym2Text3
	dw SeviiSevenIslandGym2Text4
	dw SeviiSevenIslandGym2Text5
	dw SeviiSevenIslandGym2Text6
	dw SeviiSevenIslandGym2Text7
	dw RockSmashText
	dw RockSmashText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	text_end

SeviiSevenIslandGym2TrainerHeaders:
	def_trainers 1
SeviiSevenIslandGym2TrainerHeader1:
	trainer EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_2_TRAINER_1, 2, SeviiSevenIslandGym2BattleText1, SeviiSevenIslandGym2EndBattleText1, SeviiSevenIslandGym2AfterBattleText1
SeviiSevenIslandGym2TrainerHeader2:
	trainer EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_2_TRAINER_2, 1, SeviiSevenIslandGym2BattleText2, SeviiSevenIslandGym2EndBattleText2, SeviiSevenIslandGym2AfterBattleText2
SeviiSevenIslandGym2TrainerHeader3:
	trainer EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_2_TRAINER_3, 1, SeviiSevenIslandGym2BattleText3, SeviiSevenIslandGym2EndBattleText3, SeviiSevenIslandGym2AfterBattleText3
SeviiSevenIslandGym2TrainerHeader4:
	trainer EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_2_TRAINER_4, 1, SeviiSevenIslandGym2BattleText4, SeviiSevenIslandGym2EndBattleText4, SeviiSevenIslandGym2AfterBattleText4
SeviiSevenIslandGym2TrainerHeader5:
	trainer EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_2_TRAINER_5, 1, SeviiSevenIslandGym2BattleText5, SeviiSevenIslandGym2EndBattleText5, SeviiSevenIslandGym2AfterBattleText5
SeviiSevenIslandGym2TrainerHeader6:
	trainer EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_2_TRAINER_6, 3, SeviiSevenIslandGym2BattleText6, SeviiSevenIslandGym2EndBattleText6, SeviiSevenIslandGym2AfterBattleText6
SeviiSevenIslandGym2TrainerHeader7:
	trainer EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_2_TRAINER_7, 4, SeviiSevenIslandGym2BattleText7, SeviiSevenIslandGym2EndBattleText7, SeviiSevenIslandGym2AfterBattleText7
	db -1 ; end

SeviiSevenIslandGym2_TalkToTrainer:
	call TalkToTrainer
	jp TextScriptEnd

; ---------------------------------------

SeviiSevenIslandGym2Text1:
	text_asm
	ld hl, SeviiSevenIslandGym2TrainerHeader1
	jr SeviiSevenIslandGym2_TalkToTrainer

SeviiSevenIslandGym2BattleText1:
	text_far _SeviiSevenIslandGym2BattleText1
	text_end

SeviiSevenIslandGym2EndBattleText1:
	text_far _SeviiSevenIslandGym2EndBattleText1
	text_end

SeviiSevenIslandGym2AfterBattleText1:
	text_far _SeviiSevenIslandGym2AfterBattleText1
	text_end

; ---------------------------------------

SeviiSevenIslandGym2Text2:
	text_asm
	ld hl, SeviiSevenIslandGym2TrainerHeader2
	jr SeviiSevenIslandGym2_TalkToTrainer

SeviiSevenIslandGym2BattleText2:
	text_far _SeviiSevenIslandGym2BattleText2
	text_end

SeviiSevenIslandGym2EndBattleText2:
	text_far _SeviiSevenIslandGym2EndBattleText2
	text_end

SeviiSevenIslandGym2AfterBattleText2:
	text_far _SeviiSevenIslandGym2AfterBattleText2
	text_end

; ---------------------------------------

SeviiSevenIslandGym2Text3:
	text_asm
	ld hl, SeviiSevenIslandGym2TrainerHeader3
	jr SeviiSevenIslandGym2_TalkToTrainer

SeviiSevenIslandGym2BattleText3:
	text_far _SeviiSevenIslandGym2BattleText3
	text_end

SeviiSevenIslandGym2EndBattleText3:
	text_far _SeviiSevenIslandGym2EndBattleText3
	text_end

SeviiSevenIslandGym2AfterBattleText3:
	text_far _SeviiSevenIslandGym2AfterBattleText3
	text_end

; ---------------------------------------

SeviiSevenIslandGym2Text4:
	text_asm
	ld hl, SeviiSevenIslandGym2TrainerHeader4
	jr SeviiSevenIslandGym2_TalkToTrainer

SeviiSevenIslandGym2BattleText4:
	text_far _SeviiSevenIslandGym2BattleText4
	text_end

SeviiSevenIslandGym2EndBattleText4:
	text_far _SeviiSevenIslandGym2EndBattleText4
	text_end

SeviiSevenIslandGym2AfterBattleText4:
	text_far _SeviiSevenIslandGym2AfterBattleText4
	text_end

; ---------------------------------------

SeviiSevenIslandGym2Text5:
	text_asm
	ld hl, SeviiSevenIslandGym2TrainerHeader5
	jr SeviiSevenIslandGym2_TalkToTrainer

SeviiSevenIslandGym2BattleText5:
	text_far _SeviiSevenIslandGym2BattleText5
	text_end

SeviiSevenIslandGym2EndBattleText5:
	text_far _SeviiSevenIslandGym2EndBattleText5
	text_end

SeviiSevenIslandGym2AfterBattleText5:
	text_far _SeviiSevenIslandGym2AfterBattleText5
	text_end

; ---------------------------------------

SeviiSevenIslandGym2Text6:
	text_asm
	ld hl, SeviiSevenIslandGym2TrainerHeader6
	jr SeviiSevenIslandGym2_TalkToTrainer

SeviiSevenIslandGym2BattleText6:
	text_far _SeviiSevenIslandGym2BattleText6
	text_end

SeviiSevenIslandGym2EndBattleText6:
	text_far _SeviiSevenIslandGym2EndBattleText6
	text_end

SeviiSevenIslandGym2AfterBattleText6:
	text_far _SeviiSevenIslandGym2AfterBattleText6
	text_end

; ---------------------------------------

SeviiSevenIslandGym2Text7:
	text_asm
	ld hl, SeviiSevenIslandGym2TrainerHeader7
	jp SeviiSevenIslandGym2_TalkToTrainer

SeviiSevenIslandGym2BattleText7:
	text_far _SeviiSevenIslandGym2BattleText7
	text_end

SeviiSevenIslandGym2EndBattleText7:
	text_far _SeviiSevenIslandGym2EndBattleText7
	text_end

SeviiSevenIslandGym2AfterBattleText7:
	text_far _SeviiSevenIslandGym2AfterBattleText7
	text_end

; ---------------------------------------

;SeviiSevenIslandGym2Text1:
;	text_far _SeviiSevenIslandGym2Text1
;	text_end
