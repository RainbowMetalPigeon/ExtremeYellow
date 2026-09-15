SeviiSixIslandCity_Object:
	db $43 ; border block

	def_warp_events
	warp_event  8, 15, SEVII_SIX_ISLAND_DOCK, 1
	warp_event  9, 15, SEVII_SIX_ISLAND_DOCK, 1
	warp_event  5,  5, SEVII_SIX_ISLAND_POKEMON_CENTER_AND_MART, 1
	warp_event 11,  5, SEVII_SIX_ISLAND_POKEMON_CENTER_AND_MART, 3
	warp_event 16, 11, SEVII_SIX_ISLAND_GYM_1, 1
	warp_event 15,  5, SEVII_SIX_ISLAND_HOUSES, 1

	def_bg_events
	bg_event  9,  9,  5 ; SeviiSixIslandCitySignText1
	bg_event 15, 13,  6 ; SeviiSixIslandCitySignText2
	bg_event 18,  7,  7 ; SeviiSixIslandCitySignText3
	bg_event  6,  5,  8 ; PokeCenterSignText
	bg_event 12,  5,  9 ; MartSignText

	def_object_events
	object_event  7, 10, SPRITE_BEAUTY, WALK, LEFT_RIGHT, 1
	object_event 10,  8, SPRITE_BRUNETTE_GIRL, WALK, UP_DOWN, 2
	object_event 13,  7, SPRITE_HIKER, STAY, RIGHT, 3
	object_event 19,  6, SPRITE_PINK, STAY, LEFT, 4

	def_warps_to SEVII_SIX_ISLAND_CITY