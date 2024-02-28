WardensHouse_Script:
	jp EnableAutoTextBoxDrawing

WardensHouse_TextPointers:
	; people ---
	dw FuchsiaHouse2Text1
	dw FuchsiaHouse2AntiquitiesTextShopOwner ; new
	dw FuchsiaHouse2AntiquitiesText2 ; new
	dw FuchsiaHouse2AntiquitiesText3 ; new
	dw FuchsiaHouse2AntiquitiesText4 ; new
	dw FuchsiaHouse2AntiquitiesText5 ; new
	dw FuchsiaHouse2AntiquitiesTextMapPiece ; new
;	dw PickUpItemText
;	dw BoulderText
	; signs ---
	dw FuchsiaHouse2Text4
	dw FuchsiaHouse2Text5
	; new
	dw FuchsiaHouse2AntiquitiesSign1
	dw FuchsiaHouse2AntiquitiesSign2
	dw FuchsiaHouse2AntiquitiesSign3
	dw FuchsiaHouse2AntiquitiesSign4
	dw FuchsiaHouse2AntiquitiesSign5
	dw FuchsiaHouse2AntiquitiesSign6
	dw FuchsiaHouse2AntiquitiesSign7
	dw FuchsiaHouse2AntiquitiesSign8

; people ------

FuchsiaHouse2Text1:
	text_asm
	CheckEvent EVENT_GOT_HM03 ; edited
	jr nz, .got_item
	ld b, GOLD_TEETH
	call IsItemInBag
	jr nz, .have_gold_teeth
	CheckEvent EVENT_GAVE_GOLD_TEETH
	jr nz, .gave_gold_teeth
	ld hl, WardenGibberishText1
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ld hl, WardenGibberishText3
	jr nz, .refused
	ld hl, WardenGibberishText2
.refused
	call PrintText
	jr .done
.have_gold_teeth
	ld hl, WardenTeethText1
	call PrintText
	ld a, GOLD_TEETH
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	SetEvent EVENT_GAVE_GOLD_TEETH
.gave_gold_teeth
	ld hl, WardenThankYouText
	call PrintText
	lb bc, HM_SURF, 1 ; edited
	call GiveItem
	jr nc, .bag_full
	ld hl, ReceivedHM03Text
	call PrintText
	SetEvent EVENT_GOT_HM03 ; edited
	jr .done
.got_item
	CheckEvent EVENT_BEAT_OBSIDIAN_WAREHOUSE_FINAL_TRAINER_4 ; new
	jr nz, .beatObsidianGiovanni ; new
	ld hl, HM03ExplanationText
	call PrintText
	jr .done
.beatObsidianGiovanni ; new
	ld hl, BeatGiovanniAmazementText ; new
	call PrintText ; new
	jr .done ; new
.bag_full
	ld hl, HM03NoRoomText
	call PrintText
.done
	jp TextScriptEnd

WardenGibberishText1:
	text_far _WardenGibberishText1
	text_end

WardenGibberishText2:
	text_far _WardenGibberishText2
	text_end

WardenGibberishText3:
	text_far _WardenGibberishText3
	text_end

WardenTeethText1:
	text_far _WardenTeethText1
	sound_get_key_item ; edited, was just sound_get_item_1

WardenTeethText2:
	text_far _WardenTeethText2
	text_end

WardenThankYouText:
	text_far _WardenThankYouText
	text_end

ReceivedHM03Text:
	text_far _ReceivedHM03Text
	sound_get_key_item ; edited, was just sound_get_item_1
	text_end

HM03ExplanationText:
	text_far _HM03ExplanationText
	text_end

BeatGiovanniAmazementText: ; new
	text_far _BeatGiovanniAmazementText
	text_end

HM03NoRoomText:
	text_far _HM03NoRoomText
	text_end

; new ---

FuchsiaHouse2AntiquitiesTextShopOwner: ; PG = Post-Giovanni
	text_asm
	ld hl, FuchsiaHouse2AntiquitiesTextShopOwner_PreObsidianGiovanniDefeat
	CheckEvent EVENT_BEAT_OBSIDIAN_WAREHOUSE_FINAL_TRAINER_4
	jr z, .printAndEnd
; we defeated Obsidian Giovanni
	ld hl, FuchsiaHouse2AntiquitiesTextShopOwner_PostGivingMap
	CheckEvent EVENT_OBTAIN_MAP_PIECE_3_TREASURE_HUNTER
	jr nz, .printAndEnd
; we have not received the Map Piece yet
	ld b, ARTIFACT
	call IsItemInBag
	jr nz, .ArtifactInBag
	ld hl, FuchsiaHouse2AntiquitiesTextShopOwner_PG_NoArtifact
	jr .printAndEnd
.ArtifactInBag
	ld hl, FuchsiaHouse2AntiquitiesTextShopOwner_PG_YesArtifact
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ld hl, FuchsiaHouse2AntiquitiesTextShopOwner_PG_NoTrade
	jr nz, .printAndEnd
