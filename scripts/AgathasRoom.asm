AgathasRoom_Script:
	RPTextChooser AgathasRoom_TextPointers, AgathasRoom_TextPointers_Rocket
	call AgathaShowOrHideExitBlock
	call EnableAutoTextBoxDrawing
	ld hl, AgathasRoomTrainerHeaders
	ld de, AgathasRoom_ScriptPointers
	ld a, [wAgathasRoomCurScript]
	call ExecuteCurMapScriptInTable
	ld [wAgathasRoomCurScript], a
	ret

AgathaShowOrHideExitBlock:
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
	CheckEvent EVENT_RP_ELIMINATED_AGATHA
	jr z, .dontStopMusic
	call StopAllMusic
.dontStopMusic
; BTV
; new
	CheckEvent EVENT_BEAT_AGATHAS_ROOM_TRAINER_0
	jr nz, .freeExitToNextRoom
	CheckEvent EVENT_BEAT_AGATHAS_ROOM_TRAINER_1
	jr nz, .freeExitToNextRoom
	CheckEvent EVENT_BEAT_AGATHAS_ROOM_TRAINER_2
	jr nz, .freeExitToNextRoom
	CheckEvent EVENT_BEAT_AGATHAS_ROOM_TRAINER_3
	jr nz, .freeExitToNextRoom
	CheckEvent EVENT_BEAT_AGATHAS_ROOM_TRAINER_4
; BTV
	jr z, .blockExitToNextRoom
.freeExitToNextRoom ; new
	ld a, $e
	jp .setExitBlock
.blockExitToNextRoom
	ld a, $3b
.setExitBlock
	ld [wNewTileBlockID], a
	lb bc, 0, 2
	predef_jump ReplaceTileBlock

ResetAgathaScript:
	xor a
	ld [wAgathasRoomCurScript], a
	ld [wCurMapScript], a ; new, maybe unnecessary
	ret

AgathasRoom_ScriptPointers:
	dw AgathaScript0
	dw DisplayEnemyTrainerTextAndStartBattle
	dw AgathaScript2
	dw AgathaScript3
	dw AgathaScript4
	; new for RP
	dw AgathaScript5

AgathaScript4:
	ret

AgathaScriptWalkIntoRoom:
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
	ld [wAgathasRoomCurScript], a
	ld [wCurMapScript], a
	ret

AgathaScript0:
	ld hl, AgathaEntranceCoords
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
	CheckAndSetEvent EVENT_AUTOWALKED_INTO_AGATHAS_ROOM
	jr z, AgathaScriptWalkIntoRoom
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
	ld [wAgathasRoomCurScript], a
	ld [wCurMapScript], a
	ret

AgathaEntranceCoords:
	dbmapcoord  4, 10
	dbmapcoord  5, 10
	dbmapcoord  4, 11
	dbmapcoord  5, 11
	db -1 ; end

AgathaScript3:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	xor a
	ld [wJoyIgnore], a
	ld [wAgathasRoomCurScript], a
	ld [wCurMapScript], a
	ret

AgathaScript2:
	call EndTrainerBattle
	ld a, [wIsInBattle]
	cp $ff
	jp z, ResetAgathaScript
; we won
	CheckEvent EVENT_RP_BEAT_PINK_SIX_ISLAND
	jr z, .notChampionPink
; champion Pink
	ld a, 5
	ld [wAgathasRoomCurScript], a
	ld [wCurMapScript], a
	ret
.notChampionPink
	ld a, $1
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID

AgathasRoom_TextPointers:
	dw AgathaText1
	dw AgathaDontRunAwayText

AgathasRoom_TextPointers_Rocket:
	dw AgathaText1_RP
	dw AgathaDontRunAwayText

AgathasRoomTrainerHeaders:
	def_trainers
AgathasRoomTrainerHeader0:
	trainer EVENT_BEAT_AGATHAS_ROOM_TRAINER_0, 0, AgathaBeforeBattleText, AgathaEndBattleText, AgathaAfterBattleText
AgathasRoomTrainerHeader1:
	trainer EVENT_BEAT_AGATHAS_ROOM_TRAINER_1, 0, AgathaBeforeBattleTextRematch, AgathaEndBattleTextRematch, AgathaAfterBattleTextRematch
AgathasRoomTrainerHeader2:
	trainer EVENT_BEAT_AGATHAS_ROOM_TRAINER_2, 0, AgathaBeforeBattleTextRematch2, AgathaEndBattleTextRematch2, AgathaAfterBattleTextRematch2
