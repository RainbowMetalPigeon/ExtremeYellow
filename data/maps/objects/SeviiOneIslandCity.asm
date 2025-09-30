SeviiOneIslandCity_Object:
	db $43 ; border block

	def_warp_events
	warp_event 28, 33, SEVII_ONE_ISLAND_DOCK, 1
	warp_event 29, 33, SEVII_ONE_ISLAND_DOCK, 1
	warp_event 21, 21, SEVII_ONE_ISLAND_POKEMON_CENTER_AND_MART, 1
	warp_event 17, 21, SEVII_ONE_ISLAND_POKEMON_CENTER_AND_MART, 3
	warp_event 30,  9, SEVII_ONE_ISLAND_GYM_1, 1
	warp_event 15, 13, SEVII_ONE_ISLAND_HOUSES, 1
	warp_event 37, 15, SEVII_ONE_ISLAND_HOUSES, 3
	warp_event 37, 11, SEVII_ONE_ISLAND_HOUSES, 5

	def_bg_events
	bg_event 29, 23, 11 ; SeviiOneIslandCitySignText1
	bg_event 20, 24, 12 ; SeviiOneIslandCitySignText2
	bg_event 29, 15, 13 ; SeviiOneIslandCitySignText3
	bg_event 35, 19, 14 ; SeviiOneIslandCitySignText4
	bg_event 35, 15, 15 ; SeviiOneIslandCitySignText5
	bg_event 22, 21, 16 ; PokeCenterSignText
	bg_event 18, 21, 17 ; MartSignText

	def_object_events
	object_event 27, 22, SPRITE_SUPER_NERD, STAY, LEFT, 1 ; Celio
	object_event 26, 22, SPRITE_OFFICER_JENNY, STAY, RIGHT, 2
	object_event 20, 23, SPRITE_ERIKA, WALK, ANY_DIR, 3
	object_event 14, 18, SPRITE_YOUNGSTER, WALK, UP_DOWN, 4
	object_event 19, 15, SPRITE_GIRL, WALK, UP_DOWN, 5
	object_event 27, 15, SPRITE_COOLTRAINER_F, WALK, LEFT_RIGHT, 6
	object_event 32, 17, SPRITE_ERIKA, WALK, ANY_DIR, 7
	object_event 17, 32, SPRITE_SWIMMER, WALK, ANY_DIR, 8
	object_event 16,  6, SPRITE_POKE_BALL, STAY, NONE, 9, RARE_CANDY
	object_event 36,  4, SPRITE_POKE_BALL, STAY, NONE, 10, ETHER

	def_warps_to SEVII_ONE_ISLAND_CITY
