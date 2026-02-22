SeviiTanobyDen_Object:
	db $03 ; border block

	def_warp_events
	warp_event  4,  9, SEVII_TANOBY_GARDEN, 3
	warp_event  5,  9, SEVII_TANOBY_GARDEN, 3

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
;	object_event 25,  5, SPRITE_POKE_BALL, STAY, NONE, 1, NUGGET

	def_warps_to SEVII_TANOBY_DEN
