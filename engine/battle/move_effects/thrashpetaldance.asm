ThrashPetalDanceEffect_::
	ld hl, wPlayerBattleStatus1
	ld de, wPlayerNumAttacksLeft
	ldh a, [hWhoseTurn]
	and a
	jr z, .thrashPetalDanceEffect
	ld hl, wEnemyBattleStatus1
	ld de, wEnemyNumAttacksLeft
.thrashPetalDanceEffect
	set THRASHING_ABOUT, [hl] ; mon is now using thrash/petal dance
	call BattleRandom2 ; edited
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
	jp PlayAlternativeAnimation2Copy ; edited twice
