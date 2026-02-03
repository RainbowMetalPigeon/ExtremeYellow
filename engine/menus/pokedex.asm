ShowPokedexMenu:
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
	call HandlePokedexListMenu
	jr c, .goToSideMenu ; if the player chose a pokemon from the list
.exitPokedex
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
	call HandlePokedexSideMenu
	dec b
	jr z, .exitPokedex ; if the player chose Quit
	dec b
	jr z, .doPokemonListMenu ; if pokemon not seen or player pressed B button
	dec b
	jr z, .loop
	jp .setUpGraphics ; if pokemon data or area was shown

; handles the menu on the lower right in the pokedex screen
; OUTPUT:
; b = reason for exiting menu
; 00: showed pokemon data or area
; 01: the player chose Quit
; 02: the pokemon has not been seen yet or the player pressed the B button
HandlePokedexSideMenu:
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
	ld a, [wDexMaxSeenMon]
	push af ; this doesn't need to be preserved
	ld hl, wPokedexSeen
	call IsPokemonBitSet
	ld b, 2
	jr z, .exitSideMenu
	call PokedexToIndex
	ld hl, wTopMenuItemY
	ld a, 6 ; edited
	ld [hli], a ; top menu item Y
	ld a, 15
	ld [hli], a ; top menu item X
	xor a
	ld [hli], a ; current menu item ID
	inc hl
	ld a, 5 ; edited
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
	jr z, .choseData
	dec a ; new
	jr z, .choseInfo ; new
	dec a
	jr z, .choseCry
	dec a
	jr z, .choseArea
	dec a
	vc_patch Forbid_printing_Pokedex
IF DEF (_YELLOW_VC)
	jr z, .handleMenuInput
ELSE
	jr z, .chosePrint
ENDC
	vc_patch_end
.choseQuit
	ld b, 1
.exitSideMenu
	pop af
	ld [wDexMaxSeenMon], a
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
	call DrawTileLine ; cover up the menu cursor in the pokemon list
	pop bc
	ret

.buttonBPressed
	push bc
	hlcoord 15, 6 ; edited
	ld de, 20
	lb bc, " ", 11 ; edited
	call DrawTileLine ; cover up the menu cursor in the side menu
	pop bc
	jr .exitSideMenu

.choseData
	call ShowPokedexDataInternal
	ld b, 0
	jr .exitSideMenu

.choseInfo ; new
	call ShowPokedexInfo
	ld b, 0
	jr .exitSideMenu

; play pokemon cry
.choseCry
	ld a, [wd11e]
	call GetCryData
	call PlaySound
	jr .handleMenuInput

.choseArea
	predef LoadTownMap_Nest ; display pokemon areas
	ld b, 0
	jr .exitSideMenu

.chosePrint
	ldh a, [hTileAnimations]
	push af
	xor a
	ldh [hTileAnimations], a
	ld a, [wd11e]
	ld [wcf91], a
	callfar PrintPokedexEntry
	xor a
	ldh [hAutoBGTransferEnabled], a
	call ClearScreen
	pop af
	ldh [hTileAnimations], a
	ld b, $3
	jr .exitSideMenu

; handles the list of pokemon on the left of the pokedex screen
; sets carry flag if player presses A, unsets carry flag if player presses B
HandlePokedexListMenu:
	call Pokedex_DrawInterface
.loop
	call Pokedex_PlacePokemonList
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

Pokedex_DrawInterface:
	xor a
	ldh [hAutoBGTransferEnabled], a
; draw the horizontal line separating the seen and owned amounts from the menu
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
	call DrawPokedexVerticalLine

	hlcoord 14, 9
	call DrawPokedexVerticalLine

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
	ld de, PokedexSeenText
	call PlaceString

	hlcoord 15, 3 ; edited
	ld de, PokedexOwnText
	call PlaceString

	hlcoord 1, 0 ; edited
	ld de, PokedexContentsText
	call PlaceString

	hlcoord 16, 6 ; edited
	ld de, PokedexMenuItemsText
	call PlaceString

; find the highest pokedex number among the pokemon the player has seen
	ld hl, wPokedexSeenEnd - 1
	ld b, (wPokedexSeenEnd - wPokedexSeen) * 8 + 1
.maxSeenPokemonLoop
	ld a, [hld]
	ld c, 8
.maxSeenPokemonInnerLoop
	dec b
	sla a
	jr c, .storeMaxSeenPokemon
	dec c
	jr nz, .maxSeenPokemonInnerLoop
	jr .maxSeenPokemonLoop

