; inputs: d & e = types of the defender mon
; output: [wMultipurposeTemporaryStorage] = effectiveness, or $FF if hit terminator 
TypeEffectivenessMatchFinder::
	ld a, [wMoveType]
	ld b, a
; determine which type chart to look at
	CheckEvent EVENT_ALREADY_ENTERED_TYPE_CHART_MATCHFINDER
	jr z, .firstTime
; we're returning, load stored address to continue from there
	SetEvent EVENT_ALREADY_ENTERED_TYPE_CHART_MATCHFINDER_AGAIN
	ld a, [wEphemerealTempBuffer2ByteStorage2]
	ld h, a
	ld a, [wEphemerealTempBuffer2ByteStorage2+1]
	ld l, a
	jr .loop

.firstTime
	SetEvent EVENT_ALREADY_ENTERED_TYPE_CHART_MATCHFINDER
	ld hl, TypeEffects
; load Inverse Battle chart on demand; 0 for normal, 1 for inverse
	ld a, [wInverseBattle]
	and a
    jr z, .loop
    ld hl, TypeEffectsInverse

; matching pair search
.loop
	ld a, [hli] ; a = "attacking type" of the current type pair
	cp $ff
	jr z, .done
; terminator not hit
	cp b ; does move type match "attacking type"?
	jr nz, .nextTypePair
	ld a, [hl] ; a = "defending type" of the current type pair
	cp d ; does type 1 of defender match "defending type"?
	jr z, .matchingPairFound
	cp e ; does type 2 of defender match "defending type"?
	jr z, .matchingPairFound
	jr .nextTypePair

.nextTypePair
	inc hl
	inc hl
	jr .loop

.matchingPairFound
	inc hl
	ld a, [hli] ; now hl points to the beginning of the next row
	ld [wMultipurposeTemporaryStorage], a
	ld a, h
	ld [wEphemerealTempBuffer2ByteStorage2], a
	ld a, l
	ld [wEphemerealTempBuffer2ByteStorage2+1], a
	ret

.done
	ld [wMultipurposeTemporaryStorage], a
	ret

; ====================================================================

; function to tell how effective the type of an enemy attack is on the player's current pokemon
; edited: it will now take into account various levels of effectiveness
; the result is stored in [wTypeEffectiveness]
; (0 is not effective, 1 double not effective, 2 not effective, 4 neutral, 8 super effective, 16 double super effective)
; edited: it's (ab)used by ApplyEntryHazardsPlayer and ApplyEntryHazardsEnemy by loading ROCK in [wEnemyMoveType]
AIGetTypeEffectiveness::
	ld a, [wCurOpponent]
	cp OPP_GONQUE
	jr nz, .noGonque
.randomizeTheChart
	jpfar AIGetTypeEffectivenessRandomizedChart
.noGonque
	ld a, [wRandomizationTypeChart]
	and a
	jr nz, .randomizeTheChart

;.notRandomizedTypeChart
	ld a, [wEnemyMoveType]
	ld d, a                    ; d = type of enemy move

	ld a, 10
	ld [wTypeEffectiveness], a ; initialize to neutral effectiveness
	ld hl, TypeEffects
; new, load Inverse Battle chart on demand; 0 for normal, 1 for inverse
	ld a, [wInverseBattle]
	and a
    jr z, .continue
    ld hl, TypeEffectsInverse
.continue
; back to vanilla
	push hl ; to re-use it for the second check, if any

	ld a, [wBattleMonType1]
	ld b, a ; b = type 1 of player's pokemon
	push bc ; to preserve the type 1
.loop1
	ld a, [hli]
	cp $ff
	jp z, .exitLoop1
	cp d                      ; match the type of the move
	jr nz, .nextTypePair11
	ld a, [hli]
	cp b                      ; match with type 1 of player's pokemon
	jr z, .done1
	jr .nextTypePair21
.nextTypePair11
	inc hl
.nextTypePair21
	inc hl
	jr .loop1
.done1
	ld a, [hl]
	ld [wTypeEffectiveness], a ; store damage multiplier
.exitLoop1

	ld a, 5 ; we divide by 5
	ldh [hDivisor], a
	ld a, [wTypeEffectiveness]
	ldh [hDividend], a
	ld b, 1
	call Divide ; we divide the type effectivness by 5: 0 for not effective, 1 for not very, 2 for normal, 4 for super
	; now [hQuotient + 3] contains the scaled-down effectiveness

	pop bc ; to restore the type 1
	pop hl ; restore the pointer to the effectiveness chart

	ld a, [wBattleMonType2]
	cp b
	jr nz, .secondTypeCheck
; we don't check the same type twice for a monotype mon
	ldh a, [hQuotient+3]
	add a ; we double the current value, i.e. we multiply by 2, which happens to be the neutral damage of the "copy" of the only one type we have
	jr .completing

.secondTypeCheck
	ld b, a ; b = type 2 of player's pokemon

	ld a, 10
	ld [wTypeEffectiveness], a ; initialize to neutral effectiveness (in case we find no matches)
.loop2
	ld a, [hli]
	cp $ff
	jp z, .exitLoop2
	cp d                      ; match the type of the move
	jr nz, .nextTypePair12
	ld a, [hli]
	cp b                      ; match with type 2 of player's pokemon
	jr z, .done2
	jr .nextTypePair22
.nextTypePair12
	inc hl
.nextTypePair22
	inc hl
	jr .loop2
.done2
	ld a, [hl]
	ld [wTypeEffectiveness], a ; store damage multiplier
.exitLoop2

	xor a
	ldh [hMultiplicand], a
	ld a, [wTypeEffectiveness]
	ldh [hMultiplier], a
	call Multiply ; we have Effectivness1 / 5 * Effectivness2, which is at most 4*20=80<255, so still 1 byte

	ld a, 5
	ldh [hDivisor], a
	ld b, 4
	call Divide

	ldh a, [hQuotient + 3] ; now a contains Effectivness1 / 5 * Effectivness2 / 5:
						   ; 0 for not effective
						   ; 1 for 1/4
						   ; 2 for 1/2
						   ; 4 for 1
						   ; 8 for 2
						   ; 16 for 4
.completing
	ld [wTypeEffectiveness], a
	ret

; ====================================================================

