CinnabarLab_Object:
	db $17 ; border block

	def_warp_events
	warp_event  2,  7, LAST_MAP, 3
	warp_event  3,  7, LAST_MAP, 3
	warp_event  8,  4, CINNABAR_LAB, 12 ; CINNABAR_LAB_TRADE_ROOM, 1
	warp_event 12,  4, CINNABAR_LAB, 14 ; CINNABAR_LAB_METRONOME_ROOM, 1
	warp_event 16,  4, CINNABAR_LAB, 16 ; CINNABAR_LAB_FOSSIL_ROOM, 1
	; new rooms
	warp_event 28,  7, LAST_MAP, 7 ; 6, Archeologist house
	warp_event 29,  7, LAST_MAP, 7 ; 7, Archeologist house
	warp_event 42,  7, LAST_MAP, 8 ; 8, Seismic mini lab
	warp_event 43,  7, LAST_MAP, 8 ; 9, Seismic mini lab
	warp_event 54,  7, LAST_MAP, 9 ; 10, plant enthusiast
	warp_event 55,  7, LAST_MAP, 9 ; 11, plant enthusiast
	; lab rooms merged here
	warp_event 68,  7, CINNABAR_LAB, 3 ; 12
	warp_event 69,  7, CINNABAR_LAB, 3 ; 13
	warp_event 82,  7, CINNABAR_LAB, 4 ; 14
	warp_event 83,  7, CINNABAR_LAB, 4 ; 15
	warp_event 96,  7, CINNABAR_LAB, 5 ; 16
	warp_event 97,  7, CINNABAR_LAB, 5 ; 17

	def_bg_events
	bg_event  3,  2, 13 ; Lab1Text2
	bg_event  9,  4, 14 ; Lab1Text3
	bg_event 13,  4, 14 ; Lab1Text4
	bg_event 17,  4, 16 ; Lab1Text5
	; new
	bg_event 25,  0, 17 ; Lab1ArcheologistSign1
	bg_event 27,  0, 18 ; Lab1ArcheologistSign2
	bg_event 29,  0, 19 ; Lab1ArcheologistSign3
	bg_event 31,  0, 20 ; Lab1ArcheologistSign4
	bg_event 33,  0, 21 ; Lab1ArcheologistSign5
	bg_event 41,  6, 22 ; Lab1SeismologySign1
	; CINNABAR_LAB_TRADE_ROOM
	; CINNABAR_LAB_METRONOME_ROOM
	bg_event 80,  4, 23 ; Lab3Text3
	bg_event 81,  4, 24 ; Lab3Text4
	bg_event 82,  1, 25 ; Lab3Text5
	; CINNABAR_LAB_FOSSIL_ROOM

	def_object_events
	object_event  1,  3, SPRITE_FISHING_GURU, STAY, NONE, 1 ; person
	; new
	object_event 29,  4, SPRITE_GRANNY, STAY, UP, 2 ; Archeologist
	object_event 40,  7, SPRITE_SCIENTIST, STAY, UP, 3 ; Seismologist
	object_event 54,  3, SPRITE_COOLTRAINER_M, WALK, UP_DOWN, 4 ; Plant enthusiast
	object_event 29,  2, SPRITE_OLD_AMBER, STAY, NONE, 5 ; Treasure
	; CINNABAR_LAB_TRADE_ROOM
	object_event 69,  2, SPRITE_SUPER_NERD, STAY, DOWN, 6 ; person
	object_event 67,  4, SPRITE_GRAMPS, STAY, NONE, 7 ; person
	object_event 71,  5, SPRITE_BEAUTY, STAY, UP, 8 ; person
	; CINNABAR_LAB_METRONOME_ROOM
	object_event 87,  2, SPRITE_SCIENTIST, STAY, DOWN, 9 ; person
	object_event 82,  3, SPRITE_SCIENTIST, WALK, LEFT_RIGHT, 10 ; person
	; CINNABAR_LAB_FOSSIL_ROOM
	object_event 99,  2, SPRITE_SCIENTIST, WALK, LEFT_RIGHT, 11 ; person
	object_event 101,  6, SPRITE_SCIENTIST, STAY, UP, 12 ; person

	def_warps_to CINNABAR_LAB