.storeMaxSeenPokemon
	ld a, b
	ld [wDexMaxSeenMon], a
	ret

DrawPokedexVerticalLine:
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

PokedexSeenText:
	db "SEEN@"

PokedexOwnText:
	db "OWN@"

PokedexContentsText:
	db "CONTENTS@"

PokedexMenuItemsText:
	db   "DATA"
	next "INFO" ; new
	next "CRY"
	next "AREA"
	next "PRNT"
	next "QUIT@"

Pokedex_PlacePokemonList:
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
	call IsPokemonBitSet
	pop hl
	ld a, " "
	jr z, .writeTile
	ld a, $72 ; pokeball tile
.writeTile
	ld [hl], a ; put a pokeball next to pokemon that the player has owned
	push hl
	ld hl, wPokedexSeen
	call IsPokemonBitSet
	jr nz, .getPokemonName ; if the player has seen the pokemon
	ld de, .dashedLine ; print a dashed line in place of the name if the player hasn't seen the pokemon
	jr .skipGettingName
.dashedLine ; for unseen pokemon in the list
	db "----------@"
.getPokemonName
	call PokedexToIndex
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
IsPokemonBitSet:
	ld a, [wd11e]
	dec a
	ld c, a
	ld b, FLAG_TEST
	predef FlagActionPredef
	ld a, c
	and a
	ret

; function to display pokedex data from outside the pokedex
ShowPokedexData:
	call GBPalWhiteOutWithDelay3
	call ClearScreen
	call UpdateSprites
	callfar LoadPokedexTilePatterns ; load pokedex tiles

; function to display pokedex data from inside the pokedex
ShowPokedexDataInternal:
	ld hl, wd72c
	set 1, [hl]
	ld a, $33 ; 3/7 volume
	ldh [rNR50], a
	ldh a, [hTileAnimations]
	push af
	xor a
	ldh [hTileAnimations], a
	call GBPalWhiteOut ; zero all palettes
	ld a, [wd11e] ; pokemon ID
	ld [wcf91], a
	push af
	ld b, SET_PAL_POKEDEX
	call RunPaletteCommand
	pop af
	ld [wd11e], a
	call DrawDexEntryOnScreen
	call c, Pokedex_PrintFlavorTextAtRow11
.waitForButtonPress
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	and A_BUTTON | B_BUTTON | SELECT ; edited for shiny
	jr z, .waitForButtonPress
; new, for the shiny
	bit BIT_SELECT, a
	jr z, .vanilla
; SELECT has been pressed, change palette shiny <-> non-shiny
	ld a, [wShinyOrNotShinyPokedexPalette]
	and a
	ld b, SET_PAL_POKEDEX_SHINY
	jr z, .changeToShiny
; palette is already shiny, let's make it non-shiny
	ld b, SET_PAL_POKEDEX
	call RunPaletteCommand
	xor a
	jr .end
.changeToShiny
	call RunPaletteCommand
	ld a, 1
.end
	ld [wShinyOrNotShinyPokedexPalette], a
	jr .waitForButtonPress
.vanilla
; back to vanilla
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

; new for evos and learnsets
ShowPokedexInfo: ; TBE
	ld hl, wd72c
	set 1, [hl]
	ld a, $33 ; 3/7 volume
	ldh [rNR50], a
	ldh a, [hTileAnimations]

	push af
	xor a
	ldh [hTileAnimations], a
	call GBPalWhiteOut ; zero all palettes

	ld a, [wd11e] ; pokemon ID
	ld [wcf91], a
	push af
	ld b, SET_PAL_POKEDEX
	call RunPaletteCommand
	pop af
	ld [wd11e], a

;	ld hl, wPokedexOwned
;	call IsPokemonBitSet ; info in z flag
;	jr z, .printUnknownInfo

	call DrawMonInfoOnScreen

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

; change to proper units
HeightWeightText1:
	db   "HT   ???<M>@"
HeightWeightText2:
	db   "WT   ???<K><G>@"

HeightWeightTextEEternatus1: ; new, to handle EEternatus
	db   "HT 100.0<M>@"
HeightWeightTextEEternatus2:
	db   "WT 950.0<K><G>@"

; XXX does anything point to this?
PokeText:
	db "#@"

; horizontal line that divides the pokedex text description from the rest of the data
PokedexDataDividerLine:
	db $68, $69, $6B, $69, $6B, $69, $6B, $69, $6B, $6B
	db $6B, $6B, $69, $6B, $69, $6B, $69, $6B, $69, $6A
	db "@"

