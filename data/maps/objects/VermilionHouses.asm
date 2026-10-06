VermilionHouses_Object:
	db $a ; border block

	def_warp_events
	; old rod
	warp_event  2,  7, LAST_MAP, 9
	warp_event  3,  7, LAST_MAP, 9
	; "trade", +14
	warp_event 16,  7, LAST_MAP, 8
	warp_event 17,  7, LAST_MAP, 8
	; pidgey, +28
	warp_event 30,  7, LAST_MAP, 5
	warp_event 31,  7, LAST_MAP, 5
	; new house 1
	warp_event 44,  7, LAST_MAP, 11
	warp_event 45,  7, LAST_MAP, 11
	; new house 2
	warp_event 58,  7, LAST_MAP, 12
	warp_event 59,  7, LAST_MAP, 12

	def_bg_events

	def_object_events
	object_event  2,  4, SPRITE_FISHING_GURU, STAY, RIGHT, 1 ; person
	; "trade", +14
	object_event 17,  5, SPRITE_GIRL, STAY, UP, 2 ; person
	; pidgey, +28
	object_event 33,  3, SPRITE_YOUNGSTER, STAY, LEFT, 3 ; person
	object_event 31,  5, SPRITE_BIRD, WALK, LEFT_RIGHT, 4 ; person
	object_event 32,  3, SPRITE_PAPER, STAY, NONE, 5 ; person
	; new house 1
	object_event 44,  3, SPRITE_SAILOR, STAY, DOWN, 6
	object_event 44,  4, SPRITE_WAITER, STAY, UP, 7
	; new house 2
	object_event 58,  6, SPRITE_BIRD, WALK, ANY_DIR, 8
	object_event 61,  5, SPRITE_YOUNGSTER, WALK, ANY_DIR, 9
	object_event 58,  3, SPRITE_GIRL, STAY, RIGHT, 10
	object_event 59,  3, SPRITE_PAPER, STAY, NONE, 11
	object_event 62,  1, SPRITE_POKE_BALL, STAY, NONE, 12
	object_event 60,  2, SPRITE_FISHING_GURU, WALK, ANY_DIR, 13

	def_warps_to VERMILION_HOUSES
