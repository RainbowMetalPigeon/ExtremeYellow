SeviiFiveIslandWarehouse2F_Object:
	db $2e ; border block

	def_warp_events
	warp_event 15,  2, SEVII_FIVE_ISLAND_WAREHOUSE_1F,  5 ; id=1
	warp_event  2,  2, SEVII_FIVE_ISLAND_WAREHOUSE_BF,  8 ; id=2
	warp_event  3, 18, SEVII_FIVE_ISLAND_WAREHOUSE_1F,  7 ; id=3
	warp_event 19, 18, SEVII_FIVE_ISLAND_WAREHOUSE_1F,  9 ; id=4
	warp_event 31, 12, SEVII_FIVE_ISLAND_WAREHOUSE_1F, 12 ; id=5
	warp_event 30, 18, SEVII_FIVE_ISLAND_WAREHOUSE_1F, 14 ; id=6
	warp_event 24, 12, SEVII_FIVE_ISLAND_WAREHOUSE_2F, 7 ; id=7

	def_bg_events
	bg_event 23,  3, 11 ; SeviiFiveIslandWarehouse2FSignText1 ; statue
	bg_event 23,  7, 12 ; SeviiFiveIslandWarehouse2FSignText2 ; statue
	bg_event 13, 16, 13 ; SeviiFiveIslandWarehouse2FSignText1 ; door 1
	bg_event 13, 17, 14 ; SeviiFiveIslandWarehouse2FSignText2 ; door 1
	bg_event  5,  6, 15 ; SeviiFiveIslandWarehouse2FSignText1 ; door 4
	bg_event  5,  7, 16 ; SeviiFiveIslandWarehouse2FSignText2 ; door 4

	def_object_events
	object_event 10,  6, SPRITE_CARR, STAY, LEFT, 1
	object_event 22,  5, SPRITE_PINK, WALK, UP_DOWN, 2
	object_event 11,  1, SPRITE_PINK, STAY, DOWN, 3 ; north
	object_event 11, 10, SPRITE_PINK, STAY, UP, 4 ; south
	object_event 26, 19, SPRITE_ROCKET, STAY, ANY_DIR, 5, OPP_ROCKET, 59
	object_event 25, 11, SPRITE_ROCKET_FAINTED, STAY, NONE, 6
	object_event 28,  3, SPRITE_POKE_BALL, STAY, NONE, 7, IRON
	object_event  8, 17, SPRITE_POKE_BALL, STAY, NONE, 8, CALCIUM
	object_event 14,  8, SPRITE_POKE_BALL, STAY, NONE, 9, CARBOS
	object_event  1, 10, SPRITE_POKE_BALL, STAY, NONE, 10, RARE_CANDY

	def_warps_to SEVII_FIVE_ISLAND_WAREHOUSE_2F
