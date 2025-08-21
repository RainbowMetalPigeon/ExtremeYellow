Route18Gate1F_Object:
	db $a ; border block

	def_warp_events
	warp_event  0,  4, LAST_MAP, 1
	warp_event  0,  5, LAST_MAP, 2
	warp_event  7,  4, LAST_MAP, 3
	warp_event  7,  5, LAST_MAP, 4
	warp_event  6,  8, ROUTE_18_GATE_1F, 6
	; 2F
	warp_event  7, 21, ROUTE_18_GATE_1F, 5

	def_bg_events
	; 2F
	bg_event  1, 16, 3 ; Route18GateUpstairsText2
	bg_event  6, 16, 4 ; Route18GateUpstairsText3

	def_object_events
	object_event  4,  1, SPRITE_GUARD, STAY, DOWN, 1 ; person
	; 2F
	object_event  4, 16, SPRITE_COOK, WALK, LEFT_RIGHT, 2 ; person

	def_warps_to ROUTE_18_GATE_1F
