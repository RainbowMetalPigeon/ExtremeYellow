; creates a set of moves that may be used and returns its address in hl
; unused slots are filled with 0, all used slots may be chosen with equal probability
AIEnemyTrainerChooseMoves:
	ld a, 10 ; $a
	ld hl, wBuffer ; init temporary move selection array. Only the moves with the lowest numbers are chosen in the end
	ld [hli], a   ; move 1
	ld [hli], a   ; move 2
	ld [hli], a   ; move 3
	ld [hl], a    ; move 4
	ld a, [wEnemyDisabledMove] ; forbid disabled move (if any)
	swap a
	and $f
	jr z, .noMoveDisabled
	ld hl, wBuffer
	dec a
	ld c, a
	ld b, $0
	add hl, bc    ; advance pointer to forbidden move
	ld [hl], $50  ; forbid (highly discourage) disabled move
.noMoveDisabled
	ld hl, TrainerClassMoveChoiceModifications
	ld a, [wTrainerClass]
	ld b, a
.loopTrainerClasses
	dec b
	jr z, .readTrainerClassData
.loopTrainerClassData
	ld a, [hli]
	and a
	jr nz, .loopTrainerClassData
	jr .loopTrainerClasses
.readTrainerClassData
	ld a, [hl]
	and a
	jp z, .useOriginalMoveSet
	push hl
.nextMoveChoiceModification
	pop hl
	ld a, [hli]
	and a
	jr z, .loopFindMinimumEntries
	push hl
	ld hl, AIMoveChoiceModificationFunctionPointers
	dec a
	add a
	ld c, a
	ld b, 0
	add hl, bc    ; skip to pointer
	ld a, [hli]   ; read pointer into hl
	ld h, [hl]
	ld l, a
	ld de, .nextMoveChoiceModification  ; set return address
	push de
	jp hl         ; execute modification function
.loopFindMinimumEntries ; all entries will be decremented sequentially until one of them is zero
	ld hl, wBuffer  ; temp move selection array
	ld de, wEnemyMonMoves  ; enemy moves
	ld c, NUM_MOVES
.loopDecrementEntries
	ld a, [de]
	inc de
	and a
	jr z, .loopFindMinimumEntries
	dec [hl]
	jr z, .minimumEntriesFound
	inc hl
	dec c
	jr z, .loopFindMinimumEntries
	jr .loopDecrementEntries
.minimumEntriesFound
	ld a, c
.loopUndoPartialIteration ; undo last (partial) loop iteration
	inc [hl]
	dec hl
	inc a
	cp NUM_MOVES + 1
	jr nz, .loopUndoPartialIteration
	ld hl, wBuffer  ; temp move selection array
	ld de, wEnemyMonMoves  ; enemy moves
	ld c, NUM_MOVES
.filterMinimalEntries ; all minimal entries now have value 1. All other slots will be disabled (move set to 0)
	ld a, [de]
	and a
	jr nz, .moveExisting
	ld [hl], a
.moveExisting
	ld a, [hl]
	dec a
	jr z, .slotWithMinimalValue
	xor a
	ld [hli], a     ; disable move slot
	jr .next
.slotWithMinimalValue
	ld a, [de]
	ld [hli], a     ; enable move slot
.next
	inc de
	dec c
	jr nz, .filterMinimalEntries
	ld hl, wBuffer    ; use created temporary array as move set
	ret
.useOriginalMoveSet
	ld hl, wEnemyMonMoves    ; use original move set
	ret

AIMoveChoiceModificationFunctionPointers:
	dw AIMoveChoiceModification1
	dw AIMoveChoiceModification2
	dw AIMoveChoiceModification3
	dw AIMoveChoiceModification4 ; unused, does nothing

; discourages moves that cause no damage but only a status ailment if player's mon already has one
; also check for CURSE, LEECH_SEED, SUBSTITUTE, DISABLED, CONFUSED
AIMoveChoiceModification1:
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove ; --------------------------------------------------------------------
	dec b
	ret z ; processed all 4 moves
	inc hl
	ld a, [de]
	and a
	ret z ; no more moves in move set
