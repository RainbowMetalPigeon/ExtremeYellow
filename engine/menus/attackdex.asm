ShowAttackdexMenu:
	call GBPalWhiteOut
	call ClearScreen
	call UpdateSprites
	ld a, [wListScrollOffset]
	push af
	xor a
	ld [wCurrentMenuItem], a
	ld [wListScrollOffset], a
	ld [wLastMenuItem], a
	inc a
	ld [wd11e], a
	ldh [hJoy7], a
.setUpGraphics
	callfar LoadPokedexTilePatterns
.loop
	ld b, SET_PAL_GENERIC
	call RunPaletteCommand
.doAttackListMenu
	ld hl, wTopMenuItemY
	ld a, 3
	ld [hli], a ; top menu item Y
	xor a
	ld [hli], a ; top menu item X
	inc a
	ld [wMenuWatchMovingOutOfBounds], a
	inc hl
	inc hl
	ld a, 6
	ld [hli], a ; max menu item ID
	ld [hl], D_LEFT | D_RIGHT | B_BUTTON | A_BUTTON
	call HandleAttackdexListMenu
	jr c, .goToSideMenu ; if the player chose an attack from the list
.exitAttackdex
	xor a
	ld [wMenuWatchMovingOutOfBounds], a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	ldh [hJoy7], a
	ld [wWastedByteCD3A], a
	ld [wOverrideSimulatedJoypadStatesMask], a
	pop af
	ld [wListScrollOffset], a
	call GBPalWhiteOutWithDelay3
	call RunDefaultPaletteCommand
	jp ReloadMapData

.goToSideMenu
	call HandleAttackexSideMenu
	dec b
	jr z, .exitAttackdex ; if the player chose Quit
	dec b
	jr z, .doAttackListMenu ; if move not seen or player pressed B button
	dec b
	jr z, .loop
	jp .setUpGraphics ; if attack info was shown

; handles the menu on the lower right in the attackdex screen
; OUTPUT:
; b = reason for exiting menu
; 00: showed attack info
; 01: the player chose Quit
; 02: the attack has not been seen yet or the player pressed the B button
HandleAttackexSideMenu:
	call PlaceUnfilledArrowMenuCursor
	ld a, [wCurrentMenuItem]
	push af
	ld b, a
	ld a, [wLastMenuItem]
	push af
	ld a, [wListScrollOffset]
	push af
	add b
	inc a
	ld [wd11e], a
	ld a, [wd11e]
	push af
	ld a, [wDexMaxSeenAttacks]
	push af ; this doesn't need to be preserved
	ld hl, wAttackdexSeen
	call IsAttackBitSet
	ld b, 2
	jr z, .exitSideMenu
	ld hl, wTopMenuItemY
	ld a, 10
	ld [hli], a ; top menu item Y
	ld a, 15
	ld [hli], a ; top menu item X
	xor a
	ld [hli], a ; current menu item ID
	inc hl
	ld a, 1
	ld [hli], a ; max menu item ID
	ld a, A_BUTTON | B_BUTTON
	ld [hli], a ; menu watched keys (A button and B button)
	xor a
	ld [hli], a ; old menu item ID
	ld [wMenuWatchMovingOutOfBounds], a
	ldh [hJoy7], a
.handleMenuInput
	call HandleMenuInput
	bit BIT_B_BUTTON, a
	ld b, 2
	jr nz, .buttonBPressed
	ld a, [wCurrentMenuItem]
	and a
	jr z, .choseInfo
;choseQuit
	ld b, 1
.exitSideMenu
	pop af
	ld [wDexMaxSeenAttacks], a
	pop af
	ld [wd11e], a
	pop af
	ld [wListScrollOffset], a
	pop af
	ld [wLastMenuItem], a
	pop af
	ld [wCurrentMenuItem], a
	ld a, $1
	ldh [hJoy7], a
	push bc
	hlcoord 0, 3
	ld de, 20
	lb bc, " ", 13
	call DrawTileLineCopy ; cover up the menu cursor in the attack list
	pop bc
	ret

.buttonBPressed
	push bc
	hlcoord 15, 8
	ld de, 20
	lb bc, " ", 9
	call DrawTileLineCopy ; cover up the menu cursor in the side menu
	pop bc
	jr .exitSideMenu

.choseInfo
	call ShowAttackdexDataInternal
	ld b, 0
	jr .exitSideMenu

; handles the list of attacks on the left of the attackdex screen
; sets carry flag if player presses A, unsets carry flag if player presses B
HandleAttackdexListMenu:
	call Attackdex_DrawInterface
.loop
	call Attackdex_PlaceAttackList
	call GBPalNormal
	call HandleMenuInput
	bit BIT_B_BUTTON, a ; was the B button pressed?
	jp nz, .buttonBPressed
	bit BIT_A_BUTTON, a ; was the A button pressed?
	jp nz, .buttonAPressed
.checkIfUpPressed
	bit BIT_D_UP, a ; was Up pressed?
	jr z, .checkIfDownPressed
.upPressed ; scroll up one row
	ld a, [wListScrollOffset]
	and a
	jp z, .loop
	dec a
	ld [wListScrollOffset], a
	jp .loop

.checkIfDownPressed
	bit BIT_D_DOWN, a ; was Down pressed?
	jr z, .checkIfRightPressed
.downPressed ; scroll down one row
	ld a, [wDexMaxSeenAttacks]
	cp 7
	jp c, .loop ; can't if the list is shorter than 7
	sub 7
	ld b, a
	ld a, [wListScrollOffset]
	cp b
	jp z, .loop
	inc a
	ld [wListScrollOffset], a
	jp .loop

.checkIfRightPressed
	bit BIT_D_RIGHT, a ; was Right pressed?
	jr z, .checkIfLeftPressed
.rightPressed ; scroll down 7 rows
	ld a, [wDexMaxSeenAttacks]
	cp 7
	jp c, .loop ; can't if the list is shorter than 7
	sub 6
	ld b, a
	ld a, [wListScrollOffset]
	add 7
	ld [wListScrollOffset], a
	cp b
	jp c, .loop
	dec b
	ld a, b
	ld [wListScrollOffset], a
	jp .loop

.checkIfLeftPressed ; scroll up 7 rows
	bit BIT_D_LEFT, a ; was Left pressed?
	jr z, .buttonAPressed
.leftPressed
	ld a, [wListScrollOffset]
	sub 7
	ld [wListScrollOffset], a
	jp nc, .loop
	xor a
	ld [wListScrollOffset], a
	jp .loop

.buttonAPressed
	scf
	ret

.buttonBPressed
	and a
	ret

Attackdex_DrawInterface:
	xor a
	ldh [hAutoBGTransferEnabled], a
; draw the horizontal line separating the seen amount from the bottom-right menu
	hlcoord 15, 8
	ld a, "─"
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
; draw vertical line
	hlcoord 14, 0
	ld [hl], $71 ; vertical line tile
	hlcoord 14, 1
	call DrawAttackdexVerticalLine
	hlcoord 14, 9
	call DrawAttackdexVerticalLine
