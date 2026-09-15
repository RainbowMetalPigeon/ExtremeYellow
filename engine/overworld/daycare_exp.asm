IncrementDayCareMonExp: ; edited, it's exponential with number of badges
;	ld a, [wDayCareInUse]
;	and a
;	ret z
;	ld hl, wDayCareMonExp + 2
;	inc [hl]
;	ret nz
;
;	dec hl
;	inc [hl]
;	ret nz
;	
;	dec hl
;	inc [hl]
;	ld a, [hl]
;	cp $50
;	ret c
;
;	ld a, $50
;	ld [hl], a
;	ret

	ld a, [wDayCareInUse]
	and a
	ret z
	callfar CountHowManyBadges ; returns in d the number of badges we own
	ld b, 0
	ld c, d
	ld hl, LookUpTableForDaycareStepExp
	add hl, bc
	ld a, [hl]
	ld b, a ; b holds the "how much we increase the exp"

	ld hl, wDayCareMonExp + 2
	ld a, [hl]
	add b ; a = a + b, c flag if we overflow from bit 7
	ld [hl], a
	ret nc

	dec hl
	inc [hl]
	ret nz
	
	dec hl
	inc [hl]
	ld a, [hl]
	cp $50 ; unnecessarily big?
	ret c

	ld a, $50 ; unnecessarily big?
	ld [hl], a
	ret


LookUpTableForDaycareStepExp:
	db 1	; 0 badges
	db 2	; 1 badges
	db 4	; 2 badges
	db 8	; 3 badges
	db 16	; 4 badges
	db 32	; 5 badges
	db 64	; 6 badges
	db 128	; 7 badges
	db 255	; 8 badges
