	db DEX_CHANSEY ; pokedex id

	db 250,   5,   5,  50, 105
	;   hp  atk  def  spd  spc

	db NORMAL, NORMAL ; type
	db 30 ; catch rate
	db 255 ; base exp

	INCBIN "gfx/pokemon/front/chansey.pic", 0, 1 ; sprite dimensions
	dw ChanseyPicFront, ChanseyPicBack

	db POUND, LEER, SOFTBOILED, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     BUBBLEBEAM,   METRONOME,    ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   \
	     DRAININGKISS, SEISMIC_TOSS, THUNDERBOLT,  THUNDER,      EARTHQUAKE,   \
	     PSYCHIC_M,    MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         \
	     FIRE_BLAST,   REST,         THUNDER_WAVE, PSYWAVE,      ROCK_SLIDE,   \
	     SHADOW_BALL,  SUBSTITUTE,   STRENGTH,     FLASH         
	; end

	db BANK(ChanseyPicFront)
	assert BANK(ChanseyPicFront) == BANK(ChanseyPicBack)
