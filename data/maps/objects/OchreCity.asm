OchreCity_Object:
	db $43 ; border block

	def_warp_events
	warp_event  9,  9, OCHRE_HOUSES, 1 ; 1 - house 1
	warp_event 17,  9, OCHRE_HOUSES, 3 ; 2 - house 2
	warp_event 27, 11, OCHRE_POKECENTER, 3 ; 3 - poke mart
	warp_event 35, 11, OCHRE_POKECENTER, 1 ; 4 - poke center
	warp_event 17, 15, OCHRE_HOUSES, 5 ; 5 - bird fan club
	warp_event 34, 17, OCHRE_GYM, 1 ; 6
	warp_event 10, 19, OCHRE_RESEARCH_CENTER_1, 1 ; 7
	warp_event 37, 27, OCHRE_REHABILITATION_CENTER, 2 ; 8 - front entrance rehabilitation
	warp_event 12, 33, OCHRE_WONDERLAND, 1 ; 9
	warp_event 37, 25, OCHRE_REHABILITATION_CENTER, 1 ; 10 - back entrance rehabilitation

	def_bg_events
	bg_event 28, 11, 15 ; MartSignText
	bg_event 36, 11, 16 ; PokeCenterSignText
	bg_event 37, 21, 17 ; OchreCity_SignCity
	bg_event 33, 19, 18 ; OchreCity_SignGym
	bg_event 31, 27, 19 ; OchreCity_SignRehabilitation
	bg_event 15, 21, 20 ; OchreCity_SignParkAndSquare
	bg_event  7, 19, 21 ; OchreCity_SignResearch
	bg_event 15, 15, 22 ; OchreCity_SignBirbFan
	bg_event 41, 32, 23 ; OchreCity_LooseFence

	def_object_events
	object_event  6, 10, SPRITE_BIKER, WALK, UP_DOWN, 1 ; like biking circle
	object_event 38, 16, SPRITE_COOLTRAINER_F, WALK, ANY_DIR, 2 ; underdog
	object_event 25, 25, SPRITE_COOLTRAINER_M, STAY, LEFT, 3 ; relax square
	object_event 18, 31, SPRITE_SUPER_NERD, STAY, ANY_DIR, 4 ; lost park
	object_event 21, 20, SPRITE_FISHER, STAY, RIGHT, 5 ; fish fountain
	object_event 11, 21, SPRITE_SUPER_NERD, STAY, UP, 6 ; wanna work research
	object_event 26, 37, SPRITE_BIKER, WALK, ANY_DIR, 7 ; bikers illegal races ; was a ROCKER, but maybe is more cute/ironic if it's a biker complaining about illegal races?
	object_event 32, 24, SPRITE_BEAUTY, WALK, ANY_DIR, 8 ; rehabilitation center and bird fan club
	object_event 20, 10, SPRITE_COOLTRAINER_M, WALK, ANY_DIR, 9 ; nature integration
;	object_event 30, 12, SPRITE_BEAUTY, WALK, ANY_DIR, 10 ; ochre city so great
	object_event 30, 12, SPRITE_TRAVELER, STAY, ANY_DIR, 10 ; new, traveler
	object_event 26, 19, SPRITE_SUPER_NERD, WALK, ANY_DIR, 11 ; zoning
	object_event 19, 26, SPRITE_COOLTRAINER_F, STAY, ANY_DIR, 12 ; wait friends walk park
	object_event 34, 36, SPRITE_BIRD, WALK, ANY_DIR, 13
	object_event 39, 33, SPRITE_BIRD, WALK, ANY_DIR, 14

	def_warps_to OCHRE_CITY
