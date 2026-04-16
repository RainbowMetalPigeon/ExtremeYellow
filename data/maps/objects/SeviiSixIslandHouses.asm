SeviiSixIslandHouses_Object:
	db $0A ; border block

	def_warp_events
	warp_event  2,  7, SEVII_SIX_ISLAND_CITY, 6
	warp_event  3,  7, SEVII_SIX_ISLAND_CITY, 6

	def_bg_events
;	bg_event  2,  0, 4 ; SeviiRoute38HousesSignText1

	def_object_events
	object_event  2,  3, SPRITE_MIDDLE_AGED_WOMAN, STAY, RIGHT, 1
	object_event  2,  4, SPRITE_ROCKER, STAY, RIGHT, 2
	object_event  5,  4, SPRITE_GRAMPS, STAY, LEFT, 3
	object_event  6,  6, SPRITE_BRUNETTE_GIRL, WALK, ANY_DIR, 4
	object_event  7,  6, SPRITE_MONSTER, WALK, ANY_DIR, 5

	def_warps_to SEVII_SIX_ISLAND_HOUSES
