SeviiRoute32Dive_Object:
	db $08 ; border block

	def_warp_events
;	warp_event  8, 23, SEVII_ROUTE_32_DIVE_CAVERN_1_F1, 1

	def_bg_events
;	bg_event 15, 35, 1 ; SeviiRoute32Text1

	def_object_events
	object_event 21,  5, SPRITE_DIVER, STAY, DOWN, 1, OPP_DIVER,  1
	object_event 12, 29, SPRITE_DIVER, STAY, UP, 2, OPP_DIVER, 11
	object_event  7, 54, SPRITE_DIVER, STAY, DOWN, 3, OPP_DIVER, 12
;	object_event 13, 45, SPRITE_POKE_BALL, STAY, NONE, 2, HP_UP

	def_warps_to SEVII_ROUTE_32_DIVE