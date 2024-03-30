HauntedIslandOfNumbers_Script:
	call EnableAutoTextBoxDrawing
;	ld hl, HauntedIslandOfNumbers_ScriptPointers
;	ld a, [wHauntedIslandOfNumbersCurScript]
;	call CallFunctionInTable
	ret

;HauntedIslandOfNumbers_ScriptPointers:
;	dw HauntedIslandOfNumbersScript0

;HauntedIslandOfNumbersScript0:
;	ret

; ============================

HauntedIslandOfNumbers_TextPointers:
;	dw HauntedIslandOfNumbersText1

	text_end

; ============================
