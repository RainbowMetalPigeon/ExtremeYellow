SmartSelectButton::
; SELECT was pressed

; rod: super -> good -> old
    callfar FishingInit ; c=cannot fish; nc=can fish
    jr c, .cannotFish
	lb bc, 5, MAGIKARP
	ld d, $1 ; set bite
	jpfar PreRodResponse

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
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, wd730
	set 6, [hl]
	call GBPalWhiteOutWithDelay3
	xor a
	ldh [hWY], a
	inc a
	ldh [hAutoBGTransferEnabled], a
	call LoadFontTilePatterns
	farcall DisplayTownMap
	ld hl, wd730
	res 6, [hl]
	ld de, TextScriptEnd
	push de
	ldh a, [hLoadedROMBank]
	push af
    jp EnterMap

; else?
    ret
