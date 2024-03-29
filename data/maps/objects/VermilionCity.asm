VermilionCity_Object:
	db $43 ; border block

	def_warp_events
	warp_event 11,  3, VERMILION_POKECENTER, 1
	warp_event  9, 13, POKEMON_FAN_CLUB, 1
	warp_event 21, 13, VERMILION_POKECENTER, 3 ; moved to the left ; edited due to MERGING
	warp_event 12, 19, VERMILION_GYM, 1
	warp_event 23, 19, VERMILION_HOUSES, 5 ; edited because of map merging
	warp_event 18, 31, VERMILION_DOCK, 1
	warp_event 19, 31, VERMILION_DOCK, 1
	warp_event 15, 13, VERMILION_HOUSES, 3 ; edited because of map merging
	warp_event  7,  3, VERMILION_HOUSES, 1 ; edited because of map merging
	warp_event 30,  7, BATTLE_FACILITY, 1 ; new

	def_bg_events
	bg_event 17,  5, 11 ; VermilionCityText8 ; moved to the left
	bg_event 37, 13, 12 ; VermilionCityText9
	bg_event 22, 13, 13 ; MartSignText ; moved to the left
	bg_event 12,  3, 14 ; PokeCenterSignText
	bg_event  7, 13, 15 ; VermilionCityText12
	bg_event  7, 19, 16 ; VermilionCityText13
	bg_event 29, 15, 17 ; VermilionCityText14
	bg_event 31,  9, 18 ; VermilionCityText16 ; new, Battle Facility

	def_object_events
	object_event 19,  7, SPRITE_COOLTRAINER_F, WALK, LEFT_RIGHT, 1 ; person
	object_event 14,  6, SPRITE_GAMBLER, STAY, NONE, 2 ; person
	object_event 19, 30, SPRITE_SAILOR, STAY, UP, 3 ; person; SS Anne Guardian
	object_event 30,  9, SPRITE_GAMBLER, STAY, ANY_DIR, 4 ; Battle Facility builder, edited
	object_event 30,  8, SPRITE_MONSTER, STAY, UP, 5 ; Machoke, working at the door - TODO hide/show it
	object_event 33, 12, SPRITE_MONSTER, STAY, LEFT, 6 ; Machamp, now is resting - TODO hide/show it
	object_event 25, 27, SPRITE_SAILOR, WALK, LEFT_RIGHT, 7 ; person
	object_event 19, 15, SPRITE_OFFICER_JENNY, STAY, NONE, 8 ; person
	object_event 20, 21, SPRITE_TRAVELER, STAY, ANY_DIR, 9 ; new, traveler
	object_event 35, 25, SPRITE_POKE_BALL, STAY, NONE, 10, RARE_CANDY

	def_warps_to VERMILION_CITY
