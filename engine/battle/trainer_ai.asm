; creates a set of moves that may be used and returns its address in hl
; unused slots are filled with 0, all used slots may be chosen with equal probability
AIEnemyTrainerChooseMoves:
	ld a, 20 ; edited, was 10
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
	dw AIMoveChoiceModification4

; discourages moves that cause no damage but only a status ailment if player's mon already has one
; also check for CURSE, LEECH_SEED, SUBSTITUTE, DISABLED, CONFUSED
; also for SCREENs, DREAM EATER, etc...
; also for priority moves under PSYCHIC_TERRAIN
; also entry hazards if they are already up or the player has too few mons
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
; check for priority moves under PSYCHIC_TERRAIN
	CheckEvent EVENT_TERRAIN_PSYCHIC
	jr z, .noPriorityUnderPsychicTerrain
	call AIGetPriorityPushesPops ; returns move prio in a
	cp 8 ; a-8 = prio-8, it's <0, so c flag, for prios 0-to-7, and >=0, so nc flag, for prios 8 and above
	jp c, .noPriorityUnderPsychicTerrain
; if we are here, it's a high-prio move
	jp .veryHeavilyDiscourage
.noPriorityUnderPsychicTerrain
; check if it is one of the debuffing AND damaging moves, otherwise ignore all damaging moves here
; treat the accuracy one, i.e. Mud Slap, differently from the other two,
; Mud Shot and Rock Tomb, which are stronger but reduce less useful stats in Speed
; Dream Eater goes here too as it does deal damage
	ld a, [wEnemyMoveEffect]
	cp ACCURACY_DOWN_SIDE_EFFECT_CERT
	jp z, .debuff_Accuracy
	cp SPEED_DOWN_SIDE_EFFECT_CERT
	jp z, .debuff_Speed
	cp DREAM_EATER_EFFECT
	jp z, .dreamEaterEffect
; if it is not the move above, check if it deals damage; if yes, don't process to save time
	ld a, [wEnemyMovePower]
	cp 5 ; this is here to include OHKO moves
	jr nc, .nextMove ; we only care about non-damaging and OHKO moves right now
; read the effect and start comparing with a list of to-be-checked ones --------
	ld a, [wEnemyMoveEffect]
	cp CURSE_EFFECT
	jp z, .curseEffect
	cp PARALYZE_SIDE_EFFECT_CERT
	jp z, .paralyzeCertEffect
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

	cp SPIKES_EFFECT
	jp z, .spikesEffect
	cp TOXIC_SPIKES_EFFECT
	jp z, .toxicSpikesEffect
	cp STICKY_WEB_EFFECT
	jp z, .stickyWebEffect
	cp STEALTH_ROCK_EFFECT
	jp z, .stealthRockEffect

	cp OHKO_EFFECT
	jp z, .ohkoEffect
; check for permanent-status-inflicting effects
	cp SLEEP_EFFECT
	jp z, .permaStatusEffect
; burn is special
	cp BURN_EFFECT
	jp z, .burnEffect
; poison is even more special
	cp POISON_EFFECT
	jp z, .poisonEffect
; paralyze is even more more special
	cp PARALYZE_EFFECT
	jp z, .paralyzeEffect
; check for useless-against-substitute effects
	ld a, [wPlayerBattleStatus2]
	bit HAS_SUBSTITUTE_UP, a
	jp nz, .uselessVsSubstituteEffect
; check for self-buffing moves
	ld a, [wEnemyMoveEffect]
	cp SPEED_UP2_EFFECT
	jp z, .selfBoost_Speed
	cp ATTACK_SPEED_UP1_EFFECT
	jp z, .selfBoost_SpeedAttack
	cp SPECIAL_SPEED_UP1_EFFECT
	jp z, .selfBoost_SpeedSpecial
	cp CURSE_EFFECT
	jp z, .selfBoost_Curse
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

; check for debuffing moves
; no need to re-load [wEnemyMoveEffect] in a
	cp ATTACK_DOWN1_EFFECT
	jp z, .debuff_Attack
	cp ATTACK_DOWN2_EFFECT
	jp z, .debuff_Attack
	cp DEFENSE_DOWN1_EFFECT
	jp z, .debuff_Defense
	cp DEFENSE_DOWN2_EFFECT
	jp z, .debuff_Defense
	cp SPEED_DOWN1_EFFECT
	jp z, .debuff_Speed
	cp SPEED_DOWN2_EFFECT
	jp z, .debuff_Speed
	cp SPECIAL_DOWN1_EFFECT
	jp z, .debuff_Special
	cp SPECIAL_DOWN2_EFFECT
	jp z, .debuff_Special
	cp ACCURACY_DOWN1_EFFECT
	jp z, .debuff_Accuracy
	cp ACCURACY_DOWN2_EFFECT
	jp z, .debuff_Accuracy
	cp EVASION_DOWN1_EFFECT
	jp z, .debuff_Evasion
	cp EVASION_DOWN2_EFFECT
	jp z, .debuff_Evasion
; if none of the above: we apply no modifier to this move, and we go to the next one
	jp .nextMove

.dreamEaterEffect
	ld a, [wBattleMonStatus]
	and SLP_MASK
	jp z, .veryHeavilyDiscourage
	jp .nextMove

.curseEffect
	ld a, [wPlayerBattleStatus2]
	bit BEING_CURSED, a
	jp z, .nextMove
	jp .veryHeavilyDiscourage

.paralyzeCertEffect
	ld a, [wBattleMonStatus]
	and a
	jp nz, .discourageBy3
; we also check if our mon is ELECTRIC
	ld a, [wBattleMonType1]
	cp ELECTRIC
	jp z, .discourageBy3
	ld a, [wBattleMonType2]
	cp ELECTRIC
	jp z, .discourageBy3
	jp .nextMove

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
; don't use if too few HP
	ld a, 4
	call AICheckIfHPBelowFractionPushesPops ; c flag if enemy trainer's current HP is < 1/a of MaxHP
	jp c, .veryHeavilyDiscourage
; don't use if subtitute is already up
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
	ld a, [wEnemyBattleStatus3]
	bit HAS_LIGHT_SCREEN_UP, a
	jp z, .nextMove
	jp .veryHeavilyDiscourage

.reflectEffect
	ld a, [wEnemyBattleStatus3]
	bit HAS_REFLECT_UP, a
	jp z, .nextMove
	jp .veryHeavilyDiscourage

.spikesEffect
	ld a, [wHazardsSpikesPlayerSide]
	cp 3
	jp z, .veryHeavilyDiscourage
	cp 2
	jr nz, .countPlayerAliveMons
	inc [hl] ; discourage by 1
	jr .countPlayerAliveMons

.toxicSpikesEffect
	ld a, [wHazardsToxicSpikesPlayerSide]
	cp 2
	jp z, .veryHeavilyDiscourage
	and a
	jr z, .countPlayerAliveMons
	inc [hl] ; discourage by 1
	jr .countPlayerAliveMons

.stickyWebEffect
	ld a, [wHazardsStickyWebPlayerSide]
	jr .stealthStickyCommon

.stealthRockEffect
	ld a, [wHazardsStealthRockPlayerSide]
	; fallthrough
.stealthStickyCommon
	and a
	jp nz, .veryHeavilyDiscourage
	jr .countPlayerAliveMons
	; fallthrough

