SeviiRoute38DiveCavern_Object:
	db $20 ; border block

	def_warp_events
	warp_event  4, 27, SEVII_ROUTE_38_DIVE, 1
	warp_event  5, 27, SEVII_ROUTE_38_DIVE, 1

	def_bg_events
;	bg_event  5, 27, 14 ; SeviiTwoIslandCitySignText1

	def_object_events
;	object_event  6, 20, SPRITE_DIVER, STAY, LEFT, 1, OPP_DIVER, 13
;	object_event 24,  6, SPRITE_DIVER, STAY, UP, 2, OPP_DIVER, 14
;	object_event  7,  4, SPRITE_DIVER, STAY, DOWN, 3, OPP_DIVER, 15
;	object_event 22, 21, SPRITE_DIVER, STAY, RIGHT, 4, OPP_DIVER, 16
	object_event  4,  2, SPRITE_POKE_BALL, STAY, NONE, 11, PEARL

	def_warps_to SEVII_ROUTE_38_DIVE_CAVERN
