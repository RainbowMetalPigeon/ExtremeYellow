SafariZoneQuadrupleRestHouse_Object:
	db $a ; border block

	def_warp_events
	; center
	warp_event  2,  7, SAFARI_ZONE_CENTER, 9
	warp_event  3,  7, SAFARI_ZONE_CENTER, 9
	; west, +14
	warp_event 16,  7, SAFARI_ZONE_WEST, 8
	warp_event 17,  7, SAFARI_ZONE_WEST, 8
	; east, +28
	warp_event 30,  7, SAFARI_ZONE_EAST, 5
	warp_event 31,  7, SAFARI_ZONE_EAST, 5
	; north, +42
	warp_event 44,  7, SAFARI_ZONE_NORTH, 9
	warp_event 45,  7, SAFARI_ZONE_NORTH, 9

	def_bg_events

	def_object_events
	; center
	object_event  3,  2, SPRITE_GIRL, STAY, DOWN, 1 ; Sara waiting for Erik
	object_event  1,  4, SPRITE_SCIENTIST, WALK, UP_DOWN, 2 ; person
	object_event  3,  2, SPRITE_GIRL, STAY, RIGHT, 3 ; new, Sara happy
	object_event  4,  2, SPRITE_FISHER, STAY, LEFT, 4 ; new, Erik happy
	; west, +14
	object_event 18,  4, SPRITE_SCIENTIST, WALK, ANY_DIR, 5 ; person
	object_event 14,  2, SPRITE_FISHER, STAY, RIGHT, 6 ; person ; edited, was a SPRITE_COOLTRAINER_M
	object_event 20,  2, SPRITE_ERIKA, STAY, DOWN, 7 ; person
	; east, +28
	object_event 29,  3, SPRITE_SCIENTIST, WALK, UP_DOWN, 8 ; person
	object_event 32,  2, SPRITE_ROCKER, STAY, NONE, 9 ; person
	object_event 33,  2, SPRITE_SILPH_WORKER, STAY, NONE, 10 ; person
	; north, +42
	object_event 48,  3, SPRITE_SCIENTIST, WALK, LEFT_RIGHT, 11 ; person
	object_event 45,  4, SPRITE_SAFARI_ZONE_WORKER, STAY, NONE, 12 ; person
	object_event 43,  5, SPRITE_GENTLEMAN, WALK, UP_DOWN, 13 ; person

	def_warps_to SAFARI_ZONE_QUADRUPLE_REST_HOUSE