.countPlayerAliveMons
	push hl
	push bc
	push de
	call CountHowManyPartyAlive ; d = count alive
	ld a, d
	pop de
	pop bc
	pop hl
	cp 1 ; if only 1 alive, don't use the move
	jp z, .veryHeavilyDiscourage
	cp 2 ; if only 2 alive, discourage a lot, by 3
	jp z, .discourageBy3
	cp 3 ; if only 3 alive, discourage a bit, by 1
	jp z, .discourageBy1
	jp .nextMove ; otherwise don't discourage

.ohkoEffect ; compare speeds
	call CheckIfOpponentIsFasterThanPlayer ; c flag if opponent is faster
	jp nc, .veryHeavilyDiscourage
	jp .nextMove

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

.paralyzeEffect
	ld a, [wBattleMonStatus]
	and a
	jp nz, .veryHeavilyDiscourage
; now we check if the move is ELECTRIC and the target is GROUND in a non-inverse battle
	ld a, [wInverseBattle]
	and a
	jp nz, .nextMove ; if the battle is inverse, we don't perform the checks
	ld a, [wEnemyMoveType]
	cp ELECTRIC
	jp nz, .nextMove ; no need to check if the move isn't THUNDER_WAVE, de facto
	ld a, [wBattleMonType1]
	cp GROUND
	jp z, .veryHeavilyDiscourage
	ld a, [wBattleMonType2]
	cp GROUND
	jp nz, .nextMove
	jp .veryHeavilyDiscourage

.uselessVsSubstituteEffect
	ld a, [wEnemyMoveEffect]
	push hl
	push de
	push bc
	ld hl, UselessAgainstSubstituteMoveEffects
	ld de, 1
	call IsInArray ; returns count b and carry if found
	pop bc
	pop de
	pop hl
	jp c, .veryHeavilyDiscourage
	jp z, .nextMove

; for the modifiers: values can range from 1 - 13 ($1 to $D): 7 is normal
.selfBoost_Speed
	ld a, [wEnemyMonSpeedMod]
	jr .modifierComparisons_SelfBuff_NotEvasion
.selfBoost_SpeedAttack ; whichever is lower is the one dominating
	push bc
	ld a, [wEnemyMonAttackMod]
	ld b, a
	ld a, [wEnemyMonSpeedMod]
	cp b ; speedMod-attackMod
	pop bc
	jr c, .modifierComparisons_SelfBuff_NotEvasion
	ld a, [wEnemyMonAttackMod]
	jr .modifierComparisons_SelfBuff_NotEvasion
.selfBoost_SpeedSpecial ; whichever is lower is the one dominating
	push bc
	ld a, [wEnemyMonSpecialMod]
	ld b, a
	ld a, [wEnemyMonSpeedMod]
	cp b ; speedMod-specialMod
	pop bc
	jr c, .modifierComparisons_SelfBuff_NotEvasion
	ld a, [wEnemyMonSpecialMod]
	jr .modifierComparisons_SelfBuff_NotEvasion
.selfBoost_Curse ; whichever is lower between atk and def, if not GHOST, is the one dominating
	ld a, [wPersonalizationTCGMode] ; 0=NO, 1=YES
	and a
	jr z, .ghostCheckNoTCG
	ld a, [wEnemyMonType1]
	cp TCG_PSYCHIC
	jp z, .nextMove
	ld a, [wEnemyMonType2]
	cp TCG_PSYCHIC
	jp z, .nextMove
	jr .actuallyCurseBoost
.ghostCheckNoTCG
	ld a, [wEnemyMonType1]
	cp GHOST
	jp z, .nextMove
	ld a, [wEnemyMonType2]
	cp GHOST
	jp z, .nextMove
.actuallyCurseBoost
	push bc
	ld a, [wEnemyMonDefenseMod]
	ld b, a
	ld a, [wEnemyMonAttackMod]
	cp b ; attackMod-defenseMod
	pop bc
	jr c, .modifierComparisons_SelfBuff_NotEvasion
	ld a, [wEnemyMonDefenseMod]
	jr .modifierComparisons_SelfBuff_NotEvasion
.selfBoost_Attack
	ld a, [wEnemyMonAttackMod]
	jr .modifierComparisons_SelfBuff_NotEvasion
.selfBoost_Defense
	ld a, [wEnemyMonDefenseMod]
	jr .modifierComparisons_SelfBuff_NotEvasion
.selfBoost_Special
	ld a, [wEnemyMonSpecialMod]
	jr .modifierComparisons_SelfBuff_NotEvasion
.selfBoost_Evasion
	ld a, [wEnemyMonEvasionMod]
	cp 12
	jp nc, .veryHeavilyDiscourage
	cp 11
	jr z, .discourageBy1
	jp .nextMove ; no discouragement if we are at +3 or less
.modifierComparisons_SelfBuff_NotEvasion
	cp 12
	jp nc, .veryHeavilyDiscourage
	cp 11
	jr z, .discourageBy3
	cp 10
	jr z, .discourageBy3
	cp 9
	jr z, .discourageBy2
	cp 8
	jr z, .discourageBy1
	jp .nextMove ; no discouragement if we are at +0 or less

; for the modifiers: values can range from 1 - 13 ($1 to $D): 7 is normal
.debuff_Attack
	ld a, [wPlayerMonAttackMod]
	jr .modifierComparisons_Debuff_NotAccuracy
.debuff_Defense
	ld a, [wPlayerMonDefenseMod]
	jr .modifierComparisons_Debuff_NotAccuracy
.debuff_Speed
	ld a, [wPlayerMonSpeedMod]
	jr .modifierComparisons_Debuff_NotAccuracy
.debuff_Special
	ld a, [wPlayerMonSpecialMod]
	jr .modifierComparisons_Debuff_NotAccuracy
.debuff_Evasion
	ld a, [wPlayerMonEvasionMod]
	jr .modifierComparisons_Debuff_NotAccuracy
.debuff_Accuracy
	ld a, [wPlayerMonAccuracyMod]
	cp 6
	jp nc, .nextMove ; no discouragement if accuracy is -1 or more
	cp 5
	jp z, .discourageBy1
	cp 4
	jp z, .discourageBy2
	cp 3
	jp z, .discourageBy2
	cp 2
	jp z, .discourageBy3
	jp .veryHeavilyDiscourage
.modifierComparisons_Debuff_NotAccuracy
	cp 7
	jp nc, .nextMove ; no discouragement if no debuff is yet applied
	cp 6
	jp z, .discourageBy1
	cp 5
	jp z, .discourageBy2
	cp 4
	jp z, .discourageBy3
	jp .veryHeavilyDiscourage

.discourageBy3
	inc [hl]
.discourageBy2
	inc [hl]
.discourageBy1
	inc [hl]
	jp .nextMove
.veryHeavilyDiscourage
	ld a, [hl]
	add 10 ; very heavily discourage move
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

; quite encourage moves with specific effects
; in particular, stat-modifying moves and status moves
; encourage more on 1st turn, but also on following ones
; no need to worry about trying to sleep a statused mon,
; because modification1 already handles those cases by ultra discouraging them
; new: first part handles only buff/debuff moves, encouraging them a bit
; part 2 handles only status moves, encouraging them more than de/buff ones
AIMoveChoiceModification2:
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove
	dec b
	jp z, .modification2part2 ; processed all 4 moves
	inc hl
	ld a, [de]
	and a
	jp z, .modification2part2 ; no more moves in move set
