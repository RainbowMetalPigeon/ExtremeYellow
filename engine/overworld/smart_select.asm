SmartSelectButton:: ; SELECT was pressed

; open Coin Case only if we're in the casino
    CheckEvent EVENT_IN_SEVII
    jr nz, .cannotCoinCase
    ld a, [wCurMap]
    cp GAME_CORNER
    jr nz, .cannotCoinCase
	ld b, COIN_CASE
	call IsItemInBag
    jr z, .cannotCoinCase
    call EnableAutoTextBoxDrawing
    tx_pre_jump CoinCaseNumCoinsText2

.cannotCoinCase
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
	call LoadTextBoxTilePatterns
	call CloseTextDisplay
	call InitMapSprites
	jp UpdateSprites

PlayerStartsFishing::
    text_far _PlayerStartsFishing
    text_end

_PlayerStartsFishing::
    text "<PLAYER> starts"
    line "fishing!"
;   xxxx "123456789012345678"
    done

CoinCaseNumCoinsText2::
	text_far _CoinCaseNumCoinsText2
	text_end

_CoinCaseNumCoinsText2::
	text "Coins"
	line "@"
	text_bcd wPlayerCoins, 2 | LEADING_ZEROES | LEFT_ALIGN
	text " "
	done
