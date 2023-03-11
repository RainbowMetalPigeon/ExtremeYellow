BurnEffect_:
	ld hl, wEnemyMonStatus
	ld de, wPlayerMoveType
	ldh a, [hWhoseTurn]
	and a
	jp z, .next
	ld hl, wBattleMonStatus
	ld de, wEnemyMoveType
.next
;	farcall CheckTargetSubstitute
;	jr nz, .didntAffect ; can't burn a substitute target
;	ld a, [hli]
	ld a, [hl]
	ld b, a
	and a
	jr nz, .didntAffect ; miss if target is already statused
	ld a, [wEnemyMonType1]
	cp FIRE					; this is functionally just for WILL_O_WISP, so we can de facto merely check if the opp's types are FIRE, in which case doesn't work
	jr z, .didntAffect
	ld a, [wEnemyMonType2]
	cp FIRE					; check type 2 for FIRE
	jr z, .didntAffect
;	ld a, [hli]
;	cp FIRE ; can't burn a fire-type target
;	jr z, .didntAffect
;	ld a, [hld]
;	cp FIRE ; can't burn a fire-type target
;	jr z, .didntAffect
;.hitTest
	push hl
	callfar MoveHitTest
	pop hl
	ld a, [wMoveMissed]
	and a
	jr nz, .didntAffect
	set BRN, [hl]
	callfar HalveAttackDueToBurn
	ld c, 30
	call DelayFrames
	callfar PlayCurrentMoveAnimation
	jpfar BurnedText
.didntAffect
	ld c, 50
	call DelayFrames
	jpfar PrintDidntAffectText
.doesntAffect
	ld c, 50
	call DelayFrames
	jpfar PrintDoesntAffectText
