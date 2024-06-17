ViridianSchoolHouse_Object:
	db $a ; border block

	def_warp_events
	warp_event  2,  7, LAST_MAP, 3
	warp_event  3,  7, LAST_MAP, 3

	def_bg_events

	def_object_events
	object_event  3,  5, SPRITE_BRUNETTE_GIRL, STAY, UP, 1 ; person
	object_event  4,  1, SPRITE_COOLTRAINER_F, STAY, DOWN, 2 ; person
	object_event  4,  5, SPRITE_LITTLE_GIRL, STAY, UP, 3 ; person
	object_event  0,  1, SPRITE_GAMEBOY_KID, STAY, RIGHT, 4 ; new
	object_event  1,  1, SPRITE_GAMEBOY_KID, STAY, LEFT, 5 ; new
	object_event  8,  2, SPRITE_SUPER_NERD, STAY, UP, 6 ; new
	object_event  7,  4, SPRITE_LITTLE_BOY, STAY, RIGHT, 7 ; new
	object_event  8,  4, SPRITE_LITTLE_GIRL, STAY, LEFT, 8 ; new

	def_warps_to VIRIDIAN_SCHOOL_HOUSE
