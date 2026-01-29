	db DEX_JIGGLYPUFF ; pokedex id

	db 115,  45,  20,  20,  25
	;   hp  atk  def  spd  spc

	db NORMAL, FAIRY ; type
	db 170 ; catch rate
	db 76 ; base exp

	INCBIN "gfx/pokemon/front/jigglypuff.pic", 0, 1 ; sprite dimensions
	dw JigglypuffPicFront, JigglypuffPicBack

	db SING, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     BUBBLEBEAM,   ICE_BEAM,     BLIZZARD,     DRAININGKISS, SEISMIC_TOSS, \
	     FEINT_ATTACK, THUNDERBOLT,  THUNDER,      DIG,          PSYCHIC_M,    \
	     MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         SELFDESTRUCT, \
	     FIRE_BLAST,   REST,         THUNDER_WAVE, PSYWAVE,      SHADOW_BALL,  \
	     SUBSTITUTE,   GYRO_BALL,    BODY_PRESS,   STRENGTH,     FLASH,        \
	     CURSE         
	; end

	db BANK(JigglypuffPicFront)
	assert BANK(JigglypuffPicFront) == BANK(JigglypuffPicBack)
