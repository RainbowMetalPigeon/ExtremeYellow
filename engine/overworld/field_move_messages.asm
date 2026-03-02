PrintStrengthTxt:
	ld hl, wd728
	set 0, [hl]
	ld hl, UsedStrengthText
	call PrintText
	ld hl, CanMoveBouldersText
	jp PrintText

UsedStrengthText:
	text_far _UsedStrengthText
	text_asm
	ld a, [wcf91]
	call PlayCry
	call Delay3
	jp TextScriptEnd

CanMoveBouldersText:
	text_far _CanMoveBouldersText
	text_end

IsSurfingAllowed:
; Returns whether surfing is allowed in bit 1 of wd728.
; Surfing isn't allowed on the Cycling Road or in the lowest level of the
; Seafoam Islands before the current has been slowed with boulders.
	ld hl, wd728
	set 1, [hl]
	ld a, [wd732]
	bit 5, a
	jr nz, .forcedToRideBike
	ld a, [wCurMap]
	cp SEAFOAM_ISLANDS_B4F
	ret nz
	CheckBothEventsSet EVENT_SEAFOAM4_BOULDER1_DOWN_HOLE, EVENT_SEAFOAM4_BOULDER2_DOWN_HOLE
	ret z
	ld hl, SeafoamIslandsB4FStairsCoords
	call ArePlayerCoordsInArray
	ret nc
	ld hl, wd728
	res 1, [hl]
	ld hl, CurrentTooFastText
	jp PrintText
.forcedToRideBike
	ld hl, wd728
	res 1, [hl]
	ld hl, CyclingIsFunText
	jp PrintText

SeafoamIslandsB4FStairsCoords:
	dbmapcoord  7, 11
	db -1 ; end

CurrentTooFastText:
	text_far _CurrentTooFastText
	text_end

CyclingIsFunText:
	text_far _CyclingIsFunText
	text_end

; new ===============================================

IsDivingAllowed:
	ld a, [wCurMapTileset]
	cp UNDERWATER
	jr z, .underwater
	cp OVERWORLD
	jr z, .overworld
	cp OVERWORLD_SEVII
	jr nz, .notAllowed
.overworld
	ld a, 1
	ld [wMultipurposeTemporaryStorage2], a
	ld a, [wTilePlayerStandingOn]
	cp $45
	jr .doTileComparison
.underwater
	ld a, 2
	ld [wMultipurposeTemporaryStorage2], a
	ld a, [wTilePlayerStandingOn]
	cp $32
.doTileComparison
	jr nz, .notAllowed
; Dive allowed
	ret
.notAllowed
	xor a
	ld [wMultipurposeTemporaryStorage2], a
	ret

; -------------------------------------

UsedWhirlpool::
	xor a
	ld [wActionResultOrTookBattleTurn], a
; check if we can use Whirlpool
	ld a, [wCurMapTileset]
	cp OVERWORLD_SEVII
	jr nz, .cannotUseWhirpool
; we're in a (the only) tileset with whirlpools
	ld a, [wTileInFrontOfPlayer]
	cp $20 ; SW whirlpool tile
	jr z, .canUseWhirpool
.cannotUseWhirpool
	ld hl, CannotUseWhirpoolText
	jp PrintText
.canUseWhirpool
; we can use Whirlpool
	ld a, 1
	ld [wActionResultOrTookBattleTurn], a ; used move
	ld a, [wWhichPokemon]
	ld hl, wPartyMonNicks
	call GetPartyMonName
	ld hl, wd730
	set 6, [hl]
	call GBPalWhiteOutWithDelay3
	call ClearSprites
	call RestoreScreenTilesAndReloadTilePatterns
	call ReloadMapData ; new, to expand tileset (is it even necessary?)
	ld a, SCREEN_HEIGHT_PX
	ldh [hWY], a
	call Delay3
	call LoadGBPal
	call LoadCurrentMapView
	call SaveScreenTilesToBuffer2
	call Delay3
	xor a
	ldh [hWY], a
	ld hl, UsedWhirlpoolText2
	call PrintText
	call LoadScreenTilesFromBuffer2
	ld hl, wd730
	res 6, [hl]
	ld a, $ff
	ld [wUpdateSpritesEnabled], a
	ld de, UndoWhirlpoolBlockSwaps
	callfar ReplaceTreeTileBlock
	callfar RedrawMapView
	ld a, $1
	ld [wUpdateSpritesEnabled], a
	ld a, SFX_SHRINK
	call PlaySound
	ld a, $90
	ldh [hWY], a
	call UpdateSprites
	jpfar RedrawMapView

UsedWhirlpoolText2:
	text_far _UsedWhirlpoolText2
	text_end

CannotUseWhirpoolText:
	text_far _CannotUseWhirpoolText
	text_end

; -------------------------------------

UsedWaterfall::
	xor a
	ld [wActionResultOrTookBattleTurn], a
; check if we can use Waterfall
	ld a, [wCurMapTileset]
	cp CAVERN ; waterfalls exists only in caverns
	jr nz, .cannotUseWaterfall
	ld a, [wTileInFrontOfPlayer]
	cp $50
	jr z, .canUseWaterfall
.cannotUseWaterfall
	ld hl, CannotUseWaterfallText
	jp PrintText
.canUseWaterfall
	ld a, 1
	ld [wActionResultOrTookBattleTurn], a ; used move
	ld a, [wWhichPokemon]
	ld hl, wPartyMonNicks
	call GetPartyMonName
	ld hl, wd730
	set 6, [hl]
	call GBPalWhiteOutWithDelay3
	call ClearSprites
	call RestoreScreenTilesAndReloadTilePatterns
	call ReloadMapData ; new, to expand tileset (is it even necessary?)
	ld a, SCREEN_HEIGHT_PX
	ldh [hWY], a
	call Delay3
	call LoadGBPal
	call LoadCurrentMapView
	call SaveScreenTilesToBuffer2
	call Delay3
	xor a
	ldh [hWY], a
	ld hl, UsedWaterfallText2
	call PrintText
	call LoadScreenTilesFromBuffer2
	ld hl, wd730
	res 6, [hl]
	jpfar RideWaterfallCore

UsedWaterfallText2:
	text_far _UsedWaterfallText2
	text_end

CannotUseWaterfallText:
	text_far _CannotUseWaterfallText
	text_end
