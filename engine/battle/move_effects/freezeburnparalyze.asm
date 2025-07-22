FreezeBurnParalyzeEffect_::
	xor a
	ld [wAnimationType], a
	callfar CheckTargetSubstitute ; test bit 4 of d063/d068 flags [target has substitute flag] ; edited into a callfar
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
	cp PARALYZE_SIDE_EFFECT_CERT	; new
	jr z, .paralyze1				; new
; new, to handle luck: secondary effects.
	ld a, [wLuckSecondaryEffects] ; 0=NORMAL, 1=PLAYER MIN, 2=ENEMY MAX, 3=BOTH
	and a
	jr z, .vanillaLuck
	cp 2
	jr z, .vanillaLuck
; player's turn and their luck is minimum
	ret ; do nothing
.vanillaLuck
	ld a, [wPlayerMoveEffect]
; back to vanilla
	cp PARALYZE_SIDE_EFFECT1 + 1
	ld b, 10 percent + 1
	jr c, .regular_effectiveness
; extra effectiveness
	ld b, 30 percent + 1
	sub BURN_SIDE_EFFECT2 - BURN_SIDE_EFFECT1 ; treat extra effective as regular from now on
.regular_effectiveness
	push af
	call BattleRandom2 ; get random 8bit value for probability test ; edited into the copy
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
	callfar QuarterSpeedDueToParalysis ; quarter speed of affected mon ; edited into a callfar
	ld a, ANIM_A9
	call PlayAlternativeAnimationCopy ; edited ; edited into the copy
	jp PrintMayNotAttackText ; print paralysis text
.burn1
	ld a, 1 << BRN
	ld [wEnemyMonStatus], a
	callfar HalveAttackDueToBurn ; halve attack of affected mon ; edited into a callfar
	ld a, ANIM_A9
	call PlayAlternativeAnimationCopy ; edited ; edited into the copy
	ld hl, BurnedText
	jp PrintText
.freeze1
; new
	CheckEvent EVENT_WEATHER_SUNNY_DAY
	ret nz ; can't freeze under sun
; TBV
	callfar ClearHyperBeam ; resets hyper beam (recharge) condition from target ; edited into a callfar
	ld a, 1 << FRZ
	ld [wEnemyMonStatus], a
	ld a, ANIM_A9
	call PlayAlternativeAnimationCopy ; edited ; edited into the copy
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
; new, to handle luck: secondary effects
	ld a, [wLuckSecondaryEffects] ; 0=NORMAL, 1=PLAYER MIN, 2=ENEMY MAX, 3=BOTH
	and a
	jr z, .vanillaLuck2
	cp 1
	jr z, .vanillaLuck2
; enemy's turn, and their luck is max
	SetEvent EVENT_OPPONENT_SECONDARY_EFFECT_GUARANTEED
	jr .vanillaLuck2
.vanillaLuck2
; back to vanilla
	ld a, [wEnemyMoveEffect]
	cp PARALYZE_SIDE_EFFECT_CERT	; new
	jr z, .paralyze2				; new
	cp PARALYZE_SIDE_EFFECT1 + 1
	ld b, 10 percent + 1
	jr c, .regular_effectiveness2
; extra effectiveness
	ld b, 30 percent + 1
	sub BURN_SIDE_EFFECT2 - BURN_SIDE_EFFECT1 ; treat extra effective as regular from now on
.regular_effectiveness2
; new, to handle luck: secondary effects
	CheckAndResetEvent EVENT_OPPONENT_SECONDARY_EFFECT_GUARANTEED
	jr nz, .opponentLuckMax
; back to vanilla
	push af
	call BattleRandom2 ; edited into the copy
	cp b
	pop bc
	ret nc
	ld a, b
.opponentLuckMax
	cp BURN_SIDE_EFFECT1
	jr z, .burn2
	cp FREEZE_SIDE_EFFECT
	jr z, .freeze2
.paralyze2							; new
	ld a, 1 << PAR
	ld [wBattleMonStatus], a
	callfar QuarterSpeedDueToParalysis ; edited into a callfar
	ld a, ANIM_C7
	call PlayBattleAnimation2Copy ; edited into the copy
	jp PrintMayNotAttackText
.burn2
	ld a, 1 << BRN
	ld [wBattleMonStatus], a
	callfar HalveAttackDueToBurn ; edited into a callfar
	ld a, ANIM_C7
	call PlayBattleAnimation2Copy ; edited into the copy
	ld hl, BurnedText
	jp PrintText
.freeze2
; new
	CheckEvent EVENT_WEATHER_SUNNY_DAY
	ret nz ; can't freeze under sun
; TBV
; hyper beam bits aren't reseted for opponent's side
	ld a, 1 << FRZ
	ld [wBattleMonStatus], a
	ld a, ANIM_C7
	call PlayBattleAnimation2Copy ; edited into the copy
	ld hl, FrozenText
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

PrintMayNotAttackText:
	ld hl, ParalyzedMayNotAttackText
	jp PrintText

ParalyzedMayNotAttackText:
	text_far _ParalyzedMayNotAttackText
	text_end
