SeviiUndergroundSeven_Object:
	db $03 ; border block

	def_warp_events
	warp_event  1, 70, SEVII_ROUTE_42, 1
	warp_event 38,  1, SEVII_UNDERGROUND_LOBBY, 7

	def_bg_events
	bg_event 35,  0,  1
	bg_event 35,  1,  2

	def_object_events

	def_warps_to SEVII_UNDERGROUND_SEVEN
