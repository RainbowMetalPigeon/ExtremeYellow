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

; calculate UserSpeed/5 first, and store it in a temporary 1 byte for later
	push hl ; preserve hl for later
	; put de in hl for the Divide
	ld h, d
	ld l, e
	ld a, 5 ; we divide by 5
	ldh [hDivisor], a
	ld a, [hli]
	ldh [hDividend], a
	ld a, [hl]
	ldh [hDividend + 1], a
	ld b, 2 ; 2? 4? TBV
	call Divide
	ldh a, [hQuotient + 3] ; only this one because it's just 1 byte, right?
	ld [wUnusedD5A3], a ; store temporarily the divided speed to use it later as a 1-byte divider
	                    ; let's use any one gabbo wram byte
	pop hl ; restore hl

; now we multiply the target speed by 25/5=5 (/5 because we already divided the user speed by 5)
	ld a, [hli]
	ldh [hMultiplicand + 1], a
	ld a, [hld]
	ldh [hMultiplicand + 2], a
	xor a
	ldh [hMultiplicand], a

	ld a, 5
	ldh [hMultiplier], a
	call Multiply

; now we gotta divide this result by the UserSpeed/5, temporarily stored in wUnusedD5A3
	ld a, [wUnusedD5A3]
	and a
	jr nz, .continue1
	ld a, 1 ; divisor can't be 0
.continue1
	ldh [hDivisor], a

	ld b, 2 ; 2? 4? TBV

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

; ===========================================================================

; GCS original
;FlailReversalPower:
;	; hp bar pixels, power
;	db HP_BAR_LENGTH_PX / 48,   200
;	db HP_BAR_LENGTH_PX / 12,   150
;	db HP_BAR_LENGTH_PX / 5,    100
;	db HP_BAR_LENGTH_PX / 3,     80
;	db HP_BAR_LENGTH_PX * 2 / 3, 40
;	db HP_BAR_LENGTH_PX,         20

FlailHPFractionsAndPowers: ; Extreme Yellow custom round fractions
	db 20, 200
	db 10, 150
	db  5, 100
	db  3,  80
	db  2,  40
	db  1,  20 ; TBE?
	db -1      ; TBE?

CalculateFlailBasePower::
	ld hl, FlailHPFractionsAndPowers
.loop
	ld a, [hli] ; a contains the fraction
	cp -1       ; should be useless but you never know
	jr z, .conclude
	push hl     ; hl points to the BP
	call CheckIfHPIsBelowFraction
	pop hl
	; c flag is set if we are below the threshold
	jr nc, .iterate ; not the right fraction, too many HP left
; we are below the currently checked threshold
	ld a, [hl]
	ld d, a
	ret
.iterate
	inc hl
	jr .loop
.conclude
	ld d, 20
	ret

CheckIfHPIsBelowFraction::
; return carry if player or enemy trainer's current HP is below 1 / a of the maximum
; used for FLAIL
	ldh [hDivisor], a
; turn-deciding code
	ldh a, [hWhoseTurn]
	and a
	ld hl, wBattleMonMaxHP
	jr z, .player1
	ld hl, wEnemyMonMaxHP
.player1
	ld a, [hli]
	ldh [hDividend], a
	ld a, [hl]
	ldh [hDividend + 1], a
	ld b, 2
	call Divide
	ldh a, [hQuotient + 3]
	ld c, a
	ldh a, [hQuotient + 2]
	ld b, a
; turn-deciding code
	ldh a, [hWhoseTurn]
	and a
	ld hl, wBattleMonHP + 1
	jr z, .player2
	ld hl, wEnemyMonHP + 1
.player2
	ld a, [hld]
	ld e, a
	ld a, [hl]
	ld d, a
	ld a, d
	sub b
	ret nz
	ld a, e
	sub c
	ret
