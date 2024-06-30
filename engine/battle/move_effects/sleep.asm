SleepEffect_:
	ld de, wEnemyMonStatus
	ld bc, wEnemyBattleStatus2
	ldh a, [hWhoseTurn]
	and a
	jp z, .sleepEffect
	ld de, wBattleMonStatus
	ld bc, wPlayerBattleStatus2

.sleepEffect
	ld a, [bc]
	bit NEEDS_TO_RECHARGE, a ; does the target need to recharge? (hyper beam)
	res NEEDS_TO_RECHARGE, a ; target no longer needs to recharge
	ld [bc], a
	jr nz, .setSleepCounter ; if the target had to recharge, all hit tests will be skipped
	                        ; including the event where the target already has another status
	ld a, [de]
	ld b, a
	and $7
	jr z, .notAlreadySleeping ; can't affect a mon that is already asleep
	ld hl, AlreadyAsleepText
	jp PrintText
.notAlreadySleeping
	ld a, b
	and a
	jr nz, .didntAffect ; can't affect a mon that is already statused
	push de
	callfar MoveHitTest ; apply accuracy tests ; edited, made into a callfar
	pop de
	ld a, [wMoveMissed]
	and a
	jr nz, .didntAffect
; new, to handle luck: statuses affliction
	ld a, [hWhoseTurn]
	and a
	jr z, .playersTurn
; enemy's turn
	ld a, [wLuckStatusesAffliction] ; 0=NORMAL, 1=PLAYER MIN, 2=ENEMY MAX, 3=BOTH
	and a
	jr z, .vanillaLuck
	cp 1
	jr z, .vanillaLuck
; enemy's turn, and their luck is max
	ld a, 7
	jr .sleepTurnsSet
.playersTurn
	ld a, [wLuckStatusesAffliction]
	and a
	jr z, .vanillaLuck
	cp 2
	jr z, .vanillaLuck
; player's turn and their luck is minimum
	ld a, 1
	jr .sleepTurnsSet
.vanillaLuck
; back to vanilla
.setSleepCounter
; set target's sleep counter to a random number between 1 and 7
	call BattleRandom2 ; edited
	and $7
	jr z, .setSleepCounter
.sleepTurnsSet ; new label to handle luck: statuses affliction
	ld b, a
	ld a, [wUnknownSerialFlag_d499]
	and a
	jr z, .asm_3f1ba ; XXX stadium stuff?
	ld a, b
	and $3
	jr z, .setSleepCounter
	ld b, a
.asm_3f1ba
	ld a, b
	ld [de], a
	callfar PlayCurrentMoveAnimation2 ; edited, made into a callfar
	ld hl, FellAsleepText
	jp PrintText
.didntAffect
	jpfar PrintDidntAffectText ; edited, made into a jpfar

FellAsleepText:
	text_far _FellAsleepText
	text_end

AlreadyAsleepText:
	text_far _AlreadyAsleepText
	text_end
