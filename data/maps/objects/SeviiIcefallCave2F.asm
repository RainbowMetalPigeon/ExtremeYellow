SeviiIcefallCave2F_Object:
	db $03 ; border block

	def_warp_events
	warp_event 17,  1, SEVII_ICEFALL_CAVE_1F, 5
	warp_event  1, 12, SEVII_FOUR_ISLAND_CITY, 11

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
	object_event 18,  5, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 1
	object_event  6,  3, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 2
	object_event 14,  3, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 3
	object_event 11, 18, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 4
	object_event 14, 18, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 5

	def_warps_to SEVII_ICEFALL_CAVE_2F