TypeEffects:
	;  attacker,     defender,     *=
	db WATER,        FIRE,         SUPER_EFFECTIVE
	db WATER,        ROCK,         SUPER_EFFECTIVE
	db WATER,        GROUND,       SUPER_EFFECTIVE
	db WATER,        WATER,        NOT_VERY_EFFECTIVE
	db WATER,        GRASS,        NOT_VERY_EFFECTIVE
	db WATER,        DRAGON,       NOT_VERY_EFFECTIVE

	db FIRE,         GRASS,        SUPER_EFFECTIVE
	db FIRE,         ICE,          SUPER_EFFECTIVE
	db FIRE,         BUG,          SUPER_EFFECTIVE
	db FIRE,         STEEL,        SUPER_EFFECTIVE
	db FIRE,         FIRE,         NOT_VERY_EFFECTIVE
	db FIRE,         WATER,        NOT_VERY_EFFECTIVE
	db FIRE,         ROCK,         NOT_VERY_EFFECTIVE
	db FIRE,         DRAGON,       NOT_VERY_EFFECTIVE

	db GRASS,        WATER,        SUPER_EFFECTIVE
	db GRASS,        GROUND,       SUPER_EFFECTIVE
	db GRASS,        ROCK,         SUPER_EFFECTIVE
	db GRASS,        GRASS,        NOT_VERY_EFFECTIVE
	db GRASS,        FIRE,         NOT_VERY_EFFECTIVE
	db GRASS,        BUG,          NOT_VERY_EFFECTIVE
	db GRASS,        POISON,       NOT_VERY_EFFECTIVE
	db GRASS,        FLYING,       NOT_VERY_EFFECTIVE
	db GRASS,        DRAGON,       NOT_VERY_EFFECTIVE
	db GRASS,        STEEL,        NOT_VERY_EFFECTIVE

	db ELECTRIC,     WATER,        SUPER_EFFECTIVE
	db ELECTRIC,     FLYING,       SUPER_EFFECTIVE
	db ELECTRIC,     ELECTRIC,     NOT_VERY_EFFECTIVE
	db ELECTRIC,     GRASS,        NOT_VERY_EFFECTIVE
	db ELECTRIC,     DRAGON,       NOT_VERY_EFFECTIVE
	db ELECTRIC,     GROUND,       NO_EFFECT

	db ICE,          GRASS,        SUPER_EFFECTIVE
	db ICE,          GROUND,       SUPER_EFFECTIVE
	db ICE,          FLYING,       SUPER_EFFECTIVE
	db ICE,          DRAGON,       SUPER_EFFECTIVE
	db ICE,          ICE,          NOT_VERY_EFFECTIVE
	db ICE,          WATER,        NOT_VERY_EFFECTIVE
	db ICE,          FIRE,         NOT_VERY_EFFECTIVE
	db ICE,          STEEL,        NOT_VERY_EFFECTIVE

	db ICE2,         GRASS,        SUPER_EFFECTIVE
	db ICE2,         GROUND,       SUPER_EFFECTIVE
	db ICE2,         FLYING,       SUPER_EFFECTIVE
	db ICE2,         DRAGON,       SUPER_EFFECTIVE
	db ICE2,         WATER,        SUPER_EFFECTIVE
	db ICE2,         ICE,          NOT_VERY_EFFECTIVE
	db ICE2,         FIRE,         NOT_VERY_EFFECTIVE
	db ICE2,         STEEL,        NOT_VERY_EFFECTIVE

	db PSYCHIC_TYPE, FIGHTING,     SUPER_EFFECTIVE
	db PSYCHIC_TYPE, POISON,       SUPER_EFFECTIVE
	db PSYCHIC_TYPE, PSYCHIC_TYPE, NOT_VERY_EFFECTIVE
	db PSYCHIC_TYPE, STEEL,        NOT_VERY_EFFECTIVE
	db PSYCHIC_TYPE, DARK,         NO_EFFECT

	db DRAGON,       DRAGON,       SUPER_EFFECTIVE
	db DRAGON,       STEEL,        NOT_VERY_EFFECTIVE
	db DRAGON,       FAIRY,        NO_EFFECT

	db DARK,         PSYCHIC_TYPE, SUPER_EFFECTIVE
	db DARK,         GHOST,        SUPER_EFFECTIVE
	db DARK,         FIGHTING,     NOT_VERY_EFFECTIVE
	db DARK,         FAIRY,        NOT_VERY_EFFECTIVE
	db DARK,         DARK,         NOT_VERY_EFFECTIVE

	db FAIRY,        FIGHTING,     SUPER_EFFECTIVE
	db FAIRY,        DRAGON,       SUPER_EFFECTIVE
	db FAIRY,        DARK,         SUPER_EFFECTIVE
	db FAIRY,        FIRE,         NOT_VERY_EFFECTIVE
	db FAIRY,        POISON,       NOT_VERY_EFFECTIVE
	db FAIRY,        STEEL,        NOT_VERY_EFFECTIVE

	db NORMAL,       ROCK,         NOT_VERY_EFFECTIVE
	db NORMAL,       STEEL,        NOT_VERY_EFFECTIVE
	db NORMAL,       GHOST,        NO_EFFECT

	db GHOST,        GHOST,        SUPER_EFFECTIVE
	db GHOST,        PSYCHIC_TYPE, SUPER_EFFECTIVE
	db GHOST,        DARK,         NOT_VERY_EFFECTIVE
	db GHOST,        NORMAL,       NO_EFFECT

	db FIGHTING,     NORMAL,       SUPER_EFFECTIVE
	db FIGHTING,     ROCK,         SUPER_EFFECTIVE
	db FIGHTING,     ICE,          SUPER_EFFECTIVE
	db FIGHTING,     DARK,         SUPER_EFFECTIVE
	db FIGHTING,     STEEL,        SUPER_EFFECTIVE
	db FIGHTING,     POISON,       NOT_VERY_EFFECTIVE
	db FIGHTING,     FLYING,       NOT_VERY_EFFECTIVE
	db FIGHTING,     PSYCHIC_TYPE, NOT_VERY_EFFECTIVE
	db FIGHTING,     BUG,          NOT_VERY_EFFECTIVE
	db FIGHTING,     FAIRY,        NOT_VERY_EFFECTIVE
	db FIGHTING,     GHOST,        NO_EFFECT

	db POISON,       GRASS,        SUPER_EFFECTIVE
	db POISON,       FAIRY,        SUPER_EFFECTIVE
	db POISON,       POISON,       NOT_VERY_EFFECTIVE
	db POISON,       GROUND,       NOT_VERY_EFFECTIVE
	db POISON,       ROCK,         NOT_VERY_EFFECTIVE
	db POISON,       GHOST,        NOT_VERY_EFFECTIVE
	db POISON,       STEEL,        NO_EFFECT

	db FLYING,       FIGHTING,     SUPER_EFFECTIVE
	db FLYING,       BUG,          SUPER_EFFECTIVE
	db FLYING,       GRASS,        SUPER_EFFECTIVE
	db FLYING,       ELECTRIC,     NOT_VERY_EFFECTIVE
	db FLYING,       ROCK,         NOT_VERY_EFFECTIVE
	db FLYING,       STEEL,        NOT_VERY_EFFECTIVE

	db BUG,          GRASS,        SUPER_EFFECTIVE
	db BUG,          PSYCHIC_TYPE, SUPER_EFFECTIVE
	db BUG,          DARK,         SUPER_EFFECTIVE
	db BUG,          POISON,       NOT_VERY_EFFECTIVE
	db BUG,          FIRE,         NOT_VERY_EFFECTIVE
	db BUG,          FIGHTING,     NOT_VERY_EFFECTIVE
	db BUG,          FLYING,       NOT_VERY_EFFECTIVE
	db BUG,          GHOST,        NOT_VERY_EFFECTIVE
	db BUG,          STEEL,        NOT_VERY_EFFECTIVE
	db BUG,          FAIRY,        NOT_VERY_EFFECTIVE

	db GROUND,       FIRE,         SUPER_EFFECTIVE
	db GROUND,       ELECTRIC,     SUPER_EFFECTIVE
	db GROUND,       ROCK,         SUPER_EFFECTIVE
	db GROUND,       POISON,       SUPER_EFFECTIVE
	db GROUND,       STEEL,        SUPER_EFFECTIVE
	db GROUND,       GRASS,        NOT_VERY_EFFECTIVE
	db GROUND,       BUG,          NOT_VERY_EFFECTIVE
	db GROUND,       FLYING,       NO_EFFECT

	; new, for THOUSANDARROWS
	db GROUND2,      FIRE,         SUPER_EFFECTIVE
	db GROUND2,      ELECTRIC,     SUPER_EFFECTIVE
	db GROUND2,      ROCK,         SUPER_EFFECTIVE
	db GROUND2,      POISON,       SUPER_EFFECTIVE
	db GROUND2,      STEEL,        SUPER_EFFECTIVE
	db GROUND2,      GRASS,        NOT_VERY_EFFECTIVE
	db GROUND2,      BUG,          NOT_VERY_EFFECTIVE

	db ROCK,         FIRE,         SUPER_EFFECTIVE
	db ROCK,         FLYING,       SUPER_EFFECTIVE
	db ROCK,         BUG,          SUPER_EFFECTIVE
	db ROCK,         ICE,          SUPER_EFFECTIVE
	db ROCK,         FIGHTING,     NOT_VERY_EFFECTIVE
	db ROCK,         GROUND,       NOT_VERY_EFFECTIVE
	db ROCK,         STEEL,        NOT_VERY_EFFECTIVE

	db STEEL,        ICE,          SUPER_EFFECTIVE
	db STEEL,        ROCK,         SUPER_EFFECTIVE
	db STEEL,        FAIRY,        SUPER_EFFECTIVE
	db STEEL,        FIRE,         NOT_VERY_EFFECTIVE
	db STEEL,        WATER,        NOT_VERY_EFFECTIVE
	db STEEL,        ELECTRIC,     NOT_VERY_EFFECTIVE
	db STEEL,        STEEL,        NOT_VERY_EFFECTIVE

	db -1 ; end

