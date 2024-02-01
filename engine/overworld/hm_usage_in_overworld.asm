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
	farcall IsSurfingAllowed
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
    call makePlayerMoveForward2
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
; check for cut

; &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

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

; are these needed?
;    call ClearSprites
;    call RestoreScreenTilesAndReloadTilePatterns
;    call ReloadMapData
;    ld a, SCREEN_HEIGHT_PX
;    ldh [hWY], a
;    call Delay3
;    call LoadGBPal
;    call LoadCurrentMapView
;    call SaveScreenTilesToBuffer2
;    call Delay3
;    xor a
;    ldh [hWY], a

; insta printing
    ld hl, wd730
    set 6, [hl]
    call EnableAutoTextBoxDrawing
    tx_pre UsedCutText2
    ld hl, wd730
    res 6, [hl]

; necessary only if the one above is
;    call LoadScreenTilesFromBuffer2

; actual cutting stuff?
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

; needed?
    call UpdateSprites
    callfar RedrawMapView ; should this be simply a jp RedrawMapView?
    jr .done

.notCutInTeam
    call EnableAutoTextBoxDrawing
    tx_pre_jump ThisTreeIsCuttableText

; &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

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
    line "cut this tree!"
    done

UsedCutText2::
    text_far _UsedCutText2
    text_end

_UsedCutText2::
    text "<PLAYER>'s #MON"
    line "cuts the tree!"
    done

; --------------------------------------------

makePlayerMoveForward2:
	ld a, [wPlayerDirection] ; direction the player is going
	bit PLAYER_DIR_BIT_UP, a
	ld b, D_UP
	jr nz, .storeSimulatedButtonPress
	bit PLAYER_DIR_BIT_DOWN, a
	ld b, D_DOWN
	jr nz, .storeSimulatedButtonPress
	bit PLAYER_DIR_BIT_LEFT, a
	ld b, D_LEFT
	jr nz, .storeSimulatedButtonPress
	ld b, D_RIGHT
.storeSimulatedButtonPress
	ld a, b
	ld [wSimulatedJoypadStatesEnd], a
	xor a
	ld [wWastedByteCD39], a
	inc a
	ld [wSimulatedJoypadStatesIndex], a
	ret

; from Vortiene
; Searches for a specific move in the party and also counts how many occurrences of it there are
; input:
; d = which move ID to look for
; output:
; d = how many matches
; z flag = whether a match was found (z = not found; nz = found)
IsMoveInParty:
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

; --------------------------------------------

CutTreeBlockSwaps2: ; stupid copy
	; first byte = tileset block containing the cut tree
	; second byte = corresponding tileset block after the cut animation happens
	db $32, $6D
	db $33, $6C
	db $34, $6F
	db $35, $4C
	db $60, $6E
	db $0B, $0A
	db $3C, $35
	db $3F, $35
	db $3D, $36
	db $B8, $4C ; new, for OVERWORLD (used in FUCHSIA_CITY)
	db $B9, $BA ; new, for OVERWORLD (used in FUCHSIA_CITY)
	db $4D, $4E ; new, for ISLAND blockset
	db $8B, $05 ; new, for CAVERN blockset
	db -1 ; end
