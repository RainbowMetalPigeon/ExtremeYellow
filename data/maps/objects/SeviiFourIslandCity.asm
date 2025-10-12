SeviiFourIslandCity_Object:
	db $43 ; border block

	def_warp_events
	warp_event  6, 33, SEVII_FOUR_ISLAND_DOCK, 1
	warp_event  7, 33, SEVII_FOUR_ISLAND_DOCK, 1
	warp_event 13, 17, SEVII_FOUR_ISLAND_POKEMON_CENTER_AND_MART, 1
	warp_event 19, 23, SEVII_FOUR_ISLAND_POKEMON_CENTER_AND_MART, 3
	warp_event 14,  7, SEVII_FOUR_ISLAND_GYM, 1
	warp_event 27, 21, SEVII_FOUR_ISLAND_HOUSES, 1
	warp_event 21, 13, SEVII_FOUR_ISLAND_HOUSES, 5
	warp_event 23, 25, SEVII_FOUR_ISLAND_HOUSES, 7
	warp_event 29, 11, SEVII_ICEFALL_CAVE_1F, 1

	def_bg_events
	bg_event 10, 22, 13 ; SeviiFourIslandCitySignText1
	bg_event 13,  9, 14 ; SeviiFourIslandCitySignText2
	bg_event 25, 21, 15 ; SeviiFourIslandCitySignText3
	bg_event 32, 12, 16 ; SeviiFourIslandCitySignText4
	bg_event 14, 17, 17 ; PokeCenterSignText
	bg_event 20, 23, 18 ; MartSignText
	
	def_object_events
	object_event 14,  8, SPRITE_PINK, STAY, DOWN, 1
	object_event  7, 25, SPRITE_GIRL, WALK, ANY_DIR, 2
	object_event 18, 29, SPRITE_YOUNGSTER, WALK, ANY_DIR, 3
	object_event 29, 26, SPRITE_MIDDLE_AGED_WOMAN, WALK, LEFT_RIGHT, 4
	object_event  4, 16, SPRITE_SAILOR, STAY, LEFT, 5
	object_event 12, 21, SPRITE_MIDDLE_AGED_MAN, WALK, LEFT_RIGHT, 6
	object_event  9, 11, SPRITE_COOLTRAINER_F, WALK, UP_DOWN, 7
	object_event 18, 15, SPRITE_COOLTRAINER_M, STAY, ANY_DIR, 8
	; non-persons
	object_event 31, 33, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 9
	object_event 32, 34, SPRITE_POKE_BALL, STAY, NONE, 10, IRON
	object_event  5,  4, SPRITE_POKE_BALL, STAY, NONE, 11, RARE_CANDY
	object_event 27,  4, SPRITE_POKE_BALL, STAY, NONE, 12, PP_UP

	def_warps_to SEVII_FOUR_ISLAND_CITY