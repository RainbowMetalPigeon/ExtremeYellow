SeviiMtEmber8F_Object:
	db $03 ; border block

	def_warp_events

	warp_event 15,  2, SEVII_MT_EMBER,     27 ;  1
	warp_event 15,  3, SEVII_MT_EMBER,     27 ;  2

	warp_event 15, 10, SEVII_MT_EMBER,     28 ;  3
	warp_event 15, 11, SEVII_MT_EMBER,     28 ;  4

	warp_event 15,  0, SEVII_MT_EMBER_7F,   2 ;  5

	warp_event 10, 15, SEVII_MT_EMBER,     29 ;  6
	warp_event 11, 15, SEVII_MT_EMBER,     29 ;  7
	
	warp_event  2, 15, SEVII_MT_EMBER,     30 ;  8
	warp_event  3, 15, SEVII_MT_EMBER,     30 ;  9
	
	warp_event 12,  6, SEVII_MT_EMBER_7F,   3 ; 10

	warp_event 13,  2, SEVII_MT_EMBER_9F,   8 ; 11

	warp_event  8,  6, SEVII_MT_EMBER_9F,   9 ; 12

	warp_event  0,  2, SEVII_MT_EMBER,     31 ; 13
	warp_event  0,  3, SEVII_MT_EMBER,     31 ; 14

	warp_event  0, 10, SEVII_MT_EMBER,     32 ; 15
	warp_event  0, 11, SEVII_MT_EMBER,     32 ; 16

	warp_event  9,  1, SEVII_MT_EMBER_7F,   5 ; 17

	warp_event  5,  4, SEVII_MT_EMBER_7F,   6 ; 18

	warp_event  0,  6, SEVII_MT_EMBER_7F,   7 ; 19

	warp_event  0, 13, SEVII_MT_EMBER_7F,   8 ; 20

	def_bg_events

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_MT_EMBER_8F
