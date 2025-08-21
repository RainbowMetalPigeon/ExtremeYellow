MrPsychicsHouse_Object:
	db $a ; border block

	def_warp_events
	warp_event  2,  7, LAST_MAP, 8
	warp_event  3,  7, LAST_MAP, 8
	; poly pidgey house
	warp_event 16,  7, LAST_MAP, 4
	warp_event 17,  7, LAST_MAP, 4

	def_bg_events

	def_object_events
	object_event  5,  3, SPRITE_FISHING_GURU, STAY, LEFT, 1 ; person
	object_event  2,  3, SPRITE_SABRINA, STAY, RIGHT, 2 ; new, Sabrina 
	; poly pidgey house
	object_event 16,  3, SPRITE_BRUNETTE_GIRL, STAY, RIGHT, 3 ; person
	object_event 14,  4, SPRITE_BIRD, WALK, UP_DOWN, 4 ; person
	object_event 18,  1, SPRITE_COOLTRAINER_M, STAY, DOWN, 5 ; person, edited
	object_event 17,  3, SPRITE_PAPER, STAY, NONE, 6 ; person

	def_warps_to MR_PSYCHICS_HOUSE
