SeviiFourIslandHouses_Script:
	call UndoDarkeningFromHazardRoom
	call EnableAutoTextBoxDrawing
	ld hl, SeviiFourIslandHouses_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

; scripts =========================================

UndoDarkeningFromHazardRoom:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
	xor a
	ld [wMapPalOffset], a
	ret

PinksHouseTurnEveryoneDown:
	lb bc, STAY, DOWN
	ld a, 1
	ldh [hSpriteIndex], a
	call ChangeSpriteMovementBytes
	lb bc, STAY, DOWN
	ld a, 2
	ldh [hSpriteIndex], a
	call ChangeSpriteMovementBytes
	lb bc, STAY, DOWN
	ld a, 3
	ldh [hSpriteIndex], a
	call ChangeSpriteMovementBytes
	lb bc, STAY, DOWN
	ld a, 4
	ldh [hSpriteIndex], a
	call ChangeSpriteMovementBytes
	lb de, 1, SPRITE_FACING_DOWN
	callfar ChangeSpriteFacing ; new Pigeon approach
	lb de, 2, SPRITE_FACING_DOWN
	callfar ChangeSpriteFacing
	lb de, 3, SPRITE_FACING_DOWN
	callfar ChangeSpriteFacing
	lb de, 4, SPRITE_FACING_DOWN
	jpfar ChangeSpriteFacing

SeviiFourIslandHouses_ScriptPointers:
	dw SeviiFourIslandHouses_Script0 ; 0
	dw SeviiFourIslandHouses_Script1 ; 1
	dw SeviiFourIslandHouses_Script2 ; 2
	dw SeviiFourIslandHouses_Script3 ; 3
	dw SeviiFourIslandHouses_Script4 ; 4
	dw SeviiFourIslandHouses_Script5 ; 5

SeviiFourIslandHouses_Script0:
	CheckEvent EVENT_SEVII_CLEARED_CHRONO_WAREHOUSE
	ret z
	CheckEvent EVENT_SEVII_BEAT_PINK_PINKS_HOUSE
	ret nz
	ld hl, SeviiFourIslandHouses_Coordinates_PinkFightScene
	call ArePlayerCoordsInArray ; sets carry if the coordinates are in the array, clears carry if not
	ret nc
; turn everyone down, dialogue, player moves
	call PinksHouseTurnEveryoneDown
	ld a, 17
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $ff
	ld [wJoyIgnore], a
	ld hl, wSimulatedJoypadStatesEnd
	ld de, PinksHousePlayersEntrance_RLEMovement
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
; load next script
	ld a, 1
	ld [wCurMapScript], a
	ret

SeviiFourIslandHouses_Coordinates_PinkFightScene:
	dbmapcoord  2,  7
	db -1 ; end

PinksHousePlayersEntrance_RLEMovement:
	db D_UP, 1
	db D_RIGHT, 1
	db -1 ; end

SeviiFourIslandHouses_Script1:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	xor a
	ld [wJoyIgnore], a
; player finished moving
; turn everyone down again
	call PinksHouseTurnEveryoneDown
; dialogue
	ld a, 18
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; mama moves
	ld de, PinksHouseMamaMovements
	ld a, 4
	ldh [hSpriteIndex], a
	call MoveSprite ; hSpriteIndex already set
; load next script
	ld a, 2
	ld [wCurMapScript], a
	ret

PinksHouseMamaMovements:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_LEFT
	db -1 ; end

SeviiFourIslandHouses_Script2:
; wait for Mama to have moved
	ld a, [wd730]
	bit 0, a
	ret nz
; turn player and Mama
	ld a, SPRITE_FACING_RIGHT
	ld [wSpritePlayerStateData1FacingDirection], a
	lb bc, STAY, LEFT
	ld a, 4
	ldh [hSpriteIndex], a
	call ChangeSpriteMovementBytes
	lb de, 4, SPRITE_FACING_LEFT
	callfar ChangeSpriteFacing
; Mama dialogue
	xor a
	ld [wJoyIgnore], a
	ld a, 19
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; turn player, Pink Dialogue
	ld a, SPRITE_FACING_LEFT
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, 20
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; Pink moves
	ld de, PinksHousePinkApproachesMovements
	ld a, 1
	ldh [hSpriteIndex], a
	call MoveSprite
