Route30_Object:
	db $f ; border block

	def_warp_events
	warp_event 35,  9, PIKACHU_GROTTO, 1

	def_bg_events
;	bg_event  5, 65, 3 ; Route2Text3

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to ROUTE_30
