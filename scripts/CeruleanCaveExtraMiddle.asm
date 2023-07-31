CeruleanCaveExtraMiddle_Script:
	call EnableAutoTextBoxDrawing
;	SetEvent EVENT_IN_SEAFOAM_ISLANDS
;	ld hl, wFlags_0xcd60
;	bit 7, [hl]
;	res 7, [hl]
	ld a, CERULEAN_CAVE_EXTRA_BOTTOM
	ld [wDungeonWarpDestinationMap], a
	ld hl, CeruleanCaveExtraMiddleHolesCoords
	jp IsPlayerOnDungeonWarp

CeruleanCaveExtraMiddleHolesCoords:
	dbmapcoord  7,  7
	dbmapcoord 39, 39
	db -1 ; end

CeruleanCaveExtraMiddle_TextPointers:

	text_end ; unused
