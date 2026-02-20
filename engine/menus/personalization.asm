DisplayPersonalizationMenu::
	callfar BackupTextSpeed
	callfar MakeTextTemporarilyInstant
	call InitPersonalizationMenu
	ld a, 10 ; new
	ldh [hDownArrowBlinkCount1], a ; new
.personalizationMenuLoop
	call HandleInfoBlinkTiming ; new
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	and START | B_BUTTON
	jr nz, .exitPersonalizationMenu
	call PersonalizationControl
	jr c, .dpadDelay
	call GetPersonalizationPointer
	jr c, .exitPersonalizationMenu
.dpadDelay
	call PersonalizationMenu_UpdateCursorPosition
	call DelayFrame
	call DelayFrame
	call DelayFrame
	jr .personalizationMenuLoop
.exitPersonalizationMenu
	callfar UpdatePartyMonTypesAfterPersonalization
	callfar RestoreTextSpeed
	ret

GetPersonalizationPointer:
	ld a, [wOptionsCursorLocation] ; this wram variable should do for all menus because it's always reset at the beginning
	ld e, a
	ld d, $0
	ld hl, PersonalizationMenuJumpTable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl ; jump to the function for the current highlighted personalization option

PersonalizationMenuJumpTable:
	dw PersonalizationMenu_Types
	dw PersonalizationMenu_PhySpeSplit
	dw PersonalizationMenu_SwapBattles
	dw PersonalizationMenu_TypeChart
	dw PersonalizationMenu_TCGMode
	dw PersonalizationMenu_Dummy
	dw PersonalizationMenu_Dummy
	dw PersonalizationMenu_Cancel

; ---------------------------------------------

PersonalizationMenu_Types:
	ld a, [wPersonalizationTypes]
	ld c, a
	ldh a, [hJoy5]
	bit 4, a ; right
	jr nz, .pressedRight
	bit 5, a
	jr nz, .pressedLeft
	jr .nonePressed
.pressedRight
	ld a, c
	cp $1
	jr c, .increase
	ld c, $ff
.increase
	inc c
	ld a, e
	jr .save
.pressedLeft
	ld a, c
	and a
	jr nz, .decrease
	ld c, $2
.decrease
	dec c
	ld a, d
.save
	ld a, c
	ld [wPersonalizationTypes], a
.nonePressed
	ld b, $0
	ld hl, PersonalizationTypesStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 8, 2
	call PlaceString
	and a
	ret

; ---------------------------------------------

PersonalizationMenu_PhySpeSplit:
	ld a, [wPersonalizationPhySpeSplit]
	ld c, a
	ldh a, [hJoy5]
	bit 4, a ; right
	jr nz, .pressedRight
	bit 5, a
	jr nz, .pressedLeft
	jr .nonePressed
.pressedRight
	ld a, c
	cp $1
	jr c, .increase
	ld c, $ff
.increase
	inc c
	ld a, e
	jr .save
.pressedLeft
	ld a, c
	and a
	jr nz, .decrease
	ld c, $2
.decrease
	dec c
	ld a, d
.save
	ld a, c
	ld [wPersonalizationPhySpeSplit], a
.nonePressed
	ld b, $0
	ld hl, PersonalizationPhySpeSplitStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 16, 4
	call PlaceString
	and a
	ret

; ---------------------------------------------

PersonalizationMenu_SwapBattles:
	ld a, [wPersonalizationSwapBattles]
	ld c, a
	ldh a, [hJoy5]
	bit 4, a ; right
	jr nz, .pressedRight
	bit 5, a
	jr nz, .pressedLeft
	jr .nonePressed
.pressedRight
	ld a, c
	cp 3 ; number of options - 1
	jr c, .increase
	ld c, $ff
.increase
	inc c
	ld a, e
	jr .save
.pressedLeft
	ld a, c
	and a
	jr nz, .decrease
	ld c, 4 ; number of options
.decrease
	dec c
	ld a, d
.save
	ld a, c
	ld [wPersonalizationSwapBattles], a
.nonePressed
	ld b, $0
	ld hl, PersonalizationSwapBattlesStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 14, 6
	call PlaceString
	and a
	ret

; ---------------------------------------------

PersonalizationMenu_TypeChart:
	ld a, [wPersonalizationTypeChart]
	ld c, a
	ldh a, [hJoy5]
	bit 4, a ; right
	jr nz, .pressedRight
	bit 5, a
	jr nz, .pressedLeft
	jr .nonePressed
