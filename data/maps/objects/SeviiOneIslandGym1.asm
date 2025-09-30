SeviiOneIslandGym1_Object:
	db $0f ; border block

	def_warp_events
	warp_event  2,  5, SEVII_ONE_ISLAND_CITY, 5
	warp_event  3,  5, SEVII_ONE_ISLAND_CITY, 5
	warp_event  4,  0, SEVII_ONE_ISLAND_GYM_2, 1
;	warp_event 18, 19, SEVII_ONE_ISLAND_GYM, 3
;	warp_event 19, 19, SEVII_ONE_ISLAND_GYM, 3

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
;	object_event 19,  4, SPRITE_ICHINO, STAY, DOWN, 1 ; Ichino
	object_event  4,  3, SPRITE_GYM_GUIDE, STAY, DOWN, 1 ; Guide

	def_warps_to SEVII_ONE_ISLAND_GYM_1