DrawDexEntryOnScreen:
	call ClearScreen

	hlcoord 0, 0
	ld de, 1
	lb bc, $64, SCREEN_WIDTH
	call DrawTileLine ; draw top border

	hlcoord 0, 17
	ld b, $6f
	call DrawTileLine ; draw bottom border

	hlcoord 0, 1
	ld de, 20
	lb bc, $66, $10
	call DrawTileLine ; draw left border

	hlcoord 19, 1
	ld b, $67
	call DrawTileLine ; draw right border

	ld a, $63 ; upper left corner tile
	ldcoord_a 0, 0
	ld a, $65 ; upper right corner tile
	ldcoord_a 19, 0
	ld a, $6c ; lower left corner tile
	ldcoord_a 0, 17
	ld a, $6e ; lower right corner tile
	ldcoord_a 19, 17

	hlcoord 0, 9
	ld de, PokedexDataDividerLine
	call PlaceString ; draw horizontal divider line

	hlcoord 9, 7 ; edited
	ld de, HeightWeightText1 ; edited
	call PlaceString

	; new
	hlcoord 9, 8
	ld de, HeightWeightText2
	call PlaceString

	call GetMonName
	hlcoord 9, 1 ; edited
	call PlaceString

	ld hl, PokedexEntryPointers
	ld a, [wd11e]
	dec a
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl] ; de = address of pokedex entry

	hlcoord 9, 2 ; edited
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
	call IsPokemonBitSet
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
	hlcoord 1, 1
	call LoadFlippedFrontSpriteByMonIndex ; draw pokemon picture
	ld a, [wcf91]
	call PlayCry ; play pokemon cry

	; print pokemon types
;	hlcoord 9, 4
;	predef PrintMonType
	decoord 9, 4
	callfar PrintMonTypeNarrow

	pop hl
	pop de
	pop bc
	pop af

	ld a, c
	and a
	ret z ; if the pokemon has not been owned, don't print the height, weight, or description

; change to proper units
	inc de ; de = address of decimetre (height)
	ld a, [de] ; reads decimetre, but a is overwritten without being used
	push af
	hlcoord 13, 7 ; edited
	lb bc, 1, 3
	call PrintNumber ; print decimetre (height)
	hlcoord 14, 7 ; edited
	pop af
	cp $a
	jr nc, .heightNext
	ld [hl], "0" ; if the height is less than 10, put a 0 before the decimal point
.heightNext
	inc hl
	ld a, [hli]
	ld [hld], a ; make space for the decimal point by moving the last digit forward one tile
	ld [hl], "<DOT>" ; decimal point tile
; now print the weight (note that weight is stored in tenths of kilograms internally)
; back to default code
	inc de
	inc de
	inc de ; de = address of upper byte of weight
	push de
; put weight in big-endian order at hDexWeight
	ld hl, hDexWeight
	ld a, [hl] ; save existing value of [hDexWeight]
	push af
	ld a, [de] ; a = upper byte of weight
	ld [hli], a ; store upper byte of weight in [hDexWeight]
	ld a, [hl] ; save existing value of [hDexWeight + 1]
	push af
	dec de
	ld a, [de] ; a = lower byte of weight
	ld [hl], a ; store lower byte of weight in [hDexWeight + 1]
	ld de, hDexWeight
	hlcoord 12, 8						; changed to proper units
	lb bc, 2, 4 ; 2 bytes, 4 digits		; changed to proper units
	call PrintNumber ; print weight
	hlcoord 14, 8
	ldh a, [hDexWeight + 1]
	sub 10
	ldh a, [hDexWeight]
	sbc 0
	jr nc, .next
	ld [hl], "0" ; if the weight is less than 10, put a 0 before the decimal point
.next
	inc hl
	ld a, [hli]
	ld [hld], a ; make space for the decimal point by moving the last digit forward one tile
	ld [hl], "<DOT>" ; decimal point tile
	pop af
	ldh [hDexWeight + 1], a ; restore original value of [hDexWeight + 1]
	pop af
	ldh [hDexWeight], a ; restore original value of [hDexWeight]
	pop hl
	inc hl ; hl = address of pokedex description text

	; new, to handle EEternatus
	push af
	ld a, [wd11e]
	cp EETERNATUS
	jr nz, .normalInfoPrinter
	push bc
	push de
	push hl
	hlcoord 9, 7
	ld de, HeightWeightTextEEternatus1
	call PlaceString
	hlcoord 9, 8
	ld de, HeightWeightTextEEternatus2
	call PlaceString
	pop hl
	pop de
	pop bc
