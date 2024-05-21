	db DEX_GENGAR ; pokedex id

	db  60,  65,  60, 110, 130
	;   hp  atk  def  spd  spc

	db GHOST, POISON ; type
	db 45 ; catch rate
	db 190 ; base exp

	INCBIN "gfx/pokemon/front/gengar.pic", 0, 1 ; sprite dimensions
	dw GengarPicFront, GengarPicBack

	db LICK, CONFUSE_RAY, NIGHT_SHADE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        DARK_PULSE,   BODY_SLAM,    \
	     DOUBLE_EDGE,  METRONOME,    HYPER_BEAM,   SEISMIC_TOSS, GIGA_DRAIN,   \
	     WILL_O_WISP,  THUNDERBOLT,  THUNDER,      PSYCHIC_M,    MIMIC,        \
	     DOUBLE_TEAM,  BIDE,         SELFDESTRUCT, REST,         PSYWAVE,      \
	     EXPLOSION,    SHADOW_BALL,  SUBSTITUTE,   STRENGTH,     CURSE         
	; end

	db BANK(GengarPicFront)
	assert BANK(GengarPicFront) == BANK(GengarPicBack)
