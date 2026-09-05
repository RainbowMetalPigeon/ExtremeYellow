HallOfFame_Script:
	RPTextChooser HallOfFame_TextPointers, HallOfFame_TextPointers_Rocket
	call EnableAutoTextBoxDrawing
	ld hl, HallOfFame_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

;HallofFameRoomScript_5a4aa: ; is this even for anything?
;	xor a
;	ld [wJoyIgnore], a
;	ld [wCurMapScript], a
;	ret

HallOfFame_ScriptPointers:
	dw HallofFameRoomScript0
	dw HallofFameRoomScript1
	dw HallofFameRoomScript2
	dw HallofFameRoomScript3
	dw HallofFameRoomScript4
	dw HallofFameRoomScript5
	dw HallofFameRoomScript6
	; new for RP
	dw HallofFameRoomScript1_RP ; 7
	dw HallofFameRoomScript2_RP ; 8
	dw HallofFameRoomScript3_RP ; 9
	dw HallofFameRoomScript4_RP ; 10

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
; new for RP
	CheckEvent EVENT_ROCKET_PATH
	jr z, .notRP
	ld a, $ff
	ld [wJoyIgnore], a
	ld hl, wSimulatedJoypadStatesEnd
	ld de, RLEMovement_TillPC
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
	ld a, 7
	ld [wCurMapScript], a
	ret
.notRP
; BTV
	ld a, $ff
	ld [wJoyIgnore], a
	ld hl, wSimulatedJoypadStatesEnd
	ld de, RLEMovement_OneBeforePC
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
	ld a, $1
	ld [wCurMapScript], a
	ret

RLEMovement_TillPC: ; new for RP
	db D_UP, 1
RLEMovement_OneBeforePC:
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
	ld a, $1
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, SPRITE_FACING_LEFT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay

	ld a, $2
	ld [wSprite01StateData1MovementStatus], a
	ld a, SPRITE_FACING_LEFT
	ld [wSprite01StateData1FacingDirection], a
; Rival faces right
	ld a, $2
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, SPRITE_FACING_RIGHT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay

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
	ld a, $2
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, SPRITE_FACING_UP
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay

	ld a, $2
	ld [wSprite02StateData1MovementStatus], a
	ld a, SPRITE_FACING_UP
	ld [wSprite02StateData1FacingDirection], a
; player faces up
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a
; Oak faces left (should be redundant but maybe is not?)
	ld a, $1
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, SPRITE_FACING_LEFT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay

	ld a, $2
	ld [wSprite01StateData1MovementStatus], a
	ld a, SPRITE_FACING_LEFT
	ld [wSprite01StateData1FacingDirection], a
; new code for HS and to re/set the event that we beat the game at least once
	call LoopHide
	call LoopHideExtra
	call LoopShow
	call LoopShowExtra
	call LoopShowSevii
	ResetEvent EVENT_BEAT_MEWTWO
; re-spawn the birds only if we spawn them the first time
	CheckEvent EVENT_PLACED_ALL_ORBS_IN_RECESSES
	jr z, .dontShowLegendaryBirbs
	ld a, HS_ARTICUNO
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ResetEvent EVENT_BEAT_ARTICUNO
	ld a, HS_ZAPDOS
	ld [wMissableObjectIndex], a
	predef ShowObject
	ResetEvent EVENT_BEAT_ZAPDOS
	ld a, HS_MOLTRES
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ResetEvent EVENT_BEAT_MOLTRES
.dontShowLegendaryBirbs
	SetEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE
; let's also heal the party, why not
	predef HealParty
; load next script
	ld a, $2
	ld [wCurMapScript], a
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
	ld [wCurMapScript], a
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
	ld [wCurMapScript], a
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
; Oak faces left
	ld a, $1
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, SPRITE_FACING_LEFT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay

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
	ld [wCurMapScript], a
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
	ld [wCurMapScript], a
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
	ld hl, wLoreleisRoomCurScript ; TBE (?)
	ld [hli], a ; wLoreleisRoomCurScript
	ld [hli], a ; wBrunosRoomCurScript
	ld [hl], a ; wAgathasRoomCurScript
	ld [wLancesRoomCurScript], a
	ld [wCurMapScript], a
	; Elite 4 events
	ResetEventRange INDIGO_PLATEAU_EVENTS_START, INDIGO_PLATEAU_EVENTS_END, 1
