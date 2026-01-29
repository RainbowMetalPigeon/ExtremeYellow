	db DEX_STARYU ; pokedex id

	db  30,  45,  55,  85,  70
	;   hp  atk  def  spd  spc

	db WATER, WATER ; type
	db 225 ; catch rate
	db 106 ; base exp

	INCBIN "gfx/pokemon/front/staryu.pic", 0, 1 ; sprite dimensions
	dw StaryuPicFront, StaryuPicBack

	db TACKLE, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        DOUBLE_EDGE,  BUBBLEBEAM,   ICE_BEAM,     BLIZZARD,     \
	     FLASH_CANNON, THUNDERBOLT,  THUNDER,      PSYCHIC_M,    MIMIC,        \
	     DOUBLE_TEAM,  REFLECT,      BIDE,         HYDRO_PUMP,   REST,         \
	     THUNDER_WAVE, PSYWAVE,      SUBSTITUTE,   GYRO_BALL,    SURF,         \
	     FLASH,        CURSE         
	; end

	db BANK(StaryuPicFront)
	assert BANK(StaryuPicFront) == BANK(StaryuPicBack)
