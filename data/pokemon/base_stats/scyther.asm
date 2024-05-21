	db DEX_SCYTHER ; pokedex id

	db  70, 110,  80, 105,  55
	;   hp  atk  def  spd  spc

	db BUG, FLYING ; type
	db 45 ; catch rate
	db 187 ; base exp

	INCBIN "gfx/pokemon/front/scyther.pic", 0, 1 ; sprite dimensions
	dw ScytherPicFront, ScytherPicBack

	db QUICK_ATTACK, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm SWORDS_DANCE, COUNTER,      TOXIC,        DOUBLE_EDGE,  HYPER_BEAM,   \
	     MIMIC,        DOUBLE_TEAM,  BIDE,         CLOSE_COMBAT, REST,         \
	     X_SCISSOR,    SUBSTITUTE,   CUT,          CURSE         
	; end

	db BANK(ScytherPicFront)
	assert BANK(ScytherPicFront) == BANK(ScytherPicBack)