; print how many attacks have been seen
	ld hl, wAttackdexSeen
	ld b, wAttackdexSeenEnd - wAttackdexSeen
	call CountSetBits
	ld de, wNumSetBits
	hlcoord 16, 2
	lb bc, 1, 3
	call PrintNumber ; print number of seen attacks
; print texts
	hlcoord 16, 1
	ld de, AttackdexSeenText
	call PlaceString
	hlcoord 1, 1
	ld de, AttackdexContentsText
	call PlaceString
	hlcoord 16, 10
	ld de, AttackdexMenuItemsText
	call PlaceString
; find the highest attackdex number among the attacks the player has seen
	ld hl, wAttackdexSeenEnd - 1
	ld b, (wAttackdexSeenEnd - wAttackdexSeen) * 8 + 1
.maxSeenAttackLoop
	ld a, [hld]
	ld c, 8
.maxSeenAttackInnerLoop
	dec b
	sla a
	jr c, .storeMaxSeenAttack
	dec c
	jr nz, .maxSeenAttackInnerLoop
	jr .maxSeenAttackLoop

.storeMaxSeenAttack
	ld a, b
	ld [wDexMaxSeenAttacks], a
	ret

DrawAttackdexVerticalLine:
	ld c, 9 ; height of line
	ld de, SCREEN_WIDTH ; width of screen
	ld a, $71 ; vertical line tile
.loop
	ld [hl], a
	add hl, de
	xor 1 ; toggle between vertical line tile and box tile
	dec c
	jr nz, .loop
	ret

AttackdexSeenText:
	db "SEEN@"

AttackdexContentsText:
	db "ATTACKS:@"

AttackdexMenuItemsText:
	db   "INFO"
	next "QUIT@"

Attackdex_PlaceAttackList:
	xor a
	ldh [hAutoBGTransferEnabled], a
	hlcoord 4, 2
	lb bc, 14, 10
	call ClearScreenArea
	hlcoord 1, 3
	ld a, [wListScrollOffset]
	ld [wd11e], a
	ld d, 7
	ld a, [wDexMaxSeenAttacks]
	cp 7
	jr nc, .printAttackLoop
	ld d, a
	dec a
	ld [wMaxMenuItem], a
; loop to print attacks' indexes and names
; only if the player has seen the attack
.printAttackLoop
	ld a, [wd11e]
	inc a
	ld [wd11e], a
	push af
	push de
	push hl
	ld de, -SCREEN_WIDTH
	add hl, de
	ld de, wd11e
	lb bc, LEADING_ZEROES | 1, 3
	call PrintNumber ; print the attackdex number
	ld de, SCREEN_WIDTH
	add hl, de
	dec hl
	push hl
	ld hl, wPokedexOwned
	call IsAttackBitSet
	pop hl
	push hl
	ld hl, wAttackdexSeen
	call IsAttackBitSet
	jr nz, .getAttackName ; if the player has seen the attack
	ld de, .dashedLine ; print a dashed line in place of the name if the player hasn't seen the attack
	jr .skipGettingName
.dashedLine ; for unseen attack in the list
	db "------------@"
.getAttackName
	call GetMoveName ; TBV
.skipGettingName
	pop hl
	dec hl
	call PlaceString
	pop hl
	ld bc, 2 * SCREEN_WIDTH
	add hl, bc
	pop de
	pop af
	ld [wd11e], a
	dec d
	jr nz, .printAttackLoop
	ld a, 01
	ldh [hAutoBGTransferEnabled], a
	call Delay3
	ret

; tests if an attack's bit is set in the seen-attack bit field
; INPUT:
; [wd11e] = attackdex number
; hl = address of bit field
IsAttackBitSet:
	ld a, [wd11e]
	dec a
	ld c, a
	ld b, FLAG_TEST
	predef FlagActionPredef
	ld a, c
	and a
	ret

; function to display attackdex data from outside the attackdex
ShowAttackdexData:
	call GBPalWhiteOutWithDelay3
	call ClearScreen
;	call UpdateSprites ; TBV
	callfar LoadPokedexTilePatterns ; load pokedex tiles

; function to display attackdex data from inside the attackdex
ShowAttackdexDataInternal:
	ld hl, wd72c
	set 1, [hl]
	ld a, $33 ; 3/7 volume
	ldh [rNR50], a
	ldh a, [hTileAnimations]
	push af
	xor a
	ldh [hTileAnimations], a
	call GBPalWhiteOut ; zero all palettes
	ld a, [wd11e] ; attack ID
	ld [wcf91], a
	push af
	ld b, SET_PAL_POKEDEX
	call RunPaletteCommand
	pop af
	ld [wd11e], a
	call DrawAttackdexEntryOnScreen
	call Attackdex_PrintFlavorTextAtRow10
.waitForButtonPress
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	and A_BUTTON | B_BUTTON
	jr z, .waitForButtonPress
	pop af
	ldh [hTileAnimations], a
	call GBPalWhiteOut
	call ClearScreen
	call RunDefaultPaletteCommand
	call LoadTextBoxTilePatterns
	call GBPalNormal
	ld hl, wd72c
	res 1, [hl]
	ld a, $77 ; max volume
	ldh [rNR50], a
	ret

; horizontal line that divides the pokedex text description from the rest of the data
AttackdexDataDividerLine:
	db $68, $69, $6B, $69, $6B, $69, $6B, $69, $6B, $6B
	db $6B, $6B, $69, $6B, $69, $6B, $69, $6B, $69, $6A
	db "@"

DrawAttackdexEntryOnScreen:
	call ClearScreen

	hlcoord 0, 0
	ld de, 1
	lb bc, $64, SCREEN_WIDTH
	call DrawTileLineCopy ; draw top border

	hlcoord 0, 17
	ld b, $6f
	call DrawTileLineCopy ; draw bottom border

	hlcoord 0, 1
	ld de, 20
	lb bc, $66, $10
	call DrawTileLineCopy ; draw left border

	hlcoord 19, 1
	ld b, $67
	call DrawTileLineCopy ; draw right border

	hlcoord 1, 2
	ld de, 1
	lb bc, $6B, SCREEN_WIDTH-2
	call DrawTileLineCopy ; draw divider between attack name and its info

	ld a, $63 ; upper left corner tile
	ldcoord_a 0, 0
	ld a, $65 ; upper right corner tile
	ldcoord_a 19, 0
	ld a, $6c ; lower left corner tile
	ldcoord_a 0, 17
	ld a, $6e ; lower right corner tile
	ldcoord_a 19, 17

	hlcoord 0, 8
	ld de, AttackdexDataDividerLine
	call PlaceString ; draw horizontal divider line

; print move name
	call GetMoveName

	ld hl, wcd6d
	ld b, $FF
