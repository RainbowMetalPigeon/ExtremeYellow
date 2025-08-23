SeviiSevenIslandCity_Object:
	db $43 ; border block

	def_warp_events
	warp_event 14, 15, SEVII_SEVEN_ISLAND_DOCK, 1
	warp_event 15, 15, SEVII_SEVEN_ISLAND_DOCK, 1
	warp_event 13,  3, SEVII_SEVEN_ISLAND_POKEMON_CENTER_AND_MART, 1
	warp_event  5,  7, SEVII_SEVEN_ISLAND_POKEMON_CENTER_AND_MART, 3
	warp_event 13,  7, SEVII_SEVEN_ISLAND_HOUSES, 1

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3
;	bg_event 11, 11, 5 ; Route2Text4

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE
;	object_event 13, 45, SPRITE_POKE_BALL, STAY, NONE, 2, HP_UP
;	object_event 19, 68, SPRITE_POKE_BALL, STAY, NONE, 3, LINK_CABLE ; new

	def_warps_to SEVII_SEVEN_ISLAND_CITY