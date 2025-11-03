Route11Gate1F_Object:
	db $a ; border block

	def_warp_events
	warp_event  0,  4, LAST_MAP, 1
	warp_event  0,  5, LAST_MAP, 2
	warp_event  7,  4, LAST_MAP, 3
	warp_event  7,  5, LAST_MAP, 4
	warp_event  6,  8, ROUTE_11_GATE_1F, 6
	; 2F
	warp_event  7, 21, ROUTE_11_GATE_1F, 5

	def_bg_events
	; 2F
	bg_event  1, 16, 4 ; Route11GateUpstairsText3
	bg_event  6, 16, 5 ; Route11GateUpstairsText4

	def_object_events
	object_event  4,  1, SPRITE_GUARD, STAY, NONE, 1 ; person
	; 2F
	object_event  4, 16, SPRITE_YOUNGSTER, WALK, LEFT_RIGHT, 2 ; person
	object_event  2, 20, SPRITE_SCIENTIST, STAY, NONE, 3 ; person

	def_warps_to ROUTE_11_GATE_1F