.loopMoveNameLength
	inc b
	ld a, [hli]
	cp $50 ; string terminator, @
	jr nz, .loopMoveNameLength
	ld a, b ; a now contains the length of the move's name

	cp 3
	jr z, .shift8
	cp 4
	jr z, .shift8
	cp 5
	jr z, .shift7
	cp 6
	jr z, .shift7
	cp 7
	jr z, .shift6
	cp 8
	jr z, .shift6
	cp 9
	jr z, .shift5
	cp 10
	jr z, .shift5
	cp 11
	jr z, .shift4
	cp 12
	jr z, .shift4
	hlcoord 1, 1
	jr .placeMoveNameString

.shift8
	hlcoord 8, 1
	jr .placeMoveNameString
.shift7
	hlcoord 7, 1
	jr .placeMoveNameString
.shift6
	hlcoord 6, 1
	jr .placeMoveNameString
.shift5
	hlcoord 5, 1
	jr .placeMoveNameString
.shift4
	hlcoord 4, 1
;	jr .placeMoveNameString

.placeMoveNameString
	call PlaceString

; gather info on the move
	ld a, [wd11e]
	dec a
	ld de, wPlayerMoveNum
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes ; adds bc to hl a times
	ld a, BANK(Moves)
	call FarCopyData ; copies bc bytes from a:hl to de

; print TYPE, BP, ACC, PP, and % texts
	hlcoord 1, 3
	ld de, TypeTextAttackdex
	call PlaceString

	hlcoord 1, 4
	ld de, BPTextAttackdex
	call PlaceString

	hlcoord 1, 5
	ld de, AccuracyTextAttackdex
	call PlaceString

	hlcoord 1, 6
	ld de, PPTextAttackdex
	call PlaceString

	hlcoord 10, 5
	ld [hl], "%"

; print base power
	hlcoord 9, 4
	ld a, [wPlayerMoveEffect]
	cp OHKO_EFFECT
	jr z, .OHKOMove
	ld a, [wPlayerMovePower]
	cp 1 ; this should cover all the SPECIAL_DAMAGE_EFFECT, AND COUNTER / MIRROR_COAT / GYRO_BALL
	jr z, .specialDamage
	hlcoord 7, 4
	ld de, wPlayerMovePower
	lb bc, 1, 3
	call PrintNumber ; prints the c-digit, b-byte value at de
	jr .afterDamagePrinting
.OHKOMove
	ld [hl], "INFINITE"
	jr .afterDamagePrinting
.specialDamage
	ld [hl], "?"
.afterDamagePrinting

; print accuracy
	hlcoord 7, 5
	xor a
	ld b, a
	ld a, [wPlayerMoveAccuracy]
.loopAccuracy
	sub 12
	jr c, .accuracyFound
	ld c, a
	ld a, b
	add 5
	ld b, a
	ld a, c
	jr .loopAccuracy
.accuracyFound
	ld a, b
	cp 76 ; fine-tuned number because
	jr c, .noSub5
	sub 5
.noSub5
	ld [wPlayerMoveAccuracyPercent], a
	ld de, wPlayerMoveAccuracyPercent
	lb bc, 1, 3
	call PrintNumber ; prints the c-digit, b-byte value at de

; print (base) PP
	hlcoord 8, 6
	ld de, wPlayerMoveMaxPP
	lb bc, 1, 2
	call PrintNumber

; print move type
	hlcoord 7, 3
	predef PrintMoveType

; print TM/HM number, if applicable
	decoord 15, 7
	callfar DisplayTMItemNameFromMoveName

