OchreGym_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, OchreGymSetDoorTile

	call EnableAutoTextBoxDrawing
	ld hl, OchreGymTrainerHeaders
	ld de, OchreGym_ScriptPointers
	ld a, [wOchreGymCurScript]
	call ExecuteCurMapScriptInTable
	ld [wOchreGymCurScript], a
	ret

OchreGymSetDoorTile:
	CheckEvent EVENT_OCHRE_LOCK_TRY_2
	jr nz, .doorsOpen
	ld a, $24 ; double door tile ID
	jr .replaceTile
.doorsOpen
	ld a, $5 ; clear floor tile ID
.replaceTile
	ld [wNewTileBlockID], a
	lb bc, 14, 7
	predef_jump ReplaceTileBlock

OchreGymResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wOchreGymCurScript], a
	ld [wCurMapScript], a
	ret

OchreGym_ScriptPointers:
	dw OchreGymScript0
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw OchreGymOragePostBattle
	dw OchreGymScript4
	dw OchreGymOragePostBattleRematch

OchreGymScript0:
	ld a, [wYCoord]
	ld b, a
	ld a, [wXCoord]
	ld c, a
	ld hl, OchreGymArrowTilePlayerMovement
	call DecodeArrowMovementRLE
	cp $ff
	jp z, CheckFightingMapTrainers
	call StartSimulatingJoypadStates
	ld hl, wd736
	set 7, [hl]
	ld a, SFX_ARROW_TILES
	call PlaySound
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, $4
	ld [wCurMapScript], a
	ret

OchreGymArrowTilePlayerMovement:
	map_coord_movement 18, 33, OchreGymArrowMovement3
	map_coord_movement  2,  2, OchreGymArrowMovement4
	map_coord_movement  2,  8, OchreGymArrowMovement5
	map_coord_movement  1, 12, OchreGymArrowMovement6
	map_coord_movement  1, 13, OchreGymArrowMovement7
	map_coord_movement  3, 12, OchreGymArrowMovement8
	map_coord_movement  3, 13, OchreGymArrowMovement9
	map_coord_movement  2, 21, OchreGymArrowMovement10
	map_coord_movement  3, 21, OchreGymArrowMovement11
	map_coord_movement 23, 20, OchreGymArrowMovement12
	map_coord_movement 23, 21, OchreGymArrowMovement13
	map_coord_movement 24, 21, OchreGymArrowMovement14
	map_coord_movement 25, 21, OchreGymArrowMovement15
	map_coord_movement 25, 12, OchreGymArrowMovement16
	db -1 ; end

OchreGymArrowMovement3:
	db D_LEFT, 6
	db -1 ; end

OchreGymArrowMovement4:
	db D_DOWN, 6
	db -1 ; end

OchreGymArrowMovement5:
	db D_DOWN, 7
	db -1 ; end

OchreGymArrowMovement6:
	db D_LEFT, 1
	db -1 ; end

OchreGymArrowMovement7:
	db D_LEFT, 1
	db -1 ; end

OchreGymArrowMovement8:
	db D_LEFT, 2
	db -1 ; end

OchreGymArrowMovement9:
	db D_LEFT, 2
	db -1 ; end

OchreGymArrowMovement10:
	db D_UP, 6
	db -1 ; end

OchreGymArrowMovement11:
	db D_UP, 8
	db -1 ; end

OchreGymArrowMovement12:
	db D_LEFT, 1
	db -1 ; end

OchreGymArrowMovement13:
	db D_LEFT, 7
	db -1 ; end

OchreGymArrowMovement14:
	db D_UP, 1
	db -1 ; end

OchreGymArrowMovement15:
	db D_UP, 8
	db -1 ; end

OchreGymArrowMovement16:
	db D_DOWN, 1
	db -1 ; end

OchreGymScript4:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	jr nz, .OchreGymLoadSpinnerArrow
	xor a
	ld [wJoyIgnore], a
	ld hl, wd736
	res 7, [hl]
	ld a, $0
	ld [wCurMapScript], a
	ret
.OchreGymLoadSpinnerArrow
	farjp LoadSpinnerArrowTiles

OchreGymOragePostBattle:
	ld a, [wIsInBattle]
	cp $ff
	jp z, OchreGymResetScripts
	ld a, $f0
	ld [wJoyIgnore], a
; fallthrough
OchreGymReceiveGift:
	ld a, $f ; testing
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_OCHRE_GYM_ORAGE
	lb bc, MAX_REVIVE, 1 ; TBE with PERFECTER
	call GiveItem
	jr nc, .BagFull
	ld a, $10 ; testing
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_OCHRE_GYM_GOT_GIFT
	jr .gymVictory
.BagFull
	ld a, $11 ; testing
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.gymVictory
	; deactivate gym trainers
