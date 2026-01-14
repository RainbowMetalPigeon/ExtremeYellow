SeviiFourIslandCity_Script:
	jp EnableAutoTextBoxDrawing

SeviiFourIslandCity_TextPointers:
	dw SeviiFourIslandCityText1 ; 1, post-Leauge Pink
	dw SeviiFourIslandCityText2 ; 2
	dw SeviiFourIslandCityText3 ; 3
	dw SeviiFourIslandCityText4 ; 4
	dw SeviiFourIslandCityText5 ; 5
	dw SeviiFourIslandCityText6 ; 6
	dw SeviiFourIslandCityText7 ; 7
	dw SeviiFourIslandCityText8 ; 8
	dw RockSmashText ; 9
	dw PickUpItemText ; 10
	dw PickUpItemText ; 11
	dw PickUpItemText ; 12
	dw PickUpItemText ; 13
	dw SeviiFourIslandCityText14 ; 14
	; signs
	dw SeviiFourIslandCitySignText1 ; 15
	dw SeviiFourIslandCitySignText2 ; 16
	dw SeviiFourIslandCitySignText3 ; 17
	dw SeviiFourIslandCitySignText4 ; 18
	dw PokeCenterSignText ; 19
	dw MartSignText ; 20
	; scripts

; scripts =========================================

; texts =========================================

SeviiFourIslandCityText1: ; post-Leauge Pink
	text_far _SeviiFourIslandCityText1
	text_end

SeviiFourIslandCityText2:
	text_asm
	ld hl, SeviiFourIslandCityText2_1
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ld hl, SeviiFourIslandCityText2_No
	jr nz, .printAndEnd
	ld hl, SeviiFourIslandCityText2_Yes
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiFourIslandCityText2_1:
	text_far _SeviiFourIslandCityText2_1
	text_end

SeviiFourIslandCityText2_Yes:
	text_far _SeviiFourIslandCityText2_Yes
	text_end

SeviiFourIslandCityText2_No:
	text_far _SeviiFourIslandCityText2_No
	text_end

SeviiFourIslandCityText3:
	text_far _SeviiFourIslandCityText3
	text_end

SeviiFourIslandCityText4:
	text_far _SeviiFourIslandCityText4
	text_end

SeviiFourIslandCityText5:
	text_far _SeviiFourIslandCityText5
	text_end

SeviiFourIslandCityText6:
	text_far _SeviiFourIslandCityText6
	text_end

SeviiFourIslandCityText7:
	text_far _SeviiFourIslandCityText7
	text_end

SeviiFourIslandCityText8:
	text_far _SeviiFourIslandCityText8
	text_end

SeviiFourIslandCityText14:
	text_far _SeviiUndergroundCaveGuardText
	text_end

SeviiFourIslandCitySignText1:
	text_far _SeviiFourIslandCitySignText1
	text_end

SeviiFourIslandCitySignText2:
	text_far _SeviiFourIslandCitySignText2
	text_end

SeviiFourIslandCitySignText3:
	text_far _SeviiFourIslandCitySignText3
	text_end

SeviiFourIslandCitySignText4:
	text_far _SeviiFourIslandCitySignText4
	text_end
