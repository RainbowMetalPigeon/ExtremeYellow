	db DEX_RATTATA ; pokedex id

	db  30,  56,  35,  72,  25
	;   hp  atk  def  spd  spc

	db NORMAL, NORMAL ; type
	db 255 ; catch rate
	db 57 ; base exp

	INCBIN "gfx/pokemon/front/rattata.pic", 0, 1 ; sprite dimensions
	dw RattataPicFront, RattataPicBack

	db TACKLE, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm SWORDS_DANCE, COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     BUBBLEBEAM,   ICE_BEAM,     BLIZZARD,     THUNDERBOLT,  THUNDER,      \
	     DIG,          MIMIC,        DOUBLE_TEAM,  BIDE,         REST,         \
	     THUNDER_WAVE, SHADOW_BALL,  SUBSTITUTE,   CUT,          STRENGTH,     \
	     CURSE,        ROCK_SMASH    
	; end

	db BANK(RattataPicFront)
	assert BANK(RattataPicFront) == BANK(RattataPicBack)
