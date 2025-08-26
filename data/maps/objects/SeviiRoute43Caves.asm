SeviiRoute43Caves_Object:
	db $03 ; border block

	def_warp_events
	warp_event  6, 13, SEVII_ROUTE_43, 1
	warp_event  7, 13, SEVII_ROUTE_43, 1
	warp_event  3, 46, SEVII_ROUTE_43, 2
	warp_event  3, 47, SEVII_ROUTE_43, 2
	warp_event  0, 38, SEVII_ROUTE_43, 3
	warp_event  0, 39, SEVII_ROUTE_43, 3
	warp_event  0, 30, SEVII_ROUTE_43, 4
	warp_event  0, 31, SEVII_ROUTE_43, 4
	warp_event  0, 18, SEVII_ROUTE_43, 5
	warp_event  0, 19, SEVII_ROUTE_43, 5

	def_bg_events

	def_object_events
	object_event  6,  4, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 1
	object_event  7,  4, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 2
	object_event  8,  4, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 3
	object_event  5,  8, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 4
	object_event  8,  8, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 5
	object_event  5,  9, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 6
	object_event  8,  9, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 7

	def_warps_to SEVII_ROUTE_43_CAVES