; actually do things with the move
	inc de
	call ReadMove
	ld a, [wEnemyMovePower]
	and a
	jr nz, .nextMove ; we only care about non-damaging moves right now
; read the effect and start comparing with a list of to-be-checked ones --------
	ld a, [wEnemyMoveEffect]
	cp CURSE_EFFECT
	jp z, .curseEffect
	cp LEECH_SEED_EFFECT
	jp z, .leechSeedEffect
	cp DISABLE_EFFECT
	jp z, .disableEffect
	cp CONFUSION_EFFECT
	jp z, .confusionEffect
	cp SUBSTITUTE_EFFECT
	jp z, .substituteEffect
	cp HEAL_EFFECT
	jp z, .healEffect
	cp FOCUS_ENERGY_EFFECT
	jp z, .focusEnergyEffect
	cp LIGHT_SCREEN_EFFECT
	jp z, .lightScreenEffect
	cp REFLECT_EFFECT
	jp z, .reflectEffect
; check for permanent-status-inflicting effects
	cp SLEEP_EFFECT
	jp z, .permaStatusEffect
	cp PARALYZE_EFFECT
	jp z, .permaStatusEffect
; burn is special
	cp BURN_EFFECT
	jp z, .burnEffect
; poison is even more special
	cp POISON_EFFECT
	jp z, .poisonEffect
; check for useless-against-substitute effects
	ld a, [wEnemyMoveEffect] ; unnecessary?
	push hl
	push de
	push bc
	ld hl, UselessAgainstSubstituteMoveEffects
	ld de, 1
	call IsInArray ; returns count b and carry if found
	pop bc
	pop de
	pop hl
	jp c, .uselessVsSubstituteEffect
; check for self-buffing moves
	ld a, [wEnemyMoveEffect]
	cp SPEED_UP2_EFFECT
	jp z, .selfBoost_Speed
	cp ATTACK_SPEED_UP1_EFFECT
	jp z, .selfBoost_SpeedAttack
	cp ATTACK_UP2_EFFECT
	jp z, .selfBoost_Attack
	cp DEFENSE_UP1_EFFECT
	jp z, .selfBoost_Defense
	cp DEFENSE_UP2_EFFECT
	jp z, .selfBoost_Defense
	cp SPECIAL_UP1_EFFECT
	jp z, .selfBoost_Special
	cp SPECIAL_UP2_EFFECT
	jp z, .selfBoost_Special
	cp EVASION_UP1_EFFECT
	jp z, .selfBoost_Evasion
	cp EVASION_UP2_EFFECT
	jp z, .selfBoost_Evasion
; if none of the above: we apply no modifier to this move, and we go to the next one
	jp .nextMove

.curseEffect
	ld a, [wPlayerBattleStatus2]
	bit BEING_CURSED, a
	jp z, .nextMove
	jp .veryHeavilyDiscourage

.leechSeedEffect
	ld a, [wPlayerBattleStatus2]
	bit SEEDED, a
	jp nz, .veryHeavilyDiscourage
; we also check if our mon is GRASS
	ld a, [wBattleMonType1]
	cp GRASS
	jp z, .veryHeavilyDiscourage
	ld a, [wBattleMonType2]
	cp GRASS
	jp z, .veryHeavilyDiscourage
	jp .nextMove

.disableEffect
	ld a, [wPlayerDisabledMove]
	and a
	jp z, .nextMove
	jp .veryHeavilyDiscourage

.confusionEffect
	ld a, [wPlayerBattleStatus1]
	bit CONFUSED, a
	jp z, .nextMove
	jp .veryHeavilyDiscourage

.substituteEffect
	ld a, [wEnemyBattleStatus2]
	bit HAS_SUBSTITUTE_UP, a
	jp z, .nextMove
	jp .veryHeavilyDiscourage

.healEffect
	push hl
	push de
	ld hl, wEnemyMonMaxHP
	ld de, wEnemyMonHP
	ld a, [de]
	cp [hl]
	jr nz, .notFullHealth
	inc hl
	inc de
	ld a, [de]
	cp [hl]
	jr nz, .notFullHealth
	pop de
	pop hl
	jp .veryHeavilyDiscourage ; if we are here, opponent is at max HP
