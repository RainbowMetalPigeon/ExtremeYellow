ForlornValley_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, ForlornValleyHideShowCaveEntrance
	ld hl, wCurrentMapScriptFlags ; from Vortiene
	bit 4, [hl]
	res 4, [hl]
	call nz, ForlornValleyHideShowCaveEntrance
	jp EnableAutoTextBoxDrawing

ForlornValley_TextPointers:
	dw ForlornValleyGiveCoordinates

ForlornValleyGiveCoordinates:
	text_asm
	ld c, 7
	ld b, FLAG_SET
	ld hl, wTownVisitedFlag_Sevii ; mark Desolated Rock as visited (for flying)
	predef FlagActionPredef
	ld a, HS_FORLORN_VALLEY_ITEM_1
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld hl, ForlornValley_ReceiveDesolatedRockCoordinates
	call PrintText
	jp TextScriptEnd

ForlornValley_ReceiveDesolatedRockCoordinates:
	text_far _ForlornValley_ReceiveDesolatedRockCoordinates
	sound_get_key_item
	text_end

ForlornValleyHideShowCaveEntrance:
	CheckEvent EVENT_REACHED_FORBIDDEN_MERCHANT
	jr nz, .caveOpen	; if yes, cave open
	ld a, $57			; solid rock wall block ID
	jr .replaceBlock
.caveOpen
	ld a, $06			; cave entrance block ID
.replaceBlock
	ld [wNewTileBlockID], a
	lb bc, 11, 10 ; Y and X coordinates - opposite as usual
	predef_jump ReplaceTileBlock
