SeviiSevenIslandGym2Dive_Script:
	call HandleFlags_SSIG2D
	call EnableAutoTextBoxDrawing
	ld hl, SeviiSevenIslandGym2DiveTrainerHeaders
	ld de, SeviiSevenIslandGym2Dive_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

HandleFlags_SSIG2D:
    ld hl, wCurrentMapScriptFlags
    bit 5, [hl]
    res 5, [hl]
    ret z
	SetEvent EVENT_BATTLE_CAN_BE_LOST
	ret

SeviiSevenIslandGym2Dive_ScriptPointers:
	dw SeviiSevenIslandGym2DiveScript0
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

SeviiSevenIslandGym2DiveScript0:
	ld a, [wIsInBattle]
	cp $ff
	jp nz, CheckFightingMapTrainers
; we have been defeated
	ld a, 12 ; SeviiSevenIslandGym2DiveText12_PostBlackOut
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	predef HealParty
	ld a, SPRITE_FACING_DOWN
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, SEVII_SEVEN_ISLAND_GYM_1
	ldh [hWarpDestinationMap], a
	ld a, 2 ; -1 wrt the normal numbering
	ld [wDestinationWarpID], a
	ld hl, wd72d
	set 3, [hl] ; do scripted warp
	xor a
    ld [wWalkBikeSurfState], a
	ld [wWalkBikeSurfStateCopy], a
	ld [wIsInBattle], a
	ret

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
	dw SeviiSevenIslandGym2DiveText12_PostBlackOut

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

SeviiSevenIslandGym2DiveText12_PostBlackOut:
	text_far _SeviiSevenIslandGymTextBlackout
	text_end
