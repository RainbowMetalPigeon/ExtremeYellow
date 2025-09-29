SeviiSevenIslandGym3_Script:
	call HandleBoulderAndFlags_SSIG3
	call EnableAutoTextBoxDrawing
	ld hl, SeviiSevenIslandGym3TrainerHeaders
	ld de, SeviiSevenIslandGym3_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

HandleBoulderAndFlags_SSIG3:
    ld hl, wCurrentMapScriptFlags
    bit 5, [hl]
    res 5, [hl]
    ret z
	SetEvent EVENT_BATTLE_CAN_BE_LOST
	CheckEvent EVENT_SEVII_SEVEN_ISLAND_GYM_3_BOULDER_ON_SWITCH
	ret z
	ld a, $1d
	ld [wNewTileBlockID], a
	lb bc, 8, 3
	predef_jump ReplaceTileBlock

SeviiSevenIslandGym3_ScriptPointers:
	dw SeviiSevenIslandGym3Script0
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw SeviiSevenIslandGym3ScriptPostBattle

; =========================================

SeviiSevenIslandGym3Script0:
	ld a, [wIsInBattle]
	cp $ff
	jr nz, .nonDefeated
; we have been defeated
	ld a, 17 ; SeviiSevenIslandGym3Text16_PostBlackOut
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	predef HealParty
	ld a, SPRITE_FACING_DOWN
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, SEVII_SEVEN_ISLAND_GYM_1
	ldh [hWarpDestinationMap], a
	ld a, 2 ; -1 wrt the normal numbering
	ld [wDestinationWarpID], a
	xor a
	ld [wIsInBattle], a
	ld hl, wd72d
	set 3, [hl] ; do scripted warp
	ret
.nonDefeated
	CheckEvent EVENT_SEVII_SEVEN_ISLAND_GYM_3_BOULDER_ON_SWITCH
	jp nz, CheckFightingMapTrainers
	ld hl, CoordsData_BoulderySwitch
	call CheckBoulderCoords
	jp nc, CheckFightingMapTrainers
	ldh a, [hSpriteIndex]
	cp $f
	jp z, CheckFightingMapTrainers
	ld hl, wCurrentMapScriptFlags
	set 5, [hl]
	SetEvent EVENT_SEVII_SEVEN_ISLAND_GYM_3_BOULDER_ON_SWITCH
	ret

CoordsData_BoulderySwitch:
	dbmapcoord 37,  4
	db -1 ; end

SeviiSevenIslandGym3ScriptPostBattle:
	xor a
	ld [wCurMapScript], a
; check battle result
	ld a, [wIsInBattle]
	cp $ff
	jr nz, .playerWon
; if we lost
	ld a, 16 ; if we lost
	jr .commonPart
.playerWon
	SetEvent EVENT_DEFEATED_SEVII_SAGE_NANETTE
	ld a, 15
.commonPart
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	xor a
	ld [wIsTrainerBattle], a
	ld [wCurMapScript], a
; warp player back to entrance
	predef HealParty
	ld a, SPRITE_FACING_DOWN
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, SEVII_SEVEN_ISLAND_GYM_1
	ldh [hWarpDestinationMap], a
	ld a, 2 ; -1 wrt the normal numbering
	ld [wDestinationWarpID], a
	xor a
	ld [wIsInBattle], a
	ld hl, wd72d
	set 3, [hl] ; do scripted warp
	ret

; =========================================

SeviiSevenIslandGym3_TextPointers:
	dw SeviiSevenIslandGym3Text1 ; Nanette
	dw SeviiSevenIslandGym3Text2
	dw SeviiSevenIslandGym3Text3
	dw SeviiSevenIslandGym3Text4
	dw SeviiSevenIslandGym3Text5
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	; scripts
	dw SeviiSevenIslandGym3Text5_Victory ; 15
	dw SeviiSevenIslandGym3Text5_Defeat ; 16
	dw SeviiSevenIslandGym3Text16_PostBlackOut ; 17

SeviiSevenIslandGym3TrainerHeaders:
	def_trainers 2
SeviiSevenIslandGym3TrainerHeader1:
	trainer EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_3_TRAINER_1, 1, SeviiSevenIslandGym3BattleText1, SeviiSevenIslandGym3EndBattleText1, SeviiSevenIslandGym3AfterBattleText1
SeviiSevenIslandGym3TrainerHeader2:
	trainer EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_3_TRAINER_2, 1, SeviiSevenIslandGym3BattleText2, SeviiSevenIslandGym3EndBattleText2, SeviiSevenIslandGym3AfterBattleText2
