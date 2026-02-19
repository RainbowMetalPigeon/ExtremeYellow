DisplayLayoutMenu::
	callfar BackupTextSpeed
	callfar MakeTextTemporarilyInstant
	call InitLayoutMenu
	ld a, 10 ; new
	ldh [hDownArrowBlinkCount1], a ; new
.LayoutMenuLoop
	call HandleInfoBlinkTiming ; new
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	and START | B_BUTTON
	jr nz, .exitLayoutMenu
	call LayoutControl
	jr c, .dpadDelay
	call GetLayoutPointer
	jr c, .exitLayoutMenu
.dpadDelay
	call LayoutMenu_UpdateCursorPosition
	call DelayFrame
	call DelayFrame
	call DelayFrame
	jr .LayoutMenuLoop
.exitLayoutMenu
	callfar RestoreTextSpeed
	ret

GetLayoutPointer:
	ld a, [wOptionsCursorLocation] ; this wram variable should do for all menus because it's always reset at the beginning
	ld e, a
	ld d, $0
	ld hl, LayoutMenuJumpTable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl ; jump to the function for the current highlighted layout option

LayoutMenuJumpTable:
	dw LayoutMenu_Names
	dw LayoutMenu_LevelStatus
	dw LayoutMenu_SpeakerSettings ; from the vanilla option menu
	dw LayoutMenu_Dummy
	dw LayoutMenu_Dummy
	dw LayoutMenu_Dummy
	dw LayoutMenu_Dummy
	dw LayoutMenu_Cancel

; ---------------------------------------------

LayoutMenu_Names:
	ld a, [wLayoutNames]
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
	ld [wLayoutNames], a
.nonePressed
	ld b, $0
	ld hl, LayoutNamesStringsPointerTable
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

LayoutMenu_SpeakerSettings:
	ld a, [wOptions]
	and $30
	swap a
	ld c, a
	ldh a, [hJoy5]
	bit 4, a
	jr nz, .pressedRight
	bit 5, a
	jr nz, .pressedLeft
	jr .asm_41dca
.pressedRight
	ld a, c
	inc a
	and $3
	jr .asm_41dba
.pressedLeft
	ld a, c
	dec a
	and $3
.asm_41dba
	ld c, a
	swap a
	ld b, a
	xor a
	ldh [rNR51], a
	ld a, [wOptions]
	and $cf
	or b
	ld [wOptions], a
.asm_41dca
	ld b, $0
	ld hl, SpeakerOptionStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 8, 6
	call PlaceString
	and a
	ret

SpeakerOptionStringsPointerTable:
	dw MonoSoundText
	dw Earphone1SoundText
	dw Earphone2SoundText
	dw Earphone3SoundText

MonoSoundText:
	db "MONO     @"
Earphone1SoundText:
	db "EARPHONE1@"
Earphone2SoundText:
	db "EARPHONE2@"
Earphone3SoundText:
	db "EARPHONE3@"

; ---------------------------------------------

LayoutMenu_LevelStatus:
	ld a, [wLayoutLevelStatus]
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
	ld [wLayoutLevelStatus], a
.nonePressed
	ld b, $0
	ld hl, LayoutLevelStatusStringsPointerTable
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

LayoutMenu_Dummy:
	and a
	ret

; ---------------------------------------------

LayoutMenu_Cancel:
	ldh a, [hJoy5]
	and A_BUTTON
	jr nz, .pressedCancel
	and a
	ret
.pressedCancel
	scf
	ret

; ---------------------------------------------

LayoutControl:
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
	cp 2 ; number of options - 1
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
	ld [hl], 2 ; number of options - 1
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
	cp 3 ; number of options
	ret nc
	add a ; doubles a
	ld e, a
	ld d, 0
	ld hl, LayoutInfoTexts
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
.conclude
	SetEvent EVENT_PRESSED_FOR_INFO_IN_OPTIONS
	call InitLayoutMenu_Redo
	ret

LayoutMenu_UpdateCursorPosition:
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

InitLayoutMenu:
	hlcoord 0, 0
	lb bc, SCREEN_HEIGHT - 2, SCREEN_WIDTH - 2
	call TextBoxBorder
;	call PrintLabelAboutInfo ; testing
	hlcoord 2, 2
	ld de, AllLayoutText
	call PlaceString
	hlcoord 2, 16
	ld de, LayoutMenuCancelText
	call PlaceString
	xor a
	ld [wOptionsCursorLocation], a
	ld c, 3 ; the number of options to loop through
.loop
	push bc
	call GetLayoutPointer ; updates the next option
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

InitLayoutMenu_Redo:
	hlcoord 0, 0
	lb bc, SCREEN_HEIGHT - 2, SCREEN_WIDTH - 2
	call TextBoxBorder
;	call PrintLabelAboutInfo ; new, testing
	hlcoord 2, 2
	ld de, AllLayoutText
	call PlaceString
	hlcoord 2, 16
	ld de, LayoutMenuCancelText
	call PlaceString
	xor a
	ld [wOptionsCursorLocation], a
	ld c, 3 ; the number of options to loop through
.loop
	push bc
	call GetLayoutPointer ; updates the next option
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

AllLayoutText:
	db   "NAMES:"
	next "LEVEL/STATUS:"
	next "SOUND:@"

LayoutMenuCancelText:
	db "CANCEL@"

LayoutNamesStringsPointerTable:
	dw EnglishText
	dw NeutralText
	dw JapaneseText

EnglishText:
	db "ENGLISH @"
NeutralText:
	db "NEUTRAL @"
JapaneseText:
	db "JAPANESE@"

LayoutLevelStatusStringsPointerTable:
	dw NewText
	dw OldText

NewText:
	db "NEW@"
OldText:
	db "OLD@"

; new, for info

LayoutInfoTexts:
	dw LayoutInfoTextNames
	dw LayoutInfoTextLevelStatus
	dw LayoutInfoTextSound

LayoutInfoTextNames:
	text_far _LayoutInfoTextNames
	text_end

LayoutInfoTextLevelStatus:
	text_far _LayoutInfoTextLevelStatus
	text_end

LayoutInfoTextSound:
	text_far _LayoutInfoTextSound
	text_end
