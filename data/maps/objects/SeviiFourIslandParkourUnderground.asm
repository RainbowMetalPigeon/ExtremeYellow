SeviiFourIslandParkourUnderground_Object:
	db $0a ; border block

	def_warp_events
	warp_event  2, 23, SEVII_FOUR_ISLAND_PARKOUR_PATH, 1		; 1
	warp_event  3, 23, SEVII_FOUR_ISLAND_PARKOUR_PATH, 1		; 2
	warp_event  4, 20, SEVII_FOUR_ISLAND_PARKOUR_UNDERGROUND, 4	; 3
	warp_event 19,  3, SEVII_FOUR_ISLAND_PARKOUR_UNDERGROUND, 3	; 4
	warp_event 17, 21, SEVII_FOUR_ISLAND_PARKOUR_UNDERGROUND, 6	; 5
	warp_event 32, 20, SEVII_FOUR_ISLAND_PARKOUR_UNDERGROUND, 5	; 6
	warp_event 30, 23, SEVII_FOUR_ISLAND_PARKOUR_PATH, 2		; 7
	warp_event 31, 23, SEVII_FOUR_ISLAND_PARKOUR_PATH, 2		; 8

	def_bg_events
;	bg_event  5, 65, 3 ; Route2Text3

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_FOUR_ISLAND_PARKOUR_UNDERGROUND
