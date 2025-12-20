Route21Dive_Object:
	db $08 ; border block

	def_warp_events
	warp_event  8, 29, SUNKEN_SHIP_1F, 23
	warp_event  4, 85, ROUTE_21_DIVE_CAVERN, 1

	def_bg_events

	def_object_events
;	object_event  4, 18, SPRITE_FISHER, STAY, LEFT, 2, OPP_FISHER, 7

	def_warps_to ROUTE_21_DIVE