.normalInfoPrinter
	pop af

	scf
	ret

Pokedex_PrintFlavorTextAtRow11:
	bccoord 1, 11
Pokedex_PrintFlavorTextAtBC:
	ld a, %10
	ldh [hClearLetterPrintingDelayFlags], a
	call TextCommandProcessor ; print pokedex description text
	xor a
	ldh [hClearLetterPrintingDelayFlags], a
	ret

Pokedex_PrepareDexEntryForPrinting:
	hlcoord 0, 0
	ld de, SCREEN_WIDTH
	lb bc, $66, $d
	call DrawTileLine
	hlcoord 19, 0
	ld b, $67
	call DrawTileLine
	hlcoord 0, 13
	ld de, $1
	lb bc, $6f, SCREEN_WIDTH
	call DrawTileLine
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
	call Pokedex_PrintFlavorTextAtBC
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
DrawTileLine:
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

INCLUDE "data/pokemon/dex_entries.asm"

PokedexToIndex:
	; converts the Pokédex number at wd11e to an index
	push bc
	push hl
	ld a, [wd11e]
	ld b, a
	ld c, 0
	ld hl, PokedexOrder

.loop ; go through the list until we find an entry with a matching dex number
	inc c
	ld a, [hli]
	cp b
	jr nz, .loop

	ld a, c
	ld [wd11e], a
	pop hl
	pop bc
	ret

IndexToPokedex:
	; converts the index number at wd11e to a Pokédex number
	push bc
	push hl
	ld a, [wd11e]
	dec a
	ld hl, PokedexOrder
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wd11e], a
	pop hl
	pop bc
	ret

INCLUDE "data/pokemon/dex_order.asm"

; new, testing

GetEnemyWeight:: ; new
; input: wEnemyMonSpecies
; output: d,a=higher weight bit
; no register is preserved
	ld a, [wEnemyMonSpecies]
	dec a
	ld c, a
	ld b, $0
	ld hl, PokedexEntryPointers
	add hl, bc
	add hl, bc
	ld de, wcd6d
	ld bc, $2
	ld a, BANK(PokedexEntryPointers)
	call FarCopyData
	ld hl, wcd6d
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wcd6d
	ld bc, $14
	ld a, BANK(PokedexEntryPointers)
	call FarCopyData
	ld hl, wcd6d
.loop2
	ld a, [hli]
	cp "@"
	jr nz, .loop2
	ld a, [hli]

	ld a, [hli] ; now a contains the lower weight bit
	ld e, a ; now d contains the lower weight bit

	ld a, [hl] ; now a contains the higher weight bit
	ld d, a ; now e contains the higher weight bit

	ret

; new ==========================================================

DrawMonInfoOnScreen:

	call DrawPokedexBordersForInfoPages

	call GBPalNormal

	ld hl, wPokedexOwned
	call IsPokemonBitSet
	jr nz, .pokemonOwned

; pokemon not owned
	call GetMonName
	hlcoord 1, 1
	call PlaceString
	ld h, b
	ld l, c
	ld de, InfoText
	call PlaceString
	hlcoord 3, 4
	ld de, InfoWhenOwnedText
	jp PlaceString

.pokemonOwned

	call PrintEvoInfo

.waitForButtonPress1
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	and A_BUTTON | B_BUTTON
	jr z, .waitForButtonPress1

	call PrintLevelUpMovesInfo

.waitForButtonPress2
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	and A_BUTTON | B_BUTTON
	jr z, .waitForButtonPress2

	call PrintTMHMsMovesInfo

.waitForButtonPress3
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	and A_BUTTON | B_BUTTON
	jr z, .waitForButtonPress3

	call PrintBaseStatsInfo

	ret

MonsEvolutionsText:
	db "'s EVOs@"

InfoText:
	db "'s INFO@"

InfoWhenOwnedText:
	db   "INFO AVAILABLE"
	next "  WHEN OWNED@"

; ----------------------------------------------------------

PrintEvoInfo:

