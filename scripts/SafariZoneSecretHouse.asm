SafariZoneSecretHouse_Script:
	jp EnableAutoTextBoxDrawing

SafariZoneSecretHouse_TextPointers:
	dw SafariZoneSecretHouseText1

SafariZoneSecretHouseText1:
	text_asm
	CheckEvent EVENT_GOT_LUNAR_RELIC ; edited
	jr nz, .got_item
	ld hl, SafariZoneSecretHouseText_4a350
	call PrintText
	lb bc, LUNAR_RELIC, 1 ; edited
	call GiveItem
	jr nc, .bag_full
	ld hl, ReceivedLunarRelicText
	call PrintText
	SetEvent EVENT_GOT_LUNAR_RELIC ; edited
	jr .done
.bag_full
	ld hl, LunarRelicNoRoomText
	call PrintText
	jr .done
.got_item
	ld hl, LunarRelicExplanationText
	call PrintText
.done
	jp TextScriptEnd

SafariZoneSecretHouseText_4a350:
	text_far _SecretHouseText_4a350
	text_end

ReceivedLunarRelicText:
	text_far _ReceivedLunarRelicText
	sound_get_key_item ; edited, was just sound_get_item_1
	text_end

LunarRelicExplanationText:
	text_far _LunarRelicExplanationText
	text_end

LunarRelicNoRoomText:
	text_far _LunarRelicNoRoomText
	text_end