TypeEffectsInverse:
	;  attacker,     defender,     *=
	db WATER,        FIRE,         NOT_VERY_EFFECTIVE
	db WATER,        ROCK,         NOT_VERY_EFFECTIVE
	db WATER,        GROUND,       NOT_VERY_EFFECTIVE
	db WATER,        WATER,        SUPER_EFFECTIVE
	db WATER,        GRASS,        SUPER_EFFECTIVE
	db WATER,        DRAGON,       SUPER_EFFECTIVE

	db FIRE,         GRASS,        NOT_VERY_EFFECTIVE
	db FIRE,         ICE,          NOT_VERY_EFFECTIVE
	db FIRE,         BUG,          NOT_VERY_EFFECTIVE
	db FIRE,         STEEL,        NOT_VERY_EFFECTIVE
	db FIRE,         FIRE,         SUPER_EFFECTIVE
	db FIRE,         WATER,        SUPER_EFFECTIVE
	db FIRE,         ROCK,         SUPER_EFFECTIVE
	db FIRE,         DRAGON,       SUPER_EFFECTIVE

	db GRASS,        WATER,        NOT_VERY_EFFECTIVE
	db GRASS,        GROUND,       NOT_VERY_EFFECTIVE
	db GRASS,        ROCK,         NOT_VERY_EFFECTIVE
	db GRASS,        GRASS,        SUPER_EFFECTIVE
	db GRASS,        FIRE,         SUPER_EFFECTIVE
	db GRASS,        BUG,          SUPER_EFFECTIVE
	db GRASS,        POISON,       SUPER_EFFECTIVE
	db GRASS,        FLYING,       SUPER_EFFECTIVE
	db GRASS,        DRAGON,       SUPER_EFFECTIVE
	db GRASS,        STEEL,        SUPER_EFFECTIVE

	db ELECTRIC,     WATER,        NOT_VERY_EFFECTIVE
	db ELECTRIC,     FLYING,       NOT_VERY_EFFECTIVE
	db ELECTRIC,     ELECTRIC,     SUPER_EFFECTIVE
	db ELECTRIC,     GRASS,        SUPER_EFFECTIVE
	db ELECTRIC,     DRAGON,       SUPER_EFFECTIVE
	db ELECTRIC,     GROUND,       SUPER_EFFECTIVE

	db ICE,          GRASS,        NOT_VERY_EFFECTIVE
	db ICE,          GROUND,       NOT_VERY_EFFECTIVE
	db ICE,          FLYING,       NOT_VERY_EFFECTIVE
	db ICE,          DRAGON,       NOT_VERY_EFFECTIVE
	db ICE,          ICE,          SUPER_EFFECTIVE
	db ICE,          WATER,        SUPER_EFFECTIVE
	db ICE,          FIRE,         SUPER_EFFECTIVE
	db ICE,          STEEL,        SUPER_EFFECTIVE

	db ICE2,         GRASS,        NOT_VERY_EFFECTIVE
	db ICE2,         GROUND,       NOT_VERY_EFFECTIVE
	db ICE2,         FLYING,       NOT_VERY_EFFECTIVE
	db ICE2,         DRAGON,       NOT_VERY_EFFECTIVE
	db ICE2,         ICE,          SUPER_EFFECTIVE
	db ICE2,         WATER,        SUPER_EFFECTIVE
	db ICE2,         FIRE,         SUPER_EFFECTIVE
	db ICE2,         STEEL,        SUPER_EFFECTIVE

	db PSYCHIC_TYPE, FIGHTING,     NOT_VERY_EFFECTIVE
	db PSYCHIC_TYPE, POISON,       NOT_VERY_EFFECTIVE
	db PSYCHIC_TYPE, PSYCHIC_TYPE, SUPER_EFFECTIVE
	db PSYCHIC_TYPE, STEEL,        SUPER_EFFECTIVE
	db PSYCHIC_TYPE, DARK,         SUPER_EFFECTIVE

	db DRAGON,       DRAGON,       NOT_VERY_EFFECTIVE
	db DRAGON,       STEEL,        SUPER_EFFECTIVE
	db DRAGON,       FAIRY,        SUPER_EFFECTIVE

	db DARK,         PSYCHIC_TYPE, NOT_VERY_EFFECTIVE
	db DARK,         GHOST,        NOT_VERY_EFFECTIVE
	db DARK,         FIGHTING,     SUPER_EFFECTIVE
	db DARK,         FAIRY,        SUPER_EFFECTIVE
	db DARK,         DARK,         SUPER_EFFECTIVE

	db FAIRY,        FIGHTING,     NOT_VERY_EFFECTIVE
	db FAIRY,        DRAGON,       NOT_VERY_EFFECTIVE
	db FAIRY,        DARK,         NOT_VERY_EFFECTIVE
	db FAIRY,        FIRE,         SUPER_EFFECTIVE
	db FAIRY,        POISON,       SUPER_EFFECTIVE
	db FAIRY,        STEEL,        SUPER_EFFECTIVE

	db NORMAL,       ROCK,         SUPER_EFFECTIVE
	db NORMAL,       STEEL,        SUPER_EFFECTIVE
	db NORMAL,       GHOST,        SUPER_EFFECTIVE

	db GHOST,        GHOST,        NOT_VERY_EFFECTIVE
	db GHOST,        PSYCHIC_TYPE, NOT_VERY_EFFECTIVE
	db GHOST,        DARK,         SUPER_EFFECTIVE
	db GHOST,        NORMAL,       SUPER_EFFECTIVE

	db FIGHTING,     NORMAL,       NOT_VERY_EFFECTIVE
	db FIGHTING,     ROCK,         NOT_VERY_EFFECTIVE
	db FIGHTING,     ICE,          NOT_VERY_EFFECTIVE
	db FIGHTING,     DARK,         NOT_VERY_EFFECTIVE
	db FIGHTING,     STEEL,        NOT_VERY_EFFECTIVE
	db FIGHTING,     POISON,       SUPER_EFFECTIVE
	db FIGHTING,     FLYING,       SUPER_EFFECTIVE
	db FIGHTING,     PSYCHIC_TYPE, SUPER_EFFECTIVE
	db FIGHTING,     BUG,          SUPER_EFFECTIVE
	db FIGHTING,     FAIRY,        SUPER_EFFECTIVE
	db FIGHTING,     GHOST,        SUPER_EFFECTIVE

	db POISON,       GRASS,        NOT_VERY_EFFECTIVE
	db POISON,       FAIRY,        NOT_VERY_EFFECTIVE
	db POISON,       POISON,       SUPER_EFFECTIVE
	db POISON,       GROUND,       SUPER_EFFECTIVE
	db POISON,       ROCK,         SUPER_EFFECTIVE
	db POISON,       GHOST,        SUPER_EFFECTIVE
	db POISON,       STEEL,        SUPER_EFFECTIVE

	db FLYING,       FIGHTING,     NOT_VERY_EFFECTIVE
	db FLYING,       BUG,          NOT_VERY_EFFECTIVE
	db FLYING,       GRASS,        NOT_VERY_EFFECTIVE
	db FLYING,       ELECTRIC,     SUPER_EFFECTIVE
	db FLYING,       ROCK,         SUPER_EFFECTIVE
	db FLYING,       STEEL,        SUPER_EFFECTIVE

	db BUG,          GRASS,        NOT_VERY_EFFECTIVE
	db BUG,          PSYCHIC_TYPE, NOT_VERY_EFFECTIVE
	db BUG,          DARK,         NOT_VERY_EFFECTIVE
	db BUG,          POISON,       SUPER_EFFECTIVE
	db BUG,          FIRE,         SUPER_EFFECTIVE
	db BUG,          FIGHTING,     SUPER_EFFECTIVE
	db BUG,          FLYING,       SUPER_EFFECTIVE
	db BUG,          GHOST,        SUPER_EFFECTIVE
	db BUG,          STEEL,        SUPER_EFFECTIVE
	db BUG,          FAIRY,        SUPER_EFFECTIVE

	db GROUND,       FIRE,         NOT_VERY_EFFECTIVE
	db GROUND,       ELECTRIC,     NOT_VERY_EFFECTIVE
	db GROUND,       ROCK,         NOT_VERY_EFFECTIVE
	db GROUND,       POISON,       NOT_VERY_EFFECTIVE
	db GROUND,       STEEL,        NOT_VERY_EFFECTIVE
	db GROUND,       GRASS,        SUPER_EFFECTIVE
	db GROUND,       BUG,          SUPER_EFFECTIVE
	db GROUND,       FLYING,       SUPER_EFFECTIVE

	; new, for THOUSANDARROWS
	db GROUND2,      FIRE,         NOT_VERY_EFFECTIVE
	db GROUND2,      ELECTRIC,     NOT_VERY_EFFECTIVE
	db GROUND2,      ROCK,         NOT_VERY_EFFECTIVE
	db GROUND2,      POISON,       NOT_VERY_EFFECTIVE
	db GROUND2,      STEEL,        NOT_VERY_EFFECTIVE
	db GROUND2,      GRASS,        SUPER_EFFECTIVE
	db GROUND2,      BUG,          SUPER_EFFECTIVE
	db GROUND2,      FLYING,       SUPER_EFFECTIVE

	db ROCK,         FIRE,         NOT_VERY_EFFECTIVE
	db ROCK,         FLYING,       NOT_VERY_EFFECTIVE
	db ROCK,         BUG,          NOT_VERY_EFFECTIVE
	db ROCK,         ICE,          NOT_VERY_EFFECTIVE
	db ROCK,         FIGHTING,     SUPER_EFFECTIVE
	db ROCK,         GROUND,       SUPER_EFFECTIVE
	db ROCK,         STEEL,        SUPER_EFFECTIVE

	db STEEL,        ICE,          NOT_VERY_EFFECTIVE
	db STEEL,        ROCK,         NOT_VERY_EFFECTIVE
	db STEEL,        FAIRY,        NOT_VERY_EFFECTIVE
	db STEEL,        FIRE,         SUPER_EFFECTIVE
	db STEEL,        WATER,        SUPER_EFFECTIVE
	db STEEL,        ELECTRIC,     SUPER_EFFECTIVE
	db STEEL,        STEEL,        SUPER_EFFECTIVE

	db -1 ; end

