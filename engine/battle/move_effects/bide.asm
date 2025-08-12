BideEffect_::
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
	call BattleRandom2 ; edited
	and $1
	inc a
	inc a
	ld [bc], a ; set Bide counter to 2 or 3 at random
	ldh a, [hWhoseTurn]
	add XSTATITEM_ANIM
	jp PlayAlternativeAnimation2Copy ; edited twice
