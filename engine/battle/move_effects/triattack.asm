TriAttackEffect_::
	xor a
	ld [wAnimationType], a
	callfar CheckTargetSubstitute ; test bit 4 of d063/d068 flags [target has substitute flag] ; edited into a callfar
	ret nz ; return if they have a substitute, can't effect them
	ldh a, [hWhoseTurn]
	and a
	jp nz, .opponentAttacker
; we are attacking
	ld a, [wEnemyMonStatus]
	and a
	ret nz ; we can't statusize an already statusized mon
    call BattleRandom2 ; edited into the copy
    cp 30 percent + 1   ; sum chance that one of the three effects happens (10+10+10) [it's 30+30+30 in the test phase]
    ret nc              ; if the carry flag is not set, i.e. BattleRandom2 - 30 is NOT <0, i.e. rndm>=30, nothing happens
; multi-step check: 0-9 is freeze, 10-19 is burn, 20-29 is paralysis
    cp 10 percent + 1   ; 10, but 30 in test phase
    jr c, .paralyze1
    cp 20 percent + 1   ; 20, but 60 in test phase
    jr c, .burn1
    jr .freeze1
.paralyze1
	ld a, 1 << PAR
	ld [wEnemyMonStatus], a
	callfar QuarterSpeedDueToParalysis ; quarter speed of affected mon ; edited into a callfar
	ld a, ANIM_A9
	call PlayBattleAnimation2Copy ; edited into the copy
	jpfar PrintMayNotAttackText ; print paralysis text ; edited into a jpfar
.burn1
	ld a, 1 << BRN
	ld [wEnemyMonStatus], a
	callfar HalveAttackDueToBurn ; halve attack of affected mon ; edited into a callfar
	ld a, ANIM_A9
	call PlayBattleAnimation2Copy ; edited into the copy
	ld hl, BurnedText2 ; edited into the copy present in the burn file
	jp PrintText
.freeze1
	callfar ClearHyperBeam ; resets hyper beam (recharge) condition from target ; edited into a callfar
	ld a, 1 << FRZ
	ld [wEnemyMonStatus], a
	ld a, ANIM_A9
	call PlayBattleAnimation2Copy ; edited into the copy
	ld hl, FrozenText2 ; edited into the copy here
	jp PrintText
; here is basically just copy-and-paste of the "if player is attacking", modulo some different settings at the beginning
.opponentAttacker
	ld a, [wBattleMonStatus] ; mostly same as above with addresses swapped for opponent
	and a
	ret nz ; we cannot be statusized if we already are
    call BattleRandom2 ; edited into the copy
    cp 30 percent + 1   ; sum chance that one of the three effects happens (10+10+10)
    ret nc              ; if the carry flag is not set, i.e. BattleRandom2 - 30 is NOT <0, i.e. rndm>=30, nothing happens
    ; multi-step check: 0-9 is freeze, 10-19 is burn, 20-29 is paralysis (I may be messing up some units out of how the carry considers the = case?)
    cp 10 percent + 1   ; 10, but 30 in test phase
    jr c, .paralyze2
    cp 20 percent + 1   ; 20, but 60 in test phase
    jr c, .burn2
    jr .freeze2
.paralyze2
	ld a, 1 << PAR
	ld [wBattleMonStatus], a
	callfar QuarterSpeedDueToParalysis ; edited into a callfar
	ld a, ANIM_C7
	call PlayBattleAnimation2Copy ; edited into the copy2
	jpfar PrintMayNotAttackText ; edited into a jpfar
.burn2
	ld a, 1 << BRN
	ld [wBattleMonStatus], a
	callfar HalveAttackDueToBurn ; edited into a callfar
	ld a, ANIM_C7
	call PlayBattleAnimation2Copy ; edited into the copy2
	ld hl, BurnedText2 ; edited into the copy present in the burn file
	jp PrintText
.freeze2
; hyper beam bits aren't reseted for opponent's side
	ld a, 1 << FRZ
	ld [wBattleMonStatus], a
	ld a, ANIM_C7
	call PlayBattleAnimation2Copy ; edited into the copy2
	ld hl, FrozenText2 ; edited into the copy here
	jp PrintText

FrozenText2:
	text_far _FrozenText
	text_end
