SeviiThreeIslandGym_Object:
	db $0f ; border block

	def_warp_events
	warp_event  2, 21, SEVII_THREE_ISLAND_CITY, 5
	warp_event  3, 21, SEVII_THREE_ISLAND_CITY, 5
	warp_event  4, 16, SEVII_THREE_ISLAND_GYM, 4
	warp_event 24, 21, SEVII_THREE_ISLAND_GYM, 3
	warp_event 25, 21, SEVII_THREE_ISLAND_GYM, 3

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
	object_event 25, 10, SPRITE_SANTRE, STAY, DOWN, 1 ; Santre
	object_event  4, 19, SPRITE_GYM_GUIDE, STAY, DOWN, 2 ; Guide

	def_warps_to SEVII_THREE_ISLAND_GYM
