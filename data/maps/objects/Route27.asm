Route27_Object:
	db $43 ; border block

	def_warp_events

	def_bg_events

	def_object_events
	object_event  8,  4, SPRITE_FISHER, STAY, LEFT, 1
	object_event  9, 10, SPRITE_YOUNGSTER, WALK, LEFT_RIGHT, 2
	object_event 12, 20, SPRITE_COOLTRAINER_F, WALK, ANY_DIR, 3
	object_event 11, 14, SPRITE_COOLTRAINER_M, STAY, RIGHT, 4, OPP_ENGINEER, 4
	object_event 11,  6, SPRITE_COOLTRAINER_F, WALK, UP_DOWN, 5, OPP_COOLTRAINER, 77
	object_event 10, 23, SPRITE_COOLTRAINER_M, WALK, ANY_DIR, 6, OPP_ROCKER, 3

	def_warps_to ROUTE_27
