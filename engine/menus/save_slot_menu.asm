; new for multi save slots ===========
; save slot selection menu, shown between the title screen and the main menu
; output: carry set if B was pressed
;         carry clear if a slot was chosen (stored in wCurrentSaveSlot)

MainMenu_ChooseSaveSlot_:
	call ClearScreen
	call UpdateSprites
	call Delay3

	call LoadTextBoxTilePatterns
	call LoadFontTilePatterns

	hlcoord 2, 0
	ld de, ChooseSaveSlotText
	call PlaceString

	hlcoord 5, 1
	lb bc, 9, 8
	call TextBoxBorder

	hlcoord 7, 3
	ld de, SaveSlotMenuText
	call PlaceString

	xor a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a

.printBaseText
	ld hl, wd730
	set 6, [hl] ; print the short text instantly
	ld hl, SaveSlotStartInfoText
	call PrintText
	ld hl, wd730
	res 6, [hl]

; menu variables are re-set every time, since PrintText may alter them
	ld a, 3 ; Maximum number of items (-1)
	ld [wMaxMenuItem], a
	ld a, 3
	ld [wTopMenuItemY], a
	ld a, 6
	ld [wTopMenuItemX], a
	ld a, A_BUTTON | B_BUTTON | START
	ld [wMenuWatchedKeys], a

	call HandleMenuInput

	bit BIT_B_BUTTON, a
	jr nz, .pressedB
	bit BIT_START, a
	jr nz, .pressedStart

; pressed A
	ld a, [wCurrentMenuItem]
	ld [wCurrentSaveSlot], a
	and a ; clear carry
	ret

.pressedB
	scf
	ret

.pressedStart
	ld hl, SaveSlotDetailedInfoText
	call PrintText
	jr .printBaseText

; ----------------------

ChooseSaveSlotText:
	db "CHOOSE SAVE SLOT:@"

SaveSlotMenuText:
	db   "SLOT 1"
	next "SLOT 2"
	next "SLOT 3"
	next "SLOT 4@"

SaveSlotStartInfoText:
	text_far _SaveSlotStartInfoText
	text_end

SaveSlotDetailedInfoText:
	text_far _SaveSlotDetailedInfoText
	text_end
