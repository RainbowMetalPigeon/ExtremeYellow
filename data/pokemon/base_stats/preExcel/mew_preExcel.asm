	db DEX_MEW ; pokedex id

	db 100, 100, 100, 100, 100
	;   hp  atk  def  spd  spc

	db PSYCHIC_TYPE, PSYCHIC_TYPE ; type
	db 1 ; catch rate
	db 64 ; base exp

	INCBIN "gfx/pokemon/front/mew.pic", 0, 1 ; sprite dimensions
	dw MewPicFront, MewPicBack

	db TELEPORT, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   MEGAHORN,     SWORDS_DANCE, COUNTER,      DRAGON_CLAW,  \
	     TOXIC,        DARK_PULSE,   BODY_SLAM,    METEOR_MASH,  DOUBLE_EDGE,  \
	     BUBBLEBEAM,   METRONOME,    ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   \
	     MIRROR_COAT,  DRAININGKISS, FLASH_CANNON, SEISMIC_TOSS, FEINT_ATTACK, \
	     GIGA_DRAIN,   STONE_EDGE,   WILL_O_WISP,  THUNDERBOLT,  THUNDER,      \
	     EARTHQUAKE,   FISSURE,      DIG,          PSYCHIC_M,    MOONBLAST,    \
	     MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         HYDRO_PUMP,   \
	     SELFDESTRUCT, CLOSE_COMBAT, FIRE_BLAST,   SHADOW_SNEAK, OUTRAGE,      \
	     BRAVE_BIRD,   REST,         GUNK_SHOT,    X_SCISSOR,    THUNDER_WAVE, \
	     PSYWAVE,      EXPLOSION,    ROCK_SLIDE,   SHADOW_BALL,  SUBSTITUTE,   \
	     FREEZE_DRY,   GYRO_BALL,    BODY_PRESS,   FLAIL,        CURSE,        \
	     CUT,          FLY,          SURF,         STRENGTH,     FLASH,        \
		 ROCK_SMASH,   ROCK_CLIMB,   WATERFALL,    DIVE,         WHIRLPOOL
	; end

	db BANK(MewPicFront)
	assert BANK(MewPicFront) == BANK(MewPicBack)
