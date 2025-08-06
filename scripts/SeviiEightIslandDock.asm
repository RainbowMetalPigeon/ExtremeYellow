SeviiEightIslandDock_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, ActionsOnEntry8
	call EnableAutoTextBoxDrawing
	ld hl, SeviiEightIslandDock_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

SeviiEightIslandDock_ScriptPointers:
	dw SeviiEightIslandDockScritp_NullScript
	dw SeviiEightIslandDockScritp_FerryWarpScript

SeviiEightIslandDockScritp_NullScript:
	ret

SeviiEightIslandDockScritp_FerryWarpScript:
	jpfar WarpScriptToKanto

ActionsOnEntry8:
	ld a, SEVII_EIGHT_ISLAND_CITY
	ld [wLastBlackoutMap], a
	ret

SeviiEightIslandDock_TextPointers:
	dw SeviiEightIslandDockSpriteText1
	dw SeviiEightIslandDockBgText1
	dw SeviiEightIslandDockBgText2
	dw SeviiEightIslandDockBgText3
	text_end

SeviiEightIslandDockSpriteText1: ; TBE
	text_asm
	ld hl, SeviiEightIslandDockSpriteText1_inner
	call PrintText
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd

SeviiEightIslandDockSpriteText1_inner:
	text_far _SeviiIslandsDockSailorText1
	text_end

SeviiEightIslandDockBgText1: ; TBE with hidden secret, add flags
	text_far _SeviiEightIslandDockBgText1
	text_end

SeviiEightIslandDockBgText2:
SeviiEightIslandDockBgText3:
	text_far _SeviiIslandsDockTheresNothingText
	text_end
