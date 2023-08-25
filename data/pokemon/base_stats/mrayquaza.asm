	db DEX_MRAYQUAZA ; pokedex id

	db 105, 180, 100, 115, 180
	;   hp  atk  def  spd  spc

	db DRAGON, FLYING ; type
	db 3 ; catch rate
	db 255 ; base exp

	INCBIN "gfx/pokemon/front/mrayquaza.pic", 0, 1 ; sprite dimensions
	dw MRayquazaPicFront, MRayquazaPicBack

	db TWISTER, AIR_SLASH, DRAGONASCENT, NO_MOVE ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm SWORDS_DANCE, DRAGON_CLAW,  TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   STONE_EDGE,   THUNDERBOLT,  \
	     THUNDER,      EARTHQUAKE,   MIMIC,        DOUBLE_TEAM,  HYDRO_PUMP,   \
	     FIRE_BLAST,   OUTRAGE,      REST,         THUNDER_WAVE, ROCK_SLIDE,   \
	     SUBSTITUTE,   FLY,          SURF,         STRENGTH      
	; end

	db BANK(MRayquazaPicFront)
	assert BANK(MRayquazaPicFront) == BANK(MRayquazaPicBack)
