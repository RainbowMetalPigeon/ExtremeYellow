SeviiTwoIslandHouses_Script:
	jp EnableAutoTextBoxDrawing

SeviiTwoIslandHouses_TextPointers:
	dw SeviiTwoIslandHousesText1
	dw SeviiTwoIslandHousesText2
	dw SeviiTwoIslandHousesText3
	dw SeviiTwoIslandHousesText4
	dw SeviiTwoIslandHousesText5
	dw SeviiTwoIslandHousesText6
	dw SeviiTwoIslandHousesText7
	dw SeviiTwoIslandHousesText8
	dw SeviiTwoIslandHousesText9
	dw SeviiTwoIslandHousesText10
	dw SeviiTwoIslandHousesText11
	; signs
	dw SeviiTwoIslandHousesSignText1
	dw SeviiTwoIslandHousesSignText2
	dw SeviiTwoIslandHousesSignText3
	dw SeviiTwoIslandHousesSignText3
	dw SeviiTwoIslandHousesSignText3
	dw SeviiTwoIslandHousesSignText3

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

SeviiTwoIslandHousesText6:
	text_far _SeviiTwoIslandHousesText6
	text_end

SeviiTwoIslandHousesText7:
	text_far _SeviiTwoIslandHousesText7
	text_end

SeviiTwoIslandHousesText8:
	text_far _SeviiTwoIslandHousesText8
	text_end

SeviiTwoIslandHousesText9:
	text_far _SeviiTwoIslandHousesText9
	text_end

SeviiTwoIslandHousesText10:
	text_far _SeviiTwoIslandHousesText10
	text_end

SeviiTwoIslandHousesText11:
	text_far _SeviiTwoIslandHousesText11
	text_end

SeviiTwoIslandHousesSignText1:
	text_far _SeviiTwoIslandHousesSignText1
	text_end

SeviiTwoIslandHousesSignText2:
	text_far _SeviiTwoIslandHousesSignText2
	text_end

SeviiTwoIslandHousesSignText3:
	text_far _SeviiTwoIslandHousesSignText3
	text_end
