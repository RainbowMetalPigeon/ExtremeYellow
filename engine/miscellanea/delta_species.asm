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

; =====================================

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
