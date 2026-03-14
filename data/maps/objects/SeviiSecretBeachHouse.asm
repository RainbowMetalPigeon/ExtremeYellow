SeviiSecretBeachHouse_Object:
	db $a ; border block (or $43)

	def_warp_events
	warp_event  2,  9, SEVII_SECRET_BEACH, 1
	warp_event  3,  9, SEVII_SECRET_BEACH, 1

	def_bg_events
	bg_event  3,  0,  1 ; poster 1
	bg_event  7,  0,  2 ; poster 2
	bg_event 11,  0,  3 ; poster 3
	bg_event 15,  1,  4 ; machine
	bg_event 15,  8,  5 ; bed 1
	bg_event 15,  9,  6 ; bed 2
	bg_event  0,  3,  7 ; plant 1
	bg_event  0,  5,  8 ; plant 2
	bg_event  0,  7,  9 ; plant 3
	bg_event  0,  9, 10 ; plant 4

	def_object_events
;	object_event 53,  5, SPRITE_HIKER, STAY, LEFT, 1
;	; trainers
;	object_event 45, 10, SPRITE_SUPER_NERD, STAY, UP, 2, OPP_ENGINEER, 6
;	; non-persons
;	object_event 23, 14, SPRITE_ROCKSMASHABLE_ROCK, STAY, ROCKSMASHABLE_ROCK_MOVEMENT_BYTE_2, 10
;	object_event 51, 25, SPRITE_POKE_BALL, STAY, NONE, 14, RARE_CANDY

	def_warps_to SEVII_SECRET_BEACH_HOUSE
