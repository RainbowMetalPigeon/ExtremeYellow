; displays yes/no choice
; yes -> set carry
YesNoChoice::
	call SaveScreenTilesToBuffer1
	xor a ; YES_NO_MENU
	ld [wTwoOptionMenuID], a
	jpfar InitYesNoTextBoxParameters_Core

NoYesChoice:: ; new
	call SaveScreenTilesToBuffer1
	ld a, NO_YES_MENU
	ld [wTwoOptionMenuID], a
	jpfar InitYesNoTextBoxParameters_Core

YesNoChoicePokeCenter::
	jpfar _YesNoChoicePokeCenter
