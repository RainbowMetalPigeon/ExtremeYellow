DisplayRandomizationMenu::
	call InitRandomizationMenu
.randomizationMenuLoop
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	and START | B_BUTTON
	jr nz, .exitRandomizationMenu
	call RandomizationControl
	jr c, .dpadDelay
	call GetRandomizationPointer
	jr c, .exitRandomizationMenu
.dpadDelay
	call RandomizationMenu_UpdateCursorPosition
	call DelayFrame
	call DelayFrame
	call DelayFrame
	jr .randomizationMenuLoop
.exitRandomizationMenu
	ret

GetRandomizationPointer:
	ld a, [wOptionsCursorLocation] ; this wram variable should do for all menus because it's always reset at the beginning
	ld e, a
	ld d, $0
	ld hl, RandomizationMenuJumpTable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl ; jump to the function for the current highlighted randomization option

RandomizationMenuJumpTable:
	dw RandomizationMenu_WildEncounters
	dw RandomizationMenu_TrainersTeam
	dw RandomizationMenu_Items
	dw RandomizationMenu_Warps
	dw RandomizationMenu_Dummy
	dw RandomizationMenu_Dummy
	dw RandomizationMenu_Dummy
	dw RandomizationMenu_Cancel

; ---------------------------------------------

RandomizationMenu_WildEncounters:
	ld a, [wRandomizationWildEncounters]
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
	ld [wRandomizationWildEncounters], a
.nonePressed
	ld b, $0
	ld hl, RandomizationStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 16, 2
	call PlaceString
	and a
	ret

; ---------------------------------------------

RandomizationMenu_TrainersTeam:
	ld a, [wRandomizationTrainersTeams]
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
	ld [wRandomizationTrainersTeams], a
.nonePressed
	ld b, $0
	ld hl, RandomizationStringsPointerTable
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

RandomizationMenu_Items:
	ld a, [wRandomizationItems]
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
	ld [wRandomizationItems], a
.nonePressed
	ld b, $0
	ld hl, RandomizationStringsPointerTable
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

RandomizationMenu_Warps:
	ld a, [wRandomizationWarps]
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
	ld [wRandomizationWarps], a
.nonePressed
	ld b, $0
	ld hl, RandomizationStringsPointerTable
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

RandomizationMenu_Dummy:
	and a
	ret

; ---------------------------------------------

RandomizationMenu_Cancel:
	ldh a, [hJoy5]
	and A_BUTTON
	jr nz, .pressedCancel
	and a
	ret
.pressedCancel
	scf
	ret

; ---------------------------------------------

RandomizationControl:
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
	cp 7 ; option position of CANCEL: 8th, but is #7 because we start from 0
	jr nz, .doNotWrapAround
	ld [hl], $0
	scf
	ret
.doNotWrapAround
	cp 3 ; number of options - 1
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
	ld [hl], 3 ; number of options - 1
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

RandomizationMenu_UpdateCursorPosition:
	hlcoord 1, 1
	ld de, SCREEN_WIDTH
	ld c, 16
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

InitRandomizationMenu:
	hlcoord 0, 0
	lb bc, SCREEN_HEIGHT - 2, SCREEN_WIDTH - 2
	call TextBoxBorder
	hlcoord 2, 2
	ld de, AllRandomizationText
	call PlaceString
	hlcoord 2, 16
	ld de, RandomizationMenuCancelText
	call PlaceString
	xor a
	ld [wOptionsCursorLocation], a
	ld c, 4 ; the number of options to loop through
.loop
	push bc
	call GetRandomizationPointer ; updates the next option
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

AllRandomizationText:
	db   "WILD #MON:"
	next "ENEMY TEAMS :"
	next "ITEMS:"
	next "WARPS:@"

RandomizationMenuCancelText:
	db "CANCEL@"

RandomizationStringsPointerTable:
	dw NoText
	dw YesText

NoText:
	db "NO @"
YesText:
	db "YES@"
