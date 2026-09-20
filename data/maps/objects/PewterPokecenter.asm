PewterPokecenter_Object:
	db $0 ; border block

	def_warp_events
	warp_event  3,  7, LAST_MAP, 7
	warp_event  4,  7, LAST_MAP, 7
	; from Mart, +20 in x
	warp_event 23,  7, LAST_MAP, 5
	warp_event 24,  7, LAST_MAP, 5

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_NURSE, STAY, DOWN, 1 ; person
	object_event 11,  7, SPRITE_GENTLEMAN, STAY, LEFT, 2 ; person
	object_event  1,  3, SPRITE_JIGGLYPUFF, STAY, DOWN, 3 ; person
	object_event 11,  2, SPRITE_LINK_RECEPTIONIST, STAY, DOWN, 4 ; person
	object_event  4,  3, SPRITE_COOLTRAINER_F, STAY, UP, 5 ; person
	object_event  4,  1, SPRITE_CHANSEY, STAY, DOWN, 6 ; person
	; from Mart, +20 in x
	object_event 20,  5, SPRITE_CLERK, STAY, RIGHT, 7 ; person
	object_event 23,  3, SPRITE_YOUNGSTER, WALK, UP_DOWN, 8 ; person
	object_event 25,  5, SPRITE_COOLTRAINER_F, STAY, NONE, 9 ; person ; edited sprite

	def_warps_to PEWTER_POKECENTER
