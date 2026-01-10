SeviiMtEmber9F_Object:
	db $03 ; border block

	def_warp_events
	warp_event  8, 11, SEVII_MT_EMBER,     17 ;  1
	warp_event  9, 11, SEVII_MT_EMBER,     17 ;  2
	
	warp_event  0,  4, SEVII_MT_EMBER,     18 ;  3
	warp_event  0,  5, SEVII_MT_EMBER,     18 ;  4

	warp_event  2,  9, SEVII_MT_EMBER_10F,  3 ;  5

	warp_event  2,  2, SEVII_MT_EMBER_10F,  4 ;  6

	def_bg_events

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_MT_EMBER_9F