; actually do things with the move
	inc de
	call ReadMove
	ld a, [wEnemyMoveEffect]
; edited, a big array rather than feeble cps with c/nc flags checks
	push hl
	push de
	push bc
	ld hl, Modifier2BuffDebuffMoveEffects ; not the same array as below
	ld de, 1
	call IsInArray ; returns count b and carry if found
	pop bc
	pop de
	pop hl
	jp nc, .nextMove
; move is in array
	ld a, [WAITurnCounter]
	and a ; edited, encourage less if not 1st turn
	jr nz, .notFirstTurn
	dec [hl] ; encourages by 3, so it's preferred to single-super-eff moves, but not to double-super-eff ones
	dec [hl]
.notFirstTurn ; slightly encourage this move, by 1
	dec [hl]
	jr .nextMove

.modification2part2
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove2
	dec b
	jp z, .modification2part3 ; processed all 4 moves
	inc hl
	ld a, [de]
	and a
	jp z, .modification2part3 ; no more moves in move set
; actually do things with the move
	inc de
	call ReadMove
	ld a, [wEnemyMoveEffect]
; edited, a big array rather than feeble cps with c/nc flags checks
	push hl
	push de
	push bc
	ld hl, Modifier2StatusMoveEffects ; not the same array as above
	ld de, 1
	call IsInArray ; returns count b and carry if found
	pop bc
	pop de
	pop hl
	jp nc, .nextMove2
; move is in array
	ld a, [WAITurnCounter]
	and a ; edited, encourage less if not 1st turn
	jr nz, .notFirstTurn2
	dec [hl] ; encouraged by 3, so it's preferred to single-super-eff moves, but not to double-super-eff ones
.notFirstTurn2 ; quite encourage this move, by 2, on par with superEffective moves
	dec [hl]
	dec [hl]
	jr .nextMove2

.modification2part3 ; currently unused
	ret

Modifier2BuffDebuffMoveEffects:
	db ATTACK_UP1_EFFECT				; no move uses them
	db DEFENSE_UP1_EFFECT
	db SPEED_UP1_EFFECT					; no move uses them
	db SPECIAL_UP1_EFFECT
	db ACCURACY_UP1_EFFECT				; no move uses them
	db EVASION_UP1_EFFECT
	db ATTACK_UP2_EFFECT
	db DEFENSE_UP2_EFFECT
	db SPEED_UP2_EFFECT
	db SPECIAL_UP2_EFFECT
	db ACCURACY_UP2_EFFECT				; no move uses them
	db EVASION_UP2_EFFECT
	db ATTACK_SPEED_UP1_EFFECT
	db SPECIAL_SPEED_UP1_EFFECT
	db ATTACK_DOWN_SIDE_EFFECT_CERT		; no move uses them
	db DEFENSE_DOWN_SIDE_EFFECT_CERT	; no move uses them
	db SPEED_DOWN_SIDE_EFFECT_CERT
	db SPECIAL_DOWN_SIDE_EFFECT_CERT	; no move uses them
	db ACCURACY_DOWN_SIDE_EFFECT_CERT
	db EVASION_DOWN_SIDE_EFFECT_CERT	; no move uses them
	db FOCUS_ENERGY_EFFECT
	db LIGHT_SCREEN_EFFECT
	db REFLECT_EFFECT
	db SUBSTITUTE_EFFECT
	db -1 ; end

Modifier2StatusMoveEffects:
	db CONFUSION_EFFECT
	db POISON_EFFECT
	db PARALYZE_EFFECT
	db BURN_EFFECT
	db SLEEP_EFFECT
	db CURSE_EFFECT
	db LEECH_SEED_EFFECT
	db DISABLE_EFFECT
	; V2
	db SUNNY_DAY_EFFECT
	db RAIN_DANCE_EFFECT
	db SANDSTORM_EFFECT
	db HAIL_EFFECT
	db GRASSY_TERRAIN_EFFECT
	db ELECTRIC_TERRAIN_EFFECT
	db MISTY_TERRAIN_EFFECT
	db PSYCHIC_TERRAIN_EFFECT
	db TRICK_ROOM_EFFECT
	db SPIKES_EFFECT
	db TOXIC_SPIKES_EFFECT
	db STICKY_WEB_EFFECT
	db STEALTH_ROCK_EFFECT
	db -1

; encourages moves that are effective against the player's mon
; discourage damaging moves that are ineffective or not very effective against the player's mon
; edited: takes into account various levels of effectiveness:
; encourages by 4 if double super eff, by 2 if super eff, discourages by 2 if not very eff, by 4 if double not very, by 10 if immune
; also encourages counter and mirror coat is appropriate
; new: part2 encourages draining and exploding moves at low HP by 1, 2, or 3, depending on effect and HP left
; new: part3 encouranges STAB moves by 1
; new: part4 encouranges by 1 priority moves if we are slower and they are least neutral, and discourages by 5 prio moves if player is invulnerable
; new: part5 encouranges by 5 swift-like moves if the player is slower and is invulnerable
; new: part6 dis/encouranges trick room, weathers, and terrains under appropriate conditions
; new: part7 encouranges special damage moves like STOMP if opp is MINIMIZEd, EARTHQUAKE if DIGging, etc
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
; but they are encouraged if the player is using a move of the appropriate category
	ld a, [wEnemyMoveNum]
	cp COUNTER
	jp z, .handleCounter
	cp MIRROR_COAT
	jp z, .handleMirrorCoat
; handle JUDGMENT, treat it as always super effective
	cp JUDGMENT
	jr z, .superEffective
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
	dec [hl]
.superEffective
	dec [hl]
	dec [hl]
	jr .nextMove
.doubleNotVeryEffective
	inc [hl]
	inc [hl]
.notVeryEffective
	inc [hl]
	inc [hl]
	jr .nextMove
.notEffective
	ld a, [hl]
	add 10 ; very heavily discourage move
	ld [hl], a
	jr .nextMove
.handleCounter
	ld a, [wPlayerMovePower]
	cp 2
	jr c, .discourageMoveByFive1
	push hl
	push de
	push bc
	callfar IsMoveSpecialOrPhysical_Player ; new: c=physical, nc=special
	pop bc
	pop de
	pop hl
	jp nc, .discourageMoveByFive1
; otherwise, extremely encourage the move (-5)
	dec [hl]
	dec [hl]
	dec [hl]
	dec [hl]
	dec [hl]
	jp .nextMove
.handleMirrorCoat
	ld a, [wPlayerMovePower]
	cp 2
	jr c, .discourageMoveByFive1
	push hl
	push de
	push bc
	callfar IsMoveSpecialOrPhysical_Player ; new: c=physical, nc=special
	pop bc
	pop de
	pop hl
	jp c, .discourageMoveByFive1
; otherwise, extremely encourage the move (-5)
	dec [hl]
	dec [hl]
	dec [hl]
	dec [hl]
	dec [hl]
	jp .nextMove
.discourageMoveByFive1
	ld a, [hl]
	add 5 ; heavily discourage move
	ld [hl], a
	jp .nextMove

