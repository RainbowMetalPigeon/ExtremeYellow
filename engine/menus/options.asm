DisplayOptionMenu_:
	call InitOptionsMenu
.optionMenuLoop
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	and START | B_BUTTON
	jr nz, .exitOptionMenu
	call OptionsControl
	jr c, .dpadDelay
	call GetOptionPointer
	jr c, .exitOptionMenu
.dpadDelay
	call OptionsMenu_UpdateCursorPosition
	call DelayFrame
	call DelayFrame
	call DelayFrame
	jr .optionMenuLoop
.exitOptionMenu
	ret

GetOptionPointer:
	ld a, [wOptionsCursorLocation]
	ld e, a
	ld d, $0
	ld hl, OptionMenuJumpTable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl ; jump to the function for the current highlighted option

OptionMenuJumpTable:
	dw OptionsMenu_TextSpeed
	dw OptionsMenu_BattleAnimations
	dw OptionsMenu_BattleStyle
	dw OptionsMenu_LevelCap ; new, it was OptionsMenu_SpeakerSettings, moved into the Personalization options
	dw OptionsMenu_BadgeBoost ; new, it was OptionsMenu_GBPrinterBrightness
	dw OptionsMenu_LevelScaling
	dw OptionsMenu_ExpGain
	dw OptionsMenu_Cancel

; ---------------------------------------------

OptionsMenu_TextSpeed:
	call GetTextSpeed
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
	ld b, a
	ld a, [wOptions]
	and $f0
	or b
	ld [wOptions], a
.nonePressed
	ld b, $0
	ld hl, TextSpeedStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 12, 2 ; edited
	call PlaceString
	and a
	ret

TextSpeedStringsPointerTable: ; edited
	dw InstantText
	dw FastText
	dw MidText

InstantText: ; edited
	db "INSTANT@"
FastText:
	db "FAST   @"
MidText:
	db "MID    @"

GetTextSpeed:
	ld a, [wOptions]
	and $f
	cp $5
	jr z, .midTextOption
	cp $1
	jr z, .instantTextOption
; fast text option
	ld c, $1
	lb de, 1, 5
	ret
.midTextOption
	ld c, $2
	lb de, 3, 1
	ret
.instantTextOption
	ld c, $0
	lb de, 5, 3
	ret

; ---------------------------------------------

OptionsMenu_BattleAnimations:
	ldh a, [hJoy5]
	and D_RIGHT | D_LEFT
	jr nz, .asm_41d33
	ld a, [wOptions]
	and $80 ; mask other bits
	jr .asm_41d3b
.asm_41d33
	ld a, [wOptions]
	xor $80
	ld [wOptions], a
.asm_41d3b
	ld bc, $0
	sla a
	rl c
	ld hl, AnimationOptionStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 12, 4 ; edited
	call PlaceString
	and a
	ret

AnimationOptionStringsPointerTable:
	dw AnimationOnText
	dw AnimationOffText

AnimationOnText:
	db "ON @"
AnimationOffText:
	db "OFF@"

; ---------------------------------------------

OptionsMenu_BattleStyle:
	ldh a, [hJoy5]
	and D_LEFT | D_RIGHT
	jr nz, .asm_41d6b
	ld a, [wOptions]
	and $40 ; mask other bits
	jr .asm_41d73
.asm_41d6b
	ld a, [wOptions]
	xor $40
	ld [wOptions], a
.asm_41d73
	ld bc, $0
	sla a
	sla a
	rl c
	ld hl, BattleStyleOptionStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 14, 6
	call PlaceString
	and a
	ret

BattleStyleOptionStringsPointerTable:
	dw BattleStyleShiftText
	dw BattleStyleSetText

BattleStyleShiftText:
	db "SHIFT@"
BattleStyleSetText:
	db "SET  @"

; ---------------------------------------------

OptionsMenu_GBPrinterBrightness:
	call Func_41e7b
	ldh a, [hJoy5]
	bit 4, a
	jr nz, .pressedRight
	bit 5, a
	jr nz, .pressedLeft
	jr .asm_41e32
.pressedRight
	ld a, c
	cp $4
	jr c, .asm_41e22
	ld c, $ff
.asm_41e22
	inc c
	ld a, e
	jr .asm_41e2e
.pressedLeft
	ld a, c
	and a
	jr nz, .asm_41e2c
	ld c, $5
.asm_41e2c
	dec c
	ld a, d
.asm_41e2e
	ld b, a
	ld [wPrinterSettings], a
