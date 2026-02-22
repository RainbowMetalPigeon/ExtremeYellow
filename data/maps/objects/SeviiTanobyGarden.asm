SeviiTanobyGarden_Object:
	db $43 ; border block

	def_warp_events
	warp_event  8, 13, SEVII_TANOBY_CHAMBERS, 15
	warp_event  9, 13, SEVII_TANOBY_CHAMBERS, 15
	warp_event  8,  3, SEVII_TANOBY_DEN, 1

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
;	object_event 25,  5, SPRITE_POKE_BALL, STAY, NONE, 1, NUGGET

	def_warps_to SEVII_TANOBY_GARDEN
