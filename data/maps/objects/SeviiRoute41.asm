SeviiRoute41_Object:
	db $43 ; border block

	def_warp_events
	warp_event 18, 11, SEVII_SEVEN_ISLAND_GYM_1, 1

	def_bg_events
	bg_event 11, 49, 2
	bg_event 17, 23, 3

	def_object_events
	object_event 22, 44, SPRITE_POKE_BALL, STAY, NONE, 1, ESCAPE_ROPE

	def_warps_to SEVII_ROUTE_41