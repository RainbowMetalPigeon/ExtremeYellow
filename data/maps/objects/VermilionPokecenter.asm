VermilionPokecenter_Object:
	db $0 ; border block

	def_warp_events
	warp_event  3,  7, LAST_MAP, 1
	warp_event  4,  7, LAST_MAP, 1
	; from Mart, +20 in x
	warp_event 23,  7, LAST_MAP, 3
	warp_event 24,  7, LAST_MAP, 3

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_NURSE, STAY, DOWN, 1 ; person
	object_event 10,  5, SPRITE_FISHING_GURU, STAY, NONE, 2 ; person
	object_event  5,  4, SPRITE_SAILOR, STAY, NONE, 3 ; person
	object_event 11,  2, SPRITE_LINK_RECEPTIONIST, STAY, DOWN, 4 ; person
	object_event  4,  1, SPRITE_CHANSEY, STAY, DOWN, 5 ; person
	; from Mart, +20 in x
	object_event 20,  5, SPRITE_CLERK, STAY, RIGHT, 6 ; person
	object_event 25,  6, SPRITE_COOLTRAINER_M, STAY, NONE, 7 ; person
	object_event 23,  3, SPRITE_COOLTRAINER_F, WALK, LEFT_RIGHT, 8 ; person

	def_warps_to VERMILION_POKECENTER
