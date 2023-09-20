PewterCity_Script:
	call EnableAutoTextBoxDrawing
	ld hl, wd492
	res 7, [hl]
	ld hl, PewterCity_ScriptPointers
	ld a, [wPewterCityCurScript]
	call CallFunctionInTable
	ret

PewterCity_ScriptPointers:
	dw PewterCityScript0
	dw PewterCityScript1
	dw PewterCityScript2
	dw PewterCityScript3
	dw PewterCityScript4
	dw PewterCityScript5
	dw PewterCityScript6

PewterCityScript0:
	xor a
	ld [wMuseum1FCurScript], a
	ResetEvent EVENT_BOUGHT_MUSEUM_TICKET
	ret

PewterCityScript1:
PewterCityScript2:
PewterCityScript3:
PewterCityScript4:
PewterCityScript5:
PewterCityScript6:
	ret

PewterCity_TextPointers:
	dw PewterCityText1
	dw PewterCityText2
	dw PewterCityText3
	dw PewterCityText4
	dw PewterCityText5
	dw PewterCityText6
	dw PewterCityText7
	dw MartSignText
	dw PokeCenterSignText
	dw PewterCityText10
	dw PewterCityText11
	dw PewterCityText12
	dw PewterCityText13 ; useless
	dw PewterCityText14

PewterCityText1:
	text_far _PewterCityText1
	text_end

PewterCityText2:
	text_far _PewterCityText2
	text_end

PewterCityText3:
	text_asm
	ld hl, PewterCityText_193f1
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .playerDidNotGoIntoMuseum
	ld hl, PewterCityText_193f6
	call PrintText
	jr .done
.playerDidNotGoIntoMuseum
	ld hl, PewterCityText_193fb
	call PrintText
;	xor a
;	ldh [hJoyPressed], a
;	ldh [hJoyHeld], a
;	ld [wNPCMovementScriptFunctionNum], a
;	ld a, $2
;	ld [wNPCMovementScriptPointerTableNum], a
;	ldh a, [hLoadedROMBank]
;	ld [wNPCMovementScriptBank], a
;	ld a, $3
;	ld [wSpriteIndex], a
;	call GetSpritePosition2
;	ld a, $1
;	ld [wPewterCityCurScript], a
.done
	jp TextScriptEnd

PewterCityText_193f1:
	text_far _PewterCityText_193f1
	text_end

PewterCityText_193f6:
	text_far _PewterCityText_193f6
	text_end

PewterCityText_193fb:
	text_far _PewterCityText_193fb
	text_end

PewterCityText13:
	text_far _PewterCityText13
	text_end

PewterCityText4:
	text_asm
	ld hl, PewterCityText_19427
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	cp $0
	jr nz, .playerDoesNotKnow
	ld hl, PewterCityText_1942c
	call PrintText
	jr .done
.playerDoesNotKnow
	ld hl, PewterCityText_19431
	call PrintText
.done
	jp TextScriptEnd

PewterCityText_19427:
	text_far _PewterCityText_19427
	text_end

PewterCityText_1942c:
	text_far _PewterCityText_1942c
	text_end

PewterCityText_19431:
	text_far _PewterCityText_19431
	text_end

PewterCityText5:
	text_asm
	ld hl, PewterCityText_1945d
	CheckEvent EVENT_BEAT_BROCK
	jr z, .continue
	ld hl, PewterCityText_1945dBis
.continue
	call PrintText
;	xor a
;	ldh [hJoyHeld], a
;	ld [wNPCMovementScriptFunctionNum], a
;	ld a, $3
;	ld [wNPCMovementScriptPointerTableNum], a
;	ldh a, [hLoadedROMBank]
;	ld [wNPCMovementScriptBank], a
;	ld a, $5
;	ld [wSpriteIndex], a
;	call GetSpritePosition2
;	ld a, $4
;	ld [wPewterCityCurScript], a
	jp TextScriptEnd

PewterCityText_1945d:
	text_far _PewterCityText_1945d
	text_end

PewterCityText_1945dBis:
	text_far _PewterCityText_1945dBis
	text_end

PewterCityText14:
	text_far _PewterCityText14
	text_end

PewterCityText6:
	text_far _PewterCityText6
	text_end

PewterCityText7:
	text_far _PewterCityText7
	text_end

PewterCityText10:
	text_far _PewterCityText10
	text_end

PewterCityText11:
	text_far _PewterCityText11
	text_end

PewterCityText12:
	text_far _PewterCityText12
	text_end
