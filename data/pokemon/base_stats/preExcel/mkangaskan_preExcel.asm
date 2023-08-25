	db DEX_MKANGASKAN ; pokedex id

	db 105, 125, 100, 100,  80
	;   hp  atk  def  spd  spc

	db NORMAL, NORMAL ; type
	db 45 ; catch rate
	db 222 ; base exp

	INCBIN "gfx/pokemon/front/mkangaskan.pic", 0, 1 ; sprite dimensions
	dw MKangaskanPicFront, MKangaskanPicBack

	db COMET_PUNCH, TACKLE, DOUBLE_KICK, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     BUBBLEBEAM,   ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   SEISMIC_TOSS, \
	     THUNDERBOLT,  THUNDER,      EARTHQUAKE,   FISSURE,      DIG,          \
	     MIMIC,        DOUBLE_TEAM,  BIDE,         HYDRO_PUMP,   FIRE_BLAST,   \
	     OUTRAGE,      REST,         ROCK_SLIDE,   SHADOW_BALL,  SUBSTITUTE,   \
	     CUT,          SURF,         STRENGTH,     SWORDS_DANCE, METRONOME,    \
	     METEOR_MASH   
	; end

	db BANK(MKangaskanPicFront)
	assert BANK(MKangaskanPicFront) == BANK(MKangaskanPicBack)
