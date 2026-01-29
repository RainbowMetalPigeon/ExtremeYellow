	db DEX_BLISSEY ; pokedex id

	db 255,  10,  10,  55, 135
	;   hp  atk  def  spd  spc

	db NORMAL, NORMAL ; type
	db 29 ; catch rate
	db 255 ; base exp

	INCBIN "gfx/pokemon/front/blissey.pic", 0, 1 ; sprite dimensions
	dw BlisseyPicFront, BlisseyPicBack

	db POUND, LEER, SOFTBOILED, MINIMIZE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     BUBBLEBEAM,   METRONOME,    ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   \
	     DRAININGKISS, SEISMIC_TOSS, THUNDERBOLT,  THUNDER,      EARTHQUAKE,   \
	     PSYCHIC_M,    MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         \
	     FIRE_BLAST,   REST,         THUNDER_WAVE, PSYWAVE,      ROCK_SLIDE,   \
	     SHADOW_BALL,  SUBSTITUTE,   STRENGTH,     FLASH,        CURSE,        \
	     ROCK_SMASH,   ROCK_CLIMB    
	; end

	db BANK(BlisseyPicFront)
	assert BANK(BlisseyPicFront) == BANK(BlisseyPicBack)
