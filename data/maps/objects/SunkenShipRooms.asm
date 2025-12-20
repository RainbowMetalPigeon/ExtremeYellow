SunkenShipRooms_Object:
	db $0C ; border block

	def_warp_events
; top floor
	warp_event  2, 12, SUNKEN_SHIP_1F,  1 ;  1, room 1
	warp_event 14, 12, SUNKEN_SHIP_1F,  2 ;  2, room 2
	warp_event 26, 12, SUNKEN_SHIP_1F,  3 ;  3, room 3
	warp_event 38, 12, SUNKEN_SHIP_1F,  4 ;  4, room 4
	warp_event 26, 31, SUNKEN_SHIP_1F,  5 ;  5, room 7
	warp_event 27, 31, SUNKEN_SHIP_1F,  5 ;  6, room 7
	warp_event 38, 31, SUNKEN_SHIP_1F,  6 ;  7, room 8
	warp_event 39, 31, SUNKEN_SHIP_1F,  6 ;  8, room 8

; mid floor
	warp_event  2, 36, SUNKEN_SHIP_1F, 10 ;  9, room 1
	warp_event 14, 36, SUNKEN_SHIP_1F, 11 ; 10, room 2
	warp_event 26, 36, SUNKEN_SHIP_1F, 12 ; 11, room 3
	warp_event  2, 55, SUNKEN_SHIP_1F, 13 ; 12, room 5
	warp_event  3, 55, SUNKEN_SHIP_1F, 13 ; 13, room 5
	warp_event 14, 55, SUNKEN_SHIP_1F, 14 ; 14, room 6
	warp_event 15, 55, SUNKEN_SHIP_1F, 14 ; 15, room 6
	warp_event 38, 55, SUNKEN_SHIP_1F, 15 ; 16, room 8
	warp_event 39, 55, SUNKEN_SHIP_1F, 15 ; 17, room 8

; bottom floor
	warp_event 14, 60, SUNKEN_SHIP_1F, 25 ; 18, room 2
	warp_event 38, 60, SUNKEN_SHIP_1F, 26 ; 19, room 4
	warp_event 14, 79, SUNKEN_SHIP_1F, 27 ; 20, room 6
	warp_event 15, 79, SUNKEN_SHIP_1F, 27 ; 21, room 6
	warp_event 26, 79, SUNKEN_SHIP_1F, 28 ; 22, room 7
	warp_event 27, 79, SUNKEN_SHIP_1F, 28 ; 23, room 7
	warp_event 38, 79, SUNKEN_SHIP_1F, 29 ; 24, room 8
	warp_event 39, 79, SUNKEN_SHIP_1F, 29 ; 25, room 8

; captain's room
	warp_event 41,  4, SUNKEN_SHIP_1F, 16 ; 26
	warp_event 41,  5, SUNKEN_SHIP_1F, 16 ; 27

	def_bg_events

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SUNKEN_SHIP_ROOMS