; load next script
	ld a, 3
	ld [wCurMapScript], a
	ret

PinksHousePinkApproachesMovements:
	db NPC_MOVEMENT_DOWN
	db -1 ; end

SeviiFourIslandHouses_Script3:
; wait for Pink to have moved
	ld a, [wd730]
	bit 0, a
	ret nz
; turn Pink
	lb bc, STAY, RIGHT
	ld a, 1
	ldh [hSpriteIndex], a
	call ChangeSpriteMovementBytes
	lb de, 1, SPRITE_FACING_RIGHT
	callfar ChangeSpriteFacing
; pink dialogue
	xor a
	ld [wJoyIgnore], a
	ld a, 21
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; Pink battle
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_PINK
	ld [wCurOpponent], a
	ld a, 2
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, PinksHousePinkDefeatedText
	ld de, PinksHousePinkBeatYouText
	call SaveEndBattleTextPointers
; load next script
	ld a, 4
	ld [wCurMapScript], a
	ret

SeviiFourIslandHouses_Script4:
	ld a, [wIsInBattle]
	cp $ff
	jp z, SeviiFourIslandHousesResetScripts
	ld a, $f0
	ld [wJoyIgnore], a
; we won: Pink dialogue and Pink leaves
	SetEvent EVENT_SEVII_BEAT_PINK_PINKS_HOUSE
	ld a, 22
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld de, PinksHousePinkLeavesMovements
	ld a, 1
	ldh [hSpriteIndex], a
	call MoveSprite
; load next script
	ld a, 5
	ld [wCurMapScript], a
	ret

PinksHousePinkLeavesMovements:
	db NPC_MOVEMENT_DOWN
	db -1 ; end

SeviiFourIslandHouses_Script5:
; wait for Pink to have moved
	ld a, [wd730]
	bit 0, a
	ret nz
; hide Pink
	ld a, SFX_GO_OUTSIDE
	call PlaySound
	ld a, HS_SEVII_FOUR_ISLAND_HOUSE_PINK
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
;; turn player
;	ld a, SPRITE_FACING_DOWN
;	ld [wSpritePlayerStateData1FacingDirection], a
;	ld c, 40
;	call DelayFrames
; turn player
	ld a, SPRITE_FACING_RIGHT
	ld [wSpritePlayerStateData1FacingDirection], a
; mom dialogue to gift HM Surf
	xor a
	ld [wJoyIgnore], a
	ld a, 4
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; load next script
	xor a
	ld [wCurMapScript], a
	ret


SeviiFourIslandHousesResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

; texts =========================

SeviiFourIslandHouses_TextPointers:
	dw SeviiFourIslandHousesText1
	dw SeviiFourIslandHousesText2
	dw SeviiFourIslandHousesText3
	dw SeviiFourIslandHousesText4
	dw SeviiFourIslandHousesText5
	dw SeviiFourIslandHousesText6
	; signs
	dw SeviiFourIslandHousesSignText1_TV ; 7
	dw SeviiFourIslandHousesSignText2_Picture
	dw SeviiFourIslandHousesSignText3_Paper1
	dw SeviiFourIslandHousesSignText4_Paper2
	dw SeviiFourIslandHousesSignText5_Paper3
	dw SeviiFourIslandHousesSignText6_Switch
	dw SeviiFourIslandHousesSignText7_PC
	dw SeviiFourIslandHousesSignText8_Cheater ; 14
	dw SeviiFourIslandHousesSignText9_FakeBooks ; 15
	dw SeviiFourIslandHousesSignText10_FakeBooks ; 16
	; scripts
	dw SeviiFourIslandHousesScriptText1 ; 17
	dw SeviiFourIslandHousesScriptText2 ; 18
	dw SeviiFourIslandHousesScriptText3 ; 19
	dw SeviiFourIslandHousesScriptText4 ; 20
	dw SeviiFourIslandHousesScriptText5 ; 21
	dw SeviiFourIslandHousesScriptText6 ; 22

; texts ===========================

SeviiFourIslandHousesText1: ; Pink
	text_far _SeviiFourIslandHousesText1
	text_end

