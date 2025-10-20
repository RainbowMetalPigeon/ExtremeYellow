SeviiFourIslandHouses_Script:
	call UndoDarkeningFromHazardRoom
	jp EnableAutoTextBoxDrawing

UndoDarkeningFromHazardRoom:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
	xor a
	ld [wMapPalOffset], a
	ret

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

; scripts =========================

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

; texts ===========================

SeviiFourIslandHousesText1: ; Pink
	text_far _SeviiFourIslandHousesText1
	text_end

SeviiFourIslandHousesText2: ; Dad
	text_far _SeviiFourIslandHousesText2
	text_end

SeviiFourIslandHousesText3: ; Papa
	text_far _SeviiFourIslandHousesText3
	text_end

SeviiFourIslandHousesText4: ; Mama
	text_far _SeviiFourIslandHousesText4
	text_end

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
