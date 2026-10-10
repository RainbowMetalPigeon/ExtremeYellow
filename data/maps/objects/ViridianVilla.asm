ViridianVilla_Object:
	db $0 ; border block

	def_warp_events
	; 1F
	warp_event  3,  7, LAST_MAP, 9 ; 1
	warp_event  4,  7, LAST_MAP, 9 ; 2
	warp_event  6,  0, VIRIDIAN_VILLA, 4 ; 3
	; 2F
	warp_event 20,  0, VIRIDIAN_VILLA, 3 ; 4
	warp_event 15,  0, VIRIDIAN_VILLA, 6 ; 5
	; 3F
	warp_event 29,  0, VIRIDIAN_VILLA, 5 ; 6
	warp_event 34,  0, VIRIDIAN_VILLA, 8 ; 7
	; 4F
	warp_event 48,  0, VIRIDIAN_VILLA, 7 ; 8

	def_bg_events
	bg_event  2,  1,  4 ; ViridianVilla_VillaSignText1
	bg_event 21,  4,  5 ; ViridianVilla_VillaSignText2
	bg_event 28,  2,  6 ; ViridianVilla_VillaSignText3
	bg_event 42,  1,  7 ; ViridianVilla_VillaSignText4

	def_object_events
	object_event  6,  3, SPRITE_ROCKSMASHABLE_ROCK, STAY, ROCKSMASHABLE_ROCK_MOVEMENT_BYTE_2, 1
	object_event 33,  4, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 2
	object_event 42,  6, SPRITE_GENTLEMAN, STAY, DOWN, 3

	def_warps_to VIRIDIAN_VILLA
