MtMoonB2F_Object:
	db $3 ; border block

	def_warp_events
	; old warps, edited, +24 on the y coordinate
	warp_event 25, 33, MT_MOON_B1F, 2
	warp_event 21, 41, MT_MOON_B1F, 5
	warp_event 15, 51, MT_MOON_B1F, 6
	warp_event  5, 31, MT_MOON_B1F, 7
	; new warps
	warp_event  2,  2, MT_MOON_B1F, 11 ; 5  (5)
	warp_event 25,  3, ROUTE_4,     33 ; 6  (6)

	warp_event  3,  7, ROUTE_4,     26 ; 7  (21)
	warp_event 19,  7, MT_MOON_B1F, 16 ; 8  (46)
	warp_event 31,  3, ROUTE_4,     28 ; 9  (45)

	warp_event  3, 13, ROUTE_4,     25 ; 10 (8)
	warp_event 15, 23, ROUTE_4,     31 ; 11 (7)
	warp_event 21, 11, ROUTE_4,     36 ; 12 (9)

	warp_event 23, 19, MT_MOON_B1F, 14 ; 13 (41)

	warp_event 27, 11, ROUTE_4,     27 ; 14 (22)
	warp_event 41,  1, ROUTE_4,     29 ; 15 (56)

	warp_event 31, 19, MT_MOON_B1F, 19 ; 16 (52)
	warp_event 43, 23, MT_MOON_B1F, 22 ; 17 (50)

	warp_event 39, 19, MT_MOON_B1F, 34 ; 18 (38)

	warp_event 50, 18, MT_MOON_B1F, 26 ; 19 (34)

	warp_event 46, 20, MT_MOON_B1F, 36 ; 20 (43)
	warp_event 50, 34, MT_MOON_B1F, 15 ; 21 (42)

	warp_event 43, 35, ROUTE_4,     30 ; 22 (27)
	warp_event 45, 57, MT_MOON_B1F, 28 ; 23 (26)
	warp_event 47, 43, ROUTE_4,     32 ; 24 (24)

	warp_event  3, 39, ROUTE_4,     24 ; 25 (11)
	warp_event  4, 56, MT_MOON_B1F, 32 ; 26 (14)
	warp_event 38, 52, ROUTE_4,     34 ; 27 (15)

	warp_event 58,  2, ROUTE_4,     35 ; 28 (47)
	warp_event 58, 56, CELADON_CITY, 15 ; 29


	def_bg_events

	def_object_events ; edited, +24 on the y coordinate
	object_event 12, 32, SPRITE_SUPER_NERD, STAY, RIGHT, 1, OPP_SUPER_NERD, 2
	object_event  9, 27, SPRITE_JESSIE, STAY, LEFT, 2
	object_event 15, 46, SPRITE_ROCKET, STAY, DOWN, 3, OPP_ROCKET, 2
	object_event 29, 35, SPRITE_ROCKET, STAY, UP, 4, OPP_ROCKET, 3
	object_event 29, 41, SPRITE_ROCKET, STAY, LEFT, 5, OPP_ROCKET, 1
	object_event  9, 28, SPRITE_JAMES, STAY, LEFT, 6
	object_event 12, 30, SPRITE_FOSSIL, STAY, NONE, 7 ; person
	object_event 13, 30, SPRITE_FOSSIL, STAY, NONE, 8 ; person
	object_event 25, 45, SPRITE_POKE_BALL, STAY, NONE, 9, HP_UP
	object_event 29, 29, SPRITE_POKE_BALL, STAY, NONE, 10, TM_MEGA_PUNCH

	def_warps_to MT_MOON_B2F
