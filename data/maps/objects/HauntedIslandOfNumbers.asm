HauntedIslandOfNumbers_Object:
	db $4 ; border block

	def_warp_events
;	warp_event 29, 58, HAUNTED_ISLAND_OF_NUMBERS,  1 ; 1 ; on itself, not meant to work, arrive only
	warp_event 30, 35, HAUNTED_ISLAND_OF_NUMBERS,  1 ; 1 ; just a test

	def_bg_events
;	bg_event  6,  9, 9 ; CeladonMansion2TextSign1

	def_object_events
	object_event 30, 29, SPRITE_MISSINGNO, STAY, DOWN, 1

	def_warps_to HAUNTED_ISLAND_OF_NUMBERS
