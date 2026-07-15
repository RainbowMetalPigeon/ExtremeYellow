SafariZoneExtra_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, SafariZoneExtraHideShowExit
	ld hl, wCurrentMapScriptFlags ; from Vortiene
	bit 4, [hl]
	res 4, [hl]
	call nz, SafariZoneExtraHideShowExit
	jp EnableAutoTextBoxDrawing

SafariZoneExtraHideShowExit:
	CheckEvent EVENT_ROCKET_PATH
	jr nz, .caveOpen	; if yes, cave open
	ld a, 57			; wall block ID
	jr .replaceBlock
.caveOpen
	ld a, 27			; open path block ID
.replaceBlock
	ld [wNewTileBlockID], a
	lb bc, 0, 7 ; Y and X coordinates - opposite as usual
	predef_jump ReplaceTileBlock

SafariZoneExtra_TextPointers:
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	; signs
	dw SafariZoneExtraText1
	dw SafariZoneExtraText2

SafariZoneExtraText1:
	text_far _SafariZoneExtraText1
	text_end

SafariZoneExtraText2:
	text_far _SafariZoneExtraText2
	text_end