; prepare pointer for description printing
	ld a, [wPlayerMoveNum]

	ld hl, AttackdexText_StruggleEffect
	cp STRUGGLE
	jp z, .done

	ld hl, AttackdexText_AncestorPowerEffect
	cp ANCESTOR_PWR
	jp z, .done

	ld hl, AttackdexText_FreezeDryEffect
	cp FREEZE_DRY
	jp z, .done

	ld hl, AttackdexText_GyroBallEffect
	cp GYRO_BALL
	jp z, .done

	ld hl, AttackdexText_BodyPressEffect
	cp BODY_PRESS
	jp z, .done

	ld hl, AttackdexText_FlailEffect
	cp FLAIL
	jp z, .done

	ld hl, AttackdexText_PsyStrikeEffect
	cp PSYSTRIKE
	jp z, .done

	ld hl, AttackdexText_ThousandArrowsEffect
	cp THOUSANDARROWS
	jp z, .done

	ld hl, AttackdexText_JudgmentEffect
	cp JUDGMENT
	jp z, .done

	ld hl, AttackdexText_SunnyDayEffect
	cp SUNNY_DAY
	jp z, .done

	ld hl, AttackdexText_SunnyDayEffect
	cp RAIN_DANCE
	jp z, .done

	ld hl, AttackdexText_SandstormEffect
	cp SANDSTORM
	jp z, .done

	ld hl, AttackdexText_HailEffect
	cp HAIL
	jp z, .done

	ld hl, AttackdexText_WeatherBallEffect
	cp WEATHER_BALL
	jp z, .done

	ld hl, AttackdexText_GrassyTerrainEffect
	cp GRASSY_TERRAIN
	jp z, .done

	ld hl, AttackdexText_ElectricTerrainEffect
	cp ELECTRIC_TERRAIN
	jp z, .done

	ld hl, AttackdexText_MistyTerrainEffect
	cp MISTY_TERRAIN
	jp z, .done

	ld hl, AttackdexText_PsychicTerrainEffect
	cp PSYCHIC_TERRAIN
	jp z, .done

	ld hl, AttackdexText_TerrainPulseEffect
	cp TERRAIN_PULSE
	jp z, .done

	ld hl, AttackdexText_TrickRoomEffect
	cp TRICK_ROOM
	jp z, .done

	ld a, [wPlayerMoveEffect]

	cp NO_ADDITIONAL_EFFECT
	jp z, .handleNoAdditionalEffect

	cp DRAIN_HP_EFFECT
	jp z, .handleDrainHPEffect

	cp POISON_EFFECT
	jp z, .handlePoisonEffect

	cp CHARGE_EFFECT
	jp z, .handleChargeEffect

	cp SPECIAL_DAMAGE_EFFECT
	jp z, .handleSpecialDamageEffect

	cp RECOIL_EFFECT
	jp z, .handleRecoilEffect

	cp HEAL_EFFECT
	jp z, .handleHealEffect

	ld hl, AttackdexText_FreezeSideEffect
	cp FREEZE_SIDE_EFFECT
	jp z, .done

	ld hl, AttackdexText_PoisonSideEffect1
	cp POISON_SIDE_EFFECT1
	jp z, .done

	ld hl, AttackdexText_PoisonSideEffect3
	cp POISON_SIDE_EFFECT3
	jp z, .done

	ld hl, AttackdexText_PoisonSideEffect4
	cp POISON_SIDE_EFFECT4
	jp z, .done

	ld hl, AttackdexText_BurnSideEffect1
	cp BURN_SIDE_EFFECT1
	jp z, .done

	ld hl, AttackdexText_BurnSideEffect2
	cp BURN_SIDE_EFFECT2
	jp z, .done

	ld hl, AttackdexText_ParalyzeSideEffect1
	cp PARALYZE_SIDE_EFFECT1
	jp z, .done

	ld hl, AttackdexText_ParalyzeSideEffect2
	cp PARALYZE_SIDE_EFFECT2
	jp z, .done

	ld hl, AttackdexText_ParalyzeSideEffectCert
	cp PARALYZE_SIDE_EFFECT_CERT
	jp z, .done

	ld hl, AttackdexText_FlinchSideEffect1
	cp FLINCH_SIDE_EFFECT1
	jp z, .done

	ld hl, AttackdexText_FlinchSideEffect2
	cp FLINCH_SIDE_EFFECT2
	jp z, .done

	ld hl, AttackdexText_FlinchSideEffect3
	cp FLINCH_SIDE_EFFECT3
	jp z, .done

	ld hl, AttackdexText_ExplodeEffect
	cp EXPLODE_EFFECT
	jp z, .done

	ld hl, AttackdexText_DreamEaterEffect
	cp DREAM_EATER_EFFECT
	jp z, .done

	ld hl, AttackdexText_MirrorMoveEffect
	cp MIRROR_MOVE_EFFECT
	jp z, .done

	ld hl, AttackdexText_AttackUp1Effect
	cp ATTACK_UP1_EFFECT
	jp z, .done

	ld hl, AttackdexText_DefenseUp1Effect
	cp DEFENSE_UP1_EFFECT
	jp z, .done

	ld hl, AttackdexText_SpeedUp1Effect
	cp SPEED_UP1_EFFECT
	jp z, .done

	ld hl, AttackdexText_SpecialUp1Effect
	cp SPECIAL_UP1_EFFECT
	jp z, .done

	ld hl, AttackdexText_AccuracyUp1Effect
	cp ACCURACY_UP1_EFFECT
	jp z, .done

	ld hl, AttackdexText_EvasionUp1Effect
	cp EVASION_UP1_EFFECT
	jp z, .done

	ld hl, AttackdexText_AttackUp2Effect
	cp ATTACK_UP2_EFFECT
	jp z, .done

	ld hl, AttackdexText_DefenseUp2Effect
	cp DEFENSE_UP2_EFFECT
	jp z, .done

	ld hl, AttackdexText_SpeedUp2Effect
	cp SPEED_UP2_EFFECT
	jp z, .done

	ld hl, AttackdexText_SpecialUp2Effect
	cp SPECIAL_UP2_EFFECT
	jp z, .done

	ld hl, AttackdexText_AccuracyUp2Effect
	cp ACCURACY_UP2_EFFECT
	jp z, .done

	ld hl, AttackdexText_EvasionUp2Effect
	cp EVASION_UP2_EFFECT
	jp z, .done

	ld hl, AttackdexText_AttackDown1Effect
	cp ATTACK_DOWN1_EFFECT
	jp z, .done

	ld hl, AttackdexText_DefenseDown1Effect
	cp DEFENSE_DOWN1_EFFECT
	jp z, .done

	ld hl, AttackdexText_SpeedDown1Effect
	cp SPEED_DOWN1_EFFECT
	jp z, .done

	ld hl, AttackdexText_SpecialDown1Effect
	cp SPECIAL_DOWN1_EFFECT
	jp z, .done

	ld hl, AttackdexText_AccuracyDown1Effect
	cp ACCURACY_DOWN1_EFFECT
	jp z, .done

	ld hl, AttackdexText_EvasionDown1Effect
	cp EVASION_DOWN1_EFFECT
	jp z, .done

	ld hl, AttackdexText_AttackDown2Effect
	cp ATTACK_DOWN2_EFFECT
	jp z, .done

	ld hl, AttackdexText_DefenseDown2Effect
	cp DEFENSE_DOWN2_EFFECT
	jp z, .done

	ld hl, AttackdexText_SpeedDown2Effect
	cp SPEED_DOWN2_EFFECT
	jp z, .done

	ld hl, AttackdexText_SpecialDown2Effect
	cp SPECIAL_DOWN2_EFFECT
	jp z, .done

	ld hl, AttackdexText_AccuracyDown2Effect
	cp ACCURACY_DOWN2_EFFECT
	jp z, .done

	ld hl, AttackdexText_EvasionDown2Effect
	cp EVASION_DOWN2_EFFECT
	jp z, .done

	ld hl, AttackdexText_AttackDownSide1Effect
	cp ATTACK_DOWN_SIDE_EFFECT1
	jp z, .done

	ld hl, AttackdexText_DefenseDownSide1Effect
	cp DEFENSE_DOWN_SIDE_EFFECT1
	jp z, .done

	ld hl, AttackdexText_SpeedDownSide1Effect
	cp SPEED_DOWN_SIDE_EFFECT1
	jp z, .done

	ld hl, AttackdexText_SpecialDownSide1Effect
	cp SPECIAL_DOWN_SIDE_EFFECT1
	jp z, .done

	ld hl, AttackdexText_AttackDownSide2Effect
	cp ATTACK_DOWN_SIDE_EFFECT2
	jp z, .done

	ld hl, AttackdexText_DefenseDownSide2Effect
	cp DEFENSE_DOWN_SIDE_EFFECT2
	jp z, .done

	ld hl, AttackdexText_SpeedDownSide2Effect
	cp SPEED_DOWN_SIDE_EFFECT2
	jp z, .done

	ld hl, AttackdexText_SpecialDownSide2Effect
	cp SPECIAL_DOWN_SIDE_EFFECT2
	jp z, .done

	ld hl, AttackdexText_AttackDownSide3Effect
	cp ATTACK_DOWN_SIDE_EFFECT3
	jp z, .done

	ld hl, AttackdexText_DefenseDownSide3Effect
	cp DEFENSE_DOWN_SIDE_EFFECT3
	jp z, .done

	ld hl, AttackdexText_SpeedDownSide3Effect
	cp SPEED_DOWN_SIDE_EFFECT3
	jp z, .done

	ld hl, AttackdexText_SpecialDownSide3Effect
	cp SPECIAL_DOWN_SIDE_EFFECT3
	jp z, .done

	ld hl, AttackdexText_AttackDownSideCertEffect
	cp ATTACK_DOWN_SIDE_EFFECT_CERT
	jp z, .done

	ld hl, AttackdexText_DefenseDownSideCertEffect
	cp DEFENSE_DOWN_SIDE_EFFECT_CERT
	jp z, .done

	ld hl, AttackdexText_SpeedDownSideCertEffect
	cp SPEED_DOWN_SIDE_EFFECT_CERT
	jp z, .done

	ld hl, AttackdexText_SpecialDownSideCertEffect
	cp SPECIAL_DOWN_SIDE_EFFECT_CERT
	jp z, .done

	ld hl, AttackdexText_AccuracyDownSideCertEffect
	cp ACCURACY_DOWN_SIDE_EFFECT_CERT
	jp z, .done

	ld hl, AttackdexText_EvasionDownSideCertEffect
	cp EVASION_DOWN_SIDE_EFFECT_CERT
	jp z, .done

	ld hl, AttackdexText_ConfusionSide1Effect
	cp CONFUSION_SIDE_EFFECT1
	jp z, .done

	ld hl, AttackdexText_ConfusionSide2Effect
	cp CONFUSION_SIDE_EFFECT2
	jp z, .done

	ld hl, AttackdexText_ConfusionSide3Effect
	cp CONFUSION_SIDE_EFFECT3
	jp z, .done

	ld hl, AttackdexText_AttackSpeedUp1Effect
	cp ATTACK_SPEED_UP1_EFFECT
	jp z, .done

	ld hl, AttackdexText_AttackUpSide1Effect
	cp ATTACK_UP_SIDE_EFF1
	jp z, .done

	ld hl, AttackdexText_DefenseUpSide1Effect
	cp DEFENSE_UP_SIDE_EFF1
	jp z, .done

	ld hl, AttackdexText_AttackUpSide2Effect
	cp ATTACK_UP_SIDE_EFF2
	jp z, .done

	ld hl, AttackdexText_AttackSelfDown1Effect
	cp ATTACK_SELFDOWN1
	jp z, .done

	ld hl, AttackdexText_DefenseSelfDown1Effect
	cp DEFENSE_SELFDOWN1
	jp z, .done

	ld hl, AttackdexText_SpeedSelfDown1Effect
	cp SPEED_SELFDOWN1
	jp z, .done

	ld hl, AttackdexText_SpecialSelfDown1Effect
	cp SPECIAL_SELFDOWN1
	jp z, .done

	ld hl, AttackdexText_AttackSelfDown2Effect
	cp ATTACK_SELFDOWN2
	jp z, .done

	ld hl, AttackdexText_DefenseSelfDown2Effect
	cp DEFENSE_SELFDOWN2
	jp z, .done

	ld hl, AttackdexText_SpeedSelfDown2Effect
	cp SPEED_SELFDOWN2
	jp z, .done

	ld hl, AttackdexText_SpecialSelfDown2Effect
	cp SPECIAL_SELFDOWN2
	jp z, .done

	ld hl, AttackdexText_AttackDefenseSelfDown1Effect
	cp ATTACK_DEFENSE_SELFDOWN1
	jp z, .done

	ld hl, AttackdexText_DefenseSpecialSelfDown1Effect
	cp DEFENSE_SPECIAL_SELFDOWN1
	jp z, .done

	ld hl, AttackdexText_ParalyzeEffect
	cp PARALYZE_EFFECT
	jp z, .done

	ld hl, AttackdexText_SleepEffect
	cp SLEEP_EFFECT
	jp z, .done

	ld hl, AttackdexText_BurnEffect
	cp BURN_EFFECT
	jp z, .done

	ld hl, AttackdexText_ConfusionEffect
	cp CONFUSION_EFFECT
	jp z, .done

	ld hl, AttackdexText_CurseEffect
	cp CURSE_EFFECT
	jp z, .done

	ld hl, AttackdexText_LeechSeedEffect
	cp LEECH_SEED_EFFECT
	jp z, .done

	ld hl, AttackdexText_PayDayEffect
	cp PAY_DAY_EFFECT
	jp z, .done

	ld hl, AttackdexText_SwiftEffect
	cp SWIFT_EFFECT
	jp z, .done

	ld hl, AttackdexText_ConversionEffect
	cp CONVERSION_EFFECT
	jp z, .done

	ld hl, AttackdexText_HazeEffect
	cp HAZE_EFFECT
	jp z, .done

	ld hl, AttackdexText_BideEffect
	cp BIDE_EFFECT
	jp z, .done

	ld hl, AttackdexText_ThrashPetalDanceEffect
	cp THRASH_PETAL_DANCE_EFFECT
	jp z, .done

	ld hl, AttackdexText_SwitchAndTeleportEffect
	cp SWITCH_AND_TELEPORT_EFFECT
	jp z, .done

	ld hl, AttackdexText_FlyEffect
	cp FLY_EFFECT
	jp z, .done

	ld hl, AttackdexText_TwoToFiveAttacksEffect
	cp TWO_TO_FIVE_ATTACKS_EFFECT
	jp z, .done

	ld hl, AttackdexText_AttackTwiceEffect
	cp ATTACK_TWICE_EFFECT
	jp z, .done

	ld hl, AttackdexText_TwineedleEffect
	cp TWINEEDLE_EFFECT
	jp z, .done

	ld hl, AttackdexText_OHKOEffect
	cp OHKO_EFFECT
	jp z, .done

	ld hl, AttackdexText_SuperFangEffect
	cp SUPER_FANG_EFFECT
	jp z, .done

	ld hl, AttackdexText_TrappingEffect
	cp TRAPPING_EFFECT
	jp z, .done

	ld hl, AttackdexText_JumpKickEffect
	cp JUMP_KICK_EFFECT
	jp z, .done

	ld hl, AttackdexText_FocusEnergyEffect
	cp FOCUS_ENERGY_EFFECT
	jp z, .done

	ld hl, AttackdexText_SubstituteEffect
	cp SUBSTITUTE_EFFECT
	jp z, .done

	ld hl, AttackdexText_HyperBeamEffect
	cp HYPER_BEAM_EFFECT
	jp z, .done

	ld hl, AttackdexText_MimicEffect
	cp MIMIC_EFFECT
	jp z, .done

	ld hl, AttackdexText_MetronomeEffect
	cp METRONOME_EFFECT
	jp z, .done

	ld hl, AttackdexText_SplashEffect
	cp SPLASH_EFFECT
	jp z, .done

	ld hl, AttackdexText_DisableEffect
	cp DISABLE_EFFECT
	jp z, .done

	ld hl, AttackdexText_TriattackEffect
	cp TRIATTACK_EFFECT
	jp z, .done

	ld hl, AttackdexText_TransformEffect
	cp TRANSFORM_EFFECT
	jp z, .done

	ld hl, AttackdexText_LightScreenEffect
	cp LIGHT_SCREEN_EFFECT
	jp z, .done

	ld hl, AttackdexText_ReflectEffect
	cp REFLECT_EFFECT
	jp z, .done

	ld hl, AttackdexText_PROXY ; SHOULD never appear
	jp .done

