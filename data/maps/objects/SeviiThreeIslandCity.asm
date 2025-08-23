SeviiThreeIslandCity_Object:
	db $43 ; border block

	def_warp_events
	warp_event 10, 45, SEVII_THREE_ISLAND_DOCK, 1
	warp_event 11, 45, SEVII_THREE_ISLAND_DOCK, 1
	warp_event 15, 23, SEVII_THREE_ISLAND_POKEMON_CENTER_AND_MART, 1
	warp_event 19,  9, SEVII_THREE_ISLAND_POKEMON_CENTER_AND_MART, 3
	warp_event 12,  7, SEVII_THREE_ISLAND_GYM, 1
	warp_event 15, 15, SEVII_THREE_ISLAND_HOUSES, 1
	warp_event  5, 25, SEVII_THREE_ISLAND_HOUSES, 3

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3
;	bg_event 11, 11, 5 ; Route2Text4

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE
;	object_event 13, 45, SPRITE_POKE_BALL, STAY, NONE, 2, HP_UP
;	object_event 19, 68, SPRITE_POKE_BALL, STAY, NONE, 3, LINK_CABLE ; new

	def_warps_to SEVII_THREE_ISLAND_CITY