	db DEX_GOLDUCK ; pokedex id

	db  80,  82,  78,  85,  80
	;   hp  atk  def  spd  spc

	db WATER, WATER ; type
	db 75 ; catch rate
	db 174 ; base exp

	INCBIN "gfx/pokemon/front/golduck.pic", 0, 1 ; sprite dimensions
	dw GolduckPicFront, GolduckPicBack

	db SCRATCH, LEER, DISABLE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     BUBBLEBEAM,   ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   SEISMIC_TOSS, \
	     DIG,          PSYCHIC_M,    MIMIC,        DOUBLE_TEAM,  BIDE,         \
	     HYDRO_PUMP,   REST,         SUBSTITUTE,   SURF,         STRENGTH,     \
	     FLASH,        CURSE         
	; end

	db BANK(GolduckPicFront)
	assert BANK(GolduckPicFront) == BANK(GolduckPicBack)
