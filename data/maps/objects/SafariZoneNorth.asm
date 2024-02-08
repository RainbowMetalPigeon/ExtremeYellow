SafariZoneNorth_Object:
	db $0 ; border block

	def_warp_events
	warp_event  2, 35, SAFARI_ZONE_WEST, 1
	warp_event  3, 35, SAFARI_ZONE_WEST, 2
	warp_event  8, 35, SAFARI_ZONE_WEST, 3
	warp_event  9, 35, SAFARI_ZONE_WEST, 4
	warp_event 20, 35, SAFARI_ZONE_CENTER, 5
	warp_event 21, 35, SAFARI_ZONE_CENTER, 6
	warp_event 39, 30, SAFARI_ZONE_EAST, 1
	warp_event 39, 31, SAFARI_ZONE_EAST, 2
	warp_event 35,  3, SAFARI_ZONE_QUADRUPLE_REST_HOUSE, 7 ; edited because of MERGING

	def_bg_events
	bg_event 36,  4, 4 ; SafariZoneNorthText3
	bg_event  4, 25, 5 ; SafariZoneNorthText4
	bg_event 13, 31, 6 ; SafariZoneNorthText5
	bg_event 19, 33, 7 ; SafariZoneNorthText6
	bg_event 26, 28, 8 ; SafariZoneNorthText7

	def_object_events
	object_event 26, 15, SPRITE_GIOVANNI, STAY, ANY_DIR, 1, OPP_GIOVANNI, 5 ; new, testing
	object_event 25,  1, SPRITE_POKE_BALL, STAY, NONE, 2, PROTEIN
	object_event 19,  7, SPRITE_POKE_BALL, STAY, NONE, 3, TM_OUTRAGE

	def_warps_to SAFARI_ZONE_NORTH