.pressedRight
	ld a, c
	cp 1 ; number of options - 1
	jr c, .increase
	ld c, $ff
.increase
	inc c
	ld a, e
	jr .save
.pressedLeft
	ld a, c
	and a
	jr nz, .decrease
	ld c, 2 ; number of options
.decrease
	dec c
	ld a, d
.save
	ld a, c
	ld [wPersonalizationTypeChart], a
.nonePressed
	ld b, $0
	ld hl, PersonalizationTypeChartStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 12, 8
	call PlaceString
	and a
	ret

; ---------------------------------------------

PersonalizationMenu_TCGMode:
	ld a, [wPersonalizationTCGMode]
	ld c, a
	ldh a, [hJoy5]
	bit 4, a ; right
	jr nz, .pressedRight
	bit 5, a
	jr nz, .pressedLeft
	jr .nonePressed
.pressedRight
	ld a, c
	cp 1 ; number of options - 1
	jr c, .increase
	ld c, $ff
.increase
	inc c
	ld a, e
	jr .save
.pressedLeft
	ld a, c
	and a
	jr nz, .decrease
	ld c, 2 ; number of options
.decrease
	dec c
	ld a, d
.save
	ld a, c
	ld [wPersonalizationTCGMode], a
.nonePressed
	ld b, $0
	ld hl, PersonalizationTCGModeStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 11, 10
	call PlaceString
	and a
	ret

; ---------------------------------------------

PersonalizationMenu_Dummy:
	and a
	ret

; ---------------------------------------------

PersonalizationMenu_Cancel:
	ldh a, [hJoy5]
	and A_BUTTON
	jr nz, .pressedCancel
	and a
	ret
.pressedCancel
	scf
	ret

; ---------------------------------------------

PersonalizationControl:
	ld hl, wOptionsCursorLocation
	ldh a, [hJoy5]
	cp D_DOWN
	jr z, .pressedDown
	cp D_UP
	jr z, .pressedUp
; new, to handle info printer
	cp SELECT
	jr z, .pressedSelectOrA
	cp A_BUTTON
	jr z, .pressedSelectOrA
; back to default
	and a
	ret
.pressedDown
	ld a, [hl]
	cp 7 ; option position of CANCEL: 8th, but is #6 because we start from 0
	jr nz, .doNotWrapAround
	ld [hl], $0
	scf
	ret
.doNotWrapAround
	cp 4 ; number of options - 1
	jr c, .regularIncrement
	ld [hl], 6 ; option position of CANCEL - 1, because it will be increased by 1 next step
.regularIncrement
	inc [hl]
	scf
	ret
.pressedUp
	ld a, [hl]
	cp 7 ; option position of CANCEL
	jr nz, .doNotMoveCursorToLastValidOption
	ld [hl], 4 ; number of options - 1
	scf
	ret
.doNotMoveCursorToLastValidOption
	and a
	jr nz, .regularDecrement
	ld [hl], 8 ; option position of CANCEL + 1, because it will be reduced by 1 next step
.regularDecrement
	dec [hl]
	scf
	ret
; new, to handle info printer
.pressedSelectOrA
	ld a, [hl]
	ld [wMultipurposeTemporaryStorage], a
	cp 5 ; number of options
	ret nc
	cp 0 ; first option is special as it doesn't just print one dialogue
	jr z, .alteredTypes
	add a ; doubles a
	ld e, a
	ld d, 0
	ld hl, PersonalizationInfoTexts
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
.conclude
	SetEvent EVENT_PRESSED_FOR_INFO_IN_OPTIONS
	call InitPersonalizationMenu_Redo
	ret
.alteredTypes ; hard-coded exception
	ld hl, PersonalizationInfoTextTypes
	call PrintText
	ld hl, PersonalizationInfoTextTypes_WannaKnowThemAll
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem] ; YES=0, NO=1
	and a ; equivalent to cp 0
	jr nz, .conclude
	ld hl, PersonalizationInfoTextTypes_Details
	call PrintText
	jr .conclude

PersonalizationMenu_UpdateCursorPosition:
	hlcoord 1, 2
	ld de, SCREEN_WIDTH
	ld c, 15
