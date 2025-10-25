SeviiFiveIslandWarehouse1F_Script:
	call SeviiFiveIslandWarehouse1FSetDoorBlock
	call EnableAutoTextBoxDrawing
	ld de, SeviiFiveIslandWarehouse1F_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

SeviiFiveIslandWarehouse1FSetDoorBlock:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
	CheckEvent EVENT_SEVII_FIVE_ISLAND_WAREHOUSE_BF_OPENED_DOOR_2
	jr nz, .doorsOpen
	ld a, $2D ; door block ID
	jr .replaceBlock
.doorsOpen
	ld a, $0E ; clear floor block ID
.replaceBlock
	ld [wNewTileBlockID], a
	lb bc,  2,  5
	predef_jump ReplaceTileBlock

SeviiFiveIslandWarehouse1F_ScriptPointers:
	dw SeviiFiveIslandWarehouse1FScript0
	dw SeviiFiveIslandWarehouse1FScript1

SeviiFiveIslandWarehouse1FScript0:
	ld a, [wYCoord]
	ld b, a
	ld a, [wXCoord]
	ld c, a
	ld hl, SeviiFiveIslandWarehouse1FArrowTilePlayerMovement
	call DecodeArrowMovementRLE
	cp $ff
	ret z
	call StartSimulatingJoypadStates
	ld hl, wd736
	set 7, [hl]
	ld a, SFX_ARROW_TILES
	call PlaySound
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, 1
	ld [wCurMapScript], a
	ret

SeviiFiveIslandWarehouse1FScript1:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	jr nz, .SeviiFiveIslandWarehouse1FLoadSpinnerArrow
	xor a
	ld [wJoyIgnore], a
	ld hl, wd736
	res 7, [hl]
	ld a, $0
	ld [wCurMapScript], a
	ret
.SeviiFiveIslandWarehouse1FLoadSpinnerArrow
	farjp LoadSpinnerArrowTiles

; ================ spinners - beginning ================

