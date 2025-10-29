SeviiSevenIslandCity_Script:
	jp EnableAutoTextBoxDrawing

SeviiSevenIslandCity_TextPointers:
	dw SeviiSevenIslandCityText1
	dw SeviiSevenIslandCityText2
	; signs
	dw SeviiSevenIslandCitySignText1 ; 3
	dw SeviiSevenIslandCitySignText2 ; 4
	dw SeviiSevenIslandCitySignText3 ; 5
	dw PokeCenterSignText ; 6
	dw MartSignText ; 7

SeviiSevenIslandCityText1:
	text_far _SeviiSevenIslandCityText1
	text_end

SeviiSevenIslandCityText2:
	text_far _SeviiSevenIslandCityText2
	text_end

SeviiSevenIslandCitySignText1:
	text_far _SeviiSevenIslandCitySignText1
	text_end

SeviiSevenIslandCitySignText2:
	text_far _SeviiSevenIslandCitySignText2
	text_end

SeviiSevenIslandCitySignText3:
	text_far _SeviiSevenIslandCitySignText3
	text_end
