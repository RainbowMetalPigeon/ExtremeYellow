DiglettsCaveRoute11_Script:
	call EnableAutoTextBoxDrawing
	ld a, ROUTE_11
	ld [wLastMap], a
	; new, fix Diglett Cave conditional encounters (only after defeating Surge)
	ld hl, wd72e
	res 4, [hl]
	ret

DiglettsCaveRoute11_TextPointers:
	dw DiglettsCaveEntranceRoute11Text1

DiglettsCaveEntranceRoute11Text1: ; edited
	text_asm
	ld hl, DiglettsCaveEntRoute11Text1_BeforeSurge
	CheckEvent EVENT_BEAT_LT_SURGE
	jr z, .printAndEnd
	ld hl, DiglettsCaveEntRoute11Text1_AfterSurge
.printAndEnd
	call PrintText
	jp TextScriptEnd

DiglettsCaveEntRoute11Text1_BeforeSurge: ; new
	text_far _DiglettsCaveEntRoute11Text1_BeforeSurge
	text_end

DiglettsCaveEntRoute11Text1_AfterSurge: ; new
	text_far _DiglettsCaveEntRoute11Text1_AfterSurge
	text_end
