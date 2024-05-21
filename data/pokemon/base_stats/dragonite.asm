	db DEX_DRAGONITE ; pokedex id

	db  91, 134,  95,  80, 100
	;   hp  atk  def  spd  spc

	db DRAGON, FLYING ; type
	db 9 ; catch rate
	db 218 ; base exp

	INCBIN "gfx/pokemon/front/dragonite.pic", 0, 1 ; sprite dimensions
	dw DragonitePicFront, DragonitePicBack

	db WRAP, LEER, THUNDER_WAVE, AGILITY ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   DRAGON_CLAW,  TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     BUBBLEBEAM,   ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   STONE_EDGE,   \
	     THUNDERBOLT,  THUNDER,      EARTHQUAKE,   MIMIC,        DOUBLE_TEAM,  \
	     REFLECT,      BIDE,         HYDRO_PUMP,   FIRE_BLAST,   OUTRAGE,      \
	     REST,         THUNDER_WAVE, ROCK_SLIDE,   SUBSTITUTE,   BODY_PRESS,   \
	     CUT,          FLY,          SURF,         STRENGTH,     CURSE         
	; end

	db BANK(DragonitePicFront)
	assert BANK(DragonitePicFront) == BANK(DragonitePicBack)
