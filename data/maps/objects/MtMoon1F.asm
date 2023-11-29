MtMoon1F_Object:
	db $3 ; border block

	def_warp_events
	; old warps, edited, +24 on the y coordinate
	warp_event 14, 59, ROUTE_4, 2 ; edited, explicit warp
	warp_event 15, 59, ROUTE_4, 2 ; edited, explicit warp
	warp_event  5, 29, MT_MOON_B1F, 1
	warp_event 17, 35, MT_MOON_B1F, 3
	warp_event 25, 39, MT_MOON_B1F, 4
	; new warps
	warp_event  3,  3, ROUTE_4,     4  ; 6  (1)
	warp_event  6,  4, MT_MOON_B1F, 9  ; 7  (2)
	warp_event 55,  3, ROUTE_4,     14 ; 8  (3)

	warp_event 13,  5, ROUTE_4,     8  ; 9  (19)
	warp_event 22,  4, ROUTE_4,     10 ; 10 (53)

	warp_event 27,  3, ROUTE_4,     9  ; 11 (40)
	warp_event 35,  5, ROUTE_4,     12 ; 12 (31)
	warp_event 44,  8, MT_MOON_B1F, 13 ; 13 (39)

	warp_event 50,  4, MT_MOON_B1F, 21 ; 14 (49)
	warp_event 49,  8, MT_MOON_B1F, 17 ; 15 (51)

	warp_event 48, 14, ROUTE_4,     13 ; 16 (32)

	warp_event 20, 11, MT_MOON_B1F, 24 ; 17 (33)
	warp_event 30, 14, MT_MOON_B1F, 33 ; 18 (37)
	warp_event 38, 18, ROUTE_4,     11 ; 19 (36)

	warp_event 44, 16, ROUTE_4,     5  ; 20 (10)
	warp_event 52, 32, ROUTE_4,     6  ; 21 (13)

	warp_event 54, 54, MT_MOON_B1F, 30 ; 22 (17)
	warp_event 42, 44, ROUTE_4,     7  ; 23 (18)

	warp_event 47, 48, MT_MOON_B1F, 27 ; 24 (30)

	warp_event 41, 50, MT_MOON_B1F, 35 ; 25 (44)

	warp_event 42,  2, ROUTE_4,     15 ; 26 (12)


	def_bg_events ; edited, +24 on the y coordinate
	bg_event 15, 47, 14 ; MtMoon1Text14

	def_object_events ; edited, +24 on the y coordinate
	object_event  5, 30, SPRITE_HIKER, STAY, DOWN, 1, OPP_HIKER, 1
	object_event 12, 40, SPRITE_YOUNGSTER, STAY, RIGHT, 2, OPP_YOUNGSTER, 3
	object_event 30, 28, SPRITE_COOLTRAINER_F, STAY, DOWN, 3, OPP_LASS, 5
	object_event 24, 55, SPRITE_SUPER_NERD, STAY, UP, 4, OPP_SUPER_NERD, 1
	object_event 16, 47, SPRITE_COOLTRAINER_F, STAY, DOWN, 5, OPP_LASS, 6
	object_event  7, 46, SPRITE_YOUNGSTER, STAY, DOWN, 6, OPP_BUG_CATCHER, 7
	object_event 30, 51, SPRITE_YOUNGSTER, STAY, RIGHT, 7, OPP_BUG_CATCHER, 8
	object_event  2, 44, SPRITE_POKE_BALL, STAY, NONE, 8, POTION
	object_event  2, 26, SPRITE_POKE_BALL, STAY, NONE, 9, MOON_STONE
	object_event 35, 55, SPRITE_POKE_BALL, STAY, NONE, 10, RARE_CANDY
	object_event 36, 47, SPRITE_POKE_BALL, STAY, NONE, 11, ESCAPE_ROPE
	object_event 20, 57, SPRITE_POKE_BALL, STAY, NONE, 12, POTION
	object_event  5, 56, SPRITE_POKE_BALL, STAY, NONE, 13, TM_METRONOME

	def_warps_to MT_MOON_1F
