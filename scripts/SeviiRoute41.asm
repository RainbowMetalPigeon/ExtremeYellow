SeviiRoute41_Script:
	call ResetAnomaliesWarning_SevenIsland
	jp EnableAutoTextBoxDrawing

ResetAnomaliesWarning_SevenIsland:
	ld hl, wCurrentMapScriptFlags ; new
	bit 5, [hl]
	res 5, [hl]
	ret z
	ResetEvent EVENT_SEVII_ALREADY_WARNED_ABOUT_ANOMALIES
	ret

SeviiRoute41_TextPointers:
;	dw RockSmashText
;	dw RockSmashText
;	dw PickUpItemText
;	dw PickUpItemText
;	dw PickUpItemText
;	dw SeviiRoute41Text1
	text_end

;SeviiRoute41Text1:
;	text_far _SeviiRoute41Text1
;	text_end
