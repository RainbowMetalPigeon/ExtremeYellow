ViridianSchoolHouse_Script:
	call EnableAutoTextBoxDrawing
	ret

ViridianSchoolHouse_TextPointers:
	dw SchoolText1
	dw SchoolText2
	dw SchoolText3
	dw SchoolText4 ; new
	dw SchoolText5 ; new
	dw SchoolText6 ; new
	dw SchoolText7 ; new
	dw SchoolText8 ; new
	dw SchoolText9 ; new

SchoolText1:
	text_far _SchoolText1
	text_end

SchoolText2:
	text_asm
	farcall Func_f1c0f
	jp TextScriptEnd

SchoolText3:
	text_asm
	farcall Func_f1c03
	jp TextScriptEnd

; new ----------------------

SchoolText4:
	text_far _SchoolText4
	text_end

SchoolText5:
	text_far _SchoolText5
	text_end

SchoolText6:
	text_far _SchoolText6
	text_end

SchoolText7:
	text_far _SchoolText7
	text_end

SchoolText8:
	text_far _SchoolText8
	text_end

SchoolText9:
	text_far _SchoolText9
	text_end
