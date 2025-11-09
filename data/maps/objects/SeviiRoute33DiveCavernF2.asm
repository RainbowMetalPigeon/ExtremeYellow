SeviiRoute33DiveCavernF2_Object:
	db $20 ; border block

	def_warp_events
	; room 1
	warp_event  8, 19, SEVII_ROUTE_33_DIVE_CAVERN_F1,  3 ;  1
	warp_event  9, 19, SEVII_ROUTE_33_DIVE_CAVERN_F1,  3 ;  2
	warp_event  4,  9, SEVII_ROUTE_33_DIVE_CAVERN_F3,  1 ;  3
	warp_event  8, 15, SEVII_ROUTE_33_DIVE_CAVERN_F3,  5 ;  4
	warp_event 10,  7, SEVII_ROUTE_33_DIVE_CAVERN_F3,  9 ;  5
	; room 2
	warp_event 30, 19, SEVII_ROUTE_33_DIVE_CAVERN_F1,  4 ;  6
	warp_event 31, 19, SEVII_ROUTE_33_DIVE_CAVERN_F1,  4 ;  7
	warp_event 26,  9, SEVII_ROUTE_33_DIVE_CAVERN_F3, 13 ;  8
	warp_event 28, 15, SEVII_ROUTE_33_DIVE_CAVERN_F3, 17 ;  9
	warp_event 32,  7, SEVII_ROUTE_33_DIVE_CAVERN_F3, 21 ; 10
	; room 3
	warp_event 52, 19, SEVII_ROUTE_33_DIVE_CAVERN_F1,  5 ; 11
	warp_event 53, 19, SEVII_ROUTE_33_DIVE_CAVERN_F1,  5 ; 12
	warp_event 48,  7, SEVII_ROUTE_33_DIVE_CAVERN_F3, 25 ; 13
	warp_event 50, 15, SEVII_ROUTE_33_DIVE_CAVERN_F3, 29 ; 14
	warp_event 54,  9, SEVII_ROUTE_33_DIVE_CAVERN_F3, 33 ; 15 ; R2

	def_bg_events

	def_object_events

	def_warps_to SEVII_ROUTE_33_DIVE_CAVERN_F2