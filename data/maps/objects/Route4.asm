Route4_Object:
	db $2c ; border block

	def_warp_events
	warp_event 11, 25, MT_MOON_POKECENTER, 1
	warp_event 18, 25, MT_MOON_1F, 1
	warp_event 24, 25, MT_MOON_B1F, 8
	; new warps, top row
	warp_event  5,  1, MT_MOON_1F, 6  ; 4  (1)
	warp_event  9,  1, MT_MOON_1F, 20 ; 5  (10)
	warp_event 15,  1, MT_MOON_1F, 21 ; 6  (13)
	warp_event 19,  1, MT_MOON_1F, 23 ; 7  (18)
	warp_event 23,  1, MT_MOON_1F, 9  ; 8  (19)
	warp_event 29,  1, MT_MOON_1F, 11 ; 9  (40)
	warp_event 33,  1, MT_MOON_1F, 10 ; 10 (53)
	warp_event 59,  1, MT_MOON_1F, 19 ; 11 (36)
	warp_event 63,  1, MT_MOON_1F, 12 ; 12 (31)
	warp_event 71,  1, MT_MOON_1F, 16 ; 13 (32)
	warp_event 79,  1, MT_MOON_1F, 8  ; 14 (3)
	warp_event 49,  1, MT_MOON_1F, 26 ; 15 (12)
	; new warps, middle row
	warp_event 18,  3, MT_MOON_B1F, 12 ; 16 (20)
	warp_event 32,  3, MT_MOON_B1F, 18 ; 17 (23)
	warp_event 40,  3, MT_MOON_B1F, 31 ; 18 (16)
	warp_event 46,  3, MT_MOON_B1F, 10 ; 19 (4)
	warp_event 58,  3, MT_MOON_B1F, 25 ; 20 (25)
	warp_event 70,  3, MT_MOON_B1F, 29 ; 21 (29)
	warp_event 76,  3, MT_MOON_B1F, 20 ; 22 (53)
	warp_event 80,  3, MT_MOON_B1F, 23 ; 23 (48)
	; new warps, bottom row
	warp_event  9,  5, MT_MOON_B2F, 25 ; 24 (11)
	warp_event 13,  5, MT_MOON_B2F, 10 ; 25 (8)
	warp_event 17,  5, MT_MOON_B2F, 7  ; 26 (21)
	warp_event 23,  5, MT_MOON_B2F, 14 ; 27 (22)
	warp_event 33,  5, MT_MOON_B2F, 9  ; 28 (45)
	warp_event 37,  5, MT_MOON_B2F, 15 ; 29 (56)
	warp_event 41,  5, MT_MOON_B2F, 22 ; 30 (27)
	warp_event 47,  5, MT_MOON_B2F, 11 ; 31 (7)
	warp_event 57,  5, MT_MOON_B2F, 24 ; 32 (24)
	warp_event 61,  5, MT_MOON_B2F, 6  ; 33 (6)
	warp_event 65,  5, MT_MOON_B2F, 27 ; 34 (15)
	warp_event 71,  5, MT_MOON_B2F, 28 ; 35 (47)
	warp_event 77,  5, MT_MOON_B2F, 12 ; 36 (9)

	def_bg_events
	bg_event 12, 25, 10 ; PokeCenterSignText
	bg_event 17, 27, 11 ; Route4Text5
	bg_event 27, 27, 12 ; Route4Text6

	def_object_events
	object_event  9, 28, SPRITE_COOLTRAINER_F, WALK, ANY_DIR, 1 ; person
	object_event 20, 30, SPRITE_HIKER, STAY, RIGHT, 2 ; new
	object_event 23, 31, SPRITE_HIKER, STAY, LEFT, 3 ; new
	object_event 63, 23, SPRITE_COOLTRAINER_F, STAY, RIGHT, 4, OPP_COOLTRAINER, 72 ; edited
	object_event 57, 23, SPRITE_POKE_BALL, STAY, NONE, 5, TM_COUNTER
	object_event 41,  4, SPRITE_POKE_BALL, STAY, NONE, 5, TM_CURSE ; new
	object_event 21, 30, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 6 ; new
	object_event 21, 31, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 7 ; new
	object_event 22, 30, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 8 ; new
	object_event 22, 31, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 9 ; new

	def_warps_to ROUTE_4
