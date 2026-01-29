	db DEX_AERODACTYL ; pokedex id

	db  80, 105,  65, 130,  60
	;   hp  atk  def  spd  spc

	db ROCK, FLYING ; type
	db 45 ; catch rate
	db 202 ; base exp

	INCBIN "gfx/pokemon/front/aerodactyl.pic", 0, 1 ; sprite dimensions
	dw AerodactylPicFront, AerodactylPicBack

	db WING_ATTACK, AGILITY, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm DRAGON_CLAW,  TOXIC,        DOUBLE_EDGE,  HYPER_BEAM,   STONE_EDGE,   \
	     EARTHQUAKE,   MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         \
	     FIRE_BLAST,   REST,         ROCK_SLIDE,   SUBSTITUTE,   FLY,          \
	     STRENGTH,     CURSE,        ROCK_SMASH    
	; end

	db BANK(AerodactylPicFront)
	assert BANK(AerodactylPicFront) == BANK(AerodactylPicBack)
