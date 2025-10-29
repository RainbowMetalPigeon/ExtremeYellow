SeviiSevenIslandCity_Object:
	db $43 ; border block

	def_warp_events
	warp_event 14, 15, SEVII_SEVEN_ISLAND_DOCK, 1
	warp_event 15, 15, SEVII_SEVEN_ISLAND_DOCK, 1
	warp_event 13,  3, SEVII_SEVEN_ISLAND_POKEMON_CENTER_AND_MART, 1
	warp_event  5,  7, SEVII_SEVEN_ISLAND_POKEMON_CENTER_AND_MART, 3
	warp_event 13,  7, SEVII_SEVEN_ISLAND_HOUSES, 1

	def_bg_events
	bg_event 11, 10, 3 ; SeviiSevenIslandCitySignText1
	bg_event  5, 13, 4 ; SeviiSevenIslandCitySignText2
	bg_event 11,  7, 5 ; SeviiSevenIslandCitySignText3
	bg_event 14,  3, 6 ; PokeCenterSignText
	bg_event  6,  7, 7 ; MartSignText

	def_object_events
	object_event 10,  4, SPRITE_GENTLEMAN, WALK, UP_DOWN, 1
	object_event  8,  9, SPRITE_ERIKA, WALK, LEFT_RIGHT, 2

	def_warps_to SEVII_SEVEN_ISLAND_CITY
