; only used for setting bit 2 of wd736 upon entering a new map
IsPlayerStandingOnWarp::
	ld a, [wNumberOfWarps]
	and a
	ret z
	ld c, a
	ld hl, wWarpEntries
.loop
	ld a, [wYCoord]
	cp [hl]
	jr nz, .nextWarp1
	inc hl
	ld a, [wXCoord]
	cp [hl]
	jr nz, .nextWarp2
	inc hl
	ld a, [hli] ; target warp
	ld [wDestinationWarpID], a
	ld a, [hl] ; target map
	ldh [hWarpDestinationMap], a
	callfar RandomizeWarpsForHauntedHouse ; new, to handle Haunted House randomizable warps
	ld hl, wd736
	set 2, [hl] ; standing on warp flag
	ret
.nextWarp1
	inc hl
.nextWarp2
	inc hl
	inc hl
	inc hl
	dec c
	jr nz, .loop
	ret

CheckForceBikeOrSurfOrDive:: ; edited
; new for Dive
	CheckAndResetEvent EVENT_DIVE_GO_UNDER
	jr z, .checkReemerging
    ld a, 3
    ld [wWalkBikeSurfState], a
	ld [wWalkBikeSurfStateCopy], a ; ?
	ret
.checkReemerging
	CheckAndResetEvent EVENT_DIVE_GO_ABOVE
	jr nz, .forceSurfing
.vanilla
; BTV
	ld hl, wd732
	bit 5, [hl]
	ret nz
	ld hl, ForcedBikeOrSurfMaps
	ld a, [wYCoord]
	ld b, a
	ld a, [wXCoord]
	ld c, a
	ld a, [wCurMap]
	ld d, a
.loop
	ld a, [hli]
	cp $ff
	ret z ;if we reach FF then it's not part of the list
	cp d ;compare to current map
	jr nz, .incorrectMap
	ld a, [hli]
	cp b ;compare y-coord
	jr nz, .incorrectY
	ld a, [hli]
	cp c ;compare x-coord
	jr nz, .loop ; incorrect x-coord, check next item
	ld a, [wCurMap]
	cp SEAFOAM_ISLANDS_B3F
	ld a, $2
	ld [wSeafoamIslandsB3FCurScript], a
	jr z, .forceSurfing
	ld a, [wCurMap]
	cp SEAFOAM_ISLANDS_B4F
	ld a, $2
	ld [wSeafoamIslandsB4FCurScript], a
	jr z, .forceSurfing
	;force bike riding
	ld hl, wd732
	set 5, [hl]
	ld a, $1
	ld [wWalkBikeSurfState], a
	ld [wWalkBikeSurfStateCopy], a
	call ForceBikeOrSurf
	ret
.incorrectMap
	inc hl
.incorrectY
	inc hl
	jr .loop
.forceSurfing
	ld a, $2
	ld [wWalkBikeSurfState], a
	ld [wWalkBikeSurfStateCopy], a
	call ForceBikeOrSurf
	ret

INCLUDE "data/maps/force_bike_surf.asm"

IsPlayerFacingEdgeOfMap::
	push hl
	push de
	push bc
	ld a, [wSpritePlayerStateData1FacingDirection]
	srl a
	ld c, a
	ld b, $0
	ld hl, .functionPointerTable
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wYCoord]
	ld b, a
	ld a, [wXCoord]
	ld c, a
	ld de, .return
	push de
	jp hl
.return
	pop bc
	pop de
	pop hl
	ret

.functionPointerTable
	dw .facingDown
	dw .facingUp
	dw .facingLeft
	dw .facingRight

.facingDown
	ld a, [wCurMapHeight]
	add a
	dec a
	cp b
	jr z, .setCarry
	jr .resetCarry

.facingUp
	ld a, b
	and a
	jr z, .setCarry
	jr .resetCarry

.facingLeft
	ld a, c
	and a
	jr z, .setCarry
	jr .resetCarry

.facingRight
	ld a, [wCurMapWidth]
	add a
	dec a
	cp c
	jr z, .setCarry
	jr .resetCarry
