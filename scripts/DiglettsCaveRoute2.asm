DiglettsCaveRoute2_Script:
	ld a, ROUTE_2
	ld [wLastMap], a
	; new, fix Diglett Cave conditional encounters (only after defeating Surge)
	ld hl, wd72e
	res 4, [hl]
	jp EnableAutoTextBoxDrawing

DiglettsCaveRoute2_TextPointers:
	dw DiglettsCaveRoute2Text1

DiglettsCaveRoute2Text1:
	text_far _DiglettsCaveRoute2Text1
	text_end
