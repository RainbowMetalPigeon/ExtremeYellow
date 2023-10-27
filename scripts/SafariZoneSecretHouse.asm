SafariZoneSecretHouse_Script:
	jp EnableAutoTextBoxDrawing

SafariZoneSecretHouse_TextPointers:
	dw SafariZoneSecretHouseText1

SafariZoneSecretHouseText1:
	text_asm
	CheckEvent EVENT_GOT_HM04 ; edited
	jr nz, .got_item
	ld hl, SafariZoneSecretHouseText_4a350
	call PrintText
	lb bc, HM_STRENGTH, 1 ; edited
	call GiveItem
	jr nc, .bag_full
	ld hl, ReceivedHM04Text
	call PrintText
	SetEvent EVENT_GOT_HM04 ; edited
	jr .done
.bag_full
	ld hl, HM04NoRoomText
	call PrintText
	jr .done
.got_item
	ld hl, HM04ExplanationText
	call PrintText
.done
	jp TextScriptEnd

SafariZoneSecretHouseText_4a350:
	text_far _SecretHouseText_4a350
	text_end

ReceivedHM04Text:
	text_far _ReceivedHM04Text
	sound_get_item_1
	text_end

HM04ExplanationText:
	text_far _HM04ExplanationText
	text_end

HM04NoRoomText:
	text_far _HM04NoRoomText
	text_end
