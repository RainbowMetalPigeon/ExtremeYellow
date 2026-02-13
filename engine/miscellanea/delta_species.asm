DetermineIfWildMonIsDeltaSpecies::
; "debug"/testing function, makes ever wild mon Delta Species
;    jr .deltaSpeciesEncounter

    CheckEvent EVENT_IN_SEVII
    ld a, [wCurMap]
    jr z, .kanto
; sevii
    ; TBE: Mewtwo and Mewtwo in final Tanoby

.kanto
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

; =====================================

SetDeltaSpeciesEvent_Enemy::
    ld a, [wOpponentMonShiny]
    bit BIT_MON_DELTA, a
    ret z
    SetEvent EVENT_LOAD_DELTA_SPECIES_TYPES
    ret