.handleNoAdditionalEffect
	ld a, [wPlayerMoveNum]
	ld d, a
	callfar IsMoveHighCrit
	ld hl, AttackdexText_HighCritMove
	jp c, .done
; no high-crit-rate move
	ld a, [wPlayerMoveNum]
	ld [wEnemyMoveNum], a
	callfar AIGetPriority
	ld a, e ; a contains the prio
	ld hl, AttackdexText_NoAdditionalEffect
	cp 7
	jp z, .done
; if it's not 7, it's not neutral priority
	jr nc, .higherPrio
; if there's a carry, it's below-neutral prio
	ld b, a
	ld a, 7
	sub b
	ld [wRelativePriorityForAttackdex], a
	ld hl, AttackdexText_NegativePriorityMove
	jp .done
.higherPrio
	sub 7
	ld [wRelativePriorityForAttackdex], a
	ld hl, AttackdexText_PositivePriorityMove
	jp .done

.handleDrainHPEffect
	ld a, [wPlayerMoveNum]
	ld hl, AttackdexText_DrainHPEffect50
	cp DRAININGKISS
	jp nz, .done
	ld hl, AttackdexText_DrainHPEffect75
	jp .done

.handlePoisonEffect
	ld a, [wPlayerMoveNum]
	ld hl, AttackdexText_PoisonEffect
	cp TOXIC
	jp nz, .done
	ld hl, AttackdexText_ToxicEffect
	jp .done

