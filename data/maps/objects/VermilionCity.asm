VermilionCity_Object:
	db $43 ; border block

	def_warp_events
	warp_event 11,  3, VERMILION_POKECENTER, 1
	warp_event  9, 13, POKEMON_FAN_CLUB, 1
	warp_event 21, 13, VERMILION_MART, 1 ; moved to the left
	warp_event 12, 19, VERMILION_GYM, 1
	warp_event 23, 19, VERMILION_PIDGEY_HOUSE, 1
	warp_event 18, 31, VERMILION_DOCK, 1
	warp_event 19, 31, VERMILION_DOCK, 1
	warp_event 15, 13, VERMILION_TRADE_HOUSE, 1
	warp_event  7,  3, VERMILION_OLD_ROD_HOUSE, 1
	warp_event 30,  7, REDS_HOUSE_1F, 1 ; new - BATTLE_FACILITY

	def_bg_events
	bg_event 17,  5, 9 ; VermilionCityText8 ; moved to the left
	bg_event 37, 13, 10 ; VermilionCityText9
	bg_event 22, 13, 11 ; MartSignText ; moved to the left
	bg_event 12,  3, 12 ; PokeCenterSignText
	bg_event  7, 13, 13 ; VermilionCityText12
	bg_event  7, 19, 14 ; VermilionCityText13
	bg_event 29, 15, 15 ; VermilionCityText14
	bg_event 31,  9, 16 ; VermilionCityText16 ; new, Battle Facility

	def_object_events
	object_event 19,  7, SPRITE_COOLTRAINER_F, WALK, LEFT_RIGHT, 1 ; person
	object_event 14,  6, SPRITE_GAMBLER, STAY, NONE, 2 ; person
	object_event 19, 30, SPRITE_SAILOR, STAY, UP, 3 ; person
	object_event 30,  9, SPRITE_GAMBLER, STAY, ANY_DIR, 4 ; Battle Facility builder, edited
	object_event 30,  8, SPRITE_MONSTER, STAY, UP, 5 ; Machoke, working at the door - TODO hide/show it
	object_event 33, 12, SPRITE_MONSTER, STAY, LEFT, 6 ; Machamp, now is resting - TODO hide/show it
	object_event 25, 27, SPRITE_SAILOR, WALK, LEFT_RIGHT, 7 ; person
	object_event 19, 15, SPRITE_OFFICER_JENNY, STAY, NONE, 8 ; person

	def_warps_to VERMILION_CITY