.modification3Part2 ; HEAL and EXPLOSION
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
	jp z, .drainHPOrHealEffect
	cp HEAL_EFFECT
	jp z, .drainHPOrHealEffect
	cp EXPLODE_EFFECT
	jp z, .explodeEffect
; if none of the effects above, go to the next move
	jp .nextMove2
.drainHPOrHealEffect
	ld a, 3
	call AICheckIfHPBelowFractionPushesPops ; c flag if enemy trainer's current HP is < 1/a of MaxHP
	jr c, .encourage2Times
	ld a, 2
	call AICheckIfHPBelowFractionPushesPops
	jr c, .encourage1Times
	jp .nextMove2
.explodeEffect
	ld a, 8
	call AICheckIfHPBelowFractionPushesPops ; c flag if enemy trainer's current HP is < 1/a of MaxHP
	jr c, .encourage3Times
	ld a, 4
	call AICheckIfHPBelowFractionPushesPops ; c flag if enemy trainer's current HP is < 1/a of MaxHP
	jr c, .encourage2Times
	ld a, 2
	call AICheckIfHPBelowFractionPushesPops
	jr c, .encourage1Times
	jp .nextMove2
.encourage3Times
	dec [hl]
.encourage2Times
	dec [hl]
.encourage1Times
	dec [hl]
	jp .nextMove2

.modification3Part3 ; STAB
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
; this AI modification should NOT dis/en-courage NON-damaging moves
	ld a, [wEnemyMovePower]
	and a
	jp z, .nextMove3
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

.modification3Part4 ; priority moves
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove4
	dec b
	jp z, .modification3Part5 ; processed all 4 moves ; edited
	inc hl
	ld a, [de]
	and a
	jp z, .modification3Part5 ; no more moves in move set ; edited
; actually do things with the move
	inc de
	call ReadMove
; this AI modification should NOT dis/en-courage NON-damaging moves
	ld a, [wEnemyMovePower]
	and a
	jp z, .nextMove4
; normal damaging moves
	call AIGetPriorityPushesPops ; returns move prio in a
	cp 8 ; a-8 = prio-8, it's <0, so c flag, for prios 0-to-7, and >=0, so nc flag, for prios 8 and above
	jp c, .nextMove4
; if we are here, it's a high-prio move
; check if the player's mon is NOT in dig/fly invincible state
	ld a, [wPlayerBattleStatus1]
	bit INVULNERABLE, a
	jp nz, .discourageMoveByFive4
; player is not invulnerable, so we can encourage the move
	push hl
	push bc
	push de
	callfar AIGetTypeEffectiveness
	pop de
	pop bc
	pop hl
	ld a, [wTypeEffectiveness] ; 0 is not effective, 1 double not effective, 2 not effective, 4 neutral, 8 super effective, 16 double super effective
	cp 4 ; compare with neutral
	jp c, .nextMove4 ; we don't encourage a priority move that is not at least neutral
; if we are here, it's a neutral or (double)super effective damaging priority move
; let's now check if the opponent is slower than us
	call CheckIfOpponentIsFasterThanPlayer ; c flag if opponent is faster
	jp c, .nextMove4 ; don't encourage if opponent is faster
; check if the player is SLP or FRZ, in which case, no encouragement
	ld a, [wBattleMonStatus] ; player's turn
	and (1 << FRZ) | SLP_MASK
	jp nz, .nextMove4
	dec [hl] ; slightly encourage
	jp .nextMove4
.discourageMoveByFive4
	ld a, [hl]
	add 5 ; heavily discourage move
	ld [hl], a
	jp .nextMove4

.modification3Part5 ; SWIFT moves if opponent is faster and player is invulnerable
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove5
	dec b
	jp z, .modification3Part6 ; processed all 4 moves ; edited
	inc hl
	ld a, [de]
	and a
	jp z, .modification3Part6 ; no more moves in move set ; edited
; actually do things with the move
	inc de
	call ReadMove
; we proceed only if the move is swift-like
	ld a, [wEnemyMoveEffect]
	cp SWIFT_EFFECT
	jp nz, .nextMove5
; swift-like moves, now check if the player is invulnerable
	ld a, [wPlayerBattleStatus1]
	bit INVULNERABLE, a
	jp z, .nextMove5
; finally, check if the opponent is faster than the player
	call CheckIfOpponentIsFasterThanPlayer ; c flag if opponent is faster
	jr c, .opponentIsFaster
	jp .nextMove5
.opponentIsFaster ; very heavily encourage, by 12
	dec [hl]
	dec [hl]
	dec [hl]
	dec [hl]
	dec [hl]
	dec [hl]
	dec [hl]
	dec [hl]
	dec [hl]
	dec [hl]
	dec [hl]
	dec [hl]
	jp .nextMove5

.modification3Part6 ; trick room, weathers, and terrains, as well as rapid spin
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove6
	dec b
	jp z, .modification3Part7 ; processed all 4 moves ; edited
	inc hl
	ld a, [de]
	and a
	jp z, .modification3Part7 ; no more moves in move set ; edited
; actually do things with the move
	inc de
	call ReadMove
; we proceed only if the move is TRICK_ROOM, a weather, a terrain, or RAPID_SPIN
	ld a, [wEnemyMoveNum]
	cp RAPID_SPIN
	jp z, .moveIsRapidSpin
	cp TRICK_ROOM
	jp z, .moveIsTrickRoom
	cp SUNNY_DAY
	jp z, .moveIsSunnyDay
	cp RAIN_DANCE
	jp z, .moveIsRainDance
	cp SANDSTORM
	jp z, .moveIsSandstorm
	cp HAIL
	jp z, .moveIsHail
	cp GRASSY_TERRAIN
	jp z, .moveIsGrassyTerrain
	cp ELECTRIC_TERRAIN
	jp z, .moveIsElectricTerrain
	cp PSYCHIC_TERRAIN
	jp z, .moveIsPsychicTerrain
	cp MISTY_TERRAIN
	jp z, .moveIsMistyTerrain
	jp .nextMove6
.moveIsRapidSpin
	ld a, [wHazardsSpikesEnemySide]
	and a
	jr z, .checkRapidSpinEncouragement_TS ; if 0 spikes
	dec a
	jr z, .checkRapidSpinEncouragement_TS ; if 1 spike
	dec [hl] ; if 2 spikes
	dec a
	jr z, .checkRapidSpinEncouragement_TS
	dec [hl] ; if 3 spikes
.checkRapidSpinEncouragement_TS
	ld a, [wHazardsToxicSpikesEnemySide]
	and a
	jr z, .checkRapidSpinEncouragement_SW ; if 0 toxic spikes
	dec [hl] ; if 1 toxic spike
	dec a
	jr z, .checkRapidSpinEncouragement_SW
	dec [hl] ; if 2 toxic spikes
.checkRapidSpinEncouragement_SW
	ld a, [wHazardsStickyWebEnemySide]
	and a
	jr z, .checkRapidSpinEncouragement_SR
	dec [hl]
	dec [hl]
.checkRapidSpinEncouragement_SR
	ld a, [wHazardsStealthRockEnemySide]
	and a
	jp z, .nextMove6
	dec [hl]
	dec [hl]
	jp .nextMove6
.moveIsSunnyDay
	ld a, [wPersonalizationTCGMode] ; 0=NO, 1=YES
	and a
	jr z, .typeCheckNoTCG_SD
