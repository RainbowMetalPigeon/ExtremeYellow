SeviiFourIslandPokemonCenterAndMart_Object:
	db $0 ; border block

	def_warp_events
	warp_event  3,  7, SEVII_FOUR_ISLAND_CITY, 3
	warp_event  4,  7, SEVII_FOUR_ISLAND_CITY, 3
	warp_event 17,  7, SEVII_FOUR_ISLAND_CITY, 4
	warp_event 18,  7, SEVII_FOUR_ISLAND_CITY, 4

	def_bg_events

	def_object_events
	; Center sprites
	object_event  3,  1, SPRITE_NURSE, STAY, DOWN, 1
	object_event  4,  1, SPRITE_CHANSEY, STAY, DOWN, 2
	object_event  1,  5, SPRITE_SUPER_NERD, WALK, ANY_DIR, 3
	object_event  5,  4, SPRITE_COOLTRAINER_F, STAY, DOWN, 4
	; Mart sprites
	object_event 14,  5, SPRITE_CLERK, STAY, RIGHT, 5
	object_event 14,  6, SPRITE_CLERK, STAY, RIGHT, 6
	object_event 19,  6, SPRITE_COOLTRAINER_M, WALK, UP_DOWN, 7
	object_event 18,  2, SPRITE_COOLTRAINER_F, WALK, LEFT_RIGHT, 8

	def_warps_to SEVII_FOUR_ISLAND_POKEMON_CENTER_AND_MART
