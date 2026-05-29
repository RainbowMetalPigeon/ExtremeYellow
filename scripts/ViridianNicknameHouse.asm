ViridianNicknameHouse_Script: ; edited
	ld a, TRUE
	ld [wAutoTextBoxDrawingControl], a
	dec a
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	call EnableAutoTextBoxDrawing
	ret

ViridianNicknameHouse_TextPointers:
	dw ViridianHouseText1
	dw ViridianHouseText2
	dw ViridianHouseText3
	dw ViridianHouseText4
	; new, relocated Badge Expert
	dw ViridianHouseText5
	; new, gate
	dw ViridianHouseText6
	dw ViridianHouseText7
	; signs
	dw ViridianHouseTextSign1

ViridianHouseText1:
	text_far _ViridianHouseText1
	text_end

ViridianHouseText2:
	text_far _ViridianHouseText2
	text_end

ViridianHouseText3:
	text_asm
	ld hl, ViridianHouseText_1d5b1
	call PrintText
	ld a, SPEAROW
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

ViridianHouseText_1d5b1:
	text_far _ViridianHouseText_1d5b1
	text_end

ViridianHouseText4:
	text_far _ViridianHouseText4
	text_end

ViridianHouseText5: ; just a copy-and-paste from Cerulean Badge expert
	text_asm
	ld hl, CeruleanHouse2Text_74e77
	call PrintText
	xor a
	ld [wCurrentMenuItem], a
	ld [wListScrollOffset], a
.asm_74e23
	ld hl, CeruleanHouse2Text_74e7c
	call PrintText
	ld hl, BadgeItemList
	call LoadItemList
	ld hl, wItemList
	ld a, l
	ld [wListPointer], a
	ld a, h
	ld [wListPointer + 1], a
	xor a
	ld [wPrintItemPrices], a
	ld [wMenuItemToSwap], a
	ld a, SPECIALLISTMENU
	ld [wListMenuID], a
	call DisplayListMenuID
	jr c, .asm_74e60
	ld hl, TextPointers_74e86
	ld a, [wcf91]
	sub BOULDERBADGE
	add a
	ld d, $0
	ld e, a
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
	jr .asm_74e23
.asm_74e60
	xor a
	ld [wListScrollOffset], a
	ld hl, CeruleanHouse2Text_74e81
	call PrintText
	jp TextScriptEnd

BadgeItemList:
	db 8 ; #
	db BOULDERBADGE
	db CASCADEBADGE
	db THUNDERBADGE
	db RAINBOWBADGE
	db SOULBADGE
	db MARSHBADGE
	db VOLCANOBADGE
	db EARTHBADGE
	db -1 ; end

CeruleanHouse2Text_74e77:
	text_far _CeruleanHouse2Text_74e77
	text_end

CeruleanHouse2Text_74e7c:
	text_far _CeruleanHouse2Text_74e7c
	text_end

CeruleanHouse2Text_74e81:
	text_far _CeruleanHouse2Text_74e81
	text_end

TextPointers_74e86:
	dw CeruleanHouse2Text_74e96
	dw CeruleanHouse2Text_74e9b
	dw CeruleanHouse2Text_74ea0
	dw CeruleanHouse2Text_74ea5
	dw CeruleanHouse2Text_74eaa
	dw CeruleanHouse2Text_74eaf
	dw CeruleanHouse2Text_74eb4
	dw CeruleanHouse2Text_74eb9

CeruleanHouse2Text_74e96:
	text_far _CeruleanHouse2Text_74e96
	text_end

CeruleanHouse2Text_74e9b:
	text_far _CeruleanHouse2Text_74e9b
	text_end

CeruleanHouse2Text_74ea0:
	text_far _CeruleanHouse2Text_74ea0
	text_end

CeruleanHouse2Text_74ea5:
	text_far _CeruleanHouse2Text_74ea5
	text_end

CeruleanHouse2Text_74eaa:
	text_far _CeruleanHouse2Text_74eaa
	text_end

CeruleanHouse2Text_74eaf:
	text_far _CeruleanHouse2Text_74eaf
	text_end

CeruleanHouse2Text_74eb4:
	text_far _CeruleanHouse2Text_74eb4
	text_end

CeruleanHouse2Text_74eb9:
	text_far _CeruleanHouse2Text_74eb9
	text_end

ViridianHouseTextSign1: ; new
	text_far _ViridianHouseTextSign1 ; new
	text_end

ViridianHouseText6: ; new
	text_far _ViridianHouseText6
	text_end

ViridianHouseText7: ; new
	text_asm
; if unlocked but not reached MEOWTH
	CheckHideShowExtra HS_ROUTE_22_COIN_CASE_MEOWTH
	ld hl, ViridianHouseText7_Meowth
	jr nz, .printAndEnd
; if already Champion
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE
	ld hl, ViridianHouseText7_Champion
	jr nz, .printAndEnd
; if unlocked but not beaten final rival
	CheckEvent EVENT_ROUTE22_RIVAL_WANTS_BATTLE
	jr z, .otherwise
	CheckEvent EVENT_2ND_ROUTE22_RIVAL_BATTLE
	ld hl, ViridianHouseText7_Rival2
	jr nz, .printAndEnd
; if unlocked and not missed first rival
	CheckEvent EVENT_1ST_ROUTE22_RIVAL_BATTLE
	ld hl, ViridianHouseText7_Rival1
	jr nz, .printAndEnd
.otherwise
	ld hl, ViridianHouseText7_Otherwise
.printAndEnd
	call PrintText
	jp TextScriptEnd

ViridianHouseText7_Rival1:
	text_far _ViridianHouseText7_Rival1
	text_end

ViridianHouseText7_Rival2:
	text_far _ViridianHouseText7_Rival2
	text_end

ViridianHouseText7_Champion:
	text_far _ViridianHouseText7_Champion
	text_end

ViridianHouseText7_Otherwise:
	text_far _ViridianHouseText7_Otherwise
	text_end

ViridianHouseText7_Meowth:
	text_far _ViridianHouseText7_Meowth
	text_end