.asm_41e32
	ld b, $0
	ld hl, GBPrinterOptionStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 8, 10
	call PlaceString
	and a
	ret

GBPrinterOptionStringsPointerTable:
	dw LightestPrintText
	dw LighterPrintText
	dw NormalPrintText
	dw DarkerPrintText
	dw DarkestPrintText

LightestPrintText:
	db "LIGHTEST@"
LighterPrintText:
	db "LIGHTER @"
NormalPrintText:
	db "NORMAL  @"
DarkerPrintText:
	db "DARKER  @"
DarkestPrintText:
	db "DARKEST @"

; ----- new, beginning ------------------------
OptionsMenu_BadgeBoost:
	ld a, [wBadgeBoostOption]
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
	ld [wBadgeBoostOption], a
.nonePressed
	ld b, $0
	ld hl, BadgeBoostStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 12, 10
	call PlaceString
	and a
	ret

BadgeBoostStringsPointerTable:
	dw BadgeBoostNone
	dw BadgeBoostClassic

BadgeBoostNone:
	db "NONE   @"
BadgeBoostClassic:
	db "CLASSIC@"

; ---------------------------------------------

OptionsMenu_LevelScaling:
	ld a, [wLevelScaling]
	ld c, a
	ldh a, [hJoy5]
	bit 4, a ; right
	jr nz, .pressedRight
	bit 5, a
	jr nz, .pressedLeft
	jr .nonePressed
.pressedRight
	ld a, c
	cp $4
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
	ld c, $5
.decrease
	dec c
	ld a, d
.save
	ld a, c
	ld [wLevelScaling], a
.nonePressed
	ld b, $0
	ld hl, LevelScalingStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 12, 12
	call PlaceString
	and a
	ret

LevelScalingStringsPointerTable:
	dw NoScaling
	dw ExactScaling
	dw FluctuatingScaling
	dw HardcoreScaling
	dw ImpossibleScaling

NoScaling:
	db "NONE @"
ExactScaling:
	db "EXACT@"
FluctuatingScaling:
	db "FLUCT@"
HardcoreScaling:
	db "HARD @"
ImpossibleScaling:
	db "IMPOS@"

; ---------------------------------------------

OptionsMenu_ExpGain:
	ld a, [wExpGainOption]
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
	ld [wExpGainOption], a
.nonePressed
	ld b, $0
	ld hl, ExpGainStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 11, 14
	call PlaceString
	and a
	ret

ExpGainStringsPointerTable:
	dw NormalGain
	dw LimitedGain
	dw NothingGain

NormalGain:
	db "NORMAL @"
LimitedGain:
	db "LIMITED@"
NothingGain:
	db "NOTHING@"

; ---------------------------------------------

OptionsMenu_LevelCap:
	ld a, [wLevelCapOption]
	ld c, a
	ldh a, [hJoy5]
	bit 4, a ; right
	jr nz, .pressedRight
	bit 5, a
	jr nz, .pressedLeft
	jr .nonePressed
.pressedRight
	ld a, c
	cp 4
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
	ld c, 5
.decrease
	dec c
	ld a, d
.save
	ld a, c
	ld [wLevelCapOption], a
.nonePressed
	ld b, $0
	ld hl, LevelCapStringsPointerTable
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 6, 8
	call PlaceString
	and a
	ret

LevelCapStringsPointerTable:
	dw ObedienceLooseCap
	dw ObedienceTightCap
	dw LevelLooseCap
	dw LevelTightCap
	dw NoCap

ObedienceLooseCap:
	db "OBEDIE. LOOSE@"
ObedienceTightCap:
	db "OBEDIE. TIGHT@"
LevelLooseCap:
	db "LEVEL LOOSE  @"
LevelTightCap:
	db "LEVEL TIGHT  @"
NoCap:
	db "NONE         @"

; ----- new, end ------------------------------

Func_41e7b:
	ld a, [wPrinterSettings]
	and a
	jr z, .asm_41e93
	cp $20
	jr z, .asm_41e99
	cp $60
	jr z, .asm_41e9f
	cp $7f
	jr z, .asm_41ea5
	ld c, $2
	lb de, $20, $60
	ret
.asm_41e93
	ld c, $0
	lb de, $7f, $20
	ret
.asm_41e99
	ld c, $1
	lb de, $0, $40
	ret
.asm_41e9f
	ld c, $3
	lb de, $40, $7f
	ret
