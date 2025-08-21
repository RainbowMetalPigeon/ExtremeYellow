Route16Gate1F_Script:
	ld hl, wd732
	res 5, [hl]
	call EnableAutoTextBoxDrawing
	ld a, [wCurMapScript] ; edited
	ld hl, Route16Gate1F_ScriptPointers
	jp CallFunctionInTable

Route16Gate1F_ScriptPointers:
	dw Route16GateScript0
	dw Route16GateScript1
	dw Route16GateScript2
	dw Route16GateScript3

Route16GateScript0:
	call Route16GateScript_49755
	ret nz
	ld hl, CoordsData_49714
	call ArePlayerCoordsInArray
	ret nc
	ld a, 7 ; edited
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	xor a
	ldh [hJoyHeld], a
	ld a, [wCoordIndex]
	cp $1
	jr z, .asm_4970e
	ld a, [wCoordIndex]
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	ld b, $0
	ld c, a
	ld a, D_UP
	ld hl, wSimulatedJoypadStatesEnd
	call FillMemory
	call StartSimulatingJoypadStates
	ld a, $1
	ld [wCurMapScript], a ; edited
	ret
.asm_4970e
	ld a, $2
	ld [wCurMapScript], a ; edited
	ret

CoordsData_49714:
	dbmapcoord  4,  7
	dbmapcoord  4,  8
	dbmapcoord  4,  9
	dbmapcoord  4, 10
	db -1 ; end

Route16GateScript1:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	ld a, $f0
	ld [wJoyIgnore], a

Route16GateScript2:
	ld a, $1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	ld a, D_RIGHT
	ld [wSimulatedJoypadStatesEnd], a
	call StartSimulatingJoypadStates
	ld a, $3
	ld [wCurMapScript], a ; edited
	ret

Route16GateScript3:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld hl, wd730
	res 7, [hl]
	ld a, $0
	ld [wCurMapScript], a ; edited
	ret

Route16GateScript_49755:
	ld b, BICYCLE
	jp IsItemInBag

Route16Gate1F_TextPointers:
	dw Route16GateText1
	dw Route16GateText2
	; 2F
	dw Route16GateUpstairsText1
	dw Route16GateUpstairsText2
	dw Route16GateUpstairsText3
	dw Route16GateUpstairsText4
	; scripts texts
	dw Route16GateText3

Route16GateText1:
	text_asm
	call Route16GateScript_49755
	jr z, .asm_0bdf3
	ld hl, Route16GateText_4977c
	call PrintText
	jr .asm_56c9d
.asm_0bdf3
	ld hl, Route16GateText_49777
	call PrintText
.asm_56c9d
	jp TextScriptEnd

Route16GateText_49777:
	text_far _Route16GateText_49777
	text_end

Route16GateText_4977c:
	text_far _Route16GateText_4977c
	text_end

Route16GateText3:
	text_far _Route16GateText_49781
	text_end

Route16GateText2:
	text_far _Route16GateText2
	text_end

; 2F ----------------------------------

Route16GateUpstairsText1:
	text_asm
	ld hl, Route16GateUpstairsText_49820
	call PrintText
	jp TextScriptEnd

Route16GateUpstairsText_49820:
	text_far _Route16GateUpstairsText_49820
	text_end

Route16GateUpstairsText2:
	text_asm
	ld hl, Route16GateUpstairsText_4982f
	call PrintText
	jp TextScriptEnd

Route16GateUpstairsText_4982f:
	text_far _Route16GateUpstairsText_4982f
	text_end

Route16GateUpstairsText3:
	text_asm
	ld hl, Route16GateUpstairsText_4983b
	jp GateUpstairsScript_PrintIfFacingUp

Route16GateUpstairsText_4983b:
	text_far _Route16GateUpstairsText_4983b
	text_end

Route16GateUpstairsText4:
	text_asm
	ld hl, Route16GateUpstairsText_49847
	jp GateUpstairsScript_PrintIfFacingUp

Route16GateUpstairsText_49847:
	text_far _Route16GateUpstairsText_49847
	text_end
