Route7Gate_Script:
	call EnableAutoTextBoxDrawing
	ld a, [wCurMapScript] ; edited
	ld hl, Route7Gate_ScriptPointers
	call CallFunctionInTable
	ret

Route7Gate_ScriptPointers:
	dw Route7GateScript0
	dw Route7GateScript1

Route7GateScript_PushLeft:
	ld hl, wd730
	set 7, [hl]
	ld a, D_LEFT | B_BUTTON ; edited
	ld [wSimulatedJoypadStatesEnd], a
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	xor a
	ld [wSpritePlayerStateData2MovementByte1], a
	ld [wOverrideSimulatedJoypadStatesMask], a
	ret

Route7GateScript0:
	ld a, [wd728]
	bit 6, a
	ret nz
	ld hl, CoordsData_1e167
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
	call Route7GateScript_PushLeft
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

CoordsData_1e167:
	dbmapcoord  3,  3
	dbmapcoord  3,  4
	db -1 ; end

Route7GateScript1:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

Route7Gate_TextPointers:
	dw Route7GateText1
	dw Route7GateText2
	dw Route7GateText3
	dw Route7GateText4
	dw Route7GateText5
