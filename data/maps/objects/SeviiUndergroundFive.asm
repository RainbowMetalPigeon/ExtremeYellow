SeviiUndergroundFive_Object:
	db $03 ; border block

	def_warp_events
	warp_event  1, 30, SEVII_ROUTE_34, 1
	warp_event 14,  1, SEVII_UNDERGROUND_LOBBY, 5

	def_bg_events
	bg_event 13,  0,  1
	bg_event 13,  1,  2

	def_object_events

	def_warps_to SEVII_UNDERGROUND_FIVE
