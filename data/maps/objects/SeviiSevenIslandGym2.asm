SeviiSevenIslandGym2_Object:
	db $0f ; border block

	def_warp_events
	warp_event  9,  5, SEVII_SEVEN_ISLAND_GYM_1, 3
	warp_event 34, 29, SEVII_SEVEN_ISLAND_GYM_3, 1

	def_bg_events

	def_object_events
	object_event  5, 26, SPRITE_COOLTRAINER_F, STAY, RIGHT, 1, OPP_COOLTRAINER, 78
	object_event  5, 30, SPRITE_ROCKER, STAY, LEFT, 2, OPP_ROCKER, 4
	object_event 24, 22, SPRITE_SAILOR, STAY, RIGHT, 3, OPP_SAILOR, 9
	object_event 24, 23, SPRITE_SUPER_NERD, STAY, RIGHT, 4, OPP_ENGINEER, 5
	object_event 34,  4, SPRITE_SWIMMER, STAY, DOWN, 5, OPP_SWIMMER, 23
	object_event 27, 26, SPRITE_SUPER_NERD, STAY, RIGHT, 6, OPP_POKEMANIAC, 10 ; 3
	object_event 24, 10, SPRITE_COOLTRAINER_F, STAY, UP, 7, OPP_COOLTRAINER, 79 ; 4
	; rocks
	object_event 29, 16, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 8
	object_event 23, 19, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 9
	; items
	object_event  4, 35, SPRITE_POKE_BALL, STAY, NONE, 10, MASTER_BALL
	object_event 13, 34, SPRITE_POKE_BALL, STAY, NONE, 11, REVIVE
	object_event 34, 25, SPRITE_POKE_BALL, STAY, NONE, 12, HYPER_POTION
	object_event 22, 24, SPRITE_POKE_BALL, STAY, NONE, 13, MAX_ELIXER
	object_event 20, 16, SPRITE_POKE_BALL, STAY, NONE, 14, FULL_HEAL

	def_warps_to SEVII_SEVEN_ISLAND_GYM_2