;	xor a ; useless
;	ld [wCurMapScript], a ; useless, done above
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
	; scripts
	dw HallofFameRoomText3
	dw HallofFameRoomText4

HallOfFame_TextPointers_Rocket:
	dw HallofFameRoomText1_RP
	dw HallofFameRoomText2 ; unused
	; scripts
	dw HallofFameRoomTextScript1_RP ; 3

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

LoopHideExtra:
	ld hl, ObjectsToHideExtra
.hideExtraLoop
	ld a, [hli]
	cp $ff
	ret z
	push hl
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	pop hl
	jr .hideExtraLoop

ObjectsToHideExtra:
	db HS_SAFARI_ZONE_NORTH_GUARD_1
	db HS_SAFARI_ZONE_NORTH_GUARD_2
	db HS_VIRIDIAN_GYM_GUIDE_PRE_LEAGUE
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
;	db HS_ROUTE_21_OAK
	db HS_VIRIDIAN_FOREST_ERIKA
	db HS_FIGHTING_DOJO_BRUNO
	db HS_ROCK_TUNNEL_B1F_BROCK
	db HS_POKEMON_TOWER_6F_AGATHA
	db HS_VERMILION_MACHAMP
	db HS_ROUTE_20_MISTY
	db HS_POWER_PLANT_LT_SURGE
	db HS_VICTORY_ROAD_2F_KOGA
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
	db HS_OBSIDIAN_WOOD_ORAGE
	db HS_VIRIDIAN_GYM_GUIDE_POST_LEAGUE
	db $ff

; ---------------

LoopShowSevii:
	ld hl, ObjectsToShowSevii
.showExtraLoop
	ld a, [hli]
	cp $ff
	ret z
	push hl
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	pop hl
	jr .showExtraLoop

ObjectsToShowSevii:
	db HS_SEVII_FOUR_ISLAND_CITY_POST_LEAGUE_PINK
	db $ff

; new for RP ===========================================

HallofFameRoomScript1_RP:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
; player faces right
	ld a, PLAYER_DIR_RIGHT
	ld [wPlayerMovingDirection], a
; Oak faces left
	call HoFOakFaceLeft
; delay
	call Delay3
; Oak talks
	ld a, 1
	ldh [hSpriteIndexOrTextID], a
	call HoFScript_f0JoyIgnoreDisplayTextffJoyIgnore
; set up battle
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_PROF_OAK
	ld [wCurOpponent], a
	ld a, 2
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, HoFOakDefeatText
	ld de, HoFOakWonText
	call SaveEndBattleTextPointers
	SetEvent EVENT_RP_USE_VANILLA_BATTLE_MESSAGES
; load next script
	ld a, 8
	ld [wCurMapScript], a
	ret

HallofFameRoomScript2_RP:
	ld a, [wIsInBattle]
	cp $ff
	jp z, HoFResetScripts
; we won
	ld a, $f0
	ld [wJoyIgnore], a
	call HoFOakFaceLeft
; Oak dialogue
	ld a, 3
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; Kill Oak
    call GBFadeOutToWhite
    ld c, 10
    call DelayFrames
    call GBFadeOutToBlack
	call StopMusic
    ld c, 100
    call DelayFrames
	ld c, BANK(SFX_Push_Boulder_1) ; SFX_Push_Boulder_1 ; SFX_Collision_1
	ld a, SFX_PUSH_BOULDER ; SFX_PUSH_BOULDER ; SFX_COLLISION
	call PlayMusic
	ld a, HS_HALL_OF_FAME_OAK
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	call UpdateSprites
    ld c, 150
    call DelayFrames
    call GBFadeInFromBlack
; player faces up
	ld a, SPRITE_FACING_UP
	ld [wSpritePlayerStateData1FacingDirection], a
