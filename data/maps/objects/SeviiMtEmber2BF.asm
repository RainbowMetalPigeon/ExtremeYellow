SeviiMtEmber2BF_Object:
	db $03 ; border block

	def_warp_events
	
	warp_event 49,  2, SEVII_MT_EMBER_1BF,  2 ;  1

	warp_event 43, 19, SEVII_MT_EMBER_3BF,  1 ;  2

	warp_event 40, 48, SEVII_MT_EMBER_3BF,  2 ;  3

	warp_event 29, 49, SEVII_MT_EMBER_1BF,  3 ;  4

	warp_event 25, 24, SEVII_MT_EMBER_1BF,  6 ;  5

	warp_event 24, 25, SEVII_MT_EMBER_3BF,  3 ;  6

	warp_event  4,  4, SEVII_MT_EMBER_3BF,  6 ;  7

	warp_event  7, 11, SEVII_MT_EMBER_1BF,  7 ;  8

	warp_event 12, 20, SEVII_MT_EMBER_1BF,  8 ;  9

	warp_event 45, 29, SEVII_MT_EMBER_3BF,  7 ; 10

	warp_event 48, 39, SEVII_MT_EMBER_3BF, 10 ; 11

	warp_event 42, 45, SEVII_MT_EMBER_3BF, 11 ; 12

	def_bg_events

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_MT_EMBER_2BF

