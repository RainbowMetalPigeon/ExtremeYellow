SeviiUndergroundThree_Object:
	db $03 ; border block

	def_warp_events
	warp_event 54,  1, SEVII_THREE_ISLAND_CITY, 11
	warp_event  1, 22, SEVII_UNDERGROUND_LOBBY, 3

	def_bg_events
	bg_event  8, 18,  1
	bg_event  8, 19,  2

	def_object_events

	def_warps_to SEVII_UNDERGROUND_THREE
