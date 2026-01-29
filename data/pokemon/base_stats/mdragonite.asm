	db DEX_MDRAGONITE ; pokedex id

	db  91, 124, 115, 100, 145
	;   hp  atk  def  spd  spc

	db DRAGON, FLYING ; type
	db 9 ; catch rate
	db 246 ; base exp

	INCBIN "gfx/pokemon/front/mdragonite.pic", 0, 1 ; sprite dimensions
	dw MDragonitePicFront, MDragonitePicBack

	db WRAP, LEER, THUNDER_WAVE, DRAGONBREATH ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   MEGAHORN,     DRAGON_CLAW,  TOXIC,        BODY_SLAM,    \
	     DOUBLE_EDGE,  BUBBLEBEAM,   ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   \
	     STONE_EDGE,   THUNDERBOLT,  THUNDER,      EARTHQUAKE,   MIMIC,        \
	     DOUBLE_TEAM,  REFLECT,      BIDE,         HYDRO_PUMP,   FIRE_BLAST,   \
	     OUTRAGE,      BRAVE_BIRD,   REST,         THUNDER_WAVE, ROCK_SLIDE,   \
	     SUBSTITUTE,   FREEZE_DRY,   BODY_PRESS,   CUT,          FLY,          \
	     SURF,         STRENGTH,     CURSE,        ROCK_SMASH,   WATERFALL,    \
	     DIVE,         WHIRLPOOL     
	; end

	db BANK(MDragonitePicFront)
	assert BANK(MDragonitePicFront) == BANK(MDragonitePicBack)
