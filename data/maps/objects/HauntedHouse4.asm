HauntedHouse4_Object:
	db $f ; border block

	def_warp_events
	; swirling room
	warp_event  0, 29, HAUNTED_HOUSE_4,  1 ; 1 ; TBE
	warp_event 10, 29, HAUNTED_HOUSE_4,  1 ; 2 ; TBE
	warp_event 21, 29, HAUNTED_HOUSE_4,  1 ; 3 ; TBE
	; small connected rooms - NW
	warp_event  3, 44, HAUNTED_HOUSE_4,  1 ; 4 ; TBE
	warp_event  5, 47, HAUNTED_HOUSE_4, 11 ; 5
	warp_event  2, 49, HAUNTED_HOUSE_4, 16 ; 6
	warp_event  0, 46, HAUNTED_HOUSE_4,  1 ; 7 ; TBE
	; small connected rooms - NE
	warp_event 15, 44, HAUNTED_HOUSE_4,  1 ; 8 ; TBE
	warp_event 17, 47, HAUNTED_HOUSE_4,  1 ; 9 ; TBE
	warp_event 14, 49, HAUNTED_HOUSE_4, 12 ; 10
	warp_event 12, 46, HAUNTED_HOUSE_4,  5 ; 11
	; small connected rooms - SE
	warp_event 15, 54, HAUNTED_HOUSE_4, 10 ; 12
	warp_event 17, 57, HAUNTED_HOUSE_4,  1 ; 13 ; TBE
	warp_event 14, 59, HAUNTED_HOUSE_4,  1 ; 14 ; TBE
	warp_event 12, 56, HAUNTED_HOUSE_4, 17 ; 15
	; small connected rooms - SW
	warp_event  3, 54, HAUNTED_HOUSE_4,  6 ; 16
	warp_event  5, 57, HAUNTED_HOUSE_4, 15 ; 17
	warp_event  2, 59, HAUNTED_HOUSE_4,  1 ; 18 ; TBE
	warp_event  0, 56, HAUNTED_HOUSE_4,  1 ; 19 ; TBE
	; room with "tornado" NPC
	warp_event 28, 55, HAUNTED_HOUSE_4,  1 ; 20 ; purposely only arrive
	warp_event 29, 50, HAUNTED_HOUSE_4,  1 ; 21 ; TBE
	; room with PokeBall
	warp_event 42, 59, HAUNTED_HOUSE_4,  1 ; 22 ; TBE
	warp_event 43, 54, HAUNTED_HOUSE_4,  1 ; 23 ; TBE
	; small dark room
	warp_event 56, 58, HAUNTED_HOUSE_4,  1 ; 24 ; purposely only arrive
	warp_event 59, 56, HAUNTED_HOUSE_4,  1 ; 25 ; TBE
	warp_event 59, 59, HAUNTED_HOUSE_4,  1 ; 26 ; TBE

	def_bg_events
;	bg_event  6,  9, 9 ; CeladonMansion2TextSign1

	def_object_events
	object_event  3, 57, SPRITE_MOM, STAY, UP, 1 ; SW room
	object_event 15, 56, SPRITE_MOM, STAY, LEFT, 2 ; SE room
	object_event 14, 46, SPRITE_MOM, STAY, DOWN, 3 ; NE room
	object_event  2, 47, SPRITE_MOM, STAY, RIGHT, 4 ; NW room
	object_event 28, 52, SPRITE_MOM, STAY, DOWN, 5 ; "tornado" room, up
	object_event 31, 55, SPRITE_MOM, STAY, DOWN, 6 ; "tornado" room, right
	object_event 28, 58, SPRITE_MOM, STAY, DOWN, 7 ; "tornado" room, down
	object_event 25, 55, SPRITE_MOM, STAY, DOWN, 8 ; "tornado" room, left
	object_event 42, 56, SPRITE_POKE_BALL, STAY, NONE, 9 ; PokeBall room

	def_warps_to HAUNTED_HOUSE_4
