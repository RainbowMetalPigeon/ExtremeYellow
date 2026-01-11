SeviiMtEmber3BF_Object:
	db $03 ; border block

	def_warp_events

	warp_event 45, 21, SEVII_MT_EMBER_2BF,  2 ;  1

	warp_event 42, 50, SEVII_MT_EMBER_2BF,  3 ;  2

	warp_event 26, 27, SEVII_MT_EMBER_2BF,  6 ;  3

	warp_event 27, 26, SEVII_MT_EMBER_4BF,  1 ;  4

	warp_event 23, 19, SEVII_MT_EMBER_4BF,  2 ;  5

	warp_event  6,  6, SEVII_MT_EMBER_2BF,  7 ;  6

	warp_event 47, 31, SEVII_MT_EMBER_2BF, 10 ;  7

	warp_event 32, 43, SEVII_MT_EMBER_4BF,  3 ;  8

	warp_event 55, 29, SEVII_MT_EMBER_4BF,  4 ;  9

	warp_event 50, 41, SEVII_MT_EMBER_2BF, 11 ; 10

	warp_event 44, 47, SEVII_MT_EMBER_2BF, 12 ; 11

	warp_event 42, 44, SEVII_MT_EMBER_4BF,  5 ; 12

	warp_event 42, 26, SEVII_MT_EMBER_4BF,  6 ; 13

	def_bg_events

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_MT_EMBER_3BF
