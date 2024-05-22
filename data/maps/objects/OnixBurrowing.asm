OnixBurrowing_Object:
	db $03 ; border block

	def_warp_events
	warp_event  2, 51, ROUTE_26, 1
	warp_event  3, 51, ROUTE_26, 1
	warp_event  2, 48, ONIX_BURROWING, 4
	warp_event  5,  5, ONIX_BURROWING, 3
	warp_event 40, 13, ROUTE_26, 2
	warp_event 41, 13, ROUTE_26, 2
	warp_event 45, 43, SECLUDED_CAVES, 3

	def_bg_events

	def_object_events
	object_event 27, 26, SPRITE_POKE_BALL, STAY, NONE, 1, TM_BODY_PRESS
	object_event 41,  8, SPRITE_SNORLAX, STAY, DOWN, 2, SNORLAX, 45 | OW_POKEMON ; edited, to go beyond 200

	def_warps_to ONIX_BURROWING