;	call DrawPokedexBordersForInfoPages

	hlcoord 1, 1
	ld a, h
	ld [wEphemerealTempBuffer2ByteStorage], a
	ld a, l
	ld [wEphemerealTempBuffer2ByteStorage+1], a

	call GetMonName
	hlcoord 1, 1
	call PlaceString
	ld h, b
	ld l, c
	ld de, MonsEvolutionsText
	call PlaceString

	ld hl, EvosMovesPointerTable
	ld b, 0
	ld a, [wd11e]
	ld [wLoadedMonSpecies], a
	dec a
	add a
	rl b
	ld c, a
	add hl, bc
	ld de, wBuffer
	ld a, BANK(EvosMovesPointerTable)
	ld bc, 2
	call FarCopyData ; wBuffer has the address to evomoves list
	ld hl, wBuffer
	ld a, [hli]
	ld h, [hl]
	ld l, a ; at this point hl has the address for this pokémon's evomoves list

.nextEvoEntry
	push hl ; stack start address for evolution moves (this will be later updated with the next entry)

	ld de, wBuffer
	ld a, BANK(EvosMovesPointerTable)
	ld bc, EVOLUTION_SIZE ; 4 bytes, as currently the biggest entry for an evolution is 4 bytes
	call FarCopyData ; wBuffer now has a copy of first evo entry

	ld hl, wBuffer
	ld a, [hli]
	and a ; reached terminator?
	jr nz, .noTerminator
; we reached the end
	jp .concludeEvoLoop

.noTerminator
	push hl
	push af
	SetEvent EVENT_AT_LEAST_ONE_EVOLUTION_TO_PRINT_IN_DEX
	call IncreaseHLCoordinatesBy1Row
	pop af
	pop hl
	cp EV_ITEM
	jr z, .handleItem ; is it an item evolution?
	cp EV_LEVEL
	jr z, .handleLevel

.handleTrade
	inc hl
	push hl
	call IncreaseHLCoordinatesBy2Row
	ld de, ViaTradeText
	call PlaceString
	call PrintColonRightAfterString

	call SaveValueOfwd11e
	pop hl
	ld a, [hl] ; a contains the evolved form
	ld [wd11e], a
	call GetMonName
	call GetIndentedHLCoordinates
	call PlaceString
	call RestoreValueOfwd11e

	jr .progressWithChecks3Bytes

.handleLevel
	ld a, [hli] ; a contains the level at which the mons evolve
	            ; hl now points to the mon it evolves into
	push hl
	ld [wUniQuizAnswer], a
	call IncreaseHLCoordinatesBy2Row
	ld de, ArrowLevelText
	call PlaceString
	ld h, b
	ld l, c
	push hl
	ld de, wUniQuizAnswer
	lb bc, 1, 2
	call PrintNumber
	pop hl
	call PrintColonRightAfterNumberAtDEStartingAtHL

	call SaveValueOfwd11e
	pop hl
	ld a, [hl] ; a contains the evolved form
	ld [wd11e], a
	call GetMonName
	call GetIndentedHLCoordinates
	call PlaceString
	call RestoreValueOfwd11e

	jr .progressWithChecks3Bytes

.handleItem
	call SaveValueOfwd11e

	ld a, [hli] ; a contains the item with which the mon evolves
	            ; hl now points to 1 (because... yes)
	inc hl
	push hl
	ld [wd11e], a

	ld de, ArrowText
	call IncreaseHLCoordinatesBy2Row
	call PlaceString
	ld h, b
	ld l, c
	push hl
	call GetItemName ; given an item ID at [wd11e], store the name of the item into a string starting at wcd6d
	ld de, wcd6d
	pop hl
	call PlaceString
	call PrintColonRightAfterString

	pop hl ; now hl points to the mon it evolves into
	ld a, [hl] ; a contains the evolved form
	ld [wd11e], a
	call GetMonName
	call GetIndentedHLCoordinates
	call PlaceString
	call RestoreValueOfwd11e

	jr .progressWithChecks4Bytes

.progressWithChecks3Bytes
	pop hl
	jr .continueWithProgress

.progressWithChecks4Bytes
	pop hl
	inc hl

.continueWithProgress
	inc hl
	inc hl
	inc hl ; hl now holds the address to the next evo entry
	jp .nextEvoEntry ; we have the address, load next entry to wBuffer

.concludeEvoLoop
	CheckAndResetEvent EVENT_AT_LEAST_ONE_EVOLUTION_TO_PRINT_IN_DEX
	jr nz, .popAndRet
	hlcoord 3, 4
	ld de, UnableToEvolveText
	call PlaceString
.popAndRet
	pop hl
	ret


; TBE: special case for Tyrogue
; TBE: special case for Eevee


UnableToEvolveText:
	db "CANNOT EVOLVE@"

