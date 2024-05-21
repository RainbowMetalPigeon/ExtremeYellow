	db DEX_WIGGLYTUFF ; pokedex id

	db 140,  70,  45,  45,  68
	;   hp  atk  def  spd  spc

	db NORMAL, FAIRY ; type
	db 50 ; catch rate
	db 109 ; base exp

	INCBIN "gfx/pokemon/front/wigglytuff.pic", 0, 1 ; sprite dimensions
	dw WigglytuffPicFront, WigglytuffPicBack

	db SING, DISABLE, DEFENSE_CURL, FURY_SWIPES ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     BUBBLEBEAM,   ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   DRAININGKISS, \
	     SEISMIC_TOSS, FEINT_ATTACK, THUNDERBOLT,  THUNDER,      DIG,          \
	     PSYCHIC_M,    MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         \
	     SELFDESTRUCT, FIRE_BLAST,   REST,         THUNDER_WAVE, PSYWAVE,      \
	     SHADOW_BALL,  SUBSTITUTE,   GYRO_BALL,    BODY_PRESS,   STRENGTH,     \
	     FLASH,        CURSE         
	; end

	db BANK(WigglytuffPicFront)
	assert BANK(WigglytuffPicFront) == BANK(WigglytuffPicBack)
