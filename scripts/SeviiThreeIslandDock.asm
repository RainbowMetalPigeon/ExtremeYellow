SeviiThreeIslandDock_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, ActionsOnEntry3
	call EnableAutoTextBoxDrawing
	ld hl, SeviiThreeIslandDock_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

SeviiThreeIslandDock_ScriptPointers:
	dw SeviiThreeIslandDockScritp_NullScript
	dw SeviiThreeIslandDockScritp_FerryWarpScript

SeviiThreeIslandDockScritp_NullScript:
	ret

SeviiThreeIslandDockScritp_FerryWarpScript:
	jpfar WarpScriptToKanto

ActionsOnEntry3:
	ld a, SEVII_THREE_ISLAND_CITY
	ld [wLastBlackoutMap], a
	ret

SeviiThreeIslandDock_TextPointers:
	dw SeviiThreeIslandDockSpriteText1
	dw SeviiThreeIslandDockBgText1
	dw SeviiThreeIslandDockBgText2
	dw SeviiThreeIslandDockBgText3
	text_end

SeviiThreeIslandDockSpriteText1: ; TBE
	text_asm
	ld hl, SeviiThreeIslandDockSpriteText1_inner
	call PrintText
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd

SeviiThreeIslandDockSpriteText1_inner:
	text_far _SeviiIslandsDockSailorText1
	text_end

SeviiThreeIslandDockBgText1: ; TBE with hidden secret, add flags
	text_far _SeviiThreeIslandDockBgText1
	text_end

SeviiThreeIslandDockBgText2:
SeviiThreeIslandDockBgText3:
	text_far _SeviiIslandsDockTheresNothingText
	text_end
