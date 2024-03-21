BrunosRoom_Script:
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
	CheckEitherEventSet EVENT_BEAT_BRUNOS_ROOM_TRAINER_0, EVENT_BEAT_BRUNOS_ROOM_TRAINER_1 ; edited
	jr z, .blockExitToNextRoom
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
	ret

BrunosRoom_ScriptPointers:
	dw BrunoScript0
	dw DisplayEnemyTrainerTextAndStartBattle
	dw BrunoScript2
	dw BrunoScript3
	dw BrunoScript4

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
	ld a, $1
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID

BrunosRoom_TextPointers:
	dw BrunoText1
	dw BrunoDontRunAwayText

BrunosRoomTrainerHeaders:
	def_trainers
BrunosRoomTrainerHeader0:
	trainer EVENT_BEAT_BRUNOS_ROOM_TRAINER_0, 0, BrunoBeforeBattleText, BrunoEndBattleText, BrunoAfterBattleText
BrunosRoomTrainerHeader1:
	trainer EVENT_BEAT_BRUNOS_ROOM_TRAINER_1, 0, BrunoBeforeBattleTextRematch, BrunoEndBattleTextRematch, BrunoAfterBattleTextRematch
	db -1 ; end

BrunoText1:
	text_asm
; new, check if we beat all gyms leaders in their gym rematches
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
