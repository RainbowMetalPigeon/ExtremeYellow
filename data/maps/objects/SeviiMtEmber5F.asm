SeviiMtEmber5F_Object:
	db $03 ; border block

	def_warp_events
	warp_event  6, 27, SEVII_MT_EMBER,     12 ;  1
	warp_event  7, 27, SEVII_MT_EMBER,     12 ;  2

	warp_event  0,  6, SEVII_MT_EMBER,     13 ;  3
	warp_event  0,  7, SEVII_MT_EMBER,     13 ;  4

	warp_event 17,  7, SEVII_MT_EMBER_6F,   3 ;  5

	warp_event  3, 13, SEVII_MT_EMBER_4F,  14 ;  6

	warp_event  5, 11, SEVII_MT_EMBER_6F,   4 ;  7

	def_bg_events

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_MT_EMBER_5F
