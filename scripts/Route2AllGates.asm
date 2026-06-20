Route2AllGates_Script:
	RPTextChooser Route2AllGates_TextPointers, Route2AllGates_TextPointers_Rocket
	jp EnableAutoTextBoxDrawing

Route2AllGates_TextPointers:
	; Route 2 Gate
	dw Route2GateText1
	dw Route2GateText2
	; Viridian Forest South Gate
	dw ViridianForestEntranceText1
	dw ViridianForestEntranceText2
	; Viridian Forest South Gate
	dw ViridianForestExitText1
	dw ViridianForestExitText2

Route2AllGates_TextPointers_Rocket:
	; Route 2 Gate
	dw Route2GateText1 ; TBE, Flash AID
	dw GenericNPCText_RocketPath
	; Viridian Forest South Gate
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	; Viridian Forest South Gate
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath

Route2GateText1:
	text_asm
	CheckEvent EVENT_GOT_HM05
	jr nz, .got_item
	ld a, 10
	ldh [hOaksAideRequirement], a
	ld a, HM_FLASH
	ldh [hOaksAideRewardItem], a
	ld [wd11e], a
	call GetItemName
	ld hl, wcd6d
	ld de, wOaksAideRewardItemName
	ld bc, ITEM_NAME_LENGTH
	call CopyData
	predef OaksAideScript
	ldh a, [hOaksAideResult]
	cp OAKS_AIDE_GOT_ITEM
	jr nz, .no_item
	SetEvent EVENT_GOT_HM05
.got_item
	ld hl, Route2GateText_5d616
	call PrintText
.no_item
	jp TextScriptEnd

Route2GateText_5d616:
	text_far _Route2GateText_5d616
	text_end

Route2GateText2:
	text_far _Route2GateText2
	text_end

ViridianForestEntranceText1:
	text_far _ViridianForestEntranceText1
	text_end

ViridianForestEntranceText2:
	text_far _ViridianForestEntranceText2
	text_end

ViridianForestExitText1:
	text_far _ViridianForestExitText1
	text_end

ViridianForestExitText2:
	text_far _ViridianForestExitText2
	text_end
