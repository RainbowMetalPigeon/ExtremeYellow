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
    jp z, .checkForWhirlpoolDiveWaterfall
; if we are not already surfing

; check for birbs
    CheckEvent EVENT_IN_SEVII
    jr nz, .seviiCheck

; Kanto check
    ld a, [wCurMapTileset]
    cp OVERWORLD
    jr z, .kantoTileCheck
    cp PLATEAU
    jr z, .kantoTileCheck
    cp ISLAND
    jr nz, .checkIfAreaDark
.kantoTileCheck
    ld a, [wTileInFrontOfPlayer]
    cp $76
    jr nz, .checkIfAreaDark
    jr .doBirbStuff

.seviiCheck
    call IsThisSpecialBirbSeviiMap
    ld a, [wTileInFrontOfPlayer]
    jr nz, .seviiStandard
    cp $69
    jr .seviiPostTile
.seviiStandard
    cp $5F
.seviiPostTile
    jr nz, .checkIfAreaDark
; birb in front of us
.doBirbStuff
; TBE: conditional if we are rocket
	CheckEvent EVENT_OBTAINED_SEEDS_BAG
	jr nz, .weHaveSeedsBag
; no seeds, can't feed the birbs, everyone is sad
    call EnableAutoTextBoxDrawing
    tx_pre TheBirbIsHungryText
;    ld a, SFX_LEVEL_UP ; SFX_DEX_PAGE_ADDED ; SFX_LEVEL_UP ; SFX_GET_ITEM_1 ; SFX_HEAL_HP
;    call PlaySound
    callfar BirbEmotionBubble
	ld a, 0
	ld [wEmotionBubbleSpriteIndex], a
	ld a, SAD_BUBBLE
	ld [wWhichEmotionBubble], a
	predef_jump EmotionBubble
.weHaveSeedsBag
    call EnableAutoTextBoxDrawing
    tx_pre PlayerFeedsTheBirbText
    ld a, SFX_LEVEL_UP ; SFX_DEX_PAGE_ADDED ; SFX_LEVEL_UP ; SFX_GET_ITEM_1 ; SFX_HEAL_HP
    call PlaySound
    call AnimateBribTile_Flapping_Wrapper
    callfar BirbEmotionBubble
	ld a, 0
	ld [wEmotionBubbleSpriteIndex], a
	ld a, SMILE_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
    call AnimateBribTile_Resting_Wrapper
	callfar MarkBirbAsFed
    ret ; TBE

.checkIfAreaDark
; check if area is dark
    ld a, [wMapPalOffset]
    and a
    jr z, .areaNotDark
; area is dark
    ld a, [wObtainedBadges] ; badges obtained
    bit BIT_BOULDERBADGE, a ; BROCK
	jp z, .newBadgeRequired
	CheckEvent EVENT_IN_SEVII
	jr z, .kantoFlash
	ld a, [wCurMap]
	cp SEVII_ONE_ISLAND_GYM_2
	jr nz, .kantoFlash
    tx_pre_jump CantDissipateMistText2
.kantoFlash
	xor a
	ld [wMapPalOffset], a
	tx_pre_jump FlashLightsAreaText2

.areaNotDark
; check for climbable rocks
    ld a, [wCurMapTileset]
    cp OVERWORLD
    jr z, .checkIfClimbableTile
    cp OVERWORLD_SEVII
    jr z, .checkIfClimbableTile
    cp ISLAND
    jr z, .checkIfClimbableTile
    cp CAVERN
    jr nz, .checkForSurfability
.checkIfClimbableTile
    ld a, [wTileInFrontOfPlayer]
    cp $63
    jr nz, .checkForSurfability
; there's a rock tile in front of us
    jp TryToClimbWall

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
    bit BIT_SOULBADGE, a ; KOGA
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
    bit BIT_CASCADEBADGE, a ; MISTY
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
    ld de, CutTreeBlockSwaps ; how does this even work if it's in another bank???
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

