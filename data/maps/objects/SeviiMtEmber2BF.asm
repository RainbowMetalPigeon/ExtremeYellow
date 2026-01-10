SeviiMtEmber2BF_Object:
	db $03 ; border block

	def_warp_events
	
	warp_event 49,  2, SEVII_MT_EMBER_1BF,  2 ;  1

	warp_event 43, 19, SEVII_MT_EMBER_3BF,  1 ;  2

	warp_event 40, 48, SEVII_MT_EMBER_3BF,  2 ;  3

	warp_event 29, 49, SEVII_MT_EMBER_1BF,  3 ;  4

	def_bg_events

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_MT_EMBER_2BF

