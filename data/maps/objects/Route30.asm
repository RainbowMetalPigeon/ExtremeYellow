Route30_Object:
	db $f ; border block

	def_warp_events
;	warp_event 35,  9, PIKACHU_GROTTO, 1

	def_bg_events
	bg_event  9, 38, 3 ; Route30SignText1

	def_object_events
	object_event  7, 20, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 1
	object_event 14, 34, SPRITE_MONSTER, STAY, ANY_DIR, 2

	def_warps_to ROUTE_30
