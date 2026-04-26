PerishSongEffect_:
	ld hl, wPlayerStatsToDouble
;Check PERISHING bit of each pokemon, if both are already set to 1, then effect will fail ("But if Failed!")
	bit PERISHING, [hl]
	jr z, .applyPerishingStatusPlayer ;Player is not Perishing,
	
	ld hl, wEnemyStatsToDouble
	bit PERISHING, [hl]
	jr z, .applyPerishingStatusEnemy ;Enemy is not Perishing,
	jr .failed; Both already Perishing
	
.applyPerishingStatusPlayer
	
; If Player Pokemon is not currently PERISHING, then it's counter will be set to 4 and PERISHING status to 1

	set PERISHING, [hl]
	set 2, [hl] ;setting bit 2 which = value 4, the initial value of the Perish Song Count

; Check again if Enemy is Perishing or not. If already perishing, skip next step
	ld hl, wEnemyStatsToDouble
	bit PERISHING, [hl]
	jr nz, .done

.applyPerishingStatusEnemy
; If Enemy Pokemon is not currently PERISHING, then it's counter will be set to 4 and PERISHING status to 1
	set PERISHING, [hl]
	set 2, [hl] ;setting bit 2 which = value 4, the initial value of the Perish Song Count

.done
	ld hl, PerishText
	push hl
	ld hl, PlayCurrentMoveAnimation
	call EffectCallBattleCore4 ; TBE
	pop hl
	jp PrintText

;but if failed text	
.failed
	ld c, 50
	call DelayFrames
	ld hl, PrintButItFailedText_
	jp EffectCallBattleCore4 ; TBE


PerishText:
	text_far _PerishText
	text_end

EffectCallBattleCore4: ; TBE
	ld b, BANK(BattleCore)
	jp Bankswitch
	
	
PerishEndOfTurn:
;Are either perishing?
	ld hl, wPlayerStatsToDouble
;Check PERISHING bit of each pokemon, if both are already set to 1, then effect will fail ("But if Failed!")
	bit PERISHING, [hl]
	jr nz, .reducePerishCountPlayer ;Player is Perishing
	
	ld hl, wEnemyStatsToDouble
	bit PERISHING, [hl]
	jr nz, .reducePerishCountEnemy ;Enemy is Perishing
	ret ;nobody Perishing, return

.reducePerishCountPlayer
;reduce Player PERISH Count and display text
	ld a, [hl]
	dec a
	ld [hl], a
;for text
	and PERISH_MASK
	ld [wAnotherTemporaryStorageVariable2], a
	ld a, 1
	ld [hWhoseTurn], a

	ld hl, PerishCountText
	call PrintText
	
	xor a
	ld [wAnotherTemporaryStorageVariable2], a

;check again if enemy is Pershing
	ld hl, wEnemyStatsToDouble
	bit PERISHING, [hl]
	jr z, .perishFaint ;Enemy is not Perishing

;enemy
.reducePerishCountEnemy

;reduce Enemy PERISH Count and display text
	ld a, [hl]
	dec a
	ld [hl], a
;for text
	and PERISH_MASK
	ld [wAnotherTemporaryStorageVariable2], a
	ld a, 0
	ld [hWhoseTurn], a

	ld hl, PerishCountText
	call PrintText
	
	xor a
	ld [wAnotherTemporaryStorageVariable2], a

.perishFaint

;Faint Player
;if count = 0, faint (explode effect should be fine, but in gen 2, HP doesn't even visibly drop)

	ld hl, wPlayerStatsToDouble
	bit PERISHING, [hl]
	jr z, .enemyFaint ;Player is not Perishing
	ld a, [hl]
	and PERISH_MASK
	jr nz, .enemyFaint ;Player Perish Count <> 0	
	
;ExplodeEffect:
	ld hl, wBattleMonHP
	ld de, wPlayerBattleStatus2
	xor a
	ld [hli], a ; set the mon's HP to 0
	ld [hli], a
	inc hl
	ld [hl], a ; set mon's status to 0
	ld a, [de]
	res SEEDED, a ; clear mon's leech seed status
	ld [de], a
	
.enemyFaint

	ld hl, wEnemyStatsToDouble
	bit PERISHING, [hl]
	ret z ;Enemy is not Perishing
	ld a, [hl]
	and PERISH_MASK
	ret nz ;Enemy Perish Count <> 0	
	
;ExplodeEffect:
	ld hl, wEnemyMonHP
	ld de, wEnemyBattleStatus2
	xor a
	ld [hli], a ; set the mon's HP to 0
	ld [hli], a
	inc hl
	ld [hl], a ; set mon's status to 0
	ld a, [de]
	res SEEDED, a ; clear mon's leech seed status
	ld [de], a

	ret

PerishCountText:
	text_far _PerishCountText
	text_end
