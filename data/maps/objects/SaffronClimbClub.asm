SaffronClimbClub_Object:
	db $3 ; border block

	def_warp_events
	warp_event  8, 19, SAFFRON_CITY, 9
	warp_event  9, 19, SAFFRON_CITY, 9

	def_bg_events

	def_object_events
	object_event  8, 17, SPRITE_GUARD, STAY, DOWN, 1
	object_event  7, 14, SPRITE_HIKER, WALK, ANY_DIR, 2
	object_event 17, 15, SPRITE_HIKER, WALK, ANY_DIR, 3
	object_event 28, 14, SPRITE_HIKER, WALK, ANY_DIR, 4
	object_event  2,  2, SPRITE_HIKER, STAY, RIGHT, 5
	object_event  5,  9, SPRITE_POKE_BALL, STAY, NONE, 6, POKE_BALL
	object_event 13,  8, SPRITE_POKE_BALL, STAY, NONE, 7, GREAT_BALL
	object_event 27,  4, SPRITE_POKE_BALL, STAY, NONE, 8, ULTRA_BALL

	def_warps_to SAFFRON_CLIMB_CLUB
