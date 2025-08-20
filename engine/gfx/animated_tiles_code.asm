; this code has been moved here from home/vcopy.asm
; thanks Vortiene
AnimateWaterTile::
	ld hl, vTileset tile $14
    ld de, vTileset tile $6A ; new, deep water
	ld c, $10

	ld a, [wMovingBGTilesCounter2]
	inc a
	and 7
	ld [wMovingBGTilesCounter2], a

	and 4
	jr nz, .left
.right
	ld a, [hl]
	rrca
	ld [hli], a
; new, deep water
    ld a, [de]
    rrca
    ld [de], a
    inc de
; BTV
	dec c
	jr nz, .right
	jr .done
.left
	ld a, [hl]
	rlca
	ld [hli], a
; new, deep water
    ld a, [de]
    rlca
    ld [de], a
    inc de
; BTV
	dec c
	jr nz, .left
.done
	ldh a, [hTileAnimations]
	rrca
	ret nc

	xor a
	ldh [hMovingBGTilesCounter1], a
	ret

; ==================================================================

AnimateFlowerTile::
	xor a
	ldh [hMovingBGTilesCounter1], a

	ld a, [wMovingBGTilesCounter2]
	and 3
	cp 2
	ld hl, FlowerTile1
	jr c, .copy
	ld hl, FlowerTile2
	jr z, .copy
	ld hl, FlowerTile3
.copy
	ld de, vTileset tile $03
	ld c, $10
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret

FlowerTile1: INCBIN "gfx/tilesets/flower/flower1.2bpp"
FlowerTile2: INCBIN "gfx/tilesets/flower/flower2.2bpp"
FlowerTile3: INCBIN "gfx/tilesets/flower/flower3.2bpp"

; ==================================================================

AnimateWhirlpoolTiles:: ; new
	ld a, [wCurMapTileset]
	cp OVERWORLD_SEVII
	ret nz

	ld a, [wMovingBGTilesCounter2]
	and 3

	swap a ; multiply by 16, the amount of byte per tiles
    add a
    add a ; multiply by 4, the amount of tiles per whirlpool state

; add a to the starting address of the whirlpool tiles
	add LOW(WhirlpoolTiles)
	ld l, a
	adc HIGH(WhirlpoolTiles)
	sub l
	ld h, a

; mess with the stack pointer
	ld [hSPTemp], sp
    ld sp, hl

; NW
	ld hl, vTileset tile $10
REPT (16 / 2) - 1
    pop de
    ld a, e
    ld [hli], a
    ld a, d
    ld [hli], a
ENDR
    pop de
    ld a, e
    ld [hli], a
    ld [hl], d
; NE
	ld hl, vTileset tile $5E
REPT (16 / 2) - 1
    pop de
    ld a, e
    ld [hli], a
    ld a, d
    ld [hli], a
ENDR
    pop de
    ld a, e
    ld [hli], a
    ld [hl], d
; SW
	ld hl, vTileset tile $20
REPT (16 / 2) - 1
    pop de
    ld a, e
    ld [hli], a
    ld a, d
    ld [hli], a
ENDR
    pop de
    ld a, e
    ld [hli], a
    ld [hl], d
; SE
	ld hl, vTileset tile $21
REPT (16 / 2) - 1
    pop de
    ld a, e
    ld [hli], a
    ld a, d
    ld [hli], a
ENDR
    pop de
    ld a, e
    ld [hli], a
    ld [hl], d

; restore the stack pointer
	ld sp, hSPTemp
    pop hl
    ld sp, hl

	ret

WhirlpoolTiles::
INCBIN "gfx/tilesets/whirlpool/whirlpool1.2bpp"
INCBIN "gfx/tilesets/whirlpool/whirlpool2.2bpp"
INCBIN "gfx/tilesets/whirlpool/whirlpool3.2bpp"
INCBIN "gfx/tilesets/whirlpool/whirlpool4.2bpp"

; ==================================================================

AnimateWaterfallTile:: ; new
	ld a, [wCurMapTileset]
	cp CAVERN
	ret nz

    ld [hSPTemp], sp
    ld sp, vTileset tile $50
    ld hl, (vTileset tile $50) + 2

    pop bc
    pop de
    ld a, c
    ld [hli], a
    ld a, b
    ld [hli], a
REPT 3
    pop bc
    ld a, e
    ld [hli], a
    ld a, d
    ld [hli], a
    pop de
    ld a, c
    ld [hli], a
    ld a, b
    ld [hli], a
ENDR
    ld hl, vTileset tile $50
    ld a, e
    ld [hli], a
    ld [hl], d

    ld sp, hSPTemp
    pop hl
    ld sp, hl
	ret
