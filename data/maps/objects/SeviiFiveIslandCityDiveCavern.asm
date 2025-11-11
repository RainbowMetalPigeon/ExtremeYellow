SeviiFiveIslandCityDiveCavern_Object:
	db $20 ; border block

	def_warp_events
	warp_event  4, 75, SEVII_FIVE_ISLAND_CITY_DIVE, 1
	warp_event  5, 75, SEVII_FIVE_ISLAND_CITY_DIVE, 1

	def_bg_events
;	bg_event  5, 27, 14 ; SeviiTwoIslandCitySignText1

	def_object_events
	object_event 27, 47, SPRITE_POKE_BALL, STAY, NONE, 1, PEARL
	object_event 27,  4, SPRITE_POKE_BALL, STAY, NONE, 2, PERFECTER

	def_warps_to SEVII_FIVE_ISLAND_CITY_DIVE_CAVERN
