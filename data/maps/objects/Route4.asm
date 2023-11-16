Route4_Object:
	db $2c ; border block

	def_warp_events
	warp_event 11,  5, MT_MOON_POKECENTER, 1
	warp_event 18,  5, MT_MOON_1F, 1
	warp_event 24,  5, MT_MOON_B1F, 8

	def_bg_events
	bg_event 12,  5, 10 ; PokeCenterSignText
	bg_event 17,  7, 11 ; Route4Text5
	bg_event 27,  7, 12 ; Route4Text6

	def_object_events
	object_event  9,  8, SPRITE_COOLTRAINER_F, WALK, ANY_DIR, 1 ; person
	object_event 20, 10, SPRITE_HIKER, STAY, RIGHT, 2 ; new
	object_event 23, 11, SPRITE_HIKER, STAY, LEFT, 3 ; new
	object_event 63,  3, SPRITE_COOLTRAINER_F, STAY, RIGHT, 4, OPP_COOLTRAINER, 30 ; edited
	object_event 57,  3, SPRITE_POKE_BALL, STAY, NONE, 5, TM_COUNTER
	object_event 21, 10, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 6 ; new
	object_event 21, 11, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 7 ; new
	object_event 22, 10, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 8 ; new
	object_event 22, 11, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 9 ; new

	def_warps_to ROUTE_4
