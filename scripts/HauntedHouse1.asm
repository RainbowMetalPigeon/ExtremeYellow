HauntedHouse1_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, HauntedHouse1HandleRandomGlitchyBehaviours
	call EnableAutoTextBoxDrawing
;	ld hl, HauntedHouse1_ScriptPointers
;	ld a, [wHauntedHouse1CurScript]
;	call CallFunctionInTable
	ret

HauntedHouse1HandleRandomGlitchyBehaviours:
	callfar HauntedHouseHandleRandomGlitchyBehaviours ; testing
	ret ; testing

;HauntedHouse1_ScriptPointers:
;	dw HauntedHouse1Script0

;HauntedHouse1Script0:
;	ret

; ============================

HauntedHouse1_TextPointers:
;	dw HauntedHouse1Text1

	text_end

; ============================
