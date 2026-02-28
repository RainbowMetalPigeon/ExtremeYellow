SeviiTanobyGarden_Object:
	db $43 ; border block

	def_warp_events
	warp_event  8, 13, SEVII_TANOBY_CHAMBERS, 15
	warp_event  9, 13, SEVII_TANOBY_CHAMBERS, 15
	warp_event  8,  3, SEVII_TANOBY_DEN, 1

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
	object_event  8,  8, SPRITE_MEW, STAY, DOWN, 1
	object_event 13,  8, SPRITE_MEW, STAY, DOWN, 2
	object_event 13,  5, SPRITE_MEW, STAY, DOWN, 3
	object_event 10,  6, SPRITE_MEW, STAY, DOWN, 4
	object_event  7,  9, SPRITE_MEW, STAY, DOWN, 5
	object_event  4, 12, SPRITE_MEW, STAY, DOWN, 6
	object_event  5,  4, SPRITE_MEW, STAY, DOWN, 7
	object_event 11, 12, SPRITE_MEW, STAY, DOWN, 8

	def_warps_to SEVII_TANOBY_GARDEN
