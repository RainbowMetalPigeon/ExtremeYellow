	db DEX_MMEWTWOY ; pokedex id

	db 106, 150,  70, 140, 194
	;   hp  atk  def  spd  spc

	db PSYCHIC_TYPE, PSYCHIC_TYPE ; type
	db 3 ; catch rate
	db 254 ; base exp

	INCBIN "gfx/pokemon/front/mmewtwoy.pic", 0, 1 ; sprite dimensions
	dw MMewtwoYPicFront, MMewtwoYPicBack

	db CONFUSION, DISABLE, SWIFT, PSYCHIC_M ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     BUBBLEBEAM,   METRONOME,    ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   \
	     SEISMIC_TOSS, STONE_EDGE,   WILL_O_WISP,  THUNDERBOLT,  THUNDER,      \
	     EARTHQUAKE,   PSYCHIC_M,    MIMIC,        DOUBLE_TEAM,  REFLECT,      \
	     BIDE,         SELFDESTRUCT, FIRE_BLAST,   REST,         THUNDER_WAVE, \
	     PSYWAVE,      ROCK_SLIDE,   SHADOW_BALL,  SUBSTITUTE,   STRENGTH,     \
	     FLASH,        HYDRO_PUMP,   SURF,         GIGA_DRAIN,   MIRROR_COAT,  \
	     OUTRAGE,      MOONBLAST,    DRAININGKISS  
	; end

	db BANK(MMewtwoYPicFront)
	assert BANK(MMewtwoYPicFront) == BANK(MMewtwoYPicBack)
