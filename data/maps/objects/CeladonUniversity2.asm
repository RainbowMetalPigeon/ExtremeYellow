CeladonUniversity2_Object:
	db $17 ; border block

	def_warp_events
	; magna auditorium
	warp_event 12, 33, CELADON_UNIVERSITY_1, 4 ; 1
	warp_event 13, 33, CELADON_UNIVERSITY_1, 4 ; 2
	; library & study room
	warp_event 40, 17, CELADON_UNIVERSITY_1, 5 ; 3
	warp_event 41, 17, CELADON_UNIVERSITY_1, 5 ; 4
	; computing center
	warp_event 38, 33, CELADON_UNIVERSITY_1, 6 ; 5
	warp_event 39, 33, CELADON_UNIVERSITY_1, 6 ; 6

	def_bg_events
;	bg_event 32,  1, 15 ; CeladonUniversity2SignTest

	def_object_events
	; magna auditorium
	object_event 12,  5, SPRITE_MIDDLE_AGED_WOMAN, STAY, DOWN, 1 ; prof
	object_event 12, 11, SPRITE_SUPER_NERD, STAY, UP, 2 ; student
	object_event 20, 17, SPRITE_COOLTRAINER_F, STAY, RIGHT, 3 ; lovebirds
	object_event 21, 17, SPRITE_BRUNETTE_GIRL, STAY, LEFT, 4 ; lovebirds
	object_event 16, 26, SPRITE_SUPER_NERD, STAY, UP, 5 ; student

	; library & study room
	object_event 34, 17, SPRITE_SCIENTIST_F, STAY, UP, 6 ; researcher, pc
	object_event 32, 13, SPRITE_SUPER_NERD, STAY, UP, 7 ; student, single station
	object_event 36, 13, SPRITE_COOLTRAINER_F, STAY, UP, 8 ; student, single station, Lapras?
	object_event 47, 12, SPRITE_COOLTRAINER_M, STAY, DOWN, 9 ; student, common table
	object_event 47, 15, SPRITE_BRUNETTE_GIRL, STAY, UP, 10 ; student, common table
	object_event 45,  2, SPRITE_GIRL, WALK, LEFT_RIGHT, 11 ; student, search book

	; computing center
	object_event 34, 29, SPRITE_SCIENTIST_F, STAY, UP, 12 ; researcher, pc
	object_event 40, 27, SPRITE_SCIENTIST, STAY, UP, 13 ; researcher, table
	object_event 46, 24, SPRITE_SCIENTIST_F, WALK, LEFT_RIGHT, 14 ; researcher, machines

	def_warps_to CELADON_UNIVERSITY_2
