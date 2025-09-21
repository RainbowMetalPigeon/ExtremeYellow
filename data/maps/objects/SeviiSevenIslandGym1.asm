SeviiSevenIslandGym1_Object:
	db $0f ; border block

	def_warp_events
	warp_event  2,  5, SEVII_ROUTE_41, 1
	warp_event  3,  5, SEVII_ROUTE_41, 1
	warp_event  4,  0, SEVII_SEVEN_ISLAND_GYM_2, 1

	def_bg_events

	def_object_events
	object_event  4,  3, SPRITE_GYM_GUIDE, STAY, DOWN, 1 ; Guide

	def_warps_to SEVII_SEVEN_ISLAND_GYM_1

