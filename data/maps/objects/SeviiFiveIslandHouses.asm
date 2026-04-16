SeviiFiveIslandHouses_Object:
	db $0a ; border block

	def_warp_events
	warp_event  2,  7, SEVII_FIVE_ISLAND_CITY, 6
	warp_event  3,  7, SEVII_FIVE_ISLAND_CITY, 6
	warp_event 16,  7, SEVII_FIVE_ISLAND_CITY, 8
	warp_event 17,  7, SEVII_FIVE_ISLAND_CITY, 8

	def_bg_events
	bg_event  2,  0,  9 ; SeviiFiveIslandHousesSignText1
	bg_event  3,  0, 10 ; SeviiFiveIslandHousesSignText2
	bg_event  0,  1, 11 ; SeviiFiveIslandHousesSignText3
	bg_event  1,  1, 12 ; SeviiFiveIslandHousesSignText4

	def_object_events
	object_event  2,  4, SPRITE_LITTLE_GIRL, STAY, RIGHT, 1 ; Trick Room Tutor
	object_event 16,  4, SPRITE_BIKER, WALK, ANY_DIR, 2
	object_event 15,  5, SPRITE_SANDSHREW, STAY, ANY_DIR, 3
	object_event 18,  6, SPRITE_ODDISH, STAY, ANY_DIR, 4
	object_event 18,  1, SPRITE_JIGGLYPUFF, STAY, ANY_DIR, 5
	object_event 20,  2, SPRITE_CLEFAIRY, STAY, ANY_DIR, 6
	object_event 18,  3, SPRITE_POKE_BALL, STAY, NONE, 7
	object_event 21,  0, SPRITE_PAPER, STAY, NONE, 8

	def_warps_to SEVII_FIVE_ISLAND_HOUSES
