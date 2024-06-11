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
	ld a, 8
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
; draw the horizontal line separating the seen and owned amounts from the menu
	hlcoord 15, 6
	ld a, "─"
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
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
	hlcoord 16, 8
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

PokedexOwnText2:
	db "OWN@"

AttackdexContentsText:
	db "CONTENTS@"

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
	jr nc, .printPokemonLoop
	ld d, a
	dec a
	ld [wMaxMenuItem], a
; loop to print attacks' indexes and names
; only if the player has seen the attack
.printPokemonLoop
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
	call PrintNumber ; print the pokedex number
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
	db "----------@"
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
	jr nz, .printPokemonLoop
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

; function to display pokedex data from outside the pokedex
ShowAttackdexData:
	call GBPalWhiteOutWithDelay3
	call ClearScreen
	call UpdateSprites
	callfar LoadPokedexTilePatterns ; load pokedex tiles

; function to display pokedex data from inside the pokedex
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
	call DrawDexEntryOnScreen2
	call Pokedex_PrintFlavorTextAtRow112
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
PokedexDataDividerLine2:
	db $68, $69, $6B, $69, $6B, $69, $6B, $69, $6B, $6B
	db $6B, $6B, $69, $6B, $69, $6B, $69, $6B, $69, $6A
	db "@"

DrawDexEntryOnScreen2:
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

	ld a, $63 ; upper left corner tile
	ldcoord_a 0, 0
	ld a, $65 ; upper right corner tile
	ldcoord_a 19, 0
	ld a, $6c ; lower left corner tile
	ldcoord_a 0, 17
	ld a, $6e ; lower right corner tile
	ldcoord_a 19, 17

	hlcoord 0, 9
	ld de, PokedexDataDividerLine2
	call PlaceString ; draw horizontal divider line

	call GetMoveName ; TBV
	hlcoord 9, 2
	call PlaceString

	ld hl, AttackdexEntryPointers
	ld a, [wd11e]
	dec a
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl] ; de = address of pokedex entry

	hlcoord 9, 4
	call PlaceString ; print species name

	ld h, b
	ld l, c
	push de
	ld a, [wd11e]
	push af
	call IndexToPokedex

	hlcoord 2, 8
	ld a, "№"
	ld [hli], a
	ld a, "<DOT>"
	ld [hli], a
	ld de, wd11e
	lb bc, LEADING_ZEROES | 1, 3
	call PrintNumber ; print pokedex number

	ld hl, wPokedexOwned
	call IsAttackBitSet
	pop af
	ld [wd11e], a
	ld a, [wcf91]
	ld [wd0b5], a
	pop de

	push af
	push bc
	push de
	push hl

	call Delay3
	call GBPalNormal
	call GetMonHeader ; load pokemon picture location
;	hlcoord 1, 1
;	call LoadFlippedFrontSpriteByMonIndex ; draw pokemon picture
;	ld a, [wcf91]
;	call PlayCry ; play pokemon cry

	pop hl
	pop de
	pop bc
	pop af

	ld a, c
	and a

	ret


Pokedex_PrintFlavorTextAtRow112:
	bccoord 1, 11
Pokedex_PrintFlavorTextAtBC2:
	ld a, %10
	ldh [hClearLetterPrintingDelayFlags], a
	call TextCommandProcessor ; print pokedex description text
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
	call Pokedex_PrintFlavorTextAtBC2
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

INCLUDE "data/moves/attackdex_entries.asm"
