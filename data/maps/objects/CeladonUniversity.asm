CeladonUniversity_Object:
	db $17 ; border block

	def_warp_events
	; hall
	warp_event  8, 59, LAST_MAP, 14 ; 1
	warp_event  9, 59, LAST_MAP, 14 ; 2
	warp_event  2, 48, CELADON_UNIVERSITY, 7 ; 3
	warp_event  6, 48, CELADON_UNIVERSITY, 9 ; 4
	warp_event 10, 48, CELADON_UNIVERSITY, 11 ; 5
	warp_event 14, 48, CELADON_UNIVERSITY, 13 ; 6
	; pool
	warp_event 10, 23, CELADON_UNIVERSITY, 3 ; 7
	warp_event 11, 23, CELADON_UNIVERSITY, 3 ; 8
	; magna auditorium
	warp_event 46, 53, CELADON_UNIVERSITY, 4 ; 9
	warp_event 47, 53, CELADON_UNIVERSITY, 4 ; 10
	; library & study room
	warp_event 38, 15, CELADON_UNIVERSITY, 5 ; 11
	warp_event 39, 15, CELADON_UNIVERSITY, 5 ; 12
	; computing center
	warp_event  6, 43, CELADON_UNIVERSITY, 6 ; 13
	warp_event  7, 43, CELADON_UNIVERSITY, 6 ; 14

	def_bg_events
	bg_event  3, 48, 12  ; CeladonUniversityDoor1
	bg_event  7, 48, 13 ; CeladonUniversityDoor2
	bg_event 11, 48, 14 ; CeladonUniversityDoor3
	bg_event 15, 48, 15 ; CeladonUniversityDoor4
	bg_event  8, 53, 16 ; CeladonUniversityConstitution1
	bg_event  9, 53, 17 ; CeladonUniversityConstitution2

	def_object_events
	; hall
	object_event  4, 55, SPRITE_YOUNGSTER, STAY, DOWN, 1 ; person
	object_event  3, 56, SPRITE_BEAUTY, STAY, RIGHT, 2 ; person
	object_event  5, 56, SPRITE_COOLTRAINER_F, STAY, LEFT, 3 ; person
	object_event  4, 57, SPRITE_GIRL, STAY, UP, 4 ; person
	object_event 13, 52, SPRITE_SUPER_NERD, WALK, ANY_DIR, 5 ; person
	object_event 14, 57, SPRITE_HIKER, WALK, LEFT_RIGHT, 6 ; person
	; swimming pool
	object_event 15, 17, SPRITE_MAGIKARP, STAY, LEFT_RIGHT, 7 ; mons
	object_event 13, 13, SPRITE_SEEL, WALK, LEFT_RIGHT, 8 ; mons
	object_event 15,  8, SPRITE_FOSSIL, WALK, ANY_DIR, 9 ; mons
	object_event  9, 19, SPRITE_SWIMMER, STAY, DOWN, 10
	object_event  6, 10, SPRITE_SWIMMER, WALK, UP_DOWN, 11
	; magna auditorium

	; library & study room

	; computing center

	def_warps_to CELADON_UNIVERSITY
