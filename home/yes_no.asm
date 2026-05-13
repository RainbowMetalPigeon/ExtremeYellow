; displays yes/no choice
; yes -> set carry
YesNoChoice::
	call SaveScreenTilesToBuffer1
	call InitYesNoTextBoxParameters
	jr DisplayYesNoChoice

NoYesChoice:: ; new
	call SaveScreenTilesToBuffer1
	call InitNoYesTextBoxParameters
	jr DisplayYesNoChoice

;TwoOptionMenu:: ; unreferenced
;	ld a, TWO_OPTION_MENU
;	ld [wTextBoxID], a
;	call InitYesNoTextBoxParameters
;	jp DisplayTextBoxID

InitNoYesTextBoxParameters:: ; new
	ld a, NO_YES_MENU
	jr InitYesNoTextBoxParameters_Core

InitYesNoTextBoxParameters::
	xor a ; YES_NO_MENU
InitYesNoTextBoxParameters_Core: ; new
	ld [wTwoOptionMenuID], a
	hlcoord 14, 7
	lb bc, 8, 15
	ret

YesNoChoicePokeCenter::
	call SaveScreenTilesToBuffer1
	ld a, HEAL_CANCEL_MENU
	ld [wTwoOptionMenuID], a
	hlcoord 11, 6
	lb bc, 8, 12
	jr DisplayYesNoChoice

;WideYesNoChoice:: ; unused
;	call SaveScreenTilesToBuffer1
;	ld a, WIDE_YES_NO_MENU
;	ld [wTwoOptionMenuID], a
;	hlcoord 12, 7
;	lb bc, 8, 13

DisplayYesNoChoice::
	ld a, TWO_OPTION_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID
	jp LoadScreenTilesFromBuffer1
