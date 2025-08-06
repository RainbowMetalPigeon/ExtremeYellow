SeviiOneIslandDock_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, ActionsOnEntry1
	call EnableAutoTextBoxDrawing
	ld hl, SeviiOneIslandDock_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

SeviiOneIslandDock_ScriptPointers:
	dw SeviiOneIslandDockScritp_NullScript
	dw SeviiOneIslandDockScritp_FerryWarpScript

SeviiOneIslandDockScritp_NullScript:
	ret

SeviiOneIslandDockScritp_FerryWarpScript:
	jpfar WarpScriptToKanto

ActionsOnEntry1:
	SetEvent EVENT_UNLOCKED_SEVII
	ld a, SEVII_ONE_ISLAND_CITY
	ld [wLastBlackoutMap], a
	IF DEF(_DEBUG)
		ld hl, wd732
		set 1, [hl]
	ENDC
	ret
	
SeviiOneIslandDock_TextPointers:
	dw SeviiOneIslandDockSpriteText1
	dw SeviiOneIslandDockBgText1
	dw SeviiOneIslandDockBgText2
	dw SeviiOneIslandDockBgText3
	text_end

SeviiOneIslandDockSpriteText1: ; testing
	text_asm
	ld hl, SeviiOneIslandDockSpriteText1_inner
	call PrintText
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd

SeviiOneIslandDockSpriteText1_inner: ; testing
	text_far _SeviiIslandsDockSailorText1
	text_end

SeviiOneIslandDockBgText1: ; TBE
	text_far _SeviiOneIslandDockBgText1
	text_end

SeviiOneIslandDockBgText2:
SeviiOneIslandDockBgText3:
	text_far _SeviiIslandsDockTheresNothingText
	text_end
