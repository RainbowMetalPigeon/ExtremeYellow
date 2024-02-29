HauntedHouse1_Object:
	db $f ; border block

	def_warp_events
	warp_event  4,  5, HAUNTED_HOUSE_1, 1

	def_bg_events
;	bg_event  6,  9, 9 ; CeladonMansion2TextSign1

	def_object_events
;	object_event  2,  4, SPRITE_BIRD, STAY, ANY_DIR, 1 ; Pigeon

	def_warps_to HAUNTED_HOUSE_1
