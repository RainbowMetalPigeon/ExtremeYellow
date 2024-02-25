Route29_Object:
	db $43 ; border block

	def_warp_events

	def_bg_events
	bg_event 13, 55,  3 ; Route29TextIceOrbRecess
	bg_event 15, 55,  4 ; Route29TextThunderOrbRecess
	bg_event 17, 55,  5 ; Route29TextFireOrbRecess

	def_object_events
	object_event 17,  9, SPRITE_COOLTRAINER_F, STAY, DOWN, 1, OPP_COOLTRAINER, 1 ; testing, TBE
	object_event 15, 58, SPRITE_SLOWKING, STAY, DOWN, 2

	def_warps_to ROUTE_29