ViaTradeText:
	db "▷ VIA TRADE@"

ArrowLevelText:
	db "▷ LV @"

ArrowText:
	db "▷ @"

SaveValueOfwd11e:
	ld a, [wd11e]
	ld [wMultipurposeTemporaryStorage], a
	ret

RestoreValueOfwd11e:
	ld a, [wMultipurposeTemporaryStorage]
	ld [wd11e], a
	ret

IncreaseHLCoordinatesBy2Row:
	ld a, [wEphemerealTempBuffer2ByteStorage]
	ld h, a
	ld a, [wEphemerealTempBuffer2ByteStorage+1]
	ld l, a
	ld bc, SCREEN_WIDTH * 2
	add hl, bc
	ld a, h
	ld [wEphemerealTempBuffer2ByteStorage], a
	ld a, l
	ld [wEphemerealTempBuffer2ByteStorage+1], a
	ret

IncreaseHLCoordinatesBy1Row:
	ld a, [wEphemerealTempBuffer2ByteStorage]
	ld h, a
	ld a, [wEphemerealTempBuffer2ByteStorage+1]
	ld l, a
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld a, h
	ld [wEphemerealTempBuffer2ByteStorage], a
	ld a, l
	ld [wEphemerealTempBuffer2ByteStorage+1], a
	ret

GetIndentedHLCoordinates:
	ld a, [wEphemerealTempBuffer2ByteStorage]
	ld h, a
	ld a, [wEphemerealTempBuffer2ByteStorage+1]
	ld l, a
	ld bc, SCREEN_WIDTH
	add hl, bc
	inc hl
	inc hl
	ret

PrintColonRightAfterString:
	ld h, b
	ld l, c
	ld de, ColonText
	jp PlaceString

PrintColonRightAfterNumberAtDEStartingAtHL:
	ld a, [de]
	cp 10
	jr c, .small
	cp 100
	jr nz, .medium
.big
	inc hl
.medium
	inc hl
.small
	inc hl
	inc hl
	ld de, ColonText
	jp PlaceString

ColonText:
	db ":@"

; ----------------------------------------------------------

PrintLevelUpMovesInfo:

	inc hl ; hl pointed to the 0 that divides evolutions from level-up moves
	push hl ; now hl points to the first level-up move entry

;	call DrawPokedexBordersForInfoPages
	call ClearScreenExceptBorders

	call GetMonName
	hlcoord 1, 1
	call PlaceString
	ld h, b
	ld l, c
	ld de, LevelUpMovesText
	call PlaceString

	call InitializeHLSpecialCoordinatesAndInterationsCounter

	pop hl

.nextLevelUpEntry
	push hl

	ld de, wBuffer
	ld a, BANK(EvosMovesPointerTable)
	ld bc, 3
	call FarCopyData

	ld hl, wBuffer
	ld a, [hli]
	and a ; reached terminator?
	jr nz, .noTerminator
; we reached the end
	jp .concludeLevelUpLoop

.noTerminator
	push hl
	push af
	SetEvent EVENT_AT_LEAST_ONE_EVOLUTION_TO_PRINT_IN_DEX
	pop af
	pop hl

	push hl
	ld [wUniQuizAnswer], a
	call IncreaseHLCoordinatesBy1Row
	ld de, LevelText
	call PlaceString
	ld h, b
	ld l, c
	push hl
	ld de, wUniQuizAnswer
	ld a, [de]
	cp 100
	lb bc, 1, 2
	jr nz, .printLevel
	dec hl
	lb bc, 1, 3
.printLevel
	call PrintNumber
	pop hl
	call PrintColonRightAfterNumberAtDEStartingAtHL

	call SaveValueOfwd11e
	
	pop hl
	push hl
	ld a, [hl] ; a contains the learnable move
	ld [wd11e], a
	push bc
	call GetMoveName
	ld de, wcd6d
	pop bc
	ld h, b
	ld l, c
	call PlaceString
	
	call RestoreValueOfwd11e
	pop hl

	call IterationsCounter
	cp 14

	jr c, .popIncAndReloop
; we reached the end of the page, let's wait for a button press and then clear it and restart from top
; look ahead by 1 entry to see if there's really need to do so
	inc hl
	ld a, [hl]
	and a ; is the next entry 0 = the terminator?
	jr z, .popIncAndReloop

.waitForButtonPress
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	and A_BUTTON | B_BUTTON
	jr z, .waitForButtonPress

	call ClearScreenExceptBorders_OnlyBody
	call InitializeHLSpecialCoordinatesAndInterationsCounter

