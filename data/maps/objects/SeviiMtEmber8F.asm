SeviiMtEmber8F_Object:
	db $03 ; border block

	def_warp_events

	warp_event 15,  2, SEVII_MT_EMBER,     15 ;  1
	warp_event 15,  3, SEVII_MT_EMBER,     15 ;  2

	warp_event 15, 12, SEVII_MT_EMBER,     16 ;  3
	warp_event 15, 13, SEVII_MT_EMBER,     16 ;  4

	warp_event 15,  0, SEVII_MT_EMBER_7F,   1 ;  5

	def_bg_events

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_MT_EMBER_8F
