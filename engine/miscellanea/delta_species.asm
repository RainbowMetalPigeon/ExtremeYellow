DetermineIfWildMonIsDeltaSpecies::
; "debug"/testing function, makes ever wild mon Delta Species
;    jr .deltaSpeciesEncounter

    CheckEvent EVENT_IN_SEVII
    jr z, .kanto
; sevii
    ld a, [wCurMap]
    ; TBE: Mewtwo and Mewtwo in final Tanoby
    jr .notDeltaSpeciesEncounter

.kanto
    ld a, [wEnemyMonSpecies2]
    cp MEW
    jr z, .notDeltaSpeciesEncounter
    cp ARM_MEWTWO
    jr z, .notDeltaSpeciesEncounter
    cp MEWTWO
    jr z, .notDeltaSpeciesEncounter
;    cp MMEWTWOX
;    jr z, .notDeltaSpeciesEncounter
;    cp MMEWTWOY
;    jr z, .notDeltaSpeciesEncounter
; check Kanto maps: are we in the Secluded Atoll?
    ld a, [wCurMap]
    cp SECLUDED_ATOLL_NE
    jr z, .deltaSpeciesEncounter
    cp SECLUDED_ATOLL_SE
    jr z, .deltaSpeciesEncounter
    cp SECLUDED_ATOLL_SW
    jr z, .deltaSpeciesEncounter
    cp SECLUDED_ATOLL_NW
    jr z, .deltaSpeciesEncounter
    ; fallthrough

.notDeltaSpeciesEncounter
    ld a, [wOpponentMonShiny]
    res BIT_MON_DELTA, a
	ld [wOpponentMonShiny], a
    ret

.deltaSpeciesEncounter
    ld a, [wOpponentMonShiny]
    set BIT_MON_DELTA, a
    ld [wOpponentMonShiny], a
    ret

; ==========================================================================

SetDeltaSpeciesEvent_Enemy::
    ld a, [wOpponentMonShiny]
    bit BIT_MON_DELTA, a
    ret z
    SetEvent EVENT_LOAD_DELTA_SPECIES_TYPES
    ret

SetDeltaSpeciesEvent_Loaded::
    ld a, [wLoadedMonCatchRate]
    bit BIT_MON_DELTA, a
    ret z
    SetEvent EVENT_LOAD_DELTA_SPECIES_TYPES
    ret

SetDeltaSpeciesEvent_Battle::
    ld a, [wBattleMonCatchRate]
    bit BIT_MON_DELTA, a
    ret z
    SetEvent EVENT_LOAD_DELTA_SPECIES_TYPES
    ret

SetDeltaSpeciesEvent_deRegister::
    ld a, [de]
    bit BIT_MON_DELTA, a
    ret z
    SetEvent EVENT_LOAD_DELTA_SPECIES_TYPES
    ret

SetDeltaSpeciesEvent_PlayerForLeaguePC::
    ld a, [wPlayerMonShiny] ; for League PC
    bit BIT_MON_DELTA, a
    ret z
    SetEvent EVENT_LOAD_DELTA_SPECIES_TYPES
    ret

; ==========================================================================

CheckForTrainersDeltaMons::
    ld a, [wTrainerClass]
    cp BF_TRAINER
    jr z, .battleFacility ; handled specially
    
    ld b, a
    ld a, [wTrainerNo]
    ld c, a
    ld hl, TrainersDeltaMons
.loopCheckForDelta
; b contains the trainer class, c the trainer number of the trainer we are facing
    ld a, [hli] ; a now contains the trainer class (or the terminator)
    cp $FF ; -1, terminator of the whole file
    jr z, .noDelta
    cp b ; is the trainer class we're facing the one pointed by hl?
    jr nz, .noMatch
    ld a, [hli] ; the trainer matches, now we check for the trainer number
    cp c
    jr nz, .noMatch
; the trainer class and number match, so they have at least one delta in their team
; hl now points to the first (possibly only) non-terminator party-position value
    ld a, [wEnemyMonPartyPos]
    inc a ; let's +1 a just because wEnemyMonPartyPos starts from 0 but we are used to 1-6 for the parties
    ld b, a ; now b contains the party position of the mon we are facing
.internalDeltaLoop
    ld a, [hli] ; a contains the party position of the pointed delta, and hl advanced by one
    cp $FE
    jr z, .noDelta
    cp b
    jr z, .matchFound
    jr .internalDeltaLoop
.matchFound
    ld a, [wOpponentMonShiny]
    set BIT_MON_DELTA, a
    ld [wOpponentMonShiny], a
    ret
.noMatch
	ld a, [hli]
	cp $FE
	jr nz, .noMatch
	jr .loopCheckForDelta
.noDelta
    ld a, [wOpponentMonShiny]
    res BIT_MON_DELTA, a
    ld [wOpponentMonShiny], a
    ret

.battleFacility ; TBE
    ld hl, wEnemyMonSpecies2
    ld a, [hl]
    and a
    jr z, .noDelta ; trainers can't be delta ; is this even necessary???
; BF mons, not trainers
    ld a, [wEnemyMonPartyPos] ; wEnemyMonPartyPos starts from 0
    ld hl, wBattleFacilityMon1Shinyness
    ld b, 0
    ld c, a
    add hl, bc ; now hl contains wBattleFacilityMon[N]Shinyness
    ld a, [hl]
    and a
    jr z, .noDelta
    jr .matchFound

INCLUDE "data/trainers/trainers_delta_mons.asm"
