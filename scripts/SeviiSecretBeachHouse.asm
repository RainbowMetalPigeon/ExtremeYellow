SeviiSecretBeachHouse_Script:
	jp EnableAutoTextBoxDrawing

SeviiSecretBeachHouse_TextPointers:
	dw SeviiSecretBeachHouseText1  ; poster 1
	dw SeviiSecretBeachHouseText2  ; poster 2
	dw SeviiSecretBeachHouseText3  ; poster 3
	dw SeviiSecretBeachHouseText4  ; machine
	dw SeviiSecretBeachHouseText5  ; bed 1
	dw SeviiSecretBeachHouseText6  ; bed 2
	dw SeviiSecretBeachHouseText7  ; plant 1
	dw SeviiSecretBeachHouseText8  ; plant 2
	dw SeviiSecretBeachHouseText9  ; plant 3
	dw SeviiSecretBeachHouseText10 ; plant 4

SeviiSecretBeachHouseText1:
	text_far _SeviiSecretBeachHouseText1
	text_end

SeviiSecretBeachHouseText2:
	text_far _SeviiSecretBeachHouseText2
	text_end

SeviiSecretBeachHouseText3:
	text_far _SeviiSecretBeachHouseText3
	text_end

SeviiSecretBeachHouseText4:
	text_asm
	ld hl, SeviiSecretBeachHouseText4_1
	call PrintText
	call GBFadeOutToWhite
	call ReloadMapData
	predef HealParty
	ld a, MUSIC_PKMN_HEALED
	ld [wNewSoundID], a
	call PlaySound
.next
	ld a, [wChannelSoundIDs]
	cp MUSIC_PKMN_HEALED
	jr z, .next
	ld a, [wMapMusicSoundID]
	ld [wNewSoundID], a
	call PlaySound
	call GBFadeInFromWhite
	ld hl, SeviiSecretBeachHouseText4_2
	call PrintText
	ld a, $0
	ld [wJoyIgnore], a
	jp TextScriptEnd

SeviiSecretBeachHouseText4_1:
	text_far _SeviiSecretBeachHouseText4_1
	text_end

SeviiSecretBeachHouseText4_2:
	text_far _SeviiSecretBeachHouseText4_2
	text_end

SeviiSecretBeachHouseText5:
SeviiSecretBeachHouseText6:
	text_asm
	ld hl, SeviiSecretBeachHouseText5_1
	call PrintText
	call GBFadeOutToWhite
	call ReloadMapData
	ld a, MUSIC_PKMN_HEALED
	ld [wNewSoundID], a
	call PlaySound
.next
	ld a, [wChannelSoundIDs]
	cp MUSIC_PKMN_HEALED
	jr z, .next
	ld a, [wMapMusicSoundID]
	ld [wNewSoundID], a
	call PlaySound
	call GBFadeInFromWhite
	ld hl, SeviiSecretBeachHouseText5_2
	call PrintText
	ld a, $0
	ld [wJoyIgnore], a
	jp TextScriptEnd

SeviiSecretBeachHouseText5_1:
	text_far _SeviiSecretBeachHouseText5_1
	text_end

SeviiSecretBeachHouseText5_2:
	text_far _SeviiSecretBeachHouseText5_2
	text_end

SeviiSecretBeachHouseText7:
	text_asm
	CheckEvent EVENT_SEVII_SECRET_BEACH_HOUSE_WATERED_PLANT_1
	ld hl, PlantLooksHappierText
	jr nz, .printAndEnd
; we didn't water this plant yet
	ld hl, PlantLooksThirstyText
	call PrintText
	ld b, FRESH_WATER
	call IsItemInBag ; set zero flag if item isn't in player's bag
	jr z, .done
; we have water in bag
	call WaitForTextScrollButtonPress
	ld hl, PlantWannaWaterText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ld hl, PlantNoWaterText
	jr nz, .printAndEnd
; we offer a water
    ld a, SFX_LEVEL_UP ; SFX_DEX_PAGE_ADDED ; SFX_LEVEL_UP ; SFX_GET_ITEM_1 ; SFX_HEAL_HP
    call PlaySound
	ld a, FRESH_WATER
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	SetEvent EVENT_SEVII_SECRET_BEACH_HOUSE_WATERED_PLANT_1
	ld hl, PlantYesWaterText
