HauntedPalletTown_Object:
	db $b ; border block

	def_warp_events
	warp_event  9,  9, HAUNTED_ISLAND_OF_NUMBERS, 1

	def_bg_events
;	bg_event 13, 13, 5 ; PalletTownText4

	def_object_events
;	object_event 10,  4, SPRITE_OAK, STAY, NONE, 1 ; person

	def_warps_to HAUNTED_PALLET_TOWN
