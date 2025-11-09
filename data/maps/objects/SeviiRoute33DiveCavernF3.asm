SeviiRoute33DiveCavernF3_Object:
	db $20 ; border block

	def_warp_events
	; room 1
	warp_event  4,  9, SEVII_ROUTE_33_DIVE_CAVERN_F2,  3 ;  1
	warp_event  5,  9, SEVII_ROUTE_33_DIVE_CAVERN_F2,  3 ;  2
	warp_event  2,  5, SEVII_ROUTE_33_DIVE_CAVERN_F4,  1 ;  3
	warp_event  8,  5, SEVII_ROUTE_33_DIVE_CAVERN_F4,  3 ;  4
	; room 2
	warp_event 22,  9, SEVII_ROUTE_33_DIVE_CAVERN_F2,  4 ;  5
	warp_event 23,  9, SEVII_ROUTE_33_DIVE_CAVERN_F2,  4 ;  6
	warp_event 20,  5, SEVII_ROUTE_33_DIVE_CAVERN_F4,  5 ;  7
	warp_event 26,  5, SEVII_ROUTE_33_DIVE_CAVERN_F4,  7 ;  8
	; room 3
	warp_event 40,  9, SEVII_ROUTE_33_DIVE_CAVERN_F2,  5 ;  9
	warp_event 41,  9, SEVII_ROUTE_33_DIVE_CAVERN_F2,  5 ; 10
	warp_event 38,  5, SEVII_ROUTE_33_DIVE_CAVERN_F4,  9 ; 11
	warp_event 44,  5, SEVII_ROUTE_33_DIVE_CAVERN_F4, 11 ; 12
	; room 4
	warp_event 58,  9, SEVII_ROUTE_33_DIVE_CAVERN_F2,  8 ; 13
	warp_event 59,  9, SEVII_ROUTE_33_DIVE_CAVERN_F2,  8 ; 14
	warp_event 56,  5, SEVII_ROUTE_33_DIVE_CAVERN_F4, 13 ; 15
	warp_event 62,  5, SEVII_ROUTE_33_DIVE_CAVERN_F4, 15 ; 16
	; room 5
	warp_event 76,  9, SEVII_ROUTE_33_DIVE_CAVERN_F2,  9 ; 17
	warp_event 77,  9, SEVII_ROUTE_33_DIVE_CAVERN_F2,  9 ; 18
	warp_event 74,  5, SEVII_ROUTE_33_DIVE_CAVERN_F4, 17 ; 19
	warp_event 80,  5, SEVII_ROUTE_33_DIVE_CAVERN_F4, 19 ; 20
	; room 6
	warp_event 94,  9, SEVII_ROUTE_33_DIVE_CAVERN_F2, 10 ; 21
	warp_event 95,  9, SEVII_ROUTE_33_DIVE_CAVERN_F2, 10 ; 22
	warp_event 92,  5, SEVII_ROUTE_33_DIVE_CAVERN_F4, 21 ; 23
	warp_event 98,  5, SEVII_ROUTE_33_DIVE_CAVERN_F4, 23 ; 24
	; room 7
	warp_event 112,  9, SEVII_ROUTE_33_DIVE_CAVERN_F2, 13 ; 25
	warp_event 113,  9, SEVII_ROUTE_33_DIVE_CAVERN_F2, 13 ; 26
	warp_event 110,  5, SEVII_ROUTE_33_DIVE_CAVERN_F4, 25 ; 27
	warp_event 116,  5, SEVII_ROUTE_33_DIVE_CAVERN_F4, 27 ; 28
	; room 8
	warp_event 130,  9, SEVII_ROUTE_33_DIVE_CAVERN_F2, 14 ; 29
	warp_event 131,  9, SEVII_ROUTE_33_DIVE_CAVERN_F2, 14 ; 30
	warp_event 128,  5, SEVII_ROUTE_33_DIVE_CAVERN_F4, 29 ; 31
	warp_event 134,  5, SEVII_ROUTE_33_DIVE_CAVERN_F4, 31 ; 32
	; room 9
	warp_event 148,  9, SEVII_ROUTE_33_DIVE_CAVERN_F2, 15 ; 33
	warp_event 149,  9, SEVII_ROUTE_33_DIVE_CAVERN_F2, 15 ; 34
	warp_event 146,  5, SEVII_ROUTE_33_DIVE_CAVERN_F4, 33 ; 35
	warp_event 152,  5, SEVII_ROUTE_33_DIVE_CAVERN_F4, 35 ; 36 ; R3
	def_bg_events

	def_object_events

	def_warps_to SEVII_ROUTE_33_DIVE_CAVERN_F3