SunkenShipRooms_Object:
	db $0C ; border block

	def_warp_events
; top floor
	warp_event  2, 12, SUNKEN_SHIP_1F,  1 ;  1, room 1
	warp_event 14, 12, SUNKEN_SHIP_1F,  2 ;  2, room 2
	warp_event 26, 12, SUNKEN_SHIP_1F,  3 ;  3, room 3
	warp_event 38, 12, SUNKEN_SHIP_1F,  4 ;  4, room 4
	warp_event 26, 31, SUNKEN_SHIP_1F,  5 ;  5, room 7
	warp_event 27, 31, SUNKEN_SHIP_1F,  5 ;  6, room 7
	warp_event 38, 31, SUNKEN_SHIP_1F,  6 ;  7, room 8
	warp_event 39, 31, SUNKEN_SHIP_1F,  6 ;  8, room 8

; mid floor
	warp_event  2, 36, SUNKEN_SHIP_1F, 10 ;  9, room 1
	warp_event 14, 36, SUNKEN_SHIP_1F, 11 ; 10, room 2
	warp_event 26, 36, SUNKEN_SHIP_1F, 12 ; 11, room 3
	warp_event  2, 55, SUNKEN_SHIP_1F, 13 ; 12, room 5
	warp_event  3, 55, SUNKEN_SHIP_1F, 13 ; 13, room 5
	warp_event 14, 55, SUNKEN_SHIP_1F, 14 ; 14, room 6
	warp_event 15, 55, SUNKEN_SHIP_1F, 14 ; 15, room 6
	warp_event 38, 55, SUNKEN_SHIP_1F, 15 ; 16, room 8
	warp_event 39, 55, SUNKEN_SHIP_1F, 15 ; 17, room 8

; bottom floor
	warp_event 14, 60, SUNKEN_SHIP_1F, 25 ; 18, room 2
	warp_event 38, 60, SUNKEN_SHIP_1F, 26 ; 19, room 4
	warp_event 14, 79, SUNKEN_SHIP_1F, 27 ; 20, room 6
	warp_event 15, 79, SUNKEN_SHIP_1F, 27 ; 21, room 6
	warp_event 26, 79, SUNKEN_SHIP_1F, 28 ; 22, room 7
	warp_event 27, 79, SUNKEN_SHIP_1F, 28 ; 23, room 7
	warp_event 38, 79, SUNKEN_SHIP_1F, 29 ; 24, room 8
	warp_event 39, 79, SUNKEN_SHIP_1F, 29 ; 25, room 8

; captain's room
	warp_event 41,  4, SUNKEN_SHIP_1F, 16 ; 26
	warp_event 41,  5, SUNKEN_SHIP_1F, 16 ; 27

; inter-room warps
	warp_event 29, 16, SUNKEN_SHIP_ROOMS, 29 ; 28
	warp_event 36, 16, SUNKEN_SHIP_ROOMS, 28 ; 29
	warp_event  5, 40, SUNKEN_SHIP_ROOMS, 31 ; 30
	warp_event 12, 40, SUNKEN_SHIP_ROOMS, 30 ; 31
	warp_event 17, 64, SUNKEN_SHIP_ROOMS, 33 ; 32
	warp_event 24, 64, SUNKEN_SHIP_ROOMS, 32 ; 33
	warp_event 27, 67, SUNKEN_SHIP_ROOMS, 35 ; 34
	warp_event 27, 72, SUNKEN_SHIP_ROOMS, 34 ; 35

	def_bg_events ; only plot-relevant; lore-like are delegated to extra code
; top floor
	bg_event  0, 19,  1 ; GiveCombination12Text
	bg_event 24, 25,  2 ; GiveRoomKey34Text
; mid floor
	bg_event 24, 43,  3 ; GiveCombination18Text
	bg_event  0, 49,  4 ; GiveRoomKey37Text
; bottom floor
	bg_event 12, 73,  5 ; GivePassword25Text
	bg_event 36, 73,  6 ; GivePassword22Text
; captain's room
	bg_event 41,  1,  7 ; GiveSunkenShipTreasureText
	bg_event 35,  2,  8 ; SunkenShipCaptainsLogText

/*
; lore
	bg_event 12, 19,  2 ; SunkenShipLoreText_12
	bg_event 24, 19,  3 ; SunkenShipLoreText_13
;	bg_event 36, 19, nn ; SunkenShipLoreText_14 ; x
	bg_event 36, 25,  5 ; SunkenShipLoreText_18
	bg_event  0, 43,  6 ; SunkenShipLoreText_21
	bg_event 12, 43,  7 ; SunkenShipLoreText_22
	bg_event 12, 49, 10 ; SunkenShipLoreText_26
	bg_event 36, 49, 11 ; SunkenShipLoreText_28
;	bg_event 12, 67, nn ; SunkenShipLoreText_32 ; x
	bg_event 24, 67, 12 ; SunkenShipLoreText_33
	bg_event 36, 67, 13 ; SunkenShipLoreText_34
	bg_event 24, 73, 15 ; SunkenShipLoreText_37
;	bg_event 26, 60, 19 ; DoorCantBeOpenedText2
*/

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SUNKEN_SHIP_ROOMS