;	SetEventRange EVENT_BEAT_OCHRE_GYM_TRAINER_0, EVENT_BEAT_OCHRE_GYM_TRAINER_7 ; not needed because they're all unavoidable
	jp OchreGymResetScripts

OchreGymOragePostBattleRematch:
	ld a, [wIsInBattle]
	cp $ff
	jp z, OchreGymResetScripts
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, $12
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	jp OchreGymResetScripts

OchreGym_TextPointers:
	dw OrageText
	dw OchreGymTrainerText1
	dw OchreGymTrainerText2
	dw OchreGymTrainerText3
	dw OchreGymTrainerText4
	dw OchreGymTrainerText5
	dw OchreGymTrainerText6
	dw OchreGymTrainerText7
	dw OchreGymStatueText
	dw OchreGymStatueText ; $0a
	dw OchreGymTrashBinText
	dw OchreGymTrashBinText
	dw OchreGymTrashBinText
	dw OchreGymTrashBinText
	dw OrageNoBadgeInfoText
	dw ReceivedGiftText
	dw GiftNoRoomText
	dw OragePostRematchText; new, 18=$12

OchreGymTrainerHeaders:
	def_trainers 2
OchreGymTrainerHeader0:
	trainer EVENT_BEAT_OCHRE_GYM_TRAINER_0, 1, OchreGymBattleText1, OchreGymEndBattleText1, OchreGymAfterBattleText1
OchreGymTrainerHeader1:
	trainer EVENT_BEAT_OCHRE_GYM_TRAINER_1, 2, OchreGymBattleText2, OchreGymEndBattleText2, OchreGymAfterBattleText2
OchreGymTrainerHeader2:
	trainer EVENT_BEAT_OCHRE_GYM_TRAINER_2, 2, OchreGymBattleText3, OchreGymEndBattleText3, OchreGymAfterBattleText3
OchreGymTrainerHeader3:
	trainer EVENT_BEAT_OCHRE_GYM_TRAINER_3, 1, OchreGymBattleText4, OchreGymEndBattleText4, OchreGymAfterBattleText4
OchreGymTrainerHeader4:
	trainer EVENT_BEAT_OCHRE_GYM_TRAINER_4, 3, OchreGymBattleText5, OchreGymEndBattleText5, OchreGymAfterBattleText5
OchreGymTrainerHeader5:
	trainer EVENT_BEAT_OCHRE_GYM_TRAINER_5, 2, OchreGymBattleText6, OchreGymEndBattleText6, OchreGymAfterBattleText6
OchreGymTrainerHeader6:
	trainer EVENT_BEAT_OCHRE_GYM_TRAINER_6, 1, OchreGymBattleText7, OchreGymEndBattleText7, OchreGymAfterBattleText7
	db -1 ; end

OrageText:
	text_asm
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE
	jr nz, .postGameCode
	CheckEvent EVENT_BEAT_OCHRE_GYM_ORAGE
	jr z, .beforeBeat
	CheckEventReuseA EVENT_OCHRE_GYM_GOT_GIFT
	jr nz, .afterBeat
	call z, OchreGymReceiveGift
	call DisableWaitingAfterTextDisplay
	jr .done
; new block of code for rematch
.postGameCode
	ld c, BANK(Music_MeetMaleTrainer)
	ld a, MUSIC_MEET_MALE_TRAINER
	call PlayMusic
	ld hl, OrageRematchPreBattleText
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_ORAGE
	ld [wCurOpponent], a
	ld a, 2
	ld [wTrainerNo], a
	ld hl, OrageRematchDefeatedText
	ld de, OrageRematchDefeatedText
	call SaveEndBattleTextPointers
	ld a, $5 ; new script
	ld [wOchreGymCurScript], a
	ld [wCurMapScript], a
	jr .done
; back to vanilla code

.afterBeat
	ld hl, OragePostBattleAdviceText
	call PrintText
	jr .done
.beforeBeat
	ld hl, OragePreBattleText
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, ReceivedNoBadgeText
	ld de, ReceivedNoBadgeText
	call SaveEndBattleTextPointers
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
	ld a, $3
	ld [wOchreGymCurScript], a
.done
	jp TextScriptEnd

OragePreBattleText:
	text_far _OragePreBattleText
	text_end

ReceivedNoBadgeText:
	text_far _ReceivedNoBadgeText
	text_end

OragePostBattleAdviceText:
	text_far _OragePostBattleAdviceText
;	text_waitbutton
	text_end

OrageNoBadgeInfoText:
	text_far _OrageNoBadgeInfoText
	text_end

ReceivedGiftText:
	text_far _ReceivedGiftText
	sound_get_item_1

GiftExplanationText:
	text_far _GiftExplanationText
	text_end

