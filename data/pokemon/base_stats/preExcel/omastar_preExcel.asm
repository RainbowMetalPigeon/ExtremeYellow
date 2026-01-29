	db DEX_OMASTAR ; pokedex id

	db  70,  60, 125,  55, 115
	;   hp  atk  def  spd  spc

	db ROCK, WATER ; type
	db 45 ; catch rate
	db 199 ; base exp

	INCBIN "gfx/pokemon/front/omastar.pic", 0, 1 ; sprite dimensions
	dw OmastarPicFront, OmastarPicBack

	db WATER_GUN, DEFENSE_CURL, HORN_ATTACK, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  BUBBLEBEAM,   ICE_BEAM,     \
	     BLIZZARD,     HYPER_BEAM,   SEISMIC_TOSS, STONE_EDGE,   MIMIC,        \
	     DOUBLE_TEAM,  REFLECT,      BIDE,         HYDRO_PUMP,   REST,         \
	     ROCK_SLIDE,   SUBSTITUTE,   GYRO_BALL,    SURF,         CURSE         
	; end

	db BANK(OmastarPicFront)
	assert BANK(OmastarPicFront) == BANK(OmastarPicBack)
