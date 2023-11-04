Route28_Object:
	db $43 ; border block

	def_warp_events

	def_bg_events

	def_object_events
	object_event  5,  7, SPRITE_ROCKET, STAY, RIGHT, 1
	object_event  5,  8, SPRITE_ROCKET, STAY, RIGHT, 2
	object_event  5,  9, SPRITE_ROCKET, STAY, RIGHT, 3
	object_event  5,  10, SPRITE_ROCKET, STAY, RIGHT, 4

	def_warps_to ROUTE_28
