Route5Gate_Script:
	call EnableAutoTextBoxDrawing
	ld a, [wCurMapScript] ; edited
	ld hl, Route5Gate_ScriptPointers
	jp CallFunctionInTable

Route5Gate_ScriptPointers:
	dw Route5GateScript0
	dw Route5GateScript1

Route8GateScript_PushUp:
	ld a, D_UP | B_BUTTON ; edited
	ld [wSimulatedJoypadStatesEnd], a
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	jp StartSimulatingJoypadStates

Route5GateScript0:
	ld a, [wd728]
	bit 6, a
	ret nz
	ld hl, CoordsData_1df8f
	call ArePlayerCoordsInArray
	ret nc
	ld a, PLAYER_DIR_LEFT
	ld [wPlayerMovingDirection], a
	xor a
	ldh [hJoyHeld], a
	farcall RemoveGuardDrink
	ldh a, [hItemToRemoveID]
	and a
	jr nz, .givenRightDrink
; new: we don't have the right drink; check if we have a wrong one
	ld a, $2
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	callfar DoWeHaveTheWrongDrinks ; nz if we have one of the non-Matcha-Tea
	jr z, .noJunkDrink
	ld a, $4
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.noJunkDrink
	ld a, $5
; BTV
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call Route8GateScript_PushUp
	ld a, $1
	ld [wCurMapScript], a ; edited
	ret
.givenRightDrink
	ld a, $3
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld hl, wd728
	set 6, [hl]
	ret

CoordsData_1df8f:
	dbmapcoord  3,  3
	dbmapcoord  4,  3
	db -1 ; end

Route5GateScript1:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a ; edited
	ret

Route5Gate_TextPointers:
	dw Route5GateText1
	dw Route5GateText2
	dw Route5GateText3
	dw Route5GateText4
	dw Route5GateText5

Route8GateText1:
Route7GateText1:
Route6GateText1:
Route5GateText1:
	text_asm
/*
	ld a, [wd728]
	bit 6, a
	jr nz, .asm_88856
	farcall RemoveGuardDrink
	ldh a, [hItemToRemoveID]
	and a
	jr nz, .asm_768a2
	ld hl, Route5GateText2
	call PrintText
	call Route8GateScript_PushUp
	ld a, $1
	ld [wCurMapScript], a ; edited
	jp TextScriptEnd
.asm_768a2
	ld hl, Route5GateText3
	call PrintText
	ld hl, wd728
	set 6, [hl]
	jp TextScriptEnd
.asm_88856
*/
	ld hl, SaffronGateText_ThankForTheDrink
	call PrintText
	jp TextScriptEnd

Route8GateText2:
Route7GateText2:
Route6GateText2:
Route5GateText2:
	text_far _SaffronGateText_ImOnGuardAndThirsty
	text_end

; new
Route8GateText4:
Route7GateText4:
Route6GateText4:
Route5GateText4:
	text_far _SaffronGateText_WhatsThis
	text_end

; new
Route8GateText5:
Route7GateText5:
Route6GateText5:
Route5GateText5:
	text_far _SaffronGateText_RoadIsClosed
	text_end

Route8GateText3:
Route7GateText3:
Route6GateText3:
Route5GateText3:
	text_far _SaffronGateText_CanIHaveThatDrink
	sound_get_key_item
	text_far _SaffronGateText_GluGluCanGo
	text_end

SaffronGateText_ThankForTheDrink:
	text_far _SaffronGateText_ThankForTheDrink
	text_end
