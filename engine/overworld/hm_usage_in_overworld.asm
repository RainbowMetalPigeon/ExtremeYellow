; whole new file

CheckIfCanSurfOrCutFromOverworld::
	ldh a, [hJoyHeld]
	bit BIT_A_BUTTON, a
	ret z
; A button is pressed
    ld a, [wWalkBikeSurfState]
    cp 3 ; is the player diving?
    jp z, .checkForReemerging
    cp 2 ; is the player already surfing?
    jp z, .checkForDive
; if we are not already surfing
; check for climbable rocks
    ld a, [wTileInFrontOfPlayer]
    cp $63
    jr nz, .checkForSurfability
; there's a rock tile in front of us
    call TryToClimbWall
    ret
.checkForSurfability
; check if we are in front of water
    callfar IsNextTileShoreOrWater
    jp nc, .cannotSurf ; in front of us we don't have water
    ld hl, TilePairCollisionsWater
    call CheckForTilePairCollisions
	jp c, .cannotSurf ; we are too high above water
; we have water in front of us
	call IsSurfingAllowed2
	ld hl, wd728
	bit 1, [hl]
	res 1, [hl]
	ret z
; surfing is allowed
    ld d, SURF
    call IsMoveInParty ; output: d = how many matches, z flag = whether a match was found (set = match found)
    jr z, .notSurfInTeam
; we have a Pokemon with SURF in the team
    ld a, [wObtainedBadges]
    bit BIT_SOULBADGE, a
	jp z, .newBadgeRequired
; we have the right badge
    callfar IsSurfingPikachuInThePlayersParty ; nc if it's not
    jr c, .surfingPikachu
    ld a, $1
    jr .continue
.surfingPikachu
    ld a, $2
.continue
	ld [wd473], a
    call LoadSurfingPlayerSpriteGraphics2
    callfar ItemUseSurfboard.makePlayerMoveForward
    ld hl, wd730
    set 7, [hl]
    ld a, 2
    ld [wWalkBikeSurfState], a ; change player state to surfing
    call PlayDefaultMusic ; play surfing music
    call EnableAutoTextBoxDrawing
    tx_pre_jump PlayerStartedSurfingText
.notSurfInTeam
    call EnableAutoTextBoxDrawing
    tx_pre_jump ThisWaterIsSurfableText
.newBadgeRequired
    call EnableAutoTextBoxDrawing
    tx_pre_jump NewBadgeRequiredText2
.cannotSurf
; check if we have a tree in front of us
    ld a, [wCurMapTileset]
    and a ; OVERWORLD
    jr z, .overworld
    cp OVERWORLD_SEVII ; new for sevii
    jr z, .overworld   ; new for sevii
    cp GYM
    jr z, .gym
    cp ISLAND
    jr z, .island
    cp CAVERN
	ret nz
    ld a, [wTileInFrontOfPlayer]
    cp $54 ; cavern cut tree
    ret nz
    jr .cuttableTile
.island
    ld a, [wTileInFrontOfPlayer]
    cp $3d ; island cut tree
    ret nz
    jr .cuttableTile
.gym
    ld a, [wTileInFrontOfPlayer]
    cp $50 ; gym cut tree
    ret nz
    jr .cuttableTile
.overworld
    dec a
    ld a, [wTileInFrontOfPlayer]
    cp $3d ; cut tree
    ret nz ; we don't check for grass, differently from vanilla
.cuttableTile
    ld [wCutTile], a
; we are in front of a tree
    ld d, CUT
    call IsMoveInParty ; output: d = how many matches, z flag = whether a match was found (set = match found)
    jr z, .notCutInTeam
; we have a Pokemon with CUT in the team
    ld a, [wObtainedBadges]
    bit BIT_CASCADEBADGE, a
	jp z, .newBadgeRequired ; backjump actually, no reasons not to share the same text and code
; we have the badge to cut it
; is this even necessary?
    ld a, 1
    ld [wActionResultOrTookBattleTurn], a ; used cut
; insta printing
    ld hl, wd730
    set 6, [hl]
    call EnableAutoTextBoxDrawing
    tx_pre UsedCutText2
    ld hl, wd730
    res 6, [hl]
; actual cutting stuff
    ld a, $ff
    ld [wUpdateSpritesEnabled], a
    callfar InitCutAnimOAM
    ld de, CutTreeBlockSwaps
    callfar ReplaceTreeTileBlock
    callfar RedrawMapView
    farcall AnimCut
    ld a, $1
    ld [wUpdateSpritesEnabled], a
    ld a, SFX_CUT
    call PlaySound
    ld a, $90
    ldh [hWY], a
    call UpdateSprites
    callfar RedrawMapView ; should this be simply a jp RedrawMapView?
    ret
