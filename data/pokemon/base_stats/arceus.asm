	db DEX_ARCEUS ; pokedex id

	db 120, 120, 120, 120, 120
	;   hp  atk  def  spd  spc

	db NORMAL, NORMAL ; type
	db 3 ; catch rate
	db 255 ; base exp

	INCBIN "gfx/pokemon/front/arceus.pic", 0, 1 ; sprite dimensions
	dw ArceusPicFront, ArceusPicBack

	db SEISMIC_TOSS, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm SWORDS_DANCE, DRAGON_CLAW,  DARK_PULSE,   ICE_BEAM,     BLIZZARD,     \
	     HYPER_BEAM,   FLASH_CANNON, GIGA_DRAIN,   STONE_EDGE,   WILL_O_WISP,  \
	     THUNDERBOLT,  THUNDER,      EARTHQUAKE,   PSYCHIC_M,    DOUBLE_TEAM,  \
	     REFLECT,      FIRE_BLAST,   OUTRAGE,      REST,         X_SCISSOR,    \
	     THUNDER_WAVE, ROCK_SLIDE,   SHADOW_BALL,  SUBSTITUTE,   BODY_PRESS,   \
	     CUT,          FLY,          SURF,         STRENGTH,     FLASH,        \
	     CURSE,        ROCK_SMASH,   ROCK_CLIMB,   WATERFALL,    DIVE,         \
	     WHIRLPOOL     
	; end

	db BANK(ArceusPicFront)
	assert BANK(ArceusPicFront) == BANK(ArceusPicBack)
