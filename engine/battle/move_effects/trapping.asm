TrappingEffect_:
	ld hl, wPlayerBattleStatus1
	ld de, wPlayerNumAttacksLeft
	ldh a, [hWhoseTurn]
	and a
	jr z, .trappingEffect
	ld hl, wEnemyBattleStatus1
	ld de, wEnemyNumAttacksLeft
.trappingEffect
	bit USING_TRAPPING_MOVE, [hl]
	ret nz
	push hl					; new, to make the migration work
	callfar ClearHyperBeam	; since this effect is called before testing whether the move will hit,
                        	; the target won't need to recharge even if the trapping move missed
	pop hl					; new, to make the migration work
	set USING_TRAPPING_MOVE, [hl] ; mon is now using a trapping move
	; 3/8 chance for 2 and 3 attacks, and 1/8 chance for 4 and 5 attacks
;	callfar BattleRandom	; not good, it's not really random, because a register is not preserved over a farcall/callfar
	call BattleRandom2		; new, seems to be doing just fine!
	and $3
	cp $2
	jr c, .setTrappingCounter
;	callfar BattleRandom	; not good, it's not really random, because a register is not preserved over a farcall/callfar
	call BattleRandom2		; new, seems to be doing just fine!
	and $3
.setTrappingCounter
	inc a
	ld [de], a
	ret
