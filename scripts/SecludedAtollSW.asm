SecludedAtollSW_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, SecludedAtollSWHideShowCaveEntrance
	call EnableAutoTextBoxDrawing
	ret

SecludedAtollSW_TextPointers:
	dw BoulderText

SecludedAtollSWHideShowCaveEntrance:
	CheckEvent EVENT_BEAT_INTERDIMENSIONAL_TRAVELER
	jr nz, .caveOpen	; if yes, cave open
	ld a, $57			; solid rock wall block ID
	jr .replaceBlock
.caveOpen
	ld a, $06			; cave entrance block ID
.replaceBlock
	ld [wNewTileBlockID], a
	lb bc, 6, 21 ; Y and X coordinates - opposite as usual
	predef_jump ReplaceTileBlock
