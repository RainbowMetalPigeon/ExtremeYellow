SeviiOneIslandGym2_Object:
	db $0f ; border block

	def_warp_events
;	warp_event  2, 19, SEVII_ONE_ISLAND_CITY, 5
;	warp_event  3, 19, SEVII_ONE_ISLAND_CITY, 5
;	warp_event  4, 14, SEVII_ONE_ISLAND_GYM, 4
	warp_event  4, 19, SEVII_ONE_ISLAND_GYM_1, 3
	warp_event  5, 19, SEVII_ONE_ISLAND_GYM_1, 3

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
	object_event  5,  4, SPRITE_ICHINO, STAY, DOWN, 1 ; Ichino
;	object_event  4, 17, SPRITE_GYM_GUIDE, STAY, DOWN, 2 ; Guide

	def_warps_to SEVII_ONE_ISLAND_GYM_2
