SwitchAndTeleportEffect_:
	ldh a, [hWhoseTurn]
	and a
	jr nz, .handleEnemy
	ld a, [wIsInBattle]
	dec a
	jr nz, .notWildBattle1
	ld a, [wCurEnemyLVL]
	ld b, a
	ld a, [wBattleMonLevel]
	cp b ; is the player's level greater than the enemy's level?
	jr nc, .playerMoveWasSuccessful ; if so, teleport will always succeed
	add b
	ld c, a
	inc c ; c = playerLevel + enemyLevel + 1
.rejectionSampleLoop1
	call BattleRandom2	; edited
	cp c ; get a random number between 0 and c
	jr nc, .rejectionSampleLoop1
	srl b
	srl b  ; b = enemyLevel / 4
	cp b ; is rand[0, playerLevel + enemyLevel] >= (enemyLevel / 4)?
	jr nc, .playerMoveWasSuccessful ; if so, allow teleporting
	ld c, 50
	call DelayFrames
;	ld a, [wPlayerMoveNum]			; edited, there's only teleport here now, no more roar or whirlwind
;	cp TELEPORT						; edited, there's only teleport here now, no more roar or whirlwind
;	jp nz, PrintDidntAffectText		; edited, there's only teleport here now, no more roar or whirlwind
	jp PrintButItFailedText2_
.playerMoveWasSuccessful
	callfar ReadPlayerMonCurHPAndStatus	; edited
	xor a
	ld [wAnimationType], a
	inc a
	ld [wEscapedFromBattle], a
	ld a, [wPlayerMoveNum]
	jr .playAnimAndPrintText
.notWildBattle1
	ld c, 50
	call DelayFrames
;	ld hl, IsUnaffectedText
;	ld a, [wPlayerMoveNum]			; edited, there's only teleport here now, no more roar or whirlwind
;	cp TELEPORT						; edited, there's only teleport here now, no more roar or whirlwind
;	jp nz, PrintText				; edited, there's only teleport here now, no more roar or whirlwind
	jp PrintButItFailedText2_
.handleEnemy
	ld a, [wIsInBattle]
	dec a
	jr nz, .notWildBattle2
	ld a, [wBattleMonLevel]
	ld b, a
	ld a, [wCurEnemyLVL]
	cp b
	jr nc, .enemyMoveWasSuccessful
	add b
	ld c, a
	inc c
.rejectionSampleLoop2
	call BattleRandom2	; edited
	cp c
	jr nc, .rejectionSampleLoop2
	srl b
	srl b
	cp b
	jr nc, .enemyMoveWasSuccessful
	ld c, 50
	call DelayFrames
;	ld a, [wEnemyMoveNum]			; edited, there's only teleport here now, no more roar or whirlwind
;	cp TELEPORT						; edited, there's only teleport here now, no more roar or whirlwind
;	jp nz, PrintDidntAffectText		; edited, there's only teleport here now, no more roar or whirlwind
	jp PrintButItFailedText2_
.enemyMoveWasSuccessful
	callfar ReadPlayerMonCurHPAndStatus	; edited
	xor a
	ld [wAnimationType], a
	inc a
	ld [wEscapedFromBattle], a
	ld a, [wEnemyMoveNum]
	jr .playAnimAndPrintText
.notWildBattle2
	ld c, 50
	call DelayFrames
;	ld hl, IsUnaffectedText			; edited, there's only teleport here now, no more roar or whirlwind
;	ld a, [wEnemyMoveNum]			; edited, there's only teleport here now, no more roar or whirlwind
;	cp TELEPORT						; edited, there's only teleport here now, no more roar or whirlwind
;	jp nz, PrintText				; edited, there's only teleport here now, no more roar or whirlwind
;	jp ConditionalPrintButItFailed	; edited, commented, seems very unnecessary, substituted with the line below, much safer?
	jp PrintButItFailedText2_
.playAnimAndPrintText
	push af
;	call PlayBattleAnimation			; edited
	ld [wAnimationID], a				; edited
	callfar PlayBattleAnimationGotID	; edited
	ld c, 20
	call DelayFrames
	pop af
	ld hl, RanFromBattleText
;	cp TELEPORT
;	jr z, .printText
;	ld hl, RanAwayScaredText
;	cp ROAR ; modified, removed ROAR
;	jr z, .printText
;	ld hl, WasBlownAwayText
;.printText
	jp PrintText

RanFromBattleText:
	text_far _RanFromBattleText
	text_end

;RanAwayScaredText:
;	text_far _RanAwayScaredText
;	text_end

;WasBlownAwayText:
;	text_far _WasBlownAwayText
;	text_end

PrintButItFailedText2_:
	ld hl, ButItFailedText2
	jp PrintText

ButItFailedText2:
	text_far _ButItFailedText
	text_end
