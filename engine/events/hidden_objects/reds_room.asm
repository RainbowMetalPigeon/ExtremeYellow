PrintRedSNESText: ; edited for RP
	call EnableAutoTextBoxDrawing
	CheckEvent EVENT_ROCKET_PATH
	jr nz, .RP
	tx_pre_jump RedBedroomSNESText
.RP
	tx_pre_jump RedBedroomSNESText_RP

RedBedroomSNESText::
	text_far _RedBedroomSNESText
	text_end

RedBedroomSNESText_RP::
	text_far _RedBedroomSNESText_RP
	text_end

OpenRedsPC:
	call EnableAutoTextBoxDrawing
	tx_pre_jump RedBedroomPCText

RedBedroomPCText::
	script_players_pc
