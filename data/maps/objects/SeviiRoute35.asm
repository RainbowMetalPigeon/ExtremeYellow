SeviiRoute35_Object:
	db $43 ; border block

	def_warp_events
	warp_event 29,  9, SEVII_RESORT_GORGEOUS, 1
	warp_event 44, 11, SEVII_LOST_CAVE_1, 7

	def_bg_events
	bg_event 31, 13, 3 ; SeviiRoute35Text3
	bg_event  7,  9, 4 ; SeviiRoute35Text4

	def_object_events
	object_event  8, 10, SPRITE_HIKER, STAY, UP, 1, OPP_HIKER, 19
	object_event  2,  2, SPRITE_POKE_BALL, STAY, NONE, 2, ULTRA_BALL

	def_warps_to SEVII_ROUTE_35
	