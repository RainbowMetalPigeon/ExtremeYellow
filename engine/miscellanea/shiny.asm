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
;	and %00000100
    and %00000000

    ld hl, wNonShinyEncounters
	jr nz, .shinyEncounter ; this check is a nz now, but may need to be edited

; not shiny, let's count non-shiny encounters for the "safety net"
	inc [hl]
	ld a, [hli] ; let's now compare [wNonShinyEncounters] with 1500=$05DC
	cp $05; $DC
	jr nz, .notShinyEncounter
	ld a, [hld]
	cp $0; $05
	jr nz, .notShinyEncounter
; let's make the encounter shiny because we had 1500 non-shiny ones
.shinyEncounter
    ld a, 1 ; this is the "yes it is shiny" value
    ld [wOpponentMonShiny], a
; reset the non-shiny counter
    xor a
    ld [hli], a
    ld [hl], a
    ret
.notShinyEncounter
	xor a ; not shiny
	ld [wOpponentMonShiny], a
    ret

; =====================================

PlayShinyAnimationIfShinyPlayerMon:
    ld a, [wBattleMonCatchRate]
    cp 1
    ret nz
    xor a
	ld [wAnimationType], a
	ld a, SHINY_PLAYER_ANIM
	call PlayMoveAnimationCopy
    ret

PlayShinyAnimationIfShinyEnemyMon:
    ld a, [wIsTrainerBattle]
    and a
    jr z, .wildBattle
; trainer battle, do the checks
    call CheckForTrainersShinyMons
    ld a, [wOpponentMonShiny]
    and a
    ret z
    jr .playShinyAnim
.wildBattle
    ld hl, wEnemyMonSpecies2
    ld a, [wOpponentMonShiny]
    cp 1
    ret nz
.playShinyAnim
    xor a
	ld [wAnimationType], a
	ld a, SHINY_ENEMY_ANIM
	call PlayMoveAnimationCopy
    ret

PlayMoveAnimationCopy:
	ld [wAnimationID], a
	call Delay3
	predef MoveAnimation
	callfar Func_78e98
	ret
