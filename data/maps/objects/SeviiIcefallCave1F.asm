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
;	object_event 18, 23, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 1
;	object_event 17, 16, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 2
;	object_event 15, 18, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 3

	def_warps_to SEVII_ICEFALL_CAVE_1F