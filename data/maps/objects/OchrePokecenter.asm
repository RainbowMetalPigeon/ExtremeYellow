OchrePokecenter_Object:
	db $0 ; border block

	def_warp_events
	warp_event  3,  7, OCHRE_CITY, 4
	warp_event  4,  7, OCHRE_CITY, 4
	warp_event 23,  7, OCHRE_CITY, 3
	warp_event 24,  7, OCHRE_CITY, 3

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_NURSE, STAY, DOWN, 1 ; fixed
	object_event 10,  5, SPRITE_COOLTRAINER_F, STAY, NONE, 2 ; custom
	object_event  5,  4, SPRITE_SAILOR, STAY, NONE, 3 ; custom
	object_event 11,  2, SPRITE_LINK_RECEPTIONIST, STAY, DOWN, 4 ; fixed
	object_event  4,  1, SPRITE_CHANSEY, STAY, DOWN, 5 ; fixed
	; mart
	object_event 20,  5, SPRITE_CLERK, STAY, RIGHT, 6 ; fixed
	object_event 25,  6, SPRITE_SUPER_NERD, STAY, NONE, 7 ; custom
	object_event 23,  3, SPRITE_GIRL, WALK, LEFT_RIGHT, 8 ; custom

	def_warps_to OCHRE_POKECENTER
