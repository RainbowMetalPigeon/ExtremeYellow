SeviiFiveIslandWarehouseBF_Script:
	call SeviiFiveIslandWarehouseBFSetDoorBlock
	jp EnableAutoTextBoxDrawing

SeviiFiveIslandWarehouseBFSetDoorBlock:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
; stop spinning
	ld hl, wd736
	res 7, [hl]
	ret ; TBE
	CheckEvent EVENT_OBSIDIAN_WAREHOUSE_SWITCH_CLICKED
	jr nz, .doorsOpen
	ld a, $54 ; double door block ID
	jr .replaceBlock
.doorsOpen
	ld a, $0E ; clear floor block ID
.replaceBlock
	ld [wNewTileBlockID], a
	lb bc, 3, 24
	predef_jump ReplaceTileBlock

SeviiFiveIslandWarehouseBF_TextPointers:
;	dw SeviiFiveIslandWarehouseBFText1
;	dw PickUpItemText
;	dw PickUpItemText
;	dw PickUpItemText
;	dw SeviiFiveIslandWarehouseBFText3
	text_end

;SeviiFiveIslandWarehouseBFText1:
;	text_far _SeviiFiveIslandWarehouseBFText1
;	text_end
