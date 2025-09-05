SeviiThreeIslandGym_Object:
	db $2e ; border block

	def_warp_events
	warp_event 20, 39, SEVII_THREE_ISLAND_CITY, 5
	warp_event 21, 39, SEVII_THREE_ISLAND_CITY, 5

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
	object_event 18, 35, SPRITE_SANTRE, STAY, DOWN, 1 ; Santre
	object_event 23, 37, SPRITE_GYM_GUIDE, STAY, DOWN, 2 ; Guide

	def_warps_to SEVII_THREE_ISLAND_GYM
