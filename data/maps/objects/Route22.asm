Route22_Object:
	db $2c ; border block

	def_warp_events
	warp_event  8,  9, ROUTE_22_GATE, 1
	; new, gate
	warp_event 37, 12, VIRIDIAN_NICKNAME_HOUSE, 7 ; 2
	warp_event 37, 13, VIRIDIAN_NICKNAME_HOUSE, 8 ; 3

	def_bg_events
	bg_event  7, 15,  6 ; Route22FrontGateText

	def_object_events
	object_event 25,  9, SPRITE_BLUE, STAY, NONE, 1 ; person
	object_event 25,  9, SPRITE_BLUE, STAY, NONE, 2 ; person
	object_event 26,  3, SPRITE_MONSTER, STAY, ANY_DIR, 3 ; new, Coin-Case Meowth
	object_event 27, 13, SPRITE_POKE_BALL, STAY, NONE, 4, SMASH_BALL
	object_event 21, 34, SPRITE_GIRL, STAY, DOWN, 5, SMASH_BALL

	def_warps_to ROUTE_22
