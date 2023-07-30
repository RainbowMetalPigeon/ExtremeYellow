CeruleanCaveExtraMiddle_Script:
	call EnableAutoTextBoxDrawing
	SetEvent EVENT_IN_SEAFOAM_ISLANDS
	ld hl, wFlags_0xcd60
	bit 7, [hl]
	res 7, [hl]
	jr z, .asm_4483b
	ld hl, CeruleanCaveExtraMiddleHolesCoords
.asm_4483b
	ld a, SEAFOAM_ISLANDS_B1F
	ld [wDungeonWarpDestinationMap], a
	ld hl, CeruleanCaveExtraMiddleHolesCoords
	jp IsPlayerOnDungeonWarp

CeruleanCaveExtraMiddleHolesCoords:
	dbmapcoord 39, 39
	db -1 ; end

CeruleanCaveExtraMiddle_TextPointers:
	dw BoulderText
	dw BoulderText
