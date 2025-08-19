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

AnimateWhirlpoolTiles::
	CheckEvent EVENT_IN_SEVII
	ret z

	ld a, [wMovingBGTilesCounter2]
	and 3

	and a
	jp z, .step1
	cp 1
	jr z, .step2
	cp 2
	jr z, .step3

;.step4
; NW
	ld hl, WhirlpoolTileNW4
	ld de, vTileset tile $10 ; NW corner
	ld c, $10
.loopNW4
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loopNW4
; NE
	ld hl, WhirlpoolTileNE4
	ld de, vTileset tile $5E ; NE corner
	ld c, $10
.loopNE4
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loopNE4
; SW
	ld hl, WhirlpoolTileSW4
	ld de, vTileset tile $20 ; SW corner
	ld c, $10
.loopSW4
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loopSW4
; SE
	ld hl, WhirlpoolTileSE4
	ld de, vTileset tile $21 ; SE corner
	ld c, $10
.loopSE4
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loopSE4
	ret

.step3
; NW
	ld hl, WhirlpoolTileNW3
	ld de, vTileset tile $10 ; NW corner
	ld c, $10
.loopNW3
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loopNW3
; NE
	ld hl, WhirlpoolTileNE3
	ld de, vTileset tile $5E ; NE corner
	ld c, $10
.loopNE3
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loopNE3
; SW
	ld hl, WhirlpoolTileSW3
	ld de, vTileset tile $20 ; SW corner
	ld c, $10
.loopSW3
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loopSW3
; SE
	ld hl, WhirlpoolTileSE3
	ld de, vTileset tile $21 ; SE corner
	ld c, $10
.loopSE3
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loopSE3
	ret

.step2
; NW
	ld hl, WhirlpoolTileNW2
	ld de, vTileset tile $10 ; NW corner
	ld c, $10
.loopNW2
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loopNW2
; NE
	ld hl, WhirlpoolTileNE2
	ld de, vTileset tile $5E ; NE corner
	ld c, $10
.loopNE2
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loopNE2
; SW
	ld hl, WhirlpoolTileSW2
	ld de, vTileset tile $20 ; SW corner
	ld c, $10
.loopSW2
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loopSW2
; SE
	ld hl, WhirlpoolTileSE2
	ld de, vTileset tile $21 ; SE corner
	ld c, $10
.loopSE2
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loopSE2
	ret

.step1
; NW
	ld hl, WhirlpoolTileNW1
	ld de, vTileset tile $10 ; NW corner
	ld c, $10
.loopNW1
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loopNW1
; NE
	ld hl, WhirlpoolTileNE1
	ld de, vTileset tile $5E ; NE corner
	ld c, $10
.loopNE1
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loopNE1
; SW
	ld hl, WhirlpoolTileSW1
	ld de, vTileset tile $20 ; SW corner
	ld c, $10
.loopSW1
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loopSW1
; SE
	ld hl, WhirlpoolTileSE1
	ld de, vTileset tile $21 ; SE corner
	ld c, $10
.loopSE1
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loopSE1
	ret

WhirlpoolTileNW1: INCBIN "gfx/tilesets/whirlpool/whirlpoolNW1.2bpp"
WhirlpoolTileNW2: INCBIN "gfx/tilesets/whirlpool/whirlpoolNW2.2bpp"
WhirlpoolTileNW3: INCBIN "gfx/tilesets/whirlpool/whirlpoolNW3.2bpp"
WhirlpoolTileNW4: INCBIN "gfx/tilesets/whirlpool/whirlpoolNW4.2bpp"

WhirlpoolTileNE1: INCBIN "gfx/tilesets/whirlpool/whirlpoolNE1.2bpp"
WhirlpoolTileNE2: INCBIN "gfx/tilesets/whirlpool/whirlpoolNE2.2bpp"
WhirlpoolTileNE3: INCBIN "gfx/tilesets/whirlpool/whirlpoolNE3.2bpp"
WhirlpoolTileNE4: INCBIN "gfx/tilesets/whirlpool/whirlpoolNE4.2bpp"

WhirlpoolTileSW1: INCBIN "gfx/tilesets/whirlpool/whirlpoolSW1.2bpp"
WhirlpoolTileSW2: INCBIN "gfx/tilesets/whirlpool/whirlpoolSW2.2bpp"
WhirlpoolTileSW3: INCBIN "gfx/tilesets/whirlpool/whirlpoolSW3.2bpp"
WhirlpoolTileSW4: INCBIN "gfx/tilesets/whirlpool/whirlpoolSW4.2bpp"

WhirlpoolTileSE1: INCBIN "gfx/tilesets/whirlpool/whirlpoolSE1.2bpp"
WhirlpoolTileSE2: INCBIN "gfx/tilesets/whirlpool/whirlpoolSE2.2bpp"
WhirlpoolTileSE3: INCBIN "gfx/tilesets/whirlpool/whirlpoolSE3.2bpp"
WhirlpoolTileSE4: INCBIN "gfx/tilesets/whirlpool/whirlpoolSE4.2bpp"

; ==================================================================
