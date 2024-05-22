Route26_Object:
	db $2c ; border block

	def_warp_events
	warp_event 50, 17, ONIX_BURROWING, 1
	warp_event 53,  3, ONIX_BURROWING, 5 ; SNORLAX_DEN

	def_bg_events
	bg_event 13, 55, 7 ; welcome
	bg_event 49, 19, 8 ; burrowing

	def_object_events
	object_event 18, 35, SPRITE_HIKER, STAY, ANY_DIR, 1
	object_event 15, 22, SPRITE_HIKER, STAY, ANY_DIR, 2
	object_event 20, 16, SPRITE_HIKER, STAY, ANY_DIR, 3
	object_event 41,  6, SPRITE_HIKER, STAY, ANY_DIR, 4
	object_event 51, 18, SPRITE_HIKER, STAY, LEFT, 5, OPP_HIKER, 15
	object_event 54,  6, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 6

	def_warps_to ROUTE_26
