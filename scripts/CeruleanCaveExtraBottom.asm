CeruleanCaveExtraBottom_Script:
	call RespawnItem ; new, testing
	call EnableAutoTextBoxDrawing
	ret

RespawnItem:
    ld hl, wCurrentMapScriptFlags
    bit 5, [hl]
    res 5, [hl]
    ret z
    ld a, HS_CERULEAN_CAVE_EXTRA_BOTTOM_ITEM_1
    ld [wMissableObjectIndex], a
    predef ShowObjectExtra
    ret

CeruleanCaveExtraBottom_TextPointers:
	dw PickUpItemText
