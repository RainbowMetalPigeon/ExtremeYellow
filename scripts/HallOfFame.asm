HallOfFame_Script:
	call EnableAutoTextBoxDrawing
	ld hl, HallOfFame_ScriptPointers
	ld a, [wHallOfFameCurScript]
	jp CallFunctionInTable

;HallofFameRoomScript_5a4aa: ; is this even for anything?
;	xor a
;	ld [wJoyIgnore], a
;	ld [wHallOfFameCurScript], a
;	ret

HallOfFame_ScriptPointers:
	dw HallofFameRoomScript0
	dw HallofFameRoomScript1
	dw HallofFameRoomScript2
	dw HallofFameRoomScript3
	dw HallofFameRoomScript4
	dw HallofFameRoomScript5
	dw HallofFameRoomScript6

; ==================================

;HallofFameRoomScript3: ; is this even ever used?
;	ret

HoFScript_f0JoyIgnoreDisplayTextffJoyIgnore:
	ld a, $f0
	ld [wJoyIgnore], a
	call DisplayTextID
	ld a, $ff
	ld [wJoyIgnore], a
	ret

; ==================================

HallofFameRoomScript0: ; makes player walk up to Rival and Oak
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
	db D_UP, 4 ; edited, was 5, stop before Rival
	db -1 ; end

; ==================================

HallofFameRoomScript1:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
; player faces right
	ld a, PLAYER_DIR_RIGHT
	ld [wPlayerMovingDirection], a
; Oak faces left
;	ld a, $1
;	ldh [hSpriteIndex], a
;	call SetSpriteMovementBytesToFF
;	ld a, SPRITE_FACING_LEFT
;	ldh [hSpriteFacingDirection], a
;	call SetSpriteFacingDirectionAndDelay

	ld a, $2
	ld [wSprite01StateData1MovementStatus], a
	ld a, SPRITE_FACING_LEFT
	ld [wSprite01StateData1FacingDirection], a
; Rival faces right
;	ld a, $2
;	ldh [hSpriteIndex], a
;	call SetSpriteMovementBytesToFF
;	ld a, SPRITE_FACING_RIGHT
;	ldh [hSpriteFacingDirection], a
;	call SetSpriteFacingDirectionAndDelay

	ld a, $2
	ld [wSprite02StateData1MovementStatus], a
	ld a, SPRITE_FACING_RIGHT
	ld [wSprite02StateData1FacingDirection], a
; delay
	call Delay3
; Oak talks
	ld a, $1
	ldh [hSpriteIndexOrTextID], a
	call HoFScript_f0JoyIgnoreDisplayTextffJoyIgnore
; Rival faces up
;	ld a, $2
;	ldh [hSpriteIndex], a
;	call SetSpriteMovementBytesToFF
;	ld a, SPRITE_FACING_UP
;	ldh [hSpriteFacingDirection], a
;	call SetSpriteFacingDirectionAndDelay

	ld a, $2
	ld [wSprite02StateData1MovementStatus], a
	ld a, SPRITE_FACING_UP
	ld [wSprite02StateData1FacingDirection], a
; player faces up
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a
; Oak faces left (should be redundant but maybe is not?)
;	ld a, $1
;	ldh [hSpriteIndex], a
;	call SetSpriteMovementBytesToFF
;	ld a, SPRITE_FACING_LEFT
;	ldh [hSpriteFacingDirection], a
;	call SetSpriteFacingDirectionAndDelay

	ld a, $2
	ld [wSprite01StateData1MovementStatus], a
	ld a, SPRITE_FACING_LEFT
	ld [wSprite01StateData1FacingDirection], a
; new code for HS and to re/set the event that we beat the game at least once
	call LoopHide
	call LoopShow
	call LoopShowExtra
	CheckEvent EVENT_PLACED_ALL_ORBS_IN_RECESSES
	jr z, .dontShowLegendaryBirbs
	ld a, HS_ARTICUNO
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld a, HS_ZAPDOS
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld a, HS_MOLTRES
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
.dontShowLegendaryBirbs
	SetEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE
;	SetEvent EVENT_BEAT_INTERDIMENSIONAL_TRAVELER ; temp, testing, will be modified
;	SetEvent EVENT_BEAT_ALL_GYMS_REMATCH ; temp, testing, will be modified
; let's also heal the party, why not
	predef HealParty
; load next script
	ld a, $2
	ld [wHallOfFameCurScript], a
	ret

; ==================================

HallofFameRoomScript2:
; is this to let time for the player movement to happen? So unnecessary now?
;	ld a, [wSimulatedJoypadStatesIndex]
;	and a
;	ret nz
; wait a moment for Rival to load their team
	ld c, 120 ; testing
	call DelayFrames
; delay
	call Delay3
; Oaks talk
	ld a, $4
	ldh [hSpriteIndexOrTextID], a
	call HoFScript_f0JoyIgnoreDisplayTextffJoyIgnore
; load next script
	ld a, $3
	ld [wHallOfFameCurScript], a
	ret

; ==================================

HallofFameRoomScript3:
; preare Rival for movement?
	ld a, $2
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
; Rival walks left to leave you space
	ld de, RivalLeavesYouSpaceMovement
	ld a, $2
	ldh [hSpriteIndex], a
	call MoveSprite
