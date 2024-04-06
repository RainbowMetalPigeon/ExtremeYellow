HauntedHouse1_Object:
	db $f ; border block

	def_warp_events
	; first room
	warp_event  4, 57, HAUNTED_HOUSE_1,  1 ;  1 ; purposely doesn't work
	warp_event  2, 48, HAUNTED_HOUSE_1, 20 ;  2 ; -> small room
	warp_event  7, 48, HAUNTED_HOUSE_1,  3 ;  3 ; -> itself
	warp_event  9, 53, HAUNTED_HOUSE_1,  6 ;  4 ; -> second room
	warp_event  4, 48, HAUNTED_HOUSE_1, 13 ;  5 ; -> ledge room
	; second room
	warp_event 19, 48, HAUNTED_HOUSE_1,  6 ;  6 ; -> itself, for trapping
	warp_event 25, 55, HAUNTED_HOUSE_1, 11 ;  7 ; -> long room
	warp_event 16, 52, HAUNTED_HOUSE_4, 16 ;  8 ; -> small connected room, SW
	warp_event 18, 59, HAUNTED_HOUSE_1,  1 ;  9 ; -> first room
	warp_event 23, 59, HAUNTED_HOUSE_1, 15 ; 10 ; -> wide room
	; long room
	warp_event 59, 34, HAUNTED_HOUSE_1,  1 ; 11 ; purposely doesn't work
	warp_event 59,  8, HAUNTED_HOUSE_1,  7 ; 12 ; -> second room
	; ledge room
	warp_event 12, 18, HAUNTED_HOUSE_1, 13 ; 13 ; -> itself, for trapping
	warp_event 13, 31, HAUNTED_HOUSE_1,  1 ; 14 ; -> first room
	; wide room
	warp_event  5,  0, HAUNTED_HOUSE_1,  1 ; 15 ; -> first room
	warp_event 12,  0, HAUNTED_HOUSE_1, 22 ; 16 ; -> super-small room
	warp_event 28,  0, HAUNTED_HOUSE_3, 10 ; 17 ; -> troll locked room in HAUNTED_HOUSE_3
	warp_event 36,  0, HAUNTED_HOUSE_1, 18 ; 18 ; -> itself
	warp_event 52,  0, HAUNTED_HOUSE_2,  1 ; 19 ; -> entrance of HAUNTED_HOUSE_2
	; small room
	warp_event 32, 49, HAUNTED_HOUSE_1, 13 ; 20 ; -> ledge room
	warp_event 33, 48, HAUNTED_HOUSE_1, 12 ; 21 ; -> long room (top)
	; super-small room
	warp_event 46,  9, HAUNTED_HOUSE_1, 23 ; 22 ; -> rightward narrow ledges
	; rightward narrow ledges
	warp_event  1, 13, HAUNTED_HOUSE_1,  1 ; 23 ; purposely doesn't work
	warp_event 17, 13, HAUNTED_HOUSE_1, 14 ; 24 ; -> ledge room (center)
	; infinite room
	warp_event 36, 59, HAUNTED_HOUSE_3, 17 ; 25 ; -> triple-door room, warp 3
	warp_event 37, 54, HAUNTED_HOUSE_1, 25 ; 26 ; -> same room, lower entrance
	; series of same-looking rooms
	warp_event 48, 59, HAUNTED_HOUSE_3, 16 ; 27 ; -> triple-door room, warp 2
	warp_event 49, 54, HAUNTED_HOUSE_1, 29 ; 28 ; -> next room, lower entrance
	warp_event 48, 49, HAUNTED_HOUSE_1, 28 ; 29 ; -> previous room, upper entrance
	warp_event 49, 44, HAUNTED_HOUSE_1, 31 ; 30 ; -> next room, lower entrance
	warp_event 48, 39, HAUNTED_HOUSE_1, 30 ; 31 ; -> previous room, upper entrance
	warp_event 49, 34, HAUNTED_HOUSE_1, 33 ; 32 ; -> next room, lower entrance
	warp_event 48, 29, HAUNTED_HOUSE_1, 32 ; 33 ; -> previous room, upper entrance
	warp_event 49, 24, HAUNTED_HOUSE_1, 35 ; 34 ; -> next room, lower entrance
	warp_event 48, 19, HAUNTED_HOUSE_1, 34 ; 35 ; -> previous room, upper entrance
	warp_event 49, 14, HAUNTED_HOUSE_4, 22 ; 36 ; -> PokeBall room

	def_bg_events
;	bg_event  6,  9, 9 ; CeladonMansion2TextSign1

	def_object_events
;	object_event  2,  4, SPRITE_BIRD, STAY, ANY_DIR, 1

	def_warps_to HAUNTED_HOUSE_1