.notCutInTeam
    call EnableAutoTextBoxDrawing
    tx_pre_jump ThisTreeIsCuttableText
.checkForDive
	lda_coord 8, 9 ; tile the player is on
	ld [wTilePlayerStandingOn], a
	cp $6A
	ret nz ; we're not standing on a dive-able spot
; we're on deep water, check if we have Dive
    ld d, DIVE
    call IsMoveInParty ; output: d = how many matches, z flag = whether a match was found (set = match found)
    jr z, .notDiveInTeam
; we have a Pokemon with DIVE in the team
    ld a, [wObtainedBadges]
    bit BIT_VOLCANOBADGE, a
	jp z, .newBadgeRequired
; we have the right badge
; we can actually dive
    ; how many underwater steps we can take
	ld hl, 200 ; TBE
	ld a, h
	ld [wDiveSteps], a
	ld a, l
	ld [wDiveSteps + 1], a
    ; used only for forced re-emerging when oxygen is depleted
    ld a, [wCurMap]
    ld [wDiveFromWhichMap], a
    ld a, [wXCoord]
    ld [wDiveFromWhichX], a
    ld a, [wYCoord]
    ld [wDiveFromWhichY], a
    ; print message and setup the warp
	tx_pre DiveMessageGoUnderText
    SetEvent EVENT_DIVE_GO_UNDER
    call FindDiveDestinationMap_FromAboveToSub
    jp WarpFound2
.checkForReemerging
	lda_coord 8, 9 ; tile the player is on
	ld [wTilePlayerStandingOn], a
	cp $32
	ret nz ; we're not standing on a re-emerge-able spot
	tx_pre DiveMessageGoAboveText
    SetEvent EVENT_DIVE_GO_ABOVE
    call FindDiveDestinationMap_FromSubToAbove
    jp WarpFound2
.notDiveInTeam
    call EnableAutoTextBoxDrawing
    tx_pre_jump ThisWaterIsDiveableText

; ============================================

ThisWaterIsSurfableText::
    text_far _ThisWaterIsSurfableText
    text_end

_ThisWaterIsSurfableText::
    text "A SURFing #MON"
    line "could sail you!"
    done

NewBadgeRequiredText2::
    text_far _NewBadgeRequiredText2
    text_end

_NewBadgeRequiredText2::
	text "A new BADGE"
	line "is required."
	done

PlayerStartedSurfingText::
    text_far _PlayerStartedSurfingText
    text_end

_PlayerStartedSurfingText::
    text "<PLAYER> SURFs on"
    line "their #MON!"
    done

ThisTreeIsCuttableText::
    text_far _ThisTreeIsCuttableText
    text_end

_ThisTreeIsCuttableText::
    text "A #MON could"
    line "CUT this tree!"
    done

UsedCutText2::
    text_far _UsedCutText2
    text_end

_UsedCutText2::
    text "<PLAYER>'s #MON"
    line "cuts the tree!"
    done

ThisWaterIsDiveableText::
    text_far _ThisWaterIsDiveableText
    text_end

_ThisWaterIsDiveableText::
    text "The water is deep."
    line "You could DIVE"
    cont "with a #MON!"
    done

DiveMessageGoUnderText::
	text_far _DiveMessageGoUnderText
	text_end

_DiveMessageGoUnderText::
	text "You DIVE into the"
    line "deep water!"
	done

DiveMessageGoAboveText::
	text_far _DiveMessageGoAboveText
	text_end

_DiveMessageGoAboveText::
	text "You re-emerge from"
    line "the deep water!"
	done

; --------------------------------------------

FindDiveDestinationMap_FromAboveToSub:
    CheckEvent EVENT_IN_SEVII
    ld a, [wCurMap]
    ld b, a
    ld hl, DivePairedMaps_Sevii
    jr nz, .loop
    ld hl, DivePairedMaps
.loop
    ld a, [hli]
    cp b
    jr nz, .noMatch
; match found
    ld a, [hl]
    ld [hWarpDestinationMap], a
    ret
.noMatch
    inc hl
    jr .loop

FindDiveDestinationMap_FromSubToAbove:
    CheckEvent EVENT_IN_SEVII
    ld a, [wCurMap]
    ld b, a
    ld hl, DivePairedMaps_Sevii + 1
    jr nz, .loop
    ld hl, DivePairedMaps + 1
.loop
    ld a, [hli]
    cp b
    jr nz, .noMatch
; match found
    dec hl
    dec hl
    ld a, [hl]
    ld [hWarpDestinationMap], a
    ret
.noMatch
    inc hl
    jr .loop