.notFullHealth
	pop de
	pop hl
	jp .nextMove ; we don't dis/en-courage a self-healing move at this point as long as it does at least something

.focusEnergyEffect
	ld a, [wEnemyBattleStatus2]
	bit GETTING_PUMPED, a
	jp z, .nextMove
	jp .veryHeavilyDiscourage

.lightScreenEffect
	ld a, [wPlayerBattleStatus3]
	bit HAS_LIGHT_SCREEN_UP, a
	jp z, .nextMove
	jp .veryHeavilyDiscourage

.reflectEffect
	ld a, [wPlayerBattleStatus3]
	bit HAS_REFLECT_UP, a
	jp z, .nextMove
	jp .veryHeavilyDiscourage

.permaStatusEffect
	ld a, [wBattleMonStatus]
	and a
	jp z, .nextMove
	jp .veryHeavilyDiscourage

.burnEffect
	ld a, [wBattleMonStatus]
	and a
	jp nz, .veryHeavilyDiscourage
; we also check if our mon is FIRE
	ld a, [wBattleMonType1]
	cp FIRE
	jp z, .veryHeavilyDiscourage
	ld a, [wBattleMonType2]
	cp FIRE
	jp z, .veryHeavilyDiscourage
	jp .nextMove

.poisonEffect
	ld a, [wBattleMonStatus]
	and a
	jp nz, .veryHeavilyDiscourage
; we also check if our mon is POISON or STEEL during a non-inverse battle
	ld a, [wBattleMonType1]
	cp POISON
	jp z, .veryHeavilyDiscourage
	ld a, [wBattleMonType2]
	cp POISON
	jp z, .veryHeavilyDiscourage
	ld a, [wInverseBattle]
	and a
	jp nz, .nextMove ; if the battle is inverse, we don't perform the check on STEEL
	ld a, [wBattleMonType1]
	cp STEEL
	jp z, .veryHeavilyDiscourage
	ld a, [wBattleMonType2]
	cp STEEL
	jp nz, .nextMove
	jp .veryHeavilyDiscourage

.uselessVsSubstituteEffect
	ld a, [wPlayerBattleStatus2]
	bit HAS_SUBSTITUTE_UP, a
	jp z, .nextMove
	jp .veryHeavilyDiscourage

; for the modifiers: values can range from 1 - 13 ($1 to $D): 7 is normal
.selfBoost_Speed
	ld a, [wEnemyMonSpeedMod]
	jr .modifierComparisons_NotEvasion
.selfBoost_SpeedAttack ; whichever is lower is the one dominating
	push bc
	ld a, [wEnemyMonAttackMod]
	ld b, a
	ld a, [wEnemyMonSpeedMod]
	cp b ; speedMod-attackMod
	pop bc
	jr c, .modifierComparisons_NotEvasion
	ld a, [wEnemyMonAttackMod]
	jr .modifierComparisons_NotEvasion
.selfBoost_Attack
	ld a, [wEnemyMonAttackMod]
	jr .modifierComparisons_NotEvasion
.selfBoost_Defense
	ld a, [wEnemyMonDefenseMod]
	jr .modifierComparisons_NotEvasion
.selfBoost_Special
	ld a, [wEnemyMonSpecialMod]
	jr .modifierComparisons_NotEvasion
.selfBoost_Evasion
	ld a, [wEnemyMonEvasionMod]
	cp 13
	jp z, .veryHeavilyDiscourage
	cp 12
	jr z, .discourageBy1
	jp .nextMove ; no discouragement if we are at +4 or less
.modifierComparisons_NotEvasion
	cp 13
	jp z, .veryHeavilyDiscourage
	cp 12
	jr z, .discourageBy3
	cp 11
	jr z, .discourageBy2
	cp 10
	jr z, .discourageBy1
	cp 9
	jr z, .discourageBy1
	jp .nextMove ; no discouragement if we are at +1 or less
.discourageBy3
	inc [hl]
.discourageBy2
	inc [hl]
