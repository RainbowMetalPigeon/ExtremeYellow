; function that displays the start menu
DrawStartMenu::
	CheckEvent EVENT_GOT_POKEDEX
; menu with pokedex + portablePC
	hlcoord 10, 0
	lb bc, 16, 8 ; edited for portablePC
	jr nz, .drawTextBoxBorder
; shorter menu if the player doesn't have the pokedex + portablePC
	hlcoord 10, 0
	lb bc, 12, 8
.drawTextBoxBorder
	call TextBoxBorder
	ld a, D_DOWN | D_UP | START | B_BUTTON | A_BUTTON
	ld [wMenuWatchedKeys], a
	ld a, $02
	ld [wTopMenuItemY], a ; Y position of first menu choice
	ld a, $0b
	ld [wTopMenuItemX], a ; X position of first menu choice
	ld a, [wBattleAndStartSavedMenuItem] ; remembered menu selection from last time
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
	xor a
	ld [wMenuWatchMovingOutOfBounds], a
	ld hl, wd730
	set 6, [hl] ; no pauses between printing each letter
	hlcoord 12, 2
	CheckEvent EVENT_GOT_POKEDEX
; case for not having pokedex + portablePC
	ld a, $06
	jr z, .storeMenuItemCount
; case for having pokedex + portablePC
	ld de, StartMenuPokedexText
	call PrintStartMenuItem
	ld a, $08 ; edited for portablePC, TBC
.storeMenuItemCount
	ld [wMaxMenuItem], a ; number of menu items
	ld de, StartMenuPokemonText
	call PrintStartMenuItem
	ld de, StartMenuItemText
	call PrintStartMenuItem
	ld de, wPlayerName ; player's name
	call PrintStartMenuItem
	ld a, [wd72e]
	bit 6, a ; is the player using the link feature?
; case for not using link feature
	ld de, StartMenuSaveText
	jr z, .printSaveOrResetText
; case for using link feature
	ld de, StartMenuResetText
.printSaveOrResetText
	call PrintStartMenuItem
	ld de, StartMenuOptionText
	call PrintStartMenuItem
	CheckEvent EVENT_GOT_POKEDEX ; new, for portablePC
	jr z, .dontPrintPortablePC ; new, for portablePC
	ld de, StartMenuPortablePCText ; new, for portablePC
	call PrintStartMenuItem ; new, for portablePC
.dontPrintPortablePC ; new, for portablePC
	ld de, StartMenuExitText
	call PlaceString
	ld hl, wd730
	res 6, [hl] ; turn pauses between printing letters back on
	ret

StartMenuPokedexText:
	db "POKéDEX@"

StartMenuPokemonText:
	db "#MON@"

StartMenuItemText:
	db "ITEM@"

StartMenuSaveText:
	db "SAVE@"

StartMenuResetText:
	db "RESET@"

StartMenuExitText:
	db "EXIT@"

StartMenuOptionText:
	db "OPTION@"

StartMenuPortablePCText: ; new
	db "PORT.PC@"

PrintStartMenuItem:
	push hl
	call PlaceString
	pop hl
	ld de, SCREEN_WIDTH * 2
	add hl, de
	ret
