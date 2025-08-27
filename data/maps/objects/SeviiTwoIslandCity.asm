SeviiTwoIslandCity_Object:
	db $43 ; border block

	def_warp_events
	warp_event  6, 33, SEVII_TWO_ISLAND_DOCK, 1
	warp_event  7, 33, SEVII_TWO_ISLAND_DOCK, 1
	warp_event 15, 29, SEVII_TWO_ISLAND_POKEMON_CENTER, 1
	warp_event 30,  7, SEVII_TWO_ISLAND_GYM, 1
	warp_event 11, 27, SEVII_TWO_ISLAND_HOUSES, 1
	warp_event 29, 33, SEVII_TWO_ISLAND_HOUSES, 3
	warp_event 33, 33, SEVII_TWO_ISLAND_HOUSES, 5

	def_bg_events
;	bg_event 16, 23, 1 ; SeviiTwoIslandCity_RockClimb1Up
;	bg_event 16, 22, 2 ; SeviiTwoIslandCity_RockClimb1Down
;	bg_event 11, 11, 5 ; Route2Text4

	def_object_events
	object_event 36, 28, SPRITE_TAUROS, WALK, ANY_DIR, 1
	object_event 37, 33, SPRITE_TAUROS, WALK, ANY_DIR, 2
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE
;	object_event 13, 45, SPRITE_POKE_BALL, STAY, NONE, 2, HP_UP
;	object_event 19, 68, SPRITE_POKE_BALL, STAY, NONE, 3, LINK_CABLE ; new

	def_warps_to SEVII_TWO_ISLAND_CITY