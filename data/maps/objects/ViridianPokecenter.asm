ViridianPokecenter_Object:
	db $0 ; border block

	def_warp_events
	warp_event  3,  7, LAST_MAP, 1
	warp_event  4,  7, LAST_MAP, 1
	; villa, 1F
	warp_event 23,  7, VIRIDIAN_CITY, 9 ; 3
	warp_event 24,  7, VIRIDIAN_CITY, 9 ; 4
	warp_event 26,  0, VIRIDIAN_POKECENTER, 6 ; 5
	; villa, 2F
	warp_event 40,  0, VIRIDIAN_POKECENTER, 5 ; 6
	warp_event 35,  0, VIRIDIAN_POKECENTER, 8 ; 7
	; villa, 3F
	warp_event 49,  0, VIRIDIAN_POKECENTER, 7 ; 8
	warp_event 54,  0, VIRIDIAN_POKECENTER, 10 ; 9
	; villa, 4F
	warp_event 68,  0, VIRIDIAN_POKECENTER, 9 ; 10

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_NURSE, STAY, DOWN, 1 ; person
	object_event 10,  5, SPRITE_GENTLEMAN, WALK, UP_DOWN, 2 ; person
	object_event  4,  3, SPRITE_COOLTRAINER_M, STAY, UP, 3 ; person
	object_event 11,  2, SPRITE_LINK_RECEPTIONIST, STAY, DOWN, 4 ; person
	object_event  4,  1, SPRITE_CHANSEY, STAY, DOWN, 5 ; person
	object_event  6,  5, SPRITE_GIRL, WALK, LEFT_RIGHT, 6 ; person

	def_warps_to VIRIDIAN_POKECENTER
