	db DEX_MGENGAR ; pokedex id

	db  60,  65,  80, 130, 170
	;   hp  atk  def  spd  spc

	db GHOST, POISON ; type
	db 45 ; catch rate
	db 235 ; base exp

	INCBIN "gfx/pokemon/front/mgengar.pic", 0, 1 ; sprite dimensions
	dw MGengarPicFront, MGengarPicBack

	db LICK, CONFUSE_RAY, NIGHT_SHADE, DARK_PULSE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        DARK_PULSE,   BODY_SLAM,    \
	     DOUBLE_EDGE,  METRONOME,    HYPER_BEAM,   SEISMIC_TOSS, GIGA_DRAIN,   \
	     WILL_O_WISP,  THUNDERBOLT,  THUNDER,      PSYCHIC_M,    MIMIC,        \
	     DOUBLE_TEAM,  BIDE,         SELFDESTRUCT, REST,         PSYWAVE,      \
	     EXPLOSION,    SHADOW_BALL,  SUBSTITUTE,   STRENGTH,     SHADOW_SNEAK, \
	     GUNK_SHOT,    FEINT_ATTACK, DRAININGKISS, CURSE         
	; end

	db BANK(MGengarPicFront)
	assert BANK(MGengarPicFront) == BANK(MGengarPicBack)
