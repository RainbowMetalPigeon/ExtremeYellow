CopycatsHouse1F_Object:
	db $a ; border block

	def_warp_events
	warp_event  2,  7, LAST_MAP, 1
	warp_event  3,  7, LAST_MAP, 1
	warp_event  7,  1, COPYCATS_HOUSE_2F, 1

	def_bg_events

	def_object_events
	object_event  2,  2, SPRITE_MIDDLE_AGED_WOMAN, STAY, DOWN, 1 ; parent 1
	object_event  5,  4, SPRITE_ERIKA, STAY, LEFT, 2 ; parent 2, edited
	object_event  1,  4, SPRITE_CHANSEY, STAY, NONE, 3 ; person

	def_warps_to COPYCATS_HOUSE_1F
