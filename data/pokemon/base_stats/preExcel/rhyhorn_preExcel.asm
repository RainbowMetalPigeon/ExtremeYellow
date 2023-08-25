	db DEX_RHYHORN ; pokedex id

	db  80,  85,  95,  25,  30
	;   hp  atk  def  spd  spc

	db GROUND, ROCK ; type
	db 120 ; catch rate
	db 135 ; base exp

	INCBIN "gfx/pokemon/front/rhyhorn.pic", 0, 1 ; sprite dimensions
	dw RhyhornPicFront, RhyhornPicBack

	db HORN_ATTACK, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGAHORN,     SWORDS_DANCE, COUNTER,      TOXIC,        BODY_SLAM,    \
	     DOUBLE_EDGE,  ICE_BEAM,     BLIZZARD,     STONE_EDGE,   THUNDERBOLT,  \
	     THUNDER,      EARTHQUAKE,   FISSURE,      DIG,          MIMIC,        \
	     DOUBLE_TEAM,  BIDE,         FIRE_BLAST,   REST,         ROCK_SLIDE,   \
	     SUBSTITUTE,   STRENGTH      
	; end

	db BANK(RhyhornPicFront)
	assert BANK(RhyhornPicFront) == BANK(RhyhornPicBack)