.checkForWhirlpoolDiveWaterfall
; check if we have a whirlpool in front of us
    ld a, [wCurMapTileset]
    cp OVERWORLD_SEVII
    jr nz, .checkForWaterfall
; we're in a (the?) tileset with whirlpools
    dec a
    ld a, [wTileInFrontOfPlayer]
    cp $20 ; SW whirlpool tile
    jr nz, .checkForWaterfall
; we are in front of a whirlpool
    ld d, WHIRLPOOL
    call IsMoveInParty ; output: d = how many matches, z flag = whether a match was found (set = match found)
    jr z, .notWhirlpoolInTeam
; we have a Pokemon with WHIRLPOOL in the team
    ld a, [wObtainedBadges]
    bit BIT_MARSHBADGE, a ; SABRINA
	jp z, .newBadgeRequired
; we have the badge to undo the whirlpool
; is this even necessary?
    ld a, 1
    ld [wActionResultOrTookBattleTurn], a ; used cut?
; insta printing
    ld hl, wd730
    set 6, [hl]
    call EnableAutoTextBoxDrawing
    tx_pre UsedWhirlpoolText
    ld hl, wd730
    res 6, [hl]
; actual whirlpool undoing stuff
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
    callfar RedrawMapView ; should this be simply a jp RedrawMapView?
    ret
.notWhirlpoolInTeam
    call EnableAutoTextBoxDrawing
    tx_pre_jump ThisWhirlpoolCanBeStoppedText

.checkForWaterfall

; check for waterfall
    ld a, [wCurMapTileset]
    cp CAVERN ; waterfalls exists only in caverns
    jr nz, .checkForDive
    ld a, [wTileInFrontOfPlayer]
    cp $50
    jr nz, .checkForDive
; there's a waterfall tile in front of us
    jp TryToRideWaterfall

.checkForDive
	lda_coord 8, 9 ; tile the player is on
	ld [wTilePlayerStandingOn], a
	cp $45
	ret nz ; we're not standing on a dive-able spot
; we're on deep water, check if we have Dive
    ld d, DIVE
    call IsMoveInParty ; output: d = how many matches, z flag = whether a match was found (set = match found)
    jr z, .notDiveInTeam
; we have a Pokemon with DIVE in the team
    ld a, [wObtainedBadges]
    bit BIT_RAINBOWBADGE, a ; ERIKA
	jp z, .newBadgeRequired
; we have the right badge
; we can actually dive
    ; how many underwater steps we can take
	CheckEvent EVENT_DIVE_GOT_OXYGEN_TANK
	ld hl, 300
	jr nz, .gotDiveSteps
	ld hl, 150 ; 999 for debugging
.gotDiveSteps
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

ThisWhirlpoolCanBeStoppedText::
	text_far _ThisWhirlpoolCanBeStoppedText
	text_end

_ThisWhirlpoolCanBeStoppedText::
	text "A #MON can stop"
	line "this WHIRLPOOL!"
	done

UsedWhirlpoolText::
    text_far _UsedWhirlpoolText
    text_end

_UsedWhirlpoolText::
    text "Your #MON stops"
    line "the WHIRLPOOL!"
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

CantDissipateMistText2::
	text_far _CantDissipateMistText2
	text_end

_CantDissipateMistText2::
	text "Can't dissipate the"
	line "mysterious mist!"
	done

FlashLightsAreaText2::
	text_far _FlashLightsAreaText2
	text_end

_FlashLightsAreaText2::
	text "A blinding FLASH"
	line "lights the area!"
	done

PlayerFeedsTheBirbText::
    text_far _PlayerFeedsTheBirbText
    text_end

_PlayerFeedsTheBirbText::
    text "<PLAYER> feeds"
    line "the birb!"
    done

TheBirbIsHungryText::
    text_far _TheBirbIsHungryText
    text_end

_TheBirbIsHungryText::
    text "The birb is"
    line "hungry..."
