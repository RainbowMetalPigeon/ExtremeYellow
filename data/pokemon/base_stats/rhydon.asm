	db DEX_RHYDON ; pokedex id

	db 105, 130, 120,  40,  45
	;   hp  atk  def  spd  spc

	db GROUND, ROCK ; type
	db 60 ; catch rate
	db 204 ; base exp

	INCBIN "gfx/pokemon/front/rhydon.pic", 0, 1 ; sprite dimensions
	dw RhydonPicFront, RhydonPicBack

	db HORN_ATTACK, STOMP, LEER, FURY_ATTACK ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   MEGAHORN,     SWORDS_DANCE, COUNTER,      TOXIC,        \
	     BODY_SLAM,    DOUBLE_EDGE,  BUBBLEBEAM,   ICE_BEAM,     BLIZZARD,     \
	     HYPER_BEAM,   SEISMIC_TOSS, STONE_EDGE,   THUNDERBOLT,  THUNDER,      \
	     EARTHQUAKE,   FISSURE,      DIG,          MIMIC,        DOUBLE_TEAM,  \
	     BIDE,         HYDRO_PUMP,   FIRE_BLAST,   OUTRAGE,      REST,         \
	     ROCK_SLIDE,   SUBSTITUTE,   BODY_PRESS,   CUT,          SURF,         \
	     STRENGTH,     CURSE         
	; end

	db BANK(RhydonPicFront)
	assert BANK(RhydonPicFront) == BANK(RhydonPicBack)
