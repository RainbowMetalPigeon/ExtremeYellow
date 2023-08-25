	db DEX_BLASTOISE ; pokedex id

	db  79,  83, 100,  78,  85
	;   hp  atk  def  spd  spc

	db WATER, WATER ; type
	db 45 ; catch rate
	db 210 ; base exp

	INCBIN "gfx/pokemon/front/blastoise.pic", 0, 1 ; sprite dimensions
	dw BlastoisePicFront, BlastoisePicBack

	db TACKLE, LEER, BUBBLE, WATER_GUN ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        DARK_PULSE,   BODY_SLAM,    \
	     DOUBLE_EDGE,  BUBBLEBEAM,   ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   \
	     MIRROR_COAT,  FLASH_CANNON, SEISMIC_TOSS, EARTHQUAKE,   FISSURE,      \
	     DIG,          MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         \
	     HYDRO_PUMP,   OUTRAGE,      REST,         ROCK_SLIDE,   SUBSTITUTE,   \
	     SURF,         STRENGTH      
	; end

	db BANK(BlastoisePicFront)
	assert BANK(BlastoisePicFront) == BANK(BlastoisePicBack)
