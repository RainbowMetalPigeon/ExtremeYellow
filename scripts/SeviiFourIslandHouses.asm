SeviiFourIslandHouses_Script:
	jp EnableAutoTextBoxDrawing

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
	text_far _SeviiFourIslandHousesText5
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
