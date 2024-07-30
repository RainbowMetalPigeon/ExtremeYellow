PalletTown_Object:
	db $b ; border block

	def_warp_events
	warp_event  5,  5, REDS_HOUSE_1F, 1
;	warp_event  5,  5, HALL_OF_FAME, 1
;	warp_event  5,  5, OBSIDIAN_ISLAND, 1
;	warp_event  5,  5, CERULEAN_CAVE_EXTRA_FINAL, 1 ; 1-2 entrance, 3 testing near merchant
;	warp_event  5,  5, CERULEAN_CAVE_EXTRA_MIDDLE, 7 ; 23 entrance, 4 exit, 7 Lance
;	warp_event  5,  5, CERULEAN_CAVE_1F, 10
;	warp_event  5,  5, SAFARI_ZONE_GATE, 1
;	warp_event  5,  5, OBSIDIAN_WAREHOUSE_FINAL, 1
;	warp_event  5,  5, OBSIDIAN_WAREHOUSE, 1
;	warp_event  5,  5, POKEMON_MANSION_2F, 1
;	warp_event  5,  5, SECLUDED_ATOLL_SW, 1
;	warp_event  5,  5, AGATHAS_ROOM, 1
;	warp_event  5,  5, OCHRE_HOUSES, 3
;	warp_event  5,  5, OBSIDIAN_HOUSES, 4
;	warp_event  5,  5, MT_MOON_1F, 1
;	warp_event  5,  5, CELADON_CHIEF_HOUSE, 3
;	warp_event  5,  5, SS_ANNE_CAPTAINS_ROOM, 1
;	warp_event  5,  5, COPYCATS_HOUSE_2F, 1
;	warp_event  5,  5, SILPH_CO_11F, 4
;	warp_event  5,  5, BILLS_HOUSE, 1
;	warp_event  5,  5, VICTORY_ROAD_1F, 1
;	warp_event  5,  5, OBSIDIAN_MINES, 1
;	warp_event  5,  5, LORELEIS_ROOM, 1
;	warp_event  5,  5, SAFFRON_GYM, 1
;	warp_event  5,  5, OCHRE_RESEARCH_CENTER_2, 1
;	warp_event  5,  5, POKEMON_TOWER_1F, 1
;	warp_event  5,  5, CELADON_UNIVERSITY_1, 1
;	warp_event  5,  5, HAUNTED_HOUSE_1, 1
;	warp_event  5,  5, CELADON_HOTEL_ROOMS, 1
;	warp_event  5,  5, SEAFOAM_ISLANDS_B4F, 3
;	warp_event  5,  5, PEWTER_GYM, 1
;	warp_event  5,  5, VIRIDIAN_GYM, 1
;	warp_event  5,  5, SILPH_CO_7F, 4
;	warp_event  5,  5, VICTORY_ROAD_1F, 1

	warp_event 13,  5, BLUES_HOUSE, 1
;	warp_event 13,  5, CERULEAN_CAVE_EXTRA_MIDDLE, 23
;	warp_event 13,  5, SECLUDED_ATOLL_SE, 1
;	warp_event 13,  5, SILPH_CO_11F, 4
;	warp_event 13,  5, HALL_OF_FAME, 1
;	warp_event 13,  5, OBSIDIAN_WAREHOUSE_FINAL, 1
;	warp_event 13,  5, BATTLE_FACILITY, 1
;	warp_event 13,  5, HAUNTED_REDS_HOUSE, 5
;	warp_event 13,  5, SECLUDED_CAVES, 4
;	warp_event 13,  5, SEAFOAM_ISLANDS_B4F, 3

	warp_event 12, 11, OAKS_LAB, 2
;	warp_event 12, 11, POKEMON_TOWER_6F, 1
;	warp_event 12, 11, HAUNTED_REDS_HOUSE, 5
;	warp_event 12, 11, HAUNTED_PALLET_TOWN, 1
;	warp_event 12, 11, HAUNTED_HOUSE_3, 9
;	warp_event 12, 11, HAUNTED_ISLAND_OF_NUMBERS, 1
;	warp_event 12, 11, BILLS_HOUSE, 1
;	warp_event 12, 11, BATTLE_FACILITY, 1
;	warp_event 12, 11, CHAMPIONS_ROOM, 1

	def_bg_events
	bg_event 13, 13, 5 ; PalletTownText4
	bg_event  7,  9, 6 ; PalletTownText5
	bg_event  3,  5, 7 ; PalletTownText6
	bg_event 11,  5, 8 ; PalletTownText7

	def_object_events
	object_event 10,  4, SPRITE_OAK, STAY, NONE, 1 ; person
	object_event  3,  8, SPRITE_GIRL, WALK, ANY_DIR, 2 ; person
	object_event 11, 14, SPRITE_FISHER, WALK, ANY_DIR, 3 ; person
	object_event  9,  4, SPRITE_DARK_GUIDE, STAY, DOWN, 4 ; new

	def_warps_to PALLET_TOWN
