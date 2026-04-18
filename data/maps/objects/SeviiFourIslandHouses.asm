SeviiFourIslandHouses_Object:
	db $0a ; border block

	def_warp_events
	warp_event  2,  7, SEVII_FOUR_ISLAND_CITY, 6
	warp_event  3,  7, SEVII_FOUR_ISLAND_CITY, 6
	warp_event  7,  1, SEVII_FOUR_ISLAND_HOUSES, 4
	warp_event 21,  1, SEVII_FOUR_ISLAND_HOUSES, 3
	warp_event 30,  7, SEVII_FOUR_ISLAND_CITY, 7
	warp_event 31,  7, SEVII_FOUR_ISLAND_CITY, 7
	warp_event 44,  7, SEVII_FOUR_ISLAND_CITY, 8
	warp_event 45,  7, SEVII_FOUR_ISLAND_CITY, 8
	warp_event 35,  1, SEVII_FOUR_ISLAND_HAZARD_ROOM, 1
	warp_event 58,  7, SEVII_FOUR_ISLAND_CITY, 13 ; 10
	warp_event 59,  7, SEVII_FOUR_ISLAND_CITY, 13

	def_bg_events
	bg_event  3,  1, 10 ; SeviiFourIslandHousesSignText1_TV
	bg_event  4,  0, 11 ; SeviiFourIslandHousesSignText2_Picture
	bg_event 17,  0, 12 ; SeviiFourIslandHousesSignText3_Paper1
	bg_event 18,  0, 13 ; SeviiFourIslandHousesSignText4_Paper2
	bg_event 19,  0, 14 ; SeviiFourIslandHousesSignText5_Paper3
	bg_event 17,  5, 15 ; SeviiFourIslandHousesSignText6_Switch
	bg_event 14,  1, 16 ; SeviiFourIslandHousesSignText7_PC
	bg_event 49,  0, 17 ; SeviiFourIslandHousesSignText8_Cheater
	bg_event 42,  3, 18 ; SeviiFourIslandHousesSignText9_FakeBooks
	bg_event 43,  3, 19 ; SeviiFourIslandHousesSignText10_FakeBooks
	bg_event 20,  0, 20 ; SeviiFourIslandHousesSignText5_Paper4

	def_object_events
	object_event  2,  5, SPRITE_PINK, STAY, RIGHT, 1 ; challenge right after 5-Island
	object_event  2,  4, SPRITE_MIDDLE_AGED_MAN, STAY, RIGHT, 2 ; Dad
	object_event  5,  4, SPRITE_GAMBLER, STAY, LEFT, 3 ; Papa
	object_event  5,  5, SPRITE_MIDDLE_AGED_WOMAN, STAY, LEFT, 4 ; Mama
	object_event 33,  4, SPRITE_ERIKA, STAY, LEFT, 5 ; entry hazards tutor
	object_event 43,  5, SPRITE_GAMBLER, STAY, ANY_DIR, 6 ; furniture obsessed
	object_event 58,  3, SPRITE_SEEL, STAY, DOWN, 7 ; Lorelei's Lapras doll
	object_event 60,  4, SPRITE_GRANNY, STAY, UP, 8 ; Lorelei's grandma
	object_event 61,  6, SPRITE_LITTLE_GIRL, WALK, ANY_DIR, 9 ; Lorelei's lil sib

	def_warps_to SEVII_FOUR_ISLAND_HOUSES
