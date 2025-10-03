SeviiSixIslandCity_Object:
	db $43 ; border block

	def_warp_events
	warp_event  8, 15, SEVII_SIX_ISLAND_DOCK, 1
	warp_event  9, 15, SEVII_SIX_ISLAND_DOCK, 1
	warp_event  5,  5, SEVII_SIX_ISLAND_POKEMON_CENTER_AND_MART, 1
	warp_event 11,  5, SEVII_SIX_ISLAND_POKEMON_CENTER_AND_MART, 3
	warp_event 16, 11, SEVII_SIX_ISLAND_GYM_1, 1

	def_bg_events
	bg_event  9,  9,  4 ; SeviiSixIslandCitySignText1
	bg_event 15, 13,  5 ; SeviiSixIslandCitySignText2
	bg_event 17,  5,  6 ; SeviiSixIslandCitySignText3
	bg_event  6,  5,  7 ; PokeCenterSignText
	bg_event 12,  5,  8 ; MartSignText

	def_object_events
	object_event  7, 10, SPRITE_BEAUTY, WALK, UP_DOWN, 1
	object_event  9,  7, SPRITE_BRUNETTE_GIRL, WALK, LEFT_RIGHT, 2
	object_event 15,  6, SPRITE_HIKER, STAY, RIGHT, 3

	def_warps_to SEVII_SIX_ISLAND_CITY