SeviiUndergroundSix_Object:
	db $03 ; border block

	def_warp_events
	warp_event 46, 30, SEVII_ROUTE_39, 3
	warp_event  1,  1, SEVII_UNDERGROUND_LOBBY, 6

	def_bg_events
	bg_event  8,  0,  1
	bg_event  8,  1,  2

	def_object_events

	def_warps_to SEVII_UNDERGROUND_SIX
