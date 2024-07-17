Route28_Object:
	db $43 ; border block

	def_warp_events

	def_bg_events

	def_object_events
	; Rockets
	object_event  5,  7, SPRITE_ROCKET, STAY, RIGHT, 1
	object_event  5,  8, SPRITE_ROCKET, STAY, RIGHT, 2
	object_event  5,  9, SPRITE_ROCKET, STAY, RIGHT, 3
	object_event  5, 10, SPRITE_ROCKET, STAY, RIGHT, 4
	; Citizens
	object_event 17, 14, SPRITE_COOLTRAINER_F, STAY, UP, 5
	object_event  9,  3, SPRITE_FISHER, STAY, RIGHT, 6, OPP_FISHER, 12
	object_event  7,  2, SPRITE_COOLTRAINER_M, STAY, DOWN, 7, OPP_BIRD_KEEPER, 22
	object_event 15, 14, SPRITE_COOLTRAINER_M, STAY, UP, 8, OPP_SWIMMER, 18

	def_warps_to ROUTE_28
