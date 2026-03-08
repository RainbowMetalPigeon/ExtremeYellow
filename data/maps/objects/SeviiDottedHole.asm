SeviiDottedHole_Object:
	db $03 ; border block

	def_warp_events
	warp_event 10, 13, SEVII_ROUTE_40, 1
;	warp_event  9, 13, SEVII_ROUTE_40, 1

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3
;	bg_event 11, 11, 5 ; Route2Text4

	def_object_events
	object_event 10,  5, SPRITE_MONSTER, STAY, DOWN, 1, MELTAN, 50 | OW_POKEMON ; edited, to go beyond 200
	object_event 10, 13, SPRITE_JESSIE, STAY, UP, 2
	object_event 10, 13, SPRITE_JAMES, STAY, UP, 3
	object_event  8, 10, SPRITE_JESSIE, STAY, RIGHT, 4
	object_event 12, 10, SPRITE_JAMES, STAY, LEFT, 5
	object_event  9,  9, SPRITE_PETREL, STAY, RIGHT, 6
	object_event 11,  9, SPRITE_PROTON, STAY, LEFT, 7
	object_event 10, 10, SPRITE_ARIANA, STAY, UP, 8
	object_event 10,  8, SPRITE_ARCHER, STAY, DOWN, 9

	def_warps_to SEVII_DOTTED_HOLE