; load next script
	ld a, 9
	ld [wCurMapScript], a
	ret

HallofFameRoomText1_RP:
	text_far _HallofFameRoomText1_RP
	text_end

HoFOakDefeatText:
	text_far _HoFOakDefeatText
	text_end

HoFOakWonText:
	text_far _HoFOakWonText
	text_end

HallofFameRoomTextScript1_RP:
	text_far _HallofFameRoomTextScript1_RP
	text_end

HallofFameRoomScript3_RP:
; player faces up
	ld a, SPRITE_FACING_UP
	ld [wSpritePlayerStateData1FacingDirection], a
	call Delay3
; load next script
	ld a, 10
	ld [wCurMapScript], a
	ret

HallofFameRoomScript4_RP:
; TBE: appropriate hide/show

; HoF PC
    ld c, 120
    call DelayFrames
	callfar AnimateHallOfFame
	call ClearScreen
	ld c, 100
	call DelayFrames
	
; reset INDIGO events
	ResetEventRange INDIGO_PLATEAU_EVENTS_START, INDIGO_PLATEAU_EVENTS_END, 1

; warp player back to entrance of Indigo League
	ld a, SPRITE_FACING_UP
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, INDIGO_PLATEAU
	ldh [hWarpDestinationMap], a
	ld a, 0 ; -1 wrt the normal numbering
	ld [wDestinationWarpID], a
	ld a, INDIGO_PLATEAU
	ld [wLastMap], a
	xor a
	ld [wIsInBattle], a
	ld hl, wd72d
	set 3, [hl] ; do scripted warp
	call PlayDefaultMusic
	; fallthrough

HoFResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

HoFOakFaceLeft:
	ld a, $1
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, SPRITE_FACING_LEFT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	ld a, $2
	ld [wSprite01StateData1MovementStatus], a
	ld a, SPRITE_FACING_LEFT
	ld [wSprite01StateData1FacingDirection], a
	ret







/*

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
	ld hl, wLoreleisRoomCurScript ; TBE (?)
	ld [hli], a ; wLoreleisRoomCurScript
	ld [hli], a ; wBrunosRoomCurScript
	ld [hl], a ; wAgathasRoomCurScript
	ld [wLancesRoomCurScript], a
	ld [wCurMapScript], a
	; Elite 4 events
	ResetEventRange INDIGO_PLATEAU_EVENTS_START, INDIGO_PLATEAU_EVENTS_END, 1
;	xor a ; useless
;	ld [wCurMapScript], a ; useless, done above
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

*/








/*

	ld a, $2
	ld [wSprite02StateData1MovementStatus], a
	ld a, SPRITE_FACING_UP
	ld [wSprite02StateData1FacingDirection], a
; player faces up
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a
; Oak faces left (should be redundant but maybe is not?)
	ld a, $1
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, SPRITE_FACING_LEFT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay

	ld a, $2
	ld [wSprite01StateData1MovementStatus], a
	ld a, SPRITE_FACING_LEFT
	ld [wSprite01StateData1FacingDirection], a
; new code for HS and to re/set the event that we beat the game at least once
	call LoopHide
	call LoopHideExtra
	call LoopShow
	call LoopShowExtra
	call LoopShowSevii
	ResetEvent EVENT_BEAT_MEWTWO
; re-spawn the birds only if we spawn them the first time
	CheckEvent EVENT_PLACED_ALL_ORBS_IN_RECESSES
	jr z, .dontShowLegendaryBirbs
	ld a, HS_ARTICUNO
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ResetEvent EVENT_BEAT_ARTICUNO
	ld a, HS_ZAPDOS
	ld [wMissableObjectIndex], a
	predef ShowObject
	ResetEvent EVENT_BEAT_ZAPDOS
	ld a, HS_MOLTRES
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ResetEvent EVENT_BEAT_MOLTRES
.dontShowLegendaryBirbs
	SetEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE
; let's also heal the party, why not
	predef HealParty
; load next script
	ld a, $2
	ld [wCurMapScript], a
	ret

*/
