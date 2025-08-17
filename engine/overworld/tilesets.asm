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
	ld a, [wDestinationWarpID]
	cp $ff
	jr z, .done
; new for Dive
	cp $FE
	jr nz, .vanilla
; Dive
	call LoadDestinationWarpPosition_SpecialForDive
	jr .postLoading
.vanilla
; BTV
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

	ld hl, wOverworldMap + 7 ; hl=start+7
	ld a, [wCurMapWidth]
	ld b, 0
	ld c, a
	add hl, bc ; hl=start+7+W
	add 6 ; a=width+6
	ld c, a ; bc=W+6, as long as width<249
	ld a, [wYCoord]
	rrc a ; a=Y/2
	call AddNTimes ; adds bc to hl a times ; hl=start+7+W+(W+6)x(Y/2)
	ld a, [wXCoord]
	rrc a ; a=X/2
	ld c, a ; bc=X/2
	add hl, bc ; hl=start+7+W+(W+6)x(Y/2)+X/2

	ld de, wCurrentTileBlockMapViewPointer
	ld e, [hl]
	inc hl
	ld d, [hl]

	; X and Y coordinates stay the same

    ld a, 3
    ld [wWalkBikeSurfState], a
	
	ret


	