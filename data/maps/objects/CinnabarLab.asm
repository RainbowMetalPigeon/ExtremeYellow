CinnabarLab_Object:
	db $17 ; border block

	def_warp_events
	warp_event  2,  7, LAST_MAP, 3
	warp_event  3,  7, LAST_MAP, 3
	warp_event  8,  4, CINNABAR_LAB_TRADE_ROOM, 1
	warp_event 12,  4, CINNABAR_LAB_METRONOME_ROOM, 1
	warp_event 16,  4, CINNABAR_LAB_FOSSIL_ROOM, 1
	; new rooms
	warp_event 28,  7, LAST_MAP, 7 ; 6, Archeologist house
	warp_event 29,  7, LAST_MAP, 7 ; 7, Archeologist house
	warp_event 42,  7, LAST_MAP, 8 ; 8, Seismic mini lab
	warp_event 43,  7, LAST_MAP, 8 ; 9, Seismic mini lab
	warp_event 54,  7, LAST_MAP, 9 ; 10, plant enthusiast
	warp_event 55,  7, LAST_MAP, 9 ; 11, plant enthusiast

	def_bg_events
	bg_event  3,  2, 6 ; Lab1Text2
	bg_event  9,  4, 7 ; Lab1Text3
	bg_event 13,  4, 8 ; Lab1Text4
	bg_event 17,  4, 9 ; Lab1Text5
	; new
	bg_event 25,  0, 10 ; Lab1ArcheologistSign1
	bg_event 27,  0, 11 ; Lab1ArcheologistSign2
	bg_event 29,  0, 12 ; Lab1ArcheologistSign3
	bg_event 31,  0, 13 ; Lab1ArcheologistSign4
	bg_event 33,  0, 14 ; Lab1ArcheologistSign5
	bg_event 41,  6, 15 ; Lab1SeismologySign1

	def_object_events
	object_event  1,  3, SPRITE_FISHING_GURU, STAY, NONE, 1 ; person
	; new
	object_event 29,  4, SPRITE_GRANNY, STAY, UP, 2 ; Archeologist
	object_event 40,  7, SPRITE_SCIENTIST, STAY, UP, 3 ; Seismologist
	object_event 54,  3, SPRITE_COOLTRAINER_M, WALK, UP_DOWN, 4 ; Plant enthusiast
	object_event 29,  2, SPRITE_OLD_AMBER, STAY, NONE, 5 ; Treasure

	def_warps_to CINNABAR_LAB
