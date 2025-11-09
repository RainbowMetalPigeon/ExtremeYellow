SeviiFourIslandCityDiveCavern_Object:
	db $20 ; border block

	def_warp_events
	warp_event 32, 53, SEVII_FOUR_ISLAND_CITY_DIVE, 1
	warp_event 33, 53, SEVII_FOUR_ISLAND_CITY_DIVE, 1

	def_bg_events

	def_object_events
	object_event 33,  3, SPRITE_POKE_BALL, STAY, NONE, 1, PEARL

	def_warps_to SEVII_FOUR_ISLAND_CITY_DIVE_CAVERN
