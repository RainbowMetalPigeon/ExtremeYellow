	db DEX_LICKILICKY ; pokedex id

	db 110,  85,  95,  50,  80
	;   hp  atk  def  spd  spc

	db NORMAL, NORMAL ; type
	db 35 ; catch rate
	db 193 ; base exp

	INCBIN "gfx/pokemon/front/lickilicky.pic", 0, 1 ; sprite dimensions
	dw LickilickyPicFront, LickilickyPicBack

	db WRAP, SUPERSONIC, LICK, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   SWORDS_DANCE, COUNTER,      TOXIC,        BODY_SLAM,    \
	     DOUBLE_EDGE,  BUBBLEBEAM,   ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   \
	     SEISMIC_TOSS, THUNDERBOLT,  THUNDER,      EARTHQUAKE,   FISSURE,      \
	     DIG,          MIMIC,        DOUBLE_TEAM,  BIDE,         HYDRO_PUMP,   \
	     SELFDESTRUCT, FIRE_BLAST,   REST,         EXPLOSION,    ROCK_SLIDE,   \
	     SHADOW_BALL,  SUBSTITUTE,   CUT,          SURF,         STRENGTH      
	; end

	db BANK(LickilickyPicFront)
	assert BANK(LickilickyPicFront) == BANK(LickilickyPicBack)
