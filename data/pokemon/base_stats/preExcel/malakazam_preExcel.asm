	db DEX_MALAKAZAM ; pokedex id

	db  55,  50,  65, 150, 175
	;   hp  atk  def  spd  spc

	db PSYCHIC_TYPE, PSYCHIC_TYPE ; type
	db 45 ; catch rate
	db 235 ; base exp

	INCBIN "gfx/pokemon/front/malakazam.pic", 0, 1 ; sprite dimensions
	dw MAlakazamPicFront, MAlakazamPicBack

	db TELEPORT, CONFUSION, PSYCHIC_M, DISABLE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     METRONOME,    HYPER_BEAM,   SEISMIC_TOSS, DIG,          PSYCHIC_M,    \
	     MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         REST,         \
	     THUNDER_WAVE, PSYWAVE,      SHADOW_BALL,  SUBSTITUTE,   FLASH,        \
	     MOONBLAST,    DARK_PULSE,   CURSE         
	; end

	db BANK(MAlakazamPicFront)
	assert BANK(MAlakazamPicFront) == BANK(MAlakazamPicBack)
