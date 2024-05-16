SaffronPokecenter_Object:
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
	object_event  5,  5, SPRITE_BEAUTY, STAY, NONE, 2 ; person
	object_event  8,  3, SPRITE_GENTLEMAN, STAY, DOWN, 3 ; person
	object_event 11,  2, SPRITE_LINK_RECEPTIONIST, STAY, DOWN, 4 ; person
	object_event  4,  1, SPRITE_CHANSEY, STAY, DOWN, 5 ; person
	; from Mart, +20 in x
	object_event 20,  5, SPRITE_CLERK, STAY, RIGHT, 6 ; person
	object_event 24,  2, SPRITE_SUPER_NERD, STAY, NONE, 7 ; person
	object_event 26,  5, SPRITE_COOLTRAINER_F, WALK, ANY_DIR, 8 ; person
	object_event 20,  6, SPRITE_CLERK, STAY, RIGHT, 9 ; new, TM seller

	def_warps_to SAFFRON_POKECENTER
