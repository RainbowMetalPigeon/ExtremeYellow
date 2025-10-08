SeviiSixIslandCity_Script:
	call ResetAnomaliesWarning_SixIsland
	jp EnableAutoTextBoxDrawing

ResetAnomaliesWarning_SixIsland:
	ld hl, wCurrentMapScriptFlags ; new
	bit 5, [hl]
	res 5, [hl]
	ret z
	ResetEvent EVENT_SEVII_ALREADY_WARNED_ABOUT_ANOMALIES
	ret

SeviiSixIslandCity_TextPointers:
	dw SeviiSixIslandCityText1 ; 1
	dw SeviiSixIslandCityText2 ; 2
	dw SeviiSixIslandCityText3 ; 3
	; signs
	dw SeviiSixIslandCitySignText1 ; 4
	dw SeviiSixIslandCitySignText2 ; 5
	dw SeviiSixIslandCitySignText3 ; 6
	dw PokeCenterSignText ; 7
	dw MartSignText ; 8

; scripts =========================================

; texts =========================================

SeviiSixIslandCityText1:
	text_far _SeviiSixIslandCityText1
	text_end

SeviiSixIslandCityText2:
	text_far _SeviiSixIslandCityText2
	text_end

SeviiSixIslandCityText3:
	text_far _SeviiSixIslandCityText3
	text_end

SeviiSixIslandCitySignText1:
	text_far _SeviiSixIslandCitySignText1
	text_end

SeviiSixIslandCitySignText2:
	text_far _SeviiSixIslandCitySignText2
	text_end

SeviiSixIslandCitySignText3:
	text_far _SeviiSixIslandCitySignText3
	text_end
