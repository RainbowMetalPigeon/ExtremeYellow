SeviiTwoIslandGym_Object:
	db $0f ; border block

	def_warp_events
	warp_event  2, 17, SEVII_TWO_ISLAND_CITY, 4
	warp_event  3, 17, SEVII_TWO_ISLAND_CITY, 4
	warp_event  4, 12, SEVII_TWO_ISLAND_GYM, 4
	warp_event 22, 17, SEVII_TWO_ISLAND_GYM, 3
	warp_event 23, 17, SEVII_TWO_ISLAND_GYM, 3

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
	object_event 23,  8, SPRITE_NIUE, STAY, DOWN, 1 ; Niue
	object_event  4, 15, SPRITE_GYM_GUIDE, STAY, DOWN, 2 ; Guide

	def_warps_to SEVII_TWO_ISLAND_GYM