.asm_41ea5
	ld c, $4
	lb de, $60, $0
	ret

OptionsMenu_Dummy:
	and a
	ret

OptionsMenu_Cancel:
	ldh a, [hJoy5]
	and A_BUTTON
	jr nz, .pressedCancel
	and a
	ret
.pressedCancel
	scf
	ret

OptionsControl:
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
	cp $7
	jr nz, .doNotWrapAround
	ld [hl], $0
	scf
	ret
.doNotWrapAround
	cp $6 ; edited, 2 new options, it was $4
	jr c, .regularIncrement
	ld [hl], $6
.regularIncrement
	inc [hl]
	scf
	ret
.pressedUp
	ld a, [hl]
	cp $7
	jr nz, .doNotMoveCursorToLastValidOption
	ld [hl], $6 ; edited, 2 new options, it was $4
	scf
	ret
.doNotMoveCursorToLastValidOption
	and a
	jr nz, .regularDecrement
	ld [hl], $8
.regularDecrement
	dec [hl]
	scf
	ret
; new, to handle info printer
.pressedSelectOrA
	ld a, [hl]
	ld [wUniQuizAnswer], a
	cp 7 ; number of options
	ret nc
	add a ; doubles a
	ld e, a
	ld d, 0
	ld hl, OptionsInfoTexts
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
	call InitOptionsMenu_Redo
	ret

OptionsMenu_UpdateCursorPosition:
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

InitOptionsMenu:
	hlcoord 0, 0
	lb bc, SCREEN_HEIGHT - 2, SCREEN_WIDTH - 2
	call TextBoxBorder
	call PrintLabelAboutInfo ; new, testing
	hlcoord 2, 2
	ld de, AllOptionsText
	call PlaceString
	hlcoord 2, 16
	ld de, OptionMenuCancelText
	call PlaceString
	xor a
	ld [wOptionsCursorLocation], a
	ld c, 7 ; the number of options to loop through, edited
.loop
	push bc
	call GetOptionPointer ; updates the next option
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

InitOptionsMenu_Redo:
	hlcoord 0, 0
	lb bc, SCREEN_HEIGHT - 2, SCREEN_WIDTH - 2
	call TextBoxBorder
	call PrintLabelAboutInfo ; new, testing
	hlcoord 2, 2
	ld de, AllOptionsText
	call PlaceString
	hlcoord 2, 16
	ld de, OptionMenuCancelText
	call PlaceString
	xor a
	ld [wOptionsCursorLocation], a
	ld c, 7 ; the number of options to loop through
.loop
	push bc
	call GetOptionPointer ; updates the next option
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

AllOptionsText:
	db "TXT SPEED:" ; edited
	next "ANIMATION:" ; edited
	next "BATTLESTYLE:"
	next "CAP:" ; new, it was SOUND
	next "BADGE BST:" ; new, it was PRINT
	next "LVL SCALE:" ; new
	next "EXP GAIN:@" ; new

OptionMenuCancelText:
	db "CANCEL@"

; new, for info

OptionsInfoTexts:
	dw OptionsInfoTextTextSpeed
	dw OptionsInfoTextAnimation
	dw OptionsInfoTextBattleStyle
	dw OptionsInfoTextCap
	dw OptionsInfoTextBadgeBoost
	dw OptionsInfoTextLevelScale
	dw OptionsInfoTextExpGain

OptionsInfoTextTextSpeed:
	text_far _OptionsInfoTextTextSpeed
	text_end

OptionsInfoTextAnimation:
	text_far _OptionsInfoTextAnimation
	text_end

OptionsInfoTextBattleStyle:
	text_far _OptionsInfoTextBattleStyle
	text_end

OptionsInfoTextCap:
	text_far _OptionsInfoTextCap
	text_end

OptionsInfoTextBadgeBoost:
	text_far _OptionsInfoTextBadgeBoost
	text_end

OptionsInfoTextLevelScale:
	text_far _OptionsInfoTextLevelScale
	text_end

OptionsInfoTextExpGain:
	text_far _OptionsInfoTextExpGain
	text_end

PrintLabelAboutInfo::
	hlcoord 14, 0
	ld a, "<ABAR>"
	ld [hli], a
	ld a, "<SELINFO1>"
	ld [hli], a
	ld a, "<SELINFO2>"
	ld [hli], a
	ld a, "<SELINFO3>"
	ld [hli], a
	ld a, "<SELINFO4>"
	ld [hl], a
	ret
