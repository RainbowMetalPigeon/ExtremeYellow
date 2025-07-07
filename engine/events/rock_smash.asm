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

; generate encounter 25% of the times
	call Random
	ldh a, [hRandomAdd]
	cp 25 percent
	jr nc, .tryItem
; random encounter, let's see who we get
	ldh a, [hRandomSub]
	ld b, a ; b holds the random number
	ld hl, RockSmashEncounters
.determineEncounterSlot
	ld a, [hli]
	cp b
	jr nc, .gotEncounterSlot
	inc hl
	inc hl
	jr .determineEncounterSlot
.gotEncounterSlot

	xor a ; a=0
	ld [wMoveMissed], a ; if 1, it consider the encounter to be fished ("hooked")
	ld a, [hli]
	ld [wCurOpponent], a
	ld a, [hl]
	ld [wCurEnemyLVL], a
	callfar RollForShiny ; new, for the shiny
	ret
	
.tryItem
	cp 50 percent ; 25% chance of getting an item
	ret nc ; do thing otherwise
; random item, let's see what we get
	ldh a, [hRandomSub]
	ld b, a ; b holds the random number
	ld hl, RockSmashItems
.determineItemSlot
	ld a, [hli]
	cp b
	jr nc, .gotItemSlot
	inc hl
	jr .determineItemSlot
.gotItemSlot
	
	ld a, [hl]
	ld b, a
	ld c, 1
	push bc
	
	ld [wd11e], a
	call GetItemName
	
	ld hl, FoundItemInRockText
	call PrintText
	
	pop bc
	call GiveItem
	ret c

	ld hl, BagFullText
	call PrintText
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

FoundItemInRockText:
	text_far _FoundHiddenItemText
	sound_get_item_1
	text_end
	
BagFullText:
	text_far _BagFullText
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

RockSmashEncounters:
	db 40, GEODUDE, 20
	db 60, GEODUDE, 30
	db 80, GRAVELER, 25
	db 100, GRAVELER, 35
	db 130, GOLEM, 30
	db 140, GOLEM, 40
	db 150, KRABBY, 20
	db 205, KRABBY, 30
	db 225, KINGLER, 30
	db 255, KINGLER, 40
	
RockSmashItems:
	db 27, KINGS_ROCK
	db 54, THUNDER_STONE
	db 81, WATER_STONE
	db 108, LEAF_STONE
	db 135, SUN_STONE
	db 162, ICE_STONE
	db 189, FIRE_STONE
	db 216, METAL_COAT
	db 240, MOON_STONE
	db 250, NUGGET
	db 252, BIG_NUGGET
	db 253, DOME_FOSSIL
	db 254, HELIX_FOSSIL
	db 255, OLD_AMBER
	
_BagFullText::
	text "But, <PLAYER> has"
	line "no more room for"
	cont "other items!"
	prompt