;	xxxx "123456789012345678"
    done

PlayerKicksTheBirbText::
    text_far _PlayerKicksTheBirbText
    text_end

_PlayerKicksTheBirbText::
    text "<PLAYER> kicks"
    line "the birb!"
;	xxxx "123456789012345678"
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
    db ROUTE_21, ROUTE_21_DIVE
    db ROUTE_19, ROUTE_19_DIVE
    db ROUTE_20, ROUTE_20_DIVE
;    db CINNABAR_ISLAND, CINNABAR_DIVE
;    db ROUTE_28, ROUTE_28_DIVE

; no terminator, relies on me having worked properly and no mismatched maps
DivePairedMaps_Sevii: ; TBE
    db SEVII_ROUTE_32, SEVII_ROUTE_32_DIVE
    db SEVII_TWO_ISLAND_CITY, SEVII_TWO_ISLAND_CITY_DIVE
    db SEVII_ROUTE_33, SEVII_ROUTE_33_DIVE
    db SEVII_FOUR_ISLAND_CITY, SEVII_FOUR_ISLAND_CITY_DIVE
    db SEVII_FIVE_ISLAND_CITY, SEVII_FIVE_ISLAND_CITY_DIVE
    db SEVII_ROUTE_38, SEVII_ROUTE_38_DIVE
    db SEVII_ROUTE_39, SEVII_ROUTE_39_DIVE
    db SEVII_SEVEN_ISLAND_GYM_2, SEVII_SEVEN_ISLAND_GYM_2_DIVE

; --------------------------------------------

; from Vortiene
; Searches for a specific move in the party and also counts how many occurrences of it there are
; input:
; d = which move ID to look for
; output:
; d = how many matches
; z flag = whether a match was found (z = not found; nz = found)
IsMoveInParty::
	ld c, d ; which move to check
	ld hl, wPartyMon1Moves
	lb de, 0, 0 ; d = how many matches were found, e = which pokemon we're on
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
    bit BIT_THUNDERBADGE, a ; SURGE
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
; get off bike if we're on it
    ld a, [wWalkBikeSurfState]
    and a
    jr z, .noBike
    xor a
	ld [wWalkBikeSurfState], a
	ld [wWalkBikeSurfStateCopy], a
	call LoadPlayerSpriteGraphics
    call PlayDefaultMusic ; play walking music
.noBike
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

; --------------------------------------------

TryToRideWaterfall:
; check fo move
	ld d, WATERFALL
    call IsMoveInParty ; output: d = how many matches, z flag = whether a match was found (nz = match found)
    jr z, .noWaterfallInTeam
; we have the move, check if we have the badge
    ld a, [wObtainedBadges]
    bit BIT_VOLCANOBADGE, a ; BLAINE
	jp nz, RideWaterfall
; no badge
    call EnableAutoTextBoxDrawing
    tx_pre_jump NewBadgeRequiredText2
.noWaterfallInTeam
    call EnableAutoTextBoxDrawing
    tx_pre_jump APokemonCouldRideThisText

RideWaterfall:
    SetEvent EVENT_DOING_WATERFALL
    call EnableAutoTextBoxDrawing
    tx_pre PokemonRidesTheWaterfall
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
    ld a, SFX_SURFING_JUMP
    call PlaySound
	jp StartSimulatingJoypadStates

APokemonCouldRideThisText::
	text_far _APokemonCouldRideThisText
	text_end

_APokemonCouldRideThisText::
	text "A #MON could"
	line "ride this"
    cont "WATERFALL!"
	done

PokemonRidesTheWaterfall::
	text_far _PokemonRidesTheWaterfall
	text_end

_PokemonRidesTheWaterfall::
	text "<PLAYER>'s #MON"
	line "rides the"
    cont "WATERFALL!"
	done

ForceContinueWaterfall::
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	lda_coord 8, 9 ; tile the player is on
	ld [wTilePlayerStandingOn], a
	cp $50
	jr z, .weAreOnWaterfall
	ResetEvent EVENT_DOING_WATERFALL
	ret