GiftNoRoomText:
	text_far _GiftNoRoomText
	text_end

; ----- trainers' texts -----

OchreGymTrainerText1:
	text_asm
	ld hl, OchreGymTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

OchreGymBattleText1:
	text_far _OchreGymBattleText1
	text_end

OchreGymEndBattleText1:
	text_far _OchreGymEndBattleText1
	text_end

OchreGymAfterBattleText1:
	text_far _OchreGymAfterBattleText1
	text_end

OchreGymTrainerText2:
	text_asm
	ld hl, OchreGymTrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

OchreGymBattleText2:
	text_far _OchreGymBattleText2
	text_end

OchreGymEndBattleText2:
	text_far _OchreGymEndBattleText2
	text_end

OchreGymAfterBattleText2:
	text_far _OchreGymAfterBattleText2
	text_end

OchreGymTrainerText3:
	text_asm
	ld hl, OchreGymTrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

OchreGymBattleText3:
	text_far _OchreGymBattleText3
	text_end

OchreGymEndBattleText3:
	text_far _OchreGymEndBattleText3
	text_end

OchreGymAfterBattleText3:
	text_far _OchreGymAfterBattleText3
	text_end

OchreGymTrainerText4:
	text_asm
	ld hl, OchreGymTrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

OchreGymBattleText4:
	text_far _OchreGymBattleText4
	text_end

OchreGymEndBattleText4:
	text_far _OchreGymEndBattleText4
	text_end

OchreGymAfterBattleText4:
	text_far _OchreGymAfterBattleText4
	text_end

OchreGymTrainerText5:
	text_asm
	ld hl, OchreGymTrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

OchreGymBattleText5:
	text_far _OchreGymBattleText5
	text_end

OchreGymEndBattleText5:
	text_far _OchreGymEndBattleText5
	text_end

OchreGymAfterBattleText5:
	text_far _OchreGymAfterBattleText5
	text_end

OchreGymTrainerText6:
	text_asm
	ld hl, OchreGymTrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

OchreGymBattleText6:
	text_far _OchreGymBattleText6
	text_end

OchreGymEndBattleText6:
	text_far _OchreGymEndBattleText6
	text_end

OchreGymAfterBattleText6:
	text_far _OchreGymAfterBattleText6
	text_end

OchreGymTrainerText7:
	text_asm
	ld hl, OchreGymTrainerHeader6
	call TalkToTrainer
	jp TextScriptEnd

OchreGymBattleText7:
	text_far _OchreGymBattleText7
	text_end

OchreGymEndBattleText7:
	text_far _OchreGymEndBattleText7
	text_end

OchreGymAfterBattleText7:
	text_far _OchreGymAfterBattleText7
	text_end

; ----- "signs" -----

OchreGymStatueText:
	text_far _OchreGymStatueText
	text_end

OchreGymTrashBinText:
	text_asm
    CheckEvent EVENT_OCHRE_LOCK_TRY_1
    jr nz, .secondTry
; first try at the trash bins
    SetEvent EVENT_OCHRE_LOCK_TRY_1
    ld hl, OchreGymTrashBinText_Try1
    call PrintText
    jr .done
.secondTry
; second try always open the door
	CheckEvent EVENT_OCHRE_LOCK_TRY_2
	jr nz, .thirdTry
	SetEvent EVENT_OCHRE_LOCK_TRY_2
    ld a, SFX_GO_INSIDE
    call PlaySound
    ld a, $5 ; clear floor tile ID
    ld [wNewTileBlockID], a
    lb bc, 14, 7
    predef ReplaceTileBlock
    ld hl, OchreGymTrashBinText_Try2
    call PrintText
	jr .done
.thirdTry
; third try closes the door
	ResetEvent EVENT_OCHRE_LOCK_TRY_2
    ld a, SFX_GO_INSIDE
    call PlaySound
	ld a, $24 ; double door tile ID
    ld [wNewTileBlockID], a
    lb bc, 14, 7
    predef ReplaceTileBlock
	ld hl, OchreGymTrashBinText_Try3
	call PrintText
	jr .done
.done
    jp TextScriptEnd

OchreGymTrashBinText_Try1:
	text_far _OchreGymTrashBinText_Try1
	text_end

OchreGymTrashBinText_Try2:
	text_far _OchreGymTrashBinText_Try2
	text_end

OchreGymTrashBinText_Try3:
	text_far _OchreGymTrashBinText_Try3
	text_end

; for rematch ---------------------

OrageRematchPreBattleText:
	text_far _OrageRematchPreBattleText
	text_end

OrageRematchDefeatedText:
	text_far _OrageRematchDefeatedText
	text_end

OragePostRematchText:
	text_far _GymLeaderPostRematchText
	text_end
