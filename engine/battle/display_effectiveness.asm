DisplayEffectiveness: ; edited to write more detailed info about double resistances/weaknesses
	ld a, [wDamageMultipliers]
	and $7F
	cp 10 ; is was $0A, aka 10 just written even less readable, and it's meant to be the "normal effectiveness"
	ret z
	cp 40
	jr z, .doubleSuperEffective
	cp 20
	jr z, .superEffective
	cp 5
	jr z, .notVeryEffective
	ld hl, ReallyNotVeryEffectiveText
	jr .done
.doubleSuperEffective
	ld hl, DoubleSuperEffectiveText
	jr .done
.superEffective
	ld hl, SuperEffectiveText
	jr .done
.notVeryEffective
	ld hl, NotVeryEffectiveText
.done
	jp PrintText

ReallyNotVeryEffectiveText: ; new
	text_far _ReallyNotVeryEffectiveText
	text_end

SuperEffectiveText:
	text_far _SuperEffectiveText
	text_end

NotVeryEffectiveText:
	text_far _NotVeryEffectiveText
	text_end

DoubleSuperEffectiveText: ; new
	text_far _DoubleSuperEffectiveText
	text_end
