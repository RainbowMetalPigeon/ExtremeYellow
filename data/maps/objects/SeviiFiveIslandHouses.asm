SeviiFiveIslandHouses_Object:
	db $0a ; border block

	def_warp_events
	warp_event  2,  7, SEVII_FIVE_ISLAND_CITY, 6
	warp_event  3,  7, SEVII_FIVE_ISLAND_CITY, 6

	def_bg_events
	bg_event  2,  0,  2 ; SeviiFiveIslandHousesSignText1
	bg_event  3,  0,  3 ; SeviiFiveIslandHousesSignText2

	def_object_events
	object_event  2,  4, SPRITE_LITTLE_GIRL, STAY, RIGHT, 1 ; Trick Room Tutor

	def_warps_to SEVII_FIVE_ISLAND_HOUSES
