DiglettsCave_Script: ; edited
	ld hl, wCurrentMapScriptFlags
	bit 6, [hl]
	res 6, [hl]
	call nz, DiglettCaveHandleEncounters
	call EnableAutoTextBoxDrawing
	ret

DiglettCaveHandleEncounters: ; new
	CheckEvent EVENT_BEAT_LT_SURGE
	jr nz, .postSurge
	ld hl, wd72e
	set 4, [hl]
	ret
.postSurge
	ld hl, wd72e
	res 4, [hl]
	ret

DiglettsCave_TextPointers:

	text_end ; unused