; TCG mode on
	ld a, [wEnemyMonType1]
	cp TCG_FIRE
	jr z, .encourageByOne_SD
	ld a, [wEnemyMonType2]
	cp TCG_FIRE
	jr z, .encourageByOne_SD
	jr .postEncourageByOne_SD
.typeCheckNoTCG_SD
	ld a, [wEnemyMonType1]
	cp FIRE
	jr z, .encourageByOne_SD
	ld a, [wEnemyMonType2]
	cp FIRE
	jr nz, .postEncourageByOne_SD
.encourageByOne_SD
	dec [hl]
.postEncourageByOne_SD
	push hl
	push de
	CheckEvent EVENT_WEATHER_SUNNY_DAY
	pop de
	pop hl
	jp nz, .discourageByFour6
	push hl
	push de
	CheckEvent EVENT_WEATHER_RAIN_DANCE
	pop de
	pop hl
	jp nz, .encourageByThree6
	push hl
	push de
	CheckEvent EVENT_WEATHER_SANDSTORM
	pop de
	pop hl
	jp nz, .encourageByThree6
	push hl
	push de
	CheckEvent EVENT_WEATHER_HAIL
	pop de
	pop hl
	jp nz, .encourageByThree6
	jp .nextMove6
.moveIsRainDance
	ld a, [wPersonalizationTCGMode] ; 0=NO, 1=YES
	and a
	jr z, .typeCheckNoTCG_RD
; TCG mode on
	ld a, [wEnemyMonType1]
	cp TCG_WATER
	jr z, .encourageByOne_RD
	ld a, [wEnemyMonType2]
	cp TCG_WATER
	jr z, .encourageByOne_RD
	jr .postEncourageByOne_RD
.typeCheckNoTCG_RD
	ld a, [wEnemyMonType1]
	cp WATER
	jr z, .encourageByOne_RD
	ld a, [wEnemyMonType2]
	cp WATER
	jr nz, .postEncourageByOne_RD
.encourageByOne_RD
	dec [hl]
.postEncourageByOne_RD
	push hl
	push de
	CheckEvent EVENT_WEATHER_RAIN_DANCE
	pop de
	pop hl
	jp nz, .discourageByFour6
	push hl
	push de
	CheckEvent EVENT_WEATHER_SUNNY_DAY
	pop de
	pop hl
	jp nz, .encourageByThree6
	push hl
	push de
	CheckEvent EVENT_WEATHER_SANDSTORM
	pop de
	pop hl
	jp nz, .encourageByThree6
	push hl
	push de
	CheckEvent EVENT_WEATHER_HAIL
	pop de
	pop hl
	jp nz, .encourageByThree6
	jp .nextMove6
.moveIsSandstorm
	ld a, [wPersonalizationTCGMode] ; 0=NO, 1=YES
	and a
	jr z, .typeCheckNoTCG_SS
; TCG mode on
	ld a, [wEnemyMonType1]
	cp TCG_FIGHTING
	jr z, .encourageByOne_SS
	cp TCG_METAL
	jr z, .encourageByOne_SS
	ld a, [wEnemyMonType2]
	cp TCG_FIGHTING
	jr z, .encourageByOne_SS
	cp TCG_METAL
	jr z, .encourageByOne_SS
	jr .postEncourageByOne_SS
.typeCheckNoTCG_SS
	ld a, [wEnemyMonType1]
	cp ROCK
	jr z, .encourageByOne_SS
	cp GROUND
	jr z, .encourageByOne_SS
	cp STEEL
	jr z, .encourageByOne_SS
	ld a, [wEnemyMonType2]
	cp ROCK
	jr z, .encourageByOne_SS
	cp GROUND
	jr z, .encourageByOne_SS
	cp STEEL
	jr nz, .postEncourageByOne_SS
.encourageByOne_SS
	dec [hl]
.postEncourageByOne_SS
	push hl
	push de
	CheckEvent EVENT_WEATHER_SANDSTORM
	pop de
	pop hl
	jp nz, .discourageByFour6
	push hl
	push de
	CheckEvent EVENT_WEATHER_SUNNY_DAY
	pop de
	pop hl
	jp nz, .encourageByThree6
	push hl
	push de
	CheckEvent EVENT_WEATHER_RAIN_DANCE
	pop de
	pop hl
	jp nz, .encourageByThree6
	push hl
	push de
	CheckEvent EVENT_WEATHER_HAIL
	pop de
	pop hl
	jp nz, .encourageByThree6
	jp .nextMove6
.moveIsHail
	ld a, [wPersonalizationTCGMode] ; 0=NO, 1=YES
	and a
	jr z, .typeCheckNoTCG_H
; TCG mode on
	ld a, [wEnemyMonType1]
	cp TCG_WATER
	jr z, .encourageByOne_H
	ld a, [wEnemyMonType2]
	cp TCG_WATER
	jr z, .encourageByOne_H
	jr .postEncourageByOne_H
.typeCheckNoTCG_H
	ld a, [wEnemyMonType1]
	cp ICE
	jr z, .encourageByOne_H
	ld a, [wEnemyMonType2]
	cp ICE
	jr nz, .postEncourageByOne_H
.encourageByOne_H
	dec [hl]
.postEncourageByOne_H
	push hl
	push de
	CheckEvent EVENT_WEATHER_HAIL
	pop de
	pop hl
	jp nz, .discourageByFour6
	push hl
	push de
	CheckEvent EVENT_WEATHER_SUNNY_DAY
	pop de
	pop hl
	jp nz, .encourageByThree6
	push hl
	push de
	CheckEvent EVENT_WEATHER_SANDSTORM
	pop de
	pop hl
	jp nz, .encourageByThree6
	push hl
	push de
	CheckEvent EVENT_WEATHER_RAIN_DANCE
	pop de
	pop hl
	jp nz, .encourageByThree6
	jp .nextMove6
.moveIsGrassyTerrain
	ld a, [wPersonalizationTCGMode] ; 0=NO, 1=YES
	and a
	jr z, .typeCheckNoTCG_GT
; TCG mode on
	ld a, [wEnemyMonType1]
	cp TCG_GRASS
	jr z, .encourageByOne_GT
	ld a, [wEnemyMonType2]
	cp TCG_GRASS
	jr z, .encourageByOne_GT
	jr .postEncourageByOne_GT
.typeCheckNoTCG_GT
	ld a, [wEnemyMonType1]
	cp GRASS
	jr z, .encourageByOne_GT
	ld a, [wEnemyMonType2]
	cp GRASS
	jr nz, .postEncourageByOne_GT
.encourageByOne_GT
	dec [hl]
.postEncourageByOne_GT
	push hl
	push de
	CheckEvent EVENT_TERRAIN_GRASSY
	pop de
	pop hl
	jp nz, .discourageByFour6
	push hl
	push de
	CheckEvent EVENT_TERRAIN_ELECTRIC
	pop de
	pop hl
	jp nz, .encourageByThree6
	push hl
	push de
	CheckEvent EVENT_TERRAIN_MISTY
	pop de
	pop hl
	jp nz, .encourageByThree6
	push hl
	push de
	CheckEvent EVENT_TERRAIN_PSYCHIC
	pop de
	pop hl
	jp nz, .encourageByThree6
	jp .nextMove6
