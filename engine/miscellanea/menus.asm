DrawTypeChartInfo::

	call DisableLCD

	ld hl, TypeChartTileGraphics  ; badge number tile patterns
	ld de, vChars2 tile $00
	ld bc, TypeChartTileGraphicsEnd - TypeChartTileGraphics
	call CopyData

	call EnableLCD

	call DrawTypeHeader

	ld de, TypeListsForChart
	hlcoord  2,  0
	ld a, [wPersonalizationTCGMode]
	and a
	jr z, .loopOffensive
	ld de, TypeListsForChart_TCG
	hlcoord  2,  2
	
.loopOffensive
	ld a, [de]
	inc de
	push de
	cp -1
	jr z, .doneWithOffensive

	ld b, a

	ld de, TypeListsForChart
	ld a, [wPersonalizationTCGMode]
	and a
	jr z, .loopDefensive
	ld de, TypeListsForChart_TCG

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
	ld a, [wPersonalizationTCGMode]
	and a
	jr z, .loopOffensive
	inc hl
	inc hl
	inc hl
	inc hl
	inc hl
	inc hl
	inc hl
	inc hl

	jr .loopOffensive

.doneWithOffensive
	pop de

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
	db NORMAL       ; $00
	db FIRE         ; $14
	db WATER        ; $15
	db ELECTRIC     ; $17
	db GRASS        ; $16
	db ICE          ; $19
	db FIGHTING     ; $01
	db POISON       ; $03
	db GROUND       ; $04
	db FLYING       ; $02
	db PSYCHIC_TYPE ; $18
	db BUG          ; $07
	db ROCK         ; $05
	db GHOST        ; $08
	db DRAGON       ; $1A
	db DARK         ; $1B
	db STEEL        ; $09
	db FAIRY        ; $1C
	db -1

TypeListsForChart_TCG:
	db TCG_COLORLESS   ;  0
	db TCG_FIRE        ;  1
	db TCG_WATER       ;  2
	db TCG_LIGHTNING   ;  3
	db TCG_GRASS       ;  4
	db TCG_FIGHTING    ;  5
	db TCG_PSYCHIC     ;  6
	db TCG_DRAGON      ;  7
	db TCG_DARK        ;  8
	db TCG_METAL       ;  9
	db -1

DrawTypeHeader:
	ld a, [wPersonalizationTCGMode]
	and a
	jp z, .nonTCG
; TCG vertical
	; COLORLESS
	hlcoord  0,  2
	ld [hl], $30
	inc hl
	ld [hl], $31
	; FIRE
	hlcoord  0,  3
	ld [hl], $18
	inc hl
	ld [hl], $19
	; WATER
	hlcoord  0,  4
	ld [hl], $0A
	inc hl
	ld [hl], $0B
	; LIGHTNING
	hlcoord  0,  5
	ld [hl], $32
	inc hl
	ld [hl], $33
	; GRASS
	hlcoord  0,  6
	ld [hl], $1A
	inc hl
	ld [hl], $1B
	; FIGHTING
	hlcoord  0,  7
	ld [hl], $20
	inc hl
	ld [hl], $21
	; PSYCHIC
	hlcoord  0,  8
	ld [hl], $1C
	inc hl
	ld [hl], $1D
	; DRAGON
	hlcoord  0,  9
	ld [hl], $1E
	inc hl
	ld [hl], $1F
	; DARK
	hlcoord  0, 10
	ld [hl], $10
	inc hl
	ld [hl], $11
	; STEEL
	hlcoord  0, 11
	ld [hl], $08
	inc hl
	ld [hl], $09
; TCG horizontal
	; COLORLESS
	hlcoord   2,  0
	ld [hl], $40
	hlcoord   2,  1
	ld [hl], $50
	; FIRE
	hlcoord   3,  0
	ld [hl], $41
	hlcoord   3,  1
	ld [hl], $51
	; WATER
	hlcoord   4,  0
	ld [hl], $42
	hlcoord   4,  1
	ld [hl], $52
	; LIGHTNING
	hlcoord   5,  0
	ld [hl], $43
	hlcoord   5,  1
	ld [hl], $53
	; GRASS
	hlcoord   6,  0
	ld [hl], $44
	hlcoord   6,  1
	ld [hl], $54
	; FIGHTING
	hlcoord   7,  0
	ld [hl], $45
	hlcoord   7,  1
	ld [hl], $55
	; PSYCHIC
	hlcoord   8,  0
	ld [hl], $46
	hlcoord   8,  1
	ld [hl], $56
	; DRAGON
	hlcoord   9,  0
	ld [hl], $47
	hlcoord   9,  1
	ld [hl], $57
	; DARK
	hlcoord  10,  0
	ld [hl], $48
	hlcoord  10,  1
	ld [hl], $58
	; STEEL
	hlcoord  11,  0
	ld [hl], $49
	hlcoord  11,  1
	ld [hl], $59

	ret

.nonTCG
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
