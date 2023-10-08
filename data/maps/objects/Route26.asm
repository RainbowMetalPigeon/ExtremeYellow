Route26_Object:
	db $a ; border block

	def_warp_events
	warp_event 50, 17, ONIX_BURROWING, 1
	warp_event 53,  3, REDS_HOUSE_1F, 1 ; SNORLAX_NEST

	def_bg_events
	bg_event 13, 55, 3 ; welcome
	bg_event 49, 19, 4 ; burrowing

	def_object_events
	object_event 51, 18, SPRITE_HIKER, STAY, LEFT, 1, OPP_HIKER, 15
	object_event 53,  4, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 2

	def_warps_to ROUTE_26
