SeviiRoute44_Script:
	call HideOrShowTanobyChambers
	jp EnableAutoTextBoxDrawing

HideOrShowTanobyChambers:
	ld hl, wCurrentMapScriptFlags
	bit 6, [hl]
	res 6, [hl]
	call nz, HideOrShowTanobyChambers_Core
	ld hl, wCurrentMapScriptFlags
	bit 4, [hl]
	res 4, [hl]
	ret z
; fallthrough
HideOrShowTanobyChambers_Core:
	CheckEvent EVENT_SEVII_UNLOCKED_TANOBY_CHAMBER_MAJOR
	ret nz ; no need to do anything else: if we unlocked the major chamber, ofc we unlocked the previous ones
; replace block
	ld a, $57 ; no-entrance edge block
	ld [wNewTileBlockID], a
	lb bc,  6, 42
	predef ReplaceTileBlock
; check minor chambers
	CheckEvent EVENT_SEVII_UNLOCKED_TANOBY_CHAMBERS
	ret nz
; replace block 1
	ld a, $25 ; no-entrance corner block
	ld [wNewTileBlockID], a
	lb bc,  5,  5 ; Y and X coordinates - opposite as usual
	predef ReplaceTileBlock
; replace block 2
	lb bc, 11,  6
	predef ReplaceTileBlock
; replace block 3
	lb bc,  7, 12
	predef ReplaceTileBlock
; replace block 4
	lb bc, 10, 17
	predef ReplaceTileBlock
; replace block 5
	lb bc,  7, 28
	predef ReplaceTileBlock
; replace block 6
	lb bc, 10, 34
	predef_jump ReplaceTileBlock

SeviiRoute44_TextPointers:
	dw SeviiRoute44Text1

SeviiRoute44Text1:
	text_far _SeviiRoute44Text1
	text_end
