Route21_Object:
	db $43 ; border block

	def_warp_events

	def_bg_events

	def_object_events
	object_event 11,  6, SPRITE_OAK, WALK, ANY_DIR, 1 ; new
	object_event  4, 18, SPRITE_FISHER, STAY, LEFT, 2, OPP_FISHER, 7
	object_event  6, 19, SPRITE_FISHER, STAY, DOWN, 3, OPP_FISHER, 9
	object_event  8, 25, SPRITE_SWIMMER, STAY, UP, 4, OPP_SWIMMER, 12
	object_event 11, 27, SPRITE_SWIMMER, STAY, RIGHT, 5, OPP_CUE_BALL, 9
	object_event 17, 61, SPRITE_SWIMMER, STAY, LEFT, 6, OPP_SWIMMER, 13
	object_event  5, 71, SPRITE_SWIMMER, STAY, LEFT, 7, OPP_SWIMMER, 14
	object_event 11, 77, SPRITE_SWIMMER, STAY, RIGHT, 8, OPP_SWIMMER, 15
	object_event 14, 56, SPRITE_FISHER, STAY, LEFT, 9, OPP_FISHER, 8
	object_event 17, 57, SPRITE_FISHER, STAY, RIGHT, 10, OPP_FISHER, 10

	def_warps_to ROUTE_21
