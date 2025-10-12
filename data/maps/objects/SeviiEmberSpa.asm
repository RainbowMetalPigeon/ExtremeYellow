SeviiEmberSpa_Object:
	db $03 ; border block

	def_warp_events
	warp_event  8, 19, SEVII_ROUTE_31, 1
	warp_event  9, 19, SEVII_ROUTE_31, 1

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
	object_event 14, 12, SPRITE_GRANNY, STAY, DOWN, 1 ; Rock Smash gifter
	object_event  8, 15, SPRITE_SWIMMER, STAY, DOWN, 2
	object_event  9,  6, SPRITE_SWIMMER, STAY, DOWN, 3
	object_event  5,  7, SPRITE_GRAMPS, STAY, RIGHT, 4
	object_event  4,  2, SPRITE_POKE_BALL, STAY, NONE, 5, FIRE_STONE
	object_event 15,  2, SPRITE_POKE_BALL, STAY, NONE, 6, WATER_STONE

	def_warps_to SEVII_EMBER_SPA
