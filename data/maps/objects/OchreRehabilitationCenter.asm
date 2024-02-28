OchreRehabilitationCenter_Object:
	db $c ; border block

	def_warp_events
	warp_event  4,  0, OCHRE_CITY, 10
	warp_event  4,  7, OCHRE_CITY, 8
	warp_event  5,  7, OCHRE_CITY, 8
	; house 1
	warp_event 20,  7, OCHRE_CITY, 11
	warp_event 21,  7, OCHRE_CITY, 11
	; house 2
	warp_event 34,  7, OCHRE_CITY, 12
	warp_event 35,  7, OCHRE_CITY, 12

	def_bg_events
	bg_event  9,  3, 10 ; book1
	bg_event 33,  3, 11 ; book2

	def_object_events
	object_event  9,  1, SPRITE_FISHING_GURU, STAY, DOWN, 1 ; person
	object_event  3,  4, SPRITE_COOLTRAINER_F, WALK, ANY_DIR, 2 ; person
	object_event  8,  6, SPRITE_BRUNETTE_GIRL, STAY, RIGHT, 3 ; person
	object_event 11,  7, SPRITE_BIRD, STAY, RIGHT, 4 ; wounded birb
	object_event  5,  6, SPRITE_FISHING_GURU, STAY, DOWN, 5 ; copy of the boss, generally hidden
	; house 1
	object_event 22,  4, SPRITE_COOLTRAINER_F, WALK, ANY_DIR, 6 ; battle enthusiast
	; house 2
	object_event 33,  1, SPRITE_GENTLEMAN, STAY, DOWN, 7 ; parent
	object_event 37,  4, SPRITE_FISHER, STAY, RIGHT, 8 ; parent
	object_event 34,  5, SPRITE_LITTLE_GIRL, WALK, ANY_DIR, 9 ; urban legend kid

	def_warps_to OCHRE_REHABILITATION_CENTER
