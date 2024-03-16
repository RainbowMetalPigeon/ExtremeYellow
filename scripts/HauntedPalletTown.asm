HauntedPalletTown_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, HauntedPalletTownStopMusic
	call EnableAutoTextBoxDrawing
	ld hl, HauntedPalletTown_ScriptPointers
	ld a, [wHauntedPalletTownCurScript]
	call CallFunctionInTable
	ret

; =================================

HauntedPalletTownStopMusic:
	call StopAllMusic ; glitchy, it breaks the "bump" sounds too
; à la Vortiene
;	ld a, 1
;	ld [wMuteAudioAndPauseMusic], a
	ret

HauntedPalletTown_ScriptPointers:
	dw HauntedPalletTownScript0

HauntedPalletTownScript0:
	ret

; =================================

HauntedPalletTown_TextPointers:
	
	text_end
