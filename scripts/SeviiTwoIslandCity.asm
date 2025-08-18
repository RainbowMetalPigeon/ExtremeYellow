SeviiTwoIslandCity_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SeviiTwoIslandCity_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

SeviiTwoIslandCity_ScriptPointers:
	dw SeviiTwoIslandCity_NullScript
	dw SeviiTwoIslandCity_WaitForSimulatedInputsScript

SeviiTwoIslandCity_NullScript:
	ret

SeviiTwoIslandCity_WaitForSimulatedInputsScript:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

SeviiTwoIslandCity_TextPointers:
	dw SeviiTwoIslandCity_RockClimb1Up
	dw SeviiTwoIslandCity_RockClimb1Down
;	dw PickUpItemText
;	dw SeviiTwoIslandCityText3
	text_end

;SeviiTwoIslandCityText3:
;	text_far _SeviiTwoIslandCityText3
;	text_end

SeviiTwoIslandCity_RockClimb1Down:
	text_asm
	ld a, 2
	ld [wMultipurposeBuffer], a ; how many "floors" to climb
	callfar TryToClimbWall
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd

SeviiTwoIslandCity_RockClimb1Up:
	text_asm
	ld a, 2
	ld [wMultipurposeBuffer], a ; how many "floors" to climb
	callfar TryToClimbWall
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd
