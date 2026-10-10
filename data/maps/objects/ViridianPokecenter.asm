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
	bg_event 22,  1, 11 ; ViridianPokeCenter_VillaSignText1
	bg_event 41,  4, 12 ; ViridianPokeCenter_VillaSignText2
	bg_event 48,  2, 13 ; ViridianPokeCenter_VillaSignText3
	bg_event 62,  1, 14 ; ViridianPokeCenter_VillaSignText4

	def_object_events
	object_event  3,  1, SPRITE_NURSE, STAY, DOWN, 1 ; person
	object_event 10,  5, SPRITE_GENTLEMAN, WALK, UP_DOWN, 2 ; person
	object_event  4,  3, SPRITE_COOLTRAINER_M, STAY, UP, 3 ; person
	object_event 11,  2, SPRITE_LINK_RECEPTIONIST, STAY, DOWN, 4 ; person
	object_event  4,  1, SPRITE_CHANSEY, STAY, DOWN, 5 ; person
	object_event  6,  5, SPRITE_GIRL, WALK, LEFT_RIGHT, 6 ; person
	object_event  8,  3, SPRITE_COOLTRAINER_M, STAY, DOWN, 7 ; new
	; villa
	object_event 26,  3, SPRITE_ROCKSMASHABLE_ROCK, STAY, ROCKSMASHABLE_ROCK_MOVEMENT_BYTE_2, 8
	object_event 53,  4, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 9
	object_event 62,  6, SPRITE_GENTLEMAN, STAY, DOWN, 10

	def_warps_to VIRIDIAN_POKECENTER
