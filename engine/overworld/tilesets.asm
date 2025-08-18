LoadTilesetHeader:
	call GetPredefRegisters
	push hl
	ld d, 0
	ld a, [wCurMapTileset]
	add a
	add a
	ld e, a
	ld hl, Tilesets
	add hl, de
	add hl, de
	add hl, de
	ld de, wTilesetBank
	ld bc, $b
	call CopyData
	ld a, [hl]
	ldh [hTileAnimations], a
	xor a
	ldh [hMovingBGTilesCounter1], a
	pop hl
	ld a, [wCurMapTileset]
	push hl
	push de
	ld hl, DungeonTilesets
	ld de, $1
	call IsInArray
	pop de
	pop hl
	jr c, .dungeon
	ld a, [wCurMapTileset]
	ld b, a
	ldh a, [hPreviousTileset]
	cp b
	jr z, .done
.dungeon
; new for Dive
	CheckEvent EVENT_DIVE_GO_UNDER
	jr nz, .dive
	CheckEvent EVENT_DIVE_GO_ABOVE
	jr z, .vanilla
.dive
	call LoadDestinationWarpPosition_SpecialForDive
	jr .postLoading
.vanilla
; BTV
	ld a, [wDestinationWarpID]
	cp $ff
	jr z, .done
	call LoadDestinationWarpPosition
.postLoading ; new
	ld a, [wYCoord]
	and $1
	ld [wYBlockCoord], a
	ld a, [wXCoord]
	and $1
	ld [wXBlockCoord], a
.done
	ret

INCLUDE "data/tilesets/dungeon_tilesets.asm"

INCLUDE "data/tilesets/tileset_headers.asm"

; new
LoadDestinationWarpPosition_SpecialForDive::
	ldh a, [hLoadedROMBank]
	ld [MBC1RomBank], a

	ld hl, wOverworldMap ; hl=start+7
	ld hl, wOverworldMap + 7 ; hl=start+7
	ld de, wCurrentTileBlockMapViewPointer
	ld a, [de]
	inc de
	ld a, [de]

	ld a, [wCurMapWidth]
	ld b, 0
	ld c, a
	add hl, bc ; hl=start+7+W
	add 6 ; a=width+6
	ld c, a ; bc=W+6, as long as width<249
	ld a, [wYCoord]
	srl a ; a=Y/2
	call AddNTimes ; adds bc to hl a times ; hl=start+7+W+(W+6)x(Y/2)
	ld a, [wXCoord]
	srl a ; a=X/2
	ld c, a ; bc=X/2
	add hl, bc ; hl=start+7+W+(W+6)x(Y/2)+X/2

	ld de, wCurrentTileBlockMapViewPointer
	ld a, l
	ld [de], a
	inc de
	ld a, h
	ld [de], a

	; X and Y coordinates stay the same

	CheckEvent EVENT_DIVE_GO_UNDER
	jr z, .reemerge
	ld a, 3
	ld [wWalkBikeSurfState], a
	ld [wWalkBikeSurfStateCopy], a
	ret
.reemerge
	ld a, 2
	ld [wWalkBikeSurfState], a
	ld [wWalkBikeSurfStateCopy], a
	ret


	