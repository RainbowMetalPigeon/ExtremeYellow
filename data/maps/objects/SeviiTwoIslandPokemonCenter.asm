SeviiTwoIslandPokemonCenter_Object:
	db $0 ; border block

	def_warp_events
	warp_event  3,  7, SEVII_TWO_ISLAND_CITY, 3
	warp_event  4,  7, SEVII_TWO_ISLAND_CITY, 3

	def_bg_events

	def_object_events
	; Center sprites
	object_event  3,  1, SPRITE_NURSE, STAY, DOWN, 1
	object_event  4,  1, SPRITE_CHANSEY, STAY, DOWN, 2
	object_event  1,  5, SPRITE_SUPER_NERD, WALK, ANY_DIR, 3
	object_event  5,  4, SPRITE_COOLTRAINER_F, STAY, DOWN, 4

	def_warps_to SEVII_TWO_ISLAND_POKEMON_CENTER
