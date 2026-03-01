SeviiAlteringCave_Object:
	db $03 ; border block

	def_warp_events
	warp_event 12, 41, SEVII_ROUTE_39, 2
	warp_event 13, 41, SEVII_ROUTE_39, 2
	warp_event 12,  6, SEVII_ALTERING_CAVE_4, 1

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3
;	bg_event 11, 11, 5 ; Route2Text4

	def_object_events
	object_event 13, 34, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 1
	object_event 13, 35, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 2
	object_event  6, 29, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 3
	object_event 13, 19, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 4
	object_event 14, 19, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 5
	; to be shown after inter-map interactions, initially hidden
	object_event 12, 34, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 6
	object_event 14, 19, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 7

	def_warps_to SEVII_ALTERING_CAVE
