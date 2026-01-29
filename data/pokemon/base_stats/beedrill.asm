	db DEX_BEEDRILL ; pokedex id

	db  65,  90,  40,  75,  45
	;   hp  atk  def  spd  spc

	db BUG, POISON ; type
	db 45 ; catch rate
	db 159 ; base exp

	INCBIN "gfx/pokemon/front/beedrill.pic", 0, 1 ; sprite dimensions
	dw BeedrillPicFront, BeedrillPicBack

	db FURY_ATTACK, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm SWORDS_DANCE, TOXIC,        DOUBLE_EDGE,  HYPER_BEAM,   GIGA_DRAIN,   \
	     MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         REST,         \
	     X_SCISSOR,    SUBSTITUTE,   CUT,          FLASH,        CURSE,        \
	     ROCK_SMASH    
	; end

	db BANK(BeedrillPicFront)
	assert BANK(BeedrillPicFront) == BANK(BeedrillPicBack)
