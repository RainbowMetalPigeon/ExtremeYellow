SeviiFiveIslandCity_Object:
	db $43 ; border block

	def_warp_events
	warp_event  8, 21, SEVII_FIVE_ISLAND_DOCK, 1
	warp_event  9, 21, SEVII_FIVE_ISLAND_DOCK, 1
	warp_event 13, 13, SEVII_FIVE_ISLAND_POKEMON_CENTER_AND_MART, 1
	warp_event 17, 15, SEVII_FIVE_ISLAND_POKEMON_CENTER_AND_MART, 3
	warp_event 14,  7, SEVII_FIVE_ISLAND_GYM, 1
	warp_event  9, 11, SEVII_FIVE_ISLAND_HOUSES, 1
	warp_event 30, 25, SEVII_FIVE_ISLAND_WAREHOUSE, 1

	def_bg_events
	bg_event  9, 15, 14 ; SeviiFourIslandCitySignText1
	bg_event  7,  7, 15 ; SeviiFourIslandCitySignText2
	bg_event 21, 13, 16 ; SeviiFourIslandCitySignText3
	bg_event 31, 27, 17 ; SeviiFourIslandCitySignText4
	bg_event 12,  8, 18 ; SeviiFourIslandCitySignText5
	bg_event 14, 13, 19 ; PokeCenterSignText
	bg_event 18, 15, 20 ; MartSignText

	def_object_events
	object_event  7, 14, SPRITE_GIRL, WALK, ANY_DIR, 1
	object_event 22, 15, SPRITE_COOLTRAINER_F, STAY, ANY_DIR, 2
	object_event  6,  9, SPRITE_LITTLE_GIRL, WALK, LEFT_RIGHT, 3
	object_event 30, 26, SPRITE_ROCKET, STAY, DOWN, 4
	object_event 30, 27, SPRITE_PINK, STAY, UP, 5
	; trainers
	object_event 36, 16, SPRITE_SUPER_NERD, STAY, LEFT, 6, OPP_ROCKER, 5
	object_event 27, 18, SPRITE_SUPER_NERD, STAY, LEFT, 7, OPP_ROCKER, 7  ; mandatory
	object_event 21, 31, SPRITE_SUPER_NERD, STAY, RIGHT, 8, OPP_ROCKER, 8 ; mandatory
	object_event 28, 34, SPRITE_SUPER_NERD, STAY, RIGHT, 9, OPP_ROCKER, 6
	; non-persons
	object_event  5, 29, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 10
	object_event 20, 21, SPRITE_POKE_BALL, STAY, NONE, 11, HP_UP
	object_event 25, 34, SPRITE_POKE_BALL, STAY, NONE, 12, MAX_REVIVE
	object_event  8, 32, SPRITE_POKE_BALL, STAY, NONE, 13, MAX_ELIXER

	def_warps_to SEVII_FIVE_ISLAND_CITY