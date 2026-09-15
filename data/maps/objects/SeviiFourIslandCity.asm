SeviiFourIslandCity_Object:
	db $43 ; border block

	def_warp_events
	warp_event 10, 37, SEVII_FOUR_ISLAND_DOCK, 1
	warp_event 11, 37, SEVII_FOUR_ISLAND_DOCK, 1
	warp_event 17, 21, SEVII_FOUR_ISLAND_POKEMON_CENTER_AND_MART, 1
	warp_event 23, 27, SEVII_FOUR_ISLAND_POKEMON_CENTER_AND_MART, 3
	warp_event 18, 11, SEVII_FOUR_ISLAND_GYM, 1
	warp_event 31, 25, SEVII_FOUR_ISLAND_HOUSES, 1
	warp_event 25, 17, SEVII_FOUR_ISLAND_HOUSES, 5
	warp_event 27, 29, SEVII_FOUR_ISLAND_HOUSES, 7
	warp_event 33, 15, SEVII_ICEFALL_CAVE_1F, 1 ;  9
	warp_event 39, 35, SEVII_ICEFALL_CAVE_1F, 3 ; 10
	warp_event 37,  9, SEVII_ICEFALL_CAVE_2F, 2 ; 11
	warp_event 32,  7, SEVII_UNDERGROUND_FOUR, 1 ; 12
	warp_event 13, 25, SEVII_FOUR_ISLAND_HOUSES, 10 ; 13

	def_bg_events
	bg_event 18, 26, 15 ; SeviiFourIslandCitySignText1
	bg_event 17, 13, 16 ; SeviiFourIslandCitySignText2
	bg_event 29, 25, 17 ; SeviiFourIslandCitySignText3
	bg_event 36, 16, 18 ; SeviiFourIslandCitySignText4
	bg_event 18, 21, 19 ; PokeCenterSignText
	bg_event 24, 27, 20 ; MartSignText

	def_object_events
	object_event 18, 12, SPRITE_PINK, STAY, UP, 1
	object_event 11, 29, SPRITE_GIRL, WALK, ANY_DIR, 2
	object_event 22, 33, SPRITE_YOUNGSTER, WALK, ANY_DIR, 3
	object_event 33, 30, SPRITE_MIDDLE_AGED_WOMAN, WALK, LEFT_RIGHT, 4
	object_event  8, 20, SPRITE_SAILOR, STAY, LEFT, 5
	object_event 16, 25, SPRITE_MIDDLE_AGED_MAN, WALK, LEFT_RIGHT, 6
	object_event 13, 15, SPRITE_COOLTRAINER_F, WALK, UP_DOWN, 7
	object_event 22, 19, SPRITE_COOLTRAINER_M, STAY, ANY_DIR, 8
	; non-persons
	object_event 31, 37, SPRITE_ROCKSMASHABLE_ROCK, STAY, ROCKSMASHABLE_ROCK_MOVEMENT_BYTE_2, 9
	object_event 32, 38, SPRITE_POKE_BALL, STAY, NONE, 10, IRON
	object_event  9,  8, SPRITE_POKE_BALL, STAY, NONE, 11, RARE_CANDY
	object_event 39, 11, SPRITE_POKE_BALL, STAY, NONE, 12, PP_UP
	object_event  9, 12, SPRITE_POKE_BALL, STAY, NONE, 13, MAX_ELIXER
	object_event 32,  8, SPRITE_COOLTRAINER_F, STAY, DOWN, 14

	def_warps_to SEVII_FOUR_ISLAND_CITY
