Route29_Object:
	db $43 ; border block

	def_warp_events

	def_bg_events
	bg_event 13, 55, 11 ; Route29TextIceOrbRecess
	bg_event 15, 55, 12 ; Route29TextThunderOrbRecess
	bg_event 17, 55, 13 ; Route29TextFireOrbRecess

	def_object_events
	object_event 17,  9, SPRITE_COOLTRAINER_F, STAY, DOWN, 1, OPP_COOLTRAINER, 32
	object_event 17, 10, SPRITE_COOLTRAINER_F, STAY, DOWN, 2, OPP_COOLTRAINER, 33 ; TBE
	object_event 17, 11, SPRITE_COOLTRAINER_F, STAY, DOWN, 3, OPP_COOLTRAINER, 34 ; TBE
	object_event 18, 12, SPRITE_COOLTRAINER_M, STAY, DOWN, 4, OPP_BIRD_KEEPER, 20 ; TBE
	object_event 18, 13, SPRITE_COOLTRAINER_M, STAY, DOWN, 5, OPP_BIRD_KEEPER, 21 ; TBE
	object_event 19, 14, SPRITE_HIKER, STAY, DOWN, 6, OPP_HIKER, 17 ; TBE
	object_event 19, 15, SPRITE_HIKER, STAY, DOWN, 7, OPP_HIKER, 18 ; TBE
	object_event 20, 16, SPRITE_SWIMMER, STAY, DOWN, 8, OPP_SWIMMER, 16 ; TBE
	object_event 20, 17, SPRITE_SWIMMER, STAY, DOWN, 9, OPP_SWIMMER, 17 ; TBE
	object_event 15, 58, SPRITE_SLOWKING, STAY, DOWN, 10

	def_warps_to ROUTE_29
