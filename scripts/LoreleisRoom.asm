LoreleisRoom_Script:
	call LoreleiShowOrHideExitBlock
	call EnableAutoTextBoxDrawing
	ld hl, LoreleisRoomTrainerHeaders
	ld de, LoreleisRoom_ScriptPointers
	ld a, [wLoreleisRoomCurScript]
	call ExecuteCurMapScriptInTable
	ld [wLoreleisRoomCurScript], a
	ret

LoreleiShowOrHideExitBlock:
; Blocks or clears the exit to the next room.
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
	ld hl, wBeatLorelei
	set 1, [hl]
	CheckEitherEventSet EVENT_BEAT_LORELEIS_ROOM_TRAINER_0, EVENT_BEAT_LORELEIS_ROOM_TRAINER_1 ; edited
	jr z, .blockExitToNextRoom
	ld a, $5
	jr .setExitBlock
.blockExitToNextRoom
	ld a, $24
.setExitBlock
	ld [wNewTileBlockID], a
	lb bc, 0, 2
	predef_jump ReplaceTileBlock

ResetLoreleiScript:
	xor a
	ld [wLoreleisRoomCurScript], a
	ret

LoreleisRoom_ScriptPointers:
	dw LoreleiScript0
	dw DisplayEnemyTrainerTextAndStartBattle
	dw LoreleiScript2
	dw LoreleiScript3
	dw LoreleiScript4

LoreleiScript4:
	ret

LoreleiScriptWalkIntoRoom:
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
	ld [wLoreleisRoomCurScript], a
	ld [wCurMapScript], a
	ret

LoreleiScript0:
	ld hl, LoreleiEntranceCoords
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
	CheckAndSetEvent EVENT_AUTOWALKED_INTO_LORELEIS_ROOM
	jr z, LoreleiScriptWalkIntoRoom
.stopPlayerFromLeaving
	ld a, $2
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID  ; "Don't run away!"
	ld a, D_UP
	ld [wSimulatedJoypadStatesEnd], a
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
	ld a, $3
	ld [wLoreleisRoomCurScript], a
	ld [wCurMapScript], a
	ret

LoreleiEntranceCoords:
	dbmapcoord  4, 10
	dbmapcoord  5, 10
	dbmapcoord  4, 11
	dbmapcoord  5, 11
	db -1 ; end

LoreleiScript3:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	xor a
	ld [wJoyIgnore], a
	ld [wLoreleisRoomCurScript], a
	ld [wCurMapScript], a
	ret

LoreleiScript2:
	call EndTrainerBattle
	ld a, [wIsInBattle]
	cp $ff
	jp z, ResetLoreleiScript
	ld a, $1
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID

LoreleisRoom_TextPointers:
	dw LoreleiText1
	dw LoreleiDontRunAwayText

LoreleisRoomTrainerHeaders:
	def_trainers
LoreleisRoomTrainerHeader0:
	trainer EVENT_BEAT_LORELEIS_ROOM_TRAINER_0, 0, LoreleiBeforeBattleText, LoreleiEndBattleText, LoreleiAfterBattleText
LoreleisRoomTrainerHeader1:
	trainer EVENT_BEAT_LORELEIS_ROOM_TRAINER_1, 0, LoreleiBeforeBattleTextRematch, LoreleiEndBattleTextRematch, LoreleiAfterBattleTextRematch
	db -1 ; end

LoreleiText1: ; edited
	text_asm
	ld hl, LoreleisRoomTrainerHeader1
; new, ugly checks for all the gym leaders
	CheckEvent EVENT_BEAT_BROCK_REMATCH
	jr z, .notRematch
	CheckEvent EVENT_BEAT_MISTY_REMATCH
	jr z, .notRematch
	CheckEvent EVENT_BEAT_LT_SURGE_REMATCH
	jr z, .notRematch
	CheckEvent EVENT_BEAT_ERIKA_REMATCH
	jr z, .notRematch
	CheckEvent EVENT_BEAT_KOGA_REMATCH
	jr z, .notRematch
	CheckEvent EVENT_BEAT_SABRINA_REMATCH
	jr z, .notRematch
	CheckEvent EVENT_BEAT_BLAINE_REMATCH
	jr z, .notRematch
	ld a, 1
	ld [wTrainerNo], a
	call TalkToTrainer
	jp TextScriptEnd
.notRematch
	ld hl, LoreleisRoomTrainerHeader0
;	xor a
;	ld [wTrainerNo], a
	call TalkToTrainer
	jp TextScriptEnd

LoreleiBeforeBattleText:
	text_far _LoreleiBeforeBattleText
	text_end

LoreleiEndBattleText:
	text_far _LoreleiEndBattleText
	text_end

LoreleiAfterBattleText:
	text_far _LoreleiAfterBattleText
	text_end

LoreleiDontRunAwayText:
	text_far _LoreleiDontRunAwayText
	text_end

; new -------------------------------

LoreleiBeforeBattleTextRematch:
	text_far _LoreleiBeforeBattleTextRematch
	text_end

LoreleiEndBattleTextRematch:
	text_far _LoreleiEndBattleTextRematch
	text_end

LoreleiAfterBattleTextRematch:
	text_far _LoreleiAfterBattleTextRematch
	text_end
