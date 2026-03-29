Route22_Object:
	db $2c ; border block

	def_warp_events
	warp_event  8,  9, ROUTE_22_GATE, 1

	def_bg_events
	bg_event  7, 15,  5 ; Route22FrontGateText

	def_object_events
	object_event 25,  9, SPRITE_BLUE, STAY, NONE, 1 ; person
	object_event 25,  9, SPRITE_BLUE, STAY, NONE, 2 ; person
	object_event 26,  3, SPRITE_MONSTER, STAY, ANY_DIR, 3 ; new, Coin-Case Meowth
	object_event 27, 13, SPRITE_POKE_BALL, STAY, NONE, 4, SMASH_BALL

	def_warps_to ROUTE_22
