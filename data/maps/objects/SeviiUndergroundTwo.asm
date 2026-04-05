SeviiUndergroundTwo_Object:
	db $03 ; border block

	def_warp_events
	warp_event  1,  1, SEVII_TWO_ISLAND_CITY, 8
	warp_event 22, 30, SEVII_UNDERGROUND_LOBBY, 2

	def_bg_events
	bg_event 19, 28,  1
	bg_event 19, 29,  2

	def_object_events

	def_warps_to SEVII_UNDERGROUND_TWO
