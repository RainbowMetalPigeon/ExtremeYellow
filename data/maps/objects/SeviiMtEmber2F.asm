SeviiMtEmber2F_Object:
	db $03 ; border block

	def_warp_events
	warp_event  0,  4, SEVII_MT_EMBER,      5 ;  1
	warp_event  0,  5, SEVII_MT_EMBER,      5 ;  2

	warp_event  1, 14, SEVII_MT_EMBER_1F,   9 ;  3

	warp_event 29, 16, SEVII_MT_EMBER_1F,  12 ;  4

	warp_event 25, 15, SEVII_MT_EMBER_3F,   1 ;  5

	warp_event 34, 24, SEVII_MT_EMBER_3F,   4 ;  6

	warp_event 27, 25, SEVII_MT_EMBER_3F,   5 ;  7

	warp_event 22, 28, SEVII_MT_EMBER_3F,   6 ;  8

	warp_event 24,  1, SEVII_MT_EMBER_1F,  13 ;  9

	def_bg_events

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_MT_EMBER_2F
