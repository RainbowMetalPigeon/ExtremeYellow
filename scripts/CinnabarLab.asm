CinnabarLab_Script:
	call EnableAutoTextBoxDrawing
	ret

CinnabarLab_TextPointers:
	; people
	dw Lab1Text1
	dw Lab1Text2_Archeologist ; new
	dw Lab1Text3_Seismologist ; new
	dw Lab1Text4_PlantEnthusiast ; new
	dw Lab1Text5_Treasure ; new
	dw Lab2Text1
	dw Lab2Text2
	dw Lab2Text3
	dw Lab3Text1
	dw Lab3Text2
	dw Lab4Text1
	dw Lab4Text2
	; signs
	dw Lab1Text2
	dw Lab1Text3
	dw Lab1Text4
	dw Lab1Text5
	dw Lab1ArcheologistSign1 ; new
	dw Lab1ArcheologistSign2 ; new
	dw Lab1ArcheologistSign3 ; new
	dw Lab1ArcheologistSign4 ; new
	dw Lab1ArcheologistSign5 ; new
	dw Lab1SeismologySign1 ; new
	dw Lab3Text3
	dw Lab3Text4
	dw Lab3Text5

Lab1Text1:
	text_far _Lab1Text1
	text_end

Lab1Text2:
	text_far _Lab1Text2
	text_end

Lab1Text3:
	text_far _Lab1Text3
	text_end

Lab1Text4:
	text_far _Lab1Text4
	text_end

Lab1Text5:
	text_far _Lab1Text5
	text_end

; new ------------------

; people ---

Lab1Text2_Archeologist:
	text_asm
	CheckEvent EVENT_GIVEN_CINNABAR_ARCHEOLOGIST_ARTIFACT
	jr z, .notBeenGiftedTreasureYet
	SetEvent EVENT_LAST_DIALOGUE_CINNABAR_ARCHEOLOGIST
	ld hl, Lab1Text2_Archeologist_PostGift
	jr .printAndEnd
.notBeenGiftedTreasureYet
; we have not been gifted the treasure yet
	ld hl, Lab1Text2_Archeologist_PreReturnRelic
	CheckEvent EVENT_RETURNED_LUNAR_RELIC
	jr z, .printAndEnd
; we have already returned the Relic
	ld hl, Lab1Text2_Archeologist_PostReturnRelic_FirstTime
	CheckEvent EVENT_GIVEN_CINNABAR_ARCHEOLOGIST_ARTIFACT_FAILED
	jr z, .firstTimePostRelicReturn
	ld hl, Lab1Text2_Archeologist_PostReturnRelic_NotFirstTime
.firstTimePostRelicReturn
	call PrintText
	lb bc, ARTIFACT, 1
	call GiveItem
	jr nc, .bagFull
	ResetEvent EVENT_GIVEN_CINNABAR_ARCHEOLOGIST_ARTIFACT_FAILED
	SetEvent EVENT_GIVEN_CINNABAR_ARCHEOLOGIST_ARTIFACT
	ld a, HS_CINNABAR_LAB_ARTIFACT
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld hl, Lab1Text2_Archeologist_GiftedArtifact1
	call PrintText
	ld hl, Lab1Text2_Archeologist_GiftedArtifact2
	jr .printAndEnd
.bagFull
	SetEvent EVENT_GIVEN_CINNABAR_ARCHEOLOGIST_ARTIFACT_FAILED
	ld hl, Lab1Text2_Archeologist_BagFull
.printAndEnd
	call PrintText
	jp TextScriptEnd

Lab1Text2_Archeologist_PostGift:
	text_far _Lab1Text2_Archeologist_PostGift
	text_end

Lab1Text2_Archeologist_PreReturnRelic:
	text_far _Lab1Text2_Archeologist_PreReturnRelic
	text_end

Lab1Text2_Archeologist_PostReturnRelic_FirstTime:
	text_far _Lab1Text2_Archeologist_PostReturnRelic_FirstTime
	text_end

Lab1Text2_Archeologist_PostReturnRelic_NotFirstTime:
	text_far _Lab1Text2_Archeologist_PostReturnRelic_NotFirstTime
	text_end

Lab1Text2_Archeologist_GiftedArtifact1:
	text_far _Lab1Text2_Archeologist_GiftedArtifact1
	sound_get_key_item
	text_end

Lab1Text2_Archeologist_GiftedArtifact2:
	text_far _Lab1Text2_Archeologist_GiftedArtifact2
	text_end

Lab1Text2_Archeologist_BagFull:
	text_far _Lab1Text2_Archeologist_BagFull
	text_end

; ---

Lab1Text3_Seismologist:
	text_far _Lab1Text3_Seismologist
	text_end

Lab1Text4_PlantEnthusiast:
	text_far _Lab1Text4_PlantEnthusiast
	text_end

Lab1Text5_Treasure:
	text_far _Lab1Text5_Treasure
	text_end

; signs ---

Lab1ArcheologistSign1:
	text_far _Lab1ArcheologistSign1
	text_end

Lab1ArcheologistSign2:
	text_far _Lab1ArcheologistSign2
	text_end

