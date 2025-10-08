SeviiSevenIslandHouses_Object:
	db $0a ; border block

	def_warp_events
	warp_event  2,  7, SEVII_SEVEN_ISLAND_CITY, 5
	warp_event  3,  7, SEVII_SEVEN_ISLAND_CITY, 5
	warp_event  7,  1, SEVII_SEVEN_ISLAND_HOUSES, 4
	warp_event 21,  1, SEVII_SEVEN_ISLAND_HOUSES, 3

	def_bg_events
	bg_event  0,  7,  2 ; SeviiSevenIslandHousesSignText1
	bg_event  3,  1,  3 ; SeviiSevenIslandHousesSignText2
	bg_event  5,  0,  4 ; SeviiSevenIslandHousesSignText3
	bg_event 17,  5,  5 ; SeviiSevenIslandHousesSignText4
	bg_event 21,  7,  6 ; SeviiSevenIslandHousesSignText5
	bg_event 14,  6,  7 ; SeviiSevenIslandHousesSignText6
	bg_event 14,  7,  8 ; SeviiSevenIslandHousesSignText7
	bg_event 14,  1,  9 ; SeviiSevenIslandHousesSignText8

	def_object_events
	object_event  3,  4, SPRITE_PAPER, STAY, NONE, 1

	def_warps_to SEVII_SEVEN_ISLAND_HOUSES
