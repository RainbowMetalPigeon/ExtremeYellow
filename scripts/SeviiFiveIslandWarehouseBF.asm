SeviiFiveIslandWarehouseBF_Script:
	call SeviiFiveIslandWarehouseBFSetDoorBlock
	jp EnableAutoTextBoxDrawing

SeviiFiveIslandWarehouseBFSetDoorBlock:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
; stop spinning
	ld hl, wd736
	res 7, [hl]
	CheckEvent EVENT_SEVII_FIVE_ISLAND_WAREHOUSE_BF_OPENED_DOOR_3
	jr nz, .doorsOpen
	ld a, $54 ; door block ID
	jr .replaceBlock
.doorsOpen
	ld a, $0E ; clear floor block ID
.replaceBlock
	ld [wNewTileBlockID], a
	lb bc,  7, 14
	predef_jump ReplaceTileBlock

SeviiFiveIslandWarehouseBF_TextPointers:
	dw SeviiFiveIslandWarehouseBFText1
	dw SeviiFiveIslandWarehouseBFText2
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw SeviiFiveIslandWarehouseBFSignText1
	dw SeviiFiveIslandWarehouseBFSignText2

SeviiFiveIslandWarehouseBFText1:
	text_far _SeviiFiveIslandWarehouseBFText1
	text_end

SeviiFiveIslandWarehouseBFText2:
	text_far _SeviiFiveIslandWarehouseBFText2
	text_end

SeviiFiveIslandWarehouseBFSignText1:
SeviiFiveIslandWarehouseBFSignText2:
	text_asm
	CheckEvent EVENT_SEVII_FIVE_ISLAND_WAREHOUSE_BF_OPENED_DOOR_3
	ld hl, SeviiFiveIslandWarehouseBFSignText1_DoorIsOpen
	jr nz, .printAndEnd
; require password
	call SaveScreenTilesToBuffer2
	ld hl, SeviiFiveIslandWarehouseBFSignText1_RequiresPassword
	call PrintText
	call WaitForTextScrollButtonPress
	farcall DisplayUniQuizScreen
.checkTheAnswer
	ld a, [wUniQuizAnswer]
	cp "P"
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+1]
	cp "O"
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+2]
	cp "W"
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+3]
	cp "E"
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+4]
	cp "R"
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+5]
	cp "@"
	jr z, .rightAnswer
.wrongAnswer
	ld a, SFX_DENIED
	call PlaySound
	ld hl, SeviiFiveIslandWarehouseBFSignText1_Wrong
	jr .printAndEnd
.rightAnswer
	ld a, SFX_GO_INSIDE
	call PlaySound
	SetEvent EVENT_SEVII_FIVE_ISLAND_WAREHOUSE_BF_OPENED_DOOR_3
	ld a, $0E ; clear floor block ID
	ld [wNewTileBlockID], a
	lb bc,  7, 14
	predef ReplaceTileBlock
	ld hl, SeviiFiveIslandWarehouseBFSignText1_Right
.printAndEnd
	call PrintText
.done
	jp TextScriptEnd

SeviiFiveIslandWarehouseBFSignText1_RequiresPassword:
	text_far _SeviiFiveIslandWarehouse_InsertPassword
	text_end

SeviiFiveIslandWarehouseBFSignText1_Wrong:
	text_far _SeviiFiveIslandWarehouse_WrongPassword
	text_end

SeviiFiveIslandWarehouseBFSignText1_Right:
	text_far _SeviiFiveIslandWarehouse_CorrectPassword
	text_end

SeviiFiveIslandWarehouseBFSignText1_DoorIsOpen:
	text_far _SeviiFiveIslandWarehouse_DoorIsOpen
	text_end