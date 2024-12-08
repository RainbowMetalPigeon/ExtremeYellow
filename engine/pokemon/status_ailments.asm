PrintStatusAilment:: ; edited: b and c contain wEnemyBattleStatus3/wPlayerBattleStatus3
	ld a, [de]
	bit PSN, a
	jr nz, .psn
	bit BRN, a
	jr nz, .brn
	bit FRZ, a
	jr nz, .frz
	bit PAR, a
	jr nz, .par
	and SLP_MASK
	ret z
	ld a, "S"
	ld [hli], a
	ld a, "L"
	ld [hli], a
	ld [hl], "P"
	ret
.psn ; edited, to print TOX if Toxic poison rather than normal one
	push hl
	ld a, b
	ld h, a
	ld a, c
	ld l, a ; now hl is wEnemyBattleStatus3/wPlayerBattleStatus3
	bit BADLY_POISONED, [hl]
	pop hl
	jr z, .noToxic
	ld a, "T"
	ld [hli], a
	ld a, "O"
	ld [hli], a
	ld [hl], "X"
	ret
.noToxic
	ld a, "P"
	ld [hli], a
	ld a, "S"
	ld [hli], a
	ld [hl], "N"
	ret
.brn
	ld a, "B"
	ld [hli], a
	ld a, "R"
	ld [hli], a
	ld [hl], "N"
	ret
.frz
	ld a, "F"
	ld [hli], a
	ld a, "R"
	ld [hli], a
	ld [hl], "Z"
	ret
.par
	ld a, "P"
	ld [hli], a
	ld a, "A"
	ld [hli], a
	ld [hl], "R"
	ret




;	ld hl, wEnemyBattleStatus3
;	bit BADLY_POISONED, [hl]
