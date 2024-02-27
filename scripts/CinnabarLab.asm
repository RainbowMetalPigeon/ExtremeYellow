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
	ld hl, Lab1Text2_Archeologist_PostGift
	CheckEvent EVENT_GIVEN_CINNABAR_ARCHEOLOGIST_ARTIFACT
	jr nz, .printAndEnd
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
	lb bc, POTION, 1 ; ARTIFACT
	call GiveItem
	jr nc, .bagFull
	ResetEvent EVENT_GIVEN_CINNABAR_ARCHEOLOGIST_ARTIFACT_FAILED
	SetEvent EVENT_GIVEN_CINNABAR_ARCHEOLOGIST_ARTIFACT
	ld a, HS_CINNABAR_LAB_ARTIFACT
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld hl, Lab1Text2_Archeologist_GiftedArtifact
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

Lab1Text2_Archeologist_GiftedArtifact:
	text_far _Lab1Text2_Archeologist_GiftedArtifact
	sound_get_key_item
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
