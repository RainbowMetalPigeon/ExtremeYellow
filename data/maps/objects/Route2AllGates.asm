Route2AllGates_Object:
	db $a ; border block

	def_warp_events
	; Route 2 Gate
	warp_event  4,  0, LAST_MAP, 4
	warp_event  5,  0, LAST_MAP, 4
	warp_event  4,  7, LAST_MAP, 5
	warp_event  5,  7, LAST_MAP, 5
	; Viridian Forest South Gate, +16
	warp_event 20,  0, VIRIDIAN_FOREST, 4
	warp_event 21,  0, VIRIDIAN_FOREST, 4
	warp_event 20,  7, LAST_MAP, 6
	warp_event 21,  7, LAST_MAP, 6
	; Viridian Forest South Gate, +32
	warp_event 36,  0, LAST_MAP, 2
	warp_event 37,  0, LAST_MAP, 2
	warp_event 36,  7, VIRIDIAN_FOREST, 1
	warp_event 37,  7, VIRIDIAN_FOREST, 1

	def_bg_events

	def_object_events
	; Route 2 Gate
	object_event  1,  4, SPRITE_SCIENTIST, STAY, LEFT, 1 ; person
	object_event  5,  4, SPRITE_YOUNGSTER, WALK, LEFT_RIGHT, 2 ; person
	; Viridian Forest South Gate, +16
	object_event 24,  4, SPRITE_GIRL, STAY, LEFT, 3 ; person
	object_event 18,  4, SPRITE_LITTLE_GIRL, WALK, UP_DOWN, 4 ; person
	; Viridian Forest South Gate, +32
	object_event 35,  2, SPRITE_SUPER_NERD, STAY, NONE, 5 ; person
	object_event 34,  5, SPRITE_GRAMPS, STAY, NONE, 6 ; person

	def_warps_to ROUTE_2_ALL_GATES
