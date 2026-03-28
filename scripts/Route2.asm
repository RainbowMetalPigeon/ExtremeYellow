Route2_Script:
	jp EnableAutoTextBoxDrawing

Route2_TextPointers:
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText ; new, LINK_CABLE
	dw Route2SupremeRelaxerText ; new
	dw Route2Text3
	dw Route2Text4

Route2Text3:
	text_far _Route2Text3
	text_end

Route2Text4:
	text_far _Route2Text4
	text_end

Route2SupremeRelaxerText:
	text_asm
	callfar IsStarterPikachuInOurParty
	jr c, .yesFollowingPikachu
; no following Pikachu
	ld hl, Route2SupremeRelaxerText_NoPikachu
	jr .printAndEnd
.yesFollowingPikachu
	ld hl, Route2SupremeRelaxerText_WannaMassage
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .accepted
	ld hl, Route2SupremeRelaxerText_Refused
	jr .printAndEnd
.accepted
	ld hl, Route2SupremeRelaxerText_LetsGo
	call PrintText
	ld a, $f
	ld [wEmotionBubbleSpriteIndex], a
	ld a, HEART_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
	ldpikacry e, PikachuCry5
	callfar PlayPikachuSoundClip
	ld a, $FF
	ld [wPikachuMood], a
	ld hl, Route2SupremeRelaxerText_HereWeAre
.printAndEnd
	call PrintText
	jp TextScriptEnd

Route2SupremeRelaxerText_NoPikachu:
	text_far _Route2SupremeRelaxerText_NoPikachu
	text_end

Route2SupremeRelaxerText_WannaMassage:
	text_far _Route2SupremeRelaxerText_WannaMassage
	text_end

Route2SupremeRelaxerText_Refused:
	text_far _Route2SupremeRelaxerText_Refused
	text_end

Route2SupremeRelaxerText_LetsGo:
	text_far _Route2SupremeRelaxerText_LetsGo
	text_end

Route2SupremeRelaxerText_HereWeAre:
	text_far _Route2SupremeRelaxerText_HereWeAre
	text_end
