Route7_Object:
	db $f ; border block

	def_warp_events
	warp_event 18,  9, ROUTE_7_GATE, 3
	warp_event 18, 10, ROUTE_7_GATE, 3
	warp_event 11,  9, ROUTE_7_GATE, 1
	warp_event 11, 10, ROUTE_7_GATE, 1
	warp_event  5, 13, UNDERGROUND_PATH_ROUTE_7, 1

	def_bg_events
	bg_event  3, 13, 2 ; Route7Text1

	def_object_events
	object_event 16, 15, SPRITE_POKE_BALL, STAY, NONE, 1, LINK_CABLE ; new

	def_warps_to ROUTE_7
