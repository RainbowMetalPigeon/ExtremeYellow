SeviiFourIslandCityDive_Object:
	db $08 ; border block

	def_warp_events
	warp_event 20, 23, SEVII_FOUR_ISLAND_CITY_DIVE_CAVERN, 1

	def_bg_events
;	bg_event  5, 27, 14 ; SeviiTwoIslandCitySignText1

	def_object_events
	object_event 32, 27, SPRITE_DIVER, STAY, RIGHT, 1, OPP_DIVER, 30
	object_event 29, 14, SPRITE_DIVER, STAY, DOWN, 2, OPP_DIVER, 31
	object_event 22, 11, SPRITE_DIVER, STAY, UP, 3, OPP_COOLTRAINER, 100
	object_event 14,  4, SPRITE_DIVER, STAY, LEFT, 4, OPP_DIVER, 32

	def_warps_to SEVII_FOUR_ISLAND_CITY_DIVE
