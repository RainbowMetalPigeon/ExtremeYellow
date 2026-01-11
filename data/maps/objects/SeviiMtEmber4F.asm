SeviiMtEmber4F_Object:
	db $03 ; border block

	def_warp_events
	warp_event 31,  2, SEVII_MT_EMBER,      6 ;  1
	warp_event 31,  3, SEVII_MT_EMBER,      6 ;  2

	warp_event 31,  8, SEVII_MT_EMBER,      7 ;  3
	warp_event 31,  9, SEVII_MT_EMBER,      7 ;  4

	warp_event 22, 31, SEVII_MT_EMBER,      8 ;  5
	warp_event 23, 31, SEVII_MT_EMBER,      8 ;  6

	warp_event  8, 31, SEVII_MT_EMBER,      9 ;  7
	warp_event  9, 31, SEVII_MT_EMBER,      9 ;  8

	warp_event  0, 15, SEVII_MT_EMBER,     10 ;  9
	warp_event  0, 14, SEVII_MT_EMBER,     10 ; 10

	warp_event  0,  6, SEVII_MT_EMBER,     11 ; 11
	warp_event  0,  7, SEVII_MT_EMBER,     11 ; 12

	warp_event 13,  9, SEVII_MT_EMBER_3F,   2 ; 13

	warp_event  5, 15, SEVII_MT_EMBER_5F,   6 ; 14

	warp_event 31, 24, SEVII_MT_EMBER,     12 ; 15
	warp_event 31, 25, SEVII_MT_EMBER,     12 ; 16

	warp_event 31, 31, SEVII_MT_EMBER_3F,   3 ; 17

	def_bg_events

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_MT_EMBER_4F
