SeviiSixIslandGym2_Object:
	db $0f ; border block

	def_warp_events
; Layer 2 - DR - Stealth Rocks
	warp_event  3,  5, SEVII_SIX_ISLAND_GYM_1,  1 ;  1 ; entry warp, its target is meaningless
	warp_event  2,  0, SEVII_SIX_ISLAND_GYM_1, 16 ;  2 ; PAR room
	warp_event  4,  0, SEVII_SIX_ISLAND_GYM_2, 21 ;  3 ; Curse room
	warp_event  6,  0, SEVII_SIX_ISLAND_GYM_3,  9 ;  4 ; SLP room
; Layer 2 - DR - Spikes
	warp_event 17,  5, SEVII_SIX_ISLAND_GYM_1,  1 ;  5 ; entry warp, its target is meaningless
	warp_event 16,  0, SEVII_SIX_ISLAND_GYM_3,  9 ;  6 ; SLP room
	warp_event 18,  0, SEVII_SIX_ISLAND_GYM_1, 12 ;  7 ; BRN room
	warp_event 20,  0, SEVII_SIX_ISLAND_GYM_2, 17 ;  8 ; Seeds room
; Layer 2 - DR - Toxic Spikes
	warp_event 31,  5, SEVII_SIX_ISLAND_GYM_1,  1 ;  9 ; entry warp, its target is meaningless
	warp_event 30,  0, SEVII_SIX_ISLAND_GYM_1,  8 ; 10 ; PSN room
	warp_event 32,  0, SEVII_SIX_ISLAND_GYM_3,  9 ; 11 ; SLP room
	warp_event 34,  0, SEVII_SIX_ISLAND_GYM_2, 13 ; 12 ; Confusion room
; Layer 2 - SR - Confusion
	warp_event 45,  5, SEVII_SIX_ISLAND_GYM_1,  1 ; 13 ; entry warp, its target is meaningless
	warp_event 44,  0, SEVII_SIX_ISLAND_GYM_3,  1 ; 14 ; Web room
	warp_event 46,  0, SEVII_SIX_ISLAND_GYM_2, 17 ; 15 ; Seeds room
	warp_event 48,  0, SEVII_SIX_ISLAND_GYM_1, 16 ; 16 ; PAR room
; Layer 2 - SR - Leech Seed
	warp_event 59,  5, SEVII_SIX_ISLAND_GYM_1,  1 ; 17 ; entry warp, its target is meaningless
	warp_event 58,  0, SEVII_SIX_ISLAND_GYM_1,  8 ; 18 ; PSN room
	warp_event 60,  0, SEVII_SIX_ISLAND_GYM_2, 21 ; 19 ; Curse room
	warp_event 62,  0, SEVII_SIX_ISLAND_GYM_3,  1 ; 20 ; Web room
; Layer 2 - SR - Curse
	warp_event 73,  5, SEVII_SIX_ISLAND_GYM_1,  1 ; 21 ; entry warp, its target is meaningless
	warp_event 72,  0, SEVII_SIX_ISLAND_GYM_2, 13 ; 22 ; Confusion room
	warp_event 74,  0, SEVII_SIX_ISLAND_GYM_3,  1 ; 23 ; Web room
	warp_event 76,  0, SEVII_SIX_ISLAND_GYM_1, 12 ; 24 ; BRN room

	def_bg_events
	bg_event  0,  0, 1 ; SeviiSixIslandGym2SignText1
	bg_event 14,  0, 2 ; SeviiSixIslandGym2SignText2
	bg_event 28,  0, 3 ; SeviiSixIslandGym2SignText3
	bg_event 42,  0, 4 ; SeviiSixIslandGym2SignText4
	bg_event 56,  0, 5 ; SeviiSixIslandGym2SignText5
	bg_event 70,  0, 6 ; SeviiSixIslandGym2SignText6

	def_object_events

	def_warps_to SEVII_SIX_ISLAND_GYM_2