; load next script
	ld a, $4
	ld [wHallOfFameCurScript], a
	ret

RivalLeavesYouSpaceMovement:
	db NPC_MOVEMENT_LEFT
	db -1 ; end

; ==================================

HallofFameRoomScript4:
; this is to leave time for the NPC movement to happen!
	ld a, [wd730]
	bit 0, a
	ret nz
; Rival faces right
;	ld a, $2
;	ldh [hSpriteIndex], a
;	call SetSpriteMovementBytesToFF
;	ld a, SPRITE_FACING_RIGHT
;	ldh [hSpriteFacingDirection], a
;	call SetSpriteFacingDirectionAndDelay

	ld a, $2
	ld [wSprite02StateData1MovementStatus], a
	ld a, SPRITE_FACING_RIGHT
	ld [wSprite02StateData1FacingDirection], a
; delay
	ld c, 20 ; testing
	call DelayFrames
; player walks up one step
	ld a, $ff
	ld [wJoyIgnore], a
	ld hl, wSimulatedJoypadStatesEnd
	ld de, WalkToHallOfFameConsole_RLEMovment
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
; load next script
	ld a, $5
	ld [wHallOfFameCurScript], a
	ret

WalkToHallOfFameConsole_RLEMovment:
	db D_UP, 1
	db -1 ; end

; ==================================

HallofFameRoomScript5:
; this is to leave time for the player movement to happen!
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
; delay
	call Delay3
; Oaks talk
	ld a, $3
	ldh [hSpriteIndexOrTextID], a
	call HoFScript_f0JoyIgnoreDisplayTextffJoyIgnore
; delay lol
	call Delay3
; non-moving step of player?
	xor a
	ld [wJoyIgnore], a
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a
; load next script
	ld a, $6
	ld [wHallOfFameCurScript], a
	ret

; ==================================

HallofFameRoomScript6:
	call Delay3
	ld a, [wLetterPrintingDelayFlags]
	push af
	xor a
	ld [wJoyIgnore], a
	predef HallOfFamePC ; this, in credits.asm, callfars AnimateHallOfFame, which is in movie/hall_of_fame.asm
	                    ; and after showing the part, it call(far)s SaveHallOfFameTeams which is in save.asm
						; also (???), it calls AnimateHallOfFame, which jumps to HoFRecordMonInfo, which saves level, species, and nickname
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

HallOfFame_TextPointers:
	dw HallofFameRoomText1
	dw HallofFameRoomText2 ; just a proxy to avoid issues with indexing
	dw HallofFameRoomText3
	dw HallofFameRoomText4

HallofFameRoomText1:
	text_asm
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE
	jr nz, .postGame
	ld hl, HallofFameRoomText1_Oak
	call PrintText
	ld hl, HallofFameRoomText1_Rival
	call PrintText
	jr .donePrinting
.postGame
	ld hl, HallofFameRoomText1_PG_Oak
	call PrintText
.donePrinting
	jp TextScriptEnd

HallofFameRoomText1_Oak:
	text_far _HallofFameRoomText1_Oak
	text_end

HallofFameRoomText1_Rival:
	text_far _HallofFameRoomText1_Rival
	text_end

HallofFameRoomText1_PG_Oak:
	text_far _HallofFameRoomText1_PG_Oak
	text_end

; -------------

HallofFameRoomText2: ; silly proxy
	text_far _HallofFameRoomText2
	text_end

; -------------

HallofFameRoomText3: ; fourth dialogue, screw logic lol
	text_far _HallofFameRoomText3
	text_end

; -------------

HallofFameRoomText4: ; third dialogue
	text_far _HallofFameRoomText4
	text_end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

; ---------------

LoopShow:
	ld hl, ObjectsToShow
.showLoop
	ld a, [hli]
	cp $ff
	ret z
	push hl
	ld [wMissableObjectIndex], a
	predef ShowObject
	pop hl
	jr .showLoop

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
	db HS_OBSIDIAN_WOOD_ORAGE
	db HS_PALLET_TOWN_DARK_GUIDE
	db $ff

; ---------------

LoopShowExtra:
	ld hl, ObjectsToShowExtra
.showExtraLoop
	ld a, [hli]
	cp $ff
	ret z
	push hl
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	pop hl
	jr .showExtraLoop

ObjectsToShowExtra:
	db HS_SAFARI_ZONE_NORTH_GIOVANNI
	db HS_SEAFOAM_ISLANDS_B4F_LORELEI
	db HS_MR_PSYCHIC_SABRINA
	db HS_POKEMON_MANSION_2F_BLAINE
	db HS_MEWTWO
	db HS_OCHRE_WONDERLAND_RIVAL
	db HS_CHAMPIONS_ROOM_RIVAL ; new, here to re-show Rival after we hid them when walking towards HoF
	db HS_ONIX_BURROWING_SNORLAX_DEN
	db HS_CERULEAN_CAVE_EXTRA_MIDDLE_LANCE
	db HS_LUNAR_SHRINE_TOURIST_2
	db HS_CELADON_HOTEL_ROOMS_TROPHY_1
	db $ff