.handleChargeEffect
	ld a, [wPlayerMoveNum]
	ld hl, AttackdexText_DigEffect
	cp DIG
	jp z, .done
	ld hl, AttackdexText_SolarBeamEffect
	jp .done

.handleSpecialDamageEffect
	ld a, [wPlayerMoveNum]
	ld hl, AttackdexText_DragonRageEffect
	cp DRAGON_RAGE
	jp z, .done
	ld hl, AttackdexText_SonicboomEffect
	cp SONICBOOM
	jp z, .done
	ld hl, AttackdexText_PsywaveEffect
	cp PSYWAVE
	jp z, .done
	ld hl, AttackdexText_SeismicTossNightShadeEffect
	jp .done

.handleRecoilEffect ; TBE, handle VOLT_TACKLE
	ld a, [wPlayerMoveNum]
	ld hl, AttackdexText_Recoil1o2Effect
	cp HEAD_SMASH
	jp z, .done
	ld hl, AttackdexText_Recoil1o4Effect
	jp .done

.handleHealEffect
	ld a, [wPlayerMoveNum]
	ld hl, AttackdexText_RestEffect
	cp REST
	jp z, .done
	ld hl, AttackdexText_RecoverEffect
;	jp .done

.done
	push af
	push bc
	push de
	push hl
	call GBPalNormal ; what does this even do?
	pop hl
	pop de
	pop bc
	pop af
	ret

Attackdex_PrintFlavorTextAtRow10:
	bccoord 1, 10
Attackdex_PrintFlavorTextAtBC:
	ld a, %10
	ldh [hClearLetterPrintingDelayFlags], a
	call TextCommandProcessor ; print attackdex description text
	xor a
	ldh [hClearLetterPrintingDelayFlags], a
	ret

Pokedex_PrepareDexEntryForPrinting2:
	hlcoord 0, 0
	ld de, SCREEN_WIDTH
	lb bc, $66, $d
	call DrawTileLineCopy
	hlcoord 19, 0
	ld b, $67
	call DrawTileLineCopy
	hlcoord 0, 13
	ld de, $1
	lb bc, $6f, SCREEN_WIDTH
	call DrawTileLineCopy
	ld a, $6c
	ldcoord_a 0, 13
	ld a, $6e
	ldcoord_a 19, 13
	ld a, [wPrinterPokedexEntryTextPointer]
	ld l, a
	ld a, [wPrinterPokedexEntryTextPointer + 1]
	ld h, a
	bccoord 1, 1
	ldh a, [hUILayoutFlags]
	set 3, a
	ldh [hUILayoutFlags], a
	call Attackdex_PrintFlavorTextAtBC
	ldh a, [hUILayoutFlags]
	res 3, a
	ldh [hUILayoutFlags], a
	ret

; draws a line of tiles
; INPUT:
; b = tile ID
; c = number of tile ID's to write
; de = amount to destination address after each tile (1 for horizontal, 20 for vertical)
; hl = destination address
DrawTileLineCopy:
	push bc
	push de
.loop
	ld [hl], b
	add hl, de
	dec c
	jr nz, .loop
	pop de
	pop bc
	ret

TypeTextAttackdex:
	db "TYPE:@"

BPTextAttackdex:
	db "BP:@"

AccuracyTextAttackdex:
	db "ACC:@"

PPTextAttackdex:
	db "PP:@"

; ==============================================================

AttackdexText_PROXY:
	text_far _AttackdexText_PROXY
	text_end

AttackdexText_NoAdditionalEffect:
	text_far _AttackdexText_NoAdditionalEffect
	text_end

AttackdexText_HighCritMove:
	text_far _AttackdexText_HighCritMove
	text_end

AttackdexText_FreezeSideEffect:
	text_far _AttackdexText_FreezeSideEffect
	text_end

AttackdexText_PositivePriorityMove:
	text_far _AttackdexText_PositivePriorityMove
	text_end

AttackdexText_NegativePriorityMove:
	text_far _AttackdexText_NegativePriorityMove
	text_end

AttackdexText_PoisonSideEffect1:
	text_far _AttackdexText_PoisonSideEffect1
	text_end

AttackdexText_PoisonSideEffect3:
	text_far _AttackdexText_PoisonSideEffect3
	text_end

AttackdexText_PoisonSideEffect4:
	text_far _AttackdexText_PoisonSideEffect4
	text_end

AttackdexText_BurnSideEffect1:
	text_far _AttackdexText_BurnSideEffect1
	text_end

AttackdexText_BurnSideEffect2:
	text_far _AttackdexText_BurnSideEffect2
	text_end

AttackdexText_ParalyzeSideEffect1:
	text_far _AttackdexText_ParalyzeSideEffect1
	text_end

AttackdexText_ParalyzeSideEffect2:
	text_far _AttackdexText_ParalyzeSideEffect2
	text_end

AttackdexText_ParalyzeSideEffectCert:
	text_far _AttackdexText_ParalyzeSideEffectCert
	text_end

AttackdexText_FlinchSideEffect1:
	text_far _AttackdexText_FlinchSideEffect1
	text_end

AttackdexText_FlinchSideEffect2:
	text_far _AttackdexText_FlinchSideEffect2
	text_end

AttackdexText_FlinchSideEffect3:
	text_far _AttackdexText_FlinchSideEffect3
	text_end

AttackdexText_DrainHPEffect50:
	text_far _AttackdexText_DrainHPEffect50
	text_end

AttackdexText_DrainHPEffect75:
	text_far _AttackdexText_DrainHPEffect75
	text_end

AttackdexText_ExplodeEffect:
	text_far _AttackdexText_ExplodeEffect
	text_end

AttackdexText_DreamEaterEffect:
	text_far _AttackdexText_DreamEaterEffect
	text_end

AttackdexText_MirrorMoveEffect:
	text_far _AttackdexText_MirrorMoveEffect
	text_end

AttackdexText_AttackUp1Effect:
	text_far _AttackdexText_AttackUp1Effect
	text_end

AttackdexText_DefenseUp1Effect:
	text_far _AttackdexText_DefenseUp1Effect
	text_end

AttackdexText_SpeedUp1Effect:
	text_far _AttackdexText_SpeedUp1Effect
	text_end

AttackdexText_SpecialUp1Effect:
	text_far _AttackdexText_SpecialUp1Effect
	text_end

