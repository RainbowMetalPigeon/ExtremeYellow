SeviiFiveIslandCityDive_Object:
	db $08 ; border block

	def_warp_events
	warp_event 20, 23, SEVII_FIVE_ISLAND_CITY_DIVE_CAVERN, 1

	def_bg_events
;	bg_event  5, 27, 14 ; SeviiTwoIslandCitySignText1

	def_object_events
	object_event 36,  3, SPRITE_DIVER, STAY, ANY_DIR, 1, OPP_DIVER, 33
	object_event 32, 32, SPRITE_DIVER, STAY, ANY_DIR, 2, OPP_DIVER, 34
	object_event 11, 28, SPRITE_DIVER, STAY, ANY_DIR, 3, OPP_COOLTRAINER, 101
	object_event 15, 15, SPRITE_DIVER, STAY, ANY_DIR, 4, OPP_DIVER, 35

	def_warps_to SEVII_FIVE_ISLAND_CITY_DIVE
