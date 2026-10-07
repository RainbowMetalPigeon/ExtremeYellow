Route1_Object:
	db $b ; border block

	def_warp_events

	def_bg_events
	bg_event  9, 39, 6 ; Route1SignText1

	def_object_events
	object_event  5, 36, SPRITE_YOUNGSTER, WALK, UP_DOWN, 1 ; person
	object_event 15, 26, SPRITE_YOUNGSTER, WALK, LEFT_RIGHT, 2 ; person
	object_event  4, 24, SPRITE_FISHER, STAY, RIGHT, 3 ; new
	object_event 13, 15, SPRITE_GIRL, WALK, ANY_DIR, 4 ; new
	object_event 10,  8, SPRITE_SWIMMER, STAY, LEFT, 5 ; new

	def_warps_to ROUTE_1
