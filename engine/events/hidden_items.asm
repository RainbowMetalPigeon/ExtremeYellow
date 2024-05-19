HiddenItems:
	ld hl, HiddenItemCoords
	call FindHiddenItemOrCoinsIndex
	ld [wHiddenItemOrCoinsIndex], a
	ld hl, wObtainedHiddenItemsFlags
	ld a, [wHiddenItemOrCoinsIndex]
	ld c, a
	ld b, FLAG_TEST
	predef FlagActionPredef
	ld a, c
	and a
	jr nz, .itemAlreadyFound
	call EnableAutoTextBoxDrawing
	ld a, 1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld a, [wHiddenObjectFunctionArgument] ; item ID
	ld [wd11e], a
	call GetItemName
	tx_pre_jump FoundHiddenItemText

.itemAlreadyFound
	ld a, $ff
	ldh [hItemAlreadyFound], a
	ret

INCLUDE "data/events/hidden_item_coords.asm"

FoundHiddenItemText::
	text_far _FoundHiddenItemText
	text_asm
	ld a, [wHiddenObjectFunctionArgument] ; item ID
	ld b, a
	ld c, 1
	call GiveItem
	jr nc, .bagFull
	ld hl, wObtainedHiddenItemsFlags
	ld a, [wHiddenItemOrCoinsIndex]
	ld c, a
	ld b, FLAG_SET
	predef FlagActionPredef
	ld a, SFX_GET_ITEM_2
	call PlaySoundWaitForCurrent
	call WaitForSoundToFinish
	jp TextScriptEnd
.bagFull
	call WaitForTextScrollButtonPress ; wait for button press
	xor a
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, HiddenItemBagFullText
	call PrintText
	jp TextScriptEnd

HiddenItemBagFullText::
	text_far _HiddenItemBagFullText
	text_end

HiddenCoins:
	ld b, COIN_CASE
	predef GetQuantityOfItemInBag
	ld a, b
	and a
	jr z, .doNotPickUpCoins
	ld hl, HiddenCoinCoords
	call FindHiddenItemOrCoinsIndex
	ld [wHiddenItemOrCoinsIndex], a
	ld hl, wObtainedHiddenCoinsFlags
	ld a, [wHiddenItemOrCoinsIndex]
	ld c, a
	ld b, FLAG_TEST
	predef FlagActionPredef
	ld a, c
	and a
	jr nz, .doNotPickUpCoins
	xor a
	ldh [hUnusedCoinsByte], a
	ldh [hCoins], a
	ldh [hCoins + 1], a
	ld a, [wHiddenObjectFunctionArgument]
	sub COIN
	cp 10
	jr z, .bcd10
	cp 20
	jr z, .bcd20
	cp 40
	jr z, .bcd20 ; should be bcd40
	jr .bcd100

.doNotPickUpCoins
	ld a, $ff
	ldh [hItemAlreadyFound], a
	ret

.bcd10
	ld a, $10
	ldh [hCoins + 1], a
	jr .bcdDone
.bcd20
	ld a, $20
	ldh [hCoins + 1], a
	jr .bcdDone
.bcd40 ; due to a typo, this is never used
	ld a, $40
	ldh [hCoins + 1], a
	jr .bcdDone
.bcd100
	ld a, $1
	ldh [hCoins], a
.bcdDone
	ld de, wPlayerCoins + 1
	ld hl, hCoins + 1
	ld c, $2
	predef AddBCDPredef
	ld hl, wObtainedHiddenCoinsFlags
	ld a, [wHiddenItemOrCoinsIndex]
	ld c, a
	ld b, FLAG_SET
	predef FlagActionPredef
	call EnableAutoTextBoxDrawing
	ld a, [wPlayerCoins]
	cp $99
	jr nz, .roomInCoinCase
	ld a, [wPlayerCoins + 1]
	cp $99
	jr nz, .roomInCoinCase
	tx_pre_id DroppedHiddenCoinsText
	jr .done
.roomInCoinCase
	tx_pre_id FoundHiddenCoinsText
.done
	jp PrintPredefTextID

INCLUDE "data/events/hidden_coins.asm"

FoundHiddenCoinsText::
	text_far _FoundHiddenCoinsText
	sound_get_item_2
	text_end

DroppedHiddenCoinsText::
	text_far _FoundHiddenCoins2Text
	sound_get_item_2
	text_far _DroppedHiddenCoinsText
	text_end

FindHiddenItemOrCoinsIndex:
	ld a, [wHiddenObjectY]
	ld d, a
	ld a, [wHiddenObjectX]
	ld e, a
	ld a, [wCurMap]
	ld b, a
	ld c, -1
.loop
	inc c
	ld a, [hli]
	cp -1 ; end of the list?
	ret z  ; if so, we're done here
	cp b
	jr nz, .next1
	ld a, [hli]
	cp d
	jr nz, .next2
	ld a, [hli]
	cp e
	jr nz, .loop
	ld a, c
	ret
.next1
	inc hl
.next2
	inc hl
	jr .loop

; ==============================================================================

CheckIfMegaStonesHaveAllBeenFound:: ; new
; z flag if not all stones found, nz if all found
	CheckEvent EVENT_GOT_FUJI_MEGA_STONE_X
	ret z
; 1
	ld a, OBSIDIAN_MINES
	ld b, a  ; MAP
	ld e, 24 ; X
	ld d, 30  ; Y
	call CheckIfSpecificHiddenItemHasBeenFound
	ret z
; 2
	ld a, OCHRE_WONDERLAND
	ld b, a  ; MAP
	ld e, 56 ; X
	ld d, 21  ; Y
	call CheckIfSpecificHiddenItemHasBeenFound
	ret z
; 3
	ld a, PALLET_TOWN
	ld b, a  ; MAP
	ld e, 5 ; X
	ld d, 11  ; Y
	call CheckIfSpecificHiddenItemHasBeenFound
	ret z
; 4
	ld a, SECLUDED_ATOLL_SW
	ld b, a  ; MAP
	ld e, 42 ; X
	ld d, 16  ; Y
	call CheckIfSpecificHiddenItemHasBeenFound
	ret z
; 5
	ld a, CINNABAR_ISLAND
	ld b, a  ; MAP
	ld e, 19 ; X
	ld d, 12  ; Y
	call CheckIfSpecificHiddenItemHasBeenFound
	ret

CheckIfSpecificHiddenItemHasBeenFound:: ; new
; inputs: d: Y, e: X, b: MAP
; output: nz flag if found, z if not
	ld hl, HiddenItemCoords ; MAP, Y, X (but they are written as X, Y, as hidden_item loads \1, \3, \2, trickster!)
	ld c, -1
.loop ; results: a: index; c flag not in list
	inc c
	ld a, [hli]
	cp -1 ; end of the list?
	jr z, .failed
; actual comparisons
	cp b ; MAP
	jr nz, .next1
	ld a, [hli]
	cp d ; Y
	jr nz, .next2
	ld a, [hli]
	cp e ; X
	jr nz, .loop
	ld a, c
	jr .exitLoop
; enders
.next1
	inc hl
.next2
	inc hl
	jr .loop
.exitLoop
; check if the item, which we now know exists, has been found already or not
	ld [wHiddenItemOrCoinsIndex], a
	ld hl, wObtainedHiddenItemsFlags
	ld a, [wHiddenItemOrCoinsIndex]
	ld c, a
	ld b, FLAG_TEST
	predef FlagActionPredef
	ld a, c
	and a
	ret ; with the z/nz flag already set
.failed
	xor a ; to make a=0
	xor a ; sets z flag
	ret