.moveIsElectricTerrain
	ld a, [wPersonalizationTCGMode] ; 0=NO, 1=YES
	and a
	jr z, .typeCheckNoTCG_ET
; TCG mode on
	ld a, [wEnemyMonType1]
	cp TCG_LIGHTNING
	jr z, .encourageByOne_ET
	ld a, [wEnemyMonType2]
	cp TCG_LIGHTNING
	jr z, .encourageByOne_ET
	jr .postEncourageByOne_ET
.typeCheckNoTCG_ET
	ld a, [wEnemyMonType1]
	cp ELECTRIC
	jr z, .encourageByOne_ET
	ld a, [wEnemyMonType2]
	cp ELECTRIC
	jr nz, .postEncourageByOne_ET
.encourageByOne_ET
	dec [hl]
.postEncourageByOne_ET
	push hl
	push de
	CheckEvent EVENT_TERRAIN_ELECTRIC
	pop de
	pop hl
	jp nz, .discourageByFour6
	push hl
	push de
	CheckEvent EVENT_TERRAIN_GRASSY
	pop de
	pop hl
	jp nz, .encourageByThree6
	push hl
	push de
	CheckEvent EVENT_TERRAIN_MISTY
	pop de
	pop hl
	jp nz, .encourageByThree6
	push hl
	push de
	CheckEvent EVENT_TERRAIN_PSYCHIC
	pop de
	pop hl
	jp nz, .encourageByThree6
	jp .nextMove6
.moveIsPsychicTerrain
	ld a, [wPersonalizationTCGMode] ; 0=NO, 1=YES
	and a
	jr z, .typeCheckNoTCG_PT
; TCG mode on
	ld a, [wEnemyMonType1]
	cp TCG_PSYCHIC
	jr z, .encourageByOne_PT
	ld a, [wEnemyMonType2]
	cp TCG_PSYCHIC
	jr z, .encourageByOne_PT
	jr .postEncourageByOne_PT
.typeCheckNoTCG_PT
	ld a, [wEnemyMonType1]
	cp PSYCHIC_TYPE
	jr z, .encourageByOne_PT
	ld a, [wEnemyMonType2]
	cp PSYCHIC_TYPE
	jr nz, .postEncourageByOne_PT
.encourageByOne_PT
	dec [hl]
.postEncourageByOne_PT
	push hl
	push de
	CheckEvent EVENT_TERRAIN_PSYCHIC
	pop de
	pop hl
	jp nz, .discourageByFour6
	push hl
	push de
	CheckEvent EVENT_TERRAIN_ELECTRIC
	pop de
	pop hl
	jp nz, .encourageByThree6
	push hl
	push de
	CheckEvent EVENT_TERRAIN_MISTY
	pop de
	pop hl
	jp nz, .encourageByThree6
	push hl
	push de
	CheckEvent EVENT_TERRAIN_GRASSY
	pop de
	pop hl
	jp nz, .encourageByThree6
	jp .nextMove6
.moveIsMistyTerrain
; no type check because Misty Terrain doesn't power up Fairy moves
	push hl
	push de
	CheckEvent EVENT_TERRAIN_MISTY
	pop de
	pop hl
	jp nz, .discourageByFour6
	push hl
	push de
	CheckEvent EVENT_TERRAIN_ELECTRIC
	pop de
	pop hl
	jp nz, .encourageByThree6
	push hl
	push de
	CheckEvent EVENT_TERRAIN_GRASSY
	pop de
	pop hl
	jp nz, .encourageByThree6
	push hl
	push de
	CheckEvent EVENT_TERRAIN_PSYCHIC
	pop de
	pop hl
	jp nz, .encourageByThree6
	jp .nextMove6
.moveIsTrickRoom
; check if the opponent is faster than the player
	call CheckIfOpponentIsFasterThanPlayer ; c flag if opponent is faster
	jr c, .discourageByThree6 ; opponent is faster
; player is not slower than opponent
.encourageByTwelve6
	dec [hl]
	dec [hl]
	dec [hl]
	dec [hl]
	dec [hl]
	dec [hl]
	dec [hl]
	dec [hl]
	dec [hl]
.encourageByThree6
	dec [hl]
.encourageByTwo6
	dec [hl]
.encourageByOne6
	dec [hl]
	jp .nextMove6
.discourageByFour6 ; -----
	inc [hl]
.discourageByThree6
	inc [hl]
.discourageByTwo6
	inc [hl]
	inc [hl]
	jp .nextMove6

.modification3Part7 ; special interactions: STOMP vs MINIMIZE, EARTHQUAKE vs DIG, etc
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove7
	dec b
	jp z, .modification3Part8 ; processed all 4 moves ; edited
	inc hl
	ld a, [de]
	and a
	jp z, .modification3Part8 ; no more moves in move set ; edited
; actually do things with the move
	inc de
	call ReadMove
; check if it's one of the selected moves
	ld a, [wEnemyMoveNum]
	cp STOMP
	jr z, .moveIsStomp
	cp THUNDER
	jr z, .moveIsThunder
	cp HURRICANE
	jr z, .moveIsHurricane
	cp SURF
	jr z, .moveIsSurf
	cp WHIRLPOOL
	jr z, .moveIsWhirlpool
	cp EARTHQUAKE
	jr z, .moveIsEarthquake
	cp FLAIL
	jr z, .moveIsFlail
	ld a, [wEnemyMoveEffect]
	cp OHKO_EFFECT
	jp z, .moveIsOHKOLike
	cp TRAPPING_EFFECT
	jp z, .moveIsTrapping
	jp .nextMove7
.moveIsStomp
	ld a, [wPlayerMonMinimized]
	and a
	jp nz, .encourageByFour7
	jp .nextMove7
.moveIsThunder
	ld a, [wPlayerBattleStatus1]
	bit INVULNERABLE, a ; fly/dig/dive
	jp z, .nextMove7
	ld a, [wPlayerMoveNum]
	cp FLY
	jp z, .encourageByFive7
	jp .nextMove7
.moveIsHurricane
	ld a, [wPlayerBattleStatus1]
	bit INVULNERABLE, a ; fly/dig/dive
	jp z, .nextMove7
	ld a, [wPlayerMoveNum]
	cp FLY
	jp z, .encourageByFive7
	jp .nextMove7
.moveIsSurf
	ld a, [wPlayerBattleStatus1]
	bit INVULNERABLE, a ; fly/dig/dive
	jp z, .nextMove7
	ld a, [wPlayerMoveNum]
	cp DIVE
	jp z, .encourageByFive7
	jp .nextMove7
.moveIsWhirlpool
	ld a, [wPlayerBattleStatus1]
	bit INVULNERABLE, a ; fly/dig/dive
	jp z, .nextMove7
	ld a, [wPlayerMoveNum]
	cp DIVE
	jp z, .encourageByFive7
	jp .nextMove7
.moveIsEarthquake
	ld a, [wPlayerBattleStatus1]
	bit INVULNERABLE, a ; fly/dig/dive
	jp z, .nextMove7
	ld a, [wPlayerMoveNum]
	cp DIG
	jp z, .encourageByFive7
	jp .nextMove7
