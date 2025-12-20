SunkenShip1F_Object:
	db $0C ; border block

	def_warp_events
; top floor

; mid floor
	warp_event 20, 51, ROUTE_21_DIVE, 1 ;  1 entrance
	warp_event 21, 51, ROUTE_21_DIVE, 1 ;  2 entrance
;	warp_event  0, 39, SUNKEN_SHIP_ROOMS, nn ; xx captain's room
	; rooms
	warp_event  9, 47, SUNKEN_SHIP_ROOMS, 1 ;  3, room 5
	; stairs

; bottom floor

	def_bg_events

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SUNKEN_SHIP_1F
