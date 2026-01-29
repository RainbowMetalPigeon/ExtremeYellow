	db DEX_MMEWTWOX ; pokedex id

	db 106, 190, 100, 130, 154
	;   hp  atk  def  spd  spc

	db PSYCHIC_TYPE, FIGHTING ; type
	db 3 ; catch rate
	db 254 ; base exp

	INCBIN "gfx/pokemon/front/mmewtwox.pic", 0, 1 ; sprite dimensions
	dw MMewtwoXPicFront, MMewtwoXPicBack

	db CONFUSION, DISABLE, SWIFT, PSYCHIC_M ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     BUBBLEBEAM,   METRONOME,    ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   \
	     SEISMIC_TOSS, STONE_EDGE,   WILL_O_WISP,  THUNDERBOLT,  THUNDER,      \
	     EARTHQUAKE,   PSYCHIC_M,    MIMIC,        DOUBLE_TEAM,  REFLECT,      \
	     BIDE,         SELFDESTRUCT, FIRE_BLAST,   REST,         THUNDER_WAVE, \
	     PSYWAVE,      ROCK_SLIDE,   SHADOW_BALL,  SUBSTITUTE,   STRENGTH,     \
	     FLASH,        SWORDS_DANCE, CLOSE_COMBAT, GUNK_SHOT,    SHADOW_SNEAK, \
	     METEOR_MASH,  MIRROR_COAT,  DARK_PULSE,   CURSE,        ROCK_SMASH,   \
	     ROCK_CLIMB,   DIVE          
	; end

	db BANK(MMewtwoXPicFront)
	assert BANK(MMewtwoXPicFront) == BANK(MMewtwoXPicBack)
