SeviiMtEmber6F_Object:
	db $03 ; border block

	def_warp_events
	warp_event 23,  4, SEVII_MT_EMBER,     17 ;  1
	warp_event 23,  5, SEVII_MT_EMBER,     17 ;  2

	warp_event 15,  5, SEVII_MT_EMBER_5F,   5 ;  3

	warp_event  3,  9, SEVII_MT_EMBER_5F,   7 ;  4

	warp_event  7,  5, SEVII_MT_EMBER_7F,   1 ;  5

	warp_event 11, 23, SEVII_MT_EMBER_5F,   8 ;  6

	warp_event  0, 20, SEVII_MT_EMBER,     18 ;  7
	warp_event  0, 21, SEVII_MT_EMBER,     18 ;  8

	warp_event  0, 16, SEVII_MT_EMBER,     19 ;  9
	warp_event  0, 17, SEVII_MT_EMBER,     19 ; 10

	warp_event  8, 12, SEVII_MT_EMBER_7F,   4 ; 11

	warp_event 23, 19, SEVII_MT_EMBER_5F,  11 ; 12

	def_bg_events

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_MT_EMBER_6F
