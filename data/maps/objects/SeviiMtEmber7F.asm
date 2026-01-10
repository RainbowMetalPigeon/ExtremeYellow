SeviiMtEmber7F_Object:
	db $03 ; border block

	def_warp_events

	warp_event  5,  3, SEVII_MT_EMBER_6F,   5 ;  1

	warp_event 17,  2, SEVII_MT_EMBER_8F,   5 ;  1

	def_bg_events

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_MT_EMBER_7F
