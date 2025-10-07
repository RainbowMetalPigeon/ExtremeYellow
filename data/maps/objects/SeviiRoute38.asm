SeviiRoute38_Object:
	db $43 ; border block

	def_warp_events
	warp_event 17, 13, SEVII_ROUTE_38_HOUSES, 1
	warp_event 13,  7, SEVII_ROUTE_38_HOUSES, 3
	warp_event  8, 10, SEVII_PATTERN_BUSH, 1

	def_bg_events
	bg_event  9, 11, 8 ; SeviiRoute38SignText1

	def_object_events
	object_event 16, 17, SPRITE_COOLTRAINER_F, WALK, UP_DOWN, 1
	object_event 14, 10, SPRITE_COOLTRAINER_M, WALK, LEFT_RIGHT, 2
	object_event 22, 15, SPRITE_POKE_BALL, STAY, NONE, 3, PP_UP
	object_event 12, 19, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 4
	object_event 15, 21, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 5
	object_event 18, 22, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 6
	object_event 22, 19, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 7

	def_warps_to SEVII_ROUTE_38