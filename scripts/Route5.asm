Route5_Script:
	jp EnableAutoTextBoxDrawing

Route5_TextPointers:
	dw Route5Text1 ; new
	dw Route5Text2 ; new
	dw Route5Text3 ; new
	dw Route5Text4 ; new
	dw Route5Text5 ; new
	; sign
	dw Route5Text6

Route5Text1:
	text_asm
	CheckEvent EVENT_GOT_CLIMB_CLUB_INVITATION
	jr z, .didntGetInvitationYet
	ld hl, Route5Text1_After
	jr .printAndEnd
.didntGetInvitationYet
	ld hl, Route5Text1_DoYouLike
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	cp 1
	jr nz, .playerLikes
	ld hl, Route5Text1_TooBad
	jr .printAndEnd
.playerLikes
	ld hl, Route5Text1_YoAmazing
	call PrintText
	lb bc, CC_INVITE, 1
	call GiveItem
	jr nc, .bagFull
	SetEvent EVENT_GOT_CLIMB_CLUB_INVITATION
	ld hl, Route5Text1_GotInvitation
	jr .printAndEnd
.bagFull
	ld hl, Route5Text1_BagFull
.printAndEnd
	call PrintText
	jp TextScriptEnd

Route5Text1_BagFull:
	text_far _Route5Text1_BagFull
	text_end

Route5Text1_GotInvitation:
	text_far _Route5Text1_GotInvitation
	sound_get_item_1
	text_end

Route5Text1_TooBad:
	text_far _Route5Text1_TooBad
	text_end

Route5Text1_YoAmazing:
	text_far _Route5Text1_YoAmazing
	text_end

Route5Text1_After:
	text_far _Route5Text1_After
	text_end

Route5Text1_DoYouLike:
	text_far _Route5Text1_DoYouLike
	text_end

Route5Text2:
	text_far _Route5Text2
	text_end

Route5Text3:
	text_far _Route5Text3
	text_end

Route5Text4:
	text_far _Route5Text4
	text_end

Route5Text5:
	text_far _Route5Text5
	text_end

Route5Text6:
	text_far _Route5Text6
	text_end
