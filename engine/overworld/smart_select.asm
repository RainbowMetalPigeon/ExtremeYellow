SmartSelectButton:: ; SELECT was pressed

; rod: super -> good -> old
	callfar IsNextTileShoreOrWater
	jr nc, .cannotFish
	ld a, [wWalkBikeSurfState]
	cp 2 ; Surfing?
	jr z, .cannotFish
; do we have a rod?
	ld b, OLD_ROD
	call IsItemInBag
    jr nz, .canFish
	ld b, GOOD_ROD
	call IsItemInBag
    jr nz, .canFish
	ld b, SUPER_ROD
	call IsItemInBag
    jr z, .cannotFish
.canFish
    call EnableAutoTextBoxDrawing
    tx_pre PlayerStartsFishing
	ld a, SFX_HEAL_AILMENT
	call PlaySound
	ld a, $2
	ld [wd49c], a
	ld a, $81
	ld [wPikachuMood], a
	ld c, 10 ; edited, was 80
	call DelayFrames
    SetEvent EVENT_SKIP_PRINTING_WHEN_FISHING
; determine what we fished, if anything
	ld b, SUPER_ROD
	call IsItemInBag
    jr nz, .useRodSuper
	ld b, GOOD_ROD
	call IsItemInBag
    jr nz, .useRodGood
; use Rod Old
    callfar ItemUseOldRodFar
    jr .reloadPlayerGraphic
.useRodGood
    callfar ItemUseGoodRod.RandomLoop
    jr .reloadPlayerGraphic
.useRodSuper
    callfar ItemUseSuperRodFar
.reloadPlayerGraphic
    jp LoadPlayerSpriteGraphics

.cannotFish
; bike
	ld b, BICYCLE
	call IsItemInBag
    jr z, .cannotBike
	call IsBikeRidingAllowed
	jr nc, .cannotBike
    ld a, [wWalkBikeSurfState]
    cp 2
    jr nc, .cannotBike
; we can bike: check if we are getting up or down
    and a
    jr z, .getOnBike
; getOffBike
	ld a, [wd732]
	bit 5, a ; if set, we are forced to bike
    jr nz, .cannotBike
    call LoadWalkingPlayerSpriteGraphics
    xor a
    jr .commonBikeCode
.getOnBike
    call LoadBikePlayerSpriteGraphics
	ld a, $1
.commonBikeCode
	ld [wWalkBikeSurfState], a ; change player state
	ld [wWalkBikeSurfStateCopy], a
	xor a ; no keys pressed
	ldh [hJoyHeld], a ; current joypad state
	call PlayDefaultMusic ; play music
    ret

.cannotBike
; town map
	ld b, TOWN_MAP
	call IsItemInBag
    ret z
; we have the map
	call GBPalWhiteOutWithDelay3
	xor a
	ldh [hWY], a
	inc a
	ldh [hAutoBGTransferEnabled], a
	call LoadFontTilePatterns
	farcall DisplayTownMap
    jp EnterMap

PlayerStartsFishing::
    text_far _PlayerStartsFishing
    text_end

_PlayerStartsFishing::
    text "<PLAYER> starts"
    line "fishing!"
;   xxxx "123456789012345678"
    done
