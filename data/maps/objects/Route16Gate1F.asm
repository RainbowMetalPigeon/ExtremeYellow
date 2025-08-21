Route16Gate1F_Object:
	db $a ; border block

	def_warp_events
	warp_event  0,  8, LAST_MAP, 1
	warp_event  0,  9, LAST_MAP, 2
	warp_event  7,  8, LAST_MAP, 3
	warp_event  7,  9, LAST_MAP, 3
	warp_event  0,  2, LAST_MAP, 5
	warp_event  0,  3, LAST_MAP, 6
	warp_event  7,  2, LAST_MAP, 7
	warp_event  7,  3, LAST_MAP, 8
	warp_event  6, 12, ROUTE_16_GATE_1F, 10
	; 2F
	warp_event  7, 25, ROUTE_16_GATE_1F, 9

	def_bg_events
	; 2F
	bg_event  1, 20, 5 ; Route16GateUpstairsText3
	bg_event  6, 20, 6 ; Route16GateUpstairsText4

	def_object_events
	object_event  4,  5, SPRITE_GUARD, STAY, DOWN, 1 ; person
	object_event  4,  3, SPRITE_GAMBLER, STAY, NONE, 2 ; person
	; 2F
	object_event  4, 20, SPRITE_LITTLE_BOY, STAY, NONE, 3 ; person
	object_event  2, 23, SPRITE_LITTLE_GIRL, WALK, LEFT_RIGHT, 4 ; person

	def_warps_to ROUTE_16_GATE_1F
