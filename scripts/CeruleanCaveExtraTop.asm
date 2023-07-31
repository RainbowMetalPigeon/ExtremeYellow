CeruleanCaveExtraTop_Script:
	call EnableAutoTextBoxDrawing
	ld a, CERULEAN_CAVE_EXTRA_MIDDLE
	ld [wDungeonWarpDestinationMap], a
	ld hl, CeruleanCaveExtraTopHolesCoords
	jp IsPlayerOnDungeonWarp

CeruleanCaveExtraTopHolesCoords:
	dbmapcoord 21, 20
	dbmapcoord 20, 36
	dbmapcoord  7, 40
	dbmapcoord  2, 39
	db -1 ; end

CeruleanCaveExtraTop_TextPointers:

	text_end ; unused
