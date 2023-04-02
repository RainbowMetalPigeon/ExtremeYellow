	db DEX_CLEFABLE ; pokedex id

	db  95,  70,  73,  60,  95
	;   hp  atk  def  spd  spc

	db FAIRY, FAIRY ; type
	db 25 ; catch rate
	db 129 ; base exp

	INCBIN "gfx/pokemon/front/clefable.pic", 0, 1 ; sprite dimensions
	dw ClefablePicFront, ClefablePicBack

	db SING, FURY_SWIPES, MINIMIZE, METRONOME ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    METEOR_MASH,  \
	     DOUBLE_EDGE,  BUBBLEBEAM,   METRONOME,    ICE_BEAM,     BLIZZARD,     \
	     HYPER_BEAM,   DRAININGKISS, SEISMIC_TOSS, THUNDERBOLT,  THUNDER,      \
	     DIG,          PSYCHIC_M,    MOONBLAST,    MIMIC,        DOUBLE_TEAM,  \
	     REFLECT,      BIDE,         FIRE_BLAST,   REST,         THUNDER_WAVE, \
	     PSYWAVE,      SHADOW_BALL,  SUBSTITUTE,   STRENGTH,     FLASH         
	; end

	db BANK(ClefablePicFront)
	assert BANK(ClefablePicFront) == BANK(ClefablePicBack)