AgathasRoomTrainerHeader3:
	trainer EVENT_BEAT_AGATHAS_ROOM_TRAINER_3, 0, AgathaBeforeBattleText_RP, AgathaEndBattleText_RP, AgathaAfterBattleText_RP
AgathasRoomTrainerHeader4:
	trainer EVENT_BEAT_AGATHAS_ROOM_TRAINER_4, 0, AgathaBeforeBattleText_RP_Pink, AgathaEndBattleText_RP_Pink, AgathaAfterBattleText_RP_Pink
	db -1 ; end

AgathaText1:
	text_asm
; new, check if we beat League rematch AND at least one Sevii Sage
	CheckEvent EVENT_BEAT_CHAMPION_FINAL_REMATCH
	jr z, .firstRematch
	CheckEvent EVENT_SEVII_BEAT_AT_LEAST_ONE_SHRINE_SAGE
	ld hl, AgathasRoomTrainerHeader2
	jr z, .firstRematch
	call TalkToTrainer
	ld a, 3
	ld [wTrainerNo], a
	jp TextScriptEnd
.firstRematch ; new, check if we beat all gyms leaders in their gym rematches
	ld hl, AgathasRoomTrainerHeader1
	CheckEvent EVENT_BEAT_ALL_GYMS_REMATCH
	jr z, .notRematch
	call TalkToTrainer
	ld a, 2
	ld [wTrainerNo], a
	jp TextScriptEnd
.notRematch
; end rematches check
	ld hl, AgathasRoomTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

AgathaBeforeBattleText:
	text_far _AgathaBeforeBattleText
	text_end

AgathaEndBattleText:
	text_far _AgathaEndBattleText
	text_end

AgathaAfterBattleText:
	text_far _AgathaAfterBattleText
	text_end

AgathaDontRunAwayText:
	text_far _AgathaDontRunAwayText
	text_end

; new -------------------------------

AgathaBeforeBattleTextRematch:
	text_far _AgathaBeforeBattleTextRematch
	text_end

AgathaEndBattleTextRematch:
	text_far _AgathaEndBattleTextRematch
	text_end

AgathaAfterBattleTextRematch:
	text_far _AgathaAfterBattleTextRematch
	text_end

AgathaBeforeBattleTextRematch2:
	text_far _AgathaBeforeBattleTextRematch2
	text_end

AgathaEndBattleTextRematch2:
	text_far _AgathaEndBattleTextRematch2
	text_end

AgathaAfterBattleTextRematch2:
	text_far _AgathaAfterBattleTextRematch2
	text_end

; new for RP =======================

AgathaText1_RP:
	text_asm
	SetEvent EVENT_RP_USE_VANILLA_BATTLE_MESSAGES
	CheckEvent EVENT_RP_BEAT_PINK_SIX_ISLAND
	jr nz, .championPink
; pre-Giovanni death
	ld hl, AgathasRoomTrainerHeader3
	call TalkToTrainer
	ld a, 4
	jr .gotTrainerNumber
.championPink
	ld hl, AgathasRoomTrainerHeader4
	call TalkToTrainer
	ld a, 3
.gotTrainerNumber
	ld [wTrainerNo], a
	jp TextScriptEnd

AgathaBeforeBattleText_RP:
	text_far _AgathaBeforeBattleText_RP
	text_end

AgathaEndBattleText_RP:
	text_far _AgathaEndBattleText_RP
	text_end

AgathaAfterBattleText_RP:
	text_far _AgathaAfterBattleText_RP
	text_end

AgathaBeforeBattleText_RP_Pink:
	text_far _AgathaBeforeBattleText_RP_Pink
	text_end

AgathaEndBattleText_RP_Pink:
	text_far _AgathaEndBattleText_RP_Pink
	text_end

AgathaAfterBattleText_RP_Pink:
	text_far _AgathaAfterBattleText_RP_Pink
	text_end

AgathaScript5:
	ld a, $1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; kill Agatha
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
	ld a, HS_AGATHAS_ROOM_AGATHA
	ld [wMissableObjectIndex], a
	predef HideObject
	call UpdateSprites
    ld c, 100
    call DelayFrames
    call GBFadeInFromBlack
	SetEvent EVENT_RP_ELIMINATED_AGATHA
	jp ResetAgathaScript
