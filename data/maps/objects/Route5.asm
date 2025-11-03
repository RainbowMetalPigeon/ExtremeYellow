Route5_Object:
	db $a ; border block

	def_warp_events
	warp_event 30, 29, ROUTE_5_GATE, 3
	warp_event 29, 29, ROUTE_5_GATE, 3
	warp_event 30, 33, ROUTE_5_GATE, 1
	warp_event 37, 27, UNDERGROUND_PATH_ROUTE_5, 1
	warp_event 30, 21, DAYCARE, 1

	def_bg_events
	bg_event 37, 29, 6 ; Route5Text6

	def_object_events
	object_event  8, 22, SPRITE_HIKER, STAY, ANY_DIR, 1 ; Climb Clumb invitation guy
	object_event  5, 23, SPRITE_HIKER, WALK, ANY_DIR, 2
	object_event  6, 18, SPRITE_HIKER, STAY, RIGHT, 3
	object_event 12, 12, SPRITE_HIKER, STAY, RIGHT, 4
	object_event  9, 13, SPRITE_HIKER, STAY, DOWN, 5

	def_warps_to ROUTE_5
