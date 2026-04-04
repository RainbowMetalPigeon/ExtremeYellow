SeviiTenIsland_Object:
	db $43 ; border block

	def_warp_events
	warp_event 40, 17, SEVII_UNDERGROUND_LOBBY, 10

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
	object_event 20, 20, SPRITE_POKE_BALL, STAY, NONE, 1
	object_event 20, 20, SPRITE_CELEBI, STAY, NONE, 2
	object_event 20, 20, SPRITE_CHRIS, STAY, DOWN, 3
	object_event 20, 20, SPRITE_OAK, STAY, DOWN, 4
	object_event 20, 20, SPRITE_KRIS, STAY, DOWN, 5
	object_event 20, 20, SPRITE_YOUNG_OAK, STAY, DOWN, 6

	def_warps_to SEVII_TEN_ISLAND