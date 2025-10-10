SeviiRoute31_Object:
	db $43 ; border block

	def_warp_events
	warp_event 20, 17, SEVII_EMBER_SPA, 1

	def_bg_events
	bg_event 19, 19, 15 ; SeviiRoute31SignText1

	def_object_events
	object_event 21,  4, SPRITE_GIRL, STAY, UP, 1
	; trainers
	object_event 14, 73, SPRITE_YOUNGSTER, STAY, LEFT, 2, OPP_BUG_CATCHER, 18
	object_event 16, 71, SPRITE_YOUNGSTER, STAY, RIGHT, 3, OPP_YOUNGSTER, 16
	object_event 15, 68, SPRITE_COOLTRAINER_F, STAY, DOWN, 4, OPP_LASS, 20
	object_event 19, 58, SPRITE_SUPER_NERD, STAY, LEFT, 5, OPP_SUPER_NERD, 13
	object_event  8, 66, SPRITE_COOLTRAINER_F, STAY, RIGHT, 6, OPP_COOLTRAINER, 95
	object_event  4, 54, SPRITE_SUPER_NERD, STAY, DOWN, 7, OPP_SUPER_NERD, 14
	object_event  6, 37, SPRITE_COOLTRAINER_F, STAY, UP, 8, OPP_JR_TRAINER, 37
	object_event 22, 25, SPRITE_SUPER_NERD, STAY, LEFT, 9, OPP_SUPER_NERD, 15
	object_event 16, 22, SPRITE_COOLTRAINER_F, STAY, DOWN, 10, OPP_COOLTRAINER, 96
	object_event 26, 49, SPRITE_SWIMMER, STAY, RIGHT, 11, OPP_SWIMMER, 38
	; items
	object_event  6,  94, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 12
	object_event 10, 101, SPRITE_POKE_BALL, STAY, NONE, 13, RARE_CANDY
	object_event 15,  17, SPRITE_POKE_BALL, STAY, NONE, 14, PROTEIN

	def_warps_to SEVII_ROUTE_31