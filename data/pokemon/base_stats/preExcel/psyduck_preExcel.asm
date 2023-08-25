	db DEX_PSYDUCK ; pokedex id

	db  50,  52,  48,  55,  50
	;   hp  atk  def  spd  spc

	db WATER, WATER ; type
	db 190 ; catch rate
	db 80 ; base exp

	INCBIN "gfx/pokemon/front/psyduck.pic", 0, 1 ; sprite dimensions
	dw PsyduckPicFront, PsyduckPicBack

	db SCRATCH, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     BUBBLEBEAM,   ICE_BEAM,     BLIZZARD,     SEISMIC_TOSS, DIG,          \
	     PSYCHIC_M,    MIMIC,        DOUBLE_TEAM,  BIDE,         HYDRO_PUMP,   \
	     REST,         SUBSTITUTE,   SURF,         STRENGTH,     FLASH         
	; end

	db BANK(PsyduckPicFront)
	assert BANK(PsyduckPicFront) == BANK(PsyduckPicBack)
