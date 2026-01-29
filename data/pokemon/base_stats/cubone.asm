	db DEX_CUBONE ; pokedex id

	db  50,  50,  95,  35,  40
	;   hp  atk  def  spd  spc

	db GROUND, GROUND ; type
	db 190 ; catch rate
	db 87 ; base exp

	INCBIN "gfx/pokemon/front/cubone.pic", 0, 1 ; sprite dimensions
	dw CubonePicFront, CubonePicBack

	db GROWL, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   SWORDS_DANCE, COUNTER,      TOXIC,        BODY_SLAM,    \
	     DOUBLE_EDGE,  BUBBLEBEAM,   ICE_BEAM,     BLIZZARD,     SEISMIC_TOSS, \
	     EARTHQUAKE,   FISSURE,      DIG,          MIMIC,        DOUBLE_TEAM,  \
	     BIDE,         FIRE_BLAST,   REST,         ROCK_SLIDE,   SUBSTITUTE,   \
	     STRENGTH,     CURSE,        ROCK_SMASH,   ROCK_CLIMB    
	; end

	db BANK(CubonePicFront)
	assert BANK(CubonePicFront) == BANK(CubonePicBack)
