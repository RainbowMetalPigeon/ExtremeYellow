SeviiRoute33_Object:
	db $0f ; border block

	def_warp_events
	warp_event  7,  5, SEVII_BERRY_FOREST, 1

	def_bg_events
	bg_event  9,  9, 6 ; SeviiRoute33Text1

	def_object_events
	object_event 89, 22, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 1
	object_event 18,  6, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 2
	object_event 18,  4, SPRITE_POKE_BALL, STAY, NONE, 3, RARE_CANDY
	object_event 48,  2, SPRITE_POKE_BALL, STAY, NONE, 4, ULTRA_BALL
	object_event 64, 10, SPRITE_POKE_BALL, STAY, NONE, 5, PP_UP

	def_warps_to SEVII_ROUTE_33