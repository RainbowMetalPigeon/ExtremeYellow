SeviiUndergroundLobby_Object:
	db $03 ; border block

	def_warp_events
	warp_event  1,  7, SEVII_UNDERGROUND_ONE, 2
	warp_event  1,  1, SEVII_UNDERGROUND_TWO, 2
	warp_event 12,  1, SEVII_UNDERGROUND_THREE, 2
	warp_event  1, 12, SEVII_UNDERGROUND_FOUR, 2
	warp_event  5, 12, SEVII_UNDERGROUND_FIVE, 2
	warp_event 12, 10, SEVII_UNDERGROUND_SIX, 2
	warp_event  8, 12, SEVII_UNDERGROUND_SEVEN, 2
	warp_event  7,  6, SEVII_UNDERGROUND_LOBBY, 9
	warp_event 23, 10, SEVII_UNDERGROUND_LOBBY, 8
	warp_event 22, 13, SEVII_TEN_ISLAND, 1
	warp_event 23, 13, SEVII_TEN_ISLAND, 1

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
;	object_event 25,  5, SPRITE_POKE_BALL, STAY, NONE, 1, NUGGET

	def_warps_to SEVII_UNDERGROUND_LOBBY