.popIncAndReloop
	pop hl
	inc hl
	inc hl
	jp .nextLevelUpEntry ; we have the address, load next entry to wBuffer

.concludeLevelUpLoop
	CheckAndResetEvent EVENT_AT_LEAST_ONE_EVOLUTION_TO_PRINT_IN_DEX
	jr nz, .popAndRet
	hlcoord 2, 4
	ld de, NoMovesLearnedText
	call PlaceString
.popAndRet
	pop hl
	ret

NoMovesLearnedText:
	db "NO MOVES LEARNED@"

LevelUpMovesText:
	db "'s LVLUPs@"

LevelText:
	db "LV @"

; ----------------------------------------------------------

TMHMsText:
	db "'s TM/HMs@"

; ----------------------------------------------------------

DrawPokedexBordersForInfoPages:
	call ClearScreen

	hlcoord 0, 0
	ld de, 1
	lb bc, $64, SCREEN_WIDTH
	call DrawTileLine ; draw top border

	hlcoord 0, 17
	ld b, $6f
	call DrawTileLine ; draw bottom border

	hlcoord 0, 1
	ld de, 20
	lb bc, $66, $10
	call DrawTileLine ; draw left border

	hlcoord 19, 1
	ld b, $67
	call DrawTileLine ; draw right border

	ld a, $63 ; upper left corner tile
	ldcoord_a 0, 0
	ld a, $65 ; upper right corner tile
	ldcoord_a 19, 0
	ld a, $6c ; lower left corner tile
	ldcoord_a 0, 17
	ld a, $6e ; lower right corner tile
	ldcoord_a 19, 17

	hlcoord 0, 2
	ld de, PokedexDataDividerLine
	jp PlaceString ; draw horizontal divider line

; ----------

ClearScreenExceptBorders:
; clear title
	hlcoord 1, 1
	lb bc, 1, 18
	call ClearScreenArea ; clear tilemap area cxb (swapped! yx, not xy) at hl
	; fallthrough
ClearScreenExceptBorders_OnlyBody:
; clear body
	hlcoord 1, 3
	lb bc, 14, 18
	jp ClearScreenArea
	ret

; ----------

IterationsCounter:
	ld a, [wMultipurposeTemporaryStorage2]
	inc a
	ld [wMultipurposeTemporaryStorage2], a
	ret

; ----------

InitializeHLSpecialCoordinatesAndInterationsCounter:
	hlcoord 1, 2
	ld a, h
	ld [wEphemerealTempBuffer2ByteStorage], a
	ld a, l
	ld [wEphemerealTempBuffer2ByteStorage+1], a

	xor a
	ld [wMultipurposeTemporaryStorage2], a

	ret

; ----------------------------------------------------------

PrintTMHMsMovesInfo:

;	call DrawPokedexBordersForInfoPages
	call ClearScreenExceptBorders

	call SaveValueOfwd11e ; save mon ID from wd11e into wMultipurposeTemporaryStorage (not to be confused with the TMHM ID one, see below)

	call GetMonName
	hlcoord 1, 1
	call PlaceString
	ld h, b
	ld l, c
	ld de, TMHMsMovesText
	call PlaceString

	call InitializeHLSpecialCoordinatesAndInterationsCounter
	dec a
	ld [wUniQuizAnswer+1], a ; it works only because the function above ends with a "xor a"; we use ld wUniQuizAnswer+1 to keep track of how many lines we printed

	ld a, TM01
	ld [wMultipurposeTemporaryStorage2], a ; let's use wMultipurposeTemporaryStorage2 to keep track of the item=TMHM ID that we need to loop over

.TMHMsLoop
	ld a, [wMultipurposeTemporaryStorage2]
	sub TM01 ; underflows below 0 for HM items (before TM items)
	jr nc, .skipAdding
	add NUM_TMS + NUM_HMS ; adjust HM IDs to come after TM IDs
.skipAdding
	inc a
	ld [wd11e], a
	predef TMToMove ; get move ID from TM/HM ID
	ld a, [wd11e] ; now wd11e contains the move ID

	ld [wMoveNum], a
	call RestoreValueOfwd11e ; a contains the pokemon ID
	ld [wcf91], a
	predef CanLearnTM ; tests if mon [wcf91] can learn move [wMoveNum]
	ld a, c
	and a ; can the pokemon learn the move?
	jr z, .cantLearnThisTMHM

