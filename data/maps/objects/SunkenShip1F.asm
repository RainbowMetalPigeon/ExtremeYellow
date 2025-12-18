SunkenShip1F_Object:
	db $0C ; border block

	def_warp_events
	warp_event 20, 23, ROUTE_21_DIVE, 1
	warp_event 21, 23, ROUTE_21_DIVE, 1

	def_bg_events

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SUNKEN_SHIP_1F
