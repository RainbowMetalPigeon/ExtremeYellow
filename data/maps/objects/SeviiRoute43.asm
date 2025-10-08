SeviiRoute43_Object:
	db $2c ; border block

	def_warp_events
	warp_event  5, 13, SEVII_ROUTE_43_CAVES, 1
	warp_event 21, 77, SEVII_ROUTE_43_CAVES, 3
	warp_event 18, 69, SEVII_ROUTE_43_CAVES, 5
	warp_event 18, 61, SEVII_ROUTE_43_CAVES, 7
	warp_event 18, 49, SEVII_ROUTE_43_CAVES, 9

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
	object_event 19, 78, SPRITE_HIKER, STAY, ANY_DIR, 1
	; trainers
	object_event 13,  4, SPRITE_YOUNGSTER, STAY, LEFT, 2, OPP_PSYCHIC_TR, 7
	object_event 13, 23, SPRITE_COOLTRAINER_F, STAY, DOWN, 3, OPP_COOLTRAINER, 92
	object_event  2, 44, SPRITE_COOLTRAINER_F, STAY, RIGHT, 4, OPP_COOLTRAINER, 93
	object_event 10, 53, SPRITE_SCIENTIST, STAY, RIGHT, 5, OPP_SCIENTIST, 15
	object_event 28, 38, SPRITE_YOUNGSTER, STAY, RIGHT, 6, OPP_PSYCHIC_TR, 8
	object_event 29, 50, SPRITE_COOLTRAINER_M, STAY, DOWN, 7, OPP_POKEMANIAC, 17
	object_event 30, 18, SPRITE_HIKER, STAY, LEFT, 8, OPP_HIKER, 25
	object_event 21,  8, SPRITE_COOLTRAINER_F, STAY, ANY_DIR, 9, OPP_COOLTRAINER, 94
	object_event  7, 29, SPRITE_SCIENTIST, STAY, RIGHT, 10, OPP_SCIENTIST, 16
	object_event 12, 39, SPRITE_YOUNGSTER, STAY, RIGHT, 11, OPP_PSYCHIC_TR, 9
	; non-persons
	object_event  2, 20, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 12
	object_event  3, 21, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 13
	object_event 35, 13, SPRITE_POKE_BALL, STAY, NONE, 14, RARE_CANDY

	def_warps_to SEVII_ROUTE_43
