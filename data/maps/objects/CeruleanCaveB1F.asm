CeruleanCaveB1F_Object:
	db $7d ; border block

	def_warp_events
	warp_event  3,  6, CERULEAN_CAVE_1F, 9

	def_bg_events

	def_object_events
	object_event 27, 13, SPRITE_MEWTWO, STAY, DOWN, 1, MEWTWO, 70 | OW_POKEMON ; edited, to go beyond 200
	object_event 26,  1, SPRITE_POKE_BALL, STAY, NONE, 2, ULTRA_BALL
	object_event  2, 13, SPRITE_POKE_BALL, STAY, NONE, 3, ULTRA_BALL
	object_event  3, 13, SPRITE_POKE_BALL, STAY, NONE, 4, MAX_REVIVE
	object_event 15,  3, SPRITE_POKE_BALL, STAY, NONE, 5, MAX_ELIXER
	object_event 20,  1, SPRITE_TRAVELER, STAY, ANY_DIR, 6 ; new, testing traveler rematch

	def_warps_to CERULEAN_CAVE_B1F
