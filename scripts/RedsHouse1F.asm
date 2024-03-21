RedsHouse1F_Script:
	call EnableAutoTextBoxDrawing
	ret

RedsHouse1F_TextPointers:
	dw RedsHouse1FMomText
	dw RedsHouse1FTVText
	dw RedsHouse1FPictureText ; new

RedsHouse1FMomText:
	text_asm
	callfar Func_f1b73
	jp TextScriptEnd

RedsHouse1FTVText:
	text_asm
	callfar Func_f1bc4
	jp TextScriptEnd

RedsHouse1FPictureText: ; new
	text_far _RedsHouse1FPictureText
	text_end
