SeviiFourIslandCityDive_Object:
	db $08 ; border block

	def_warp_events
	warp_event 20, 23, SEVII_FOUR_ISLAND_CITY_DIVE_CAVERN, 1

	def_bg_events
;	bg_event  5, 27, 14 ; SeviiTwoIslandCitySignText1

	def_object_events
;	object_event  6, 20, SPRITE_DIVER, STAY, LEFT, 1, OPP_DIVER, 13
;	object_event 24,  6, SPRITE_DIVER, STAY, UP, 2, OPP_DIVER, 14
;	object_event  7,  4, SPRITE_DIVER, STAY, DOWN, 3, OPP_DIVER, 15
;	object_event 22, 21, SPRITE_DIVER, STAY, RIGHT, 4, OPP_DIVER, 16
;	object_event 36, 38, SPRITE_POKE_BALL, STAY, NONE, 5, PROTEIN
;	object_event 36, 39, SPRITE_POKE_BALL, STAY, NONE, 6, IRON
;	object_event 37, 38, SPRITE_POKE_BALL, STAY, NONE, 7, CALCIUM
;	object_event 37, 39, SPRITE_POKE_BALL, STAY, NONE, 8, CARBOS

	def_warps_to SEVII_FOUR_ISLAND_CITY_DIVE
