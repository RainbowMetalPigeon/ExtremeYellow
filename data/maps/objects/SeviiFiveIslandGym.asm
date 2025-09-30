SeviiFiveIslandGym_Object:
	db $0F ; border block

	def_warp_events
	warp_event  2, 23, SEVII_FIVE_ISLAND_CITY, 5
	warp_event  3, 23, SEVII_FIVE_ISLAND_CITY, 5
	warp_event  4, 18, SEVII_FIVE_ISLAND_GYM, 4
	warp_event 24, 23, SEVII_FIVE_ISLAND_GYM, 3
	warp_event 25, 23, SEVII_FIVE_ISLAND_GYM, 3

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
	object_event 20, 11, SPRITE_GONQUE, STAY, DOWN, 1 ; Gonque
	object_event  4, 21, SPRITE_GYM_GUIDE, STAY, DOWN, 2 ; Guide

	def_warps_to SEVII_FIVE_ISLAND_GYM
