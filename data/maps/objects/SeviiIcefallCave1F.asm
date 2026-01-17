SeviiIcefallCave1F_Object:
	db $03 ; border block

	def_warp_events
	warp_event 14, 39, SEVII_FOUR_ISLAND_CITY,  9
	warp_event 15, 39, SEVII_FOUR_ISLAND_CITY,  9
	warp_event 26, 39, SEVII_FOUR_ISLAND_CITY, 10
	warp_event 27, 39, SEVII_FOUR_ISLAND_CITY, 10
	warp_event 11,  5, SEVII_ICEFALL_CAVE_2F,  1

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
	object_event  2, 10, SPRITE_POKE_BALL, STAY, NONE,  1, CARBOS
	object_event 21,  6, SPRITE_POKE_BALL, STAY, NONE,  2, PROTEIN
	object_event 35, 37, SPRITE_POKE_BALL, STAY, NONE,  3, CALCIUM

	def_warps_to SEVII_ICEFALL_CAVE_1F