SeviiSevenIslandGym3TrainerHeader3:
	trainer EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_3_TRAINER_3, 2, SeviiSevenIslandGym3BattleText3, SeviiSevenIslandGym3EndBattleText3, SeviiSevenIslandGym3AfterBattleText3
SeviiSevenIslandGym3TrainerHeader4:
	trainer EVENT_BEAT_SEVII_SEVEN_ISLAND_GYM_3_TRAINER_4, 4, SeviiSevenIslandGym3BattleText4, SeviiSevenIslandGym3EndBattleText4, SeviiSevenIslandGym3AfterBattleText4
	db -1 ; end

SeviiSevenIslandGym3_TalkToTrainer:
	call TalkToTrainer
	jp TextScriptEnd

; ---------------------------------------

SeviiSevenIslandGym3Text2:
	text_asm
	ld hl, SeviiSevenIslandGym3TrainerHeader1
	jr SeviiSevenIslandGym3_TalkToTrainer

SeviiSevenIslandGym3BattleText1:
	text_far _SeviiSevenIslandGym3BattleText1
	text_end

SeviiSevenIslandGym3EndBattleText1:
	text_far _SeviiSevenIslandGym3EndBattleText1
	text_end

SeviiSevenIslandGym3AfterBattleText1:
	text_far _SeviiSevenIslandGym3AfterBattleText1
	text_end

; ---------------------------------------

SeviiSevenIslandGym3Text3:
	text_asm
	ld hl, SeviiSevenIslandGym3TrainerHeader2
	jr SeviiSevenIslandGym3_TalkToTrainer

SeviiSevenIslandGym3BattleText2:
	text_far _SeviiSevenIslandGym3BattleText2
	text_end

SeviiSevenIslandGym3EndBattleText2:
	text_far _SeviiSevenIslandGym3EndBattleText2
	text_end

SeviiSevenIslandGym3AfterBattleText2:
	text_far _SeviiSevenIslandGym3AfterBattleText2
	text_end

; ---------------------------------------

SeviiSevenIslandGym3Text4:
	text_asm
	ld hl, SeviiSevenIslandGym3TrainerHeader3
	jr SeviiSevenIslandGym3_TalkToTrainer

SeviiSevenIslandGym3BattleText3:
	text_far _SeviiSevenIslandGym3BattleText3
	text_end

SeviiSevenIslandGym3EndBattleText3:
	text_far _SeviiSevenIslandGym3EndBattleText3
	text_end

SeviiSevenIslandGym3AfterBattleText3:
	text_far _SeviiSevenIslandGym3AfterBattleText3
	text_end

; ---------------------------------------

SeviiSevenIslandGym3Text5:
	text_asm
	ld hl, SeviiSevenIslandGym3TrainerHeader4
	jr SeviiSevenIslandGym3_TalkToTrainer

SeviiSevenIslandGym3BattleText4:
	text_far _SeviiSevenIslandGym3BattleText4
	text_end

SeviiSevenIslandGym3EndBattleText4:
	text_far _SeviiSevenIslandGym3EndBattleText4
	text_end

SeviiSevenIslandGym3AfterBattleText4:
	text_far _SeviiSevenIslandGym3AfterBattleText4
	text_end

; ---------------------------------------

SeviiSevenIslandGym3Text1:
	text_asm
	ld hl, SeviiSevenIslandGym3Text1_Intro
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, wOptions
	res 7, [hl] ; turn on battle animations
	set 6, [hl] ; battle style set
	SetEvent EVENT_BATTLE_CAN_BE_LOST
	ld hl, NanetteText_PostBattleText
	ld de, NanetteText_PostBattleText
	call SaveEndBattleTextPointers
	ld a, OPP_NANETTE
	ld [wCurOpponent], a
	ld a, 1
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	xor a
	ldh [hJoyHeld], a
	ld a, 3
	ld [wCurMapScript], a
	jp TextScriptEnd
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiSevenIslandGym3Text1_Intro:
	text_far _SeviiSevenIslandGym3Text1_Intro
	text_end

NanetteText_PostBattleText:
	text_far _NanetteText_PostBattleText
	text_end

SeviiSevenIslandGym3Text5_Victory:
	text_far _SeviiSevenIslandGym3Text5_Victory
	text_end

SeviiSevenIslandGym3Text5_Defeat:
	text_far _SeviiSevenIslandGym3Text5_Defeat
	text_end

; ---------------------------------------

SeviiSevenIslandGym3Text16_PostBlackOut:
	text_far _SeviiSevenIslandGymTextBlackout
	text_end
