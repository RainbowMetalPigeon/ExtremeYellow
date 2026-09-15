SeviiLostCave2_Script:
	RPTextChooser SeviiLostCave2_TextPointers, SeviiLostCave2_TextPointers_Rocket
	call EnableAutoTextBoxDrawing
	ld de, SeviiLostCave2_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

SeviiLostCave2_ScriptPointers:
	dw SeviiLostCave2_Script0
	dw SeviiLostCave2_Script1
	; for RP
	dw SeviiLostCave2_Script2

SeviiLostCave2_Script0:
	ret

SeviiLostCave2_Script1:
	SetEvent EVENT_RESCUED_SELPHY
	ld a, HS_SEVII_LOST_CAVE_2_SELPHY
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld a, HS_SEVII_RESORT_GORGEOUS_SELPHY
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
; set scripts warp
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, SPRITE_FACING_UP
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, SEVII_RESORT_GORGEOUS
	ldh [hWarpDestinationMap], a
	ld a, 0 ; -1 wrt the normal numbering
	ld [wDestinationWarpID], a
	ld a, SEVII_ROUTE_35
	ld [wLastMap], a
	ld hl, wd72d
	set 3, [hl] ; do scripted warp
; finish up
	xor a
	ld [wCurMapScript], a
	ret

SeviiLostCave2_TextPointers:
	dw SeviiLostCave2Text1

SeviiLostCave2_TextPointers_Rocket:
	dw SeviiLostCave2Text1_RP
	; scripts
	dw SeviiLostCave2Text1_RP_AfterWaterfall

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

; new for RP ===============================

SeviiLostCave2Text1_RP:
	text_asm
	ld hl, SeviiLostCave2Text1_RP_BeforeWaterfall
	call PrintText
	lb bc, HM_WATERFALL, 1
	call GiveItem
	jr c, .bagNotFull
	ld hl, SeviiLostCave2Text1_RP_BagFull
	call PrintText
	jp TextScriptEnd
.bagNotFull
	SetEvent EVENT_GOT_WATERFALL_FROM_SELPHY ; unnecessary?
	ld hl, SeviiLostCave2Text1_RP_GotWaterfall
	call PrintText
	ld a, 2
	ld [wCurMapScript], a
	jp TextScriptEnd

SeviiLostCave2Text1_RP_BeforeWaterfall:
	text_far _SeviiLostCave2Text1_RP_BeforeWaterfall
	text_end

SeviiLostCave2Text1_RP_BagFull:
	text_far _SeviiLostCave2Text1_RP_BagFull
	text_end

SeviiLostCave2Text1_RP_GotWaterfall:
	text_far _SeviiResortGorgeousText1_GotWaterfall
	sound_get_key_item
	text_end

SeviiLostCave2Text1_RP_AfterWaterfall:
	text_far _SeviiLostCave2Text1_RP_AfterWaterfall
	text_end

SeviiLostCave2_Script2:
	ld a, 2
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; set scripts warp
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, SPRITE_FACING_DOWN
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, SEVII_ROUTE_35
	ldh [hWarpDestinationMap], a
	ld a, 1 ; -1 wrt the normal numbering
	ld [wDestinationWarpID], a
	ld a, SEVII_ROUTE_35
	ld [wLastMap], a
	ld hl, wd72d
	set 3, [hl] ; do scripted warp
; finish up
	xor a
	ld [wCurMapScript], a
	ret
