HauntedHouse3_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, HauntedHouse3HandleRandomGlitchyBehaviours
	call EnableAutoTextBoxDrawing
;	ld hl, HauntedHouse3_ScriptPointers
;	ld a, [wHauntedHouse3CurScript]
;	call CallFunctionInTable
	ret

HauntedHouse3HandleRandomGlitchyBehaviours:
	callfar HauntedHouseHandleRandomGlitchyBehaviours ; testing
	ret

;HauntedHouse3_ScriptPointers:
;	dw HauntedHouse3Script0

;HauntedHouse3Script0:
;	ret

; ============================

HauntedHouse3_TextPointers:
;	dw HauntedHouse3Text1

	text_end

; ============================