Lab1ArcheologistSign3:
	text_far _Lab1ArcheologistSign3
	text_end

Lab1ArcheologistSign4:
	text_far _Lab1ArcheologistSign4
	text_end

Lab1ArcheologistSign5:
	text_far _Lab1ArcheologistSign5
	text_end

Lab1SeismologySign1:
	text_far _Lab1SeismologySign1
	text_end

; Lab 2 ----------------------------------

Lab2Text1:
	text_far _Lab2Text1
	text_end

Lab2Text2:
	text_asm
	ld a, TRADE_FOR_SPOONY ; edited
	ld [wWhichTrade], a
	jr Lab2DoTrade

Lab2Text3:
	text_asm
	ld a, TRADE_FOR_MUSKY ; edited
	ld [wWhichTrade], a
Lab2DoTrade:
	predef DoInGameTradeDialogue
	jp TextScriptEnd

; Lab 3 ----------------------------------

Lab3Text1:
	text_asm
	CheckEvent EVENT_GOT_TM35
	jr nz, .got_item
	ld hl, TM35PreReceiveText
	call PrintText
	lb bc, TM_HYDRO_PUMP, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, ReceivedTM35Text
	call PrintText
	SetEvent EVENT_GOT_TM35
	jr .done
.bag_full
	ld hl, TM35NoRoomText
	call PrintText
	jr .done
.got_item
	ld hl, TM35ExplanationText
	call PrintText
.done
	jp TextScriptEnd

TM35PreReceiveText:
	text_far _TM35PreReceiveText
	text_end

ReceivedTM35Text:
	text_far _ReceivedTM35Text
	sound_get_item_1
	text_end

TM35ExplanationText:
	text_far _TM35ExplanationText
	text_end

TM35NoRoomText:
	text_far _TM35NoRoomText
	text_end

Lab3Text2:
	text_far _Lab3Text2
	text_end

Lab3Text4:
Lab3Text3:
	text_far _Lab3Text3
	text_end

Lab3Text5:
	text_far _Lab3Text5
	text_end

; Lab 4 ----------------------------------

Lab4Script_GetFossilsInBag:
; construct a list of all fossils in the player's bag
	xor a
	ld [wFilteredBagItemsCount], a
	ld de, wFilteredBagItems
	ld hl, FossilsList
.loop
	ld a, [hli]
	and a
	jr z, .done
	push hl
	push de
	ld [wd11e], a
	ld b, a
	predef GetQuantityOfItemInBag
	pop de
	pop hl
	ld a, b
	and a
	jr z, .loop

	; A fossil's in the bag
	ld a, [wd11e]
	ld [de], a
	inc de
	push hl
	ld hl, wFilteredBagItemsCount
	inc [hl]
	pop hl
	jr .loop
.done
	ld a, $ff
	ld [de], a
	ret

FossilsList:
	db DOME_FOSSIL
	db HELIX_FOSSIL
	db OLD_AMBER
	db 0 ; end

Lab4Text1:
	text_asm
	CheckEvent EVENT_GAVE_FOSSIL_TO_LAB
	jr nz, .asm_75d96
	ld hl, Lab4Text_75dc6
	call PrintText
	call Lab4Script_GetFossilsInBag
	ld a, [wFilteredBagItemsCount]
	and a
	jr z, .asm_75d8d
	farcall GiveFossilToCinnabarLab
	jr .asm_75d93
.asm_75d8d
	ld hl, Lab4Text_75dcb
	call PrintText
.asm_75d93
	jp TextScriptEnd
.asm_75d96
	CheckEventAfterBranchReuseA EVENT_LAB_STILL_REVIVING_FOSSIL, EVENT_GAVE_FOSSIL_TO_LAB
	jr z, .asm_75da2
	ld hl, Lab4Text_75dd0
	call PrintText
	jr .asm_75d93
.asm_75da2
	call LoadFossilItemAndMonNameBank1D
	ld hl, Lab4Text_75dd5
	call PrintText
	SetEvent EVENT_LAB_HANDING_OVER_FOSSIL_MON
	ld a, [wFossilMon]
	ld b, a
	ld c, 45 ; edited, was 30
	call GivePokemon
	jr nc, .asm_75d93
	ResetEvents EVENT_GAVE_FOSSIL_TO_LAB, EVENT_LAB_STILL_REVIVING_FOSSIL, EVENT_LAB_HANDING_OVER_FOSSIL_MON
	jr .asm_75d93

Lab4Text_75dc6:
	text_far _Lab4Text_75dc6
	text_end

Lab4Text_75dcb:
	text_far _Lab4Text_75dcb
	text_end

Lab4Text_75dd0:
	text_far _Lab4Text_75dd0
	text_end

Lab4Text_75dd5:
	text_far _Lab4Text_75dd5
	text_end

Lab4Text2:
	text_asm
	ld a, TRADE_FOR_PEBBLE ; edited
	ld [wWhichTrade], a
	predef DoInGameTradeDialogue
	jp TextScriptEnd

LoadFossilItemAndMonNameBank1D:
	farjp LoadFossilItemAndMonName
