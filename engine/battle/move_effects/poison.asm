PoisonEffect_:
	ResetEvent EVENT_OPPONENT_SECONDARY_EFFECT_GUARANTEED ; new, to handle luck: secondary effects
	ld hl, wEnemyMonStatus
	ld de, wPlayerMoveEffect
	ldh a, [hWhoseTurn]
	and a
	jr z, .poisonEffect
	ld hl, wBattleMonStatus
	ld de, wEnemyMoveEffect
; new, to handle luck: secondary effects
	ld a, [hWhoseTurn]
	and a
	jr z, .playersTurn
; enemy's turn
	ld a, [wLuckSecondaryEffects] ; 0=NORMAL, 1=PLAYER MIN, 2=ENEMY MAX, 3=BOTH
	and a
	jr z, .vanillaLuck
	cp 1
	jr z, .vanillaLuck
; enemy's turn, and their luck is max
	SetEvent EVENT_OPPONENT_SECONDARY_EFFECT_GUARANTEED
	jr .vanillaLuck
.playersTurn
	ld a, [wLuckSecondaryEffects]
	and a
	jr z, .vanillaLuck
	cp 2
	jr z, .vanillaLuck
; player's turn and their luck is minimum
	jp .noEffect
.vanillaLuck
; back to vanilla
.poisonEffect
	push hl ; new
	push de ; new
	callfar CheckTargetSubstitute ; edited into a callfar
	pop de  ; new
	pop hl  ; new
	jp nz, .noEffect ; can't poison a substitute target
	ld a, [hli]
	ld b, a
	and a
	jp nz, .noEffect ; miss if target is already statused
; new, to handle STEEL (which can be poisoned in inverse battles but not in normal ones, while POISON can't anytime)
	ld a, [wInverseBattle]
	and a
	jr nz, .inverseBattle
	ld a, [hli]
	cp STEEL ; can't poison a steel-type target in a normal battle
	jp z, .noEffect
	ld a, [hld]
	cp STEEL ; can't poison a steel-type target in a normal battle
	jp z, .noEffect
.inverseBattle ; vanilla bits
	ld a, [hli]
	cp POISON ; can't poison a poison-type target
	jp z, .noEffect
	ld a, [hld]
	cp POISON ; can't poison a poison-type target
	jp z, .noEffect
.vanilla
; back to vanilla
; new to check terrain
	push hl
	call CheckIfNonTurnPokemonIsFlying ; z flag = FLYING
	pop hl
	jr z, .noMistyTerrain
	CheckEvent EVENT_TERRAIN_MISTY
	jr z, .noMistyTerrain
	; Misty terrain: check if side effect or not
	ld a, [de]
	cp POISON_EFFECT
	ret nz
	; if non-side effect, print the message
	ld hl, TheTerrainPreventsText
	jp PrintText
.noMistyTerrain
; BTV
	ld a, [de] ; load move effect; changed names to make numbers reflect rate, and added two new rates
	cp POISON_SIDE_EFFECT1
	ld b, 10 percent + 1 ; chance of poisoning
	jr z, .sideEffectTest
	cp POISON_SIDE_EFFECT2
	ld b, 20 percent + 1 ; chance of poisoning
	jr z, .sideEffectTest
	cp POISON_SIDE_EFFECT3
	ld b, 30 percent + 1 ; chance of poisoning
	jr z, .sideEffectTest
	cp POISON_SIDE_EFFECT4
	ld b, 40 percent + 1 ; chance of poisoning
	jr z, .sideEffectTest
	push hl
	push de
	callfar MoveHitTest ; apply accuracy tests, edited into a callfar
	pop de
	pop hl
	ld a, [wMoveMissed]
	and a
	jr nz, .didntAffect
	jr .inflictPoison
.sideEffectTest
; new, to handle luck: secondary effects
	push hl
	CheckAndResetEvent EVENT_OPPONENT_SECONDARY_EFFECT_GUARANTEED
	pop hl
	jr nz, .inflictPoison
; back to vanilla
	call BattleRandom2 ; edited into the copy
	cp b ; was side effect successful?
	ret nc
.inflictPoison
	dec hl
	set 3, [hl] ; mon is now poisoned
	push de
	dec de
	ldh a, [hWhoseTurn]
	and a
	ld b, ANIM_C7
	ld hl, wPlayerBattleStatus3
	ld a, [de]
	ld de, wPlayerToxicCounter
	jr nz, .ok
	ld b, ANIM_A9
	ld hl, wEnemyBattleStatus3
	ld de, wEnemyToxicCounter
.ok
	cp TOXIC
	jr nz, .normalPoison ; done if move is not Toxic
	set BADLY_POISONED, [hl] ; else set Toxic battstatus
	xor a
	ld [de], a
	ld hl, BadlyPoisonedText
	jr .continue
.normalPoison
	ld hl, PoisonedText
.continue
	pop de
	ld a, [de]
	cp POISON_EFFECT
	jr z, .regularPoisonEffect
	ld a, b
	call PlayAlternativeAnimation2Copy ; edited
	jp PrintText
.regularPoisonEffect
	call PlayCurrentMoveAnimation2Copy
	jp PrintText
.noEffect
	ld a, [de]
	cp POISON_EFFECT
	ret nz
.didntAffect
	ld c, 5 ; edited, was 50
	call DelayFrames
	jpfar PrintDidntAffectText

PoisonedText:
	text_far _PoisonedText
	text_end

BadlyPoisonedText:
	text_far _BadlyPoisonedText
	text_end
