HallOfFame_Script:
	call EnableAutoTextBoxDrawing
	ld hl, HallOfFame_ScriptPointers
	ld a, [wHallOfFameCurScript]
	jp CallFunctionInTable

HallofFameRoomScript_5a4aa:
	xor a
	ld [wJoyIgnore], a
	ld [wHallOfFameCurScript], a
	ret

HallOfFame_ScriptPointers:
	dw HallofFameRoomScript0
	dw HallofFameRoomScript1
	dw HallofFameRoomScript2
	dw HallofFameRoomScript3

HallofFameRoomScript3:
	ret

HallofFameRoomScript2:
	call Delay3
	ld a, [wLetterPrintingDelayFlags]
	push af
	xor a
	ld [wJoyIgnore], a
	predef HallOfFamePC
	pop af
	ld [wLetterPrintingDelayFlags], a
	ld hl, wFlags_D733
	res 1, [hl]
	inc hl
	set 0, [hl]
	xor a
	ld hl, wLoreleisRoomCurScript
	ld [hli], a ; wLoreleisRoomCurScript
	ld [hli], a ; wBrunosRoomCurScript
	ld [hl], a ; wAgathasRoomCurScript
	ld [wLancesRoomCurScript], a
	ld [wHallOfFameCurScript], a
	; Elite 4 events
	ResetEventRange INDIGO_PLATEAU_EVENTS_START, INDIGO_PLATEAU_EVENTS_END, 1
	xor a
	ld [wHallOfFameCurScript], a
	ld a, PALLET_TOWN
	ld [wLastBlackoutMap], a
	farcall SaveSAVtoSRAM
	ld b, 5
.delayLoop
	ld c, 600 / 5
	call DelayFrames
	dec b
	jr nz, .delayLoop
	call WaitForTextScrollButtonPress
	jp Init

HallofFameRoomScript0:
	ld a, $ff
	ld [wJoyIgnore], a
	ld hl, wSimulatedJoypadStatesEnd
	ld de, RLEMovement5a528
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
	ld a, $1
	ld [wHallOfFameCurScript], a
	ret

RLEMovement5a528:
	db D_UP, 5
	db -1 ; end

HallofFameRoomScript1:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	ld a, PLAYER_DIR_RIGHT
	ld [wPlayerMovingDirection], a
	ld a, $1
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, SPRITE_FACING_LEFT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	call Delay3
	xor a
	ld [wJoyIgnore], a
	inc a ; PLAYER_DIR_RIGHT
	ld [wPlayerMovingDirection], a
	ld a, $1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $ff
	ld [wJoyIgnore], a

	; new code for HS and to set the event that we beat the game at least once
	call LoopHide
	call LoopShow
	call LoopShowExtra
	SetEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE ; new

	; back to vanilla code
	ld a, $2
	ld [wHallOfFameCurScript], a
	ret

HallOfFame_TextPointers:
	dw HallofFameRoomText1

HallofFameRoomText1:
	text_far _HallofFameRoomText1
	text_end

; ----- new HS compat functions -----

LoopHide:
	ld hl, ObjectsToHide
.hideLoop
	ld a, [hli]
	cp $ff
	ret z
	push hl
	ld [wMissableObjectIndex], a
	predef HideObject
	pop hl
	jr .hideLoop

ObjectsToHide:
	db HS_CERULEAN_CAVE_GUY
	db HS_VERMILION_MACHOKE
	db $ff

LoopShow:
	ld hl, ObjectsToShow
.hideLoop
	ld a, [hli]
	cp $ff
	ret z
	push hl
	ld [wMissableObjectIndex], a
	predef ShowObject
	pop hl
	jr .hideLoop

ObjectsToShow:
	db HS_ROUTE_21_OAK
	db HS_VIRIDIAN_FOREST_ERIKA
	db HS_FIGHTING_DOJO_BRUNO
	db HS_ROCK_TUNNEL_B1F_BROCK
	db HS_POKEMON_TOWER_6F_AGATHA
	db HS_VERMILION_MACHAMP
	db HS_ROUTE_20_MISTY
	db HS_POWER_PLANT_LT_SURGE
	db HS_VICTORY_ROAD_2F_KOGA
	db HS_CERULEAN_CAVE_EXTRA_MIDDLE_LANCE
	db HS_MOLTRES
	db HS_ZAPDOS
	db $ff

LoopShowExtra:
	ld hl, ObjectsToShowExtra
.hideLoop
	ld a, [hli]
	cp $ff
	ret z
	push hl
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	pop hl
	jr .hideLoop

ObjectsToShowExtra:
	db HS_SAFARI_ZONE_NORTH_GIOVANNI
	db HS_SEAFOAM_ISLANDS_B4F_LORELEI
	db HS_MR_PSYCHIC_SABRINA
	db HS_POKEMON_MANSION_2F_BLAINE
	db HS_MEWTWO
	db HS_ARTICUNO
	db $ff
