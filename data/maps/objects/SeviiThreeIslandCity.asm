SeviiThreeIslandCity_Object:
	db $43 ; border block

	def_warp_events
	warp_event 10, 45, SEVII_THREE_ISLAND_DOCK, 1
	warp_event 11, 45, SEVII_THREE_ISLAND_DOCK, 1
	warp_event 15, 23, SEVII_THREE_ISLAND_POKEMON_CENTER_AND_MART, 1
	warp_event 19,  9, SEVII_THREE_ISLAND_POKEMON_CENTER_AND_MART, 3
	warp_event 12,  7, SEVII_THREE_ISLAND_GYM, 1
	warp_event 15, 15, SEVII_THREE_ISLAND_HOUSES, 1
	warp_event  5, 25, SEVII_THREE_ISLAND_HOUSES, 3
	warp_event 14, 35, SEVII_THREE_ISLAND_CAVES, 1
	warp_event 22, 35, SEVII_THREE_ISLAND_CAVES, 3
	warp_event 19, 33, SEVII_THREE_ISLAND_CAVES, 5

	def_bg_events
	bg_event 15, 37, 12 ; SeviiThreeIslandCitySignText1
	bg_event 11, 27, 13 ; SeviiThreeIslandCitySignText2
	bg_event 11,  9, 14 ; SeviiThreeIslandCitySignText3
	bg_event  1,  9, 15 ; SeviiThreeIslandCitySignText4
	bg_event 16, 23, 16 ; PokeCenterSignText
	bg_event 20,  9, 17 ; MartSignText

	def_object_events
	object_event  6, 39, SPRITE_FISHER, STAY, DOWN, 1
	object_event  9, 31, SPRITE_BRUNETTE_GIRL, WALK, UP_DOWN, 2
	object_event 10, 25, SPRITE_SUPER_NERD, WALK, ANY_DIR, 3
	object_event 12, 18, SPRITE_MIDDLE_AGED_WOMAN, WALK, LEFT_RIGHT, 4
	object_event 20, 13, SPRITE_GAMBLER, WALK, UP_DOWN, 5
	object_event 14, 11, SPRITE_BRUNETTE_GIRL, WALK, ANY_DIR, 6
	object_event  5,  8, SPRITE_COOLTRAINER_F, STAY, LEFT, 7
	object_event 21,  5, SPRITE_LITTLE_GIRL, WALK, LEFT_RIGHT, 8 ; playing seek
	object_event 26,  4, SPRITE_LITTLE_GIRL, STAY, RIGHT, 9 ; playing hide
	object_event 24, 38, SPRITE_POKE_BALL, STAY, NONE, 10, ULTRA_BALL
	object_event 22, 29, SPRITE_POKE_BALL, STAY, NONE, 11, CARBOS

	def_warps_to SEVII_THREE_ISLAND_CITY