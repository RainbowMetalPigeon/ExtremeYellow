HauntedHouse4_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, HauntedHouse4HandleRandomGlitchyBehaviours
	call EnableAutoTextBoxDrawing
;	ld hl, HauntedHouse4_ScriptPointers
;	ld a, [wHauntedHouse4CurScript]
;	call CallFunctionInTable
	ret

HauntedHouse4HandleRandomGlitchyBehaviours:
	callfar HauntedHouseHandleRandomGlitchyBehaviours ; testing
	ret

;HauntedHouse4_ScriptPointers:
;	dw HauntedHouse4Script0

;HauntedHouse4Script0:
;	ret

; ============================

HauntedHouse4_TextPointers:
;	dw HauntedHouse4Text1

	text_end

; ============================
