	db DEX_LICKITUNG ; pokedex id

	db  90,  55,  75,  30,  60
	;   hp  atk  def  spd  spc

	db NORMAL, NORMAL ; type
	db 45 ; catch rate
	db 127 ; base exp

	INCBIN "gfx/pokemon/front/lickitung.pic", 0, 1 ; sprite dimensions
	dw LickitungPicFront, LickitungPicBack

	db WRAP, SUPERSONIC, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   SWORDS_DANCE, COUNTER,      TOXIC,        BODY_SLAM,    \
	     DOUBLE_EDGE,  BUBBLEBEAM,   ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   \
	     SEISMIC_TOSS, THUNDERBOLT,  THUNDER,      EARTHQUAKE,   FISSURE,      \
	     DIG,          MIMIC,        DOUBLE_TEAM,  BIDE,         HYDRO_PUMP,   \
	     FIRE_BLAST,   REST,         ROCK_SLIDE,   SHADOW_BALL,  SUBSTITUTE,   \
	     BODY_PRESS,   CUT,          SURF,         STRENGTH,     CURSE         
	; end

	db BANK(LickitungPicFront)
	assert BANK(LickitungPicFront) == BANK(LickitungPicBack)
