SeviiMtEmber1F_Object:
	db $03 ; border block

	def_warp_events
	warp_event 16, 43, SEVII_MT_EMBER,  1 ;  1
	warp_event 17, 43, SEVII_MT_EMBER,  1 ;  2

	warp_event 43, 32, SEVII_MT_EMBER,  2 ;  3
	warp_event 43, 33, SEVII_MT_EMBER,  2 ;  4
	
	warp_event 43,  8, SEVII_MT_EMBER,  3 ;  5
	warp_event 43,  9, SEVII_MT_EMBER,  3 ;  6
	
	warp_event  0, 20, SEVII_MT_EMBER,  4 ;  7
	warp_event  0, 21, SEVII_MT_EMBER,  4 ;  8

	def_bg_events

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_MT_EMBER_1F
