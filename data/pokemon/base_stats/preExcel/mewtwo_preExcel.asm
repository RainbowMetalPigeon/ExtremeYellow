	db DEX_MEWTWO ; pokedex id

	db 106, 110,  90, 130, 154
	;   hp  atk  def  spd  spc

	db PSYCHIC_TYPE, PSYCHIC_TYPE ; type
	db 3 ; catch rate
	db 220 ; base exp

	INCBIN "gfx/pokemon/front/mewtwo.pic", 0, 1 ; sprite dimensions
	dw MewtwoPicFront, MewtwoPicBack

	db CONFUSION, DISABLE, SWIFT, PSYCHIC_M ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     BUBBLEBEAM,   METRONOME,    ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   \
	     SEISMIC_TOSS, STONE_EDGE,   WILL_O_WISP,  THUNDERBOLT,  THUNDER,      \
	     EARTHQUAKE,   PSYCHIC_M,    MIMIC,        DOUBLE_TEAM,  REFLECT,      \
	     BIDE,         SELFDESTRUCT, FIRE_BLAST,   REST,         THUNDER_WAVE, \
	     PSYWAVE,      ROCK_SLIDE,   SHADOW_BALL,  SUBSTITUTE,   STRENGTH,     \
	     FLASH,        CURSE         
	; end

	db BANK(MewtwoPicFront)
	assert BANK(MewtwoPicFront) == BANK(MewtwoPicBack)
