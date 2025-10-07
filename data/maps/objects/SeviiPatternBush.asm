SeviiPatternBush_Object:
	db $03 ; border block

	def_warp_events
	warp_event 39, 14, SEVII_ROUTE_38, 3
	warp_event 39, 15, SEVII_ROUTE_38, 3
	warp_event  0, 14, SEVII_ROUTE_39, 1
	warp_event  0, 15, SEVII_ROUTE_39, 1

	def_bg_events
;	bg_event  4, 37, 15

	def_object_events
	object_event 34, 11, SPRITE_WAITER, WALK, UP_DOWN, 1
	object_event 21, 15, SPRITE_CHANNELER, WALK, LEFT_RIGHT, 2
	object_event 14, 10, SPRITE_GYM_GUIDE, WALK, UP_DOWN, 3
	object_event  4, 13, SPRITE_COOK, WALK, UP_DOWN, 4
	; trainers
	object_event 29, 18, SPRITE_GENTLEMAN, WALK, UP_DOWN, 5, OPP_GENTLEMAN, 7
	object_event 24, 10, SPRITE_SAILOR, WALK, UP_DOWN, 6, OPP_SAILOR, 10
	object_event 15, 16, SPRITE_BIKER, WALK, UP_DOWN, 7, OPP_BIKER, 16
	object_event  7, 22, SPRITE_GAMBLER, WALK, LEFT_RIGHT, 8, OPP_GAMBLER, 9
	; non-persons
;	object_event  2, 47, SPRITE_POKE_BALL, WALK, NONE, 14, METAL_COAT

	def_warps_to SEVII_PATTERN_BUSH
