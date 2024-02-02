TextScriptEndingText::
	text_end

TextScriptEnd::
	ld hl, TextScriptEndingText
	ret

ExclamationText::
	text_far _ExclamationText
	text_end

GroundRoseText::
	text_far _GroundRoseText
	text_end

BoulderText:: ; edited
	text_asm
	ld d, STRENGTH
    callfar IsMoveInParty ; output: d = how many matches, z flag = whether a match was found (set = match found)
    jr z, .notStrengthInTeam
; we have a Pokemon with STRENGTH in the team
	ld a, [wObtainedBadges]
	bit BIT_RAINBOWBADGE, a
	jp z, .newBadgeRequired
; we have the necessary badge
	ld hl, wd728
	set 0, [hl]
	ld hl, CanMoveBouldersText2
	jr .printAndEnd
.notStrengthInTeam
	ld hl, BoulderText_Internal
	jr .printAndEnd
.newBadgeRequired
	ld hl, NewBadgeRequiredText3
.printAndEnd
	call PrintText
	jp TextScriptEnd

NewBadgeRequiredText3:: ; new
    text_far _NewBadgeRequiredText2
    text_end

BoulderText_Internal:: ; new
	text_far _BoulderText
	text_end

CanMoveBouldersText2:: ; new
	text_far _CanMoveBouldersText2
	text_end

MartSignText::
	text_far _MartSignText
	text_end

PokeCenterSignText::
	text_far _PokeCenterSignText
	text_end

PickUpItemText::
	text_asm
	predef PickUpItem
	jp TextScriptEnd
