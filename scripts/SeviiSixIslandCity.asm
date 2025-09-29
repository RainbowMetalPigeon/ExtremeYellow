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
;	dw PickUpItemText
;	dw PickUpItemText
;	dw PickUpItemText
;	dw SeviiSixIslandCityText3
	text_end

;SeviiSixIslandCityText3:
;	text_far _SeviiSixIslandCityText3
;	text_end
