HauntedHouse2_Object:
	db $f ; border block

	; rooms go from bottom left to bottom right,
	; then second-bottomest row, left to right, etc
	; up to top row, ending top-right
	def_warp_events
	; room 1
	warp_event  2, 35, HAUNTED_HOUSE_2, 24 ; 1, this is the entrance, we arrive to here from HAUNTED_HOUSE_1, but also Right Warp 1 = RW1
	warp_event  5, 33, HAUNTED_HOUSE_2, 20 ; 2
	warp_event  3, 30, HAUNTED_HOUSE_2, 25 ; 3
	warp_event  0, 32, HAUNTED_HOUSE_2, 36 ; 4
	; room 2
	warp_event 14, 35, HAUNTED_HOUSE_2,  2 ; 5
	warp_event 17, 33, HAUNTED_HOUSE_2, 14 ; 6
	warp_event 15, 30, HAUNTED_HOUSE_2,  7 ; 7
	warp_event 12, 32, HAUNTED_HOUSE_2, 15 ; 8, RW4
	; room 3
	warp_event 26, 35, HAUNTED_HOUSE_2, 31 ; 9
	warp_event 29, 33, HAUNTED_HOUSE_2, 28 ; 10
	; room 4
	warp_event  2, 25, HAUNTED_HOUSE_2,  4 ; 11
	warp_event  5, 23, HAUNTED_HOUSE_2, 25 ; 12
	warp_event  3, 20, HAUNTED_HOUSE_2,  5 ; 13, RW3
	warp_event  0, 22, HAUNTED_HOUSE_2, 10 ; 14
	; room 5
	warp_event 14, 25, HAUNTED_HOUSE_3, 19 ; 15 ; RW5, exit, dark maze
	warp_event 17, 23, HAUNTED_HOUSE_2, 35 ; 16
	warp_event 15, 20, HAUNTED_HOUSE_2, 20 ; 17
	warp_event 12, 22, HAUNTED_HOUSE_2,  3 ; 18
	; room 6
	warp_event 29, 23, HAUNTED_HOUSE_2, 19 ; 19
	warp_event 24, 22, HAUNTED_HOUSE_2,  2 ; 20
	; room 7
	warp_event  2, 15, HAUNTED_HOUSE_2, 32 ; 21
	warp_event  5, 13, HAUNTED_HOUSE_2, 12 ; 22, RW2
	warp_event  3, 10, HAUNTED_HOUSE_2, 30 ; 23
	warp_event  0, 12, HAUNTED_HOUSE_2, 24 ; 24
	; room 8
	warp_event 14, 15, HAUNTED_HOUSE_2,  1 ; 25
	warp_event 15, 10, HAUNTED_HOUSE_2, 32 ; 26, purposely doesn't work
	; room 9
	warp_event 26, 15, HAUNTED_HOUSE_2, 20 ; 27
	warp_event 29, 13, HAUNTED_HOUSE_2, 34 ; 28
	warp_event 24, 12, HAUNTED_HOUSE_2, 26 ; 29
	; room 10
	warp_event  5,  3, HAUNTED_HOUSE_2, 10 ; 30
	warp_event  3,  0, HAUNTED_HOUSE_2, 20 ; 31
	; room 11
	warp_event 14,  5, HAUNTED_HOUSE_2, 32 ; 32
	warp_event 17,  3, HAUNTED_HOUSE_2, 31 ; 33
	; room 12
	warp_event 26,  5, HAUNTED_HOUSE_2, 33 ; 34
	warp_event 29,  3, HAUNTED_HOUSE_2, 29 ; 35
	warp_event 27,  0, HAUNTED_HOUSE_2, 29 ; 36

	def_bg_events
	bg_event  2,  3,  1 ; HauntedHouse2TextSignR1C1
	bg_event 14,  3,  2 ; HauntedHouse2TextSignR1C2
	bg_event 26,  3,  3 ; HauntedHouse2TextSignR1C3
	bg_event  2, 13,  4 ; HauntedHouse2TextSignR2C1
	bg_event 14, 13,  5 ; HauntedHouse2TextSignR2C2
	bg_event 26, 13,  6 ; HauntedHouse2TextSignR2C3
	bg_event  2, 23,  7 ; HauntedHouse2TextSignR3C1
	bg_event 14, 23,  8 ; HauntedHouse2TextSignR3C2
	bg_event 26, 23,  9 ; HauntedHouse2TextSignR3C3
	bg_event  2, 33, 10 ; HauntedHouse2TextSignR4C1
	bg_event 14, 33, 11 ; HauntedHouse2TextSignR4C2
	bg_event 26, 33, 12 ; HauntedHouse2TextSignR4C3

	def_object_events
;	object_event  2,  4, SPRITE_BIRD, STAY, ANY_DIR, 1

	def_warps_to HAUNTED_HOUSE_2
