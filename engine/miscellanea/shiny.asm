CheckForTrainersShinyMons::
    ld a, [wTrainerClass]
    cp BF_TRAINER
    jr z, .battleFacility ; handled specially
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
.battleFacility
    ld hl, wEnemyMonSpecies2
    ld a, [hl]
    and a
    jr z, .noShiny ; trainers can't be shiny ; is this even necessary???
; BF mons, not trainers
    ld a, [wEnemyMonPartyPos] ; wEnemyMonPartyPos starts from 0
    ld hl, wBattleFacilityMon1Shinyness
    ld b, 0
    ld c, a
    add hl, bc ; now hl contains wBattleFacilityMon[N]Shinyness
    ld a, [hl]
    and a
    jr z, .noShiny
    jr .matchFound

INCLUDE "data/trainers/trainers_shiny_mons.asm"

; =====================================

AssignShinyToBattleFacilityTrainers::
    ld hl, wBattleFacilityMon1Shinyness
    ld b, 6
.loopOnMons
    call Random
    cp 51 ; 20% chance
    ld a, 1
    jr c, .itIsShiny
    xor a
.itIsShiny
    ld [hli], a
    dec b
    jr nz, .loopOnMons
    ret

; =====================================

RollForShiny::
; roll some numbers and do some checks
; "debug" function, simply scalable
    call Random
    and %00000100
    jr nz, .shinyEncounter
; hRandomAdd/Sub needs to be substituted with calls to Random if I change to Jojo's code
; in that case I also move the call to this routine from end of battle to the wild encounter code
    ldh a, [hRandomAdd]
    cp 42 ; can be any number, I just want a 1/256 chance here
    jr nz, .badShinyRoll ; nz for real, z for testing purposes
; second random number, the badge-dependent one
; we skip this check if we have the SHINY CHARM, ergo the probability is 1/256
    ld b, SHINY_CHARM
    call IsItemInBag
    jr nz, .shinyEncounter
; if we don't have the SHINY CHARM, we need to roll another number and check against the badge-dependent U.L.
    call CountHowManyBadges ; a contains the number of badges
    call ConvertNumberOfBadgesIntoUpperLimit ; a contains the upper limit for the second random number
    ld b, a ; now it's b that holds the upper limit
    ldh a, [hRandomSub] ; a holds the random number
    cp b ; a-b, random-limit, c flag set if a is strictly lower than b, aka in b/256 cases, as 0 is included
    jr c, .shinyEncounter
.badShinyRoll
; not shiny, let's count non-shiny encounters for the "safety net"
    ld hl, wNonShinyEncounters
	inc [hl]
	ld a, [hli] ; let's now compare [wNonShinyEncounters] with 1500=$05DC
	cp $DC ; $05 for testing purposes, $DC for the 1500
	jr nz, .notShinyEncounter
	ld a, [hl]
	cp $05 ; $00 for testing purposes, $05 for the 1500
	jr nz, .notShinyEncounter
; let's make the encounter shiny because we had 1500 non-shiny ones
.shinyEncounter
    ld a, 1 ; this is the "yes it is shiny" value
    ld [wOpponentMonShiny], a
; reset the non-shiny counter
    xor a
    ld hl, wNonShinyEncounters ; not elegant but clearer to read, I could do some hld and preload it but whatever
    ld [hli], a
    ld [hl], a
    ret
.notShinyEncounter
	xor a ; not shiny
	ld [wOpponentMonShiny], a
    ret

CountHowManyBadges: ; returns in a the number of badges we own
    xor a
    ld hl, wObtainedBadges
	bit BIT_EARTHBADGE, [hl]
	jr z, .next1
    inc a
.next1
	bit BIT_VOLCANOBADGE, [hl]
	jr z, .next2
    inc a
.next2
	bit BIT_MARSHBADGE, [hl]
	jr z, .next3
    inc a
.next3
	bit BIT_SOULBADGE, [hl]
	jr z, .next4
    inc a
.next4
	bit BIT_RAINBOWBADGE, [hl]
	jr z, .next5
    inc a
.next5
	bit BIT_THUNDERBADGE, [hl]
	jr z, .next6
    inc a
.next6
	bit BIT_CASCADEBADGE, [hl]
	jr z, .next7
    inc a
.next7
	bit BIT_BOULDERBADGE, [hl]
	jr z, .next8
    inc a
.next8
    ret

ConvertNumberOfBadgesIntoUpperLimit: ; returns in a the upper limit for the second random number
    cp 0
    jr z, .badges0
    cp 1
    jr z, .badges1
    cp 2
    jr z, .badges2
    cp 3
    jr z, .badges3
    cp 4
    jr z, .badges4
    cp 5
    jr z, .badges5
    cp 6
    jr z, .badges6
    cp 7
    jr z, .badges7
; badges8
    ld a, 66
    ret
.badges7
    ld a, 33
    ret
.badges6
    ld a, 22
    ret
.badges5
    ld a, 16
    ret
.badges4
    ld a, 13
    ret
.badges3
    ld a, 11
    ret
.badges2
    ld a, 9
    ret
.badges1
    ld a, 8
    ret
.badges0
    ld a, 7
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
;    call CheckForTrainersShinyMons ; unnecessary, already calling this in engine/gfx/palettes.asm
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
