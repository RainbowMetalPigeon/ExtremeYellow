HauntedRedsHouse_Object:
	db $a ; border block

	def_warp_events
	warp_event  7,  1, HAUNTED_REDS_HOUSE, 2 ; 1
	warp_event 21,  1, HAUNTED_REDS_HOUSE, 1 ; 2
	warp_event 16,  7, HAUNTED_PALLET_TOWN, 1 ; 3
	warp_event 17,  7, HAUNTED_PALLET_TOWN, 1 ; 4
	warp_event  3,  6, HAUNTED_REDS_HOUSE, 5 ; 5, special arrival warp

	def_bg_events
	bg_event 17,  1, 2 ; HauntedRedsHouseTVText
	bg_event  3,  5, 3 ; HauntedRedsHouseConsoleText
	bg_event  0,  1, 4 ; HauntedRedsHousePCText
	bg_event 14,  1, 5 ; HauntedRedsHouseBookshelvesText
	bg_event 15,  1, 6 ; HauntedRedsHouseBookshelvesText
	bg_event 18,  0, 7 ; HauntedRedsHousePictureText

	def_object_events
	object_event 19,  4, SPRITE_MOM, STAY, LEFT, 1

	def_warps_to HAUNTED_REDS_HOUSE