.discourageBy1
	inc [hl]
	jp .nextMove

.veryHeavilyDiscourage
	ld a, [hl]
	add 10 ; very heavily discourage move ; edited, was 5
	ld [hl], a
	jp .nextMove

UselessAgainstSubstituteMoveEffects:
	db ATTACK_DOWN1_EFFECT
	db DEFENSE_DOWN1_EFFECT
	db SPEED_DOWN1_EFFECT
	db SPECIAL_DOWN1_EFFECT
	db ACCURACY_DOWN1_EFFECT
	db EVASION_DOWN1_EFFECT
	db ATTACK_DOWN2_EFFECT
	db DEFENSE_DOWN2_EFFECT
	db SPEED_DOWN2_EFFECT
	db SPECIAL_DOWN2_EFFECT
	db ACCURACY_DOWN2_EFFECT
	db EVASION_DOWN2_EFFECT
	db POISON_EFFECT
	db CONFUSION_EFFECT
	db -1 ; end

; slightly encourage moves with specific effects; edited
; in particular, stat-modifying moves and status moves
AIMoveChoiceModification2:
	ld a, [wAILayer2Encouragement]
	and a ; edited, it was cp $1, now status moves should get prio on turn 1
	ret nz
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove
	dec b
	ret z ; processed all 4 moves
	inc hl
	ld a, [de]
	and a
	ret z ; no more moves in move set
; actually do things with the move
	inc de
	call ReadMove
	ld a, [wEnemyMoveEffect]
; edited, a big array rather than feeble cps with c/nc flags checks
	push hl
	push de
	push bc
	ld hl, Modifier2BuffDebuffMoveEffects
	ld de, 1
	call IsInArray ; returns count b and carry if found
	pop bc
	pop de
	pop hl
	jp nc, .nextMove
.preferMove
	dec [hl] ; slightly encourage this move
	jr .nextMove

Modifier2BuffDebuffMoveEffects:
	db ATTACK_UP1_EFFECT
	db DEFENSE_UP1_EFFECT
	db SPEED_UP1_EFFECT
	db SPECIAL_UP1_EFFECT
	db ACCURACY_UP1_EFFECT
	db EVASION_UP1_EFFECT
	db ATTACK_UP2_EFFECT
	db DEFENSE_UP2_EFFECT
	db SPEED_UP2_EFFECT
	db SPECIAL_UP2_EFFECT
	db ACCURACY_UP2_EFFECT
	db EVASION_UP2_EFFECT
	db LIGHT_SCREEN_EFFECT
	db REFLECT_EFFECT
	db CONFUSION_EFFECT
	db POISON_EFFECT
	db PARALYZE_EFFECT
	db BURN_EFFECT
	db SLEEP_EFFECT
	db FOCUS_ENERGY_EFFECT
	db ATTACK_DOWN_SIDE_EFFECT_CERT
	db DEFENSE_DOWN_SIDE_EFFECT_CERT
	db SPEED_DOWN_SIDE_EFFECT_CERT
	db SPECIAL_DOWN_SIDE_EFFECT_CERT
	db ACCURACY_DOWN_SIDE_EFFECT_CERT
	db EVASION_DOWN_SIDE_EFFECT_CERT
	db SUBSTITUTE_EFFECT
	db CURSE_EFFECT
	db LEECH_SEED_EFFECT
	db DISABLE_EFFECT
	db PARALYZE_SIDE_EFFECT_CERT
	db ATTACK_SPEED_UP1_EFFECT
	db -1

; encourages moves that are effective against the player's mon (even if non-damaging).
; discourage damaging moves that are ineffective or not very effective against the player's mon,
; unless there's no damaging move that deals at least neutral damage
; edited: takes into account various levels of effectiveness
; new: part2 encourages draining and exploding moves at low HP
; new: part3 encouranges STAB moves
AIMoveChoiceModification3:
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove
	dec b
	jp z, .modification3Part2 ; processed all 4 moves ; edited
	inc hl
	ld a, [de]
	and a
	jp z, .modification3Part2 ; no more moves in move set ; edited