; no terminator, relies on me having worked properly and no mismatched maps
DivePairedMaps: ; TBE
;    db ROUTE_19, ROUTE_19_DIVE
;    db ROUTE_20, ROUTE_20_DIVE
;    db CINNABAR_ISLAND, CINNABAR_DIVE
;    db ROUTE_21, ROUTE_21_DIVE
;    db ROUTE_28, ROUTE_28_DIVE

; no terminator, relies on me having worked properly and no mismatched maps
DivePairedMaps_Sevii: ; TBE
    db SEVII_ROUTE_32, SEVII_ROUTE_32_DIVE

; --------------------------------------------

; from Vortiene
; Searches for a specific move in the party and also counts how many occurrences of it there are
; input:
; d = which move ID to look for
; output:
; d = how many matches
; z flag = whether a match was found (z = not found; nz = found)
IsMoveInParty:: ; maybe unnecessary to use double colon?
	ld c, d ; which move to check
	ld hl, wPartyMon1Moves
	lb de, 0, 0 ; d = how many matches were found e = which pokemon we're on
	push bc
.nextPoke
	pop bc
	ld b, NUM_MOVES
.moveloop
	ld a, [hl]
	cp c ; is it the specified move?
	jr nz, .noMatch
	inc d ; increase number of matches
.noMatch
	inc hl
	dec b
	jr nz, .moveloop
	inc e
	ld a, e
	cp PARTY_LENGTH
	jr z, .done
	push bc
	ld hl, wPartyMon1Moves
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	jr .nextPoke
.done
	ld a, d
	and a
	ret

; ugly copies to fix ghost messages --------------------------------------------

IsSurfingAllowed2:
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
	ld hl, SeafoamIslandsB4FStairsCoords2
	call ArePlayerCoordsInArray
	ret nc
	ld hl, wd728
	res 1, [hl]
	tx_pre_jump CurrentTooFastText2
.forcedToRideBike
	ld hl, wd728
	res 1, [hl]
	tx_pre_jump CyclingIsFunText2

SeafoamIslandsB4FStairsCoords2:
	dbmapcoord  7, 11
	db -1 ; end

CurrentTooFastText2::
	text_far _CurrentTooFastText2
	text_end

_CurrentTooFastText2::
	text "The current is"
	line "much too fast!"
	done

CyclingIsFunText2::
	text_far _CyclingIsFunText2
	text_end

_CyclingIsFunText2::
	text "Cycling is fun!"
	line "Forget SURFing!"
	done

; --------------------------------------------

TryToClimbWall:
; check fo move
	ld d, ROCK_CLIMB
    call IsMoveInParty ; output: d = how many matches, z flag = whether a match was found (nz = match found)
    jr z, .noRockClimbInTeam
; we have the move, check if we have the badge
    ld a, [wObtainedBadges]
    bit BIT_RAINBOWBADGE, a
	jp nz, ClimbWallUp
; no badge
    call EnableAutoTextBoxDrawing
    tx_pre_jump NewBadgeRequiredText2
.noRockClimbInTeam
    call EnableAutoTextBoxDrawing
    tx_pre_jump APokemonCouldClimbThisText

ClimbWallUp:
    SetEvent EVENT_DOING_ROCK_CLIMB
    call EnableAutoTextBoxDrawing
    tx_pre PokemonClimbsTheWall
; decide where to go, and how much
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_UP
	jr z, .goingUp
; going down
	ld a, D_DOWN
	jr .doTheSteps
.goingUp
	ld a, D_UP
.doTheSteps
	ld [wSimulatedJoypadStatesEnd], a
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
    ld a, SFX_PUSH_BOULDER
    call PlaySound
	jp StartSimulatingJoypadStates

APokemonCouldClimbThisText::
	text_far _APokemonCouldClimbThisText
	text_end

_APokemonCouldClimbThisText::
	text "A #MON could"
	line "CLIMB this wall!"
	done

PokemonClimbsTheWall::
	text_far _PokemonClimbsTheWall
	text_end

_PokemonClimbsTheWall::
	text "<PLAYER>'s #MON"
	line "climbs the wall!"
	done

ForceContinueRockClimb::
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	lda_coord 8, 9 ; tile the player is on
	ld [wTilePlayerStandingOn], a
	cp $63
	jr z, .weAreOnClimbableWall
	ResetEvent EVENT_DOING_ROCK_CLIMB
	ret
.weAreOnClimbableWall
; check which direction we're facing, and force the movement accordingly
	ld a, [wPlayerDirection]
	cp PLAYER_DIR_DOWN
	jr z, .down
; up
	ld a, D_UP
	jr .end
.down
	ld a, D_DOWN
.end
	ldh [hJoyHeld], a
	ret