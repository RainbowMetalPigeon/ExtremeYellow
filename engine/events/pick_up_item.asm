PickUpItem:
	call EnableAutoTextBoxDrawing

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

	ld hl, wMapSpriteExtraData
	ldh a, [hSpriteIndexOrTextID]
	dec a
	add a
	ld d, 0
	ld e, a
	add hl, de

;	ld a, [hl] ; edited, commented out, now unnecessary here, gets loaded later
; new, to item randomization
	ld a, [wRandomizationItems] ; 0 for NO, 1 for YES
	and a
	jr z, .lockedItemOrNoRandomization
; we DO randomize the items
	ld a, [hl] ; a contains the item we are supposed to pick up
	call CheckIfItemIsLocked ; item is in a, c flag if it is locked
	jr c, .lockedItemOrNoRandomization
; item is not locked: can be randomized
.loopRandom
	call Random
	cp 65 ; length of the RandomizableItems list
	jr nc, .loopRandom
; now a contains a random number in [0,64]
	ld hl, RandomizableItems
.accessLoop
	dec a
	cp $FF
	jr z, .doneAccessLoop
	inc hl
	jr .accessLoop
.doneAccessLoop
	; now [hl] contains the randomized allowed item, so we can continue as follows
	; double label merely for clarity reasons
.lockedItemOrNoRandomization
	ld a, [hl]
.backToVanilla
; end of item randomization part

	ld b, a ; item
	ld c, 1 ; quantity
	call GiveItem
	jr nc, .BagFull

	ldh a, [hMissableObjectIndex]
	ld [wMissableObjectIndex], a
	CheckEvent EVENT_USE_EXTRA_HIDESHOW ; new
	jr nz, .hideExtra 					; new
	predef HideObject
	jr .hidden							; new
.hideExtra								; new
	predef HideObjectExtra				; new
.hidden									; new
	ld a, 1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, FoundItemText
	jr .print

.BagFull
	ld hl, NoMoreRoomForItemText
.print
	call PrintText
	ret

FoundItemText:
	text_far _FoundItemText
	sound_get_item_1
	text_end

NoMoreRoomForItemText:
	text_far _NoMoreRoomForItemText
	text_end

; new, for item randomization

CheckIfItemIsLocked: ; returns c flag if item loaded in a is locked
	push hl
	push de
	push bc
	ld hl, LockedItems
	ld de, 1
	call IsInArray ; search an array at hl for the value in a; entry size is de bytes; returns count b and carry if found
	pop bc
	pop de
	pop hl
	ret

RandomizableItems: ; 65 items, so it's ok if indexes are between 0 and 64
	db MASTER_BALL
	db ULTRA_BALL
	db GREAT_BALL
	db POKE_BALL
	db MOON_STONE
	db ANTIDOTE
	db BURN_HEAL
	db ICE_HEAL
	db AWAKENING
	db PARLYZ_HEAL
	db FULL_RESTORE
	db MAX_POTION
	db HYPER_POTION
	db SUPER_POTION
	db POTION
	db ESCAPE_ROPE
	db REPEL
	db FIRE_STONE
	db THUNDER_STONE
	db WATER_STONE
	db HP_UP
	db PROTEIN
	db IRON
	db CARBOS
	db CALCIUM
	db RARE_CANDY
	db X_ACCURACY
	db LEAF_STONE
	db NUGGET
	db POKE_DOLL
	db FULL_HEAL
	db REVIVE
	db MAX_REVIVE
	db GUARD_SPEC
	db SUPER_REPEL
	db MAX_REPEL
	db DIRE_HIT
;	db FRESH_WATER 	; removed to avoid plot skippings
;	db SODA_POP 	; removed to avoid plot skippings
;	db LEMONADE 	; removed to avoid plot skippings
	db X_ATTACK
	db X_DEFEND
	db X_SPEED
	db X_SPECIAL
	db PP_UP
	db ETHER
	db MAX_ETHER
	db ELIXER
	db MAX_ELIXER
	db MEGA_STONE_X
	db MEGA_STONE_Y
	db SUN_STONE
	db ICE_STONE
	db KINGS_ROCK
	db METAL_COAT
	db UPGRADE
	db DUBIOUS_DISK
	db FAST_BALL
	db HEAVY_BALL
	db LEGEND_CANDY
	db BIG_NUGGET
	db PERFECTER
;	db LIGHT_BALL	; removed to preserve specialness
	db CHROMOGENE
	db GUTSCHEIN
	db ONIGIRI_BOX
	db OLD_AMBER
	db DOME_FOSSIL
	db HELIX_FOSSIL
	db -1

LockedItems:
	db SECRET_KEY
	db CARD_KEY
	db GOLD_TEETH
	db SILPH_SCOPE
	db LIFT_KEY
	db LIGHT_BALL	; added to preserve specialness
	db CHEAT_CANDY
	db LAVA_STONE    ; to ensure birbs can be unlocked
	db MAGMA_STONE   ; to ensure birbs can be unlocked
	db MOLTEN_STONE  ; to ensure birbs can be unlocked
	db -1