; actually do things with the move
	inc de
	call ReadMove
; this AI modification should NOT dis/en-courage NON-damaging moves
	ld a, [wEnemyMovePower]
	and a
	jp z, .nextMove
; counter and mirror coat are unaffected by type match-up too and have BP=1
	ld a, [wEnemyMoveNum]
	cp COUNTER
	jp z, .nextMove
	cp MIRROR_COAT
	jp z, .nextMove
; handle special moves that are unaffected by type match-up
	ld a, [wEnemyMoveEffect]
	cp SUPER_FANG_EFFECT
	jp z, .nextMove
	cp SPECIAL_DAMAGE_EFFECT
	jp z, .nextMove
; normal damaging moves
	push hl
	push bc
	push de
	callfar AIGetTypeEffectiveness
	pop de
	pop bc
	pop hl
	ld a, [wTypeEffectiveness] ; 0 is not effective, 1 double not effective, 2 not effective, 4 neutral, 8 super effective, 16 double super effective
	cp 4 ; compare with neutral
	jp z, .nextMove ; we don't dis/en-courage a neutral move
	cp 0
	jr z, .notEffective
	cp 1
	jr z, .doubleNotVeryEffective
	cp 2
	jr z, .notVeryEffective
	cp 8
	jr z, .superEffective
	; if we are here, it's double super effective
	dec [hl]
.superEffective
	dec [hl]
	jr .nextMove
.doubleNotVeryEffective
	inc [hl]
.notVeryEffective
	inc [hl]
	jr .nextMove
.notEffective
	ld a, [hl]
	add 10 ; very heavily discourage move
	ld [hl], a
	jr .nextMove

.modification3Part2
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove2
	dec b
	jp z, .modification3Part3 ; processed all 4 moves
	inc hl
	ld a, [de]
	and a
	jp z, .modification3Part3 ; no more moves in move set
; actually do things with the move
	inc de
	call ReadMove
; read move effect and encourage under specific conditions, like draining or exploding moves at low health
	ld a, [wEnemyMoveEffect]
	cp DRAIN_HP_EFFECT
	jp z, .drainHPEffect
	cp EXPLODE_EFFECT
	jp z, .explodeEffect
; if none of the effects above, go to the next move
	jp .nextMove2
.drainHPEffect
	ld a, 4
	call AICheckIfHPBelowFractionPushesPops ; c flag if enemy trainer's current HP is < 1/a of MaxHP
	jr c, .encourageTwice
	ld a, 2
	call AICheckIfHPBelowFractionPushesPops
	jr c, .encourageOnce
	jp .nextMove2
.explodeEffect
	ld a, 8
	call AICheckIfHPBelowFractionPushesPops ; c flag if enemy trainer's current HP is < 1/a of MaxHP
	jr c, .encourageTwice
	ld a, 3
	call AICheckIfHPBelowFractionPushesPops
	jr c, .encourageOnce
	jp .nextMove2
.encourageTwice
	dec [hl]
.encourageOnce
	dec [hl]
	jp .nextMove2

.modification3Part3
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove3
	dec b
	jp z, .modification3Part4 ; processed all 4 moves
	inc hl
	ld a, [de]
	and a
	jp z, .modification3Part4 ; no more moves in move set
; actually do things with the move
	inc de
	call ReadMove
; slightly encourage move if benefits from STAB
	push bc
	ld a, [wEnemyMoveType]
	ld b, a
	ld a, [wEnemyMonType1]
	cp b ; a is enemy mon's type 1, b is enemy move type
	jr z, .moveHasSTAB
	ld a, [wEnemyMonType2]
	cp b ; a is enemy mon's type 2, b is enemy move type
	jr z, .moveHasSTAB
; no STAB
	pop bc
	jr .nextMove3
.moveHasSTAB
	pop bc
	dec [hl]
	jp .nextMove3

.modification3Part4
	ret



AIMoveChoiceModification4:
	ret

ReadMove:
	push hl
	push de
	push bc
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld de, wEnemyMoveNum
	call CopyData ; copies bc bytes from hl to de
	pop bc
	pop de
	pop hl
	ret

