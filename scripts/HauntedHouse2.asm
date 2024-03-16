HauntedHouse2_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, HauntedHouse2HandleRandomGlitchyBehaviours
	call EnableAutoTextBoxDrawing
;	ld hl, HauntedHouse2_ScriptPointers
;	ld a, [wHauntedHouse2CurScript]
;	call CallFunctionInTable
	ret

HauntedHouse2HandleRandomGlitchyBehaviours:
	callfar HauntedHouseHandleRandomGlitchyBehaviours ; testing
	ret

;HauntedHouse2_ScriptPointers:
;	dw HauntedHouse2Script0

;HauntedHouse2Script0:
;	ret

; ============================

HauntedHouse2_TextPointers:
;	dw HauntedHouse2Text1

	text_end

; ============================
