SeviiRoute39_Object:
	db $43 ; border block

	def_warp_events
	warp_event 23, 50, SEVII_PATTERN_BUSH, 3
	warp_event 11,  7, SEVII_ALTERING_CAVE, 1

	def_bg_events
	bg_event 23, 51, 14 ; SeviiRoute39SignText1

	def_object_events
	object_event 12,  9, SPRITE_HIKER, STAY, UP, 1
	object_event 19, 47, SPRITE_ERIKA, WALK, LEFT_RIGHT, 2
	; trainers
	object_event  6, 48, SPRITE_SUPER_NERD, STAY, RIGHT, 3, OPP_POKEMANIAC, 11
	object_event 19, 16, SPRITE_SUPER_NERD, STAY, DOWN, 4, OPP_POKEMANIAC, 12
	object_event  8, 43, SPRITE_SWIMMER, STAY, ANY_DIR, 5, OPP_SWIMMER, 34
	object_event  6, 33, SPRITE_SWIMMER, STAY, ANY_DIR, 6, OPP_SWIMMER, 35
	object_event 16, 34, SPRITE_SWIMMER, STAY, ANY_DIR, 7, OPP_SWIMMER, 36
	object_event 13, 19, SPRITE_SWIMMER, STAY, ANY_DIR, 8, OPP_SWIMMER, 37
	; non-persons
	object_event  4,  8, SPRITE_POKE_BALL, STAY, NONE,  9, PP_UP
	object_event  5, 49, SPRITE_POKE_BALL, STAY, NONE, 10, POTION
	object_event 21,  2, SPRITE_POKE_BALL, STAY, NONE, 11, NUGGET
	object_event 18, 17, SPRITE_POKE_BALL, STAY, NONE, 12, POKE_BALL
	object_event  3,  4, SPRITE_COOLTRAINER_F, STAY, DOWN, 13
;	object_event 11, 46, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, nn

	def_warps_to SEVII_ROUTE_39