; ====================================================================

TypeEffects_Pigeon:
	;  attacker,     defender,     *=

	db NORMAL,       FAIRY,        SUPER_EFFECTIVE
	db NORMAL,       ROCK,         NOT_VERY_EFFECTIVE
	db NORMAL,       STEEL,        NOT_VERY_EFFECTIVE
	db NORMAL,       FLYING,       NOT_VERY_EFFECTIVE
	db NORMAL,       GHOST,        NO_EFFECT

	db FIRE,         GRASS,        SUPER_EFFECTIVE
	db FIRE,         ICE,          SUPER_EFFECTIVE
	db FIRE,         BUG,          SUPER_EFFECTIVE
	db FIRE,         STEEL,        SUPER_EFFECTIVE
	db FIRE,         GHOST,        SUPER_EFFECTIVE
	db FIRE,         FIRE,         NOT_VERY_EFFECTIVE
	db FIRE,         WATER,        NOT_VERY_EFFECTIVE
	db FIRE,         FIGHTING,     NOT_VERY_EFFECTIVE
	db FIRE,         ROCK,         NOT_VERY_EFFECTIVE
	db FIRE,         DRAGON,       NOT_VERY_EFFECTIVE

	db WATER,        FIRE,         SUPER_EFFECTIVE
	db WATER,        POISON,       SUPER_EFFECTIVE ; ?
	db WATER,        ROCK,         SUPER_EFFECTIVE
	db WATER,        GHOST,        SUPER_EFFECTIVE
	db WATER,        STEEL,        SUPER_EFFECTIVE
	db WATER,        WATER,        NOT_VERY_EFFECTIVE
	db WATER,        GRASS,        NOT_VERY_EFFECTIVE
	db WATER,        FIGHTING,     NOT_VERY_EFFECTIVE
	db WATER,        GROUND,       NOT_VERY_EFFECTIVE
	db WATER,        FLYING,       NOT_VERY_EFFECTIVE
	db WATER,        DRAGON,       NOT_VERY_EFFECTIVE

	db ELECTRIC,     WATER,        SUPER_EFFECTIVE
	db ELECTRIC,     GROUND,       SUPER_EFFECTIVE
	db ELECTRIC,     GHOST,        SUPER_EFFECTIVE
	db ELECTRIC,     STEEL,        SUPER_EFFECTIVE
	db ELECTRIC,     ELECTRIC,     NOT_VERY_EFFECTIVE
	db ELECTRIC,     FIRE,         NOT_VERY_EFFECTIVE
	db ELECTRIC,     DRAGON,       NOT_VERY_EFFECTIVE

	db GRASS,        WATER,        SUPER_EFFECTIVE
	db GRASS,        GROUND,       SUPER_EFFECTIVE
	db GRASS,        GHOST,        SUPER_EFFECTIVE
	db GRASS,        GRASS,        NOT_VERY_EFFECTIVE
	db GRASS,        FIRE,         NOT_VERY_EFFECTIVE
	db GRASS,        FLYING,       NOT_VERY_EFFECTIVE
	db GRASS,        DRAGON,       NOT_VERY_EFFECTIVE
	db GRASS,        STEEL,        NOT_VERY_EFFECTIVE

	db ICE,          GRASS,        SUPER_EFFECTIVE
	db ICE,          BUG,          SUPER_EFFECTIVE
	db ICE,          GHOST,        SUPER_EFFECTIVE
	db ICE,          FIRE,         SUPER_EFFECTIVE
	db ICE,          ICE,          NOT_VERY_EFFECTIVE
	db ICE,          WATER,        NOT_VERY_EFFECTIVE
	db ICE,          STEEL,        NOT_VERY_EFFECTIVE
	db ICE,          FIGHTING,     NOT_VERY_EFFECTIVE
	db ICE,          DRAGON,       NOT_VERY_EFFECTIVE

	db ICE2,         GRASS,        SUPER_EFFECTIVE
	db ICE2,         BUG,          SUPER_EFFECTIVE
	db ICE2,         GHOST,        SUPER_EFFECTIVE
	db ICE2,         FIRE,         SUPER_EFFECTIVE
	db ICE2,         WATER,        SUPER_EFFECTIVE
	db ICE2,         ICE,          NOT_VERY_EFFECTIVE
	db ICE2,         STEEL,        NOT_VERY_EFFECTIVE
	db ICE2,         FIGHTING,     NOT_VERY_EFFECTIVE
	db ICE2,         DRAGON,       NOT_VERY_EFFECTIVE

	db FIGHTING,     DARK,         SUPER_EFFECTIVE
	db FIGHTING,     DRAGON,       SUPER_EFFECTIVE
	db FIGHTING,     FLYING,       NOT_VERY_EFFECTIVE
	db FIGHTING,     PSYCHIC_TYPE, NOT_VERY_EFFECTIVE
	db FIGHTING,     STEEL,        NOT_VERY_EFFECTIVE
	db FIGHTING,     GHOST,        NO_EFFECT

	db POISON,       GRASS,        SUPER_EFFECTIVE
	db POISON,       GROUND,       SUPER_EFFECTIVE
	db POISON,       BUG,          SUPER_EFFECTIVE
	db POISON,       FAIRY,        SUPER_EFFECTIVE
	db POISON,       WATER,        NOT_VERY_EFFECTIVE
	db POISON,       FIGHTING,     NOT_VERY_EFFECTIVE
	db POISON,       ROCK,         NOT_VERY_EFFECTIVE
	db POISON,       DARK,         NOT_VERY_EFFECTIVE
	db POISON,       STEEL,        NOT_VERY_EFFECTIVE
	db POISON,       GHOST,        NO_EFFECT
	db POISON,       POISON,       NO_EFFECT

	db GROUND,       FIRE,         SUPER_EFFECTIVE
	db GROUND,       ELECTRIC,     SUPER_EFFECTIVE
	db GROUND,       WATER,        SUPER_EFFECTIVE
	db GROUND,       STEEL,        SUPER_EFFECTIVE
	db GROUND,       GRASS,        NOT_VERY_EFFECTIVE
	db GROUND,       BUG,          NOT_VERY_EFFECTIVE
	db GROUND,       GROUND,       NOT_VERY_EFFECTIVE
	db GROUND,       GHOST,        NO_EFFECT
	db GROUND,       FLYING,       NO_EFFECT

	db GROUND2,      FIRE,         SUPER_EFFECTIVE
	db GROUND2,      ELECTRIC,     SUPER_EFFECTIVE
	db GROUND2,      WATER,        SUPER_EFFECTIVE
	db GROUND2,      STEEL,        SUPER_EFFECTIVE
	db GROUND2,      GRASS,        NOT_VERY_EFFECTIVE
	db GROUND2,      BUG,          NOT_VERY_EFFECTIVE
	db GROUND2,      GROUND,       NOT_VERY_EFFECTIVE
	db GROUND2,      GHOST,        NO_EFFECT

	db FLYING,       BUG,          SUPER_EFFECTIVE
	db FLYING,       GROUND,       NOT_VERY_EFFECTIVE
	db FLYING,       ROCK,         NOT_VERY_EFFECTIVE
	db FLYING,       STEEL,        NOT_VERY_EFFECTIVE
	db FLYING,       GHOST,        NO_EFFECT

	db PSYCHIC_TYPE, FIGHTING,     SUPER_EFFECTIVE
	db PSYCHIC_TYPE, GHOST,        SUPER_EFFECTIVE
	db PSYCHIC_TYPE, DARK,         SUPER_EFFECTIVE
	db PSYCHIC_TYPE, STEEL,        SUPER_EFFECTIVE
	db PSYCHIC_TYPE, ELECTRIC,     NOT_VERY_EFFECTIVE ; ?
	db PSYCHIC_TYPE, GRASS,        NOT_VERY_EFFECTIVE ; ?
	db PSYCHIC_TYPE, PSYCHIC_TYPE, NOT_VERY_EFFECTIVE
	db PSYCHIC_TYPE, BUG,          NOT_VERY_EFFECTIVE

	db BUG,          GRASS,        SUPER_EFFECTIVE
	db BUG,          PSYCHIC_TYPE, SUPER_EFFECTIVE
	db BUG,          DRAGON,       SUPER_EFFECTIVE
	db BUG,          ICE,          NOT_VERY_EFFECTIVE
	db BUG,          FIRE,         NOT_VERY_EFFECTIVE
	db BUG,          FLYING,       NOT_VERY_EFFECTIVE
	db BUG,          STEEL,        NOT_VERY_EFFECTIVE
	db BUG,          GHOST,        NO_EFFECT

	db ROCK,         FLYING,       SUPER_EFFECTIVE
	db ROCK,         BUG,          SUPER_EFFECTIVE
	db ROCK,         WATER,        NOT_VERY_EFFECTIVE
	db ROCK,         STEEL,        NOT_VERY_EFFECTIVE
	db ROCK,         GHOST,        NO_EFFECT

	db GHOST,        PSYCHIC_TYPE, SUPER_EFFECTIVE
	db GHOST,        BUG,          NOT_VERY_EFFECTIVE
	db GHOST,        DARK,         NOT_VERY_EFFECTIVE
	db GHOST,        STEEL,        NOT_VERY_EFFECTIVE
	db GHOST,        FAIRY,        NOT_VERY_EFFECTIVE
	db GHOST,        GROUND,       NO_EFFECT ; ? SUPER_EFFECTIVE?

	db DRAGON,       FIRE,         SUPER_EFFECTIVE
	db DRAGON,       WATER,        SUPER_EFFECTIVE
	db DRAGON,       ELECTRIC,     SUPER_EFFECTIVE
	db DRAGON,       GRASS,        SUPER_EFFECTIVE
	db DRAGON,       ICE,          SUPER_EFFECTIVE
	db DRAGON,       DRAGON,       SUPER_EFFECTIVE
	db DRAGON,       GHOST,        SUPER_EFFECTIVE
	db DRAGON,       STEEL,        NOT_VERY_EFFECTIVE
	db DRAGON,       BUG,          NOT_VERY_EFFECTIVE

	db DARK,         PSYCHIC_TYPE, SUPER_EFFECTIVE
	db DARK,         GHOST,        SUPER_EFFECTIVE
	db DARK,         FAIRY,        SUPER_EFFECTIVE
	db DARK,         FIGHTING,     NOT_VERY_EFFECTIVE
	db DARK,         POISON,       NOT_VERY_EFFECTIVE ; ?
	db DARK,         BUG,          NOT_VERY_EFFECTIVE
	db DARK,         DARK,         NOT_VERY_EFFECTIVE

	db STEEL,        ICE,          SUPER_EFFECTIVE
	db STEEL,        GROUND,       SUPER_EFFECTIVE
	db STEEL,        ROCK,         SUPER_EFFECTIVE
	db STEEL,        FAIRY,        SUPER_EFFECTIVE
	db STEEL,        FIRE,         NOT_VERY_EFFECTIVE
	db STEEL,        WATER,        NOT_VERY_EFFECTIVE
	db STEEL,        ELECTRIC,     NOT_VERY_EFFECTIVE
	db STEEL,        PSYCHIC_TYPE, NOT_VERY_EFFECTIVE ; ?
	db STEEL,        STEEL,        NOT_VERY_EFFECTIVE
	db STEEL,        GHOST,        NO_EFFECT

	db FAIRY,        GHOST,        SUPER_EFFECTIVE
	db FAIRY,        DARK,         SUPER_EFFECTIVE
	db FAIRY,        FIRE,         NOT_VERY_EFFECTIVE
	db FAIRY,        POISON,       NOT_VERY_EFFECTIVE
	db FAIRY,        GRASS,        NOT_VERY_EFFECTIVE
	db FAIRY,        BUG,          NOT_VERY_EFFECTIVE
	db FAIRY,        STEEL,        NOT_VERY_EFFECTIVE

	db -1 ; end

