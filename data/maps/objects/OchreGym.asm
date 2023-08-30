OchreGym_Object:
	db $3 ; border block

	def_warp_events
	warp_event 14, 33, OCHRE_CITY, 6
	warp_event 15, 33, OCHRE_CITY, 6
	warp_event 14, 26, OCHRE_GYM, 4
	warp_event 25,  2, OCHRE_GYM, 3

	def_bg_events
	bg_event 13, 31, 9 ; gym statue
	bg_event 16, 31, 10 ; gym statue
	bg_event  7, 29, 11 ; trash bin
	bg_event  9, 29, 12 ; trash bin
	bg_event  7, 31, 13 ; trash bin
	bg_event  9, 31, 14 ; trash bin

	def_object_events
	object_event 13, 12, SPRITE_COOLTRAINER_F, STAY, DOWN, 1, OPP_ORAGE, 1 ; to be edited: OW sprite
	object_event 18,  6, SPRITE_SUPER_NERD, STAY, DOWN, 2, OPP_ROCKER, 3
	object_event 17, 10, SPRITE_COOLTRAINER_M, STAY, RIGHT, 3, OPP_BIRD_KEEPER, 18
	object_event 15, 13, SPRITE_CHANNELER, STAY, DOWN, 4, OPP_CHANNELER, 25
	object_event 11, 13, SPRITE_YOUNGSTER, STAY, LEFT, 5, OPP_BUG_CATCHER, 16
	object_event 11,  6, SPRITE_SUPER_NERD, STAY, DOWN, 6, OPP_POKEMANIAC, 8
	object_event 16,  9, SPRITE_SUPER_NERD, STAY, LEFT, 7, OPP_SUPER_NERD, 12
	object_event 15, 11, SPRITE_COOLTRAINER_F, STAY, LEFT, 8, OPP_COOLTRAINER, 13

	def_warps_to OCHRE_GYM
