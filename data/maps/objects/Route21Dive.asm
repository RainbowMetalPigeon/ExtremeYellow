Route21Dive_Object:
	db $08 ; border block

	def_warp_events
	warp_event  8, 29, SUNKEN_SHIP_1F, 23
	warp_event  4, 85, ROUTE_21_DIVE_CAVERN, 1

	def_bg_events

	def_object_events
	object_event  5, 31, SPRITE_DIVER, WALK, LEFT_RIGHT, 1
	object_event  5, 38, SPRITE_DIVER, STAY, LEFT, 2, OPP_DIVER, 36 ; semi-mandatory
	object_event 14, 36, SPRITE_DIVER, STAY, RIGHT, 3, OPP_DIVER, 37 ; semi-mandatory
	object_event 14, 22, SPRITE_DIVER, STAY, RIGHT, 4, OPP_DIVER, 38 ; mandatory
	object_event  7, 67, SPRITE_DIVER, STAY, UP, 5, OPP_DIVER, 39
	object_event 11, 62, SPRITE_DIVER, STAY, DOWN, 6, OPP_DIVER, 40 ; mandatory
	object_event  6, 73, SPRITE_DIVER, STAY, ANY_DIR, 7, OPP_DIVER, 41 ; 6x MAGIKARP
	object_event 17, 70, SPRITE_DIVER, STAY, LEFT, 8, OPP_COOLTRAINER, 104 ; mandatory

	def_warps_to ROUTE_21_DIVE
