ViridianSchoolHouse_Object:
	db $a ; border block

	def_warp_events
	warp_event  2,  7, LAST_MAP, 3
	warp_event  3,  7, LAST_MAP, 3
	; new
	warp_event 18,  7, VIRIDIAN_CITY, 10
	warp_event 19,  7, VIRIDIAN_CITY, 10
	warp_event 23,  1, VIRIDIAN_SCHOOL_HOUSE, 6
	warp_event 36,  1, VIRIDIAN_SCHOOL_HOUSE, 5

	def_bg_events
	bg_event 19,  4, 14
	bg_event 20,  1, 15
	bg_event 33,  5, 16
	bg_event 30,  1, 17
	bg_event 32,  0, 18
	bg_event 33,  0, 19
	bg_event 30,  7, 20

	def_object_events
	object_event  3,  5, SPRITE_BRUNETTE_GIRL, STAY, UP, 1 ; person
	object_event  4,  1, SPRITE_COOLTRAINER_F, STAY, DOWN, 2 ; person
	object_event  4,  5, SPRITE_LITTLE_GIRL, STAY, UP, 3 ; person
	object_event  0,  1, SPRITE_GAMEBOY_KID, STAY, RIGHT, 4 ; new
	object_event  1,  1, SPRITE_GAMEBOY_KID, STAY, LEFT, 5 ; new
	object_event  8,  2, SPRITE_SUPER_NERD, STAY, UP, 6 ; new
	object_event  7,  4, SPRITE_LITTLE_BOY, STAY, RIGHT, 7 ; new
	object_event  8,  4, SPRITE_LITTLE_GIRL, STAY, LEFT, 8 ; new
	object_event  7,  7, SPRITE_COOLTRAINER_F, STAY, UP, 9 ; new
	; new
	object_event 18,  4, SPRITE_BRUNETTE_GIRL, STAY, RIGHT, 10
	object_event 21,  3, SPRITE_SUPER_NERD, STAY, LEFT, 11
	object_event 20,  3, SPRITE_CLIPBOARD, STAY, NONE, 12
	object_event 34,  3, SPRITE_COOLTRAINER_F, WALK, LEFT_RIGHT, 13

	def_warps_to VIRIDIAN_SCHOOL_HOUSE
