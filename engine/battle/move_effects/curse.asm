CurseEffect_::
	ld hl, wEnemyBattleStatus2
	ld de, wBattleMonType1
	ldh a, [hWhoseTurn]
	and a
	jr z, .curseEffect
	ld hl, wPlayerBattleStatus2
	ld de, wEnemyMonType1
.curseEffect
; effect depends on the type of the user
	ld a, [de]
	cp GHOST
	jr z, .ghostTyping
	inc de
	ld a, [de]
	cp GHOST
	jr z, .ghostTyping
; not ghost: de/buff effect ----------------------------------------------------
	callfar PlayCurrentMoveAnimation ; testing / unnecessary because we handle CURSE two animations in core, like the charging of multi-turn moves
	jpfar AttackUpDefenseUpSpeedDownEffect ; jp? will do?
	ret ; useless?
.ghostTyping ; -----------------------------------------------------------------
; miss if the target is already cursed
	bit BEING_CURSED, [hl]
	jr nz, .moveMissed
; apply the curse
	set BEING_CURSED, [hl]
	callfar PlayCurrentMoveAnimation ; testing / unnecessary because we handle CURSE two animations in core, like the charging of multi-turn moves
; lose half life, it goes through even if we faint
	ld hl, wBattleMonHP
	ldh a, [hWhoseTurn]
	and a
	jr z, .playersTurn
	ld hl, wEnemyMonHP
.playersTurn
	push hl
	ld bc, $e      ; skip to max HP ; dear Arceus if this is ugly lol
	add hl, bc
	ld a, [hli]    ; load max HP
	ld [wHPBarMaxHP+1], a
	ld b, a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	ld c, a
	srl b
	rr c         ; bc = max HP/2
	pop hl
	inc hl
	ld a, [hl]    ; subtract total damage from current HP
	ld [wHPBarOldHP], a
	sub c
	ld [hld], a
	ld [wHPBarNewHP], a
	ld a, [hl]
	ld [wHPBarOldHP+1], a
	sbc b
	ld [hl], a
	ld [wHPBarNewHP+1], a
	jr nc, .noOverkill
	xor a         ; overkill: zero HP
	ld [hli], a
	ld [hl], a
	ld [wHPBarNewHP], a
	ld [wHPBarNewHP+1], a
.noOverkill
	callfar UpdateCurMonHPBar ; made into a callfar, testing
	ld hl, WasCursedText
	jp PrintText
.moveMissed
	ld c, 50
	call DelayFrames
	ld hl, AlreadyCursedText
	jp PrintText

WasCursedText:
	text_far _WasCursedText
	text_end

AlreadyCursedText:
	text_far _AlreadyCursedText
	text_end
