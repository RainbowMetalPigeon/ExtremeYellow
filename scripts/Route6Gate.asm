Route6Gate_Script:
	RPTextChooser Route6Gate_TextPointers, Route6Gate_TextPointers_Rocket
	call EnableAutoTextBoxDrawing
	ld hl, Route6Gate_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call CallFunctionInTable
	ret

Route6Gate_ScriptPointers:
	dw Route6GateScript0
	dw Route6GateScript1

Route8GateScript_PushDown:
	ld hl, wd730
	set 7, [hl]
	ld a, D_DOWN | B_BUTTON ; edited
	ld [wSimulatedJoypadStatesEnd], a
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	xor a
	ld [wSpritePlayerStateData2MovementByte1], a
	ld [wOverrideSimulatedJoypadStatesMask], a
	ret

Route6GateScript0: ; edited for RP
	CheckEvent EVENT_RP_GOT_HM01
	ret nz ; guards don't stop player if in RP and after the first quest
	ld a, [wd728]
	bit 6, a
	ret nz
	ld hl, CoordsData_1e08c
	call ArePlayerCoordsInArray
	ret nc
; we are in the "to be stopped" area
	CheckEvent EVENT_ROCKET_PATH
	jr z, .notRP
	ld a, PLAYER_DIR_RIGHT
	ld [wPlayerMovingDirection], a
	xor a
	ldh [hJoyHeld], a
	inc a
	jr .printTextAndPushAway
.notRP
; BTV
	ld a, PLAYER_DIR_RIGHT
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
.printTextAndPushAway
; BTV
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call Route8GateScript_PushDown
	ld a, $1
	ld [wCurMapScript], a
	ret
.givenRightDrink
	ld hl, wd728
	set 6, [hl]
	ld a, $3
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID

CoordsData_1e08c:
	dbmapcoord  3,  2
	dbmapcoord  4,  2
	db -1 ; end

Route6GateScript1:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

Route6Gate_TextPointers:
	dw Route6GateText1
	; scripts
	dw Route6GateText2
	dw Route6GateText3
	dw Route6GateText4
	dw Route6GateText5

Route6Gate_TextPointers_Rocket:
	dw Route6GateText1_RP
