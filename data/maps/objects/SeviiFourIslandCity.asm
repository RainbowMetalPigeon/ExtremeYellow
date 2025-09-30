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
;	bg_event  5, 65, 4 ; Route2Text3
;	bg_event 11, 11, 5 ; Route2Text4

	def_object_events
	object_event  7, 25, SPRITE_COOLTRAINER_F, WALK, ANY_DIR, 1
	object_event 18, 29, SPRITE_COOLTRAINER_F, WALK, ANY_DIR, 2
	object_event 29, 26, SPRITE_COOLTRAINER_F, WALK, LEFT_RIGHT, 3
	object_event  4, 16, SPRITE_COOLTRAINER_F, STAY, LEFT, 4
	object_event 12, 21, SPRITE_COOLTRAINER_F, WALK, LEFT_RIGHT, 5
	object_event  9, 11, SPRITE_COOLTRAINER_F, WALK, UP_DOWN, 6
	object_event 18, 15, SPRITE_COOLTRAINER_F, STAY, ANY_DIR, 7

	object_event 32, 33, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 8
	object_event 33, 33, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 9

	def_warps_to SEVII_FOUR_ISLAND_CITY