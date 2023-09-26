Route14_Object:
	db $43 ; border block

	def_warp_events

	def_bg_events
	bg_event  9, 35, 11 ; Route14Text11

	def_object_events
	object_event 13,  7, SPRITE_COOLTRAINER_M, STAY, RIGHT, 1, OPP_BIRD_KEEPER, 14
	object_event 16,  7, SPRITE_COOLTRAINER_M, STAY, DOWN, 2, OPP_BIRD_KEEPER, 15
	object_event 16, 10, SPRITE_COOLTRAINER_M, STAY, LEFT, 3, OPP_BIRD_KEEPER, 16
	object_event 13, 10, SPRITE_COOLTRAINER_M, STAY, UP, 4, OPP_BIRD_KEEPER, 17
	object_event  6,  9, SPRITE_COOLTRAINER_M, STAY, LEFT, 5, OPP_BIRD_KEEPER, 4
	object_event 16, 29, SPRITE_COOLTRAINER_M, STAY, DOWN, 6, OPP_BIRD_KEEPER, 5
	object_event  6, 39, SPRITE_BIKER, STAY, UP, 7, OPP_BIKER, 13
	object_event  7, 39, SPRITE_BIKER, STAY, UP, 8, OPP_BIKER, 14
	object_event 10, 39, SPRITE_BIKER, STAY, UP, 9, OPP_BIKER, 15
	object_event 11, 39, SPRITE_BIKER, STAY, UP, 10, OPP_BIKER, 2

	def_warps_to ROUTE_14
