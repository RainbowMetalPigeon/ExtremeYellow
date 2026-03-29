LoadSpinnerArrowTiles::
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;joenote - This ties the spin frame update to an external counter.
;			It will only get updated every 4 overworld updates (half that if in 60fps mode).
;			CopyVideoData only gets run 1 time as well, and it supplants 1 DelayFrame in OverworldLoop.
;			Now there are no wasted frames when this runs, and spin movement is now at full speed.
	push bc
	ld b, 2
	ld c, b
	inc c
	ld a, [wSpinnerTileFrameCount]
	cp c
	jr c, .notgreater
	ld a, b
	ld [wSpinnerTileFrameCount], a
	jr .noadjust
.notgreater
	cp 1
	jr nc, .noadjust
	ld a, b
	ld [wSpinnerTileFrameCount], a
.noadjust
	pop bc
	ld a, [wSpinnerTileFrameCount]
	dec a
	ld [wSpinnerTileFrameCount], a
	ret nz
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ld a, [wSpritePlayerStateData1ImageIndex]
	srl a
	srl a
	ld hl, SpinnerPlayerFacingDirections
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [hl]
	ld [wSpritePlayerStateData1ImageIndex], a
	ld a, [wCurMapTileset]
	cp FACILITY
	ld hl, FacilitySpinnerArrows
	jr z, .gotSpinnerArrows
	ld hl, GymSpinnerArrows
.gotSpinnerArrows
	ld a, [wSimulatedJoypadStatesIndex]
	bit 0, a
	jr nz, .alternateGraphics
	ld de, 6 * 4
	add hl, de
.alternateGraphics
	ld a, $4 ; edited, was $4 in vanilla
	ld bc, $0
.loop
	push af
	push hl
	push bc
	add hl, bc
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call CopyVideoData
	pop bc
	ld a, $6
	add c
	ld c, a
	pop hl
	pop af
	dec a
	jr nz, .loop
	ret

INCLUDE "data/tilesets/spinner_tiles.asm"

SpinnerPlayerFacingDirections:
; This isn't the order of the facing directions.  Rather, it's a list of
; the facing directions that come next. For example, when the player is
; facing down (00), the next facing direction is left (08).
	db $08 ; down -> left
	db $0C ; up -> right
	db $04 ; left -> up
	db $00 ; right -> down

; these tiles are the animation for the tiles that push the player in dungeons like Rocket HQ
SpinnerArrowAnimTiles:
	INCBIN "gfx/overworld/spinners.2bpp"
