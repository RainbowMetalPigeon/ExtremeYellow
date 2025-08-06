SeviiFourIslandDock_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, ActionsOnEntry4
	call EnableAutoTextBoxDrawing
	ld hl, SeviiFourIslandDock_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

SeviiFourIslandDock_ScriptPointers:
	dw SeviiFourIslandDockScritp_NullScript
	dw SeviiFourIslandDockScritp_FerryWarpScript

SeviiFourIslandDockScritp_NullScript:
	ret

SeviiFourIslandDockScritp_FerryWarpScript:
	jpfar WarpScriptToKanto

ActionsOnEntry4:
	ld a, SEVII_FOUR_ISLAND_CITY
	ld [wLastBlackoutMap], a
	ret

SeviiFourIslandDock_TextPointers:
	dw SeviiFourIslandDockSpriteText1
	dw SeviiFourIslandDockBgText1
	dw SeviiFourIslandDockBgText2
	dw SeviiFourIslandDockBgText3
	text_end

SeviiFourIslandDockSpriteText1: ; TBE
	text_asm
	ld hl, SeviiFourIslandDockSpriteText1_inner
	call PrintText
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd

SeviiFourIslandDockSpriteText1_inner:
	text_far _SeviiIslandsDockSailorText1
	text_end

SeviiFourIslandDockBgText1: ; TBE with hidden secret, add flags
	text_far _SeviiFourIslandDockBgText1
	text_end

SeviiFourIslandDockBgText2:
SeviiFourIslandDockBgText3:
	text_far _SeviiIslandsDockTheresNothingText
	text_end
