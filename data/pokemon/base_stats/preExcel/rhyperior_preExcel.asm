	db DEX_RHYPERIOR ; pokedex id

	db 115, 140, 130,  40,  55
	;   hp  atk  def  spd  spc

	db GROUND, ROCK ; type
	db 35 ; catch rate
	db 217 ; base exp

	INCBIN "gfx/pokemon/front/rhyperior.pic", 0, 1 ; sprite dimensions
	dw RhyperiorPicFront, RhyperiorPicBack

	db HORN_ATTACK, STOMP, LEER, FURY_ATTACK ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   MEGAHORN,     SWORDS_DANCE, COUNTER,      TOXIC,        \
	     BODY_SLAM,    DOUBLE_EDGE,  BUBBLEBEAM,   ICE_BEAM,     BLIZZARD,     \
	     HYPER_BEAM,   FLASH_CANNON, SEISMIC_TOSS, STONE_EDGE,   THUNDERBOLT,  \
	     THUNDER,      EARTHQUAKE,   FISSURE,      DIG,          MIMIC,        \
	     DOUBLE_TEAM,  BIDE,         HYDRO_PUMP,   FIRE_BLAST,   OUTRAGE,      \
	     REST,         ROCK_SLIDE,   SUBSTITUTE,   CUT,          SURF,         \
	     STRENGTH      
	; end

	db BANK(RhyperiorPicFront)
	assert BANK(RhyperiorPicFront) == BANK(RhyperiorPicBack)