; ====================================================================

TypeEffects_PigeonInverse:
	;  attacker,     defender,     *=

	db NORMAL,       FAIRY,        NOT_VERY_EFFECTIVE
	db NORMAL,       ROCK,         SUPER_EFFECTIVE
	db NORMAL,       STEEL,        SUPER_EFFECTIVE
	db NORMAL,       FLYING,       SUPER_EFFECTIVE
	db NORMAL,       GHOST,        SUPER_EFFECTIVE

	db FIRE,         GRASS,        NOT_VERY_EFFECTIVE
	db FIRE,         ICE,          NOT_VERY_EFFECTIVE
	db FIRE,         BUG,          NOT_VERY_EFFECTIVE
	db FIRE,         STEEL,        NOT_VERY_EFFECTIVE
	db FIRE,         GHOST,        NOT_VERY_EFFECTIVE
	db FIRE,         FIRE,         SUPER_EFFECTIVE
	db FIRE,         WATER,        SUPER_EFFECTIVE
	db FIRE,         FIGHTING,     SUPER_EFFECTIVE
	db FIRE,         ROCK,         SUPER_EFFECTIVE
	db FIRE,         DRAGON,       SUPER_EFFECTIVE

	db WATER,        FIRE,         NOT_VERY_EFFECTIVE
	db WATER,        POISON,       NOT_VERY_EFFECTIVE ; ?
	db WATER,        ROCK,         NOT_VERY_EFFECTIVE
	db WATER,        GHOST,        NOT_VERY_EFFECTIVE
	db WATER,        STEEL,        NOT_VERY_EFFECTIVE
	db WATER,        WATER,        SUPER_EFFECTIVE
	db WATER,        GRASS,        SUPER_EFFECTIVE
	db WATER,        FIGHTING,     SUPER_EFFECTIVE
	db WATER,        GROUND,       SUPER_EFFECTIVE
	db WATER,        FLYING,       SUPER_EFFECTIVE
	db WATER,        DRAGON,       SUPER_EFFECTIVE

	db ELECTRIC,     WATER,        NOT_VERY_EFFECTIVE
	db ELECTRIC,     GROUND,       NOT_VERY_EFFECTIVE
	db ELECTRIC,     GHOST,        NOT_VERY_EFFECTIVE
	db ELECTRIC,     STEEL,        NOT_VERY_EFFECTIVE
	db ELECTRIC,     ELECTRIC,     SUPER_EFFECTIVE
	db ELECTRIC,     FIRE,         SUPER_EFFECTIVE
	db ELECTRIC,     DRAGON,       SUPER_EFFECTIVE

	db GRASS,        WATER,        NOT_VERY_EFFECTIVE
	db GRASS,        GROUND,       NOT_VERY_EFFECTIVE
	db GRASS,        GHOST,        NOT_VERY_EFFECTIVE
	db GRASS,        GRASS,        SUPER_EFFECTIVE
	db GRASS,        FIRE,         SUPER_EFFECTIVE
	db GRASS,        FLYING,       SUPER_EFFECTIVE
	db GRASS,        DRAGON,       SUPER_EFFECTIVE
	db GRASS,        STEEL,        SUPER_EFFECTIVE

	db ICE,          GRASS,        NOT_VERY_EFFECTIVE
	db ICE,          BUG,          NOT_VERY_EFFECTIVE
	db ICE,          GHOST,        NOT_VERY_EFFECTIVE
	db ICE,          FIRE,         NOT_VERY_EFFECTIVE
	db ICE,          ICE,          SUPER_EFFECTIVE
	db ICE,          WATER,        SUPER_EFFECTIVE
	db ICE,          STEEL,        SUPER_EFFECTIVE
	db ICE,          FIGHTING,     SUPER_EFFECTIVE
	db ICE,          DRAGON,       SUPER_EFFECTIVE

	db ICE2,         GRASS,        NOT_VERY_EFFECTIVE
	db ICE2,         BUG,          NOT_VERY_EFFECTIVE
	db ICE2,         GHOST,        NOT_VERY_EFFECTIVE
	db ICE2,         FIRE,         NOT_VERY_EFFECTIVE
	db ICE2,         WATER,        NOT_VERY_EFFECTIVE
	db ICE2,         ICE,          SUPER_EFFECTIVE
	db ICE2,         STEEL,        SUPER_EFFECTIVE
	db ICE2,         FIGHTING,     SUPER_EFFECTIVE
	db ICE2,         DRAGON,       SUPER_EFFECTIVE

	db FIGHTING,     DARK,         NOT_VERY_EFFECTIVE
	db FIGHTING,     DRAGON,       NOT_VERY_EFFECTIVE
	db FIGHTING,     FLYING,       SUPER_EFFECTIVE
	db FIGHTING,     PSYCHIC_TYPE, SUPER_EFFECTIVE
	db FIGHTING,     STEEL,        SUPER_EFFECTIVE
	db FIGHTING,     GHOST,        SUPER_EFFECTIVE

	db POISON,       GRASS,        NOT_VERY_EFFECTIVE
	db POISON,       GROUND,       NOT_VERY_EFFECTIVE
	db POISON,       BUG,          NOT_VERY_EFFECTIVE
	db POISON,       FAIRY,        NOT_VERY_EFFECTIVE
	db POISON,       WATER,        SUPER_EFFECTIVE
	db POISON,       FIGHTING,     SUPER_EFFECTIVE
	db POISON,       ROCK,         SUPER_EFFECTIVE
	db POISON,       DARK,         SUPER_EFFECTIVE
	db POISON,       STEEL,        SUPER_EFFECTIVE
	db POISON,       GHOST,        SUPER_EFFECTIVE
	db POISON,       POISON,       SUPER_EFFECTIVE

	db GROUND,       FIRE,         NOT_VERY_EFFECTIVE
	db GROUND,       ELECTRIC,     NOT_VERY_EFFECTIVE
	db GROUND,       WATER,        NOT_VERY_EFFECTIVE
	db GROUND,       STEEL,        NOT_VERY_EFFECTIVE
	db GROUND,       GRASS,        SUPER_EFFECTIVE
	db GROUND,       BUG,          SUPER_EFFECTIVE
	db GROUND,       GROUND,       SUPER_EFFECTIVE
	db GROUND,       GHOST,        SUPER_EFFECTIVE
	db GROUND,       FLYING,       SUPER_EFFECTIVE

	db GROUND2,      FIRE,         NOT_VERY_EFFECTIVE
	db GROUND2,      ELECTRIC,     NOT_VERY_EFFECTIVE
	db GROUND2,      WATER,        NOT_VERY_EFFECTIVE
	db GROUND2,      STEEL,        NOT_VERY_EFFECTIVE
	db GROUND2,      GRASS,        SUPER_EFFECTIVE
	db GROUND2,      BUG,          SUPER_EFFECTIVE
	db GROUND2,      GROUND,       SUPER_EFFECTIVE
	db GROUND2,      GHOST,        SUPER_EFFECTIVE

	db FLYING,       BUG,          NOT_VERY_EFFECTIVE
	db FLYING,       GROUND,       SUPER_EFFECTIVE
	db FLYING,       ROCK,         SUPER_EFFECTIVE
	db FLYING,       STEEL,        SUPER_EFFECTIVE
	db FLYING,       GHOST,        SUPER_EFFECTIVE

	db PSYCHIC_TYPE, FIGHTING,     NOT_VERY_EFFECTIVE
	db PSYCHIC_TYPE, GHOST,        NOT_VERY_EFFECTIVE
	db PSYCHIC_TYPE, DARK,         NOT_VERY_EFFECTIVE
	db PSYCHIC_TYPE, STEEL,        NOT_VERY_EFFECTIVE
	db PSYCHIC_TYPE, ELECTRIC,     SUPER_EFFECTIVE ; ?
	db PSYCHIC_TYPE, GRASS,        SUPER_EFFECTIVE ; ?
	db PSYCHIC_TYPE, PSYCHIC_TYPE, SUPER_EFFECTIVE
	db PSYCHIC_TYPE, BUG,          SUPER_EFFECTIVE

	db BUG,          GRASS,        NOT_VERY_EFFECTIVE
	db BUG,          PSYCHIC_TYPE, NOT_VERY_EFFECTIVE
	db BUG,          DRAGON,       NOT_VERY_EFFECTIVE
	db BUG,          ICE,          SUPER_EFFECTIVE
	db BUG,          FIRE,         SUPER_EFFECTIVE
	db BUG,          FLYING,       SUPER_EFFECTIVE
	db BUG,          STEEL,        SUPER_EFFECTIVE
	db BUG,          GHOST,        SUPER_EFFECTIVE

	db ROCK,         FLYING,       NOT_VERY_EFFECTIVE
	db ROCK,         BUG,          NOT_VERY_EFFECTIVE
	db ROCK,         WATER,        SUPER_EFFECTIVE
	db ROCK,         STEEL,        SUPER_EFFECTIVE
	db ROCK,         GHOST,        SUPER_EFFECTIVE

	db GHOST,        PSYCHIC_TYPE, NOT_VERY_EFFECTIVE
	db GHOST,        BUG,          SUPER_EFFECTIVE
	db GHOST,        DARK,         SUPER_EFFECTIVE
	db GHOST,        STEEL,        SUPER_EFFECTIVE
	db GHOST,        FAIRY,        SUPER_EFFECTIVE
	db GHOST,        GROUND,       SUPER_EFFECTIVE ; ? NOT_VERY_EFFECTIVE?

	db DRAGON,       FIRE,         NOT_VERY_EFFECTIVE
	db DRAGON,       WATER,        NOT_VERY_EFFECTIVE
	db DRAGON,       ELECTRIC,     NOT_VERY_EFFECTIVE
	db DRAGON,       GRASS,        NOT_VERY_EFFECTIVE
	db DRAGON,       ICE,          NOT_VERY_EFFECTIVE
	db DRAGON,       DRAGON,       NOT_VERY_EFFECTIVE
	db DRAGON,       GHOST,        NOT_VERY_EFFECTIVE
	db DRAGON,       STEEL,        SUPER_EFFECTIVE
	db DRAGON,       BUG,          SUPER_EFFECTIVE

	db DARK,         PSYCHIC_TYPE, NOT_VERY_EFFECTIVE
	db DARK,         GHOST,        NOT_VERY_EFFECTIVE
	db DARK,         FAIRY,        NOT_VERY_EFFECTIVE
	db DARK,         FIGHTING,     SUPER_EFFECTIVE
	db DARK,         POISON,       SUPER_EFFECTIVE ; ?
	db DARK,         BUG,          SUPER_EFFECTIVE
	db DARK,         DARK,         SUPER_EFFECTIVE

	db STEEL,        ICE,          NOT_VERY_EFFECTIVE
	db STEEL,        GROUND,       NOT_VERY_EFFECTIVE
	db STEEL,        ROCK,         NOT_VERY_EFFECTIVE
	db STEEL,        FAIRY,        NOT_VERY_EFFECTIVE
	db STEEL,        FIRE,         SUPER_EFFECTIVE
	db STEEL,        WATER,        SUPER_EFFECTIVE
	db STEEL,        ELECTRIC,     SUPER_EFFECTIVE
	db STEEL,        PSYCHIC_TYPE, SUPER_EFFECTIVE ; ?
	db STEEL,        STEEL,        SUPER_EFFECTIVE
	db STEEL,        GHOST,        SUPER_EFFECTIVE

	db FAIRY,        GHOST,        NOT_VERY_EFFECTIVE
	db FAIRY,        DARK,         NOT_VERY_EFFECTIVE
	db FAIRY,        FIRE,         SUPER_EFFECTIVE
	db FAIRY,        POISON,       SUPER_EFFECTIVE
	db FAIRY,        GRASS,        SUPER_EFFECTIVE
	db FAIRY,        BUG,          SUPER_EFFECTIVE
	db FAIRY,        STEEL,        SUPER_EFFECTIVE

	db -1 ; end
