JumpMoveEffect:
	call _JumpMoveEffect
	ld b, $1
	ret

_JumpMoveEffect:
	ldh a, [hWhoseTurn]
	and a
	ld a, [wPlayerMoveEffect]
	jr z, .next1
	ld a, [wEnemyMoveEffect]
.next1
	dec a ; subtract 1, there is no special effect for 00
	add a ; x2, 16bit pointers
	ld hl, MoveEffectPointerTable
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl ; jump to special effect handler

INCLUDE "data/moves/effects_pointers.asm"

SleepEffect:			; made into a jpfar to save space
	jpfar SleepEffect_	; made into a jpfar to save space

PoisonEffect:           ; made into a jpfar to save space
	jpfar PoisonEffect_ ; made into a jpfar to save space

DrainHPEffect:
	jpfar DrainHPEffect_

ExplodeEffect:           ; made into a jpfar to save space
	jpfar ExplodeEffect_ ; made into a jpfar to save space

FreezeBurnParalyzeEffect:
	xor a
	ld [wAnimationType], a
	call CheckTargetSubstitute ; test bit 4 of d063/d068 flags [target has substitute flag]
	ret nz ; return if they have a substitute, can't effect them
	ldh a, [hWhoseTurn]
	and a
	jp nz, .opponentAttacker
	ld a, [wEnemyMonStatus]
	and a
	jp nz, CheckDefrost ; can't inflict status if opponent is already statused
	ld a, [wPlayerMoveType]
	ld b, a
	ld a, [wEnemyMonType1]
	cp b ; do target type 1 and move type match?
	ret z  ; return if they match (an ice move can't freeze an ice-type, body slam can't paralyze a normal-type, etc.)
	ld a, [wEnemyMonType2]
	cp b ; do target type 2 and move type match?
	ret z  ; return if they match
	ld a, [wPlayerMoveEffect]
	; block commented away because it's useless stuff
;	cp UNUSED_EFFECT_23 ; more stadium stuff
;	jr nz, .asm_3f2c7
;	ld a, [wUnknownSerialFlag_d499]
;	and a
;	ld a, FREEZE_SIDE_EFFECT
;	ld b, 30 percent + 1
;	jr z, .regular_effectiveness
;	ld b, 10 percent + 1
;	jr .regular_effectiveness
;.asm_3f2c7
	cp PARALYZE_SIDE_EFFECT_CERT	; new
	jr z, .paralyze1				; new
	cp PARALYZE_SIDE_EFFECT1 + 1
	ld b, 10 percent + 1
	jr c, .regular_effectiveness
; extra effectiveness
	ld b, 30 percent + 1
	sub BURN_SIDE_EFFECT2 - BURN_SIDE_EFFECT1 ; treat extra effective as regular from now on
.regular_effectiveness
	push af
	call BattleRandom ; get random 8bit value for probability test
	cp b
	pop bc
	ret nc ; do nothing if random value is >= 1A or 4D [no status applied]
	ld a, b ; what type of effect is this?
	cp BURN_SIDE_EFFECT1
	jr z, .burn1
	cp FREEZE_SIDE_EFFECT
	jr z, .freeze1
.paralyze1							; new
	ld a, 1 << PAR
	ld [wEnemyMonStatus], a
	call QuarterSpeedDueToParalysis ; quarter speed of affected mon
	ld a, ANIM_A9
	call PlayBattleAnimation
	jp PrintMayNotAttackText ; print paralysis text
.burn1
	ld a, 1 << BRN
	ld [wEnemyMonStatus], a
	call HalveAttackDueToBurn ; halve attack of affected mon
	ld a, ANIM_A9
	call PlayBattleAnimation
	ld hl, BurnedText
	jp PrintText
.freeze1
	call ClearHyperBeam ; resets hyper beam (recharge) condition from target
	ld a, 1 << FRZ
	ld [wEnemyMonStatus], a
	ld a, ANIM_A9
	call PlayBattleAnimation
	ld hl, FrozenText
	jp PrintText
.opponentAttacker
	ld a, [wBattleMonStatus] ; mostly same as above with addresses swapped for opponent
	and a
	jp nz, CheckDefrost
	ld a, [wEnemyMoveType]
	ld b, a
	ld a, [wBattleMonType1]
	cp b
	ret z
	ld a, [wBattleMonType2]
	cp b
	ret z
	ld a, [wEnemyMoveEffect]
	; block commented away because it's useless stuff
;	cp UNUSED_EFFECT_23 ; more stadium stuff
;	jr nz, .asm_3f341
;	ld a, [wUnknownSerialFlag_d499]
;	and a
;	ld a, FREEZE_SIDE_EFFECT
;	ld b, 30 percent + 1
;	jr z, .regular_effectiveness2
;	ld b, 10 percent + 1
;	jr .regular_effectiveness2
;.asm_3f341
	cp PARALYZE_SIDE_EFFECT_CERT	; new
	jr z, .paralyze2				; new
	cp PARALYZE_SIDE_EFFECT1 + 1
	ld b, 10 percent + 1
	jr c, .regular_effectiveness2
; extra effectiveness
	ld b, 30 percent + 1
	sub BURN_SIDE_EFFECT2 - BURN_SIDE_EFFECT1 ; treat extra effective as regular from now on
.regular_effectiveness2
	push af
	call BattleRandom
	cp b
	pop bc
	ret nc
	ld a, b
	cp BURN_SIDE_EFFECT1
	jr z, .burn2
	cp FREEZE_SIDE_EFFECT
	jr z, .freeze2
.paralyze2							; new
	ld a, 1 << PAR
	ld [wBattleMonStatus], a
	call QuarterSpeedDueToParalysis
	ld a, ANIM_C7
	call PlayBattleAnimation2
	jp PrintMayNotAttackText
.burn2
	ld a, 1 << BRN
	ld [wBattleMonStatus], a
	call HalveAttackDueToBurn
	ld a, ANIM_C7
	call PlayBattleAnimation2
	ld hl, BurnedText
	jp PrintText
.freeze2
; hyper beam bits aren't reseted for opponent's side
	ld a, 1 << FRZ
	ld [wBattleMonStatus], a
	ld a, ANIM_C7
	call PlayBattleAnimation2
	ld hl, FrozenText
	jp PrintText

TriAttackEffect:
	xor a
	ld [wAnimationType], a
	call CheckTargetSubstitute ; test bit 4 of d063/d068 flags [target has substitute flag]
	ret nz ; return if they have a substitute, can't effect them
	ldh a, [hWhoseTurn]
	and a
	jp nz, .opponentAttacker
;	ld a, [wEnemyMonStatus]
;	and a
;	jp nz, CheckDefrost ; can't inflict status if opponent is already statused
    ; comment this because wanna make TRI_ATTACK powa and so bypasses type immunity because I like Porygon
