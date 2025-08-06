SeviiTwoIslandDock_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, ActionsOnEntry2
	call EnableAutoTextBoxDrawing
	ld hl, SeviiTwoIslandDock_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

SeviiTwoIslandDock_ScriptPointers:
	dw SeviiTwoIslandDockScritp_NullScript
	dw SeviiTwoIslandDockScritp_FerryWarpScript

SeviiTwoIslandDockScritp_NullScript:
	ret

SeviiTwoIslandDockScritp_FerryWarpScript:
	jpfar WarpScriptToKanto

ActionsOnEntry2:
	ld a, SEVII_TWO_ISLAND_CITY
	ld [wLastBlackoutMap], a
	ret

SeviiTwoIslandDock_TextPointers:
	dw SeviiTwoIslandDockSpriteText1
	dw SeviiTwoIslandDockBgText1
	dw SeviiTwoIslandDockBgText2
	dw SeviiTwoIslandDockBgText3
	text_end

SeviiTwoIslandDockSpriteText1: ; TBE
	text_asm
	ld hl, SeviiTwoIslandDockSpriteText1_inner
	call PrintText
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd

SeviiTwoIslandDockSpriteText1_inner:
	text_far _SeviiIslandsDockSailorText1
	text_end

SeviiTwoIslandDockBgText1: ; TBE with hidden secret, add flags
	text_far _SeviiTwoIslandDockBgText1
	text_end

SeviiTwoIslandDockBgText2:
SeviiTwoIslandDockBgText3:
	text_far _SeviiIslandsDockTheresNothingText
	text_end
