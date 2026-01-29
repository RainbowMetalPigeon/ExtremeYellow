	db DEX_MARODACTYL ; pokedex id

	db  80, 135,  85, 150,  70
	;   hp  atk  def  spd  spc

	db ROCK, FLYING ; type
	db 45 ; catch rate
	db 237 ; base exp

	INCBIN "gfx/pokemon/front/marodactyl.pic", 0, 1 ; sprite dimensions
	dw MArodactylPicFront, MArodactylPicBack

	db WING_ATTACK, AGILITY, ROCK_SLIDE, NO_MOVE ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm DRAGON_CLAW,  TOXIC,        DOUBLE_EDGE,  HYPER_BEAM,   STONE_EDGE,   \
	     EARTHQUAKE,   MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         \
	     FIRE_BLAST,   REST,         ROCK_SLIDE,   SUBSTITUTE,   FLY,          \
	     STRENGTH,     BRAVE_BIRD,   BODY_SLAM,    CURSE,        ROCK_SMASH    
	; end

	db BANK(MArodactylPicFront)
	assert BANK(MArodactylPicFront) == BANK(MArodactylPicBack)
