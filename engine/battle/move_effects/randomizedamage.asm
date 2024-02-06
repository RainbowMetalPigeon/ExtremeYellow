; multiplies damage by a random percentage from ~85% to 100%
RandomizeDamage:
; new, maximize the damage roll if Starter Pikachu is happy enough (>160)
	ldh a, [hWhoseTurn]
	and a
	jr nz, .notStarterPikachu ; we don't do this if it's not our turn
	callfar IsThisPartymonStarterPikachu_Party
	jr nc, .notStarterPikachu
	ld a, [wPikachuHappiness]
	cp 161
	ret nc
.notStarterPikachu
; back to vanilla
	ld hl, wDamage
	ld a, [hli]
	and a
	jr nz, .DamageGreaterThanOne
	ld a, [hl]
	cp 2
	ret c ; return if damage is equal to 0 or 1
.DamageGreaterThanOne
	xor a
	ldh [hMultiplicand], a
	dec hl
	ld a, [hli]
	ldh [hMultiplicand + 1], a
	ld a, [hl]
	ldh [hMultiplicand + 2], a
; loop until a random number greater than or equal to 217 is generated
.loop
	call BattleRandom2 ; edited into the copy
	rrca
	cp 217
	jr c, .loop
	ldh [hMultiplier], a
	call Multiply ; multiply damage by the random number, which is in the range [217, 255]
	ld a, 255
	ldh [hDivisor], a
	ld b, $4
	call Divide ; divide the result by 255
; store the modified damage
	ldh a, [hQuotient + 2]
	ld hl, wDamage
	ld [hli], a
	ldh a, [hQuotient + 3]
	ld [hl], a
	ret