.printAndEnd
	call PrintText
.done
	jp TextScriptEnd

SeviiSecretBeachHouseText8:
	text_asm
	CheckEvent EVENT_SEVII_SECRET_BEACH_HOUSE_WATERED_PLANT_2
	ld hl, PlantLooksHappierText
	jr nz, .printAndEnd
; we didn't water this plant yet
	ld hl, PlantLooksThirstyText
	call PrintText
	ld b, FRESH_WATER
	call IsItemInBag ; set zero flag if item isn't in player's bag
	jr z, .done
; we have water in bag
	call WaitForTextScrollButtonPress
	ld hl, PlantWannaWaterText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ld hl, PlantNoWaterText
	jr nz, .printAndEnd
; we offer a water
    ld a, SFX_LEVEL_UP ; SFX_DEX_PAGE_ADDED ; SFX_LEVEL_UP ; SFX_GET_ITEM_1 ; SFX_HEAL_HP
    call PlaySound
	ld a, FRESH_WATER
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	SetEvent EVENT_SEVII_SECRET_BEACH_HOUSE_WATERED_PLANT_2
	ld hl, PlantYesWaterText
.printAndEnd
	call PrintText
.done
	jp TextScriptEnd

SeviiSecretBeachHouseText9:
	text_asm
	CheckEvent EVENT_SEVII_SECRET_BEACH_HOUSE_WATERED_PLANT_3
	ld hl, PlantLooksHappierText
	jr nz, .printAndEnd
; we didn't water this plant yet
	ld hl, PlantLooksThirstyText
	call PrintText
	ld b, FRESH_WATER
	call IsItemInBag ; set zero flag if item isn't in player's bag
	jr z, .done
; we have water in bag
	call WaitForTextScrollButtonPress
	ld hl, PlantWannaWaterText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ld hl, PlantNoWaterText
	jr nz, .printAndEnd
; we offer a water
    ld a, SFX_LEVEL_UP ; SFX_DEX_PAGE_ADDED ; SFX_LEVEL_UP ; SFX_GET_ITEM_1 ; SFX_HEAL_HP
    call PlaySound
	ld a, FRESH_WATER
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	SetEvent EVENT_SEVII_SECRET_BEACH_HOUSE_WATERED_PLANT_3
	ld hl, PlantYesWaterText
.printAndEnd
	call PrintText
.done
	jp TextScriptEnd

SeviiSecretBeachHouseText10:
	text_asm
	CheckEvent EVENT_SEVII_SECRET_BEACH_HOUSE_WATERED_PLANT_4
	ld hl, PlantLooksHappierText
	jr nz, .printAndEnd
; we didn't water this plant yet
	ld hl, PlantLooksThirstyText
	call PrintText
	ld b, FRESH_WATER
	call IsItemInBag ; set zero flag if item isn't in player's bag
	jr z, .done
; we have water in bag
	call WaitForTextScrollButtonPress
	ld hl, PlantWannaWaterText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ld hl, PlantNoWaterText
	jr nz, .printAndEnd
; we offer a water
    ld a, SFX_LEVEL_UP ; SFX_DEX_PAGE_ADDED ; SFX_LEVEL_UP ; SFX_GET_ITEM_1 ; SFX_HEAL_HP
    call PlaySound
	ld a, FRESH_WATER
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	SetEvent EVENT_SEVII_SECRET_BEACH_HOUSE_WATERED_PLANT_4
	ld hl, PlantYesWaterText
.printAndEnd
	call PrintText
.done
	jp TextScriptEnd
	
PlantLooksHappierText:
	text_far _PlantLooksHappierText
	text_end

PlantLooksThirstyText:
	text_far _PlantLooksThirstyText
	text_end

PlantWannaWaterText:
	text_far _PlantWannaWaterText
	text_end

PlantNoWaterText:
	text_far _PlantNoWaterText
	text_end

PlantYesWaterText:
	text_far _PlantYesWaterText
	text_end
	