.resetCarry
	and a
	ret
.setCarry
	scf
	ret

IsWarpTileInFrontOfPlayer::
	push hl
	push de
	push bc
	call _GetTileAndCoordsInFrontOfPlayer
; new for Sevii
	CheckEvent EVENT_IN_SEVII
	jr nz, .sevii
; BTV
	callfar IsCurrentMapHauntedHouse                    ; new
	jp z, IsHauntedHouseExtraWarpTileInFrontOfPlayer    ; new
	ld a, [wCurMap]
	cp SS_ANNE_BOW
	jr z, IsSSAnneBowWarpTileInFrontOfPlayer
	cp CERULEAN_CAVE_EXTRA_TOP							; new
	jp z, IsCeruleanCaveExtraWarpTileInFrontOfPlayer	; new
	cp CERULEAN_CAVE_EXTRA_MIDDLE						; new
	jr z, IsCeruleanCaveExtraWarpTileInFrontOfPlayer	; new
	cp CERULEAN_CAVE_EXTRA_BOTTOM						; new
	jr z, IsCeruleanCaveExtraWarpTileInFrontOfPlayer	; new
	cp CELADON_UNIVERSITY_1 							; new
	jp z, IsCeladonUniversityWarpTileInFrontOfPlayer	; new
	cp CELADON_UNIVERSITY_2								; new
	jr z, IsCeladonUniversityWarpTileInFrontOfPlayer	; new
	cp OBSIDIAN_WAREHOUSE								; new
	jp z, IsObsidianWarehouseWarpTileInFrontOfPlayer	; new
	cp SECLUDED_CAVES									; new
	jr z, IsSecludedCavesWarpTileInFrontOfPlayer		; new
	cp ONIX_BURROWING									; new
	jp z, IsOnixBurrowingWarpTileInFrontOfPlayer		; new
	cp HAUNTED_REDS_HOUSE								; new
	jp z, IsRedsHouseWarpTileInFrontOfPlayer			; new
	cp REDS_HOUSE_1F									; new
	jp z, IsRedsHouseWarpTileInFrontOfPlayer			; new
; new for Sevii
	jr .postMapChecks
.sevii
	ld a, [wCurMap]
	cp SEVII_LOST_CAVE_1
	jr z, IsSeviiLostCaveWarpTileInFrontOfPlayer
	cp SEVII_LOST_CAVE_2
	jr z, IsSeviiLostCaveWarpTileInFrontOfPlayer
	cp SEVII_LOST_CAVE_3
	jr z, IsSeviiLostCaveWarpTileInFrontOfPlayer
	cp SEVII_ROUTE_43_CAVES
	jr z, IsSeviiRoute43CavesWarpTileInFrontOfPlayer
.postMapChecks ; new
	ld a, [wSpritePlayerStateData1FacingDirection]
	srl a
	ld c, a
	ld b, 0
	ld hl, WarpTileListPointers
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wTileInFrontOfPlayer]
	ld de, $1
	call IsInArray
.done
	pop bc
	pop de
	pop hl
	ret

INCLUDE "data/tilesets/warp_carpet_tile_ids.asm"

IsSSAnneBowWarpTileInFrontOfPlayer:
	ld a, [wTileInFrontOfPlayer]
	cp $15
	jr nz, .notSSAnne5Warp
	scf
	jr IsWarpTileInFrontOfPlayer.done
.notSSAnne5Warp
	and a
	jr IsWarpTileInFrontOfPlayer.done

IsSeviiRoute43CavesWarpTileInFrontOfPlayer: ; new
IsSeviiLostCaveWarpTileInFrontOfPlayer: ; new
IsSecludedCavesWarpTileInFrontOfPlayer: ; new
IsCeruleanCaveExtraWarpTileInFrontOfPlayer: ; new
	ld a, [wTileInFrontOfPlayer]
	cp $3C
	jr nz, .notCerulanExtraWarp
	scf
	jr IsWarpTileInFrontOfPlayer.done
