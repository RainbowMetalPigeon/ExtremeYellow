SeviiLostCave2_Script:
	call EnableAutoTextBoxDrawing
	ld de, SeviiLostCave2_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

SeviiLostCave2_ScriptPointers:
	dw SeviiLostCave2_Script0
	dw SeviiLostCave2_Script1

SeviiLostCave2_Script0:
	ret

SeviiLostCave2_Script1:
	call GBFadeOutToBlack
	SetEvent EVENT_RESCUED_SELPHY
	ld a, HS_SEVII_LOST_CAVE_2_SELPHY
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld a, HS_SEVII_RESORT_GORGEOUS_SELPHY
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
	xor a
	ld [wCurMapScript], a
	ret

SeviiLostCave2_TextPointers:
	dw SeviiLostCave2Text1
	text_end

SeviiLostCave2Text1:
	text_asm
	ld hl, SeviiLostCave2Text1_1
	call PrintText
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd

SeviiLostCave2Text1_1:
	text_far _SeviiLostCave2Text1
	text_end
