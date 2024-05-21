	db DEX_KANGASKHAN ; pokedex id

	db 105,  95,  80,  90,  40
	;   hp  atk  def  spd  spc

	db NORMAL, NORMAL ; type
	db 45 ; catch rate
	db 175 ; base exp

	INCBIN "gfx/pokemon/front/kangaskhan.pic", 0, 1 ; sprite dimensions
	dw KangaskhanPicFront, KangaskhanPicBack

	db COMET_PUNCH, TACKLE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     BUBBLEBEAM,   ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   SEISMIC_TOSS, \
	     THUNDERBOLT,  THUNDER,      EARTHQUAKE,   FISSURE,      DIG,          \
	     MIMIC,        DOUBLE_TEAM,  BIDE,         HYDRO_PUMP,   FIRE_BLAST,   \
	     OUTRAGE,      REST,         ROCK_SLIDE,   SHADOW_BALL,  SUBSTITUTE,   \
	     CUT,          SURF,         STRENGTH,     CURSE         
	; end

	db BANK(KangaskhanPicFront)
	assert BANK(KangaskhanPicFront) == BANK(KangaskhanPicBack)
