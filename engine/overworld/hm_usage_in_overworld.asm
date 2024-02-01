; whole new file

CheckIfCanSurfFromOverworld::
;	ldh a, [hLoadedROMBank]
;	push af
	ldh a, [hJoyHeld]
	bit BIT_A_BUTTON, a
	jr z, .done
; A button is pressed
    ld a, [wWalkBikeSurfState]
    cp 2 ; is the player already surfing?
    jr z, .done
; if we are not already surfing
    callfar IsNextTileShoreOrWater
    jp nc, .done ; in front of us we don't have water
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
    jr .done

;	ld a, SURFBOARD
;	ld [wcf91], a
;	ld [wPseudoItemID], a
;	call UseItem
;;   [wActionResultOrTookBattleTurn]
;;   call ItemUseSurfboard
;    jr .done

.notSurfInTeam
    call EnableAutoTextBoxDrawing
    tx_pre_jump ThisWaterIsSurfableText
    jr .done
.newBadgeRequired
    call EnableAutoTextBoxDrawing
    tx_pre_jump NewBadgeRequiredText2
.done
;	pop af
;	call BankswitchCommon
	ret

; --------------------------------------------

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
