SeviiEmberSpa_Script:
	jp EnableAutoTextBoxDrawing

SeviiEmberSpa_TextPointers:
	dw SeviiEmberSpaText1
	dw SeviiEmberSpaText2
	dw SeviiEmberSpaText3
	dw SeviiEmberSpaText4
	dw PickUpItemText
	dw PickUpItemText

SeviiEmberSpaText1: ; Rock Smash gifter
	text_asm
	CheckEvent EVENT_GOT_HM06
	jr z, .didntGetInvitationYet
	ld hl, SeviiEmberSpaText1_After
	jr .printAndEnd
.didntGetInvitationYet
	ld hl, SeviiEmberSpaText1_HaveThis
	call PrintText
	lb bc, HM_ROCK_SMASH, 1
	call GiveItem
	jr nc, .bagFull
	SetEvent EVENT_GOT_HM06
	ld hl, SeviiEmberSpaText1_GotHM
	jr .printAndEnd
.bagFull
	ld hl, SeviiEmberSpaText1_BagFull
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiEmberSpaText1_After:
	text_far _SeviiEmberSpaText1_After
	text_end

SeviiEmberSpaText1_HaveThis:
	text_far _SeviiEmberSpaText1_HaveThis
	text_end

SeviiEmberSpaText1_GotHM:
	text_far _SeviiEmberSpaText1_GotHM
	sound_get_key_item
	text_end

SeviiEmberSpaText1_BagFull:
	text_far _SeviiEmberSpaText1_BagFull
	text_end
	
SeviiEmberSpaText2:
	text_far _SeviiEmberSpaText2
	text_end

SeviiEmberSpaText3:
	text_far _SeviiEmberSpaText3
	text_end

SeviiEmberSpaText4:
	text_far _SeviiEmberSpaText4
	text_end