.notCerulanExtraWarp
	and a
	jr IsWarpTileInFrontOfPlayer.done

IsCeladonUniversityWarpTileInFrontOfPlayer: ; new
	ld a, [wTileInFrontOfPlayer]
	cp $36
	jr nz, .notUniversityWarp
	scf
	jr IsWarpTileInFrontOfPlayer.done
.notUniversityWarp
	and a
	jr IsWarpTileInFrontOfPlayer.done

IsObsidianWarehouseWarpTileInFrontOfPlayer: ; new
	ld a, [wTileInFrontOfPlayer]
	cp $33
	jr nz, .notWarehouseWarp
	scf
	jr IsWarpTileInFrontOfPlayer.done
.notWarehouseWarp
	and a
	jr IsWarpTileInFrontOfPlayer.done

IsHauntedHouseExtraWarpTileInFrontOfPlayer: ; new
	ld a, [wTileInFrontOfPlayer]
	cp $10
	jr nz, .notHauntedHouseWarp
	scf
	jr IsWarpTileInFrontOfPlayer.done
.notHauntedHouseWarp
	and a
	jr IsWarpTileInFrontOfPlayer.done

IsOnixBurrowingWarpTileInFrontOfPlayer: ; new
	ld a, [wTileInFrontOfPlayer]
	cp $3C ; why in the universe is this even needed?
	jr z, .yesBurrowingWarp
	cp $1C
	jr nz, .notBurrowingWarp
.yesBurrowingWarp
	scf
	jr IsWarpTileInFrontOfPlayer.done
.notBurrowingWarp
	and a
	jr IsWarpTileInFrontOfPlayer.done

IsRedsHouseWarpTileInFrontOfPlayer: ; new
	ld a, [wTileInFrontOfPlayer]
	cp $10
	jr nz, .notHauntedHouseWarp
	scf
	jr IsWarpTileInFrontOfPlayer.done
.notHauntedHouseWarp
	and a
	jr IsWarpTileInFrontOfPlayer.done

IsPlayerStandingOnDoorTileOrWarpTile::
	push hl
	push de
	push bc
	farcall IsPlayerStandingOnDoorTile
	jr c, .done
	ld a, [wCurMapTileset]
	add a
	ld c, a
	ld b, $0
	ld hl, WarpTileIDPointers
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, $1
	lda_coord 8, 9
	call IsInArray
	jr nc, .done
	ld hl, wd736
	res 2, [hl]
.done
	pop bc
	pop de
	pop hl
	ret

INCLUDE "data/tilesets/warp_tile_ids.asm"

PrintSafariZoneSteps::
	ld a, [wCurMap]
	cp SAFARI_ZONE_EAST
	ret c
	cp HAUNTED_HOUSE_1 ; edited, SAFARI_ZONE_SECRET_HOUSE + 1
	ret nc
	hlcoord 0, 0
	lb bc, 3, 7
	call TextBoxBorder
	hlcoord 1, 1
	ld de, wSafariSteps
	lb bc, 2, 3
	call PrintNumber
	hlcoord 4, 1
	ld de, SafariSteps
	call PlaceString
	hlcoord 1, 3
	ld de, SafariBallText
	call PlaceString
	ld a, [wNumSafariBalls]
	cp 10
	jr nc, .tenOrMore
	hlcoord 5, 3
	ld a, " "
	ld [hl], a
.tenOrMore
	hlcoord 6, 3
	ld de, wNumSafariBalls
	lb bc, 1, 2
	jp PrintNumber

SafariSteps:
	db "/500@"

SafariBallText:
	db "BALL×× @"

GetTileAndCoordsInFrontOfPlayer:
	call GetPredefRegisters

_GetTileAndCoordsInFrontOfPlayer:
	ld a, [wYCoord]
	ld d, a
	ld a, [wXCoord]
	ld e, a
	ld a, [wSpritePlayerStateData1FacingDirection]
	and a ; cp SPRITE_FACING_DOWN
	jr nz, .notFacingDown
