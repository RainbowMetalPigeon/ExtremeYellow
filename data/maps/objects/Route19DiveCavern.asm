Route19DiveCavern_Object:
	db $20 ; border block

	def_warp_events
	warp_event 10, 19, ROUTE_19_DIVE, 1
	warp_event 11, 19, ROUTE_19_DIVE, 1

	def_bg_events

	def_object_events
	object_event 15,  2, SPRITE_POKE_BALL, STAY, NONE, 1, PEARL

	def_warps_to ROUTE_19_DIVE_CAVERN
