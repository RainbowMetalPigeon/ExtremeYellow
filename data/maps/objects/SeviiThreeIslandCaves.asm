SeviiThreeIslandCaves_Object:
	db $03 ; border block

	def_warp_events
	warp_event  4, 19, SEVII_THREE_ISLAND_CITY, 8
	warp_event  5, 19, SEVII_THREE_ISLAND_CITY, 8
	warp_event 24, 19, SEVII_THREE_ISLAND_CITY, 9
	warp_event 25, 19, SEVII_THREE_ISLAND_CITY, 9
	warp_event 20,  5, SEVII_THREE_ISLAND_CITY, 10

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
	object_event 25,  5, SPRITE_POKE_BALL, STAY, NONE, 1, NUGGET

	def_warps_to SEVII_THREE_ISLAND_CAVES