AttackdexText_AccuracyUp1Effect:
	text_far _AttackdexText_AccuracyUp1Effect
	text_end

AttackdexText_EvasionUp1Effect:
	text_far _AttackdexText_EvasionUp1Effect
	text_end

AttackdexText_AttackUp2Effect:
	text_far _AttackdexText_AttackUp2Effect
	text_end

AttackdexText_DefenseUp2Effect:
	text_far _AttackdexText_DefenseUp2Effect
	text_end

AttackdexText_SpeedUp2Effect:
	text_far _AttackdexText_SpeedUp2Effect
	text_end

AttackdexText_SpecialUp2Effect:
	text_far _AttackdexText_SpecialUp2Effect
	text_end

AttackdexText_AccuracyUp2Effect:
	text_far _AttackdexText_AccuracyUp2Effect
	text_end

AttackdexText_EvasionUp2Effect:
	text_far _AttackdexText_EvasionUp2Effect
	text_end

AttackdexText_AttackDown1Effect:
	text_far _AttackdexText_AttackDown1Effect
	text_end

AttackdexText_DefenseDown1Effect:
	text_far _AttackdexText_DefenseDown1Effect
	text_end

AttackdexText_SpeedDown1Effect:
	text_far _AttackdexText_SpeedDown1Effect
	text_end

AttackdexText_SpecialDown1Effect:
	text_far _AttackdexText_SpecialDown1Effect
	text_end

AttackdexText_AccuracyDown1Effect:
	text_far _AttackdexText_AccuracyDown1Effect
	text_end

AttackdexText_EvasionDown1Effect:
	text_far _AttackdexText_EvasionDown1Effect
	text_end

AttackdexText_AttackDown2Effect:
	text_far _AttackdexText_AttackDown2Effect
	text_end

AttackdexText_DefenseDown2Effect:
	text_far _AttackdexText_DefenseDown2Effect
	text_end

AttackdexText_SpeedDown2Effect:
	text_far _AttackdexText_SpeedDown2Effect
	text_end

AttackdexText_SpecialDown2Effect:
	text_far _AttackdexText_SpecialDown2Effect
	text_end

AttackdexText_AccuracyDown2Effect:
	text_far _AttackdexText_AccuracyDown2Effect
	text_end

AttackdexText_EvasionDown2Effect:
	text_far _AttackdexText_EvasionDown2Effect
	text_end

AttackdexText_AttackDownSide1Effect:
	text_far _AttackdexText_AttackDownSide1Effect
	text_end

AttackdexText_DefenseDownSide1Effect:
	text_far _AttackdexText_DefenseDownSide1Effect
	text_end

AttackdexText_SpeedDownSide1Effect:
	text_far _AttackdexText_SpeedDownSide1Effect
	text_end

AttackdexText_SpecialDownSide1Effect:
	text_far _AttackdexText_SpecialDownSide1Effect
	text_end

AttackdexText_AttackDownSide2Effect:
	text_far _AttackdexText_AttackDownSide2Effect
	text_end

AttackdexText_DefenseDownSide2Effect:
	text_far _AttackdexText_DefenseDownSide2Effect
	text_end

AttackdexText_SpeedDownSide2Effect:
	text_far _AttackdexText_SpeedDownSide2Effect
	text_end

AttackdexText_SpecialDownSide2Effect:
	text_far _AttackdexText_SpecialDownSide2Effect
	text_end

AttackdexText_AttackDownSide3Effect:
	text_far _AttackdexText_AttackDownSide3Effect
	text_end

AttackdexText_DefenseDownSide3Effect:
	text_far _AttackdexText_DefenseDownSide3Effect
	text_end

AttackdexText_SpeedDownSide3Effect:
	text_far _AttackdexText_SpeedDownSide3Effect
	text_end

AttackdexText_SpecialDownSide3Effect:
	text_far _AttackdexText_SpecialDownSide3Effect
	text_end

AttackdexText_AttackDownSideCertEffect:
	text_far _AttackdexText_AttackDownSideCertEffect
	text_end

AttackdexText_DefenseDownSideCertEffect:
	text_far _AttackdexText_DefenseDownSideCertEffect
	text_end

AttackdexText_SpeedDownSideCertEffect:
	text_far _AttackdexText_SpeedDownSideCertEffect
	text_end

AttackdexText_SpecialDownSideCertEffect:
	text_far _AttackdexText_SpecialDownSideCertEffect
	text_end

AttackdexText_AccuracyDownSideCertEffect:
	text_far _AttackdexText_AccuracyDownSideCertEffect
	text_end

AttackdexText_EvasionDownSideCertEffect:
	text_far _AttackdexText_EvasionDownSideCertEffect
	text_end

AttackdexText_ConfusionSide1Effect:
	text_far _AttackdexText_ConfusionSide1Effect
	text_end

AttackdexText_ConfusionSide2Effect:
	text_far _AttackdexText_ConfusionSide2Effect
	text_end

AttackdexText_ConfusionSide3Effect:
	text_far _AttackdexText_ConfusionSide3Effect
	text_end

AttackdexText_AttackSpeedUp1Effect::
	text_far _AttackdexText_AttackSpeedUp1Effect
	text_end

AttackdexText_AttackUpSide1Effect::
	text_far _AttackdexText_AttackUpSide1Effect
	text_end

AttackdexText_DefenseUpSide1Effect::
	text_far _AttackdexText_DefenseUpSide1Effect
	text_end

AttackdexText_AttackUpSide2Effect::
	text_far _AttackdexText_AttackUpSide2Effect
	text_end

AttackdexText_AttackSelfDown1Effect::
	text_far _AttackdexText_AttackSelfDown1Effect
	text_end

AttackdexText_DefenseSelfDown1Effect::
	text_far _AttackdexText_DefenseSelfDown1Effect
	text_end

AttackdexText_SpeedSelfDown1Effect::
	text_far _AttackdexText_SpeedSelfDown1Effect
	text_end

AttackdexText_SpecialSelfDown1Effect::
	text_far _AttackdexText_SpecialSelfDown1Effect
	text_end

AttackdexText_AttackSelfDown2Effect::
	text_far _AttackdexText_AttackSelfDown2Effect
	text_end

AttackdexText_DefenseSelfDown2Effect::
	text_far _AttackdexText_DefenseSelfDown2Effect
	text_end

AttackdexText_SpeedSelfDown2Effect::
	text_far _AttackdexText_SpeedSelfDown2Effect
	text_end

AttackdexText_SpecialSelfDown2Effect::
	text_far _AttackdexText_SpecialSelfDown2Effect
	text_end

AttackdexText_AttackDefenseSelfDown1Effect::
	text_far _AttackdexText_AttackDefenseSelfDown1Effect
	text_end

AttackdexText_DefenseSpecialSelfDown1Effect::
	text_far _AttackdexText_DefenseSpecialSelfDown1Effect
	text_end

AttackdexText_PoisonEffect:
	text_far _AttackdexText_PoisonEffect
	text_end

