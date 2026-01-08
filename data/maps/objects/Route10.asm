Route10_Object:
	db $2c ; border block

	def_warp_events
	warp_event 11, 19, ROCK_TUNNEL_POKECENTER, 1
	warp_event  8, 17, ROCK_TUNNEL_1F, 1
	warp_event  8, 53, ROCK_TUNNEL_1F, 3
	warp_event  6, 37, POWER_PLANT, 1 ; edited
	warp_event  7, 51, ROCK_TUNNEL_1F, 9 ; new

	def_bg_events
	bg_event  7, 19, 7 ; Route10Text7
	bg_event 12, 19, 8 ; PokeCenterSignText
	bg_event  9, 55, 9 ; Route10Text9
	bg_event  5, 39, 10 ; Route10Text10 ; edited

	def_object_events
	object_event 10, 42, SPRITE_SUPER_NERD, STAY, LEFT, 1, OPP_POKEMANIAC, 1 ; edited
	object_event  3, 57, SPRITE_HIKER, STAY, UP, 2, OPP_HIKER, 7
	object_event 14, 64, SPRITE_SUPER_NERD, STAY, LEFT, 3, OPP_POKEMANIAC, 2
	object_event  7, 25, SPRITE_COOLTRAINER_F, STAY, LEFT, 4, OPP_JR_TRAINER, 7
	object_event  3, 61, SPRITE_HIKER, STAY, DOWN, 5, OPP_HIKER, 8
	object_event  7, 54, SPRITE_COOLTRAINER_F, STAY, DOWN, 6, OPP_JR_TRAINER, 8

	def_warps_to ROUTE_10
