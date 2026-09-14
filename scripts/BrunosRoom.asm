BrunosRoom_Script:
	RPTextChooser BrunosRoom_TextPointers, BrunosRoom_TextPointers_Rocket
	call BrunoShowOrHideExitBlock
	call EnableAutoTextBoxDrawing
	ld hl, BrunosRoomTrainerHeaders
	ld de, BrunosRoom_ScriptPointers
	ld a, [wBrunosRoomCurScript]
	call ExecuteCurMapScriptInTable
	ld [wBrunosRoomCurScript], a
	ret

BrunoShowOrHideExitBlock:
; Blocks or clears the exit to the next room.
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
; new for RP
	CheckEvent EVENT_ROCKET_PATH
	jr z, .dontStopMusic
	CheckEvent EVENT_RP_BEAT_PINK_SIX_ISLAND
	jr z, .dontStopMusic
	CheckEvent EVENT_RP_ELIMINATED_BRUNO
	jr z, .dontStopMusic
	call StopAllMusic
.dontStopMusic
; BTV
; new
	CheckEvent EVENT_BEAT_BRUNOS_ROOM_TRAINER_0
	jr nz, .freeExitToNextRoom
	CheckEvent EVENT_BEAT_BRUNOS_ROOM_TRAINER_1
	jr nz, .freeExitToNextRoom
	CheckEvent EVENT_BEAT_BRUNOS_ROOM_TRAINER_2
	jr nz, .freeExitToNextRoom
	CheckEvent EVENT_BEAT_BRUNOS_ROOM_TRAINER_3
	jr nz, .freeExitToNextRoom
	CheckEvent EVENT_BEAT_BRUNOS_ROOM_TRAINER_4
; BTV
	jr z, .blockExitToNextRoom
.freeExitToNextRoom ; new
	ld a, $5
	jp .setExitBlock
.blockExitToNextRoom
	ld a, $24
.setExitBlock
	ld [wNewTileBlockID], a
	lb bc, 0, 2
	predef_jump ReplaceTileBlock

ResetBrunoScript:
	xor a
	ld [wBrunosRoomCurScript], a
	ld [wCurMapScript], a ; new, maybe unnecessary
	ret

BrunosRoom_ScriptPointers:
	dw BrunoScript0
	dw DisplayEnemyTrainerTextAndStartBattle
	dw BrunoScript2
	dw BrunoScript3
	dw BrunoScript4
	; new for RP
	dw BrunoScript5

BrunoScript4:
	ret

BrunoScriptWalkIntoRoom:
; Walk six steps upward.
	ld hl, wSimulatedJoypadStatesEnd
	ld a, D_UP
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld a, $6
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
	ld a, $3
	ld [wBrunosRoomCurScript], a
	ld [wCurMapScript], a
	ret

BrunoScript0:
	ld hl, BrunoEntranceCoords
	call ArePlayerCoordsInArray
	jp nc, CheckFightingMapTrainers
	xor a
	ldh [hJoyPressed], a
	ldh [hJoyHeld], a
	ld [wSimulatedJoypadStatesEnd], a
	ld [wSimulatedJoypadStatesIndex], a
	ld a, [wCoordIndex]
	cp $3  ; Is player standing one tile above the exit?
	jr c, .stopPlayerFromLeaving
	CheckAndSetEvent EVENT_AUTOWALKED_INTO_BRUNOS_ROOM
	jr z, BrunoScriptWalkIntoRoom
.stopPlayerFromLeaving
; new for RP
	CheckEvent EVENT_ROCKET_PATH
	jr z, .vanilla
	CheckEvent EVENT_RP_BEAT_PINK_SIX_ISLAND
	ret nz
.vanilla
; BTV
	ld a, $2
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID  ; "Don't run away!"
	ld a, D_UP | B_BUTTON ; edited, to fix blocking Pikachu glitch
	ld [wSimulatedJoypadStatesEnd], a
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
	ld a, $3
	ld [wBrunosRoomCurScript], a
	ld [wCurMapScript], a
	ret

BrunoEntranceCoords:
	dbmapcoord  4, 10
	dbmapcoord  5, 10
	dbmapcoord  4, 11
	dbmapcoord  5, 11
	db -1 ; end

BrunoScript3:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	xor a
	ld [wJoyIgnore], a
	ld [wBrunosRoomCurScript], a
	ld [wCurMapScript], a
	ret

BrunoScript2:
	call EndTrainerBattle
	ld a, [wIsInBattle]
	cp $ff
	jp z, ResetBrunoScript
; we won
	CheckEvent EVENT_RP_BEAT_PINK_SIX_ISLAND
	jr z, .notChampionPink
; champion Pink
	ld a, 5
	ld [wBrunosRoomCurScript], a
	ld [wCurMapScript], a
	ret
.notChampionPink
	ld a, $1
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID

BrunosRoom_TextPointers:
	dw BrunoText1
	dw BrunoDontRunAwayText

BrunosRoom_TextPointers_Rocket:
	dw BrunoText1_RP
	dw BrunoDontRunAwayText

