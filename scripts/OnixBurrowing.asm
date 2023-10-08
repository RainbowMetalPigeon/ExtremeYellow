OnixBurrowing_Script:
	call EnableAutoTextBoxDrawing
	ld de, OnixBurrowing_ScriptPointers
	ld a, [wOnixBurrowingCurScript]
	call ExecuteCurMapScriptInTable
	ld [wOnixBurrowingCurScript], a
	ret

OnixBurrowing_ScriptPointers:
	dw OnixBurrowingScript0

OnixBurrowingScript0:
	ld a, [wYCoord]
	cp $2E
	jr nc, .entrance
	ld hl, wd72e
	res 4, [hl]
	ret
.entrance
	ld hl, wd72e
	set 4, [hl]
	ret

OnixBurrowing_TextPointers:

	text_end ; unused
