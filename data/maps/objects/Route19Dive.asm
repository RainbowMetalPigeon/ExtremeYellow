Route19Dive_Object:
	db $08 ; border block

	def_warp_events
	warp_event 16,  5, ROUTE_19_DIVE_CAVERN, 1

	def_bg_events

	def_object_events
	object_event  9, 42, SPRITE_DIVER, STAY, UP, 1, OPP_DIVER, 7

	def_warps_to ROUTE_19_DIVE
