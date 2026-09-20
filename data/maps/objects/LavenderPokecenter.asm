LavenderPokecenter_Object:
	db $0 ; border block

	def_warp_events
	warp_event  3,  7, LAST_MAP, 1
	warp_event  4,  7, LAST_MAP, 1
	; from Mart, +20 in x
	warp_event 23,  7, LAST_MAP, 4
	warp_event 24,  7, LAST_MAP, 4

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_NURSE, STAY, DOWN, 1 ; person
	object_event  5,  3, SPRITE_GENTLEMAN, STAY, NONE, 2 ; person
	object_event 10,  5, SPRITE_LITTLE_GIRL, WALK, LEFT_RIGHT, 3 ; person
	object_event 11,  2, SPRITE_LINK_RECEPTIONIST, STAY, DOWN, 4 ; person
	object_event  4,  1, SPRITE_CHANSEY, STAY, DOWN, 5 ; person
	; from Mart, +20 in x
	object_event 20,  5, SPRITE_CLERK, STAY, RIGHT, 6 ; person
	object_event 23,  4, SPRITE_BALDING_GUY, STAY, NONE, 7 ; person
	object_event 27,  2, SPRITE_COOLTRAINER_M, STAY, NONE, 8 ; person

	def_warps_to LAVENDER_POKECENTER
