SeviiFiveIslandDock_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, ActionsOnEntry5
	call EnableAutoTextBoxDrawing
	ld hl, SeviiFiveIslandDock_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

SeviiFiveIslandDock_ScriptPointers:
	dw SeviiFiveIslandDockScritp_NullScript
	dw SeviiFiveIslandDockScritp_FerryWarpScript

SeviiFiveIslandDockScritp_NullScript:
	ret

SeviiFiveIslandDockScritp_FerryWarpScript:
	jpfar WarpScriptToKanto

ActionsOnEntry5:
	ld a, SEVII_FIVE_ISLAND_CITY
	ld [wLastBlackoutMap], a
	ret

SeviiFiveIslandDock_TextPointers:
	dw SeviiFiveIslandDockSpriteText1
	dw SeviiFiveIslandDockBgText1
	dw SeviiFiveIslandDockBgText2
	dw SeviiFiveIslandDockBgText3
	text_end

SeviiFiveIslandDockSpriteText1: ; TBE
	text_asm
	ld hl, SeviiFiveIslandDockSpriteText1_inner
	call PrintText
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd

SeviiFiveIslandDockSpriteText1_inner:
	text_far _SeviiIslandsDockSailorText1
	text_end

SeviiFiveIslandDockBgText1: ; TBE with hidden secret, add flags
	text_far _SeviiFiveIslandDockBgText1
	text_end

SeviiFiveIslandDockBgText2:
SeviiFiveIslandDockBgText3:
	text_far _SeviiIslandsDockTheresNothingText
	text_end
