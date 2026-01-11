SeviiMtEmber8F_Object:
	db $03 ; border block

	def_warp_events

	warp_event 15,  2, SEVII_MT_EMBER,     20 ;  1
	warp_event 15,  3, SEVII_MT_EMBER,     20 ;  2

	warp_event 15, 10, SEVII_MT_EMBER,     21 ;  3
	warp_event 15, 11, SEVII_MT_EMBER,     21 ;  4

	warp_event 15,  0, SEVII_MT_EMBER_7F,   2 ;  5

	warp_event 10, 15, SEVII_MT_EMBER,     22 ;  6
	warp_event 11, 15, SEVII_MT_EMBER,     22 ;  7
	
	warp_event  2, 15, SEVII_MT_EMBER,     23 ;  8
	warp_event  3, 15, SEVII_MT_EMBER,     23 ;  9
	
	warp_event 12,  6, SEVII_MT_EMBER_7F,   3 ; 10

	def_bg_events

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_MT_EMBER_8F
