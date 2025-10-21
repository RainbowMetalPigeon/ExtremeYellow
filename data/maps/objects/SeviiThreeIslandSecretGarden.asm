SeviiThreeIslandSecretGarden_Object:
	db $03 ; border block

	def_warp_events
	warp_event  8, 17, SEVII_THREE_ISLAND_HOUSES, 5
	warp_event  9, 17, SEVII_THREE_ISLAND_HOUSES, 5
	warp_event  0,  6, SEVII_ROUTE_33, 2
	warp_event  0,  7, SEVII_ROUTE_33, 2

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
;	object_event 21, 24, SPRITE_YOUNGSTER, STAY, RIGHT, 1 ; person
	object_event  8,  8, SPRITE_POKE_BALL, STAY, NONE, 1, HM_WHIRLPOOL

	def_warps_to SEVII_THREE_ISLAND_SECRET_GARDEN
