SeviiRoute40_Object:
	db $2c ; border block

	def_warp_events
	warp_event 24, 21, SEVII_DOTTED_HOLE, 1

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
	object_event 51,  5, SPRITE_HIKER, STAY, LEFT, 1
	; trainers
	object_event 43, 10, SPRITE_SUPER_NERD, STAY, UP, 2, OPP_ENGINEER, 6
	object_event 20,  4, SPRITE_SUPER_NERD, STAY, RIGHT, 3, OPP_ENGINEER, 7
	object_event  3, 16, SPRITE_SUPER_NERD, STAY, ANY_DIR, 4, OPP_ENGINEER, 8
	object_event 32,  2, SPRITE_SUPER_NERD, STAY, DOWN, 5, OPP_ROCKER, 13
	object_event 10,  4, SPRITE_SUPER_NERD, STAY, DOWN, 6, OPP_POKEMANIAC, 13
	object_event  7, 21, SPRITE_SUPER_NERD, STAY, LEFT_RIGHT, 7, OPP_POKEMANIAC, 14
	object_event  9,  6, SPRITE_COOLTRAINER_F, STAY, UP, 8, OPP_COOLTRAINER, 89
	object_event  9, 18, SPRITE_HIKER, STAY, LEFT, 9, OPP_HIKER, 21
	; non-persons
	object_event 21, 14, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 10
	object_event 48, 24, SPRITE_POKE_BALL, STAY, NONE, 11, PP_UP
	object_event 49, 24, SPRITE_POKE_BALL, STAY, NONE, 12, BIG_NUGGET
	object_event 48, 25, SPRITE_POKE_BALL, STAY, NONE, 13, METAL_COAT
	object_event 49, 25, SPRITE_POKE_BALL, STAY, NONE, 14, RARE_CANDY

	def_warps_to SEVII_ROUTE_40