VermilionDock_Script:
	call EnableAutoTextBoxDrawing
; new
	CheckAndResetEvent EVENT_MARK_TO_WALK_OUTSIDE_VERMILION_DOCK
	jr nz, .walkOutOfVermilionDock
	CheckEvent EVENT_VERMILION_DOCK_AUTOWALKING_SEVII_FERRY_IN_DOCK
	jp nz, .walkingTowardsSeviiFerry
	CheckAndResetEvent EVENT_VERMILION_DOCK_AUTOWALKING_SEVII_FERRY
	jr z, .noSeviiFerry
; we just entered the map and we are walking towards the Sevii Ferry
	SetEvent EVENT_VERMILION_DOCK_AUTOWALKING_SEVII_FERRY_IN_DOCK
	call Delay3
	ld hl, wd730
	set 7, [hl]
	ld hl, wSimulatedJoypadStatesEnd
	ld a, D_DOWN
	ld [hli], a
	ld [hl], a
	ld a, 2
	ld [wSimulatedJoypadStatesIndex], a
	xor a
	ld [wSpritePlayerStateData2MovementByte1], a
	ld [wOverrideSimulatedJoypadStatesMask], a
	dec a
	ld [wJoyIgnore], a
	ret
.noSeviiFerry
; BTV
	CheckEventHL EVENT_STARTED_WALKING_OUT_OF_DOCK
	jr nz, .walking_out_of_dock
	CheckEvent EVENT_BEAT_CHAMPION_FINAL_REMATCH ; new
	ret nz ; new
	CheckEventReuseHL EVENT_GOT_HM01
	ret z
	ld a, [wDestinationWarpID]
	cp $1
	ret nz
	CheckEventReuseHL EVENT_SS_ANNE_LEFT
	jp z, VermilionDockSSAnneLeavesScript
.walkOutOfVermilionDock ; new
; show Pikachu, if present
	call CheckPikachuFollowingPlayer
	jr nz, .notFollowingPikachu0
	ld a, $1
	ld [wPikachuSpawnState], a
	call EnablePikachuOverworldSpriteDrawing
.notFollowingPikachu0
	SetEventReuseHL EVENT_STARTED_WALKING_OUT_OF_DOCK
	call Delay3
	ld hl, wd730
	set 7, [hl]
	ld hl, wSimulatedJoypadStatesEnd
	ld a, D_UP
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld a, $3
	ld [wSimulatedJoypadStatesIndex], a
	xor a
	ld [wSpritePlayerStateData2MovementByte1], a
	ld [wOverrideSimulatedJoypadStatesMask], a
	dec a
	ld [wJoyIgnore], a
	ret
.walking_out_of_dock
	CheckEventAfterBranchReuseHL EVENT_WALKED_OUT_OF_DOCK, EVENT_STARTED_WALKING_OUT_OF_DOCK
	ret nz
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	ld [wJoyIgnore], a
	SetEventReuseHL EVENT_WALKED_OUT_OF_DOCK
	ret
.walkingTowardsSeviiFerry ; new
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	ld [wJoyIgnore], a
; hide player and Pikachu
	call CheckPikachuFollowingPlayer
	jr nz, .notFollowingPikachu
	call DisablePikachuOverworldSpriteDrawing
.notFollowingPikachu
	call LoadTransparentPlayerSpriteGraphics
	ld a, SFX_GO_INSIDE
	call PlaySound ; somehow it doesn't work???
	call WaitForSoundToFinish
	jp PerformFerryWarpFromVermilion

VermilionDockSSAnneLeavesScript:
	SetEventForceReuseHL EVENT_SS_ANNE_LEFT
	ld a, $ff
	ld [wJoyIgnore], a
	call StopAllMusic
	ld c, BANK(Music_Surfing)
	ld a, MUSIC_SURFING
	call PlayMusic
	farcall LoadSmokeTileFourTimes
	xor a
	ld [wSpritePlayerStateData1ImageIndex], a
	ld c, 120 ; reduce this to speedup departure
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
	call VermilionDock_EmitSmokePuff
	pop de
	ld b, 16
.smoke_puff_drift_loop
	call VermilionDock_AnimSmokePuffDriftRight
	ld c, 8
.delay_between_drifts
	call VermilionDock_SyncScrollWithLY
	dec c ; double this and the other two to speed up the departure
	jr nz, .delay_between_drifts
	inc d ; double this and the other two to speed up the departure
	dec b ; double this and the other two to speed up the departure
	jr nz, .smoke_puff_drift_loop
	pop bc
	dec e
	jr nz, .shift_columns_up
	xor a
	ldh [rWY], a
	ldh [hWY], a
	call VermilionDock_EraseSSAnne
	ld a, $90
	ldh [hWY], a
	ld a, $1
	ld [wUpdateSpritesEnabled], a
	pop hl
	pop bc
	ld [hl], b
	dec hl
	ld [hl], c
	call LoadPlayerSpriteGraphics
	ld hl, wNumberOfWarps
	dec [hl]
	ret

