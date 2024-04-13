HauntedHouse4_Object:
	db $f ; border block

	def_warp_events
	; swirling room
	warp_event  0, 29, HAUNTED_HOUSE_4, 20 ; 1 ; -> center of "tornado" NPC room
	warp_event 10, 29, HAUNTED_HOUSE_3, 19 ; 2 ; -> dark maze center
	warp_event 21, 29, HAUNTED_HOUSE_3, 21 ; 3 ; -> door madness
	; small connected rooms - NW
	warp_event  3, 44, HAUNTED_HOUSE_1, 22 ; 4 ; -> super-small room
	warp_event  5, 47, HAUNTED_HOUSE_4, 11 ; 5
	warp_event  2, 49, HAUNTED_HOUSE_4, 16 ; 6
	warp_event  0, 46, HAUNTED_HOUSE_4,  7 ; 7 ; -> on itself
	; small connected rooms - NE
	warp_event 15, 44, HAUNTED_HOUSE_1, 22 ; 8 ; -> super-small room
	warp_event 17, 47, HAUNTED_HOUSE_4,  9 ; 9 ; -> on itself
	warp_event 14, 49, HAUNTED_HOUSE_4, 12 ; 10
	warp_event 12, 46, HAUNTED_HOUSE_4,  5 ; 11
	; small connected rooms - SE
	warp_event 15, 54, HAUNTED_HOUSE_4, 10 ; 12
	warp_event 17, 57, HAUNTED_HOUSE_4, 13 ; 13 ; -> on itself
	warp_event 14, 59, HAUNTED_HOUSE_1, 22 ; 14 ; -> super-small room
	warp_event 12, 56, HAUNTED_HOUSE_4, 17 ; 15
	; small connected rooms - SW
	warp_event  3, 54, HAUNTED_HOUSE_4,  6 ; 16
	warp_event  5, 57, HAUNTED_HOUSE_4, 15 ; 17
	warp_event  2, 59, HAUNTED_HOUSE_1, 22 ; 18 ; -> super-small room
	warp_event  0, 56, HAUNTED_HOUSE_4, 19 ; 19 ; -> on itself
	; room with "tornado" NPC
	warp_event 28, 55, HAUNTED_HOUSE_4,  1 ; 20 ; purposely only arrive
	warp_event 29, 50, HAUNTED_HOUSE_4, 24 ; 21 ; -> small dark room
	; room with PokeBall
	warp_event 42, 59, HAUNTED_HOUSE_1, 36 ; 22 ; -> top of last room in series of same-looking rooms
	warp_event 43, 54, HAUNTED_HOUSE_3, 14 ; 23 ; -> entrance of triple-door room
	; small dark room
	warp_event 56, 58, HAUNTED_HOUSE_4, 24 ; 24 ; purposely only arrive
	warp_event 59, 56, HAUNTED_HOUSE_3, 21 ; 25 ; -> door madness
	warp_event 59, 59, HAUNTED_HOUSE_4, 26 ; 26 ; -> on itself

	def_bg_events
;	bg_event  6,  9, 9 ; CeladonMansion2TextSign1

	def_object_events
	object_event  3, 57, SPRITE_MOM, STAY, UP, 1 ; SW room
	object_event 15, 56, SPRITE_MOM, STAY, LEFT, 2 ; SE room
	object_event 14, 46, SPRITE_MOM, STAY, DOWN, 3 ; NE room
	object_event  2, 47, SPRITE_MOM, STAY, RIGHT, 4 ; NW room
	object_event 28, 52, SPRITE_MOM, STAY, DOWN, 5 ; "tornado" room, up
	object_event 31, 55, SPRITE_MOM, STAY, LEFT, 6 ; "tornado" room, right
	object_event 28, 58, SPRITE_MOM, STAY, UP, 7 ; "tornado" room, down
	object_event 25, 55, SPRITE_MOM, STAY, RIGHT, 8 ; "tornado" room, left
	object_event 42, 56, SPRITE_POKE_BALL, STAY, NONE, 9 ; PokeBall room

	def_warps_to HAUNTED_HOUSE_4
