Route29_Object:
	db $43 ; border block

	def_warp_events

	def_bg_events
	bg_event 13, 55, 11 ; Route29TextIceOrbRecess
	bg_event 15, 55, 12 ; Route29TextThunderOrbRecess
	bg_event 17, 55, 13 ; Route29TextFireOrbRecess
	; ruins
	bg_event  6, 19, 14 ; Route29TextRuin1
	bg_event  7, 19, 15 ; Route29TextRuin1
	bg_event 22, 21, 16 ; Route29TextRuin2
	bg_event 23, 21, 17 ; Route29TextRuin2
	bg_event 16, 29, 18 ; Route29TextRuin3
	bg_event 17, 29, 19 ; Route29TextRuin3
	bg_event 18, 37, 20 ; Route29TextRuin4
	bg_event 19, 37, 21 ; Route29TextRuin4
	bg_event  8, 39, 22 ; Route29TextRuin5
	bg_event  9, 39, 23 ; Route29TextRuin5

	def_object_events
	object_event 17,  9, SPRITE_COOLTRAINER_F, STAY, DOWN, 1, OPP_COOLTRAINER, 32
	object_event  9, 16, SPRITE_COOLTRAINER_F, STAY, LEFT, 2, OPP_COOLTRAINER, 33
	object_event 22, 42, SPRITE_COOLTRAINER_F, STAY, RIGHT, 3, OPP_COOLTRAINER, 34
	object_event 14, 28, SPRITE_COOLTRAINER_M, STAY, DOWN, 4, OPP_BIRD_KEEPER, 20
	object_event 24, 32, SPRITE_COOLTRAINER_M, STAY, DOWN, 5, OPP_BIRD_KEEPER, 21
	object_event  8, 40, SPRITE_HIKER, STAY, UP, 6, OPP_HIKER, 17
	object_event 23, 22, SPRITE_HIKER, STAY, UP, 7, OPP_HIKER, 18
	object_event  9, 32, SPRITE_SWIMMER, STAY, RIGHT, 8, OPP_SWIMMER, 16
	object_event 18, 43, SPRITE_SWIMMER, STAY, LEFT, 9, OPP_SWIMMER, 17
	object_event 15, 58, SPRITE_SLOWKING, STAY, DOWN, 10

	def_warps_to ROUTE_29
