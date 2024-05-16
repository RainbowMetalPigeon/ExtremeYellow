CeruleanPokecenter_Object:
	db $0 ; border block

	def_warp_events
	warp_event  3,  7, LAST_MAP, 3
	warp_event  4,  7, LAST_MAP, 3
	; from Mart, +20 in x
	warp_event 23,  7, LAST_MAP, 6
	warp_event 24,  7, LAST_MAP, 6

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_NURSE, STAY, DOWN, 1 ; person
	object_event 10,  5, SPRITE_SUPER_NERD, WALK, ANY_DIR, 2 ; person
	object_event  4,  3, SPRITE_GENTLEMAN, STAY, UP, 3 ; person
	object_event 11,  2, SPRITE_LINK_RECEPTIONIST, STAY, DOWN, 4 ; person
	object_event  4,  1, SPRITE_CHANSEY, STAY, DOWN, 5 ; person
	; from Mart, +20 in x
	object_event 20,  5, SPRITE_CLERK, STAY, RIGHT, 6 ; person
	object_event 23,  4, SPRITE_COOLTRAINER_M, WALK, UP_DOWN, 7 ; person
	object_event 26,  2, SPRITE_COOLTRAINER_F, WALK, LEFT_RIGHT, 8 ; person
	object_event 20,  6, SPRITE_CLERK, STAY, RIGHT, 9 ; new, TM seller

	def_warps_to CERULEAN_POKECENTER
