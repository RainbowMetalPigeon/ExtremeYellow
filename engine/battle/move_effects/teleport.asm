SwitchAndTeleportEffect_:
	ldh a, [hWhoseTurn]
	and a
	jr nz, .handleEnemy

; handlePlayer
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
	ld c, 30
	call DelayFrames
	ld a, [wPlayerMoveNum]
	cp TELEPORT
	jp nz, PrintDidntAffectText
	jp PrintButItFailedText2_
.playerMoveWasSuccessful
	callfar ReadPlayerMonCurHPAndStatus	; edited
	xor a
	ld [wAnimationType], a
	inc a
	ld [wEscapedFromBattle], a
	ld a, [wPlayerMoveNum]
	jp PlayAnimAndPrintText
.notWildBattle1
	ld c, 30
	call DelayFrames
; new
	ld a, [wPlayerMoveNum]
	cp TELEPORT
	jp z, PrintButItFailedText2_
; not teleport: roar/whirlwind
	call CountUnfaintedPokemonInParty_Enemy
	cp 2
	jp c, PrintButItFailedText2_
	ld a, [wPlayerMoveNum]
	call PlayAnimAndPrintText
	jpfar AISwitchIfEnoughMons
; BTV

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
	ld c, 30
	call DelayFrames
	ld a, [wEnemyMoveNum]
	cp TELEPORT
	jp nz, PrintDidntAffectText
	jp PrintButItFailedText2_
.enemyMoveWasSuccessful
	callfar ReadPlayerMonCurHPAndStatus	; edited
	xor a
	ld [wAnimationType], a
	inc a
	ld [wEscapedFromBattle], a
	ld a, [wEnemyMoveNum]
	jr PlayAnimAndPrintText
.notWildBattle2
	ld c, 30
	call DelayFrames
; new
	ld a, [wEnemyMoveNum]
	cp TELEPORT
	jp z, PrintButItFailedText2_
; not teleport: roar/whirlwind
	call CountUnfaintedPokemonInParty_Player
	cp 2
	jr c, PrintButItFailedText2_
	ld a, [wEnemyMoveNum]
	call PlayAnimAndPrintText
	jp ForcePlayerSwitch
; BTV

PlayAnimAndPrintText: ; standalone function
	push af
;	call PlayBattleAnimation			; edited
	ld [wAnimationID], a				; edited
	callfar PlayBattleAnimationGotID	; edited
	ld c, 20
	call DelayFrames
	pop af
	ld hl, RanFromBattleText
	cp TELEPORT
	jr z, .printText
	ld hl, RanAwayScaredText
	cp ROAR
	jr z, .printText
	ld hl, WasBlownAwayText
.printText
	jp PrintText

RanFromBattleText:
	text_far _RanFromBattleText
	text_end

RanAwayScaredText:
	text_far _RanAwayScaredText
	text_end

WasBlownAwayText:
	text_far _WasBlownAwayText
	text_end

PrintButItFailedText2_:
	ld hl, ButItFailedText2
	jp PrintText

ButItFailedText2:
	text_far _ButItFailedText
	text_end

; new ================================

CountUnfaintedPokemonInParty_Player:
	ld a, [wPartyCount]
	ld c, a
	ld hl, wPartyMon1HP
	ld d, 0 ; keep count of unfainted monsters
.loop ; count how many monsters haven't fainted yet
	ld a, [hli]
	ld b, a
	ld a, [hld]
	or b
	jr z, .fainted ; has monster fainted?
	inc d
.fainted
	push bc
	ld bc, wPartyMon2 - wPartyMon1
	add hl, bc
	pop bc
	dec c
	jr nz, .loop
	ld a, d ; how many available monsters are there?
	ret

CountUnfaintedPokemonInParty_Enemy:
	ld a, [wEnemyPartyCount]
	ld c, a
	ld hl, wEnemyMon1HP
	ld d, 0 ; keep count of unfainted monsters
.loop ; count how many monsters haven't fainted yet
	ld a, [hli]
	ld b, a
	ld a, [hld]
	or b
	jr z, .fainted ; has monster fainted?
	inc d
.fainted
	push bc
	ld bc, wEnemyMon2 - wEnemyMon1
	add hl, bc
	pop bc
	dec c
	jr nz, .loop
	ld a, d ; how many available monsters are there?
	ret

ForcePlayerSwitch:
	ld a, [wPartyCount]
	ld d, a
	ld hl, wPartyMon1HP
	ld e, $FF ; index counter, will be increased next step
.loop2
	inc e
	ld a, [hli]
	ld b, a
	ld a, [hld]
	or b
	jr z, .fainted2 ; has monster fainted?
; not fainted: check if it's the same one that's already out
	ld a, [wPlayerMonNumber]
	cp e
	jr nz, .actuallySwitch
.fainted2
	ld bc, wPartyMon2 - wPartyMon1
	add hl, bc
	dec d
	jr nz, .loop2
.actuallySwitch
	ld a, e
	ld [wWhichPokemon], a
	ld [wPlayerMonNumber], a
	inc a
	ld hl, wPartySpecies - 1
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl] ; species
	ld [wcf91], a
	ld [wBattleMonSpecies2], a
	ld a, [wBattleMonSpecies]
	ld [wd0b5], a
	call GetMonHeader
	jpfar SwitchPlayerMon
