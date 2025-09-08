SeviiRoute33_Object:
	db $0f ; border block

	def_warp_events
	warp_event  7,  5, SEVII_BERRY_FOREST, 1
	warp_event 98, 23, SEVII_THREE_ISLAND_SECRET_GARDEN, 3

	def_bg_events
	bg_event  9,  9, 15 ; SeviiRoute33SignText1
	bg_event 99, 23, 16 ; SeviiRoute33SignText2

	def_object_events
	object_event 34, 12, SPRITE_BIKER, STAY, RIGHT, 1
	object_event 33, 13, SPRITE_BIKER, STAY, RIGHT, 2
	object_event 31, 12, SPRITE_BIKER, STAY, RIGHT, 3
	object_event 31, 13, SPRITE_BIKER, STAY, RIGHT, 4
	; TBE
	object_event 77, 14, SPRITE_GIRL, STAY, LEFT, 5, OPP_SWIMMER, 19
	object_event 57, 12, SPRITE_GIRL, STAY, DOWN, 6, OPP_SWIMMER, 19
	object_event 85,  2, SPRITE_GIRL, STAY, DOWN, 7, OPP_SWIMMER, 19
	object_event 64, 20, SPRITE_GIRL, STAY, RIGHT, 8, OPP_SWIMMER, 19
	object_event 61, 10, SPRITE_GIRL, STAY, UP, 9, OPP_SWIMMER, 19
	; items
	object_event 89, 22, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 10
	object_event 18,  6, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 11
	object_event 18,  4, SPRITE_POKE_BALL, STAY, NONE, 12, RARE_CANDY
	object_event 50,  2, SPRITE_POKE_BALL, STAY, NONE, 13, ULTRA_BALL
	object_event 64, 10, SPRITE_POKE_BALL, STAY, NONE, 14, PP_UP

	def_warps_to SEVII_ROUTE_33