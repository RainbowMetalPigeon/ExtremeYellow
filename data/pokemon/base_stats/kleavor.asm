	db DEX_KLEAVOR ; pokedex id

	db  70, 135,  95,  85,  70
	;   hp  atk  def  spd  spc

	db BUG, ROCK ; type
	db 45 ; catch rate
	db 200 ; base exp

	INCBIN "gfx/pokemon/front/kleavor.pic", 0, 1 ; sprite dimensions
	dw KleavorPicFront, KleavorPicBack

	db QUICK_ATTACK, ROCK_THROW, LEER, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm SWORDS_DANCE, COUNTER,      TOXIC,        DOUBLE_EDGE,  HYPER_BEAM,   \
	     STONE_EDGE,   MIMIC,        DOUBLE_TEAM,  BIDE,         CLOSE_COMBAT, \
	     REST,         X_SCISSOR,    ROCK_SLIDE,   SUBSTITUTE,   CUT,          \
	     CURSE         
	; end

	db BANK(KleavorPicFront)
	assert BANK(KleavorPicFront) == BANK(KleavorPicBack)