.moveIsFlail
	ld a, 20
	call AICheckIfHPBelowFractionPushesPops ; c flag if enemy trainer's current HP is < 1/a of MaxHP
	jp c, .encourageByFive7
	ld a, 10
	call AICheckIfHPBelowFractionPushesPops ; c flag if enemy trainer's current HP is < 1/a of MaxHP
	jp c, .encourageByThree7
	ld a, 5
	call AICheckIfHPBelowFractionPushesPops ; c flag if enemy trainer's current HP is < 1/a of MaxHP
	jp c, .encourageByOne7
	ld a, 3
	call AICheckIfHPBelowFractionPushesPops ; c flag if enemy trainer's current HP is < 1/a of MaxHP
	jp c, .nextMove7
	ld a, 2
	call AICheckIfHPBelowFractionPushesPops ; c flag if enemy trainer's current HP is < 1/a of MaxHP
	jp c, .discourageByOne7
	jp nc, .discourageByTwo7
;	jp .nextMove7
.moveIsOHKOLike
	ld a, [wEnemyBattleStatus2]
	bit USING_X_ACCURACY, a ; is the enemy using X Accuracy?
	jr nz, .encourageByTen7
	jp .nextMove7
.moveIsTrapping
	call CheckIfOpponentIsFasterThanPlayer ; c if opp is faster
	jp c, .encourageByThree7
	jp .nextMove7
.discourageByTen7 ; ---
	inc [hl]
	inc [hl]
	inc [hl]
	inc [hl]
	inc [hl]
	inc [hl]
.discourageByFour7
	inc [hl]
.discourageByThree7
	inc [hl]
.discourageByTwo7
	inc [hl]
.discourageByOne7
	inc [hl]
	jp .nextMove7
.encourageByTen7 ; ---
	dec [hl]
	dec [hl]
	dec [hl]
	dec [hl]
	dec [hl]
.encourageByFive7
	dec [hl]
.encourageByFour7
	dec [hl]
.encourageByThree7
	dec [hl]
.encourageByTwo7
	dec [hl]
.encourageByOne7
	dec [hl]
	jp .nextMove7

.modification3Part8 ; discourage moves used many times in a row
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove8
	dec b
	jp z, .modification3Part9 ; processed all 4 moves ; edited
	inc hl
	ld a, [de]
	and a
	jp z, .modification3Part9 ; no more moves in move set ; edited
; actually do things with the move
	inc de
	call ReadMove
; is the move the same as we last used?
	push hl
	ld hl, wLastMoveUsedByAIOpponent
	ld a, [wEnemyMoveNum]
	cp [hl]
	pop hl
	jp nz, .nextMove8 ; it's not the same move
; it is the same move as the last we used, check how many times before this we already used it
	ld a, [wHowManyTimesSameAIMoveInARow]
	cp 7
	jr nc, .discourageByFive8
	cp 6
	jr z, .discourageByFour8
	cp 5
	jr z, .discourageByThree8
	cp 4
	jr z, .discourageByTwo8
	cp 3
	jr z, .discourageByOne8
	jp .nextMove8
.discourageByFive8
	inc [hl]
.discourageByFour8
	inc [hl]
.discourageByThree8
	inc [hl]
.discourageByTwo8
	inc [hl]
.discourageByOne8
	inc [hl]
	jp .nextMove8

.modification3Part9
	ret

; new, to handle tactical switching:
; - when they are confused
; - when they are TOXICed
; - when they are trapped in a trapping move ; edited, is handled later
; - when enemy's mon is nerfed too much
; - when all of enemy's moves are discouraged
; - when the PERISHing counter is at 1
AIMoveChoiceModification4:
	ResetEvent EVENT_AI_SWITCH_MON
	ld a, [wEnemyBattleStatus1] ; ----------------------------------------------
	bit CONFUSED, a
	jr z, .checkToxiced
	call Random
	cp 66 percent
	jr nc, .checkToxiced
	jp .setSwitchingAndEnd
.checkToxiced ; ----------------------------------------------------------------
	ld a, [wEnemyBattleStatus3]
	bit BADLY_POISONED, a
	jr z, .checkNerfed
	call Random
	cp 20 percent
	jr nc, .checkNerfed
	jp .setSwitchingAndEnd
.checkNerfed ; -----------------------------------------------------------------
; for the modifiers: values can range from 1 - 13 ($1 to $D): 7 is normal
	ld hl, wEnemyMonAttackMod
	ld a, [hli]
	ld b, a ; b holds atk mod
	ld c, 5
.modifierLoop
	ld a, [hli]
	add b
	ld b, a ; b holds atk+(temporary sum of stats) mod
	dec c
	jr nz, .modifierLoop
; now we have the sum of the modifiers in b (and also in a actually)
	ld a, b ; redundant I guess
	cp 42
	jr nc, .checkEncouragement
; it's 41 or less
	cp 41
	jr z, .debuffedBy1
	cp 40
	jr z, .debuffedBy2
	cp 39
	jr z, .debuffedBy3
; 38 or less, i.e. debuffed by 4 or more, AI just switches
	jp .setSwitchingAndEnd
.debuffedBy1
	call Random
	cp 25 percent
	jr nc, .checkEncouragement
	jp .setSwitchingAndEnd
.debuffedBy2
	call Random
	cp 66 percent
	jr nc, .checkEncouragement
	jp .setSwitchingAndEnd
.debuffedBy3
	call Random
	cp 90 percent
	jr nc, .checkEncouragement
	jp .setSwitchingAndEnd
.checkEncouragement ; ----------------------------------------------------------
	ld hl, wBuffer - 1 ; temp move selection array (-1 byte offset)
	ld de, wEnemyMonMoves ; enemy moves
	ld b, NUM_MOVES + 1
.nextMove
	dec b
	jp z, .rollForEncouragementBasedSwitch ; processed all 4 moves, if here, AI may switches
	inc hl
	ld a, [de]
	and a
	jp z, .rollForEncouragementBasedSwitch ; no more moves in move set, if here, AI may switches
; let's check how dis/en-couraged the move is
	inc de ; for next loop
	ld a, [hl]
	cp 21 ; encouragement - 21; neutral: 20-21 -> c; discouraged: 21-21->nc
	jr c, .checkPerishing ; if even 1 move is not discouraged, no switch
	jr .nextMove
.checkPerishing ; --------------------------------------------------------------
	ld a, [wEnemyStatsToDouble]
	bit PERISHING, a
	jr z, .checkNext
	and PERISH_MASK
	cp 1
	jr z, .setSwitchingAndEnd
	; fallthrough
.checkNext ; -------------------------------------------------------------------
	ret
.rollForEncouragementBasedSwitch ; fix for V1.3: 20% to switch if all moves are discouraged; ugly but will do for now
	call Random
	cp 90 percent
	ret nc
.setSwitchingAndEnd ; ==========================================================
	SetEvent EVENT_AI_SWITCH_MON
	ret

ReadMove:
	push hl
	push de
	push bc
	dec a
	ld de, wEnemyMoveNum ; target of the copy
; edited, because of splitting the two files from within the same bank
	ld c, a ; new
	callfar MoveInfoCopier ; new
; back to vanilla
	pop bc
	pop de
	pop hl
	ret

INCLUDE "data/trainers/move_choices.asm"

;INCLUDE "data/trainers/pic_pointers_money.asm" ; edited, not necessary here

;INCLUDE "data/trainers/names.asm" ; edited, not necessary here

;INCLUDE "engine/battle/misc.asm" ; edited, not necessary here

; the next three need to be together, but don't need to be here

