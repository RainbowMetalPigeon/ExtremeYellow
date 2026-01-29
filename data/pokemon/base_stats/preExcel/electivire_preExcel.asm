	db DEX_ELECTIVIRE ; pokedex id

	db  75, 123,  67,  95,  90
	;   hp  atk  def  spd  spc

	db ELECTRIC, ELECTRIC ; type
	db 45 ; catch rate
	db 199 ; base exp

	INCBIN "gfx/pokemon/front/electivire.pic", 0, 1 ; sprite dimensions
	dw ElectivirePicFront, ElectivirePicBack

	db QUICK_ATTACK, LEER, THUNDERSHOCK, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     METRONOME,    HYPER_BEAM,   SEISMIC_TOSS, THUNDERBOLT,  THUNDER,      \
	     EARTHQUAKE,   DIG,          PSYCHIC_M,    MIMIC,        DOUBLE_TEAM,  \
	     REFLECT,      BIDE,         REST,         THUNDER_WAVE, PSYWAVE,      \
	     ROCK_SLIDE,   SUBSTITUTE,   STRENGTH,     FLASH,        CURSE         
	; end

	db BANK(ElectivirePicFront)
	assert BANK(ElectivirePicFront) == BANK(ElectivirePicBack)
