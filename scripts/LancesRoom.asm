LancesRoom_Script:
	RPTextChooser LancesRoom_TextPointers, LancesRoom_TextPointers_Rocket
	call LanceShowOrHideEntranceBlocks
	call EnableAutoTextBoxDrawing
	ld hl, LancesRoomTrainerHeaders
	ld de, LancesRoom_ScriptPointers
	ld a, [wLancesRoomCurScript]
	call ExecuteCurMapScriptInTable
	ld [wLancesRoomCurScript], a
	ret

LanceShowOrHideEntranceBlocks:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
; new for RP
	CheckEvent EVENT_ROCKET_PATH
	jr z, .dontStopMusic
	CheckEvent EVENT_RP_BEAT_PINK_SIX_ISLAND
	jr z, .dontStopMusic
	CheckEvent EVENT_RP_ELIMINATED_LANCE
	jr z, .dontStopMusic
	call StopAllMusic
.dontStopMusic
; BTV
; new for RP
	CheckEvent EVENT_ROCKET_PATH
	jr z, .vanilla
	CheckEvent EVENT_RP_BEAT_PINK_SIX_ISLAND
	ret nz
.vanilla
; BTV
	CheckEvent EVENT_LANCES_ROOM_LOCK_DOOR
	jr nz, .closeEntrance
	; open entrance
	ld a, $31
	ld b, $32
	jp .setEntranceBlocks
.closeEntrance
	ld a, $72
	ld b, $73
.setEntranceBlocks
; Replaces the tile blocks so the player can't leave.
	push bc
	ld [wNewTileBlockID], a
	lb bc, 6, 2
	call .SetEntranceBlock
	pop bc
	ld a, b
	ld [wNewTileBlockID], a
	lb bc, 6, 3
.SetEntranceBlock:
	predef_jump ReplaceTileBlock

ResetLanceScript:
	xor a
	ld [wLancesRoomCurScript], a
	ld [wCurMapScript], a ; new, maybe unnecessary
	ret

LancesRoom_ScriptPointers:
	dw LanceScript0
	dw DisplayEnemyTrainerTextAndStartBattle
	dw LanceScript2
	dw LanceScript3
	dw LanceScript4
	; new for RP
	dw LanceScript5

LanceScript4:
	ret

LanceScript0:
	CheckEvent EVENT_BEAT_LANCE
	ret nz
	ld hl, LanceTriggerMovementCoords
	call ArePlayerCoordsInArray
	jp nc, CheckFightingMapTrainers
	xor a
	ldh [hJoyHeld], a
	ld a, [wCoordIndex]
	cp $3  ; Is player standing next to Lance's sprite?
	jr nc, .notStandingNextToLance
	ld a, $1
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID
.notStandingNextToLance
	cp $5  ; Is player standing on the entrance staircase?
	jr z, WalkToLance
	CheckAndSetEvent EVENT_LANCES_ROOM_LOCK_DOOR
	ret nz
	ld hl, wCurrentMapScriptFlags
	set 5, [hl]
	ld a, SFX_GO_INSIDE
	call PlaySound
	jp LanceShowOrHideEntranceBlocks

LanceTriggerMovementCoords:
	dbmapcoord  5,  1
	dbmapcoord  6,  2
	dbmapcoord  5, 10 ; edited, leftover from Red?
	dbmapcoord  6, 10 ; edited, leftover from Red?
	dbmapcoord 24, 16
	db -1 ; end

LanceScript2:
	call EndTrainerBattle
	ld a, [wIsInBattle]
	cp $ff
	jp z, ResetLanceScript
; we won
	CheckEvent EVENT_RP_BEAT_PINK_SIX_ISLAND
	jr z, .notChampionPink
; champion Pink
	ld a, 5
	ld [wLancesRoomCurScript], a
	ld [wCurMapScript], a
	ret
.notChampionPink
	ld a, $1
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID

WalkToLance:
; Moves the player down the hallway to Lance's room.
; new for RP
	CheckEvent EVENT_RP_ENTERED_LANCES_ROOM_ONCE
	ret nz
; BTV
	ld a, $ff
	ld [wJoyIgnore], a
	ld hl, wSimulatedJoypadStatesEnd
	ld de, WalkToLance_RLEList
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
	ld a, $3
	ld [wLancesRoomCurScript], a
	ld [wCurMapScript], a
; new for RP
	CheckEvent EVENT_ROCKET_PATH
	ret z
	CheckEvent EVENT_RP_BEAT_PINK_SIX_ISLAND
	ret z
	SetEvent EVENT_RP_ENTERED_LANCES_ROOM_ONCE
; BTV
	ret

WalkToLance_RLEList:
	db D_UP, 13
	db D_LEFT, 12
	db D_DOWN, 7
	db D_LEFT, 6
	db -1 ; end

LanceScript3:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	xor a
	ld [wJoyIgnore], a
	ld [wLancesRoomCurScript], a
	ld [wCurMapScript], a
	ret

LancesRoom_TextPointers:
	dw LanceText1

LancesRoom_TextPointers_Rocket:
	dw LanceText1_RP

LancesRoomTrainerHeaders:
	def_trainers
LancesRoomTrainerHeader0:
	trainer EVENT_BEAT_LANCES_ROOM_TRAINER_0, 0, LanceBeforeBattleText, LanceEndBattleText, LanceAfterBattleText
LancesRoomTrainerHeader1:
	trainer EVENT_BEAT_LANCES_ROOM_TRAINER_1, 0, LanceBeforeBattleTextRematch, LanceEndBattleTextRematch, LanceAfterBattleTextRematch