; facing down
	lda_coord 8, 11
	inc d
	jr .storeTile
.notFacingDown
	cp SPRITE_FACING_UP
	jr nz, .notFacingUp
; facing up
	lda_coord 8, 7
	dec d
	jr .storeTile
.notFacingUp
	cp SPRITE_FACING_LEFT
	jr nz, .notFacingLeft
; facing left
	lda_coord 6, 9
	dec e
	jr .storeTile
.notFacingLeft
	cp SPRITE_FACING_RIGHT
	jr nz, .storeTile
; facing right
	lda_coord 10, 9
	inc e
.storeTile
	ld c, a
	ld [wTileInFrontOfPlayer], a
	ret

GetTileTwoStepsInFrontOfPlayer:
	xor a
	ldh [hPlayerFacing], a
	ld hl, wYCoord
	ld a, [hli]
	ld d, a
	ld e, [hl]
	ld a, [wSpritePlayerStateData1FacingDirection]
	and a ; cp SPRITE_FACING_DOWN
	jr nz, .notFacingDown
; facing down
	ld hl, hPlayerFacing
	set 0, [hl]
	lda_coord 8, 13
	inc d
	jr .storeTile
.notFacingDown
	cp SPRITE_FACING_UP
	jr nz, .notFacingUp
; facing up
	ld hl, hPlayerFacing
	set 1, [hl]
	lda_coord 8, 5
	dec d
	jr .storeTile
.notFacingUp
	cp SPRITE_FACING_LEFT
	jr nz, .notFacingLeft
; facing left
	ld hl, hPlayerFacing
	set 2, [hl]
	lda_coord 4, 9
	dec e
	jr .storeTile
.notFacingLeft
	cp SPRITE_FACING_RIGHT
	jr nz, .storeTile
; facing right
	ld hl, hPlayerFacing
	set 3, [hl]
	lda_coord 12, 9
	inc e
.storeTile
	ld c, a
	ld [wTileInFrontOfBoulderAndBoulderCollisionResult], a
	ld [wTileInFrontOfPlayer], a
	ret

CheckForCollisionWhenPushingBoulder:
	call GetTileTwoStepsInFrontOfPlayer
	call IsTilePassable
	jr c, .done
	ld hl, TilePairCollisionsLand
	call CheckForTilePairCollisions2
	ld a, $ff
	jr c, .done ; if there is an elevation difference between the current tile and the one two steps ahead
	ld a, [wTileInFrontOfBoulderAndBoulderCollisionResult]
	cp $15 ; stairs tile
	ld a, $ff
	jr z, .done ; if the tile two steps ahead is stairs
	call CheckForBoulderCollisionWithSprites
.done
	ld [wTileInFrontOfBoulderAndBoulderCollisionResult], a
	ret

; sets a to $ff if there is a collision and $00 if there is no collision
CheckForBoulderCollisionWithSprites:
	ld a, [wBoulderSpriteIndex]
	dec a
	swap a
	ld d, 0
	ld e, a
	ld hl, wSprite01StateData2MapY
	add hl, de
	ld a, [hli] ; map Y position
	ldh [hPlayerYCoord], a
	ld a, [hl] ; map X position
	ldh [hPlayerXCoord], a
	ld a, [wNumSprites]
	ld c, a
	ld de, $f
	ld hl, wSprite01StateData2MapY
	ldh a, [hPlayerFacing]
	and $3 ; facing up or down?
	jr z, .pushingHorizontallyLoop
.pushingVerticallyLoop
	inc hl
	ldh a, [hPlayerXCoord]
	cp [hl]
	jr nz, .nextSprite1 ; if X coordinates don't match
	dec hl
	ld a, [hli]
	ld b, a
	ldh a, [hPlayerFacing]
	rrca
	jr c, .pushingDown
; pushing up
	ldh a, [hPlayerYCoord]
	dec a
	jr .compareYCoords
.pushingDown
	ldh a, [hPlayerYCoord]
	inc a
.compareYCoords
	cp b
	jr z, .failure
