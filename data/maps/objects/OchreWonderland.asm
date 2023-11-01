OchreWonderland_Object:
	db $3 ; border block

	def_warp_events
	warp_event  2, 59, OCHRE_CITY, 9
	warp_event  3, 59, OCHRE_CITY, 9
	warp_event  3, 55, OCHRE_WONDERLAND, 4
	warp_event 18, 40, OCHRE_WONDERLAND, 3

	def_bg_events
	bg_event  5, 57, 11 ; OchreWonderland_Sign1
	bg_event 47, 41, 12 ; OchreWonderland_Sign2

	def_object_events
	object_event  9,  4, SPRITE_BLUE, STAY, DOWN, 1

	object_event 19, 41, SPRITE_POKE_BALL, STAY, NONE, 2, POKE_BALL
	object_event 18, 21, SPRITE_POKE_BALL, STAY, NONE, 3, LEAF_STONE
	object_event 30,  8, SPRITE_POKE_BALL, STAY, NONE, 4, MOON_STONE
	object_event 45,  8, SPRITE_POKE_BALL, STAY, NONE, 5, WATER_STONE
	object_event 51,  2, SPRITE_POKE_BALL, STAY, NONE, 6 ; EEVEE
	object_event 43, 34, SPRITE_POKE_BALL, STAY, NONE, 7, THUNDER_STONE
	object_event 34, 42, SPRITE_POKE_BALL, STAY, NONE, 8, NUGGET
	object_event 26, 56, SPRITE_POKE_BALL, STAY, NONE, 9, ICE_STONE
	object_event 18, 57, SPRITE_POKE_BALL, STAY, NONE, 10, FIRE_STONE

	def_warps_to OCHRE_WONDERLAND