SeviiFiveIslandWarehouse1FArrowTilePlayerMovement:
	; left room

	map_coord_movement  3,  2, Sevii_Spinner_RIGHT_3
	map_coord_movement  6,  2, Sevii_Spinner_DOWN_5

	map_coord_movement  2,  3, Sevii_Spinner_RIGHT_5
	map_coord_movement  7,  3, Sevii_Spinner_DOWN_3

	map_coord_movement  4,  6, Sevii_Spinner_DOWN_7
	map_coord_movement  7,  6, Sevii_Spinner_LEFT_3
	map_coord_movement  8,  6, Sevii_Spinner_DOWN_2

	map_coord_movement  5,  7, Sevii_Spinner_DOWN_5
	map_coord_movement  6,  7, Sevii_Spinner_LEFT_1
	map_coord_movement  9,  7, Sevii_Spinner_DOWN_2

	map_coord_movement  8,  8, Sevii_Spinner_DOWN_10
	map_coord_movement 11,  8, Sevii_Spinner_UP_2

	map_coord_movement  9,  9, Sevii_Spinner_DOWN_9
	map_coord_movement 10,  9, Sevii_Spinner_UP_3

	map_coord_movement  5, 12, Sevii_Spinner_RIGHT_6
	map_coord_movement 11, 12, Sevii_Spinner_UP_4

	map_coord_movement  4, 13, Sevii_Spinner_RIGHT_6
	map_coord_movement 10, 13, Sevii_Spinner_UP_4

	map_coord_movement  3, 14, Sevii_Spinner_UP_12

	map_coord_movement  2, 15, Sevii_Spinner_UP_12

	map_coord_movement  8, 18, Sevii_Spinner_RIGHT_1
	map_coord_movement  9, 18, Sevii_Spinner_DOWN_2

	map_coord_movement  7, 20, Sevii_Spinner_LEFT_6
	map_coord_movement  9, 20, Sevii_Spinner_LEFT_2

	; right room

	map_coord_movement 18,  2, Sevii_Spinner_RIGHT_2
	map_coord_movement 20,  2, Sevii_Spinner_DOWN_5

	map_coord_movement 19,  4, Sevii_Spinner_DOWN_2
	map_coord_movement 21,  4, Sevii_Spinner_LEFT_2

	map_coord_movement 16,  5, Sevii_Spinner_LEFT_1
	map_coord_movement 18,  5, Sevii_Spinner_UP_3
	map_coord_movement 24,  5, Sevii_Spinner_DOWN_4

	map_coord_movement 17,  6, Sevii_Spinner_LEFT_2
	map_coord_movement 19,  6, Sevii_Spinner_RIGHT_3
	map_coord_movement 22,  6, Sevii_Spinner_RIGHT_3
	map_coord_movement 25,  6, Sevii_Spinner_DOWN_7

	map_coord_movement 16,  7, Sevii_Spinner_UP_2
	map_coord_movement 18,  7, Sevii_Spinner_DOWN_3
	map_coord_movement 20,  7, Sevii_Spinner_DOWN_2

	map_coord_movement 17,  8, Sevii_Spinner_LEFT_2

	map_coord_movement 17,  9, Sevii_Spinner_LEFT_2
	map_coord_movement 20,  9, Sevii_Spinner_DOWN_2
	map_coord_movement 24,  9, Sevii_Spinner_DOWN_3

	map_coord_movement 17, 10, Sevii_Spinner_DOWN_2
	map_coord_movement 18, 10, Sevii_Spinner_LEFT_1
	map_coord_movement 21, 10, Sevii_Spinner_UP_6

	map_coord_movement 16, 11, Sevii_Spinner_UP_4
	map_coord_movement 19, 11, Sevii_Spinner_UP_5

	map_coord_movement 17, 12, Sevii_Spinner_DOWN_2
	map_coord_movement 19, 12, Sevii_Spinner_UP_1
	map_coord_movement 21, 12, Sevii_Spinner_LEFT_2
	map_coord_movement 24, 12, Sevii_Spinner_LEFT_3

	map_coord_movement 13, 13, Sevii_Spinner_RIGHT_5
	map_coord_movement 20, 13, Sevii_Spinner_LEFT_2
	map_coord_movement 23, 13, Sevii_Spinner_LEFT_3
	map_coord_movement 25, 13, Sevii_Spinner_DOWN_7

	map_coord_movement 17, 14, Sevii_Spinner_DOWN_4

	map_coord_movement 32, 18, Sevii_Spinner_LEFT_4

	map_coord_movement 13, 20, Sevii_Spinner_UP_7
	map_coord_movement 25, 20, Sevii_Spinner_RIGHT_7
	map_coord_movement 32, 20, Sevii_Spinner_UP_2

	db -1 ; end

Sevii_Spinner_UP_1:
	db D_UP, 1
	db -1 ; end
Sevii_Spinner_UP_2:
	db D_UP, 2
	db -1 ; end
Sevii_Spinner_UP_3:
	db D_UP, 3
	db -1 ; end
Sevii_Spinner_UP_4:
	db D_UP, 4
	db -1 ; end
Sevii_Spinner_UP_5:
	db D_UP, 5
	db -1 ; end
Sevii_Spinner_UP_6:
	db D_UP, 6
	db -1 ; end
Sevii_Spinner_UP_7:
	db D_UP, 7
	db -1 ; end
Sevii_Spinner_UP_8:
	db D_UP, 8
	db -1 ; end
Sevii_Spinner_UP_12:
	db D_UP, 12
	db -1 ; end

Sevii_Spinner_DOWN_1:
	db D_DOWN, 1
	db -1 ; end
Sevii_Spinner_DOWN_2:
	db D_DOWN, 2
	db -1 ; end
Sevii_Spinner_DOWN_3:
	db D_DOWN, 3
	db -1 ; end
Sevii_Spinner_DOWN_4:
	db D_DOWN, 4
	db -1 ; end
Sevii_Spinner_DOWN_5:
	db D_DOWN, 5
	db -1 ; end
Sevii_Spinner_DOWN_6:
	db D_DOWN, 6
	db -1 ; end
Sevii_Spinner_DOWN_7:
	db D_DOWN, 7
	db -1 ; end
Sevii_Spinner_DOWN_9:
	db D_DOWN, 9
	db -1 ; end
Sevii_Spinner_DOWN_10:
	db D_DOWN, 10
	db -1 ; end

Sevii_Spinner_LEFT_1:
	db D_LEFT, 1
	db -1 ; end
Sevii_Spinner_LEFT_2:
	db D_LEFT, 2
	db -1 ; end
