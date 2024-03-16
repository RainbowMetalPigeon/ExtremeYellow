LavenderHouses_Object:
	db $a ; border block

	def_warp_events
	; Fuji house
	warp_event  2,  7, LAST_MAP, 3
	warp_event  3,  7, LAST_MAP, 3
	; Cubone house, +14 on x
	warp_event 16,  7, LAST_MAP, 5
	warp_event 17,  7, LAST_MAP, 5
	; Name Rater house, +28 on x
	warp_event 30,  7, LAST_MAP, 6
	warp_event 31,  7, LAST_MAP, 6

	def_bg_events

	def_object_events
	object_event  3,  5, SPRITE_SUPER_NERD, STAY, NONE, 1 ; person
	object_event  6,  3, SPRITE_LITTLE_GIRL, STAY, DOWN, 2 ; person
	object_event  6,  4, SPRITE_MONSTER, STAY, UP, 3 ; person
	object_event  1,  3, SPRITE_MONSTER, STAY, NONE, 4 ; person
	object_event  3,  1, SPRITE_MR_FUJI, STAY, NONE, 5 ; person
	object_event  3,  3, SPRITE_POKEDEX, STAY, NONE, 6 ; person
	; Cubone house, +14 on x
	object_event 17,  5, SPRITE_CUBONE, STAY, UP, 7 ; edited
	object_event 16,  4, SPRITE_BRUNETTE_GIRL, STAY, RIGHT, 8 ; person
	; Name Rater house, +28 on x
	object_event 33,  3, SPRITE_SILPH_PRESIDENT, STAY, LEFT, 9 ; person

	def_warps_to LAVENDER_HOUSES
