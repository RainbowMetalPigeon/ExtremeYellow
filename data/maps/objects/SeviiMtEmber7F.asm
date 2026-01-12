SeviiMtEmber7F_Object:
	db $03 ; border block

	def_warp_events

	warp_event  5,  3, SEVII_MT_EMBER_6F,   5 ;  1

	warp_event 17,  2, SEVII_MT_EMBER_8F,   5 ;  2

	warp_event 14,  8, SEVII_MT_EMBER_8F,  10 ;  3

	warp_event  6, 10, SEVII_MT_EMBER_6F,  11 ;  4

	warp_event 11,  3, SEVII_MT_EMBER_8F,  17 ;  5

	warp_event  7,  6, SEVII_MT_EMBER_8F,  18 ;  6

	warp_event  2,  8, SEVII_MT_EMBER_8F,  19 ;  7

	warp_event  2, 15, SEVII_MT_EMBER_8F,  20 ;  8

	warp_event  6,  7, SEVII_MT_EMBER_6F,  15 ;  9

	warp_event  0, 19, SEVII_MT_EMBER_6F,  16 ; 10

	warp_event 17, 19, SEVII_MT_EMBER_6F,  17 ; 11

	warp_event 10, 12, SEVII_MT_EMBER_6F,  18 ; 12

	def_bg_events

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_MT_EMBER_7F