; we can learn this move
	SetEvent EVENT_AT_LEAST_ONE_EVOLUTION_TO_PRINT_IN_DEX
	call PrintTMHMNumberAndName

.cantLearnThisTMHM ; check if we reached the end of the list of TMs/HMs
	call IterationsCounter ; increases wMultipurposeTemporaryStorage2, which tracks which TMHM ID we're working on, right now also in a
	cp TM01
	jr z, .concludeTMHMsLoop
	cp TM01 + NUM_TMS ; maybe +-1, TBE
	jr nc, .handleHMs
	jr .TMHMsLoop
.handleHMs
	ld a, HM01
	ld [wMultipurposeTemporaryStorage2], a
	jr .TMHMsLoop
.concludeTMHMsLoop
	CheckAndResetEvent EVENT_AT_LEAST_ONE_EVOLUTION_TO_PRINT_IN_DEX ; bastardized event, reused
	ret nz
	hlcoord 1, 4
	ld de, NoTMsHMsLearnedText
	jp PlaceString

NoTMsHMsLearnedText:
	db "NO TMs/HMs LEARNED@"

; ----------

TMHMsMovesText:
	db "'s TM/HMs@"

; ----------

PrintTMHMNumberAndName:
	ld a, [wUniQuizAnswer+1]
	inc a
	ld [wUniQuizAnswer+1], a
	cp 14
	jr nz, .noNewPage

.waitForButtonPress
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	and A_BUTTON | B_BUTTON
	jr z, .waitForButtonPress

	call ClearScreenExceptBorders_OnlyBody
	hlcoord 1, 2
	ld a, h
	ld [wEphemerealTempBuffer2ByteStorage], a
	ld a, l
	ld [wEphemerealTempBuffer2ByteStorage+1], a
	xor a
	ld [wUniQuizAnswer+1], a

.noNewPage
	call IncreaseHLCoordinatesBy1Row
	ld d, h
	ld e, l ; now we have decoord, needed for next function
	ld a, [wMoveNum]
	ld [wd11e], a
	callfar DisplayTMItemNameFromMoveName ; wd11e has move ID as input

	call PrintColon4PlacesRightOfLastSavedHLCoords

	ld a, [wMoveNum]
	ld [wd11e], a
	ld [wUniQuizAnswer], a ; TBE
	call GetMoveName ; pointer to name: wcd6d
	ld de, wcd6d
	call AdvanceHLCoordsBy6
	jp PlaceString

; ----------

AdvanceHLCoordsBy6:
	ld a, [wEphemerealTempBuffer2ByteStorage]
	ld h, a
	ld a, [wEphemerealTempBuffer2ByteStorage+1]
	ld l, a
	inc hl
	inc hl
	inc hl
	inc hl
	inc hl
	ret

; ----------

PrintColon4PlacesRightOfLastSavedHLCoords:
	ld a, [wEphemerealTempBuffer2ByteStorage]
	ld h, a
	ld a, [wEphemerealTempBuffer2ByteStorage+1]
	ld l, a
	inc hl
	inc hl
	inc hl
	inc hl
	ld de, ColonText
	jp PlaceString

; ----------------------------------------------------------

PrintBaseStatsInfo:

;	call DrawPokedexBordersForInfoPages
	call ClearScreenExceptBorders

	call RestoreValueOfwd11e ; save mon ID from wd11e into wMultipurposeTemporaryStorage
	ld a, [wd11e]
	ld [wd0b5], a
	call GetMonHeader

	call GetMonName
	hlcoord 1, 1
	call PlaceString
	ld h, b
	ld l, c
	ld de, BaseStatsText
	call PlaceString

; actual stats printing
	hlcoord 2, 4
	ld de, StatsNameText
	call PlaceString

	hlcoord 12, 4
	lb bc, 1, 3
	ld de, wMonHBaseHP
	call PrintStatDex
	ld de, wMonHBaseAttack
	call PrintStatDex
	ld de, wMonHBaseDefense
	call PrintStatDex
	ld de, wMonHBaseSpeed
	call PrintStatDex
	ld de, wMonHBaseSpecial
	call PrintStatDex

	ret

BaseStatsText:
	db "'s STATS@"

PrintStatDex:
	push hl
	call PrintNumber
	pop hl
	ld de, SCREEN_WIDTH * 2
	add hl, de
	ret

StatsNameText:
	db   "HP      : "
	next "ATTACK  : "
	next "DEFENSE : "
	next "SPEED   : "
	next "SPECIAL : @"
