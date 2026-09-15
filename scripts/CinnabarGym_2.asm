CinnabarGymScript_PrintPreQuizTexts:
	callfar Func_PrintPreQuizTexts
	jp TextScriptEnd

CinnabarGymScript_753e9:
	push hl
	ld hl, wd475
	bit 7, [hl]
	res 7, [hl]
	pop hl
	ret

CinnabarGymScript_CheckBit7Ofwd475: ; edited
	push hl
	ld hl, wd475
	bit 7, [hl]
	pop hl
	ret