;	ld a, [wPlayerMoveType]
;	ld b, a
;	ld a, [wEnemyMonType1]
;	cp b ; do target type 1 and move type match?
;	ret z  ; return if they match (an ice move can't freeze an ice-type, body slam can't paralyze a normal-type, etc.)
;	ld a, [wEnemyMonType2]
;	cp b ; do target type 2 and move type match?
;	ret z  ; return if they match
    ; I think i can comment all of this away? It'll be one single move and I don't care for Stadium shenanigans
	; oh lol I did it only for part of the code
;	ld a, [wPlayerMoveEffect]
;	cp UNUSED_EFFECT_23 ; more stadium stuff
;	jr nz, .asm_3f2c7
;	ld a, [wUnknownSerialFlag_d499]
;	and a
;	ld a, FREEZE_SIDE_EFFECT
;	ld b, 30 percent + 1
;	jr z, .regular_effectiveness
;	ld b, 10 percent + 1
;	jr .regular_effectiveness
;.asm_3f2c7
    call BattleRandom
    cp 30 percent + 1   ; sum chance that one of the three effects happens (10+10+10) [it's 30+30+30 in the test phase]
    ret nc              ; if the carry flag is not set, i.e. BattleRandom - 30 is NOT <0, i.e. rndm>=30, nothing happens
    ; multi-step check: 0-9 is freeze, 10-19 is burn, 20-29 is paralysis (I may be messing up some units out of how the carry considers the = case?)
    cp 10 percent + 1   ; 10, but 30 in test phase
    jr c, .paralyze1
    cp 20 percent + 1   ; 20, but 60 in test phase
    jr c, .burn1
    jr .freeze1
    ; all of this is now useless
;	cp PARALYZE_SIDE_EFFECT1 + 1
;	ld b, 10 percent + 1
;	jr c, .regular_effectiveness
;; extra effectiveness
;	ld b, 30 percent + 1
;	sub BURN_SIDE_EFFECT2 - BURN_SIDE_EFFECT1 ; treat extra effective as regular from now on
;.regular_effectiveness
;	push af
;	call BattleRandom ; get random 8bit value for probability test
;	cp b
;	pop bc
;	ret nc ; do nothing if random value is >= 1A or 4D [no status applied]
;	ld a, b ; what type of effect is this?
;	cp BURN_SIDE_EFFECT1
;	jr z, .burn1
;	cp FREEZE_SIDE_EFFECT
;	jr z, .freeze1
.paralyze1
	ld a, 1 << PAR
	ld [wEnemyMonStatus], a
	call QuarterSpeedDueToParalysis ; quarter speed of affected mon
	ld a, ANIM_A9
	call PlayBattleAnimation
	jp PrintMayNotAttackText ; print paralysis text
.burn1
	ld a, 1 << BRN
	ld [wEnemyMonStatus], a
	call HalveAttackDueToBurn ; halve attack of affected mon
	ld a, ANIM_A9
	call PlayBattleAnimation
	ld hl, BurnedText
	jp PrintText
.freeze1
	call ClearHyperBeam ; resets hyper beam (recharge) condition from target
	ld a, 1 << FRZ
	ld [wEnemyMonStatus], a
	ld a, ANIM_A9
	call PlayBattleAnimation
	ld hl, FrozenText
	jp PrintText
    ; here is basically just copy-and-paste of the "if player is attacking", modulo some different settings at the beginning
.opponentAttacker
;	ld a, [wBattleMonStatus] ; mostly same as above with addresses swapped for opponent
;	and a
;	jp nz, CheckDefrost
    ; useless as before?
;	ld a, [wEnemyMoveType]
;	ld b, a
;	ld a, [wBattleMonType1]
;	cp b
;	ret z
;	ld a, [wBattleMonType2]
;	cp b
;	ret z
;	ld a, [wEnemyMoveEffect]
;	cp UNUSED_EFFECT_23 ; more stadium stuff
;	jr nz, .asm_3f341
;	ld a, [wUnknownSerialFlag_d499]
;	and a
;	ld a, FREEZE_SIDE_EFFECT
;	ld b, 30 percent + 1
;	jr z, .regular_effectiveness2
;	ld b, 10 percent + 1
;	jr .regular_effectiveness2
;.asm_3f341
    call BattleRandom
    cp 30 percent + 1   ; sum chance that one of the three effects happens (10+10+10)
    ret nc              ; if the carry flag is not set, i.e. BattleRandom - 30 is NOT <0, i.e. rndm>=30, nothing happens
    ; multi-step check: 0-9 is freeze, 10-19 is burn, 20-29 is paralysis (I may be messing up some units out of how the carry considers the = case?)
    cp 10 percent + 1   ; 10, but 30 in test phase
    jr c, .paralyze2
    cp 20 percent + 1   ; 20, but 60 in test phase
    jr c, .burn2
    jr .freeze2
    ; again all useless?
;	cp PARALYZE_SIDE_EFFECT_CERT	; new
;	jr z, .paralyze2				; new
;	cp PARALYZE_SIDE_EFFECT1 + 1
;	ld b, 10 percent + 1
;	jr c, .regular_effectiveness2
;; extra effectiveness
;	ld b, 30 percent + 1
;	sub BURN_SIDE_EFFECT2 - BURN_SIDE_EFFECT1 ; treat extra effective as regular from now on
;.regular_effectiveness2
;	push af
;	call BattleRandom
;	cp b
;	pop bc
;	ret nc
;	ld a, b
;	cp BURN_SIDE_EFFECT1
;	jr z, .burn2
;	cp FREEZE_SIDE_EFFECT
;	jr z, .freeze2
.paralyze2
	ld a, 1 << PAR
	ld [wBattleMonStatus], a
	call QuarterSpeedDueToParalysis
	ld a, ANIM_C7
	call PlayBattleAnimation2
	jp PrintMayNotAttackText
.burn2
	ld a, 1 << BRN
	ld [wBattleMonStatus], a
	call HalveAttackDueToBurn
	ld a, ANIM_C7
	call PlayBattleAnimation2
	ld hl, BurnedText
	jp PrintText
.freeze2
; hyper beam bits aren't reseted for opponent's side
	ld a, 1 << FRZ
	ld [wBattleMonStatus], a
	ld a, ANIM_C7
	call PlayBattleAnimation2
	ld hl, FrozenText
	jp PrintText

PrintBurnText: ; new, testing
	ld hl, BurnedText
	jp PrintText

BurnedText:
	text_far _BurnedText
	text_end

FrozenText:
	text_far _FrozenText
	text_end

CheckDefrost:
; any fire-type move that has a chance inflict burn (all but Fire Spin) will defrost a frozen target
	and 1 << FRZ ; are they frozen?
	ret z ; return if so
	ldh a, [hWhoseTurn]
	and a
	jr nz, .opponent
	;player [attacker]
	ld a, [wPlayerMoveType]
	sub FIRE
	ret nz ; return if type of move used isn't fire
	ld [wEnemyMonStatus], a ; set opponent status to 00 ["defrost" a frozen monster]
	ld hl, wEnemyMon1Status
	ld a, [wEnemyMonPartyPos]
	ld bc, wEnemyMon2 - wEnemyMon1
	call AddNTimes
	xor a
	ld [hl], a ; clear status in roster
	ld hl, FireDefrostedText
	jr .common
.opponent
	ld a, [wEnemyMoveType] ; same as above with addresses swapped
	sub FIRE
	ret nz
	ld [wBattleMonStatus], a
	ld hl, wPartyMon1Status
	ld a, [wPlayerMonNumber]
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	xor a
	ld [hl], a
	ld hl, FireDefrostedText
.common
	jp PrintText

FireDefrostedText:
	text_far _FireDefrostedText
	text_end

SelfBuff10Percent:
	call BattleRandom
	cp 10 percent	; chance of self-buffing
	ret nc			; returns and doesn't buff if rolls 10 or higher
	call StatModifierUpEffect ; jr or call?
	ret

SelfBuff20Percent:
	call BattleRandom
	cp 20 percent	; chance of self-buffing
	ret nc			; returns and doesn't buff if rolls 20 or higher
	call StatModifierUpEffect ; jr or call?
	ret

; taking inspiration from Vortiene
AttackSpeedUpEffect: ; used for Dragon Dance
	ld de, wPlayerMoveEffect
	ldh a, [hWhoseTurn]
	and a
	jr z, .next
	ld de, wEnemyMoveEffect
.next
	ld a, SPEED_UP1_EFFECT
	ld [de], a
	push de
	call StatModifierUpEffect ; stat modifier raising function
	pop de
	ld a, ATTACK_UP_SIDE_EFF1 ; it's ugly I'm using the one whose name implies a 10% chance, but I can't be bothered to make another one
	ld [de], a ; we do the side effect for the second stat because it won't run the animation
	push de
	call StatModifierUpEffect ; stat modifier raising function
	pop de
	ld a, ATTACK_SPEED_UP1_EFFECT
	ld [de], a
	ret

AttackUpDefenseUpSpeedDownEffect:: ; used for Curse
	ld de, wPlayerMoveEffect
	ldh a, [hWhoseTurn]
	and a
	jr z, .next
	ld de, wEnemyMoveEffect
.next
	ld a, SPEED_SELFDOWN1
	ld [de], a
	push de
	call StatModifierSelfDownEffect ; stat modifier self-lowering function
	pop de
	ld a, DEFENSE_UP_SIDE_EFF1 ; ugly, see comment of Dragon Dance
	ld [de], a ; we do the side effect for the second stat because it won't run the animation
	push de
	call StatModifierUpEffect ; stat modifier raising function
	pop de
	ld a, ATTACK_UP_SIDE_EFF1 ; ugly, see comment of Dragon Dance
	ld [de], a ; we do the side effect for the second stat because it won't run the animation
	push de
	call StatModifierUpEffect ; stat modifier raising function
	pop de
	ld a, ATTACK_UP_DEFENSE_UP_SPEED_DOWN_EFFECT
	ld [de], a
	ret

StatModifierUpEffect:
	ld hl, wPlayerMonStatMods
	ld de, wPlayerMoveEffect
	ldh a, [hWhoseTurn]
	and a
	jr z, .statModifierUpEffect
	ld hl, wEnemyMonStatMods
	ld de, wEnemyMoveEffect
.statModifierUpEffect
	ld a, [de]
	cp ATTACK_UP_SIDE_EFF1 		; new, testing
	jr c, .vanillaCode
	cp ATTACK_UP_SIDE_EFF1
	jr z, .mapNewToAtk
	cp ATTACK_UP_SIDE_EFF2
	jr z, .mapNewToAtk
	cp DEFENSE_UP_SIDE_EFF1
	jr z, .mapNewToDef
.mapNewToAtk
	ld a, 0
	jr .incrementStatMod
.mapNewToDef
	ld a, 1
	jr .incrementStatMod
.vanillaCode
	sub ATTACK_UP1_EFFECT
	cp EVASION_UP1_EFFECT + $3 - ATTACK_UP1_EFFECT ; covers all +1 effects
	jr c, .incrementStatMod
	sub ATTACK_UP2_EFFECT - ATTACK_UP1_EFFECT ; map +2 effects to equivalent +1 effect
.incrementStatMod
	ld c, a
	ld b, $0
	add hl, bc
	ld b, [hl]
	inc b ; increment corresponding stat mod
	ld a, $d
	cp b ; can't raise stat past +6 ($d or 13)
	jp c, PrintNothingHappenedText
	ld a, [de]
	cp ATTACK_UP_SIDE_EFF1 ; new, testing
	jr nc, .ok
	cp ATTACK_UP1_EFFECT + $8 ; is it a +2 effect?
	jr c, .ok
	inc b ; if so, increment stat mod again
	ld a, $d
	cp b ; unless it's already +6
	jr nc, .ok
	ld b, a
.ok
	ld [hl], b
	ld a, c
	cp $4
	jr nc, UpdateStatDone ; jump if mod affected is evasion/accuracy
	push hl
	ld hl, wBattleMonAttack + 1
	ld de, wPlayerMonUnmodifiedAttack
	ldh a, [hWhoseTurn]
	and a
	jr z, .pointToStats
	ld hl, wEnemyMonAttack + 1
	ld de, wEnemyMonUnmodifiedAttack
.pointToStats
	push bc
	sla c
	ld b, $0
	add hl, bc ; hl = modified stat
	ld a, c
	add e
	ld e, a
	jr nc, .checkIf999
	inc d ; de = unmodified (original) stat
.checkIf999
	pop bc
	; check if stat is already 999
	ld a, [hld]
	sub LOW(MAX_STAT_VALUE)
	jr nz, .recalculateStat
	ld a, [hl]
	sbc HIGH(MAX_STAT_VALUE)
	jp z, RestoreOriginalStatModifier
.recalculateStat ; recalculate affected stat
                 ; paralysis and burn penalties, as well as badge boosts are ignored
	push hl
	push bc
	ld hl, StatModifierRatios
	dec b
	sla b
	ld c, b
	ld b, $0
	add hl, bc
	pop bc
	xor a
	ldh [hMultiplicand], a
	ld a, [de]
	ldh [hMultiplicand + 1], a
	inc de
	ld a, [de]
	ldh [hMultiplicand + 2], a
	ld a, [hli]
	ldh [hMultiplier], a
	call Multiply
	ld a, [hl]
	ldh [hDivisor], a
	ld b, $4
	call Divide
	pop hl
; cap at MAX_STAT_VALUE (999)
	ldh a, [hProduct + 3]
	sub LOW(MAX_STAT_VALUE)
	ldh a, [hProduct + 2]
	sbc HIGH(MAX_STAT_VALUE)
	jp c, UpdateStat
	ld a, HIGH(MAX_STAT_VALUE)
	ldh [hMultiplicand + 1], a
	ld a, LOW(MAX_STAT_VALUE)
	ldh [hMultiplicand + 2], a

UpdateStat:
	ldh a, [hProduct + 2]
	ld [hli], a
	ldh a, [hProduct + 3]
	ld [hl], a
	pop hl
UpdateStatDone:
	ld b, c
	inc b
	call PrintStatText
	ld hl, wPlayerBattleStatus2
	ld de, wPlayerMoveNum
	ld bc, wPlayerMonMinimized
	ldh a, [hWhoseTurn]
	and a
	jr z, .playerTurn
	ld hl, wEnemyBattleStatus2
	ld de, wEnemyMoveNum
	ld bc, wEnemyMonMinimized
.playerTurn
;;;;;;;;;; adapted from Vortiene
	push de
	ld de, wPlayerMoveEffect
	ldh a, [hWhoseTurn]
	and a
	jr z, .playerTurn2
	ld de, wEnemyMoveEffect
.playerTurn2
	ld a, [de]
	pop de
	cp ATTACK_UP_SIDE_EFF1
	jr nc, .skipAnimation
;;;;;;;;;;
	ld a, [de]
	cp MINIMIZE
	jr nz, .notMinimize
 ; if a substitute is up, slide off the substitute and show the mon pic before
 ; playing the minimize animation
	bit HAS_SUBSTITUTE_UP, [hl]
	push af
	push bc
	push de
	ld hl, HideSubstituteShowMonAnim
	ld b, BANK(HideSubstituteShowMonAnim)
	call nz, Bankswitch
	pop de
.notMinimize
	call PlayCurrentMoveAnimation
.skipAnimation	; adapted from Vortiene
	ld a, [de]
	cp MINIMIZE
	jr nz, .applyBadgeBoostsAndStatusPenalties
	pop bc
	ld a, $1
	ld [bc], a
	ld hl, ReshowSubstituteAnim
	ld b, BANK(ReshowSubstituteAnim)
	pop af
	call nz, Bankswitch
.applyBadgeBoostsAndStatusPenalties
	ld a, [wBadgeBoostOption]	; new code to handle the badge boost option
	cp 2						; new code to handle the badge boost option
	jr c, .noGlitchyBadgeBoost1	; new code to handle the badge boost option
	ldh a, [hWhoseTurn]
	and a
	call z, ApplyBadgeStatBoosts ; whenever the player uses a stat-up move, badge boosts get reapplied again to every stat,
	                             ; even to those not affected by the stat-up move (will be boosted further)
.noGlitchyBadgeBoost1			; new code to handle the badge boost option
	ld hl, MonsStatsRoseText
	call PrintText

; these shouldn't be here
	call QuarterSpeedDueToParalysis ; apply speed penalty to the player whose turn is not, if it's paralyzed
	jp HalveAttackDueToBurn ; apply attack penalty to the player whose turn is not, if it's burned

RestoreOriginalStatModifier:
	pop hl
	dec [hl]

PrintNothingHappenedText:
	ld hl, NothingHappenedText
	jp PrintText

MonsStatsRoseText:
	text_far _MonsStatsRoseText
	text_asm
	ld hl, GreatlyRoseText
	ldh a, [hWhoseTurn]
	and a
	ld a, [wPlayerMoveEffect]
	jr z, .playerTurn
	ld a, [wEnemyMoveEffect]
.playerTurn
	cp ATTACK_UP_SIDE_EFF1	; new, testing
	jp nc, .rose			; new, testing
	cp ATTACK_DOWN1_EFFECT
	ret nc
.rose						; new, testing
	ld hl, RoseText
	ret

GreatlyRoseText:
	text_pause
	text_far _GreatlyRoseText
; fallthrough
RoseText:
	text_far _RoseText
	text_end

StatModifierDownEffect:
	ld hl, wEnemyMonStatMods
	ld de, wPlayerMoveEffect
	ld bc, wEnemyBattleStatus1
	ldh a, [hWhoseTurn]
	and a
	jr z, .statModifierDownEffect
	ld hl, wPlayerMonStatMods
	ld de, wEnemyMoveEffect
	ld bc, wPlayerBattleStatus1
	; new: removed the 25% chance for opponent to miss a stat-reducer move
;	ld a, [wLinkState]
;	cp LINK_STATE_BATTLING
;	jr z, .statModifierDownEffect
;	call BattleRandom
;	cp 25 percent + 1 ; chance to miss by in regular battle
;	jp c, MoveMissed
.statModifierDownEffect
	call CheckTargetSubstitute ; can't hit through substitute
	jp nz, MoveMissed
	ld a, [de]
	cp ATTACK_DOWN_SIDE_EFFECT1		; new, was ATTACK_DOWN_SIDE_EFFECT3, which was ATTACK_DOWN_SIDE_EFFECT
	jr c, .nonSideEffect
	cp ATTACK_DOWN_SIDE_EFFECT_CERT	; new
	jr nc, .canLowerFurther			; new
	cp ATTACK_DOWN_SIDE_EFFECT3		; new
	jr nc, .goTo30ishChance			; new
	cp ATTACK_DOWN_SIDE_EFFECT2		; new
	jr nc, .goTo20Chance			; new
; would be goTo10Chance, but no need to jump to it if we failed the jr nc above
	call BattleRandom
	cp 10 percent + 1 ; chance for side effects
	jp nc, CantLowerAnymore
	jp c, .canLowerFurther
.goTo20Chance
	call BattleRandom
	cp 20 percent + 1 ; chance for side effects
	jp nc, CantLowerAnymore
	jp c, .canLowerFurther
.goTo30ishChance
	call BattleRandom
	cp 33 percent + 1 ; chance for side effects
	jp nc, CantLowerAnymore
;			jp c, .canLowerFurther	; unnecessary
;		.differentChance  			; new
;			call BattleRandom		; new
;			cp 99 percent + 1 ; different chance for side effects  ; new
;			jp nc, CantLowerAnymore	; new
.canLowerFurther 			; new
	ld a, [de]
	cp ATTACK_DOWN_SIDE_EFFECT_CERT	; new
	jr nc, .mappingCert				; new
	cp ATTACK_DOWN_SIDE_EFFECT3		; new
	jr nc, .mapping30				; new
	cp ATTACK_DOWN_SIDE_EFFECT2		; new
	jr nc, .mapping20				; new
	sub ATTACK_DOWN_SIDE_EFFECT1 	; map each stat to 0-5 (it said 3 because there was nothing lower accuracy or evasion?)
	jr .decrementStatMod			; new, bug fix!
.mappingCert						; new
	sub ATTACK_DOWN_SIDE_EFFECT_CERT 	; new ; map each stat to 0-5 (it said 3 because there was nothing lower accuracy or evasion?)
	jr .decrementStatMod
.mapping30							; new
	sub ATTACK_DOWN_SIDE_EFFECT3 	; new ; map each stat to 0-5 (it said 3 because there was nothing lower accuracy or evasion?)
	jr .decrementStatMod
.mapping20							; new
	sub ATTACK_DOWN_SIDE_EFFECT2 	; new ; map each stat to 0-5 (it said 3 because there was nothing lower accuracy or evasion?)
	jr .decrementStatMod
.nonSideEffect ; non-side effects only
	push hl
	push de
	push bc
	call MoveHitTest ; apply accuracy tests
	pop bc
	pop de
	pop hl
	ld a, [wMoveMissed]
	and a
	jp nz, MoveMissed
	ld a, [bc]
	bit INVULNERABLE, a ; fly/dig
	jp nz, MoveMissed
	ld a, [de]
	sub ATTACK_DOWN1_EFFECT
	cp EVASION_DOWN1_EFFECT + $3 - ATTACK_DOWN1_EFFECT ; covers all -1 effects
	jr c, .decrementStatMod
	sub ATTACK_DOWN2_EFFECT - ATTACK_DOWN1_EFFECT ; map -2 effects to corresponding -1 effect
.decrementStatMod
	ld c, a
	ld b, $0
	add hl, bc
	ld b, [hl]
	dec b ; dec corresponding stat mod
	jp z, CantLowerAnymore ; if stat mod is 1 (-6), can't lower anymore
	ld a, [de]
	cp ATTACK_DOWN2_EFFECT - $16 ; $24
	jr c, .ok
	cp EVASION_DOWN2_EFFECT + $5 ; $44
	jr nc, .ok
	dec b ; stat down 2 effects only (dec mod again)
	jr nz, .ok
	inc b ; increment mod to 1 (-6) if it would become 0 (-7)
.ok
	ld [hl], b ; save modified mod
	ld a, c
	cp $4
	jr nc, UpdateLoweredStatDone ; jump for evasion/accuracy
	push hl
	push de
	ld hl, wEnemyMonAttack + 1
	ld de, wEnemyMonUnmodifiedAttack
	ldh a, [hWhoseTurn]
	and a
	jr z, .pointToStat
	ld hl, wBattleMonAttack + 1
	ld de, wPlayerMonUnmodifiedAttack
.pointToStat
	push bc
	sla c
	ld b, $0
	add hl, bc ; hl = modified stat
	ld a, c
	add e
	ld e, a
	jr nc, .noCarry
	inc d ; de = unmodified stat
.noCarry
	pop bc
	ld a, [hld]
	sub $1 ; can't lower stat below 1 (-6)
	jr nz, .recalculateStat
	ld a, [hl]
	and a
	jp z, CantLowerAnymore_Pop
.recalculateStat
; recalculate affected stat
; paralysis and burn penalties, as well as badge boosts are ignored
	push hl
	push bc
	ld hl, StatModifierRatios
	dec b
	sla b
	ld c, b
	ld b, $0
	add hl, bc
	pop bc
	xor a
	ldh [hMultiplicand], a
	ld a, [de]
	ldh [hMultiplicand + 1], a
	inc de
	ld a, [de]
	ldh [hMultiplicand + 2], a
	ld a, [hli]
	ldh [hMultiplier], a
	call Multiply
	ld a, [hl]
	ldh [hDivisor], a
	ld b, $4
	call Divide
	pop hl
	ldh a, [hProduct + 3]
	ld b, a
	ldh a, [hProduct + 2]
	or b
	jp nz, UpdateLoweredStat
	ldh [hMultiplicand + 1], a
	ld a, $1
	ldh [hMultiplicand + 2], a

UpdateLoweredStat:
	ldh a, [hProduct + 2]
	ld [hli], a
	ldh a, [hProduct + 3]
	ld [hl], a
	pop de
	pop hl
UpdateLoweredStatDone:
	ld b, c
	inc b
	push de
	call PrintStatText
	pop de
	ld a, [de]
    cp ATTACK_SELFDOWN1
    jr c, .nonSelfDebuffingMoves
    jr .ApplyBadgeBoostsAndStatusPenalties
.nonSelfDebuffingMoves ; vanilla code
	cp ATTACK_DOWN_SIDE_EFFECT1 ; new, edited, it was $44, hard-coded number for the no-longer-existing ATTACK_DOWN_SIDE_EFFECT
	jr nc, .ApplyBadgeBoostsAndStatusPenalties
	call PlayCurrentMoveAnimation2
.ApplyBadgeBoostsAndStatusPenalties
    cp ATTACK_SELFDOWN1
    jr nc, .selfDebuffingMoves
	ld a, [wBadgeBoostOption]	; new code to handle the badge boost option
	cp 2						; new code to handle the badge boost option
	jr c, .noGlitchyBadgeBoost2	; new code to handle the badge boost option
	ldh a, [hWhoseTurn]
	and a
	call nz, ApplyBadgeStatBoosts	; vanilla "nz" call
.noGlitchyBadgeBoost2			; new code to handle the badge boost option
	ld hl, MonsStatsFellText
	call PrintText
	jr .bizarreContinuation			; new
.selfDebuffingMoves
	ld a, [wBadgeBoostOption]	; new code to handle the badge boost option
	cp 2						; new code to handle the badge boost option
	jr c, .noGlitchyBadgeBoost3	; new code to handle the badge boost option
    ldh a, [hWhoseTurn]
    and a
    call z, ApplyBadgeStatBoosts	; new, edited: whenever the player uses a self-debuff move, badge boosts get reapplied again to every stat
.noGlitchyBadgeBoost3			; new code to handle the badge boost option
	ld hl, MonsStatsSelfFellText
	call PrintText
.bizarreContinuation				; new
; These where probably added given that a stat-down move affecting speed or attack will override
; the stat penalties from paralysis and burn respectively.
; But they are always called regardless of the stat affected by the stat-down move.
	call QuarterSpeedDueToParalysis
	jp HalveAttackDueToBurn

CantLowerAnymore_Pop:
	pop de
	pop hl
	inc [hl]

CantLowerAnymore:
	ld a, [de]
	cp ATTACK_DOWN_SIDE_EFFECT1
	ret nc
	ld hl, NothingHappenedText
	jp PrintText

MoveMissed:
	ld a, [de]
	cp ATTACK_DOWN_SIDE_EFFECT1 ; new, edited, it was $44, hard-coded number for the no-longer-existing ATTACK_DOWN_SIDE_EFFECT
	ret nc
	jp ConditionalPrintButItFailed

MonsStatsFellText:
	text_far _MonsStatsFellText
	text_asm
	ld hl, FellText
	ldh a, [hWhoseTurn]
	and a
	ld a, [wPlayerMoveEffect]
	jr z, .playerTurn
	ld a, [wEnemyMoveEffect]
.playerTurn
; check if the move's effect decreases a stat by 2
	cp BIDE_EFFECT
	ret c
	cp ATTACK_DOWN_SIDE_EFFECT1 ; edited, it was $44, hard-coded number for the no-longer-existing ATTACK_DOWN_SIDE_EFFECT
	ret nc
	ld hl, GreatlyFellText
    ret

MonsStatsSelfFellText: ; new, updated for the self-debuffing moves
	text_far _MonsStatsSelfFellText
	text_asm
	ld hl, FellText
	ldh a, [hWhoseTurn]
	and a
	ld a, [wPlayerMoveEffect]
	jr z, .playerTurn
	ld a, [wEnemyMoveEffect]
.playerTurn
; check if the move's effect decreases a stat by 2
    cp ATTACK_SELFDOWN2
    ret c
    ld hl, GreatlyFellText
	ret

GreatlyFellText:
	text_pause
	text_far _GreatlyFellText
; fallthrough
FellText:
	text_far _FellText
	text_end

PrintStatText:
	ld hl, StatModTextStrings
	ld c, "@"
.findStatName_outer
	dec b
	jr z, .foundStatName
.findStatName_inner
	ld a, [hli]
	cp c
	jr z, .findStatName_outer
	jr .findStatName_inner
.foundStatName
	ld de, wStringBuffer
	ld bc, $a
	jp CopyData

; === NEW BIG BLOCKs for SELF-DEBUFFING MOVES ===

AttackDefenseSelfDownEffect: ; used for SUPERPOWER
	ld de, wPlayerMoveEffect
	ldh a, [hWhoseTurn]
	and a
	jr z, .next
	ld de, wEnemyMoveEffect
.next
	ld a, ATTACK_SELFDOWN1
	ld [de], a
	push de
	call StatModifierSelfDownEffect ; stat modifier self-lowering function
	pop de
	ld a, DEFENSE_SELFDOWN1
	ld [de], a
	push de
	call StatModifierSelfDownEffect ; stat modifier self-lowering function
	pop de
	ld a, ATTACK_DEFENSE_SELFDOWN1
	ld [de], a
	ret

DefenseSpecialSelfDownEffect: ; used for CLOSE_COMBAT
	ld de, wPlayerMoveEffect
	ldh a, [hWhoseTurn]
	and a
	jr z, .next
	ld de, wEnemyMoveEffect
.next
	ld a, DEFENSE_SELFDOWN1
	ld [de], a
	push de
	call StatModifierSelfDownEffect ; stat modifier self-lowering function
	pop de
	ld a, SPECIAL_SELFDOWN1
	ld [de], a
	push de
	call StatModifierSelfDownEffect ; stat modifier self-lowering function
	pop de
	ld a, DEFENSE_SPECIAL_SELFDOWN1
	ld [de], a
	ret

StatModifierSelfDownEffect:
    ; different from usual, because we're lowering the stats of the mon that is attacking
	ld hl, wPlayerMonStatMods
	ld de, wPlayerMoveEffect
	ld bc, wPlayerBattleStatus1
	ldh a, [hWhoseTurn]
	and a
	jr z, .statModifierDownEffect
	ld hl, wEnemyMonStatMods
	ld de, wEnemyMoveEffect
	ld bc, wEnemyBattleStatus1
    ; --- no 25% chance of missing
.statModifierDownEffect
    ; --- no SUBSTITUTE check
	ld a, [de]
;	cp ATTACK_DOWN_SIDE_EFFECT ; TO BE EDITED
;	jr c, .nonSideEffect
;	ld a, [de] ; IS THIS NECESSARY?
	sub ATTACK_SELFDOWN1 ; map each stat to 0-3
	cp ATTACK_SELFDOWN2-ATTACK_SELFDOWN1
	jr c, .continueWithDebuff
	sub ATTACK_SELFDOWN2-ATTACK_SELFDOWN1
;	jr .decrementStatMod
;.nonSideEffect ; non-side effects only
;	push hl
;	push de
;	push bc
;	call MoveHitTest ; apply accuracy tests
;	pop bc
;	pop de
;	pop hl
;	ld a, [wMoveMissed]
;	and a
;	jp nz, MoveMissed
;	ld a, [bc]
;	bit INVULNERABLE, a ; fly/dig
;	jp nz, MoveMissed
;	ld a, [de]
;	sub ATTACK_DOWN1_EFFECT
;	cp EVASION_DOWN1_EFFECT + $3 - ATTACK_DOWN1_EFFECT ; covers all -1 effects
;	jr c, .decrementStatMod
;	sub ATTACK_DOWN2_EFFECT - ATTACK_DOWN1_EFFECT ; map -2 effects to corresponding -1 effect
;.decrementStatMod
.continueWithDebuff
	ld c, a
	ld b, $0
	add hl, bc
	ld b, [hl]
	dec b ; dec corresponding stat mod
	jp z, CantLowerAnymore ; if stat mod is 1 (-6), can't lower anymore
	ld a, [de]
	cp ATTACK_SELFDOWN2 ; new, is it a -2 effect? to be tested
	jr c, .ok
	dec b ; stat down 2 effects only (dec mod again)
	jr nz, .ok
	inc b ; increment mod to 1 (-6) if it would become 0 (-7)
.ok
	ld [hl], b ; save modified mod
	ld a, c
	cp $4
	jp nc, UpdateLoweredStatDone ; jump for evasion/accuracy - why?
	push hl
	push de
	ld hl, wBattleMonAttack + 1        ; new, swapped with below
	ld de, wPlayerMonUnmodifiedAttack  ; new, swapped with below
	ldh a, [hWhoseTurn]
	and a
	jr z, .pointToStat
	ld hl, wEnemyMonAttack + 1         ; new, swapped with above
	ld de, wEnemyMonUnmodifiedAttack   ; new, swapped with above
.pointToStat
	push bc
	sla c
	ld b, $0
	add hl, bc ; hl = modified stat
	ld a, c
	add e
	ld e, a
	jr nc, .noCarry
	inc d ; de = unmodified stat
.noCarry
	pop bc
	ld a, [hld]
	sub $1 ; can't lower stat below 1 (-6)
	jr nz, .recalculateStat
	ld a, [hl]
	and a
	jp z, CantLowerAnymore_Pop
.recalculateStat
; recalculate affected stat
; paralysis and burn penalties, as well as badge boosts are ignored
	push hl
	push bc
	ld hl, StatModifierRatios
	dec b
	sla b
	ld c, b
	ld b, $0
	add hl, bc
	pop bc
	xor a
	ldh [hMultiplicand], a
	ld a, [de]
	ldh [hMultiplicand + 1], a
	inc de
	ld a, [de]
	ldh [hMultiplicand + 2], a
	ld a, [hli]
	ldh [hMultiplier], a
	call Multiply
	ld a, [hl]
	ldh [hDivisor], a
	ld b, $4
	call Divide
	pop hl
	ldh a, [hProduct + 3]
	ld b, a
	ldh a, [hProduct + 2]
	or b
	jp nz, UpdateLoweredStat
	ldh [hMultiplicand + 1], a
	ld a, $1
	ldh [hMultiplicand + 2], a
    jp UpdateLoweredStat

INCLUDE "data/battle/stat_mod_names.asm"
INCLUDE "data/battle/stat_modifiers.asm"

BideEffect:
	ld hl, wPlayerBattleStatus1
	ld de, wPlayerBideAccumulatedDamage
	ld bc, wPlayerNumAttacksLeft
	ldh a, [hWhoseTurn]
	and a
	jr z, .bideEffect
	ld hl, wEnemyBattleStatus1
	ld de, wEnemyBideAccumulatedDamage
	ld bc, wEnemyNumAttacksLeft
.bideEffect
	set STORING_ENERGY, [hl] ; mon is now using bide
	xor a
	ld [de], a
	inc de
	ld [de], a
	ld [wPlayerMoveEffect], a
	ld [wEnemyMoveEffect], a
	call BattleRandom
	and $1
	inc a
	inc a
	ld [bc], a ; set Bide counter to 2 or 3 at random
	ldh a, [hWhoseTurn]
	add XSTATITEM_ANIM
	jp PlayBattleAnimation2

ThrashPetalDanceEffect:
	ld hl, wPlayerBattleStatus1
	ld de, wPlayerNumAttacksLeft
	ldh a, [hWhoseTurn]
	and a
	jr z, .thrashPetalDanceEffect
	ld hl, wEnemyBattleStatus1
	ld de, wEnemyNumAttacksLeft
.thrashPetalDanceEffect
	set THRASHING_ABOUT, [hl] ; mon is now using thrash/petal dance
	call BattleRandom
	and $1
	inc a
	inc a
	ld [de], a ; set thrash/petal dance counter to 2 or 3 at random
	; edited to avoid the squares for OUTRAGE
	ldh a, [hWhoseTurn]
	and a
	ld a, [wPlayerMoveNum]
	jr z, .continue
	ld a, [wEnemyMoveNum]
.continue
	cp OUTRAGE
	ld a, 0
	jr z, .skipExtraAnimation
	ldh a, [hWhoseTurn]	; vanilla code
	add ANIM_B0			; vanilla code
.skipExtraAnimation
	jp PlayBattleAnimation2

SwitchAndTeleportEffect:			; made into a jpfar to save space
	jpfar SwitchAndTeleportEffect_	; made into a jpfar to save space

TwoToFiveAttacksEffect:				; made into a jpfar to save space
	jpfar TwoToFiveAttacksEffect_	; made into a jpfar to save space

FlinchSideEffect:					; made into a jpfar to save space
	jpfar FlinchSideEffect_			; made into a jpfar to save space

OneHitKOEffect:
	jpfar OneHitKOEffect_

ChargeEffect:
	ld hl, wPlayerBattleStatus1
	ld de, wPlayerMoveEffect
	ldh a, [hWhoseTurn]
	and a
	jr z, .chargeEffect
	ld hl, wEnemyBattleStatus1
	ld de, wEnemyMoveEffect
.chargeEffect
	ld b, XSTATITEM_ANIM ; edited
	set CHARGING_UP, [hl]
	ld a, [de]
	dec de ; de contains enemy or player MOVENUM
	cp FLY_EFFECT
	jr nz, .notFly
	set INVULNERABLE, [hl] ; mon is now invulnerable to typical attacks (fly/dig)
	ld b, TELEPORT ; load Teleport's animation
.notFly
	ld a, [de]
	cp DIG
	jr nz, .notDigOrFly
	set INVULNERABLE, [hl] ; mon is now invulnerable to typical attacks (fly/dig)
	ld b, ANIM_C0
.notDigOrFly
	push de
	push bc
	inc hl ; battle status 2
	push hl
	ld a, [hl]
	bit HAS_SUBSTITUTE_UP, a
	ld hl, HideSubstituteShowMonAnim
	ld b, BANK(HideSubstituteShowMonAnim)
	call nz, Bankswitch
	pop hl
	pop bc
	xor a
	ld [wAnimationType], a
	ld a, b
	call PlayBattleAnimation
	ld a, [hl]
	bit HAS_SUBSTITUTE_UP, a
	ld hl, ReshowSubstituteAnim
	ld b, BANK(ReshowSubstituteAnim)
	call nz, Bankswitch
	pop de
	ld a, [de]
	ld [wChargeMoveNum], a
	ld hl, ChargeMoveEffectText
	jp PrintText

ChargeMoveEffectText:
	text_far _ChargeMoveEffectText
	text_asm
	ld a, [wChargeMoveNum]
;	cp RAZOR_WIND
;	ld hl, MadeWhirlwindText
;	jr z, .gotText
	cp SOLARBEAM
	ld hl, TookInSunlightText
	jr z, .gotText
;	cp SKULL_BASH
;	ld hl, LoweredItsHeadText
;	jr z, .gotText
;	cp SKY_ATTACK
;	ld hl, SkyAttackGlowingText
;	jr z, .gotText
	cp FLY
	ld hl, FlewUpHighText
	jr z, .gotText
	cp DIG
	ld hl, DugAHoleText
.gotText
	ret

;MadeWhirlwindText:
;	text_far _MadeWhirlwindText
;	text_end

TookInSunlightText:
	text_far _TookInSunlightText
	text_end

;LoweredItsHeadText:
;	text_far _LoweredItsHeadText
;	text_end

;SkyAttackGlowingText:
;	text_far _SkyAttackGlowingText
;	text_end

FlewUpHighText:
	text_far _FlewUpHighText
	text_end

DugAHoleText:
	text_far _DugAHoleText
	text_end

TrappingEffect:				; made into a jpfar to save space
	jpfar TrappingEffect_	; made into a jpfar to save space

MistEffect:
	jpfar MistEffect_

FocusEnergyEffect:
	jpfar FocusEnergyEffect_

RecoilEffect:
	jpfar RecoilEffect_

Confusion10SideEffect:
	call BattleRandom
	cp 10 percent ; chance of confusion
	ret nc
	jr ConfusionSideEffectSuccess

Confusion20SideEffect:
	call BattleRandom
	cp 20 percent ; chance of confusion
	ret nc
	jr ConfusionSideEffectSuccess

Confusion30SideEffect:
	call BattleRandom
	cp 30 percent ; chance of confusion
	ret nc
	jr ConfusionSideEffectSuccess

ConfusionEffect:
	call CheckTargetSubstitute
	jr nz, ConfusionEffectFailed
	call MoveHitTest
	ld a, [wMoveMissed]
	and a
	jr nz, ConfusionEffectFailed

ConfusionSideEffectSuccess:
	ldh a, [hWhoseTurn]
	and a
	ld hl, wEnemyBattleStatus1
	ld bc, wEnemyConfusedCounter
	ld a, [wPlayerMoveEffect]
	jr z, .confuseTarget
	ld hl, wPlayerBattleStatus1
	ld bc, wPlayerConfusedCounter
	ld a, [wEnemyMoveEffect]
.confuseTarget
	bit CONFUSED, [hl] ; is mon confused?
	jr nz, ConfusionEffectFailed
	set CONFUSED, [hl] ; mon is now confused
	push af
	call BattleRandom
	and $3
	inc a
	inc a
	ld [bc], a ; confusion status will last 2-5 turns
	pop af
;	cp CONFUSION_SIDE_EFFECT3			; Vortiene's suggestion
;	jr z, .doneConfusion				; Vortiene's suggestion
;	cp CONFUSION_SIDE_EFFECT2			; Vortiene's suggestion
;	jr z, .doneConfusion				; Vortiene's suggestion
;	cp CONFUSION_SIDE_EFFECT1			; Vortiene's suggestion
;	jr z, .doneConfusion				; Vortiene's suggestion
	cp CONFUSION_SIDE_EFFECT1			; simplified version
	jr nc, .doneConfusion				; skip the animation if EFFECT-CONFUSION_SIDE_EFFECT1 has no carry, i.e. the difference is >=0
	call PlayCurrentMoveAnimation2		; Vortiene's suggestion
.doneConfusion							; Vortiene's suggestion
	ld hl, BecameConfusedText			; Vortiene's suggestion
	jp PrintText						; Vortiene's suggestion

BecameConfusedText:
	text_far _BecameConfusedText
	text_end

ConfusionEffectFailed: 				; this seems like I've modified it ok?
	cp CONFUSION_SIDE_EFFECT1
	ret z
	cp CONFUSION_SIDE_EFFECT2
	ret z
	cp CONFUSION_SIDE_EFFECT3
	ret z
	ld c, 50
	call DelayFrames
	jp ConditionalPrintButItFailed

ParalyzeEffect:
	jpfar ParalyzeEffect_

BurnEffect:					; new
	jpfar BurnEffect_		; new

SubstituteEffect:
	jpfar SubstituteEffect_

HyperBeamEffect:
	ld hl, wPlayerBattleStatus2
	ldh a, [hWhoseTurn]
	and a
	jr z, .hyperBeamEffect
	ld hl, wEnemyBattleStatus2
.hyperBeamEffect
	set NEEDS_TO_RECHARGE, [hl] ; mon now needs to recharge
	ret

ClearHyperBeam:
	push hl
	ld hl, wEnemyBattleStatus2
	ldh a, [hWhoseTurn]
	and a
	jr z, .playerTurn
	ld hl, wPlayerBattleStatus2
.playerTurn
	res NEEDS_TO_RECHARGE, [hl] ; mon no longer needs to recharge
	pop hl
	ret

MimicEffect:				; made into a jpfar to save space
	jpfar MimicEffect_		; made into a jpfar to save space

LeechSeedEffect:
	jpfar LeechSeedEffect_

CurseEffect:
	jpfar CurseEffect_

SplashEffect:
	call PlayCurrentMoveAnimation
	jp PrintNoEffectText

DisableEffect:				; made into a jpfar to save space
	jpfar DisableEffect_	; made into a jpfar to save space

PayDayEffect:
	jpfar PayDayEffect_

ConversionEffect:
	jpfar ConversionEffect_

HazeEffect:
	jpfar HazeEffect_

HealEffect:
	jpfar HealEffect_

TransformEffect:
	jpfar TransformEffect_

ReflectLightScreenEffect:
	jpfar ReflectLightScreenEffect_

NothingHappenedText:
	text_far _NothingHappenedText
	text_end

PrintNoEffectText:
	ld hl, NoEffectText
	jp PrintText

NoEffectText:
	text_far _NoEffectText
	text_end

ConditionalPrintButItFailed:
	ld a, [wMoveDidntMiss]
	and a
	ret nz ; return if the side effect failed, yet the attack was successful

PrintButItFailedText_:
	ld hl, ButItFailedText
	jp PrintText

ButItFailedText:
	text_far _ButItFailedText
	text_end

PrintDidntAffectText:
	ld hl, DidntAffectText
	jp PrintText

DidntAffectText:
	text_far _DidntAffectText
	text_end

IsUnaffectedText:
	text_far _IsUnaffectedText
	text_end

PrintMayNotAttackText:
	ld hl, ParalyzedMayNotAttackText
	jp PrintText

ParalyzedMayNotAttackText:
	text_far _ParalyzedMayNotAttackText
	text_end

CheckTargetSubstitute:
	push hl
	ld hl, wEnemyBattleStatus2
	ldh a, [hWhoseTurn]
	and a
	jr z, .next1
	ld hl, wPlayerBattleStatus2
.next1
	bit HAS_SUBSTITUTE_UP, [hl]
	pop hl
	ret

PlayCurrentMoveAnimation2:
; animation at MOVENUM will be played unless MOVENUM is 0
; plays wAnimationType 3 or 6
	ldh a, [hWhoseTurn]
	and a
	ld a, [wPlayerMoveNum]
	jr z, .notEnemyTurn
	ld a, [wEnemyMoveNum]
.notEnemyTurn
	and a
	ret z

PlayBattleAnimation2:
; play animation ID at a and animation type 6 or 3
	ld [wAnimationID], a
	ldh a, [hWhoseTurn]
	and a
	ld a, $6
	jr z, .storeAnimationType
	ld a, $3
.storeAnimationType
	ld [wAnimationType], a
	jp PlayBattleAnimationGotID

PlayCurrentMoveAnimation:
; animation at MOVENUM will be played unless MOVENUM is 0
; resets wAnimationType
	xor a
	ld [wAnimationType], a
	ldh a, [hWhoseTurn]
	and a
	ld a, [wPlayerMoveNum]
	jr z, .notEnemyTurn
	ld a, [wEnemyMoveNum]
.notEnemyTurn
	and a
	ret z

PlayBattleAnimation:
; play animation ID at a and predefined animation type
	ld [wAnimationID], a

PlayBattleAnimationGotID:
; play animation at wAnimationID
	push hl
	push de
	push bc
	predef MoveAnimation
	callfar Func_78e98
	pop bc
	pop de
	pop hl
	ret
