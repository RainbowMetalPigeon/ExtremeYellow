DisplayLuckMenu::
	call InitLuckMenu
.luckMenuLoop
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	and START | B_BUTTON
	jr nz, .exitLuckMenu
	call LuckControl
	jr c, .dpadDelay
	call GetLuckPointer
	jr c, .exitLuckMenu
.dpadDelay
	call LuckMenu_UpdateCursorPosition
	call DelayFrame
	call DelayFrame
	call DelayFrame
	jr .luckMenuLoop
.exitLuckMenu
	ret

GetLuckPointer:
	ld a, [wOptionsCursorLocation] ; this wram variable should do for all menus because it's always reset at the beginning
	ld e, a
	ld d, $0
	ld hl, LuckMenuJumpTable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl ; jump to the function for the current highlighted luck option

LuckMenuJumpTable:
	dw LuckMenu_Accuracy
	dw LuckMenu_Roll
	dw LuckMenu_Crit
	dw LuckMenu_SecondaryEffects
	dw LuckMenu_StatusesAffliction
	dw LuckMenu_Dummy
	dw LuckMenu_Cancel

; ---------------------------------------------

LuckMenu_Accuracy:
	ld a, [wLuckAccuracy]
	ld c, a
	ldh a, [hJoy5]
	bit 4, a ; right
	jr nz, .pressedRight
	bit 5, a
	jr nz, .pressedLeft
	jr .nonePressed
.pressedRight
	ld a, c
	cp $3
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
	ld c, $4
.decrease
	dec c
	ld a, d
.save
	ld a, c
	ld [wLuckAccuracy], a
.nonePressed
	ld b, $0
	ld hl, LuckStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 9, 4
	call PlaceString
	and a
	ret

; ---------------------------------------------

LuckMenu_Roll:
	ld a, [wLuckRoll]
	ld c, a
	ldh a, [hJoy5]
	bit 4, a ; right
	jr nz, .pressedRight
	bit 5, a
	jr nz, .pressedLeft
	jr .nonePressed
.pressedRight
	ld a, c
	cp $3
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
	ld c, $4
.decrease
	dec c
	ld a, d
.save
	ld a, c
	ld [wLuckRoll], a
.nonePressed
	ld b, $0
	ld hl, LuckStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 9, 6
	call PlaceString
	and a
	ret

; ---------------------------------------------

LuckMenu_Crit:
	ld a, [wLuckCrit]
	ld c, a
	ldh a, [hJoy5]
	bit 4, a ; right
	jr nz, .pressedRight
	bit 5, a
	jr nz, .pressedLeft
	jr .nonePressed
.pressedRight
	ld a, c
	cp $3
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
	ld c, $4
.decrease
	dec c
	ld a, d
.save
	ld a, c
	ld [wLuckCrit], a
.nonePressed
	ld b, $0
	ld hl, LuckStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 9, 8
	call PlaceString
	and a
	ret

; ---------------------------------------------

LuckMenu_SecondaryEffects:
	ld a, [wLuckSecondaryEffects]
	ld c, a
	ldh a, [hJoy5]
	bit 4, a ; right
	jr nz, .pressedRight
	bit 5, a
	jr nz, .pressedLeft
	jr .nonePressed
.pressedRight
	ld a, c
	cp $3
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
	ld c, $4
.decrease
	dec c
	ld a, d
.save
	ld a, c
	ld [wLuckSecondaryEffects], a
.nonePressed
	ld b, $0
	ld hl, LuckStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 9, 10
	call PlaceString
	and a
	ret

; ---------------------------------------------

LuckMenu_StatusesAffliction:
	ld a, [wLuckStatusesAffliction]
	ld c, a
	ldh a, [hJoy5]
	bit 4, a ; right
	jr nz, .pressedRight
	bit 5, a
	jr nz, .pressedLeft
	jr .nonePressed
.pressedRight
	ld a, c
	cp $3
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
	ld c, $4
.decrease
	dec c
	ld a, d
.save
	ld a, c
	ld [wLuckStatusesAffliction], a
