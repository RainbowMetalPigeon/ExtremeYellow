ObsidianMines_Object:
	db $7D ; border block

	def_warp_events
	warp_event 28, 59, OBSIDIAN_ISLAND, 9
	warp_event 29, 59, OBSIDIAN_ISLAND, 9

	def_bg_events
;	bg_event xx, yy, nn ; sign

	def_object_events
	object_event 39, 30, SPRITE_HIKER, STAY, DOWN, 1, OPP_HIKER, 16 ; 28, 57
	object_event 48, 12, SPRITE_HIKER, STAY, LEFT, 2 ; relax
	object_event 28, 57, SPRITE_HIKER, WALK, ANY_DIR, 3 ; panic, escape rope ; 39, 30

	object_event 49, 27, SPRITE_POKE_BALL, STAY, NONE, 4, MOON_STONE
	object_event 51, 34, SPRITE_POKE_BALL, STAY, NONE, 5, FIRE_STONE
	object_event  7, 29, SPRITE_POKE_BALL, STAY, NONE, 6, THUNDER_STONE
	object_event 14, 41, SPRITE_POKE_BALL, STAY, NONE, 7, WATER_STONE
	object_event 25, 49, SPRITE_POKE_BALL, STAY, NONE, 8, LEAF_STONE
	object_event 44, 53, SPRITE_POKE_BALL, STAY, NONE, 9, SUN_STONE	
	object_event 55, 54, SPRITE_POKE_BALL, STAY, NONE, 10, ICE_STONE

	def_warps_to OBSIDIAN_MINES
