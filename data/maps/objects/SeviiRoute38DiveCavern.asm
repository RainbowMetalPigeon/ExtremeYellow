SeviiRoute38DiveCavern_Object:
	db $20 ; border block

	def_warp_events
	warp_event  4, 27, SEVII_ROUTE_38_DIVE, 1
	warp_event  5, 27, SEVII_ROUTE_38_DIVE, 1

	def_bg_events
;	bg_event  5, 27, 14 ; SeviiTwoIslandCitySignText1

	def_object_events
	object_event  3, 23, SPRITE_DIVER, STAY, RIGHT, 1, OPP_DIVER, 21
	object_event  6, 23, SPRITE_DIVER, STAY, LEFT, 2, OPP_DIVER, 22
	object_event  2, 19, SPRITE_DIVER, STAY, RIGHT, 3, OPP_DIVER, 23
	object_event  7, 19, SPRITE_DIVER, STAY, LEFT, 4, OPP_DIVER, 24
	object_event  3, 15, SPRITE_DIVER, STAY, RIGHT, 5, OPP_DIVER, 25
	object_event  6, 15, SPRITE_DIVER, STAY, LEFT, 6, OPP_DIVER, 26
	object_event  2, 11, SPRITE_DIVER, STAY, RIGHT, 7, OPP_DIVER, 27
	object_event  7, 11, SPRITE_DIVER, STAY, LEFT, 8, OPP_DIVER, 28
	object_event  3,  7, SPRITE_DIVER, STAY, RIGHT, 9, OPP_COOLTRAINER, 99
	object_event  6,  7, SPRITE_DIVER, STAY, LEFT, 10, OPP_DIVER, 29
	object_event  4,  2, SPRITE_POKE_BALL, STAY, NONE, 11, PEARL

	def_warps_to SEVII_ROUTE_38_DIVE_CAVERN
