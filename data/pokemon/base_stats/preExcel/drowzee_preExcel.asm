	db DEX_DROWZEE ; pokedex id

	db  60,  48,  45,  42,  90
	;   hp  atk  def  spd  spc

	db PSYCHIC_TYPE, PSYCHIC_TYPE ; type
	db 190 ; catch rate
	db 102 ; base exp

	INCBIN "gfx/pokemon/front/drowzee.pic", 0, 1 ; sprite dimensions
	dw DrowzeePicFront, DrowzeePicBack

	db POUND, HYPNOSIS, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     METRONOME,    SEISMIC_TOSS, PSYCHIC_M,    MIMIC,        DOUBLE_TEAM,  \
	     REFLECT,      BIDE,         REST,         THUNDER_WAVE, PSYWAVE,      \
	     SHADOW_BALL,  SUBSTITUTE,   FLASH,        CURSE         
	; end

	db BANK(DrowzeePicFront)
	assert BANK(DrowzeePicFront) == BANK(DrowzeePicBack)
