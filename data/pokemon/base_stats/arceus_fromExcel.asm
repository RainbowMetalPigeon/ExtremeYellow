	db DEX_ARCEUS ; pokedex id

	db 120, 120, 120, 120, 120
	;   hp  atk  def  spd  spc

	db NORMAL, NORMAL ; type
	db 3 ; catch rate
	db 255 ; base exp

	INCBIN "gfx/pokemon/front/arceus.pic", 0, 1 ; sprite dimensions
	dw ArceusPicFront, ArceusPicBack

	db SEISMIC_TOSS, STOMP, LIGHT_SCREEN, REFLECT ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm SWORDS_DANCE, MEGA_KICK,    TOXIC,        BODY_SLAM,    TAKE_DOWN,    \
	     DOUBLE_EDGE,  BUBBLEBEAM,   WATER_GUN,    ICE_BEAM,     BLIZZARD,     \
	     HYPER_BEAM,   SUBMISSION,   COUNTER,      SEISMIC_TOSS, MEGA_DRAIN,   \
	     SOLARBEAM,    DRAGON_RAGE,  THUNDERBOLT,  THUNDER,      EARTHQUAKE,   \
	     FISSURE,      PSYCHIC_M,    TELEPORT,     MIMIC,        DOUBLE_TEAM,  \
	     REFLECT,      BIDE,         METRONOME,    FIRE_BLAST,   SWIFT,        \
	     DREAM_EATER,  REST,         THUNDER_WAVE, PSYWAVE,      ROCK_SLIDE,   \
	     TRI_ATTACK,   SUBSTITUTE,   CUT,          SURF,         STRENGTH,     \
	     FLASH         
	; end

	db BANK(ArceusPicFront)
	assert BANK(ArceusPicFront) == BANK(ArceusPicBack)
