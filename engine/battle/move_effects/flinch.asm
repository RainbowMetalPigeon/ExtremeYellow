FlinchSideEffect_:
	callfar CheckTargetSubstitute	; edited
	ret nz
	ld hl, wEnemyBattleStatus1
	ld de, wPlayerMoveEffect
	ldh a, [hWhoseTurn]
	and a
	jr z, .flinchSideEffect
	ld hl, wPlayerBattleStatus1
	ld de, wEnemyMoveEffect
.flinchSideEffect
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
;	call z, ClearHyperBeam		; edited
	jr nz, .continueVanilla		; edited
	push hl						; new, to make the migration work
	callfar ClearHyperBeam		; edited
	pop hl						; new, to make the migration work
.continueVanilla				; edited
	ld a, [de]
	cp FLINCH_SIDE_EFFECT1
	ld b, 10 percent + 1 ; chance of flinch (FLINCH_SIDE_EFFECT1)
	jr z, .gotEffectChance
	cp FLINCH_SIDE_EFFECT2											; new
	ld b, 20 percent + 1 ; chance of flinch (FLINCH_SIDE_EFFECT2)	; new
	jr z, .gotEffectChance											; new
	ld b, 30 percent + 1 ; chance of flinch otherwise (FLINCH_SIDE_EFFECT3)
.gotEffectChance
	call BattleRandom2	; edited
	cp b
	ret nc
	set FLINCHED, [hl] ; set mon's status to flinching
	callfar ClearHyperBeam	; edited
	ret
