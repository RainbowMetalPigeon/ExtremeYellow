HauntedHouse1_Object:
	db $f ; border block

	def_warp_events
	; first room
	warp_event  4, 57, HAUNTED_HOUSE_1,  1 ;  1 ; purposely doesn't work
	warp_event  2, 48, HAUNTED_HOUSE_1,  3 ;  2
	warp_event  7, 48, HAUNTED_HOUSE_1,  2 ;  3
	warp_event  9, 53, HAUNTED_HOUSE_1,  7 ;  4
	warp_event  0, 52, HAUNTED_HOUSE_1,  1 ;  5
	warp_event  4, 48, HAUNTED_HOUSE_1, 14 ;  6
	; second room
	warp_event 19, 48, HAUNTED_HOUSE_1,  7 ;  7 ; on itself, for trapping
	warp_event 25, 55, HAUNTED_HOUSE_1, 12 ;  8
	warp_event 16, 52, HAUNTED_HOUSE_1,  9 ;  9
	warp_event 18, 59, HAUNTED_HOUSE_1,  5 ; 10
	warp_event 23, 59, HAUNTED_HOUSE_1, 16 ; 11 ; TBE
	; long room
	warp_event 59, 34, HAUNTED_HOUSE_1,  1 ; 12 ; purposely doesn't work
	warp_event 59,  8, HAUNTED_HOUSE_1,  8 ; 13
	; ledge room
	warp_event 12, 18, HAUNTED_HOUSE_1, 14 ; 14 ; on itself, for trapping
	warp_event 13, 31, HAUNTED_HOUSE_1,  1 ; 15
	; wide room
	warp_event  5,  0, HAUNTED_HOUSE_1,  1 ; 16 ; TBE
	warp_event 12,  0, HAUNTED_HOUSE_1,  1 ; 17 ; TBE
	warp_event 20,  0, HAUNTED_HOUSE_1,  1 ; 18 ; TBE
	warp_event 28,  0, HAUNTED_HOUSE_1,  1 ; 19 ; TBE
	warp_event 36,  0, HAUNTED_HOUSE_1,  1 ; 20 ; TBE
	warp_event 44,  0, HAUNTED_HOUSE_1,  1 ; 21 ; TBE
	warp_event 52,  0, HAUNTED_HOUSE_1,  1 ; 22 ; TBE



	def_bg_events
;	bg_event  6,  9, 9 ; CeladonMansion2TextSign1

	def_object_events
;	object_event  2,  4, SPRITE_BIRD, STAY, ANY_DIR, 1

	def_warps_to HAUNTED_HOUSE_1
