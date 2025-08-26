SeviiRoute34_Object:
	db $43 ; border block

	def_warp_events

	def_bg_events

	def_object_events
	object_event 10,  9, SPRITE_GRAMPS, STAY, ANY_DIR, 1 ; Amulet Coin gifter
	object_event 37, 16, SPRITE_SWIMMER, STAY, RIGHT, 2, OPP_SWIMMER, 19
	object_event 47,  2, SPRITE_SWIMMER, STAY, LEFT, 3, OPP_SWIMMER, 20
	object_event 25,  7, SPRITE_SWIMMER, STAY, DOWN, 4, OPP_SWIMMER, 21
	object_event 16,  7, SPRITE_SWIMMER, STAY, UP, 5, OPP_SWIMMER, 22

	def_warps_to SEVII_ROUTE_34