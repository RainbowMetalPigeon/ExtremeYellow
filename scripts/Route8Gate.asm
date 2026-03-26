Route8Gate_Script:
	call EnableAutoTextBoxDrawing
	ld hl, Route8Gate_ScriptPointers
	ld a, [wCurMapScript] ; edited
	jp CallFunctionInTable

Route8Gate_ScriptPointers:
	dw Route8GateScript0
	dw Route8GateScript1

Route8GateScript_PushRight:
	ld hl, wd730
	set 7, [hl]
	ld a, D_RIGHT | B_BUTTON ; edited
	ld [wSimulatedJoypadStatesEnd], a
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	xor a
	ld [wSpritePlayerStateData2MovementByte1], a
	ld [wOverrideSimulatedJoypadStatesMask], a
	ret

Route8GateScript0:
	ld a, [wd728]
	bit 6, a
	ret nz
	ld hl, CoordsData_1e22c
	call ArePlayerCoordsInArray
	ret nc
	ld a, PLAYER_DIR_UP
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
	call Route8GateScript_PushRight
	ld a, $1
	ld [wCurMapScript], a
	ret
.givenRightDrink
	ld hl, wd728
	set 6, [hl]
	ld a, $3
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID

CoordsData_1e22c:
	dbmapcoord  2,  3
	dbmapcoord  2,  4
	db -1 ; end

Route8GateScript1:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

Route8Gate_TextPointers:
	dw Route8GateText1
	dw Route8GateText2
	dw Route8GateText3
	dw Route8GateText4
	dw Route8GateText5
