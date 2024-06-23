; multiplies damage by a random percentage from ~85% to 100%
RandomizeDamage:
	ResetEvent EVENT_PLAYER_MINIMUM_ROLL ; new, to handle luck: roll
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
; new, to handle luck: roll
	ld a, [hWhoseTurn]
	and a
	jr z, .playersTurn
; enemy's turn
	ld a, [wLuckRoll] ; 0=NORMAL, 1=PLAYER MIN, 2=ENEMY MAX, 3=BOTH
	and a
	jr z, .vanillaLuck
	cp 1
	jr z, .vanillaLuck
; if we are here, it's enemy's turn and they have max luck: we just return, no roll
	ret
.playersTurn
	ld a, [wLuckRoll] ; 0=NORMAL, 1=PLAYER MIN, 2=ENEMY MAX, 3=BOTH
	and a
	jr z, .vanillaLuck
	cp 2
	jr z, .vanillaLuck
; if we are here, it's player's turn and they have min luck
	SetEvent EVENT_PLAYER_MINIMUM_ROLL
.vanillaLuck
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
; new, to handle luck: roll
	CheckEvent EVENT_PLAYER_MINIMUM_ROLL
	jr z, .vanillaRoll
	ld a, 217 ; load minimum roll in the multiplier
	ldh [hMultiplier], a
.vanillaRoll
; back to vanilla
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
