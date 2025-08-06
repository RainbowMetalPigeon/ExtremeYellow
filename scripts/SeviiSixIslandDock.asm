SeviiSixIslandDock_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, ActionsOnEntry6
	call EnableAutoTextBoxDrawing
	ld hl, SeviiSixIslandDock_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

SeviiSixIslandDock_ScriptPointers:
	dw SeviiSixIslandDockScritp_NullScript
	dw SeviiSixIslandDockScritp_FerryWarpScript

SeviiSixIslandDockScritp_NullScript:
	ret

SeviiSixIslandDockScritp_FerryWarpScript:
	jpfar WarpScriptToKanto

ActionsOnEntry6:
	ld a, SEVII_SIX_ISLAND_CITY
	ld [wLastBlackoutMap], a
	ret

SeviiSixIslandDock_TextPointers:
	dw SeviiSixIslandDockSpriteText1
	dw SeviiSixIslandDockBgText1
	dw SeviiSixIslandDockBgText2
	dw SeviiSixIslandDockBgText3
	text_end

SeviiSixIslandDockSpriteText1: ; TBE
	text_asm
	ld hl, SeviiSixIslandDockSpriteText1_inner
	call PrintText
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd

SeviiSixIslandDockSpriteText1_inner:
	text_far _SeviiIslandsDockSailorText1
	text_end

SeviiSixIslandDockBgText1: ; TBE with hidden secret, add flags
	text_far _SeviiSixIslandDockBgText1
	text_end

SeviiSixIslandDockBgText2:
SeviiSixIslandDockBgText3:
	text_far _SeviiIslandsDockTheresNothingText
	text_end