AttackdexText_ToxicEffect:
	text_far _AttackdexText_ToxicEffect
	text_end

AttackdexText_ParalyzeEffect:
	text_far _AttackdexText_ParalyzeEffect
	text_end

AttackdexText_SleepEffect:
	text_far _AttackdexText_SleepEffect
	text_end

AttackdexText_BurnEffect:
	text_far _AttackdexText_BurnEffect
	text_end

AttackdexText_ConfusionEffect:
	text_far _AttackdexText_ConfusionEffect
	text_end

AttackdexText_CurseEffect:
	text_far _AttackdexText_CurseEffect
	text_end

AttackdexText_LeechSeedEffect:
	text_far _AttackdexText_LeechSeedEffect
	text_end

AttackdexText_PayDayEffect:
	text_far _AttackdexText_PayDayEffect
	text_end

AttackdexText_SwiftEffect:
	text_far _AttackdexText_SwiftEffect
	text_end

AttackdexText_ConversionEffect:
	text_far _AttackdexText_ConversionEffect
	text_end

AttackdexText_HazeEffect:
	text_far _AttackdexText_HazeEffect
	text_end

AttackdexText_BideEffect:
	text_far _AttackdexText_BideEffect
	text_end

AttackdexText_ThrashPetalDanceEffect:
	text_far _AttackdexText_ThrashPetalDanceEffect
	text_end

AttackdexText_SwitchAndTeleportEffect:
	text_far _AttackdexText_SwitchAndTeleportEffect
	text_end

AttackdexText_DigEffect:
	text_far _AttackdexText_DigEffect
	text_end

AttackdexText_SolarBeamEffect:
	text_far _AttackdexText_SolarBeamEffect
	text_end

AttackdexText_FlyEffect:
	text_far _AttackdexText_FlyEffect
	text_end

AttackdexText_TwoToFiveAttacksEffect:
	text_far _AttackdexText_TwoToFiveAttacksEffect
	text_end

AttackdexText_AttackTwiceEffect:
	text_far _AttackdexText_AttackTwiceEffect
	text_end

AttackdexText_TwineedleEffect:
	text_far _AttackdexText_TwineedleEffect
	text_end

AttackdexText_OHKOEffect:
	text_far _AttackdexText_OHKOEffect
	text_end

AttackdexText_SuperFangEffect:
	text_far _AttackdexText_SuperFangEffect
	text_end

AttackdexText_TrappingEffect:
	text_far _AttackdexText_TrappingEffect
	text_end

AttackdexText_JumpKickEffect:
	text_far _AttackdexText_JumpKickEffect
	text_end

AttackdexText_FocusEnergyEffect:
	text_far _AttackdexText_FocusEnergyEffect
	text_end

AttackdexText_SubstituteEffect:
	text_far _AttackdexText_SubstituteEffect
	text_end

AttackdexText_HyperBeamEffect:
	text_far _AttackdexText_HyperBeamEffect
	text_end

AttackdexText_MimicEffect:
	text_far _AttackdexText_MimicEffect
	text_end

AttackdexText_MetronomeEffect:
	text_far _AttackdexText_MetronomeEffect
	text_end

AttackdexText_SplashEffect:
	text_far _AttackdexText_SplashEffect
	text_end

AttackdexText_DisableEffect:
	text_far _AttackdexText_DisableEffect
	text_end

AttackdexText_TriattackEffect:
	text_far _AttackdexText_TriattackEffect
	text_end

AttackdexText_TransformEffect:
	text_far _AttackdexText_TransformEffect
	text_end

AttackdexText_LightScreenEffect:
	text_far _AttackdexText_LightScreenEffect
	text_end

AttackdexText_ReflectEffect:
	text_far _AttackdexText_ReflectEffect
	text_end

AttackdexText_DragonRageEffect:
	text_far _AttackdexText_DragonRageEffect
	text_end

AttackdexText_SonicboomEffect:
	text_far _AttackdexText_SonicboomEffect
	text_end

AttackdexText_PsywaveEffect:
	text_far _AttackdexText_PsywaveEffect
	text_end

AttackdexText_SeismicTossNightShadeEffect:
	text_far _AttackdexText_SeismicTossNightShadeEffect
	text_end

AttackdexText_Recoil1o2Effect:
	text_far _AttackdexText_Recoil1o2Effect
	text_end

AttackdexText_Recoil1o3Effect: ; TBE, for VOLT_TACKLE
	text_far _AttackdexText_Recoil1o3Effect
	text_end

AttackdexText_Recoil1o4Effect:
	text_far _AttackdexText_Recoil1o4Effect
	text_end

AttackdexText_RestEffect:
	text_far _AttackdexText_RestEffect
	text_end

AttackdexText_RecoverEffect:
	text_far _AttackdexText_RecoverEffect
	text_end

AttackdexText_FreezeDryEffect:
	text_far _AttackdexText_FreezeDryEffect
	text_end

AttackdexText_GyroBallEffect:
	text_far _AttackdexText_GyroBallEffect
	text_end

AttackdexText_BodyPressEffect:
	text_far _AttackdexText_BodyPressEffect
	text_end

AttackdexText_FlailEffect:
	text_far _AttackdexText_FlailEffect
	text_end

AttackdexText_PsyStrikeEffect:
	text_far _AttackdexText_PsyStrikeEffect
	text_end

AttackdexText_ThousandArrowsEffect:
	text_far _AttackdexText_ThousandArrowsEffect
	text_end

AttackdexText_JudgmentEffect:
	text_far _AttackdexText_JudgmentEffect
	text_end

AttackdexText_SunnyDayEffect:
	text_far _AttackdexText_SunnyDayEffect
	text_end

AttackdexText_RainDanceEffect:
	text_far _AttackdexText_RainDanceEffect
	text_end

AttackdexText_SandstormEffect:
	text_far _AttackdexText_SandstormEffect
	text_end

AttackdexText_HailEffect:
	text_far _AttackdexText_HailEffect
	text_end

AttackdexText_StruggleEffect:
	text_far _AttackdexText_StruggleEffect
	text_end

AttackdexText_AncestorPowerEffect:
	text_far _AttackdexText_AncestorPowerEffect
	text_end

AttackdexText_GrassyTerrainEffect:
	text_far _AttackdexText_GrassyTerrainEffect
	text_end

AttackdexText_ElectricTerrainEffect:
	text_far _AttackdexText_ElectricTerrainEffect
	text_end

AttackdexText_MistyTerrainEffect:
	text_far _AttackdexText_MistyTerrainEffect
	text_end

AttackdexText_PsychicTerrainEffect:
	text_far _AttackdexText_PsychicTerrainEffect
	text_end

AttackdexText_WeatherBallEffect:
	text_far _AttackdexText_WeatherBallEffect
	text_end

AttackdexText_TerrainPulseEffect:
	text_far _AttackdexText_TerrainPulseEffect
	text_end

AttackdexText_TrickRoomEffect:
	text_far _AttackdexText_TrickRoomEffect
	text_end
