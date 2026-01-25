DisplayRandomizationMenu::
	call InitRandomizationMenu
	ld a, 10 ; new
	ldh [hDownArrowBlinkCount1], a ; new
.randomizationMenuLoop
	call HandleInfoBlinkTiming ; new
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
; to inizialite the random address needed for the wild encounters and type chart option
; see commens about the other part for more info
	ldh a, [hRandomAdd]
	ld [wRandomMemoryAddressForTypeChartRandomization+1], a
	call Random
	ld [wRandomMemoryAddressForWildRandomization+1], a
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
	dw RandomizationMenu_TypeChart
	dw RandomizationMenu_Items
	dw RandomizationMenu_Evolutions
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
	hlcoord 15, 2
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
	hlcoord 15, 4
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
	hlcoord 8, 8
	call PlaceString
	and a
	ret

; ---------------------------------------------

RandomizationMenu_TypeChart:
	ld a, [wRandomizationTypeChart]
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
	ld [wRandomizationTypeChart], a
.nonePressed
	ld b, $0
	ld hl, RandomizationStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 15, 6
	call PlaceString
	and a
	ret

; ---------------------------------------------

RandomizationMenu_Evolutions:
	ld a, [wRandomizationEvolutions]
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
	ld [wRandomizationEvolutions], a
.nonePressed
	ld b, $0
	ld hl, RandomizationStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 13, 10
	call PlaceString
	and a
	ret

; ---------------------------------------------

; unused
RandomizationMenu_Warps:
	ld a, [wOptions] ; TBE
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
	ld [wOptions], a ; TBE
.nonePressed
	ld b, $0
	ld hl, RandomizationStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 8, 10
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
	ld [wUniQuizAnswer], a
	cp 5 ; number of options
	ret nc
	add a ; doubles a
	ld e, a
	ld d, 0
	ld hl, RandomizationInfoTexts
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
	SetEvent EVENT_PRESSED_FOR_INFO_IN_OPTIONS
	call InitRandomizationMenu_Redo
	ret

RandomizationMenu_UpdateCursorPosition:
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

InitRandomizationMenu:
; to inizialite the random address needed for the wild encounters option
; we do the first here and the second upon exiting the menu to maximize the randomness due to player's inputs
.loopRandom
	call Random
	cp 32
	jr nc, .loopRandom
	ld [wRandomMemoryAddressForWildRandomization], a
; the loop is necessary if wRandomMemoryAddressForWildRandomization is indeed the MOST significant byte
; in which case we cannot go too high otherwise we go beyond the boundaries of the bank itself
; let's repeate the same code for the type chart randomization
.loopRandom2
	call Random
	cp 32
	jr nc, .loopRandom2
	ld [wRandomMemoryAddressForTypeChartRandomization], a
; back to ordinary code
	hlcoord 0, 0
	lb bc, SCREEN_HEIGHT - 2, SCREEN_WIDTH - 2
	call TextBoxBorder
;	call PrintLabelAboutInfo ; new, testing
	hlcoord 2, 2
	ld de, AllRandomizationText
	call PlaceString
	hlcoord 2, 16
	ld de, RandomizationMenuCancelText
	call PlaceString
;	hlcoord 4, 2
;	ld de, RandomizationTitleText
;	call PlaceString
	xor a
	ld [wOptionsCursorLocation], a
	ld c, 5 ; the number of options to loop through
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

InitRandomizationMenu_Redo:
	hlcoord 0, 0
	lb bc, SCREEN_HEIGHT - 2, SCREEN_WIDTH - 2
	call TextBoxBorder
;	call PrintLabelAboutInfo ; new, testing
	hlcoord 2, 2
	ld de, AllRandomizationText
	call PlaceString
	hlcoord 2, 16
	ld de, RandomizationMenuCancelText
	call PlaceString
;	hlcoord 4, 2
;	ld de, RandomizationTitleText
;	call PlaceString
	xor a
	ld [wOptionsCursorLocation], a
	ld c, 5 ; the number of options to loop through
.loop
	push bc
	call GetRandomizationPointer ; updates the next option
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

AllRandomizationText:
	db   "WILD #MON:"
	next "ENEMY TEAMS :"
	next "TYPE CHART  :"
	next "ITEMS:"
	next "EVOLUTIONS:@"

RandomizationTitleText:
	db "RANDOMIZATION@"

RandomizationMenuCancelText:
	db "CANCEL@"

RandomizationStringsPointerTable:
	dw NoText
	dw YesText

NoText:
	db "NO @"
YesText:
	db "YES@"

; new, for info

RandomizationInfoTexts:
	dw RandomizationInfoTextWildMons
	dw RandomizationInfoTextEnemyTeams
	dw RandomizationInfoTextTypeChart
	dw RandomizationInfoTextItems
	dw RandomizationInfoTextEvolutions

RandomizationInfoTextWildMons:
	text_far _RandomizationInfoTextWildMons
	text_end

RandomizationInfoTextEnemyTeams:
	text_far _RandomizationInfoTextEnemyTeams
	text_end

RandomizationInfoTextTypeChart:
	text_far _RandomizationInfoTextTypeChart
	text_end

RandomizationInfoTextItems:
	text_far _RandomizationInfoTextItems
	text_end

RandomizationInfoTextEvolutions:
	text_far _RandomizationInfoTextEvolutions
	text_end
