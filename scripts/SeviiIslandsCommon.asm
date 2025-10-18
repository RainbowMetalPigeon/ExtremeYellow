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
	call SeviiDockFerryLeavesScript

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
	SetEvent EVENT_TRAVELING_WITH_FERRY
	ld a, 1 ; -1 wrt the normal numbering
	ld [wDestinationWarpID], a
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, SPRITE_FACING_UP
	ld [wSpritePlayerStateData1FacingDirection], a
	ld hl, wd72d
	set 3, [hl] ; do scripted warp
	ld a, $0
	ld [wCurMapScript], a
	ret

; ---------------------------------------------- to depart the ferry

SeviiDockFerryLeavesScript::
	ld a, $ff
	ld [wJoyIgnore], a
	call StopAllMusic
	ld c, BANK(Music_Surfing)
	ld a, MUSIC_SURFING
	call PlayMusic
	farcall LoadSmokeTileFourTimes
	xor a
	ld [wSpritePlayerStateData1ImageIndex], a
	ld c, 30 ; reduce this to speedup departure
	call DelayFrames
	ld b, $9c
	call CopyScreenTileBufferToVRAM
	hlcoord 0, 10
	ld bc, SCREEN_WIDTH * 6
	ld a, $14 ; water tile
	call FillMemory
	ld a, 1
	ldh [hAutoBGTransferEnabled], a
	call Delay3
	xor a
	ldh [hAutoBGTransferEnabled], a
	ld [wSSAnneSmokeDriftAmount], a
	ldh [rOBP1], a
	call UpdateGBCPal_OBP1
	ld a, 88
	ld [wSSAnneSmokeX], a
	ld hl, wMapViewVRAMPointer
	ld c, [hl]
	inc hl
	ld b, [hl]
	push bc
	push hl
	ld a, SFX_SS_ANNE_HORN
	call PlaySoundWaitForCurrent
	ld a, $ff
	ld [wUpdateSpritesEnabled], a
	ld d, $0
	ld e, $8
.shift_columns_up
	ld hl, $2
	add hl, bc
	ld a, l
	ld [wMapViewVRAMPointer], a
	ld a, h
	ld [wMapViewVRAMPointer + 1], a
	push hl
	push de
	call ScheduleEastColumnRedraw
	call SeviiDock_EmitSmokePuff
	pop de
	ld b, 4 ; halve this and the other and double "inc d" to speed up departure
.smoke_puff_drift_loop
	call SeviiDock_AnimSmokePuffDriftRight
	ld c, 2
.delay_between_drifts
	call SeviiDock_SyncScrollWithLY
	dec c ; halve this and the other and double "inc d" to speed up departure
	jr nz, .delay_between_drifts
	inc d ; double this and the do the other two to speed up the departure
	inc d
	inc d
	inc d
	dec b
	jr nz, .smoke_puff_drift_loop
	pop bc
	dec e
	jr nz, .shift_columns_up
	xor a
	ldh [rWY], a
	ldh [hWY], a

	pop hl
	pop bc

/*
	call ShowSeviiDockSailors
	call SeviiDock_EraseFerry
	ld a, $90
	ldh [hWY], a
	ld a, $1
	ld [wUpdateSpritesEnabled], a
	ld [hl], b
	dec hl
	ld [hl], c
	call LoadPlayerSpriteGraphics
; show Pikachu, if present
	call CheckPikachuFollowingPlayer
	jr nz, .notFollowingPikachu
	ld a, $1
	ld [wPikachuSpawnState], a
	call EnablePikachuOverworldSpriteDrawing
.notFollowingPikachu
	ld hl, wNumberOfWarps
	dec [hl]
*/
	ret

SeviiDock_AnimSmokePuffDriftRight:
	push bc
	push de
	ld hl, wShadowOAMSprite04XCoord
	ld a, [wSSAnneSmokeDriftAmount]
	swap a
	ld c, a
	ld de, 4
.loop
	inc [hl]
	inc [hl]
	add hl, de
	dec c
	jr nz, .loop
	pop de
	pop bc
	ret

SeviiDock_EmitSmokePuff:
	ld a, [wSSAnneSmokeX]
	sub 16
	ld [wSSAnneSmokeX], a
	ld c, a
	ld b, 100 ; Y
	ld a, [wSSAnneSmokeDriftAmount]
	inc a
	ld [wSSAnneSmokeDriftAmount], a
	ld a, $1
	ld de, SeviiDockOAMBlock
	call WriteOAMBlock
	ret

SeviiDockOAMBlock:
	; tile id, attribute
	db $fc, $10
	db $fd, $10
	db $fe, $10
	db $ff, $10

SeviiDock_SyncScrollWithLY:
	ld h, d
	ld l, $50
	call .sync_scroll_ly
	ld h, $0
	ld l, $80
.sync_scroll_ly
	ldh a, [rLY]
	cp l
	jr nz, .sync_scroll_ly
	ld a, h
	ldh [rSCX], a
.wait_for_ly_match
	ldh a, [rLY]
	cp h
	jr z, .wait_for_ly_match
	ret

SeviiDock_EraseFerry:
	ld hl, wVermilionDockTileMapBuffer
	ld bc, wVermilionDockTileMapBufferEnd - wVermilionDockTileMapBuffer
	ld a, $14 ; water tile
	call FillMemory
	hlbgcoord 0, 10
	ld de, wVermilionDockTileMapBuffer
	lb bc, BANK(wVermilionDockTileMapBuffer), 12
	call CopyVideoData

	hlowcoord 5, 2, SEVII_ONE_ISLAND_DOCK_WIDTH ; TBV
	ld a, $d ; water block
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a

	ld a, SFX_SS_ANNE_HORN
	call PlaySound
	ld c, 10 ; reduce this to speedup departure
	call DelayFrames
	ret

ShowSeviiDockSailors::
	ld hl, SeviiDocksSailorsToHideOrShow
.showSailorsLoop
	ld a, [hli]
	cp $ff ; have we run out of sailors to handle?
	ret z ; if so, we're done here
	push hl
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	pop hl
	jr .showSailorsLoop

HideSeviiDockSailors::
	ld hl, SeviiDocksSailorsToHideOrShow
.showSailorsLoop
	ld a, [hli]
	cp $ff ; have we run out of sailors to handle?
	ret z ; if so, we're done here
	push hl
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	pop hl
	jr .showSailorsLoop

SeviiDocksSailorsToHideOrShow:
	db HS_SEVII_ONE_ISLAND_DOCK_SAILOR
	db HS_SEVII_TWO_ISLAND_DOCK_SAILOR
	db HS_SEVII_THREE_ISLAND_DOCK_SAILOR
	db HS_SEVII_FOUR_ISLAND_DOCK_SAILOR
	db HS_SEVII_FIVE_ISLAND_DOCK_SAILOR
	db HS_SEVII_SIX_ISLAND_DOCK_SAILOR
	db HS_SEVII_SEVEN_ISLAND_DOCK_SAILOR
	db HS_SEVII_EIGHT_ISLAND_DOCK_SAILOR
	db $FF

; ----------------------------------------------

; input: d = sprite index, e = sprite facing
ChangeSpriteFacing::
	ld a, d
	ldh [hSpriteIndex], a
	ld a, e
	ldh [hSpriteFacingDirection], a
	jp SetSpriteFacingDirectionAndDelay
