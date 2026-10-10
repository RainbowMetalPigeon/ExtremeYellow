Route1_Object:
	db $b ; border block

	def_warp_events

	def_bg_events
	bg_event  9, 45,  8 ; Route1SignText1

	def_object_events
	object_event  5, 42, SPRITE_YOUNGSTER, WALK, UP_DOWN, 1 ; person
	object_event 15, 33, SPRITE_YOUNGSTER, WALK, LEFT_RIGHT, 2 ; person
	; new
	object_event  4, 30, SPRITE_FISHER, STAY, RIGHT, 3
	object_event 13, 21, SPRITE_GIRL, WALK, ANY_DIR, 4
	object_event 10, 14, SPRITE_SWIMMER, STAY, LEFT, 5
	object_event  4,  2, SPRITE_POKE_BALL, STAY, NONE, 6, SMASH_BALL
	object_event  7,  8, SPRITE_GAMBLER, WALK, LEFT_RIGHT, 7

	def_warps_to ROUTE_1
