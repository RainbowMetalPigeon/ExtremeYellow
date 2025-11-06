Route21DiveCavern_Object:
	db $20 ; border block

	def_warp_events
	warp_event 28, 59, ROUTE_21_DIVE, 2
	warp_event 29, 59, ROUTE_21_DIVE, 2

	def_bg_events

	def_object_events
	object_event 28, 53, SPRITE_POKE_BALL, STAY, NONE, 1, PEARL

	def_warps_to ROUTE_21_DIVE_CAVERN
