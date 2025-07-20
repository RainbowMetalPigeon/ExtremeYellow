SeviiOneIslandDock_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, ActionsOnEntry
	call EnableAutoTextBoxDrawing
	ld hl, SeviiOneIslandDock_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

SeviiOneIslandDock_ScriptPointers: ; testing
	dw NullScript
	dw WarpScriptToKanto

ActionsOnEntry:
	ld a, SEVII_ONE_ISLAND_CITY
	ld [wLastBlackoutMap], a
	IF DEF(_DEBUG)
		ld hl, wd732
		set 1, [hl]
	ENDC
	ret
	
SeviiOneIslandDock_TextPointers:
	dw SeviiOneIslandDockText1
;	dw PickUpItemText
;	dw PickUpItemText
;	dw PickUpItemText
	text_end

;SeviiOneIslandDockText3:
;	text_far _SeviiOneIslandDockText3
;	text_end

SeviiOneIslandDockText1: ; testing
	text_asm
	ld hl, SeviiOneIslandDockText1_test
	call PrintText
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd

SeviiOneIslandDockText1_test: ; testing
	text_far _PalletTownText2
	text_end

NullScript: ; testing
	ret

WarpScriptToKanto: ; testing
	ld a, VERMILION_DOCK
	ld [wd72d], a
	ld c, 20
	call DelayFrames
	ld hl, wd732
	res 1, [hl]
	ld a, [wDefaultMap]
	ld [wDestinationMap], a
	ld a, VERMILION_CITY
	ld [wLastMap], a
	call GBFadeOutToBlack
;	ld a, SPRITE_FACING_UP
;	ld [wSpritePlayerStateData1FacingDirection], a
	callfar SpecialWarpIn
	ld c, 20
	call DelayFrames
	ResetEvent EVENT_IN_SEVII
;	ld a, 0
;	ld [wCurMapScript], a
	jpfar SpecialEnterMap