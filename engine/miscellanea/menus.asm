DrawTypeChartInfo::

	call DisableLCD

	ld hl, TypeChartTileGraphics  ; badge number tile patterns
	ld de, vChars2 tile $00
	ld bc, TypeChartTileGraphicsEnd - TypeChartTileGraphics
	call CopyData

	call EnableLCD

	call DrawTypeHeader

;	hlcoord  1,  0
;	ld [hl], $50
;	inc hl
;	ld [hl], $51
;	inc hl
;	ld [hl], $52
;	inc hl
;	ld [hl], $53
;	inc hl
;
;	hlcoord  3,  1
;	ld a, 8
;	ld [wTypeEffectiveness], a
;	call PlaceTileDependingOnEffectiveness


	ld de, TypeListsForChart
	hlcoord  2,  0
.loopOffensive
	ld a, [de]
	inc de
	push de
	cp -1
	jr z, .doneWithOffensive

	ld b, a
	ld de, TypeListsForChart
.loopDefensive
	ld a, [de]
	cp -1
	jr z, .doneWithDefensive
	ld c, a
	push hl
	push de
	push bc
	call DetermineEffectiveness ; input: b=ATK, c=DEF; output: wTypeEffectiveness 0-1-2-4-8-16
	pop bc
	pop de
	pop hl
	call PlaceTileDependingOnEffectiveness
	inc hl
	inc de
	jr .loopDefensive
.doneWithDefensive

	pop de
	inc hl
	inc hl

	jr .loopOffensive

.doneWithOffensive

	ret

; ====================================================================================

; input: b = attacking type; c = defending type
; output: [wTypeEffectiveness]: 0 is not effective, 1 double not effective, 2 not effective, 4 neutral, 8 super effective, 16 double super effective
DetermineEffectiveness:
	ld a, b
	ld [wEnemyMoveType], a
	ld a, c
	ld [wBattleMonType1], a
	ld [wBattleMonType2], a
	jpfar AIGetTypeEffectiveness ; output in wTypeEffectiveness

; inputs: hlcoord, wTypeEffectiveness value
PlaceTileDependingOnEffectiveness:
	ld a, [wTypeEffectiveness]
	cp 4 ; neutral
	ld [hl], $24
	ret z
	and a ; no effective
	ld [hl], $27
	ret z
	cp 2 ; not very effective
	ld [hl], $26
	ret z
	; super effective
	ld [hl], $25
	ret

TypeListsForChart:
	db NORMAL       ;  0
	db FIRE         ;  1
	db WATER        ;  2
	db ELECTRIC     ;  3
	db GRASS        ;  4
	db ICE          ;  5
	db FIGHTING     ;  6
	db POISON       ;  7
	db GROUND       ;  8
	db FLYING       ;  9
	db PSYCHIC_TYPE ; 10
	db BUG          ; 11
	db ROCK         ; 12
	db GHOST        ; 13
	db DRAGON       ; 14
	db DARK         ; 15
	db STEEL        ; 16
	db FAIRY        ; 17
	db -1

DrawTypeHeader:
	; NORMAL
	hlcoord  0,  0
	ld [hl], $00
	inc hl
	ld [hl], $01

	; FIRE
	hlcoord  0,  1
	ld [hl], $18
	inc hl
	ld [hl], $19

	; WATER
	hlcoord  0,  2
	ld [hl], $0A
	inc hl
	ld [hl], $0B

	; ELECTRIC
	hlcoord  0,  3
	ld [hl], $0C
	inc hl
	ld [hl], $0D

	; GRASS
	hlcoord  0,  4
	ld [hl], $1A
	inc hl
	ld [hl], $1B

	; ICE
	hlcoord  0,  5
	ld [hl], $0E
	inc hl
	ld [hl], $0F

	; FIGHTING
	hlcoord  0,  6
	ld [hl], $20
	inc hl
	ld [hl], $21

	; POISON
	hlcoord  0,  7
	ld [hl], $22
	inc hl
	ld [hl], $23

	; GROUND
	hlcoord  0,  8
	ld [hl], $04
	inc hl
	ld [hl], $05

	; FLYING
	hlcoord  0,  9
	ld [hl], $02
	inc hl
	ld [hl], $03

	; PSYCHIC_TYPE
	hlcoord  0, 10
	ld [hl], $1C
	inc hl
	ld [hl], $1D

	; BUG
	hlcoord  0, 11
	ld [hl], $06
	inc hl
	ld [hl], $07

	; ROCK
	hlcoord  0, 12
	ld [hl], $14
	inc hl
	ld [hl], $15

	; GHOST
	hlcoord  0, 13
	ld [hl], $16
	inc hl
	ld [hl], $17

	; DRAGON
	hlcoord  0, 14
	ld [hl], $1E
	inc hl
	ld [hl], $1F

	; DARK
	hlcoord  0, 15
	ld [hl], $10
	inc hl
	ld [hl], $11

	; STEEL
	hlcoord  0, 16
	ld [hl], $08
	inc hl
	ld [hl], $09

	; FAIRY
	hlcoord  0, 17
	ld [hl], $12
	inc hl
	ld [hl], $13

	ret

; ====================================================================================

TypeChartTileGraphics:  INCBIN "gfx/pokedex/type_chart_font.2bpp"
TypeChartTileGraphicsEnd:

; ====================================================================================

; draws a vertical line
; INPUT:
; hl = address of top tile in the line
; a = tile ID
TrainerInfo_DrawVerticalLine2:
	ld de, SCREEN_WIDTH
	ld c, 8
.loop
	ld [hl], a
	add hl, de
	dec c
	jr nz, .loop
	ret

TrainerInfo_FarCopyData2:
	ld a, BANK(TrainerInfoTextBoxTileGraphics)
	jp FarCopyData

; draws a text box on the trainer info screen
; height is always 6
; INPUT:
; hl = destination address
; [wTrainerInfoTextBoxWidthPlus1] = width
; [wTrainerInfoTextBoxWidth] = width - 1
; [wTrainerInfoTextBoxNextRowOffset] = distance from the end of a text box row to the start of the next
TrainerInfo_DrawTextBox2:
	ld a, $79 ; upper left corner tile ID
	lb de, $7a, $7b ; top edge and upper right corner tile ID's
	call TrainerInfo_DrawHorizontalEdge2 ; draw top edge
	call TrainerInfo_NextTextBoxRow2
	ld a, [wTrainerInfoTextBoxWidthPlus1]
	ld e, a
	ld d, 0
	ld c, 6 ; height of the text box
.loop
	ld [hl], $7c ; left edge tile ID
	add hl, de
	ld [hl], $78 ; right edge tile ID
	call TrainerInfo_NextTextBoxRow2
	dec c
	jr nz, .loop
	ld a, $7d ; lower left corner tile ID
	lb de, $77, $7e ; bottom edge and lower right corner tile ID's

TrainerInfo_DrawHorizontalEdge2:
	ld [hli], a ; place left corner tile
	ld a, [wTrainerInfoTextBoxWidth]
	ld c, a
	ld a, d
.loop
	ld [hli], a ; place edge tile
	dec c
	jr nz, .loop
	ld a, e
	ld [hl], a ; place right corner tile
	ret

TrainerInfo_NextTextBoxRow2:
	ld a, [wTrainerInfoTextBoxNextRowOffset] ; distance to the start of the next row
.loop
	inc hl
	dec a
	jr nz, .loop
	ret

TrainerInfo_NameMoneyTimeText2:
	db   "NAME/"
	next "MONEY/"
	next "TIME/@"

; $76 is a circle tile
TrainerInfo_BadgesText2:
	db $76,"BADGES",$76,"@"
