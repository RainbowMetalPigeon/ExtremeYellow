	db DEX_MCLEFABLE ; pokedex id

	db  95,  80,  93,  70, 135
	;   hp  atk  def  spd  spc

	db FAIRY, FLYING ; type
	db 25 ; catch rate
	db 159 ; base exp

	INCBIN "gfx/pokemon/front/mclefable.pic", 0, 1 ; sprite dimensions
	dw MClefablePicFront, MClefablePicBack

	db SING, MOONBLAST, MINIMIZE, METRONOME ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    METEOR_MASH,  \
	     DOUBLE_EDGE,  BUBBLEBEAM,   METRONOME,    ICE_BEAM,     BLIZZARD,     \
	     HYPER_BEAM,   DRAININGKISS, SEISMIC_TOSS, THUNDERBOLT,  THUNDER,      \
	     DIG,          PSYCHIC_M,    MOONBLAST,    MIMIC,        DOUBLE_TEAM,  \
	     REFLECT,      BIDE,         FIRE_BLAST,   REST,         THUNDER_WAVE, \
	     PSYWAVE,      SHADOW_BALL,  SUBSTITUTE,   STRENGTH,     FLASH,        \
	     CURSE,        ROCK_SMASH    
	; end

	db BANK(MClefablePicFront)
	assert BANK(MClefablePicFront) == BANK(MClefablePicBack)
