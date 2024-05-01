CheckForTrainersShinyMons::
    ld a, [wTrainerClass]
    ld b, a
    ld a, [wTrainerNo]
    ld c, a
    ld hl, TrainersShinyMons
.loopCheckForShiny
; b contains the trainer class, c the trainer number of the trainer we are facing
    ld a, [hli] ; a now contains the trainer class (or the terminator)
    cp $FF ; -1, terminator of the whole file
    jr z, .noShiny
    cp b ; is the trainer class we're facing the one pointed by hl?
    jr nz, .noMatch
    ld a, [hli] ; the trainer matches, now we check for the trainer number
    cp c
    jr nz, .noMatch
; the trainer class and number match, so they have at least one shiny in their team
; hl now points to the first (possibly only) non-terminator party-position value
    ld a, [wEnemyMonPartyPos]
    inc a ; let's +1 a just because wEnemyMonPartyPos starts from 0 but we are used to 1-6 for the parties
    ld b, a ; now b contains the party position of the mon we are facing
.internalShinyLoop
    ld a, [hli] ; a contains the party position of the pointed shiny, and hl advanced by one
    cp $FE
    jr z, .noShiny
    cp b
    jr z, .matchFound
    jr .internalShinyLoop
.matchFound
    ld a, 1
    ld [wOpponentMonShiny], a
    ret
.noMatch
	ld a, [hli]
	cp $FE
	jr nz, .noMatch
	jr .loopCheckForShiny
.noShiny
    xor a
    ld [wOpponentMonShiny], a
    ret

INCLUDE "data/trainers/trainers_shiny_mons.asm"

; =====================================

RollForShiny::
; roll some numbers and do some checks
;	call Random
;	and a
;	jr nz, .vanilla
	call Random
	and %00000100

	ld a, 1 ; this is the "yes it is shiny" value
	jr nz, .shiny ; this check is a nz now, but may need to be edited
	xor a ; not shiny
.shiny
	ld [wOpponentMonShiny], a
	ret
