MtMoonB1F_Object:
	db $3 ; border block

	def_warp_events
	; old warps, edited: x+16, y+16
	warp_event 21, 21, MT_MOON_1F, 3
	warp_event 33, 27, MT_MOON_B2F, 1
	warp_event 41, 25, MT_MOON_1F, 4
	warp_event 41, 31, MT_MOON_1F, 5
	warp_event 37, 33, MT_MOON_B2F, 2
	warp_event 29, 43, MT_MOON_B2F, 3
	warp_event 39, 19, MT_MOON_B2F, 4
	warp_event 43, 19, LAST_MAP, 3
	; new warps
	warp_event  7,  5, MT_MOON_1F,  7  ; 9  (2)
	warp_event 21,  5, ROUTE_4,     19 ; 10 (4)
	warp_event  3, 13, MT_MOON_B2F, 5  ; 11 (5)

	warp_event 27,  7, ROUTE_4,     16 ; 12 (20)
	warp_event 41,  5, MT_MOON_1F,  13 ; 13 (39)
	warp_event 43, 15, MT_MOON_B2F, 13 ; 14 (41)
	warp_event 55, 15, MT_MOON_B2F, 21 ; 15 (42)

	warp_event  9, 15, MT_MOON_B2F, 8  ; 16 (46)

	warp_event 27, 21, MT_MOON_1F,  15 ; 17 (51)

	warp_event 17, 25, ROUTE_4,     17 ; 18 (23)

	warp_event 23, 41, MT_MOON_B2F, 16 ; 19 (52)

	warp_event 35, 39, ROUTE_4,     22 ; 20 (53)

	warp_event 47, 23, MT_MOON_1F,  14 ; 21 (49)
	warp_event 51, 31, MT_MOON_B2F, 17 ; 22 (50)
	warp_event 57, 27, ROUTE_4,     23 ; 23 (48)

	warp_event  5, 23, MT_MOON_1F,  17 ; 24 (33)
	warp_event  7, 31, ROUTE_4,     20 ; 25 (25)
	warp_event 15, 37, MT_MOON_B2F, 19 ; 26 (34)

	warp_event 47, 49, MT_MOON_1F,  24 ; 27 (30)
	warp_event 51, 39, MT_MOON_B2F, 23 ; 28 (26)
	warp_event 57, 49, ROUTE_4,     21 ; 29 (29)

	warp_event 27, 59, MT_MOON_1F,  22 ; 30 (17)
	warp_event 33, 47, ROUTE_4,     18 ; 31 (16)
	warp_event 47, 53, MT_MOON_B2F, 26 ; 32 (14)

	warp_event  5, 47, MT_MOON_1F,  18 ; 33 (37)
	warp_event 21, 53, MT_MOON_B2F, 18 ; 34 (38)

	warp_event  7, 53, MT_MOON_1F,  25 ; 35 (44)
	warp_event 17, 51, MT_MOON_B2F, 20 ; 36 (43)


	def_bg_events

	def_object_events

	def_warps_to MT_MOON_B1F
