SunkenShipRooms_Object:
	db $0C ; border block

	def_warp_events
; top floor

; mid floor
	warp_event  2, 55, SUNKEN_SHIP_1F,  3 ;  1, room 5
	warp_event  3, 55, SUNKEN_SHIP_1F,  3 ;  2, room 5

; bottom floor

	def_bg_events

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SUNKEN_SHIP_ROOMS
