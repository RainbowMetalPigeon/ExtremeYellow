WarpScriptToKanto:: ; testing
	ld a, VERMILION_DOCK
	ld [wd72d], a
	ld c, 20
	call DelayFrames
	ld hl, wd732
	res 1, [hl]
	ld a, [wDefaultMap]
	ld [wDestinationMap], a
	ld a, VERMILION_CITY
	ld [wLastMap], a
	call GBFadeOutToBlack
;	ld a, SPRITE_FACING_UP
;	ld [wSpritePlayerStateData1FacingDirection], a
	callfar SpecialWarpIn
	ld c, 20
	call DelayFrames
	ResetEvent EVENT_IN_SEVII
	xor a
	ld [wOriginallyInKantoOrSevii], a ; 0=Kanto, 1=Sevii
	ld a, 0
	ld [wCurMapScript], a
	jpfar SpecialEnterMap

; ----------------------------------------------

PerformFerryWarp::
	ld a, [wUniQuizAnswer]
	cp FERRY_VERMILION
	jp z, WarpScriptToKanto
; non-special warp
	cp FERRY_SEVII_TWO
	jr z, .two
	cp FERRY_SEVII_THREE
	jr z, .three
	cp FERRY_SEVII_FOUR
	jr z, .four
	cp FERRY_SEVII_FIVE
	jr z, .five
	cp FERRY_SEVII_SIX
	jr z, .six
	cp FERRY_SEVII_SEVEN
	jr z, .seven
	cp FERRY_SEVII_EIGHT
	jr z, .eight
;.one
	ld a, SEVII_ONE_ISLAND_DOCK
	ldh [hWarpDestinationMap], a
	ld a, SEVII_ONE_ISLAND_CITY
	ld [wLastMap], a
	jr .commondWarpCode
.two
	ld a, SEVII_TWO_ISLAND_DOCK
	ldh [hWarpDestinationMap], a
	ld a, SEVII_TWO_ISLAND_CITY
	ld [wLastMap], a
	jr .commondWarpCode
.three
	ld a, SEVII_THREE_ISLAND_DOCK
	ldh [hWarpDestinationMap], a
	ld a, SEVII_THREE_ISLAND_CITY
	ld [wLastMap], a
	jr .commondWarpCode
.four
	ld a, SEVII_FOUR_ISLAND_DOCK
	ldh [hWarpDestinationMap], a
	ld a, SEVII_FOUR_ISLAND_CITY
	ld [wLastMap], a
	jr .commondWarpCode
.five
	ld a, SEVII_FIVE_ISLAND_DOCK
	ldh [hWarpDestinationMap], a
	ld a, SEVII_FIVE_ISLAND_CITY
	ld [wLastMap], a
	jr .commondWarpCode
.six
	ld a, SEVII_SIX_ISLAND_DOCK
	ldh [hWarpDestinationMap], a
	ld a, SEVII_SIX_ISLAND_CITY
	ld [wLastMap], a
	jr .commondWarpCode
.seven
	ld a, SEVII_SEVEN_ISLAND_DOCK
	ldh [hWarpDestinationMap], a
	ld a, SEVII_SEVEN_ISLAND_CITY
	ld [wLastMap], a
	jr .commondWarpCode
.eight
	ld a, SEVII_EIGHT_ISLAND_DOCK
	ldh [hWarpDestinationMap], a
	ld a, SEVII_EIGHT_ISLAND_CITY
	ld [wLastMap], a
.commondWarpCode
	ld a, 1
	ld [wDestinationWarpID], a
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, SPRITE_FACING_DOWN
	ld [wSpritePlayerStateData1FacingDirection], a
	ld hl, wd72d
	set 3, [hl] ; do scripted warp
	ld a, $0
	ld [wCurMapScript], a	
	ret