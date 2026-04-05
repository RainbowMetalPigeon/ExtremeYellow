SeviiUndergroundOne_Object:
	db $03 ; border block

	def_warp_events
	warp_event  3,  7, SEVII_ROUTE_32, 1
	warp_event 70,  4, SEVII_UNDERGROUND_LOBBY, 1

	def_bg_events
	bg_event 67,  6,  1
	bg_event 67,  7,  2

	def_object_events

	def_warps_to SEVII_UNDERGROUND_ONE