Sevii_Spinner_LEFT_3:
	db D_LEFT, 3
	db -1 ; end
Sevii_Spinner_LEFT_4:
	db D_LEFT, 4
	db -1 ; end
Sevii_Spinner_LEFT_5:
	db D_LEFT, 5
	db -1 ; end
Sevii_Spinner_LEFT_6:
	db D_LEFT, 6
	db -1 ; end
Sevii_Spinner_LEFT_7:
	db D_LEFT, 7
	db -1 ; end
Sevii_Spinner_LEFT_13:
	db D_LEFT, 13
	db -1 ; end

Sevii_Spinner_RIGHT_1:
	db D_RIGHT, 1
	db -1 ; end
Sevii_Spinner_RIGHT_2:
	db D_RIGHT, 2
	db -1 ; end
Sevii_Spinner_RIGHT_3:
	db D_RIGHT, 3
	db -1 ; end
Sevii_Spinner_RIGHT_4:
	db D_RIGHT, 4
	db -1 ; end
Sevii_Spinner_RIGHT_5:
	db D_RIGHT, 5
	db -1 ; end
Sevii_Spinner_RIGHT_6:
	db D_RIGHT, 6
	db -1 ; end
Sevii_Spinner_RIGHT_7:
	db D_RIGHT, 7
	db -1 ; end
Sevii_Spinner_RIGHT_8:
	db D_RIGHT, 8
	db -1 ; end

; ================ spinners - end ================

SeviiFiveIslandWarehouse1F_TextPointers:
	dw SeviiFiveIslandWarehouse1FText1
	dw SeviiFiveIslandWarehouse1FText2
	dw PickUpItemText
	dw PickUpItemText
	dw SeviiFiveIslandWarehouse1FSignText1
	dw SeviiFiveIslandWarehouse1FSignText2

SeviiFiveIslandWarehouse1FText1:
	text_far _SeviiFiveIslandWarehouse1FText1
	text_end

SeviiFiveIslandWarehouse1FText2:
	text_far _SeviiFiveIslandWarehouse1FText2
	text_end

SeviiFiveIslandWarehouse1FSignText1:
SeviiFiveIslandWarehouse1FSignText2:
	text_asm
	CheckEvent EVENT_SEVII_FIVE_ISLAND_WAREHOUSE_BF_OPENED_DOOR_2
	ld hl, SeviiFiveIslandWarehouse1FSignText1_DoorIsOpen
	jr nz, .printAndEnd
; require password
	call SaveScreenTilesToBuffer2
	ld hl, SeviiFiveIslandWarehouse1FSignText1_RequiresPassword
	call PrintText
	call WaitForTextScrollButtonPress
	farcall DisplayUniQuizScreen
.checkTheAnswer
	ld a, [wUniQuizAnswer]
	cp "A"
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+1]
	cp "L"
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+2]
	cp "L"
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+3]
	cp "@"
	jr z, .rightAnswer
.wrongAnswer
	ld a, SFX_DENIED
	call PlaySound
	ld hl, SeviiFiveIslandWarehouse1FSignText1_Wrong
	jr .printAndEnd
.rightAnswer
	ld a, SFX_GO_INSIDE
	call PlaySound
	SetEvent EVENT_SEVII_FIVE_ISLAND_WAREHOUSE_BF_OPENED_DOOR_2
	ld a, $0E ; clear floor block ID
	ld [wNewTileBlockID], a
	lb bc,  2,  5
	predef ReplaceTileBlock
	ld hl, SeviiFiveIslandWarehouse1FSignText1_Right
.printAndEnd
	call PrintText
.done
	jp TextScriptEnd

SeviiFiveIslandWarehouse1FSignText1_RequiresPassword:
	text_far _SeviiFiveIslandWarehouse_InsertPassword
	text_end

SeviiFiveIslandWarehouse1FSignText1_Wrong:
	text_far _SeviiFiveIslandWarehouse_WrongPassword
	text_end

SeviiFiveIslandWarehouse1FSignText1_Right:
	text_far _SeviiFiveIslandWarehouse_CorrectPassword
	text_end

SeviiFiveIslandWarehouse1FSignText1_DoorIsOpen:
	text_far _SeviiFiveIslandWarehouse_DoorIsOpen
	text_end