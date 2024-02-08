SafariZoneWest_Object:
	db $0 ; border block

	def_warp_events
	warp_event 20,  0, SAFARI_ZONE_NORTH, 1
	warp_event 21,  0, SAFARI_ZONE_NORTH, 2
	warp_event 26,  0, SAFARI_ZONE_NORTH, 3
	warp_event 27,  0, SAFARI_ZONE_NORTH, 4
	warp_event 29, 22, SAFARI_ZONE_CENTER, 3
	warp_event 29, 23, SAFARI_ZONE_CENTER, 4
	warp_event  3,  3, SAFARI_ZONE_SECRET_HOUSE, 1
	warp_event 11, 11, SAFARI_ZONE_QUADRUPLE_REST_HOUSE, 3 ; edited because of MERGING

	def_bg_events
	bg_event 12, 12, 5 ; SafariZoneWestText5
;	bg_event 17,  3, 6 ; SafariZoneWestText6 ; edited: commented away
	bg_event 26,  4, 6 ; SafariZoneWestText7
	bg_event 24, 22, 7 ; SafariZoneWestText8

	def_object_events
	object_event  8, 20, SPRITE_POKE_BALL, STAY, NONE, 1, MAX_POTION
	object_event  9,  7, SPRITE_POKE_BALL, STAY, NONE, 2, TM_DOUBLE_TEAM
	object_event 18, 18, SPRITE_POKE_BALL, STAY, NONE, 3, MAX_REVIVE
	object_event 22, 12, SPRITE_POKE_BALL, STAY, NONE, 4, NUGGET ; edited: moved and changed, no longer GOLD_TEETH

	def_warps_to SAFARI_ZONE_WEST
