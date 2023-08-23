CeruleanCaveExtraFinal_Object:
	db $3 ; border block

	def_warp_events
	warp_event 28, 59, CERULEAN_CAVE_EXTRA_MIDDLE, 2
	warp_event 29, 59, CERULEAN_CAVE_EXTRA_MIDDLE, 3

	def_bg_events
	bg_event  3,  0, 15 ; sign

	def_object_events
	object_event  2,  0, SPRITE_GRANNY, STAY, DOWN, 1 ; person
	object_event 26, 54, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 2 ; boulder
	object_event 31, 54, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 3 ; boulder
	object_event 35, 24, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 4 ; boulder

	object_event 36,  3, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 5 ; boulder
	object_event 36,  6, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 6 ; boulder
	object_event 36,  7, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 7 ; boulder
	object_event 33,  8, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 8 ; boulder
	object_event 33,  4, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 9 ; boulder

	object_event 14,  3, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 10 ; boulder
	object_event 12,  4, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 11 ; boulder
	object_event 13,  5, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 12 ; boulder
	object_event 14,  6, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 13 ; boulder
	object_event 13,  7, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 14 ; boulder

	def_warps_to CERULEAN_CAVE_EXTRA_FINAL
