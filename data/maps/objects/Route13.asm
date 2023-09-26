Route13_Object:
	db $43 ; border block

	def_warp_events

	def_bg_events
	bg_event  3, 11, 11 ; Route13Text11
	bg_event 25,  7, 12 ; Route13Text12
	bg_event 37,  7, 13 ; Route13Text13

	def_object_events
	object_event 40,  3, SPRITE_COOLTRAINER_M, STAY, DOWN, 1, OPP_BIRD_KEEPER, 1
	object_event 41,  7, SPRITE_COOLTRAINER_F, STAY, UP, 2, OPP_JR_TRAINER, 12
	object_event 32,  9, SPRITE_COOLTRAINER_F, STAY, DOWN, 3, OPP_JR_TRAINER, 13
	object_event 23,  6, SPRITE_COOLTRAINER_F, STAY, RIGHT, 4, OPP_JR_TRAINER, 14
	object_event 33,  9, SPRITE_COOLTRAINER_F, STAY, UP, 5, OPP_JR_TRAINER, 15
	object_event 19,  8, SPRITE_COOLTRAINER_M, STAY, DOWN, 6, OPP_BIRD_KEEPER, 2
	object_event 14,  5, SPRITE_BEAUTY, STAY, RIGHT, 7, OPP_BEAUTY, 4
	object_event 20,  4, SPRITE_BEAUTY, STAY, RIGHT, 8, OPP_BEAUTY, 5
	object_event 39, 11, SPRITE_BIKER, STAY, LEFT, 9, OPP_BIKER, 1
	object_event  5,  6, SPRITE_COOLTRAINER_M, STAY, LEFT, 10, OPP_BIRD_KEEPER, 3

	def_warps_to ROUTE_13
