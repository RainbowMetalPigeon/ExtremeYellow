HauntedRedsHouse_Script:
;	ld hl, wCurrentMapScriptFlags
;	bit 5, [hl]
;	res 5, [hl]
;	call nz, HauntedRedsHouseHandleRandomGlitchyBehaviours
	call EnableAutoTextBoxDrawing
	ld hl, HauntedRedsHouse_ScriptPointers
	ld a, [wHauntedRedsHouseCurScript]
	call CallFunctionInTable
	ret

; =================================

HauntedRedsHouse_ScriptPointers:
	dw HauntedRedsHouseScript0

HauntedRedsHouseScript0:
	ret

; =================================

HauntedRedsHouse_TextPointers:
	dw HauntedRedsHouseMomText
	dw HauntedRedsHouseTVText
	dw HauntedRedsHouseConsoleText
	dw HauntedRedsHousePCText

HauntedRedsHouseMomText:
	text_far _HauntedRedsHouseMomText
	text_end

HauntedRedsHouseTVText:
	text_asm
	ld hl, HauntedTVWrongSideText
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_UP
	jp nz, .got_text
	ld hl, HauntedTVRightSideText
.got_text
	call PrintText
	jp TextScriptEnd

HauntedTVRightSideText:
	text_far _HauntedTVRightSideText
	text_end

HauntedTVWrongSideText:
	text_far _HauntedTVWrongSideText
	text_end

HauntedRedsHouseConsoleText:
	text_far _HauntedRedsHouseConsoleText
	text_end

HauntedRedsHousePCText:
	text_far _HauntedRedsHousePCText
	text_end

HauntedRedsHouseBookshelvesText:
	text_far _HauntedRedsHouseBookshelvesText
	text_end
	