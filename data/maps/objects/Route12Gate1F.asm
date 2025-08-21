Route12Gate1F_Object:
	db $a ; border block

	def_warp_events
	warp_event  4,  0, LAST_MAP, 1
	warp_event  5,  0, LAST_MAP, 2
	warp_event  4,  7, LAST_MAP, 3
	warp_event  5,  7, LAST_MAP, 3
	warp_event  8,  6, ROUTE_12_GATE_1F, 6
	; 2F
	warp_event 23,  7, ROUTE_12_GATE_1F, 5

	def_bg_events
	; 2F
	bg_event 17,  2, 3 ; Route12GateUpstairsText2
	bg_event 22,  2, 4 ; Route12GateUpstairsText3

	def_object_events
	object_event  1,  3, SPRITE_GUARD, STAY, NONE, 1 ; person
	; 2F
	object_event 19,  4, SPRITE_BRUNETTE_GIRL, WALK, UP_DOWN, 2 ; person

	def_warps_to ROUTE_12_GATE_1F
