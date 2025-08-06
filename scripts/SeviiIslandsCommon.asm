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
