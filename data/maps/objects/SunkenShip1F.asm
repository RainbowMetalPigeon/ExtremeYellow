SunkenShip1F_Object:
	db $0C ; border block

	def_warp_events
; top floor
	; rooms
	warp_event  9,  4, SUNKEN_SHIP_ROOMS,  1 ;  1, room 1
	warp_event 15,  4, SUNKEN_SHIP_ROOMS,  2 ;  2, room 2
	warp_event 27,  4, SUNKEN_SHIP_ROOMS,  3 ;  3, room 3
	warp_event 33,  4, SUNKEN_SHIP_ROOMS,  4 ;  4, room 4 (blocked)
	warp_event 27, 19, SUNKEN_SHIP_ROOMS,  5 ;  5, room 7 (blocked)
	warp_event 33, 19, SUNKEN_SHIP_ROOMS,  7 ;  6, room 8
	; stairs
	warp_event 21,  5, SUNKEN_SHIP_1F,    17 ;  7
	warp_event 34, 10, SUNKEN_SHIP_1F,    19 ;  8
	warp_event 22, 18, SUNKEN_SHIP_1F,    22 ;  9

; mid floor
	; rooms
	warp_event  9, 32, SUNKEN_SHIP_ROOMS,  9 ; 10, room 1
	warp_event 15, 32, SUNKEN_SHIP_ROOMS, 10 ; 11, room 2 (blocked)
	warp_event 27, 32, SUNKEN_SHIP_ROOMS, 11 ; 12, room 3
	warp_event  9, 47, SUNKEN_SHIP_ROOMS, 12 ; 13, room 5 (blocked)
	warp_event 15, 47, SUNKEN_SHIP_ROOMS, 14 ; 14, room 6
	warp_event 33, 47, SUNKEN_SHIP_ROOMS, 16 ; 15, room 8
	warp_event  0, 39, SUNKEN_SHIP_ROOMS, 26 ; 16, captain's room
	; stairs
	warp_event 21, 33, SUNKEN_SHIP_1F,     7 ; 17
	warp_event 23, 33, SUNKEN_SHIP_1F,    30 ; 18
	warp_event 34, 38, SUNKEN_SHIP_1F,     8 ; 19
	warp_event  7, 39, SUNKEN_SHIP_1F,    31 ; 20
	warp_event 34, 40, SUNKEN_SHIP_1F,    32 ; 21
	warp_event 22, 46, SUNKEN_SHIP_1F,     9 ; 22
	; entrance
	warp_event 20, 51, ROUTE_21_DIVE,      1 ; 23, entrance
	warp_event 21, 51, ROUTE_21_DIVE,      1 ; 24, entrance

; bottom floor
	; rooms
	warp_event 15, 60, SUNKEN_SHIP_ROOMS, 18 ; 25, room 2 (blocked)
	warp_event 33, 60, SUNKEN_SHIP_ROOMS, 19 ; 26, room 4
	warp_event 15, 75, SUNKEN_SHIP_ROOMS, 20 ; 27, room 6
	warp_event 27, 75, SUNKEN_SHIP_ROOMS, 22 ; 28, room 7
	warp_event 33, 75, SUNKEN_SHIP_ROOMS, 24 ; 29, room 8
	; stairs
	warp_event 23, 61, SUNKEN_SHIP_1F,    18 ; 30
	warp_event  7, 67, SUNKEN_SHIP_1F,    20 ; 31
	warp_event 34, 68, SUNKEN_SHIP_1F,    21 ; 32

	def_bg_events
	; top floor
	bg_event 33,  5,  1 ; locked door
	bg_event  9, 19,  2 ; broken door
	bg_event 15, 19,  3 ; broken door
	bg_event 27, 19,  4 ; locked door
	; mid floor
	bg_event 15, 33,  5 ; locked door
	bg_event 33, 33,  6 ; broken door
	bg_event  9, 47,  7 ; locked door
	bg_event 27, 47,  8 ; broken door
	; bottom floor
	bg_event  9, 61,  9 ; broken door
	bg_event 15, 61, 10 ; locked door
	bg_event 27, 61, 11 ; broken door
	bg_event  9, 75, 12 ; broken door
	bg_event 33, 75, 13 ; locked door

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SUNKEN_SHIP_1F
