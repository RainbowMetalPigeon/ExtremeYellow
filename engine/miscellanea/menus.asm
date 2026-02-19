DrawTypeChartInfo::

	ld de, RedPicFront
	lb bc, BANK(RedPicFront), $01
	ld a, [wPlayerGender]
	and a
	jr z, .ContinueWithLoading
	cp a, 2
	jr z, .AreEnby
	ld de, GreenPicFront
	lb bc, BANK(GreenPicFront), $01
	jr .ContinueWithLoading
.AreEnby
	ld de, YellowPicFront
	lb bc, BANK(YellowPicFront), $01
.ContinueWithLoading
	predef DisplayPicCenteredOrUpperRight

	call DisableLCD

	hlcoord 0, 2
	ld a, " "
	call TrainerInfo_DrawVerticalLine2

	hlcoord 1, 2
	call TrainerInfo_DrawVerticalLine2

	ld hl, vChars2 tile $07
	ld de, vChars2 tile $00
	ld bc, $1c tiles
	call CopyData ; copies bc bytes from hl to de

	ld hl, TrainerInfoTextBoxTileGraphics ; trainer info text box tile patterns
	ld de, vChars2 tile $77
	ld bc, 8 tiles
	push bc
	call TrainerInfo_FarCopyData2

	ld hl, BlankLeaderNames
	ld de, vChars2 tile $60
	ld bc, $17 tiles
	call TrainerInfo_FarCopyData2
	pop bc

	ld hl, BadgeNumbersTileGraphics  ; badge number tile patterns
	ld de, vChars1 tile $58
	call TrainerInfo_FarCopyData2

	ld hl, GymLeaderFaceAndBadgeTileGraphics  ; gym leader face and badge tile patterns
	ld de, vChars2 tile $20
	ld bc, 8 * 8 tiles
	ld a, BANK(GymLeaderFaceAndBadgeTileGraphics)
	call FarCopyData

	ld hl, TextBoxGraphics
	ld de, 13 tiles
	add hl, de ; hl = colon tile pattern
	ld de, vChars1 tile $56
	ld bc, 1 tiles
	ld a, BANK(TextBoxGraphics)
	push bc
	call FarCopyData
	pop bc

	ld hl, TrainerInfoTextBoxTileGraphics tile 8  ; background tile pattern
	ld de, vChars1 tile $57
	call TrainerInfo_FarCopyData2

	call EnableLCD

	ld hl, wTrainerInfoTextBoxWidthPlus1
	ld a, 18 + 1
	ld [hli], a
	dec a
	ld [hli], a
	ld [hl], 1

	hlcoord 0, 0
	call TrainerInfo_DrawTextBox2

	ld hl, wTrainerInfoTextBoxWidthPlus1
	ld a, 16 + 1
	ld [hli], a
	dec a
	ld [hli], a
	ld [hl], 3

	hlcoord 1, 10
	call TrainerInfo_DrawTextBox2

	hlcoord 0, 10
	ld a, $d7
	call TrainerInfo_DrawVerticalLine2

	hlcoord 19, 10
	call TrainerInfo_DrawVerticalLine2

	hlcoord 6, 9
	ld de, TrainerInfo_BadgesText2
	call PlaceString

	hlcoord 2, 2
	ld de, TrainerInfo_NameMoneyTimeText2
	call PlaceString

	hlcoord 7, 2
	ld de, wPlayerName
	call PlaceString

	hlcoord 8, 4
	ld de, wPlayerMoney
	ld c, $e3
	call PrintBCDNumber

	hlcoord 7, 6 ; edited, was 9, 6
	ld de, wPlayTimeHours ; hours
	lb bc, LEFT_ALIGN | 2, 5 ; edited, was 1, 3
	call PrintNumber ; Print the c-digit, b-byte value at de.

	ld [hl], ":" ; edited, to expand tileset

	inc hl
	ld de, wPlayTimeMinutes ; minutes
	lb bc, LEADING_ZEROES | 1, 2
	jp PrintNumber

; --------------------------------------------------------------

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

; =====================================================

; input: d = attacking type; e = defending type
; output: [wTypeEffectiveness]: 0 is not effective, 1 double not effective, 2 not effective, 4 neutral, 8 super effective, 16 double super effective
DetermineEffectiveness:
	ld a, d
	ld [wEnemyMoveType], a
	ld a, e
	ld [wBattleMonType1], a
	ld [wBattleMonType2], a
	jpfar AIGetTypeEffectiveness ; output in wTypeEffectiveness

TypeListsForChart:
	db NORMAL       ;  0
	db FIGHTING     ;  1
	db FLYING       ;  2
	db POISON       ;  3
	db GROUND       ;  4
	db ROCK         ;  5
	db BUG          ;  7
	db GHOST        ;  8
	db STEEL        ;  9
	db FIRE         ; 10
	db WATER        ; 11
	db GRASS        ; 12
	db ELECTRIC     ; 13
	db PSYCHIC_TYPE ; 14
	db ICE          ; 15
	db DRAGON       ; 16
	db DARK         ; 17
	db FAIRY        ; 18
	db -1





;a