INCLUDE "data/trainers/move_choices.asm"

INCLUDE "data/trainers/pic_pointers_money.asm"

INCLUDE "data/trainers/names.asm"

INCLUDE "engine/battle/misc.asm"

INCLUDE "engine/battle/read_trainer_party.asm"

INCLUDE "data/trainers/special_moves.asm"

INCLUDE "data/trainers/parties.asm"

TrainerAI:
	ld a, [wIsInBattle]
	dec a
	jr z, .done ; if not a trainer, we're done here
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	jr z, .done ; if in a link battle, we're done as well
	ld a, [wEnemyBattleStatus1]
	and 1 << CHARGING_UP | 1 << THRASHING_ABOUT | 1 << STORING_ENERGY
	jr nz, .done ; don't follow trainer ai if opponent is in a locked state
; edited, block of code commented out because removed rage
;	ld a, [wEnemyBattleStatus2]
;	and 1 << USING_RAGE
;	jr nz, .done ; don't follow trainer ai if opponent is locked in rage
;	             ; note that this doesn't check for hyper beam recharge which can cause problems
	ld a, [wTrainerClass] ; what trainer class is this?
	dec a
	ld c, a
	ld b, 0
	ld hl, TrainerAIPointers
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [wAICount]
	and a
	jr z, .done ; if no AI uses left, we're done here
	inc hl
	inc a
	jr nz, .getpointer
	dec hl
	ld a, [hli]
	ld [wAICount], a
.getpointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call Random
	jp hl
.done
	and a
	ret

INCLUDE "data/trainers/ai_pointers.asm"

JugglerAI:
	cp 25 percent + 1
	ret nc
	jp AISwitchIfEnoughMons

BlackbeltAI:
	cp 13 percent - 1
	ret nc
	jp AIUseXAttack

ProfOakAI: ; new
	cp 75 percent - 1
	ret nc
	ld a, 5
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseFullRestore

GiovanniAI:
	cp 15 percent + 1 ; edited, was 25
	ret nc
	jp AIUseXAttack ; edited, was GuardSpec

;CooltrainerMAI: ; commented out
;	cp 25 percent + 1
;	ret nc
;	jp AIUseXAttack

CooltrainerAI:
	; The intended 25% chance to consider switching will not apply.
	; Uncomment the line below to fix this - done
	cp 25 percent + 1
	ret nc ; uncommented
	ld a, 10
	call AICheckIfHPBelowFraction
	jp c, AIUseHyperPotion
	ld a, 5
	call AICheckIfHPBelowFraction
	ret nc
	jp AISwitchIfEnoughMons

BrockAI:
; if his active monster has a status condition, use a full heal
	ld a, [wEnemyMonStatus]
	and a
	ret z
	jp AIUseFullHeal

MistyAI:
	cp 25 percent + 1
	ret nc
	jp AIUseXDefend

LtSurgeAI:
	cp 25 percent + 1
	ret nc
	ld a, 8 ; new
	call AICheckIfHPBelowFraction ; new
	ret nc ; new
	jp AIUseSuperPotion ; edited, was AIUseXSpeed

ErikaAI:
	cp 50 percent + 1
	ret nc
	ld a, 10
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseHyperPotion ; updated

KogaAI:
	cp 13 percent - 1
	ret nc
	jp AIUseXAttack

SabrinaAI:
	cp 25 percent + 1
	ret nc
	jp AIUseXDefend

BlaineAI:
	cp 25 percent + 1
	ret nc
	ld a, 10
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseHyperPotion ; updated

OrageAI: ; new
	cp 45 percent + 1
	ret nc
	ld a, 8
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseHyperPotion

Rival2AI:
	cp 13 percent - 1
	ret nc
	ld a, 5
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseSuperPotion ; updated

Rival3AI:
	cp 95 percent - 1 ; updated
	ret nc
	ld a, 5
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseFullRestore

LoreleiAI:
	cp 50 percent + 1
	ret nc
	ld a, 5
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseFullRestore ; updated

BrunoAI:
	cp 15 percent + 1 ; edited
	ret nc
	jp AIUseXAttack ; updated