VermilionDock_AnimSmokePuffDriftRight:
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

VermilionDock_EmitSmokePuff:
; new smoke puff above the S.S. Anne's front smokestack
	ld a, [wSSAnneSmokeX]
	sub 16
	ld [wSSAnneSmokeX], a
	ld c, a
	ld b, 100 ; Y
	ld a, [wSSAnneSmokeDriftAmount]
	inc a
	ld [wSSAnneSmokeDriftAmount], a
	ld a, $1
	ld de, VermilionDockOAMBlock
	call WriteOAMBlock
	ret

VermilionDockOAMBlock:
	; tile id, attribute
	db $fc, $10
	db $fd, $10
	db $fe, $10
	db $ff, $10

VermilionDock_SyncScrollWithLY:
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

VermilionDock_EraseSSAnne:
; Fill the area the S.S. Anne occupies in BG map 0 with water tiles.
	ld hl, wVermilionDockTileMapBuffer
	ld bc, wVermilionDockTileMapBufferEnd - wVermilionDockTileMapBuffer
	ld a, $14 ; water tile
	call FillMemory
	hlbgcoord 0, 10
	ld de, wVermilionDockTileMapBuffer
	lb bc, BANK(wVermilionDockTileMapBuffer), 12
	call CopyVideoData

; Replace the blocks of the lower half of the ship with water blocks. This
; leaves the upper half alone, but that doesn't matter because replacing any of
; the blocks is unnecessary because the blocks the ship occupies are south of
; the player and won't be redrawn when the player automatically walks north and
; exits the map. This code could be removed without affecting anything.
	hlowcoord 5, 2, VERMILION_DOCK_WIDTH
	ld a, $d ; water block
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a

	ld a, SFX_SS_ANNE_HORN
	call PlaySound
	ld c, 120 ; reduce this to speedup departure
	call DelayFrames
	ret

VermilionDock_TextPointers:
	dw VermilionDockText1

VermilionDockText1:
	text_asm
	ld hl, VermilionDockNoteText
	call PrintText
	; let's make PIGEON appear in Celadon
	ld a, HS_CELADON_MANSION_PIGEON
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	jp TextScriptEnd

VermilionDockNoteText: ; new
	text_far _VermilionDockNoteText
	text_end

; special ferry warp to sevii ---------------------------------

PerformFerryWarpFromVermilion::
	callfar SeviiDockFerryLeavesScript
; determine destination
	ld a, [wUniQuizAnswer]
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
	ld d, SEVII_ONE_ISLAND_DOCK
	ld e, SEVII_ONE_ISLAND_CITY
	jr VermilionWarpToSevii
.two
	ld d, SEVII_TWO_ISLAND_DOCK
	ld e, SEVII_TWO_ISLAND_CITY
	jr VermilionWarpToSevii
.three
	ld d, SEVII_THREE_ISLAND_DOCK
	ld e, SEVII_THREE_ISLAND_CITY
	jr VermilionWarpToSevii
.four
	ld d, SEVII_FOUR_ISLAND_DOCK
	ld e, SEVII_FOUR_ISLAND_CITY
	jr VermilionWarpToSevii
.five
	ld d, SEVII_FIVE_ISLAND_DOCK
	ld e, SEVII_FIVE_ISLAND_CITY
	jr VermilionWarpToSevii
.six
	ld d, SEVII_SIX_ISLAND_DOCK
	ld e, SEVII_SIX_ISLAND_CITY
	jr VermilionWarpToSevii
.seven
	ld d, SEVII_SEVEN_ISLAND_DOCK
	ld e, SEVII_SEVEN_ISLAND_CITY
	jr VermilionWarpToSevii
.eight
	ld d, SEVII_EIGHT_ISLAND_DOCK
	ld e, SEVII_EIGHT_ISLAND_CITY
	; fallthrough
VermilionWarpToSevii::
	ld a, d
	ld [wd72d], a
	ld a, e
	ld [wLastMap], a
	ld c, 20
	call DelayFrames
	ld hl, wd732
	res 1, [hl]
	ld a, [wDefaultMap]
	ld [wDestinationMap], a
	call GBFadeOutToBlack
	callfar SpecialWarpIn
	ld c, 20
	call DelayFrames
	SetEvent EVENT_IN_SEVII
	ld a, 1
	ld [wOriginallyInKantoOrSevii], a ; 0=Kanto, 1=Sevii
	ld a, 4
	ld [wCurMapScript], a
	ResetEvent EVENT_VERMILION_DOCK_AUTOWALKING_SEVII_FERRY
	ResetEvent EVENT_VERMILION_DOCK_AUTOWALKING_SEVII_FERRY_IN_DOCK
	jpfar SpecialEnterMap
