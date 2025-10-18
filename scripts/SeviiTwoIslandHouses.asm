SeviiTwoIslandHouses_Script:
	jp EnableAutoTextBoxDrawing

SeviiTwoIslandHouses_TextPointers:
	dw SeviiTwoIslandHousesText1
	dw SeviiTwoIslandHousesText2
	dw SeviiTwoIslandHousesText3
	dw SeviiTwoIslandHousesText4
	dw SeviiTwoIslandHousesText5
	; signs
	dw SeviiTwoIslandHousesSignText1

SeviiTwoIslandHousesText1:
	text_far _SeviiTwoIslandHousesText1
	text_end

SeviiTwoIslandHousesText2: ; Tutor Weather Ball
	text_asm
	call SaveScreenTilesToBuffer2 ; this must always be here before calling Tutor, and should always be at a point when text is not on the screen
	ld hl, SeviiTwoIslandHousesText2_Question
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .learnMove
.declineMove
	ld hl, SeviiTwoIslandHousesText2_Refused
	call PrintText
	jr .done
.learnMove
	ld a, WEATHER_BALL
	ld [wMoveNum], a
	farcall Tutor
	ld hl, SeviiTwoIslandHousesText2_Done
	call PrintText
.done
	jp TextScriptEnd

SeviiTwoIslandHousesText2_Question:
	text_far _SeviiTwoIslandHousesText2_Question
	text_end

SeviiTwoIslandHousesText2_Refused:
	text_far _SeviiTwoIslandHousesText2_Refused
	text_end

SeviiTwoIslandHousesText2_Done:
	text_far _SeviiTwoIslandHousesText2_Done
	text_end

SeviiTwoIslandHousesText3: ; Tutor Terrain Pulse
	text_asm
	call SaveScreenTilesToBuffer2 ; this must always be here before calling Tutor, and should always be at a point when text is not on the screen
	ld hl, SeviiTwoIslandHousesText3_Question
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .learnMove
.declineMove
	ld hl, SeviiTwoIslandHousesText3_Refused
	call PrintText
	jr .done
.learnMove
	ld a, TERRAIN_PULSE
	ld [wMoveNum], a
	farcall Tutor
	ld hl, SeviiTwoIslandHousesText3_Done
	call PrintText
.done
	jp TextScriptEnd

SeviiTwoIslandHousesText3_Question:
	text_far _SeviiTwoIslandHousesText3_Question
	text_end

SeviiTwoIslandHousesText3_Refused:
	text_far _SeviiTwoIslandHousesText3_Refused
	text_end

SeviiTwoIslandHousesText3_Done:
	text_far _SeviiTwoIslandHousesText3_Done
	text_end

SeviiTwoIslandHousesText4:
	text_far _SeviiTwoIslandHousesText4
	text_end

SeviiTwoIslandHousesText5:
	text_far _SeviiTwoIslandHousesText5
	text_end

SeviiTwoIslandHousesSignText1:
	text_far _SeviiTwoIslandHousesSignText1
	text_end
