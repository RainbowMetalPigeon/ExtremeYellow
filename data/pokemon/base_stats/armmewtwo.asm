	db DEX_ARM_MEWTWO ; pokedex id

	db 106,  90, 110, 130,  90
	;   hp  atk  def  spd  spc

	db PSYCHIC_TYPE, STEEL ; type
	db 9 ; catch rate
	db 220 ; base exp

	INCBIN "gfx/pokemon/front/armmewtwo.pic", 0, 1 ; sprite dimensions
	dw ArmMewtwoPicFront, ArmMewtwoPicBack

	db CONFUSION, DISABLE, SWIFT, PSYCHIC_M ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     BUBBLEBEAM,   METRONOME,    ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   \
	     SEISMIC_TOSS, STONE_EDGE,   WILL_O_WISP,  THUNDERBOLT,  THUNDER,      \
	     EARTHQUAKE,   PSYCHIC_M,    MIMIC,        DOUBLE_TEAM,  REFLECT,      \
	     BIDE,         SELFDESTRUCT, FIRE_BLAST,   REST,         THUNDER_WAVE, \
	     PSYWAVE,      ROCK_SLIDE,   SHADOW_BALL,  SUBSTITUTE,   STRENGTH,     \
	     FLASH,        CURSE,        ROCK_SMASH,   ROCK_CLIMB,   DIVE          
	; end

	db BANK(ArmMewtwoPicFront)
	assert BANK(ArmMewtwoPicFront) == BANK(ArmMewtwoPicBack)
