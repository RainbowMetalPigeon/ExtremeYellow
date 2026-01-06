ForlornValley_Script:
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
	predef HideObject
	ld hl, ForlornValley_ReceiveDesolatedRockCoordinates
	call PrintText
	jp TextScriptEnd

ForlornValley_ReceiveDesolatedRockCoordinates:
	text_far _ForlornValley_ReceiveDesolatedRockCoordinates
	sound_get_key_item
	text_end
