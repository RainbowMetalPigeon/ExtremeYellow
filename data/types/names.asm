TypeNames:
	table_width 2, TypeNames

	dw .Normal
	dw .Fighting
	dw .Flying
	dw .Poison
	dw .Ground
	dw .Rock
	dw .Bird
	dw .Bug
	dw .Ghost
	dw .Steel
	dw .Typeless
	dw .Ground2 ; new, for THOUSANDARROWS

REPT UNUSED_TYPES_END - UNUSED_TYPES
	dw .Normal
ENDR

	dw .Fire
	dw .Water
	dw .Grass
	dw .Electric
	dw .Psychic
	dw .Ice
	dw .Dragon
	dw .Dark
	dw .Fairy
	dw .Ice2 ; new, for FREEZE_DRY

	assert_table_length NUM_TYPES

.Normal:   db "NORMAL@"
.Fighting: db "FIGHTING@"
.Flying:   db "FLYING@"
.Poison:   db "POISON@"
.Fire:     db "FIRE@"
.Water:    db "WATER@"
.Grass:    db "GRASS@"
.Electric: db "ELECTRIC@"
.Psychic:  db "PSYCHIC@"
.Ice:      db "ICE@"
.Ground:   db "GROUND@"
.Rock:     db "ROCK@"
.Bird:     db "BIRD@"
.Bug:      db "BUG@"
.Ghost:    db "GHOST@"
.Dragon:   db "DRAGON@"
.Steel:	   db "STEEL@"
.Dark:	   db "DARK@"
.Fairy:	   db "FAIRY@"
.Typeless  db "TYPELESS@"
.Ground2   db "GROUND@" ; new, for THOUSANDARROWS
.Ice2:	   db "ICE@" ; new, for FREEZE_DRY

; new, for TCG mode ==================================

TypeNames_TCG:
	table_width 2, TypeNames_TCG

	dw .TCGColorless
	dw .TCGFighting
	dw .TCGMetal
	dw .TCGTypeless
	dw .TCGFire
	dw .TCGWater
	dw .TCGGrass
	dw .TCGLightning
	dw .TCGPsychic
	dw .TCGDragon
	dw .TCGDark
	dw .TCGWater2 ; for FREEZE_DRY

	assert_table_length NUM_TYPES_TCG

.TCGColorless:	db "COLORLES@" ; COLORLESS
.TCGFighting:	db "FIGHTING@"
.TCGMetal:		db "METAL@"
.TCGTypeless:	db "TYPELESS@"
.TCGFire:		db "FIRE@"
.TCGWater:		db "WATER@"
.TCGGrass:		db "GRASS@"
.TCGLightning:	db "LIGHTNIN@" ; LIGHTNING
.TCGPsychic:	db "PSYCHIC@"
.TCGDragon:		db "DRAGON@"
.TCGDark:		db "DARK@"
.TCGWater2:		db "WATER@"
