DisplayPersonalizationMenu::
	call InitPersonalizationMenu
.personalizationMenuLoop
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
	dw PersonalizationMenu_Names
	dw PersonalizationMenu_Types
	dw PersonalizationMenu_Dummy
	dw PersonalizationMenu_Dummy
	dw PersonalizationMenu_Dummy
	dw PersonalizationMenu_Dummy
	dw PersonalizationMenu_Cancel

; ---------------------------------------------

PersonalizationMenu_Names:
	ld a, [wPersonalizationNames]
	ld c, a
	ldh a, [hJoy5]
	bit 4, a ; right
	jr nz, .pressedRight
	bit 5, a
	jr nz, .pressedLeft
	jr .nonePressed
.pressedRight
	ld a, c
	cp $2
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
	ld c, $3
.decrease
	dec c
	ld a, d
.save
	ld a, c
	ld [wPersonalizationNames], a
.nonePressed
	ld b, $0
	ld hl, PersonalizationNamesStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 8, 4
	call PlaceString
	and a
	ret

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
	hlcoord 8, 6
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
	and a
	ret
.pressedDown
	ld a, [hl]
	cp 6 ; option position of CANCEL: 7th, but is #6 because we start from 0
	jr nz, .doNotWrapAround
	ld [hl], $0
	scf
	ret
.doNotWrapAround
	cp 1 ; number of options - 1
	jr c, .regularIncrement
	ld [hl], 5 ; option position of CANCEL - 1, because it will be increased by 1 next step
.regularIncrement
	inc [hl]
	scf
	ret
.pressedUp
	ld a, [hl]
	cp 6 ; option position of CANCEL
	jr nz, .doNotMoveCursorToLastValidOption
	ld [hl], 1 ; number of options - 1
	scf
	ret
.doNotMoveCursorToLastValidOption
	and a
	jr nz, .regularDecrement
	ld [hl], 7 ; option position of CANCEL + 1, because it will be reduced by 1 next step
.regularDecrement
	dec [hl]
	scf
	ret

PersonalizationMenu_UpdateCursorPosition:
	hlcoord 1, 4
	ld de, SCREEN_WIDTH
	ld c, 13
.loop
	ld [hl], " "
	add hl, de
	dec c
	jr nz, .loop
	hlcoord 1, 4
	ld bc, SCREEN_WIDTH * 2
	ld a, [wOptionsCursorLocation]
	call AddNTimes
	ld [hl], "▶"
	ret

InitPersonalizationMenu:
	hlcoord 0, 0
	lb bc, SCREEN_HEIGHT - 2, SCREEN_WIDTH - 2
	call TextBoxBorder
	hlcoord 2, 4
	ld de, AllPersonalizationText
	call PlaceString
	hlcoord 2, 16
	ld de, PersonalizationMenuCancelText
	call PlaceString
	hlcoord 3, 2
	ld de, PersonalizationTitleText
	call PlaceString
	xor a
	ld [wOptionsCursorLocation], a
	ld c, 2 ; the number of options to loop through
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

AllPersonalizationText:
	db   "NAMES:"
	next "TYPES:@"

PersonalizationTitleText:
	db "PERSONALIZATION@"

PersonalizationMenuCancelText:
	db "CANCEL@"

PersonalizationNamesStringsPointerTable:
	dw EnglishText
	dw NeutralText
	dw JapaneseText

EnglishText:
	db "ENGLISH @"
NeutralText:
	db "NEUTRAL @"
JapaneseText:
	db "JAPANESE@"

PersonalizationTypesStringsPointerTable:
	dw ClassicText
	dw NewText

ClassicText:
	db "CLASSIC@"
NewText:
	db "NEW    @"
