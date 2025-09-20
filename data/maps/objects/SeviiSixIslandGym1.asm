SeviiSixIslandGym1_Object:
	db $0f ; border block

	def_warp_events
; intro room
	warp_event  2,  7, SEVII_SIX_ISLAND_CITY, 5  ;  1
	warp_event  3,  7, SEVII_SIX_ISLAND_CITY, 5  ;  2
	warp_event  4,  2, SEVII_SIX_ISLAND_GYM_1, 4 ;  3
; Layer 0 - stat debuffs
	warp_event 17,  5, SEVII_SIX_ISLAND_GYM_1,  1 ;  4 ; entry warp, its target is meaningless
	warp_event 16,  0, SEVII_SIX_ISLAND_GYM_1, 12 ;  5 ; BRN room
	warp_event 18,  0, SEVII_SIX_ISLAND_GYM_1, 16 ;  6 ; PAR room
	warp_event 20,  0, SEVII_SIX_ISLAND_GYM_1,  8 ;  7 ; PSN room
; Layer 1 - PSN
	warp_event 31,  5, SEVII_SIX_ISLAND_GYM_1,  1 ;  8 ; entry warp, its target is meaningless
	warp_event 30,  0, SEVII_SIX_ISLAND_GYM_2,  5 ;  9 ; Spikes room
	warp_event 32,  0, SEVII_SIX_ISLAND_GYM_2,  1 ; 10 ; Rocks room
	warp_event 34,  0, SEVII_SIX_ISLAND_GYM_2, 13 ; 11 ; Confusion room
; Layer 1 - BRN
	warp_event 45,  5, SEVII_SIX_ISLAND_GYM_1,  1 ; 12 ; entry warp, its target is meaningless
	warp_event 44,  0, SEVII_SIX_ISLAND_GYM_2,  1 ; 13 ; Rocks room
	warp_event 46,  0, SEVII_SIX_ISLAND_GYM_2, 17 ; 14 ; Seeds room
	warp_event 48,  0, SEVII_SIX_ISLAND_GYM_2,  9 ; 15 ; Toxic Spikes room
; Layer 1 - PAR
	warp_event 59,  5, SEVII_SIX_ISLAND_GYM_1,  1 ; 16 ; entry warp, its target is meaningless
	warp_event 58,  0, SEVII_SIX_ISLAND_GYM_2, 21 ; 17 ; Curse room
	warp_event 60,  0, SEVII_SIX_ISLAND_GYM_2,  5 ; 18 ; Spikes room
	warp_event 62,  0, SEVII_SIX_ISLAND_GYM_2,  9 ; 19 ; Toxic Spikes room

	def_bg_events
	bg_event 14,  0, 2 ; SeviiSixIslandGym1SignText1
	bg_event 28,  0, 3 ; SeviiSixIslandGym1SignText2
	bg_event 42,  0, 4 ; SeviiSixIslandGym1SignText3
	bg_event 56,  0, 5 ; SeviiSixIslandGym1SignText4

	def_object_events
	object_event  4,  5, SPRITE_GYM_GUIDE, STAY, DOWN, 1 ; Guide

	def_warps_to SEVII_SIX_ISLAND_GYM_1