.loop
	ld [hl], " "
	add hl, de
	dec c
	jr nz, .loop
	hlcoord 1, 2
	ld bc, SCREEN_WIDTH * 2
	ld a, [wOptionsCursorLocation]
	call AddNTimes
	ld [hl], "▶"
	ret

InitPersonalizationMenu:
	hlcoord 0, 0
	lb bc, SCREEN_HEIGHT - 2, SCREEN_WIDTH - 2
	call TextBoxBorder
	hlcoord 2, 2
	ld de, AllPersonalizationText
	call PlaceString
	hlcoord 2, 16
	ld de, PersonalizationMenuCancelText
	call PlaceString
	xor a
	ld [wOptionsCursorLocation], a
	ld c, 5 ; the number of options to loop through
.loop
	push bc
	call GetPersonalizationPointer ; updates the next option
	pop bc
	ld hl, wOptionsCursorLocation
	inc [hl] ; moves the cursor for the highlighted option
	dec c
	jr nz, .loop
	xor a
	ld [wOptionsCursorLocation], a
	inc a
	ldh [hAutoBGTransferEnabled], a
	call Delay3
	ret

InitPersonalizationMenu_Redo:
	hlcoord 0, 0
	lb bc, SCREEN_HEIGHT - 2, SCREEN_WIDTH - 2
	call TextBoxBorder
	hlcoord 2, 2
	ld de, AllPersonalizationText
	call PlaceString
	hlcoord 2, 16
	ld de, PersonalizationMenuCancelText
	call PlaceString
	xor a
	ld [wOptionsCursorLocation], a
	ld c, 5 ; the number of options to loop through
.loop
	push bc
	call GetPersonalizationPointer ; updates the next option
	pop bc
	ld hl, wOptionsCursorLocation
	inc [hl] ; moves the cursor for the highlighted option
	dec c
	jr nz, .loop
	ld a, 1
	ldh [hAutoBGTransferEnabled], a
	ld a, [wMultipurposeTemporaryStorage] ; to restore the previous curson position
	ld [wOptionsCursorLocation], a
	ret

AllPersonalizationText:
	db   "TYPES:"
	next "PHY/SPE SPLIT:"
	next "SWAP BATTLE:"
	next "TYPECHART:"
	next "TCG MODE:@"

PersonalizationTitleText:
	db "PERSONALIZATION@"

PersonalizationMenuCancelText:
	db "CANCEL@"

PersonalizationTypesStringsPointerTable:
	dw ClassicText
	dw AlteredText

ClassicText:
	db "CLASSIC@" ; TBE: VANILLA?
AlteredText:
	db "ALTERED@"

PersonalizationPhySpeSplitStringsPointerTable:
	dw NoText
	dw YesText

PersonalizationSwapBattlesStringsPointerTable:
	dw NoneText
	dw TradeTexts
	dw AllText
	dw MajorText

NoneText:
	db "NONE @"
TradeTexts:
	db "TRADE@"
AllText:
	db "ALL  @"
MajorText:
	db "MAJOR@"

PersonalizationTypeChartStringsPointerTable:
	dw ClassicText
	dw CustomText

CustomText:
	db "CUSTOM @" ; TBE: PIGEON's?

PersonalizationTCGModeStringsPointerTable:
	dw NoText
	dw YesText

; new, for info

PersonalizationInfoTexts:
	dw PersonalizationInfoTextTypes
	dw PersonalizationInfoTextPhySpeSplit
	dw PersonalizationInfoTextSwapBattles
	dw PersonalizationInfoTextTypeChart
	dw PersonalizationInfoTextTCGMode

PersonalizationInfoTextTypes:
	text_far _PersonalizationInfoTextTypes
	text_end

PersonalizationInfoTextPhySpeSplit:
	text_far _PersonalizationInfoTextPhySpeSplit
	text_end

PersonalizationInfoTextSwapBattles:
	text_far _PersonalizationInfoTextSwapBattles
	text_end

PersonalizationInfoTextTypes_WannaKnowThemAll:
	text_far _PersonalizationInfoTextTypes_WannaKnowThemAll
	text_end

PersonalizationInfoTextTypes_Details:
	text_far _PersonalizationInfoTextTypes_Details
	text_end

PersonalizationInfoTextTypeChart:
	text_far _PersonalizationInfoTextTypeChart
	text_end

PersonalizationInfoTextTCGMode:
	text_far _PersonalizationInfoTextTCGMode
	text_end
