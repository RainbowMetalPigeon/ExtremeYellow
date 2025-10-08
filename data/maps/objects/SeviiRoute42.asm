SeviiRoute42_Object:
	db $2c ; border block

	def_warp_events
;	warp_event 28, 33, SEVII_ONE_ISLAND_DOCK, 1
;	warp_event 29, 33, SEVII_ONE_ISLAND_DOCK, 2

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
	object_event 12, 25, SPRITE_ERIKA, STAY, ANY_DIR, 1
	; trainers
	object_event  8, 12, SPRITE_HIKER, STAY, LEFT, 2, OPP_HIKER, 22
	object_event  9,  8, SPRITE_COOLTRAINER_F, STAY, DOWN, 3, OPP_COOLTRAINER, 90
	object_event  4, 15, SPRITE_GENTLEMAN, STAY, RIGHT, 4, OPP_GENTLEMAN, 8
	object_event  9, 19, SPRITE_HIKER, STAY, UP, 5, OPP_HIKER, 23
	object_event 16, 26, SPRITE_COOLTRAINER_F, STAY, RIGHT, 6, OPP_COOLTRAINER, 91
	object_event  8, 34, SPRITE_COOLTRAINER_M, STAY, LEFT, 7, OPP_POKEMANIAC, 15
	object_event 18, 38, SPRITE_SCIENTIST, STAY, LEFT, 8, OPP_SCIENTIST, 14
	object_event 14, 45, SPRITE_COOLTRAINER_M, STAY, DOWN, 9, OPP_POKEMANIAC, 16
	object_event 16, 56, SPRITE_HIKER, STAY, LEFT, 10, OPP_HIKER, 24
	; non-persons
;	object_event  5, 29, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 11
	object_event  7, 55, SPRITE_POKE_BALL, STAY, NONE, 11, RARE_CANDY
	object_event 10, 23, SPRITE_POKE_BALL, STAY, NONE, 12, NUGGET

	def_warps_to SEVII_ROUTE_42
