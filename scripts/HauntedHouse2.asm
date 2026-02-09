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
	dw HauntedHouse2TextSignR1C1
	dw HauntedHouse2TextSignR1C2
	dw HauntedHouse2TextSignR1C3
	dw HauntedHouse2TextSignR2C1
	dw HauntedHouse2TextSignR2C2
	dw HauntedHouse2TextSignR2C3
	dw HauntedHouse2TextSignR3C1
	dw HauntedHouse2TextSignR3C2
	dw HauntedHouse2TextSignR3C3
	dw HauntedHouse2TextSignR4C1
	dw HauntedHouse2TextSignR4C2
	dw HauntedHouse2TextSignR4C3

HauntedHouse2TextSignR1C1:
	text_far _HauntedHouse2TextSignR1C1
	text_end

HauntedHouse2TextSignR1C2:
	text_far _HauntedHouse2TextSignR1C2
	text_end

HauntedHouse2TextSignR1C3:
	text_far _HauntedHouse2TextSignR1C3
	text_end

HauntedHouse2TextSignR2C1:
	text_far _HauntedHouse2TextSignR2C1
	text_end

HauntedHouse2TextSignR2C2:
	text_far _HauntedHouse2TextSignR2C2
	text_end

HauntedHouse2TextSignR2C3:
	text_far _HauntedHouse2TextSignR2C3
	text_end

HauntedHouse2TextSignR3C1:
	text_far _HauntedHouse2TextSignR3C1
	text_end

HauntedHouse2TextSignR3C2:
	text_far _HauntedHouse2TextSignR3C2
	text_end

HauntedHouse2TextSignR3C3:
	text_far _HauntedHouse2TextSignR3C3
	text_end

HauntedHouse2TextSignR4C1:
	text_far _HauntedHouse2TextSignR4C1
	text_end

HauntedHouse2TextSignR4C2:
	text_far _HauntedHouse2TextSignR4C2
	text_end

HauntedHouse2TextSignR4C3:
	text_far _HauntedHouse2TextSignR4C3
	text_end

; ============================
