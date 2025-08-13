SeviiTwoIslandCity_Object:
	db $43 ; border block

	def_warp_events
	warp_event  6, 33, SEVII_TWO_ISLAND_DOCK, 1
	warp_event  7, 33, SEVII_TWO_ISLAND_DOCK, 1
	warp_event 15, 29, SEVII_TWO_ISLAND_POKEMON_CENTER, 1

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3
;	bg_event 11, 11, 5 ; Route2Text4

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE
;	object_event 13, 45, SPRITE_POKE_BALL, STAY, NONE, 2, HP_UP
;	object_event 19, 68, SPRITE_POKE_BALL, STAY, NONE, 3, LINK_CABLE ; new

	def_warps_to SEVII_TWO_ISLAND_CITY