BrunosRoomTrainerHeaders:
	def_trainers
BrunosRoomTrainerHeader0:
	trainer EVENT_BEAT_BRUNOS_ROOM_TRAINER_0, 0, BrunoBeforeBattleText, BrunoEndBattleText, BrunoAfterBattleText
BrunosRoomTrainerHeader1:
	trainer EVENT_BEAT_BRUNOS_ROOM_TRAINER_1, 0, BrunoBeforeBattleTextRematch, BrunoEndBattleTextRematch, BrunoAfterBattleTextRematch
BrunosRoomTrainerHeader2:
	trainer EVENT_BEAT_BRUNOS_ROOM_TRAINER_2, 0, BrunoBeforeBattleTextRematch2, BrunoEndBattleTextRematch2, BrunoAfterBattleTextRematch2
BrunosRoomTrainerHeader3:
	trainer EVENT_BEAT_BRUNOS_ROOM_TRAINER_3, 0, BrunoBeforeBattleText_RP, BrunoEndBattleText_RP, BrunoAfterBattleText_RP
BrunosRoomTrainerHeader4:
	trainer EVENT_BEAT_BRUNOS_ROOM_TRAINER_4, 0, BrunoBeforeBattleText_RP_Pink, BrunoEndBattleText_RP_Pink, BrunoAfterBattleText_RP_Pink
	db -1 ; end

BrunoText1:
	text_asm
; new, check if we beat League rematch AND at least one Sevii Sage
	CheckEvent EVENT_BEAT_CHAMPION_FINAL_REMATCH
	jr z, .firstRematch
	CheckEvent EVENT_SEVII_BEAT_AT_LEAST_ONE_SHRINE_SAGE
	ld hl, BrunosRoomTrainerHeader2
	jr z, .firstRematch
	call TalkToTrainer
	ld a, 3
	ld [wTrainerNo], a
	jp TextScriptEnd
.firstRematch ; new, check if we beat all gyms leaders in their gym rematches
	ld hl, BrunosRoomTrainerHeader1
	CheckEvent EVENT_BEAT_ALL_GYMS_REMATCH
	jr z, .notRematch
	call TalkToTrainer
	ld a, 2
	ld [wTrainerNo], a
	jp TextScriptEnd
.notRematch
; end rematches check
	ld hl, BrunosRoomTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

BrunoBeforeBattleText:
	text_far _BrunoBeforeBattleText
	text_end

BrunoEndBattleText:
	text_far _BrunoEndBattleText
	text_end

BrunoAfterBattleText:
	text_far _BrunoAfterBattleText
	text_end

BrunoDontRunAwayText:
	text_far _BrunoDontRunAwayText
	text_end

; new -------------------------------

BrunoBeforeBattleTextRematch:
	text_far _BrunoBeforeBattleTextRematch
	text_end

BrunoEndBattleTextRematch:
	text_far _BrunoEndBattleTextRematch
	text_end

BrunoAfterBattleTextRematch:
	text_far _BrunoAfterBattleTextRematch
	text_end

BrunoBeforeBattleTextRematch2:
	text_far _BrunoBeforeBattleTextRematch2
	text_end

BrunoEndBattleTextRematch2:
	text_far _BrunoEndBattleTextRematch2
	text_end

BrunoAfterBattleTextRematch2:
	text_far _BrunoAfterBattleTextRematch2
	text_end

; new for RP =======================

BrunoText1_RP:
	text_asm
	SetEvent EVENT_RP_USE_VANILLA_BATTLE_MESSAGES
	CheckEvent EVENT_RP_BEAT_PINK_SIX_ISLAND
	jr nz, .championPink
; pre-Giovanni death
	ld hl, BrunosRoomTrainerHeader3
	call TalkToTrainer
	ld a, 4
	jr .gotTrainerNumber
.championPink
	ld hl, BrunosRoomTrainerHeader4
	call TalkToTrainer
	ld a, 3
.gotTrainerNumber
	ld [wTrainerNo], a
	jp TextScriptEnd

BrunoBeforeBattleText_RP:
	text_far _BrunoBeforeBattleText_RP
	text_end

BrunoEndBattleText_RP:
	text_far _BrunoEndBattleText_RP
	text_end

BrunoAfterBattleText_RP:
	text_far _BrunoAfterBattleText_RP
	text_end

BrunoBeforeBattleText_RP_Pink:
	text_far _BrunoBeforeBattleText_RP_Pink
	text_end

BrunoEndBattleText_RP_Pink:
	text_far _BrunoEndBattleText_RP_Pink
	text_end

BrunoAfterBattleText_RP_Pink:
	text_far _BrunoAfterBattleText_RP_Pink
	text_end

BrunoScript5:
	ld a, $1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; kill Bruno
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
	ld a, HS_BRUNOS_ROOM_BRUNO
	ld [wMissableObjectIndex], a
	predef HideObject
	call UpdateSprites
    ld c, 100
    call DelayFrames
    call GBFadeInFromBlack
	SetEvent EVENT_RP_ELIMINATED_BRUNO
	jp ResetBrunoScript
