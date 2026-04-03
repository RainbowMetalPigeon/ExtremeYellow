ShowChoicedexMenu::
	call GBPalWhiteOut
	call ClearScreen
	call UpdateSprites
	ld a, [wListScrollOffset]
	push af
	xor a
	ld [wCurrentMenuItem], a
	ld [wListScrollOffset], a
	ld [wLastMenuItem], a
	ld [wMultipurposeTemporaryStorage], a
	inc a
	ld [wd11e], a
	ldh [hJoy7], a
.setUpGraphics
	callfar LoadPokedexTilePatterns
.loop
	ld b, SET_PAL_GENERIC
	call RunPaletteCommand
.doPokemonListMenu
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
	call HandleChoicedexListMenu
	jr c, .chosenAMon ; if the player chose a pokemon from the list ; TBE
.exitChoicedex
	xor a
	ld [wMenuWatchMovingOutOfBounds], a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	ldh [hJoy7], a
	ld [wWastedByteCD3A], a
	ld [wOverrideSimulatedJoypadStatesMask], a
	pop af
	ld [wListScrollOffset], a
	call RunDefaultPaletteCommand
	call GBPalNormal
	call GBPalWhiteOutWithDelay3
	ret
	jp ReloadMapData

.chosenAMon
	ld a, [wCurrentMenuItem]
	ld b, a
	ld a, [wListScrollOffset]
	add b
	inc a
	ld [wd11e], a
	ld a, 1
	ld [wMultipurposeTemporaryStorage], a
	jr .exitChoicedex

; handles the list of pokemon on the left of the pokedex screen
; sets carry flag if player presses A, unsets carry flag if player presses B
HandleChoicedexListMenu:
	call Choicedex_DrawInterface
.loop
	call Choicedex_PlacePokemonList
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
	ld a, [wDexMaxSeenMon]
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
	ld a, [wDexMaxSeenMon]
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

Choicedex_DrawInterface:
	xor a
	ldh [hAutoBGTransferEnabled], a
; draw the horizontal line separating the seen and owned amounts from the menu ; TBE
	hlcoord 15, 5 ; edited
	ld a, "─"
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	hlcoord 14, 0
	ld [hl], $71 ; vertical line tile

	hlcoord 14, 1
	call DrawChoicedexVerticalLine

	hlcoord 14, 9
	call DrawChoicedexVerticalLine

	ld hl, wPokedexSeen
	ld b, wPokedexSeenEnd - wPokedexSeen
	call CountSetBits
	ld de, wNumSetBits
	hlcoord 16, 1 ; edited
	lb bc, 1, 3
	call PrintNumber ; print number of seen pokemon

	ld hl, wPokedexOwned
	ld b, wPokedexOwnedEnd - wPokedexOwned
	call CountSetBits
	ld de, wNumSetBits
	hlcoord 16, 4 ; edited
	lb bc, 1, 3
	call PrintNumber ; print number of owned pokemon

	hlcoord 15, 0 ; edited
	ld de, ChoicedexSeenText
	call PlaceString

	hlcoord 15, 3 ; edited
	ld de, ChoicedexOwnText
	call PlaceString

	hlcoord 1, 0 ; edited
	ld de, ChoicedexChooseText
	call PlaceString

	ld a, 219
	ld [wDexMaxSeenMon], a
	ret

DrawChoicedexVerticalLine:
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

ChoicedexSeenText:
	db "SEEN@"

ChoicedexOwnText:
	db "OWN@"

ChoicedexChooseText:
	db "CHOOSE@"

Choicedex_PlacePokemonList:
	xor a
	ldh [hAutoBGTransferEnabled], a
	hlcoord 4, 2
	lb bc, 14, 10
	call ClearScreenArea
	hlcoord 1, 3
	ld a, [wListScrollOffset]
	ld [wd11e], a
	ld d, 7
	ld a, [wDexMaxSeenMon]
	cp 7
	jr nc, .printPokemonLoop
	ld d, a
	dec a
	ld [wMaxMenuItem], a
; loop to print pokemon pokedex numbers and names
; if the player has owned the pokemon, it puts a pokeball beside the name
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
	call IsPokemonBitSet2
	pop hl
	ld a, " "
	jr z, .writeTile
	ld a, $72 ; pokeball tile
.writeTile
	ld [hl], a ; put a pokeball next to pokemon that the player has owned
	push hl
.getPokemonName
	callfar PokedexToIndex
	call GetMonName
.skipGettingName
	pop hl
	inc hl
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

; tests if a pokemon's bit is set in the seen or owned pokemon bit fields
; INPUT:
; [wd11e] = pokedex number
; hl = address of bit field
IsPokemonBitSet2:
	ld a, [wd11e]
	dec a
	ld c, a
	ld b, FLAG_TEST
	predef FlagActionPredef
	ld a, c
	and a
	ret
