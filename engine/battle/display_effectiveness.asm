DisplayEffectiveness:
	ld a, [wDamageMultipliers]
	and $7F
	cp $0A ; it's still 10, just written even less readable, and it's meant to be the "normal effectiveness"
	ret z
	ld hl, SuperEffectiveText
	jr nc, .done
	ld hl, NotVeryEffectiveText
.done
	jp PrintText

SuperEffectiveText:
	text_far _SuperEffectiveText
	text_end

NotVeryEffectiveText:
	text_far _NotVeryEffectiveText
	text_end
