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

	def_bg_events

	def_object_events
	object_event  2,  4, SPRITE_FISHING_GURU, STAY, RIGHT, 1 ; person
	; "trade", +14
	object_event 17,  5, SPRITE_GENTLEMAN, STAY, UP, 2 ; person
	; pidgey, +28
	object_event 33,  3, SPRITE_YOUNGSTER, STAY, LEFT, 3 ; person
	object_event 31,  5, SPRITE_BIRD, WALK, LEFT_RIGHT, 4 ; person
	object_event 32,  3, SPRITE_PAPER, STAY, NONE, 5 ; person

	def_warps_to VERMILION_HOUSES
