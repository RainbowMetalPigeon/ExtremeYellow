SeviiTwoIsletHouses_Object:
	db $0A ; border block

	def_warp_events
	warp_event  2,  7, SEVII_TWO_ISLET, 2
	warp_event  3,  7, SEVII_TWO_ISLET, 2
	warp_event 16,  7, SEVII_TWO_ISLET, 3
	warp_event 17,  7, SEVII_TWO_ISLET, 3
	warp_event 30,  7, SEVII_TWO_ISLET, 4
	warp_event 31,  7, SEVII_TWO_ISLET, 4

	def_bg_events
	bg_event 31,  4,  7 ; SeviiTwoIsletHousesSignText1 ; book with notes about shiny probabilities
	bg_event 28,  1,  8 ; SeviiTwoIsletHousesSignText2 ; safety-net indicator

	def_object_events
	; house 1
	object_event  2,  4, SPRITE_SILPH_WORKER, STAY, RIGHT, 1 ; sells ATK 0-ifier
	object_event  5,  3, SPRITE_SILPH_WORKER, STAY, LEFT, 2 ; sells SPD 0-ifier
	object_event  4,  1, SPRITE_GAMEBOY_KID, STAY, DOWN, 3
	; house 2
	object_event 16,  4, SPRITE_FISHER, STAY, RIGHT, 4
	object_event 20,  3, SPRITE_LITTLE_GIRL, WALK, UP_DOWN, 5
	; house 3
	object_event 31,  5, SPRITE_MIDDLE_AGED_WOMAN, STAY, UP, 6 ; shiny hunter

	def_warps_to SEVII_TWO_ISLET_HOUSES