;INCLUDE "data/trainers/parties.asm"

;INCLUDE "engine/battle/read_trainer_party.asm"

;INCLUDE "data/trainers/special_moves.asm" ; now directly inside the above one

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
; new, to handle switches set by modification 4
	CheckAndResetEvent EVENT_AI_SWITCH_MON
	jr z, .noAISwitchFromModification4
	jp AISwitchIfEnoughMons
.noAISwitchFromModification4
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
	ld a, [hli]
	cp 4
	jr z, .trySwitchFromTrapping
	cp 0
	jp z, .noSwitchFromTrapping
	jr .readTrainerClassData
.trySwitchFromTrapping
	ld hl, wPlayerBattleStatus1
	bit USING_TRAPPING_MOVE, [hl]
	jr z, .noSwitchFromTrapping
; opponent is actually trapped, has a chance to switch out
	call Random
	cp 60 percent
	jr nc, .noSwitchFromTrapping
; opponent actually switches out from being trapped
	jp AISwitchIfEnoughMons
.noSwitchFromTrapping
; back to vanilla
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
	cp 20 percent + 1 ; edited
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

CooltrainerAI: ; edited: 70% change to use a Hyper Potion below 1/6 HP, and no switching
	cp 70 percent + 1
	ret nc
	ld a, 6 ; new
	call AICheckIfHPBelowFraction
	ret nc ; new
	jp AIUseHyperPotion

GamblerAI: ; new
	ld a, [WAITurnCounter]
	and a
	ret nz
	jp AIUseXAccuracy

; Gym Leaders: all edited ------------------------------------------------

; new: for all gym leaders, except Giovanni (and Orage)
GymLeadersCommonAI:
	callfar CountHowManyBadges ; returns in d the number of badges we own
	ld a, d
	and a
	jr z, .badges0
	dec a
	jr z, .badges1
	dec a
	jr z, .badges2
	dec a
	jr z, .badges3
	dec a
	jr z, .badges4
	dec a
	jr z, .badges5
	dec a
	jr z, .badges6
;.badges7or8
	ld a, 6
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseFullRestore
.badges6
	call Random
	cp 75 percent + 1
	ret nc
	ld a, 6
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseFullRestore
.badges5
	call Random
	cp 85 percent + 1
	ret nc
	ld a, 8
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseHyperPotion
.badges4
	call Random
	cp 75 percent + 1
	ret nc
	ld a, 6
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseHyperPotion
.badges3
	call Random
	cp 85 percent + 1
	ret nc
	ld a, 8
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseSuperPotion
.badges2
	call Random
	cp 75 percent + 1
	ret nc
	ld a, 6
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseSuperPotion
.badges1
	ld a, [wEnemyMonStatus]
	and a
	jp nz, AIUseFullHeal
	call Random
	cp 75 percent + 1
	ret nc
	ld a, 8
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUsePotion
.badges0
	ld a, [wEnemyMonStatus]
	and a
	jp nz, AIUseFullHeal
	call Random
	cp 65 percent + 1
	ret nc
	ld a, 6
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUsePotion

BrockAI:
	ld b, a ; temporarily hold the random value
	ld a, [WAITurnCounter]
	and a
	ld a, b ; restore the random value
	jp nz, GymLeadersCommonAI
; first turn
	cp 15 percent + 1
	jp c, AIUseXSpecial
	cp 30 percent + 1
	ret nc
	jp AIUseXSpeed

MistyAI:
	ld b, a ; temporarily hold the random value
	ld a, [WAITurnCounter]
	and a
	ld a, b ; restore the random value
	jp nz, GymLeadersCommonAI
; first turn
	cp 20 percent + 1
	jp c, AIUseXSpecial
	cp 30 percent + 1
	ret nc
	jp AIUseXAttack

LtSurgeAI:
	jp GymLeadersCommonAI

ErikaAI:
	jp GymLeadersCommonAI

KogaAI:
	ld b, a ; temporarily hold the random value
	ld a, [WAITurnCounter]
	and a
	ld a, b ; restore the random value
	jp nz, GymLeadersCommonAI
; first turn
	cp 30 percent + 1
	ret nc
	jp AIUseXAttack

SabrinaAI:
	ld b, a ; temporarily hold the random value
	ld a, [WAITurnCounter]
	and a
	ld a, b ; restore the random value
	jp nz, GymLeadersCommonAI
; first turn
	cp 30 percent + 1
	ret nc
	jp AIUseXDefend

BlaineAI:
	ld b, a ; temporarily hold the random value
	ld a, [WAITurnCounter]
	and a
	ld a, b ; restore the random value
	jp nz, GymLeadersCommonAI
; first turn
	cp 20 percent + 1
	ret nc
	jp AIUseXSpecial

OrageAI: ; new
	ld b, a ; temporarily hold the random value
	ld a, [WAITurnCounter]
	and a
	ld a, b ; restore the random value
	jp nz, GymLeadersCommonAI
; first turn
	cp  7 percent + 1
	jp c, AIUseXAttack
	cp 14 percent + 1
	jp c, AIUseXDefend
	cp 21 percent + 1
	jp c, AIUseXSpeed
	cp 28 percent + 1
	ret nc
	jp AIUseXSpecial

; end of Gym Leaders part -------------------------------------------------

Rival2AI:
	cp 13 percent - 1
	ret nc
	ld a, 5
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseSuperPotion ; updated

Rival3AI:
	cp 90 percent - 1 ; updated
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

BrunoAI: ; edited
	cp 50 percent + 1
	ret nc
	ld a, 5
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseFullRestore ; updated

AgathaAI: ; edited, no switching
;	cp 8 percent
;	jp c, AISwitchIfEnoughMons
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

AISwitchIfEnoughMons:: ; edited, 2 colons
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
; edited: reset here the trapping
	ld hl, wPlayerBattleStatus1
	res USING_TRAPPING_MOVE, [hl]

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

AIUseXAccuracy:
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

AIGetPriorityPushesPops: ; new
	push hl
	push bc
	push de
	callfar AIGetPriority ; load the priority of the opponent's move in e: 7 is neutral
	ld a, e ; a contains the priority of the move
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
	ld [wAltAnimationID], a ; new
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

; new ===================================================

CountHowManyPartyAlive: ; d = how many alive mons player has
	ld a, [wPartyCount]
	ld e, a
	xor a
	ld d, a ; d counts how many alive mons are there
	ld hl, wPartyMon1HP
	ld bc, wPartyMon2 - wPartyMon1 - 1
.partyMonsLoop
	ld a, [hl]
	inc hl
	or [hl]
	jr z, .noCounterIncrease
	inc d
.noCounterIncrease
	add hl, bc
	dec e
	jr nz, .partyMonsLoop
	ret

; check if the opponent is faster than the player
; c flag if opponent is faster
CheckIfOpponentIsFasterThanPlayer:
	push hl
	push de
	push bc
	ld hl, wEnemyMonSpeed
	ld de, wBattleMonSpeed
	ld a, [de]
	cp [hl] ; battling's speed - opponent mon's speed, MOST significant byte
	jr c, .opponentIsFaster
	inc hl
	inc de
	ld a, [de]
	cp [hl] ; battling's speed - opponent mon's speed, LEAST significant byte
.opponentIsFaster
	pop bc
	pop de
	pop hl
	ret