.nextSprite1
	dec c
	jr z, .success
	add hl, de
	jr .pushingVerticallyLoop
.pushingHorizontallyLoop
	ld a, [hli]
	ld b, a
	ldh a, [hPlayerYCoord]
	cp b
	jr nz, .nextSprite2
	ld b, [hl]
	ldh a, [hPlayerFacing]
	bit 2, a
	jr nz, .pushingLeft
; pushing right
	ldh a, [hPlayerXCoord]
	inc a
	jr .compareXCoords
.pushingLeft
	ldh a, [hPlayerXCoord]
	dec a
.compareXCoords
	cp b
	jr z, .failure
.nextSprite2
	dec c
	jr z, .success
	add hl, de
	jr .pushingHorizontallyLoop
.failure
	ld a, $ff
	ret
.success
	xor a
	ret

; moved from home ---------------------------------------

; this function is an extra check that sometimes has to pass in order to warp, beyond just standing on a warp
; the "sometimes" qualification is necessary because of CheckWarpsNoCollision's behavior
; depending on the map, either "function 1" or "function 2" is used for the check
; "function 1" passes when the player is at the edge of the map and is facing towards the outside of the map
; "function 2" passes when the the tile in front of the player is among a certain set
; sets carry if the check passes, otherwise clears carry
ExtraWarpCheck::
; new for Sevii
	CheckEvent EVENT_IN_SEVII
	jr nz, .sevii
; BTV
	callfar IsCurrentMapHauntedHouse ; new
	jr z, .useFunction2				 ; new
	ld a, [wCurMap]
	cp SS_ANNE_3F
	jr z, .useFunction1
	cp ROCKET_HIDEOUT_B1F
	jr z, .useFunction2
	cp ROCKET_HIDEOUT_B2F
	jr z, .useFunction2
	cp ROCKET_HIDEOUT_B4F
	jr z, .useFunction2
	cp ROCK_TUNNEL_1F
	jr z, .useFunction2
	cp CERULEAN_CAVE_EXTRA_TOP		; new
	jr z, .useFunction2				; new
	cp CERULEAN_CAVE_EXTRA_MIDDLE	; new
	jr z, .useFunction2				; new
	cp CERULEAN_CAVE_EXTRA_BOTTOM	; new
	jr z, .useFunction2				; new
	cp CELADON_UNIVERSITY_1     	; new
	jr z, .useFunction2				; new
	cp CELADON_UNIVERSITY_2 		; new
	jr z, .useFunction2				; new
	cp OBSIDIAN_WAREHOUSE			; new
	jr z, .useFunction2				; new
	cp SECLUDED_CAVES				; new
	jr z, .useFunction2				; new
	cp ONIX_BURROWING				; new
	jr z, .useFunction2				; new
	cp HAUNTED_REDS_HOUSE			; new
	jr z, .useFunction2				; new
	cp REDS_HOUSE_1F				; new
	jr z, .useFunction2				; new
; new for Sevii
	jr .checkByTileset ; new
.sevii
	ld a, [wCurMap]
	cp SEVII_LOST_CAVE_1
	jr z, .useFunction2
	cp SEVII_LOST_CAVE_2
	jr z, .useFunction2
	cp SEVII_LOST_CAVE_3
	jr z, .useFunction2
	cp SEVII_ROUTE_43_CAVES
	jr z, .useFunction2
.checkByTileset ; new
; BTV	
	ld a, [wCurMapTileset]
	and a ; outside tileset (OVERWORLD)
	jr z, .useFunction2
	cp OVERWORLD_SEVII ; new for sevii
	jr z, .useFunction2 ; new for sevii
	cp SHIP ; S.S. Anne tileset
	jr z, .useFunction2
	cp SHIP_PORT ; Vermilion Port tileset
	jr z, .useFunction2
	cp PLATEAU ; Indigo Plateau tileset
	jr z, .useFunction2
.useFunction1
	jp IsPlayerFacingEdgeOfMap
.useFunction2
	jp IsWarpTileInFrontOfPlayer