SeviiFourIslandHousesText2: ; Dad
	text_asm
	CheckEvent EVENT_SEVII_BEAT_PINK_PINKS_HOUSE
	ld hl, SeviiFourIslandHousesText2_Post
	jr nz, .printAndEnd
	ld hl, SeviiFourIslandHousesText2_Pre
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiFourIslandHousesText2_Pre:
	text_far _SeviiFourIslandHousesText2_Pre
	text_end

SeviiFourIslandHousesText2_Post:
	text_far _SeviiFourIslandHousesText2_Post
	text_end

SeviiFourIslandHousesText3: ; Papa
	text_asm
	CheckEvent EVENT_SEVII_BEAT_PINK_PINKS_HOUSE
	ld hl, SeviiFourIslandHousesText3_Post
	jr nz, .printAndEnd
	ld hl, SeviiFourIslandHousesText3_Pre
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiFourIslandHousesText3_Pre:
	text_far _SeviiFourIslandHousesText3_Pre
	text_end

SeviiFourIslandHousesText3_Post:
	text_far _SeviiFourIslandHousesText3_Post
	text_end

SeviiFourIslandHousesText4: ; Mama
	text_asm
	CheckEvent EVENT_GOT_HM03
	ld hl, SeviiFourIslandHousesText4_PostHM
	jr nz, .printAndEnd