; we have the ARTIFACT and we do accept the trade
	ld hl, FuchsiaHouse2AntiquitiesTextShopOwner_PG_YesTrade
	call PrintText
	ld a, ARTIFACT
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	ld a, HS_WARDENS_ANTIQUITIES_MAP_PIECE
	ld [wMissableObjectIndex], a
	predef HideObject
	CheckAndSetEvent EVENT_OBTAIN_ANY_MAP_PIECE
	jr nz, .setMapPieceEvent
; we also need to give the map item itself
	lb bc, MYSTERY_MAP, 1
	call GiveItem
;	jr c, .useless ; this check can never fail unless the player messes up the game
.setMapPieceEvent
	SetEvent EVENT_OBTAIN_MAP_PIECE_3_TREASURE_HUNTER
	ld hl, FuchsiaHouse2AntiquitiesTextShopOwner_PG_ObtainMapPiece
	jr z, .printAndEnd
.printAndEnd
	call PrintText
	jp TextScriptEnd

FuchsiaHouse2AntiquitiesTextShopOwner_PreObsidianGiovanniDefeat:
	text_far _FuchsiaHouse2AntiquitiesTextShopOwner_PreObsidianGiovanniDefeat
	text_end

FuchsiaHouse2AntiquitiesTextShopOwner_PG_NoArtifact:
	text_far _FuchsiaHouse2AntiquitiesTextShopOwner_PG_NoArtifact
	text_end

FuchsiaHouse2AntiquitiesTextShopOwner_PG_YesArtifact:
	text_far _FuchsiaHouse2AntiquitiesTextShopOwner_PG_YesArtifact
	text_end

FuchsiaHouse2AntiquitiesTextShopOwner_PG_NoTrade:
	text_far _FuchsiaHouse2AntiquitiesTextShopOwner_PG_NoTrade
	text_end

FuchsiaHouse2AntiquitiesTextShopOwner_PG_YesTrade:
	text_far _FuchsiaHouse2AntiquitiesTextShopOwner_PG_YesTrade
	text_end

FuchsiaHouse2AntiquitiesTextShopOwner_PG_ObtainMapPiece:
	text_far _Route12TextObsidianMinesHiker_GiveMapPiece ; shared
	sound_get_key_item
	text_end

FuchsiaHouse2AntiquitiesTextShopOwner_PostGivingMap:
	text_far _FuchsiaHouse2AntiquitiesTextShopOwner_PostGivingMap
	text_end

; ---

FuchsiaHouse2AntiquitiesText2:
	text_far _FuchsiaHouse2AntiquitiesText2
	text_end

FuchsiaHouse2AntiquitiesText3:
	text_far _FuchsiaHouse2AntiquitiesText3
	text_end

FuchsiaHouse2AntiquitiesText4:
	text_far _FuchsiaHouse2AntiquitiesText4
	text_end

FuchsiaHouse2AntiquitiesText5:
	text_far _FuchsiaHouse2AntiquitiesText5
	text_end

FuchsiaHouse2AntiquitiesTextMapPiece:
	text_far _FuchsiaHouse2AntiquitiesTextMapPiece
	text_end

; signs ------

FuchsiaHouse2Text5:
FuchsiaHouse2Text4:
	text_asm
	ldh a, [hSpriteIndex]
	cp $8 ; lol this whole thing is beyond idiotic
	ld hl, FuchsiaHouse2Text_7517b
	jr nz, .asm_4c9a2
	ld hl, FuchsiaHouse2Text_75176
.asm_4c9a2
	call PrintText
	jp TextScriptEnd

FuchsiaHouse2Text_75176:
	text_far _FuchsiaHouse2Text_75176
	text_end

FuchsiaHouse2Text_7517b:
	text_far _FuchsiaHouse2Text_7517b
	text_end

; new ---

FuchsiaHouse2AntiquitiesSign1:
	text_far _FuchsiaHouse2AntiquitiesSign1
	text_end

FuchsiaHouse2AntiquitiesSign2:
	text_far _FuchsiaHouse2AntiquitiesSign2
	text_end

FuchsiaHouse2AntiquitiesSign3:
	text_far _FuchsiaHouse2AntiquitiesSign3
	text_end

FuchsiaHouse2AntiquitiesSign4:
	text_far _FuchsiaHouse2AntiquitiesSign4
	text_end

FuchsiaHouse2AntiquitiesSign5:
	text_far _FuchsiaHouse2AntiquitiesSign5
	text_end

FuchsiaHouse2AntiquitiesSign6:
	text_far _FuchsiaHouse2AntiquitiesSign6
	text_end

FuchsiaHouse2AntiquitiesSign7:
	text_far _FuchsiaHouse2AntiquitiesSign7
	text_end

FuchsiaHouse2AntiquitiesSign8:
	text_far _FuchsiaHouse2AntiquitiesSign8
	text_end
