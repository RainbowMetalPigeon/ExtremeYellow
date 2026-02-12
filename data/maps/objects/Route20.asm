Route20_Object:
	db $43 ; border block

	def_warp_events
	warp_event 48,  5, SEAFOAM_ISLANDS_1F, 1
	warp_event 58,  9, SEAFOAM_ISLANDS_1F, 3

	def_bg_events
	bg_event 51,  7, 13 ; Route20Text11
	bg_event 57, 11, 14 ; Route20Text12

	def_object_events
	object_event 61,  4, SPRITE_MISTY, STAY, ANY_DIR, 1 ; new
	object_event 87,  8, SPRITE_SWIMMER, STAY, UP, 2, OPP_SWIMMER, 9
	object_event 68, 11, SPRITE_SWIMMER, STAY, UP, 3, OPP_BEAUTY, 15
	object_event 45, 10, SPRITE_SWIMMER, STAY, DOWN, 4, OPP_BEAUTY, 6
	object_event 55, 14, SPRITE_SWIMMER, STAY, RIGHT, 5, OPP_JR_TRAINER, 24
	object_event 38, 13, SPRITE_SWIMMER, STAY, DOWN, 6, OPP_SWIMMER, 10
	object_event 87, 13, SPRITE_SWIMMER, STAY, UP, 7, OPP_SWIMMER, 11
	object_event 34,  9, SPRITE_COOLTRAINER_M, STAY, UP, 8, OPP_BIRD_KEEPER, 11
	object_event 25,  7, SPRITE_SWIMMER, STAY, UP, 9, OPP_BEAUTY, 7
	object_event 24, 12, SPRITE_SWIMMER, STAY, DOWN, 10, OPP_JR_TRAINER, 16
	object_event 15,  8, SPRITE_SWIMMER, STAY, UP, 11, OPP_BEAUTY, 8
	object_event 48,  6, SPRITE_COOLTRAINER_M, STAY, ANY_DIR, 12 ; new, special birdkeeper

	def_warps_to ROUTE_20