; we didn't get the HM yet
; check if we already beat Pink (so we didn't get Surf because bag full)
	CheckEvent EVENT_SEVII_BEAT_PINK_PINKS_HOUSE
	jr nz, .tryGiveHM
; if we are here, it means it's before the Chrono events
	ld hl, SeviiFourIslandHousesText4_PreChrono
	jr .printAndEnd
.tryGiveHM
	ld hl, SeviiFourIslandHousesText4_TryGiveHM
	call PrintText
	lb bc, HM_SURF, 1
	call GiveItem
	jr nc, .bagFull
	ld hl, ReceivedHM03Text
	call PrintText
	SetEvent EVENT_GOT_HM03
	jr .done
.bagFull
	ld hl, SeviiFourIslandHousesText4_NoRoom
.printAndEnd
	call PrintText
.done
	jp TextScriptEnd

SeviiFourIslandHousesText4_PreChrono:
	text_far _SeviiFourIslandHousesText4_PreChrono
	text_end

SeviiFourIslandHousesText4_TryGiveHM:
	text_far _SeviiFourIslandHousesText4_TryGiveHM
	text_end

ReceivedHM03Text:
	text_far _ReceivedHM03Text
	sound_get_key_item
	text_end

SeviiFourIslandHousesText4_NoRoom:
	text_far _SeviiFourIslandHousesText4_NoRoom
	text_end

SeviiFourIslandHousesText4_PostHM:
	text_far _SeviiFourIslandHousesText4_PostHM
	text_end

; tutor -----

SeviiFourIslandHousesText5: ; Entry Hazards Tutor
	text_asm
	call SaveScreenTilesToBuffer2 ; this must always be here before calling Tutor, and should always be at a point when text is not on the screen
	CheckEvent EVENT_SEVII_HAZARD_ROOM_WON
	jr nz, .alreadyWon
; still haven't given won
	ld hl, SeviiFourIslandHousesText5_ProposeGame
	call PrintText
	jr .done
.alreadyWon
	ld hl, SeviiFourIslandHousesText5_Question
	call PrintText
;	call YesNoChoice
;	ld a, [wCurrentMenuItem]
;	and a
;	jr z, .learnMove
	call MoveTutorHazardChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .spikes
	dec a
	jr z, .toxicSpikes
	dec a
	jr z, .stickyWeb
	dec a
	jr z, .stealthRocks
; decline
	ld hl, SeviiFourIslandHousesText5_Refused
	call PrintText
	jr .done
.spikes
	ld a, SPIKES
	jr .learnMove
.toxicSpikes
	ld a, TOXIC_SPIKES
	jr .learnMove
.stickyWeb
	ld a, STICKY_WEB
	jr .learnMove
.stealthRocks
	ld a, STEALTH_ROCK
.learnMove
	ld [wMoveNum], a
	farcall Tutor
	ld hl, SeviiFourIslandHousesText5_Done
	call PrintText
.done
	jp TextScriptEnd

SeviiFourIslandHousesText5_ProposeGame:
	text_far _SeviiFourIslandHousesText5_ProposeGame
	text_end

SeviiFourIslandHousesText5_Question:
	text_far _SeviiFourIslandHousesText5_Question
	text_end

SeviiFourIslandHousesText5_Refused:
	text_far _SeviiFourIslandHousesText5_Refused
	text_end

SeviiFourIslandHousesText5_Done:
	text_far _SeviiFourIslandHousesText5_Done
	text_end

MoveTutorHazardChoice:
	call SaveScreenTilesToBuffer1
	ld a, MOVE_TUTOR_HAZARD_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld hl, wTopMenuItemY
	ld a, 5
	ld [hli], a ; top menu item Y
	ld a, 6
	ld [hli], a ; top menu item X
	xor a
	ld [hli], a ; current menu item ID
	inc hl
	ld a, 3 ; number of options - 1?
	ld [hli], a ; wMaxMenuItem
	ld a, B_BUTTON | A_BUTTON
	ld [hli], a ; wMenuWatchedKeys
	xor a
	ld [hl], a ; wLastMenuItem
	call HandleMenuInput
	bit BIT_B_BUTTON, a
	jr nz, .decline ; if B was pressed
; A was pressed
	call PlaceUnfilledArrowMenuCursor
	ld a, [wCurrentMenuItem]
	jp LoadScreenTilesFromBuffer1
.decline
	ld a, 4
	ld [wCurrentMenuItem], a
	jp LoadScreenTilesFromBuffer1

SeviiFourIslandHousesText6: ; Furniture
	text_far _SeviiFourIslandHousesText6
	text_end

; signs --------

SeviiFourIslandHousesSignText1_TV:
	text_asm
	ld hl, SeviiFourIslandHousesSignText1_TV_Wrong
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_UP
	jp nz, .got_text
	ld hl, SeviiFourIslandHousesSignText1_TV_Right
.got_text
	call PrintText
	jp TextScriptEnd

SeviiFourIslandHousesSignText1_TV_Right:
	text_far _SeviiFourIslandHousesSignText1_TV_Right
	text_end

SeviiFourIslandHousesSignText1_TV_Wrong:
	text_far _SeviiFourIslandHousesSignText1_TV_Wrong
	text_end

SeviiFourIslandHousesSignText2_Picture:
	text_far _SeviiFourIslandHousesSignText2_Picture
	text_end

SeviiFourIslandHousesSignText3_Paper1:
	text_far _SeviiFourIslandHousesSignText3_Paper1
	text_end

SeviiFourIslandHousesSignText4_Paper2:
	text_far _SeviiFourIslandHousesSignText4_Paper2
	text_end

SeviiFourIslandHousesSignText5_Paper3:
	text_far _SeviiFourIslandHousesSignText5_Paper3
	text_end

SeviiFourIslandHousesSignText6_Switch:
	text_far _SeviiFourIslandHousesSignText6_Switch
	text_end

SeviiFourIslandHousesSignText7_PC:
	text_far _SeviiFourIslandHousesSignText7_PC
	text_end

SeviiFourIslandHousesSignText8_Cheater:
	text_far _SeviiFourIslandHousesSignText8_Cheater
	text_end

SeviiFourIslandHousesSignText9_FakeBooks:
SeviiFourIslandHousesSignText10_FakeBooks:
	text_far _SeviiFourIslandHousesSignText_FakeBooks
	text_end

; scripts ------

SeviiFourIslandHousesScriptText1:
	text_far _SeviiFourIslandHousesScriptText1
	text_end

SeviiFourIslandHousesScriptText2:
	text_far _SeviiFourIslandHousesScriptText2
	text_end

SeviiFourIslandHousesScriptText3:
	text_far _SeviiFourIslandHousesScriptText3
	text_end

SeviiFourIslandHousesScriptText4:
	text_far _SeviiFourIslandHousesScriptText4
	text_end

SeviiFourIslandHousesScriptText5:
	text_far _SeviiFourIslandHousesScriptText5
	text_end

SeviiFourIslandHousesScriptText6:
	text_far _SeviiFourIslandHousesScriptText6
	text_end

PinksHousePinkDefeatedText:
	text_far _PinksHousePinkDefeatedText
	text_end

PinksHousePinkBeatYouText:
	text_far _PinksHousePinkBeatYouText
	text_end