LancesRoomTrainerHeader2:
	trainer EVENT_BEAT_LANCES_ROOM_TRAINER_2, 0, LanceBeforeBattleTextRematch2, LanceEndBattleTextRematch2, LanceAfterBattleTextRematch2
LancesRoomTrainerHeader3:
	trainer EVENT_BEAT_LANCES_ROOM_TRAINER_3, 0, LanceBeforeBattleText_RP, LanceEndBattleText_RP, LanceAfterBattleText_RP
LancesRoomTrainerHeader4:
	trainer EVENT_BEAT_LANCES_ROOM_TRAINER_4, 0, LanceBeforeBattleText_RP_Pink, LanceEndBattleText_RP_Pink, LanceAfterBattleText_RP_Pink
	db -1 ; end

LanceText1:
	text_asm
; new, check if we beat League rematch AND at least one Sevii Sage
	CheckEvent EVENT_BEAT_CHAMPION_FINAL_REMATCH
	jr z, .firstRematch
	CheckEvent EVENT_SEVII_BEAT_AT_LEAST_ONE_SHRINE_SAGE
	ld hl, LancesRoomTrainerHeader2
	jr z, .firstRematch
	call TalkToTrainer
	ld a, 3
	ld [wTrainerNo], a
	jp TextScriptEnd
.firstRematch ; new, check if we beat all gyms leaders in their gym rematches
	ld hl, LancesRoomTrainerHeader1
	CheckEvent EVENT_BEAT_ALL_GYMS_REMATCH
	jr z, .notRematch
	call TalkToTrainer
	ld a, 2
	ld [wTrainerNo], a
	jp TextScriptEnd
.notRematch
; end rematches check
	ld hl, LancesRoomTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

LanceBeforeBattleText:
	text_far _LanceBeforeBattleText
	text_end

LanceEndBattleText:
	text_far _LanceEndBattleText
	text_end

LanceAfterBattleText:
	text_far _LanceAfterBattleText
	text_asm
	SetEvent EVENT_BEAT_LANCE
	jp TextScriptEnd

; new -------------------------------

LanceBeforeBattleTextRematch:
	text_far _LanceBeforeBattleTextRematch
	text_end

LanceEndBattleTextRematch:
	text_far _LanceEndBattleTextRematch
	text_end

LanceAfterBattleTextRematch:
	text_far _LanceAfterBattleTextRematch
	text_asm
	SetEvent EVENT_BEAT_LANCE
	jp TextScriptEnd

LanceBeforeBattleTextRematch2:
	text_far _LanceBeforeBattleTextRematch2
	text_end

LanceEndBattleTextRematch2:
	text_far _LanceEndBattleTextRematch2
	text_end

LanceAfterBattleTextRematch2:
	text_far _LanceAfterBattleTextRematch2
	text_asm
	SetEvent EVENT_BEAT_LANCE
	jp TextScriptEnd

; new for RP =======================

LanceText1_RP:
	text_asm
	SetEvent EVENT_RP_USE_VANILLA_BATTLE_MESSAGES
	CheckEvent EVENT_RP_BEAT_PINK_SIX_ISLAND
	jr nz, .championPink
; pre-Giovanni death
	ld hl, LancesRoomTrainerHeader3
	call TalkToTrainer
	ld a, 4
	jr .gotTrainerNumber
.championPink
	ld hl, LancesRoomTrainerHeader4
	call TalkToTrainer
	ld a, 3
.gotTrainerNumber
	ld [wTrainerNo], a
	jp TextScriptEnd

LanceBeforeBattleText_RP:
	text_far _LanceBeforeBattleText_RP
	text_end

LanceEndBattleText_RP:
	text_far _LanceEndBattleText_RP
	text_end

LanceAfterBattleText_RP:
	text_asm
	CheckEvent EVENT_BEAT_CHAMPION_RIVAL
	ld hl, LanceAfterBattleText_RP_After
	jr nz, .printAndEnd
; didn't beat Blue yet
	ld a, $1
	ld [wChampionsRoomCurScript], a
	SetEvent EVENT_BEAT_LANCE
	ld hl, LanceAfterBattleText_RP_Before
.printAndEnd
	call PrintText
	jp TextScriptEnd

LanceAfterBattleText_RP_Before:
	text_far _LanceAfterBattleText_RP_Before
	text_end

LanceAfterBattleText_RP_After:
	text_far _LanceAfterBattleText_RP_After
	text_end

LanceBeforeBattleText_RP_Pink:
	text_far _LanceBeforeBattleText_RP_Pink
	text_end

LanceEndBattleText_RP_Pink:
	text_far _LanceEndBattleText_RP_Pink
	text_end

LanceAfterBattleText_RP_Pink:
	text_asm
	ld a, $1
	ld [wChampionsRoomCurScript], a
	SetEvent EVENT_BEAT_LANCE
	ld hl, LanceAfterBattleText_RP_Pink_Core
	call PrintText
	jp TextScriptEnd

LanceAfterBattleText_RP_Pink_Core:
	text_far _LanceAfterBattleText_RP_Pink_Core
	text_end

LanceScript5:
	ld a, $1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; kill Lance
    call GBFadeOutToWhite
    call GBFadeInFromWhite
    call GBFadeOutToWhite
    call GBFadeInFromWhite
    call GBFadeOutToBlack
	call StopMusic
    ld c, 60
    call DelayFrames
	ld c, BANK(SFX_Push_Boulder_1)
	ld a, SFX_PUSH_BOULDER
	call PlayMusic
	ld a, HS_LANCES_ROOM_LANCE
	ld [wMissableObjectIndex], a
	predef HideObject
	call UpdateSprites
    ld c, 100
    call DelayFrames
    call GBFadeInFromBlack
	SetEvent EVENT_RP_ELIMINATED_LANCE
	jp ResetLanceScript
