DisplayPersonalizationMenu::
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
	dw PersonalizationMenu_PhySpeSplit
	dw PersonalizationMenu_LevelStatus
	dw PersonalizationMenu_SpeakerSettings ; from the vanilla option menu
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

PersonalizationMenu_SpeakerSettings:
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
	hlcoord 8, 12
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
	hlcoord 16, 8
	call PlaceString
	and a
	ret

; ---------------------------------------------

PersonalizationMenu_LevelStatus:
	ld a, [wPersonalizationLevelStatus]
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
	ld [wPersonalizationLevelStatus], a
.nonePressed
	ld b, $0
	ld hl, PersonalizationLevelStatusStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 15, 10
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
	cp 1 ; second option is special as it doesn't just print one dialogue
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
;	call PrintLabelAboutInfo ; new, testing
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
;	call PrintLabelAboutInfo ; new, testing
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
	ld a, [wUniQuizAnswer] ; to restore the previous curson position
	ld [wOptionsCursorLocation], a
	ret

AllPersonalizationText:
	db   "NAMES:"
	next "TYPES:"
	next "PHY/SPE SPLIT:"
	next "LEVEL/STATUS:"
	next "SOUND:@"

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
	dw AlteredText

ClassicText:
	db "CLASSIC@"
AlteredText:
	db "ALTERED@"

PersonalizationPhySpeSplitStringsPointerTable:
	dw NoText
	dw YesText

;NoText:
;	db "NO @"
;YesText:
;	db "YES@"

PersonalizationLevelStatusStringsPointerTable:
	dw NewText
	dw OldText

NewText:
	db "NEW@"
OldText:
	db "OLD@"

; new, for info

PersonalizationInfoTexts:
	dw PersonalizationInfoTextNames
	dw PersonalizationInfoTextTypes
	dw PersonalizationInfoTextPhySpeSplit
	dw PersonalizationInfoTextLevelStatus
	dw PersonalizationInfoTextSound

PersonalizationInfoTextNames:
	text_far _PersonalizationInfoTextNames
	text_end

PersonalizationInfoTextTypes:
	text_far _PersonalizationInfoTextTypes
	text_end

PersonalizationInfoTextPhySpeSplit:
	text_far _PersonalizationInfoTextPhySpeSplit
	text_end

PersonalizationInfoTextLevelStatus:
	text_far _PersonalizationInfoTextLevelStatus
	text_end

PersonalizationInfoTextSound:
	text_far _PersonalizationInfoTextSound
	text_end

PersonalizationInfoTextTypes_WannaKnowThemAll:
	text_far _PersonalizationInfoTextTypes_WannaKnowThemAll
	text_end

PersonalizationInfoTextTypes_Details:
	text_far _PersonalizationInfoTextTypes_Details
	text_end
