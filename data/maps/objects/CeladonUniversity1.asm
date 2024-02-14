CeladonUniversity1_Object:
	db $17 ; border block

	def_warp_events
	; hall
	warp_event  6, 29, LAST_MAP, 14 ; 1
	warp_event  7, 29, LAST_MAP, 14 ; 2
	warp_event  2, 22, CELADON_UNIVERSITY_1, 7 ; 3
	warp_event  4, 22, CELADON_UNIVERSITY_2, 1 ; 4
	warp_event  8, 22, CELADON_UNIVERSITY_2, 3 ; 5
	warp_event 10, 22, CELADON_UNIVERSITY_2, 5 ; 6
	; pool
	warp_event  8, 17, CELADON_UNIVERSITY_1, 3 ; 7
	warp_event  9, 17, CELADON_UNIVERSITY_1, 3 ; 8

	def_bg_events
	bg_event  3, 22, 13 ; CeladonUniversityDoor1
	bg_event  5, 22, 14 ; CeladonUniversityDoor2
	bg_event  9, 22, 15 ; CeladonUniversityDoor3
	bg_event 11, 22, 16 ; CeladonUniversityDoor4
	bg_event  6, 25, 17 ; CeladonUniversityConstitution1
	bg_event  7, 25, 18 ; CeladonUniversityConstitution2

	def_object_events
	; hall
	object_event  3, 26, SPRITE_SUPER_NERD, STAY, DOWN, 1 ; person
	object_event  2, 27, SPRITE_GIRL, STAY, RIGHT, 2 ; person
	object_event  4, 27, SPRITE_COOLTRAINER_F, STAY, LEFT, 3 ; person
	object_event  3, 28, SPRITE_BRUNETTE_GIRL, STAY, UP, 4 ; person
	object_event 10, 25, SPRITE_COOLTRAINER_M, WALK, ANY_DIR, 5 ; person
	object_event 11, 27, SPRITE_HIKER, WALK, LEFT_RIGHT, 6 ; person
	; swimming pool
	object_event 10,  4, SPRITE_MAGIKARP, STAY, LEFT_RIGHT, 7 ; mons
	object_event  9,  7, SPRITE_MAGIKARP, WALK, LEFT_RIGHT, 8 ; mons
	object_event 10, 11, SPRITE_MAGIKARP, WALK, ANY_DIR, 9 ; mons
	object_event  3,  5, SPRITE_SWIMMER, WALK, UP_DOWN, 10
	object_event  5, 13, SPRITE_SWIMMER, STAY, DOWN, 11
	object_event 19, 16, SPRITE_GIRL, STAY, LEFT, 12

	def_warps_to CELADON_UNIVERSITY_1