.weAreOnWaterfall
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

; ==================================================================

; resting

AnimateBribTile_Resting_Wrapper:
    CheckEvent EVENT_IN_SEVII
    jr nz, AnimateBribTile_SeviiResting_Decider
    ; fallthrough

;AnimateBribTile_Resting_Decider:
    ld a, [wCurMapTileset]
    cp OVERWORLD
    jr nz, AnimateBribTile_Resting2
    ; fallthrough

AnimateBribTile_Resting:
	ld de, BirbTileRest
	ld hl, vTileset tile $76
    jr AnimateBribTile_Core

AnimateBribTile_Resting2:
	ld de, BirbTileRest2
	ld hl, vTileset tile $76
    jr AnimateBribTile_Core

AnimateBribTile_SeviiResting_Decider:
    call IsThisSpecialBirbSeviiMap
    jr z, AnimateBribTile_SeviiResting2
    ; fallthrough

AnimateBribTile_SeviiResting:
	ld de, BirbTileSeviiRest
	ld hl, vTileset tile $5F
    jr AnimateBribTile_Core

AnimateBribTile_SeviiResting2:
	ld de, BirbTileSeviiRest2
	ld hl, vTileset tile $69
    jr AnimateBribTile_Core

; flapping

AnimateBribTile_Flapping_Wrapper:
    CheckEvent EVENT_IN_SEVII
    jr nz, AnimateBribTile_SeviiFlapping_Decider
    ; fallthrough

;AnimateBribTile_Flapping_Decider:
    ld a, [wCurMapTileset]
    cp OVERWORLD
    jr nz, AnimateBribTile_Flapping2
    ; fallthrough

AnimateBribTile_Flapping:
	ld de, BirbTileFlap
	ld hl, vTileset tile $76
    jr AnimateBribTile_Core

AnimateBribTile_Flapping2:
	ld de, BirbTileFlap2
	ld hl, vTileset tile $76
    jr AnimateBribTile_Core

AnimateBribTile_SeviiFlapping_Decider:
    call IsThisSpecialBirbSeviiMap
    jr z, AnimateBribTile_SeviiFlapping2
    ; fallthrough

AnimateBribTile_SeviiFlapping:
	ld de, BirbTileSeviiFlap
	ld hl, vTileset tile $5F
    ; fallthrough

AnimateBribTile_Core:
	lb bc, BANK(BirbTileRest), 1
	jp CopyVideoData

AnimateBribTile_SeviiFlapping2:
	ld de, BirbTileSeviiFlap2
	ld hl, vTileset tile $69
    jr AnimateBribTile_Core

BirbTileRest: INCBIN "gfx/tilesets/birbs/birb_resting.2bpp"
BirbTileFlap: INCBIN "gfx/tilesets/birbs/birb_flapping.2bpp"

BirbTileSeviiRest: INCBIN "gfx/tilesets/birbs/birb_sevii_resting.2bpp"
BirbTileSeviiFlap: INCBIN "gfx/tilesets/birbs/birb_sevii_flapping.2bpp"

BirbTileRest2: INCBIN "gfx/tilesets/birbs/birb_resting2.2bpp"
BirbTileFlap2: INCBIN "gfx/tilesets/birbs/birb_flapping2.2bpp"

BirbTileSeviiRest2: INCBIN "gfx/tilesets/birbs/birb_sevii_resting2.2bpp"
BirbTileSeviiFlap2: INCBIN "gfx/tilesets/birbs/birb_sevii_flapping2.2bpp"

IsThisSpecialBirbSeviiMap:
    ld a, [wCurMap]
    cp SEVII_EIGHT_ISLAND_CITY
    ret z
    cp SEVII_DESOLATED_ROCK
    ret z
    cp SEVII_TEN_ISLAND
    ret

; ==================================================================
