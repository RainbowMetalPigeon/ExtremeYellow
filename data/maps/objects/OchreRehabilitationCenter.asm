OchreRehabilitationCenter_Object:
	db $c ; border block

	def_warp_events
	warp_event  4,  0, OCHRE_CITY, 10
	warp_event  4,  7, OCHRE_CITY, 8
	warp_event  5,  7, OCHRE_CITY, 8

	def_bg_events
	bg_event  9,  3,  6 ; book

	def_object_events
	object_event  9,  1, SPRITE_FISHING_GURU, STAY, DOWN, 1 ; person
	object_event  3,  4, SPRITE_COOLTRAINER_F, WALK, ANY_DIR, 2 ; person
	object_event  8,  6, SPRITE_BRUNETTE_GIRL, STAY, RIGHT, 3 ; person
	object_event 11,  7, SPRITE_BIRD, STAY, RIGHT, 4 ; wounded birb
	object_event  5,  6, SPRITE_FISHING_GURU, STAY, DOWN, 5 ; copy of the boss, generally hidden

	def_warps_to OCHRE_REHABILITATION_CENTER
