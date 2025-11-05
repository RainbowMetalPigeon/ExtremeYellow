Route19Dive_Object:
	db $08 ; border block

	def_warp_events
;	warp_event  5,  9, SUMMER_BEACH_HOUSE, 1

	def_bg_events
;	bg_event 11, 11, 11 ; Route19Text11

	def_object_events
;	object_event  9, 42, SPRITE_SWIMMER, STAY, UP, 9, OPP_SWIMMER, 8

	def_warps_to ROUTE_19_DIVE
