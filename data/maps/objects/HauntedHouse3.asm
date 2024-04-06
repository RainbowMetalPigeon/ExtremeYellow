HauntedHouse3_Object:
	db $f ; border block

	def_warp_events
	; series of ever-smaller rooms
	warp_event  0,  3, HAUNTED_HOUSE_3,  2 ; 1 -> next smaller room
	warp_event  0, 11, HAUNTED_HOUSE_3,  3 ; 2 -> next smaller room
	warp_event  0, 19, HAUNTED_HOUSE_3,  4 ; 3 -> next smaller room
	warp_event  0, 27, HAUNTED_HOUSE_3,  5 ; 4 -> next smaller room
	warp_event  0, 35, HAUNTED_HOUSE_3,  7 ; 5 -> next smaller room
	warp_event  3, 32, HAUNTED_HOUSE_3, 14 ; 6 ; RW, entrance of triple-door room
	warp_event 18,  3, HAUNTED_HOUSE_3,  1 ; 7 ; -> back to beginning of series of ever-smaller rooms
	warp_event 19,  0, HAUNTED_HOUSE_3, 21 ; 8 ; -> door madness
	; changing/mutating maze
	warp_event 43,  0, HAUNTED_HOUSE_3, 21 ; 9  ; entrance of maze ; -> door madness
	warp_event 54, 15, HAUNTED_HOUSE_1,  8 ; 10 ; troll locked room, back to where we were from
	warp_event  0, 41, HAUNTED_HOUSE_3, 19 ; 11 ; -> dark maze
	warp_event 30, 25, HAUNTED_HOUSE_4, 26 ; 12 ; -> small dark room (secondary warp)
	warp_event 33, 37, HAUNTED_HOUSE_3,  1 ; 13 ; RW, -> series of ever-smaller rooms
	; triple-door room
	warp_event 27, 49, HAUNTED_HOUSE_3,  1 ; 14 ; TBE ; entrance, to be defined from where
	warp_event 24, 42, HAUNTED_HOUSE_3, 18 ; 15 ; towards dead-exit room
	warp_event 27, 42, HAUNTED_HOUSE_1, 27 ; 16 ; RW, towards series of five identical-looking rooms
	warp_event 30, 42, HAUNTED_HOUSE_1, 25 ; 17 ; infinite-loop room
	; "identical room" with dead exit
	warp_event 24, 59, HAUNTED_HOUSE_3, 15 ; 18 ; back to triple-door room
	; dark maze
	warp_event 48, 49, HAUNTED_HOUSE_3, 19 ; 19 ; purposely non-working, only arrival
	warp_event 49, 50, HAUNTED_HOUSE_3, 21 ; 20 ; -> door madness
	; chaos-warp room / door madness
	warp_event 13, 46, HAUNTED_HOUSE_4, 24 ; 21 ; -> small dark room
	warp_event  2, 50, HAUNTED_HOUSE_4, 20 ; 22 ; -> center of "tornado" NPC room
	warp_event 10, 52, HAUNTED_HOUSE_3, 21 ; 23 ; -> on itself
	warp_event  5, 57, HAUNTED_HOUSE_3,  9 ; 25 ; -> mutating maze
	warp_event 11, 53, HAUNTED_HOUSE_4,  1 ; 24 ; -> swirling room

	def_bg_events
;	bg_event  6,  9, 9 ; CeladonMansion2TextSign1

	def_object_events
;	object_event  2,  4, SPRITE_BIRD, STAY, ANY_DIR, 1

	def_warps_to HAUNTED_HOUSE_3