AgathaAI:
	cp 8 percent
	jp c, AISwitchIfEnoughMons
	cp 50 percent + 1
	ret nc
	ld a, 4
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseFullRestore ; updated

LanceAI:
	cp 50 percent + 1
	ret nc
	ld a, 5
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseFullRestore ; updated

GenericAI:
	and a ; clear carry
	ret

; end of individual trainer AI routines

DecrementAICount:
	ld hl, wAICount
	dec [hl]
	scf
	ret

AIPlayRestoringSFX:
	ld a, SFX_HEAL_AILMENT
	jp PlaySoundWaitForCurrent

AIUseFullRestore:
	call AICureStatus
	ld a, FULL_RESTORE
	ld [wAIItem], a
	ld de, wHPBarOldHP
	ld hl, wEnemyMonHP + 1
	ld a, [hld]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
	ld hl, wEnemyMonMaxHP + 1
	ld a, [hld]
	ld [de], a
	inc de
	ld [wHPBarMaxHP], a
	ld [wEnemyMonHP + 1], a
	ld a, [hl]
	ld [de], a
	ld [wHPBarMaxHP+1], a
	ld [wEnemyMonHP], a
	jr AIPrintItemUseAndUpdateHPBar

AIUsePotion:
; enemy trainer heals his monster with a potion
	ld a, POTION
	ld b, 20
	jr AIRecoverHP

AIUseSuperPotion:
; enemy trainer heals his monster with a super potion
	ld a, SUPER_POTION
	ld b, 50
	jr AIRecoverHP

AIUseHyperPotion:
; enemy trainer heals his monster with a hyper potion
	ld a, HYPER_POTION
	ld b, 200
	; fallthrough

AIRecoverHP:
; heal b HP and print "trainer used $(a) on pokemon!"
	ld [wAIItem], a
	ld hl, wEnemyMonHP + 1
	ld a, [hl]
	ld [wHPBarOldHP], a
	add b
	ld [hld], a
	ld [wHPBarNewHP], a
	ld a, [hl]
	ld [wHPBarOldHP+1], a
	ld [wHPBarNewHP+1], a
	jr nc, .next
	inc a
	ld [hl], a
	ld [wHPBarNewHP+1], a
.next
	inc hl
	ld a, [hld]
	ld b, a
	ld de, wEnemyMonMaxHP + 1
	ld a, [de]
	dec de
	ld [wHPBarMaxHP], a
	sub b
	ld a, [hli]
	ld b, a
	ld a, [de]
	ld [wHPBarMaxHP+1], a
	sbc b
	jr nc, AIPrintItemUseAndUpdateHPBar
	inc de
	ld a, [de]
	dec de
	ld [hld], a
	ld [wHPBarNewHP], a
	ld a, [de]
	ld [hl], a
	ld [wHPBarNewHP+1], a
	; fallthrough

AIPrintItemUseAndUpdateHPBar:
	call AIPrintItemUse_
	hlcoord 2, 2
	xor a
	ld [wHPBarType], a
	predef UpdateHPBar2
	jp DecrementAICount

AISwitchIfEnoughMons:
; enemy trainer switches if there are 2 or more unfainted mons in party
	ld a, [wEnemyPartyCount]
	ld c, a
	ld hl, wEnemyMon1HP

	ld d, 0 ; keep count of unfainted monsters

	; count how many monsters haven't fainted yet
.loop
	ld a, [hli]
	ld b, a
	ld a, [hld]
	or b
	jr z, .Fainted ; has monster fainted?
	inc d
.Fainted
	push bc
	ld bc, wEnemyMon2 - wEnemyMon1
	add hl, bc
	pop bc
	dec c
	jr nz, .loop

	ld a, d ; how many available monsters are there?
	cp 2    ; don't bother if only 1
	jp nc, SwitchEnemyMon
	and a
	ret

SwitchEnemyMon:

