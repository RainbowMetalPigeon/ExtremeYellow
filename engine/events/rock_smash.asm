RockSmash::
	call EnableAutoTextBoxDrawing
	
	CheckEvent EVENT_BEAT_OCHRE_GYM_ORAGE
	jr nz, .canUseRockSmash
; we haven't beaten Orage yet
	ld hl, CannotUseRockSmashText
	call PrintText
	ret

.canUseRockSmash
; check if a Pokemon has the move
	ld d, SPLASH ; will be ROCK_SMASH
    callfar IsMoveInParty ; output: d = how many matches, z flag = whether a match was found (set = match found)
    jr nz, .RockSmashInTeam
; we don't have the move
	ld hl, APokemonCouldSmashThisText
	call PrintText
	ret

.RockSmashInTeam
; all good, let's break that rock
	ldh a, [hSpriteIndexOrTextID]
	ld b, a
	ld hl, wMissableObjectList
.missableObjectsListLoop
	ld a, [hli]
	cp $ff
	ret z
	cp b
	jr z, .isMissable
	inc hl
	jr .missableObjectsListLoop

.isMissable
	ld a, [hl]
	ldh [hMissableObjectIndex], a
	ld [wMissableObjectIndex], a

	ld a, 1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, RockSmashedText
	call PrintText
	
; artificial blinking
	ld a, SFX_CUT ; SFX_PUSH_BOULDER
	call PlaySound
	call ProperHide
	ld c, 9
	call DelayFrames
	call ProperShow
	ld c, 9
	call DelayFrames
	call ProperHide
	ld c, 9
	call DelayFrames
	call ProperShow
	ld c, 36
	call DelayFrames
	call ProperHide

	ret

RockSmashedText:
	text_far _RockSmashedText
	text_end

CannotUseRockSmashText:
	text_far _CannotUseRockSmashText
	text_end
	
APokemonCouldSmashThisText:
	text_far _APokemonCouldSmashThisText
	text_end

ProperHide:
	CheckEvent EVENT_IN_SEVII
	jr nz, .sevii
	CheckEvent EVENT_USE_EXTRA_HIDESHOW
	jr nz, .hideExtra
	predef HideObject
	ret
.hideExtra
	predef HideObjectExtra
	ret
.sevii
	predef HideObjectSevii
	ret

ProperShow:
	CheckEvent EVENT_IN_SEVII
	jr nz, .sevii
	CheckEvent EVENT_USE_EXTRA_HIDESHOW
	jr nz, .showExtra
	predef ShowObject
	ret
.showExtra
	predef ShowObjectExtra
	ret
.sevii
	predef ShowObjectSevii
	ret
