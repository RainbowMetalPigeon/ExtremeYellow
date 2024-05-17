; base power: min(150 , 25xTargetSpeed/UserSpeed+1)
CalculateGyroBallBasePower::
	ldh a, [hWhoseTurn]
	and a
	ld de, wBattleMonSpeed ; player speed value
	ld hl, wEnemyMonSpeed ; enemy speed value
	jr z, .player
	ld de, wEnemyMonSpeed ; enemy speed value
	ld hl, wBattleMonSpeed ; player speed value
.player
	; de points to the user speed
	; hl points to the target speed

; calculate UserSpeed/4 first, and store it in a temporary 1 byte for later
	push hl ; preserve hl for later
	; put de in hl for the Divide
	ld h, d
	ld l, e
	ld a, 4 ; we divide by 4
	ldh [hDivisor], a
	ld a, [hli]
	ldh [hDividend], a
	ld a, [hl]
	ldh [hDividend + 1], a
	ld b, 4 ; 2? 4? TBV
	call Divide
	ldh a, [hQuotient + 3] ; only this one because it's just 1 byte, right?
	ld [wUnusedD5A3], a ; store temporarily the divided speed to use it later as a 1-byte divider
	                    ; let's use any one gabbo wram byte
	pop hl ; restore hl

; now we multiply the target speed by 25
	ld a, [hli]
	ldh [hMultiplicand + 1], a
	ld a, [hld]
	ldh [hMultiplicand + 2], a
	xor a
	ldh [hMultiplicand], a

	ld a, 25
	ldh [hMultiplier], a
	call Multiply

; divide this by 4 so that we can fit the dividend UserSpeed into one byte by dividing it too by 4
	ld a, 4
	ldh [hDivisor], a

	ld b, 4 ; number of bytes of hDividend, which maxes out at 999x25<65535, so it's just 2 bytes
	        ; but then why do I see 4 being loaded basically everywhere? TBV

	call Divide

; now we gotta divide this result by the UserSpeed/4, temporarily stored in wUnusedD5A3
	ld a, [wUnusedD5A3]
	and a
	jr nz, .continue1
	ld a, 1 ; divisor can't be 0
.continue1
	ldh [hDivisor], a

	ld b, 4 ; 2? 4? TBV

	call Divide ; max result should be 6243, so we need to check 2 bytes of result

; if the more significant byte is not 0, it means the result is surely above 255, so we get 150 as base power
	ldh a, [hQuotient + 2]
	and a
	jr nz, .load150AsBasePower

; the result is between 0 and 255
	ldh a, [hQuotient + 3]
	inc a ; +1
	jr z, .load150AsBasePower ; if it was 255 and so we overflew
	cp 150
	jr nc, .load150AsBasePower ; nc if a-150>=0, in which case we fix base power at 150
	ld d, a
	ret

.load150AsBasePower
	ld d, 150
	ret
