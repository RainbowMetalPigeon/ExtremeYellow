SeviiUndergroundFour_Object:
	db $03 ; border block

	def_warp_events
	warp_event  1, 30, SEVII_FOUR_ISLAND_CITY, 12
	warp_event 54,  1, SEVII_UNDERGROUND_LOBBY, 4

	def_bg_events
	bg_event 52,  0,  1
	bg_event 52,  1,  2

	def_object_events

	def_warps_to SEVII_UNDERGROUND_FOUR
