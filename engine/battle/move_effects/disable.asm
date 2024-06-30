DisableEffect_:
	callfar MoveHitTest ; edited, made into a callfar
	ld a, [wMoveMissed]
	and a
	jp nz, .moveMissed
	ld de, wEnemyDisabledMove
	ld hl, wEnemyMonMoves
	ldh a, [hWhoseTurn]
	and a
	jr z, .disableEffect
	ld de, wPlayerDisabledMove
	ld hl, wBattleMonMoves
.disableEffect
; no effect if target already has a move disabled
	ld a, [de]
	and a
	jp nz, .moveMissed
.pickMoveToDisable
	push hl
	call BattleRandom2 ; edited, new random function
	and $3
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [hl]
	pop hl
	and a
	jr z, .pickMoveToDisable ; loop until a non-00 move slot is found
	ld [wd11e], a ; store move number
	push hl
	ldh a, [hWhoseTurn]
	and a
	ld hl, wBattleMonPP
	jr nz, .enemyTurn
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	pop hl ; wEnemyMonMoves
	jr nz, .playerTurnNotLinkBattle
; .playerTurnLinkBattle
	push hl
	ld hl, wEnemyMonPP
.enemyTurn
	push hl
	ld a, [hli]
	or [hl]
	inc hl
	or [hl]
	inc hl
	or [hl]
	and $3f
	pop hl ; wBattleMonPP or wEnemyMonPP
	jr z, .moveMissedPopHL ; nothing to do if all moves have no PP left
	add hl, bc
	ld a, [hl]
	pop hl
	and a
	jr z, .pickMoveToDisable ; pick another move if this one had 0 PP
.playerTurnNotLinkBattle
; non-link battle enemies have unlimited PP so the previous checks aren't needed
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
	ld a, 8
	jr .disableTurnsSet
.playersTurn
	ld a, [wLuckStatusesAffliction]
	and a
	jr z, .vanillaLuck
	cp 2
	jr z, .vanillaLuck
; player's turn and their luck is minimum
	ld a, 1
	jr .disableTurnsSet
.vanillaLuck
; back to vanilla
	call BattleRandom2 ; edited, new random function
	and $7
	inc a ; 1-8 turns disabled
.disableTurnsSet ; new label, to handle luck: statuses affliction
	inc c ; move 1-4 will be disabled
	swap c
	add c ; map disabled move to high nibble of wEnemyDisabledMove / wPlayerDisabledMove
	ld [de], a
	callfar PlayCurrentMoveAnimation2 ; edited, made into a callfar
	ld hl, wPlayerDisabledMoveNumber
	ldh a, [hWhoseTurn]
	and a
	jr nz, .printDisableText
	inc hl ; wEnemyDisabledMoveNumber
.printDisableText
	ld a, [wd11e] ; move number
	ld [hl], a
	callfar GetMoveName ; edited, made into a callfar
	ld hl, MoveWasDisabledText
	jp PrintText
.moveMissedPopHL
	pop hl
.moveMissed
	jpfar PrintButItFailedText_ ; edited, made into a jpfar

MoveWasDisabledText:
	text_far _MoveWasDisabledText
	text_end