; prepare to withdraw the active monster: copy hp, number, and status to roster

	ld a, [wEnemyMonPartyPos]
	ld hl, wEnemyMon1HP
	ld bc, wEnemyMon2 - wEnemyMon1
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, wEnemyMonHP
	ld bc, 4
	call CopyData

	ld hl, AIBattleWithdrawText
	call PrintText

	; This wFirstMonsNotOutYet variable is abused to prevent the player from
	; switching in a new mon in response to this switch.
	ld a, 1
	ld [wFirstMonsNotOutYet], a
	callfar EnemySendOut
	xor a
	ld [wFirstMonsNotOutYet], a

	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	ret z
	scf
	ret

AIBattleWithdrawText:
	text_far _AIBattleWithdrawText
	text_end

AIUseFullHeal:
	call AIPlayRestoringSFX
	call AICureStatus
	ld a, FULL_HEAL
	jp AIPrintItemUse

AICureStatus:
; cures the status of enemy's active pokemon
	ld a, [wEnemyMonPartyPos]
	ld hl, wEnemyMon1Status
	ld bc, wEnemyMon2 - wEnemyMon1
	call AddNTimes
	xor a
	ld [hl], a ; clear status in enemy team roster
	ld [wEnemyMonStatus], a ; clear status of active enemy
	ld hl, wEnemyBattleStatus3
	res 0, [hl]
	ret

AIUseXAccuracy: ; unused
	call AIPlayRestoringSFX
	ld hl, wEnemyBattleStatus2
	set 0, [hl]
	ld a, X_ACCURACY
	jp AIPrintItemUse

AIUseGuardSpec:
	call AIPlayRestoringSFX
	ld hl, wEnemyBattleStatus2
	set 1, [hl]
	ld a, GUARD_SPEC
	jp AIPrintItemUse

AIUseDireHit: ; unused
	call AIPlayRestoringSFX
	ld hl, wEnemyBattleStatus2
	set 2, [hl]
	ld a, DIRE_HIT
	jp AIPrintItemUse

AICheckIfHPBelowFraction:
; return carry if enemy trainer's current HP is below 1 / a of the maximum
	ldh [hDivisor], a
	ld hl, wEnemyMonMaxHP
	ld a, [hli]
	ldh [hDividend], a
	ld a, [hl]
	ldh [hDividend + 1], a
	ld b, 2
	call Divide
	ldh a, [hQuotient + 3]
	ld c, a
	ldh a, [hQuotient + 2]
	ld b, a
	ld hl, wEnemyMonHP + 1
	ld a, [hld]
	ld e, a
	ld a, [hl]
	ld d, a
	ld a, d
	sub b
	ret nz
	ld a, e
	sub c
	ret

AICheckIfHPBelowFractionPushesPops: ; new
	push hl
	push bc
	push de
	call AICheckIfHPBelowFraction
	pop de
	pop bc
	pop hl
	ret

AIUseXAttack:
	ld b, $A
	ld a, X_ATTACK
	jr AIIncreaseStat

AIUseXDefend:
	ld b, $B
	ld a, X_DEFEND
	jr AIIncreaseStat

AIUseXSpeed:
	ld b, $C
	ld a, X_SPEED
	jr AIIncreaseStat

AIUseXSpecial:
	ld b, $D
	ld a, X_SPECIAL
	; fallthrough

AIIncreaseStat:
	ld [wAIItem], a
	push bc
	call AIPrintItemUse_
	pop bc
	ld hl, wEnemyMoveEffect
	ld a, [hld]
	push af
	ld a, [hl]
	push af
	push hl
	ld a, XSTATITEM_ANIM ; edited
	ld [hli], a
	ld [hl], b
	callfar StatModifierUpEffect
	pop hl
	pop af
	ld [hli], a
	pop af
	ld [hl], a
	jp DecrementAICount

AIPrintItemUse:
	ld [wAIItem], a
	call AIPrintItemUse_
	jp DecrementAICount

AIPrintItemUse_:
; print "x used [wAIItem] on z!"
	ld a, [wAIItem]
	ld [wd11e], a
	call GetItemName
	ld hl, AIBattleUseItemText
	jp PrintText

AIBattleUseItemText:
	text_far _AIBattleUseItemText
	text_end
