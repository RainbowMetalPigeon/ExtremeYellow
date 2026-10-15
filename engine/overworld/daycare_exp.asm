IncrementDayCareMonExp: ; edited, it's quadratic with number of badges
	ld a, [wDayCareInUse]
	and a
	ret z
	ld hl, wDayCareMonExp + 2
; edited
	CheckEvent EVENT_UNLOCKED_DAYCARE_MORE_EXP
	jr z, .normalDayCare
	ld a, [hl]
	add 4
	ld [hl], a
	jr c, .overflow
	jr .checkStatExp_HP
.normalDayCare
; BTV
	inc [hl]
	jr nz, .checkStatExp_HP

.overflow ; new label

	dec hl
	inc [hl]
	jr nz, .checkStatExp_HP

	dec hl
	inc [hl]
	ld a, [hl]
	cp $50
	jr c, .checkStatExp_HP

	ld a, $50
	ld [hl], a

.checkStatExp_HP
	CheckEvent EVENT_UNLOCKED_DAYCARE_STAT_EXP_HP
	jr z, .checkStatExp_Attack
	ld hl, wDayCareMonHPExp
	call DayCareIncreaseStatExp

.checkStatExp_Attack
	CheckEvent EVENT_UNLOCKED_DAYCARE_STAT_EXP_ATK
	jr z, .checkStatExp_Defense
	ld hl, wDayCareMonAttackExp
	call DayCareIncreaseStatExp

.checkStatExp_Defense
	CheckEvent EVENT_UNLOCKED_DAYCARE_STAT_EXP_DEF
	jr z, .checkStatExp_Speed
	ld hl, wDayCareMonDefenseExp
	call DayCareIncreaseStatExp

.checkStatExp_Speed
	CheckEvent EVENT_UNLOCKED_DAYCARE_STAT_EXP_SPD
	jr z, .checkStatExp_Special
	ld hl, wDayCareMonSpeedExp
	call DayCareIncreaseStatExp

.checkStatExp_Special
	CheckEvent EVENT_UNLOCKED_DAYCARE_STAT_EXP_SPC
	ret z
	ld hl, wDayCareMonSpecialExp
	jp DayCareIncreaseStatExp

; new ----------------------------

; expects hl = wDayCareMon[X]Exp, with [X] = HP, Attack, Defense, Speed, or Special
DayCareIncreaseStatExp:
	inc hl ; little endian?
	ld a, [hl]
	add 10 ; we increase the stat by 10 per step
	ld [hl], a
	ret nc

; there's an overflow: we must increase also the big endian by 1
	dec hl
	inc [hl]
	ret nz

; there's a big endian overflow: just set both to $FF
	ld a, $FF
	ld [hli], a
	ld [hl], a
	ret
