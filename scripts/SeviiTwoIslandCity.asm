SeviiTwoIslandCity_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SeviiTwoIslandCity_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

SeviiTwoIslandCity_ScriptPointers:
	dw SeviiTwoIslandCity_NullScript

SeviiTwoIslandCity_NullScript:
	ret

SeviiTwoIslandCity_TextPointers:
;	dw SeviiTwoIslandCity_RockClimb1Up
;	dw SeviiTwoIslandCity_RockClimb1Down
;	dw PickUpItemText
;	dw SeviiTwoIslandCityText3
	text_end
