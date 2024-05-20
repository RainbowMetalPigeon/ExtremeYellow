; whole new file

CheckIfCanSurfOrCutFromOverworld::
	ldh a, [hJoyHeld]
	bit BIT_A_BUTTON, a
	jp z, .done
; A button is pressed
    ld a, [wWalkBikeSurfState]
    cp 2 ; is the player already surfing?
    jp z, .done
; if we are not already surfing
    callfar IsNextTileShoreOrWater
    jp nc, .cannotSurf ; in front of us we don't have water
; we have water in front of us
    ld d, SURF
    call IsMoveInParty ; output: d = how many matches, z flag = whether a match was found (set = match found)
    jr z, .notSurfInTeam
; we have a Pokemon with SURF in the team
    ld a, [wObtainedBadges]
    bit BIT_SOULBADGE, a
	jp z, .newBadgeRequired
; we have the right badge
	call IsSurfingAllowed2
	ld hl, wd728
	bit 1, [hl]
	res 1, [hl]
	jp z, .done
; surfing is allowed
    callfar IsSurfingPikachuInThePlayersParty ; nc if it's not
    jr c, .surfingPikachu
    ld a, $1
    jr .continue
.surfingPikachu
    ld a, $2
.continue
	ld [wd473], a
; unnecessary???
;    ld hl, TilePairCollisionsWater
;    call CheckForTilePairCollisions
;    jp c, SurfingAttemptFailed
    call LoadSurfingPlayerSpriteGraphics2
    callfar ItemUseSurfboard.makePlayerMoveForward
    ld hl, wd730
    set 7, [hl]
    ld a, 2
    ld [wWalkBikeSurfState], a ; change player state to surfing
    call PlayDefaultMusic ; play surfing music
    call EnableAutoTextBoxDrawing
    tx_pre_jump PlayerStartedSurfingText
    jp .done
.notSurfInTeam
    call EnableAutoTextBoxDrawing
    tx_pre_jump ThisWaterIsSurfableText
    jp .done
.newBadgeRequired
    call EnableAutoTextBoxDrawing
    tx_pre_jump NewBadgeRequiredText2
    jp .done
.cannotSurf
; check if we have a tree in front of us
    ld a, [wCurMapTileset]
    and a ; OVERWORLD
    jr z, .overworld
    cp GYM
    jr z, .gym
    cp ISLAND
    jr z, .island
    cp CAVERN
    ld a, [wTileInFrontOfPlayer]
    cp $54 ; cavern cut tree
    jp nz, .done
    jr .cuttableTile
.island
    ld a, [wTileInFrontOfPlayer]
    cp $3d ; island cut tree
    jp nz, .done
    jr .cuttableTile
.gym
    ld a, [wTileInFrontOfPlayer]
    cp $50 ; gym cut tree
    jp nz, .done
    jr .cuttableTile
.overworld
    dec a
    ld a, [wTileInFrontOfPlayer]
    cp $3d ; cut tree
    jp nz, .done ; we don't check for grass, differently from vanilla
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
    jr .done
.notCutInTeam
    call EnableAutoTextBoxDrawing
    tx_pre_jump ThisTreeIsCuttableText
.done
	ret

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
