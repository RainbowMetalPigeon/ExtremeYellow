FlinchSideEffect_:
	callfar CheckTargetSubstitute	; edited
	ret nz
	ld hl, wEnemyBattleStatus1
	ld de, wPlayerMoveEffect
	ldh a, [hWhoseTurn]
	and a
	jr z, .flinchSideEffect
	ld hl, wPlayerBattleStatus1
	ld de, wEnemyMoveEffect
.flinchSideEffect
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
;	call z, ClearHyperBeam		; edited
	jr nz, .continueVanilla		; edited
	push hl						; new, to make the migration work
	callfar ClearHyperBeam		; edited
	pop hl						; new, to make the migration work
.continueVanilla				; edited
; new, to handle luck: secondary effects
	ld a, [hWhoseTurn]
	and a
	jr z, .playersTurn
; enemy's turn
	ld a, [wLuckSecondaryEffects] ; 0=NORMAL, 1=PLAYER MIN, 2=ENEMY MAX, 3=BOTH
	and a
	jr z, .vanillaLuck
	cp 1
	jr z, .vanillaLuck
; enemy's turn, and their luck is max
	jr .flinchSuccess
.playersTurn
	ld a, [wLuckSecondaryEffects]
	and a
	jr z, .vanillaLuck
	cp 2
	jr z, .vanillaLuck
; player's turn and their luck is minimum
	ret
.vanillaLuck
; back to vanilla
	ld a, [de]
	cp FLINCH_SIDE_EFFECT1
	ld b, 10 percent + 1 ; chance of flinch (FLINCH_SIDE_EFFECT1)
	jr z, .gotEffectChance
	cp FLINCH_SIDE_EFFECT2											; new
	ld b, 20 percent + 1 ; chance of flinch (FLINCH_SIDE_EFFECT2)	; new
	jr z, .gotEffectChance											; new
	cp FLINCH_SIDE_EFFECT3											; new
	ld b, 30 percent + 1 ; chance of flinch (FLINCH_SIDE_EFFECT3)	; new
	jr z, .gotEffectChance											; new
	ld b, 50 percent + 1 ; chance of flinch otherwise (FLINCH_SIDE_EFFECT5)
.gotEffectChance
	call BattleRandom2	; edited
	cp b
	ret nc
.flinchSuccess ; new label, to handle luck: secondary effects
	set FLINCHED, [hl] ; set mon's status to flinching
	callfar ClearHyperBeam	; edited
	ret
