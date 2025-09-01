SeviiTwoIslandCity_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SeviiTwoIslandCity_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

SeviiTwoIslandCity_ScriptPointers:
	dw SeviiTwoIslandCity_NullScript

SeviiTwoIslandCity_TextPointers:
	dw SeviiTwoIslandCityText1
	dw SeviiTwoIslandCityText2
	dw SeviiTwoIslandCityText3
	dw SeviiTwoIslandCityText4
	dw SeviiTwoIslandCityText5
	dw SeviiTwoIslandCityText6
	dw SeviiTwoIslandCityText7
	dw SeviiTwoIslandCityText8
	dw SeviiTwoIslandCityText9  ; Tauros
	dw SeviiTwoIslandCityText10 ; Tauros
	dw RockSmashText
	dw PickUpItemText
	dw PickUpItemText
	; signs
	dw SeviiTwoIslandCitySignText1
	dw SeviiTwoIslandCitySignText2
	dw SeviiTwoIslandCitySignText3
	dw SeviiTwoIslandCitySignText4
	dw PokeCenterSignText

; scripts =========================================

SeviiTwoIslandCity_NullScript:
	ret

; texts =========================================

SeviiTwoIslandCityText1:
	text_far _SeviiTwoIslandCityText1
	text_end
	
SeviiTwoIslandCityText2:
	text_far _SeviiTwoIslandCityText2
	text_end
	
SeviiTwoIslandCityText3:
	text_far _SeviiTwoIslandCityText3
	text_end
	
SeviiTwoIslandCityText4:
	text_far _SeviiTwoIslandCityText4
	text_end
	
SeviiTwoIslandCityText5:
	text_far _SeviiTwoIslandCityText5
	text_end
	
SeviiTwoIslandCityText6:
	text_far _SeviiTwoIslandCityText6
	text_end
	
SeviiTwoIslandCityText7:
	text_far _SeviiTwoIslandCityText7
	text_end
	
SeviiTwoIslandCityText8:
	text_far _SeviiTwoIslandCityText8
	text_end
	
SeviiTwoIslandCityText9:
SeviiTwoIslandCityText10:
	text_far _SeviiTwoIslandCityText10
	text_end
	
SeviiTwoIslandCitySignText1:
	text_far _SeviiTwoIslandCitySignText1
	text_end
	
SeviiTwoIslandCitySignText2:
	text_far _SeviiTwoIslandCitySignText2
	text_end
	
SeviiTwoIslandCitySignText3:
	text_far _SeviiTwoIslandCitySignText3
	text_end
	
SeviiTwoIslandCitySignText4:
	text_far _SeviiTwoIslandCitySignText4
	text_end
	
