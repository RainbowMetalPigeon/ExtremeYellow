SeviiMtEmber3BF_Object:
	db $03 ; border block

	def_warp_events

	warp_event 45, 21, SEVII_MT_EMBER_2BF,  2 ;  1

	warp_event 42, 50, SEVII_MT_EMBER_2BF,  3 ;  2

	def_bg_events

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_MT_EMBER_3BF
