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

	hlcoord 2, 1
	ld de, ChooseSaveSlotText
	call PlaceString

	hlcoord 5, 2
	lb bc, 9, 8
	call TextBoxBorder

	hlcoord 7, 4
	ld de, SaveSlotMenuText
	call PlaceString

	xor a
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a

.printBaseText
	ld hl, wd730
	set 6, [hl] ; print the short text instantly
	ld hl, SaveSlotStartInfoText
	call PrintTextLessTallBox
	ld hl, wd730
	res 6, [hl]

; menu variables are re-set every time, since PrintText may alter them
	ld a, 3 ; Maximum number of items (-1)
	ld [wMaxMenuItem], a
	ld a, 4
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
	call PrintTextLessTallBox
	jr .printBaseText

; ----------------------

; like PrintText, but the text box is one tile less tall (top border on row 13
; instead of 12), leaving row 12 free for the slot box's bottom border
; input: hl = text to print
PrintTextLessTallBox:
	push hl
	hlcoord 0, 13
	lb bc, 3, 18
	call TextBoxBorder
	call UpdateSprites
	call Delay3
	ld hl, hUILayoutFlags
	set BIT_LESS_TALL_TEXT_BOX, [hl]
	pop hl
	call PrintText_NoCreatingTextBox
	ld hl, hUILayoutFlags
	res BIT_LESS_TALL_TEXT_BOX, [hl]
	ret

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
