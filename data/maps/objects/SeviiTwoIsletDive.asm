SeviiTwoIsletDive_Object:
	db $08 ; border block

	def_warp_events
;	warp_event 12, 41, SEVII_ROUTE_39, 2

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
;	object_event 13, 34, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 1
;	object_event  6, 29, SPRITE_ROCKSMASHABLE_ROCK, STAY, ROCKSMASHABLE_ROCK_MOVEMENT_BYTE_2, 3

	def_warps_to SEVII_TWO_ISLET_DIVE