.nonePressed
	ld b, $0
	ld hl, LuckStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 9, 12
	call PlaceString
	and a
	ret

; ---------------------------------------------

LuckMenu_Dummy:
	and a
	ret

; ---------------------------------------------

LuckMenu_Cancel:
	ldh a, [hJoy5]
	and A_BUTTON
	jr nz, .pressedCancel
	and a
	ret
.pressedCancel
	scf
	ret

; ---------------------------------------------

LuckControl:
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
	cp 6 ; option position of CANCEL: 7th, but is #6 because we start from 0
	jr nz, .doNotWrapAround
	ld [hl], $0
	scf
	ret
.doNotWrapAround
	cp 4 ; number of options - 1
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
	ld [hl], 4 ; number of options - 1
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
; new, to handle info printer
.pressedSelectOrA
	ld a, [hl]
	ld [wUniQuizAnswer], a
	cp 5 ; number of options
	ret nc
	add a ; doubles a
	ld e, a
	ld d, 0
	ld hl, LuckInfoTexts
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
	call InitLuckMenu_Redo
	ret

LuckMenu_UpdateCursorPosition:
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

InitLuckMenu:
	hlcoord 0, 0
	lb bc, SCREEN_HEIGHT - 2, SCREEN_WIDTH - 2
	call TextBoxBorder
	call PrintLabelAboutInfo ; new, testing
	hlcoord 2, 4
	ld de, AllLuckText
	call PlaceString
	hlcoord 2, 16
	ld de, LuckMenuCancelText
	call PlaceString
	hlcoord 5, 2
	ld de, LuckTitleText
	call PlaceString
	xor a
	ld [wOptionsCursorLocation], a
	ld c, 5 ; the number of options to loop through
.loop
	push bc
	call GetLuckPointer ; updates the next option
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

InitLuckMenu_Redo:
	hlcoord 0, 0
	lb bc, SCREEN_HEIGHT - 2, SCREEN_WIDTH - 2
	call TextBoxBorder
	call PrintLabelAboutInfo ; new, testing
	hlcoord 2, 4
	ld de, AllLuckText
	call PlaceString
	hlcoord 2, 16
	ld de, LuckMenuCancelText
	call PlaceString
	hlcoord 5, 2
	ld de, LuckTitleText
	call PlaceString
	xor a
	ld [wOptionsCursorLocation], a
	ld c, 5 ; the number of options to loop through
.loop
	push bc
	call GetLuckPointer ; updates the next option
	pop bc
	ld hl, wOptionsCursorLocation
	inc [hl] ; moves the cursor for the highlighted option
	dec c
	jr nz, .loop
	ld a, 1
	ldh [hAutoBGTransferEnabled], a
	ld a, [wUniQuizAnswer] ; to restore the previous curson position
	ld [wOptionsCursorLocation], a
	ret

AllLuckText:
	db   "ACC:"
	next "ROLL:"
	next "CRIT:"
	next "EFFS:"
	next "STATUS:@"

LuckTitleText:
	db "BATTLE LUCK@"

LuckMenuCancelText:
	db "CANCEL@"

LuckStringsPointerTable:
	dw NormalText
	dw PlayerMinText
	dw OpponentMaxText
	dw BothText

NormalText:
	db "NORMAL    @"
PlayerMinText:
	db "PLAYER MIN@"
OpponentMaxText:
	db "ENEMY MAX @"
BothText:
	db "BOTH      @"

; new, for info

LuckInfoTexts:
	dw LuckInfoTextAccuracy
	dw LuckInfoTextRoll
	dw LuckInfoTextCrits
	dw LuckInfoTextEffects
	dw LuckInfoTextStatus

LuckInfoTextAccuracy:
	text_far _LuckInfoTextAccuracy
	text_end

LuckInfoTextRoll:
	text_far _LuckInfoTextRoll
	text_end

LuckInfoTextCrits:
	text_far _LuckInfoTextCrits
	text_end

LuckInfoTextEffects:
	text_far _LuckInfoTextEffects
	text_end

LuckInfoTextStatus:
	text_far _LuckInfoTextStatus
	text_end
