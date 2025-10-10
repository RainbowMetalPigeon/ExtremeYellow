SeviiTwoIslandCity_Object:
	db $43 ; border block

	def_warp_events
	warp_event  6, 33, SEVII_TWO_ISLAND_DOCK, 1
	warp_event  7, 33, SEVII_TWO_ISLAND_DOCK, 1
	warp_event 15, 29, SEVII_TWO_ISLAND_POKEMON_CENTER, 1
	warp_event 30,  7, SEVII_TWO_ISLAND_GYM, 1
	warp_event 11, 27, SEVII_TWO_ISLAND_HOUSES, 1
	warp_event 29, 33, SEVII_TWO_ISLAND_HOUSES, 3
	warp_event 33, 33, SEVII_TWO_ISLAND_HOUSES, 5

	def_bg_events
	bg_event  5, 27, 14 ; SeviiTwoIslandCitySignText1
	bg_event 23, 31, 15 ; SeviiTwoIslandCitySignText2
	bg_event 33, 35, 16 ; SeviiTwoIslandCitySignText3
	bg_event 32, 12, 17 ; SeviiTwoIslandCitySignText4
	bg_event 16, 29, 18 ; PokeCenterSignText

	def_object_events
	object_event  7, 27, SPRITE_GRANNY, STAY, ANY_DIR, 1
	object_event 18, 32, SPRITE_COOLTRAINER_F, WALK, ANY_DIR, 2
	object_event 30, 28, SPRITE_COOLTRAINER_F, WALK, LEFT_RIGHT, 3 ; TBE?
	object_event 20, 17, SPRITE_HIKER, STAY, ANY_DIR, 4
	object_event 22, 28, SPRITE_GRANNY, STAY, DOWN, 5
	object_event 23, 28, SPRITE_GRAMPS, STAY, DOWN, 6
	object_event 24, 34, SPRITE_SUPER_NERD, WALK, LEFT_RIGHT, 7
	object_event  8, 10, SPRITE_BIKER, STAY, LEFT, 8
	object_event 36, 28, SPRITE_TAUROS, WALK, ANY_DIR, 9
	object_event 37, 33, SPRITE_TAUROS, WALK, ANY_DIR, 10
	object_event 15,  8, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 11
	object_event 18,  3, SPRITE_POKE_BALL, STAY, NONE, 12, PROTEIN
	object_event 16, 19, SPRITE_POKE_BALL, STAY, NONE, 13, NUGGET
	; TBE? One more sprite?

	def_warps_to SEVII_TWO_ISLAND_CITY