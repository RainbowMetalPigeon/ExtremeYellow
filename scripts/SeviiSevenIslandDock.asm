SeviiSevenIslandDock_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, ActionsOnEntry7
	call EnableAutoTextBoxDrawing
	ld hl, SeviiSevenIslandDock_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

SeviiSevenIslandDock_ScriptPointers:
	dw SeviiSevenIslandDockScritp_NullScript
	dw SeviiSevenIslandDockScritp_FerryWarpScript

SeviiSevenIslandDockScritp_NullScript:
	ret

SeviiSevenIslandDockScritp_FerryWarpScript:
	jpfar WarpScriptToKanto

ActionsOnEntry7:
	ld a, SEVII_SEVEN_ISLAND_CITY
	ld [wLastBlackoutMap], a
	ret

SeviiSevenIslandDock_TextPointers:
	dw SeviiSevenIslandDockSpriteText1
	dw SeviiSevenIslandDockBgText1
	dw SeviiSevenIslandDockBgText2
	dw SeviiSevenIslandDockBgText3
	text_end

SeviiSevenIslandDockSpriteText1: ; TBE
	text_asm
	ld hl, SeviiSevenIslandDockSpriteText1_inner
	call PrintText
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd

SeviiSevenIslandDockSpriteText1_inner:
	text_far _SeviiIslandsDockSailorText1
	text_end

SeviiSevenIslandDockBgText1: ; TBE with hidden secret, add flags
	text_far _SeviiSevenIslandDockBgText1
	text_end

SeviiSevenIslandDockBgText2:
SeviiSevenIslandDockBgText3:
	text_far _SeviiIslandsDockTheresNothingText
	text_end
