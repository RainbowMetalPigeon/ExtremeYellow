SeviiSixIslandGym3_Object:
	db $0f ; border block

	def_warp_events
; Layer 3 - Web
	warp_event  3,  5, SEVII_SIX_ISLAND_GYM_1,  1 ;  1 ; entry warp, its target is meaningless
	warp_event  2,  0, SEVII_SIX_ISLAND_GYM_3,  5 ;  2 ; FRZ room
	warp_event  4,  0, SEVII_SIX_ISLAND_GYM_3, 13 ;  3 ; Rokusei room
	warp_event  6,  0, SEVII_SIX_ISLAND_GYM_1,  4 ;  4 ; Stat debuff room (starting point)
; Layer 3 - FRZ
	warp_event 17,  5, SEVII_SIX_ISLAND_GYM_1,  1 ;  5 ; entry warp, its target is meaningless
	warp_event 16,  0, SEVII_SIX_ISLAND_GYM_3, 13 ;  6 ; Rokusei room
	warp_event 18,  0, SEVII_SIX_ISLAND_GYM_1,  4 ;  7 ; Stat debuff room (starting point)
	warp_event 20,  0, SEVII_SIX_ISLAND_GYM_3,  5 ;  8 ; FRZ room (itself)
; Layer 3 - SLP
	warp_event 31,  5, SEVII_SIX_ISLAND_GYM_1,  1 ;  9 ; entry warp, its target is meaningless
	warp_event 30,  0, SEVII_SIX_ISLAND_GYM_1,  4 ; 10 ; Stat debuff room (starting point)
	warp_event 32,  0, SEVII_SIX_ISLAND_GYM_3, 13 ; 11 ; Rokusei room
	warp_event 34,  0, SEVII_SIX_ISLAND_GYM_3,  5 ; 12 ; FRZ room
; Layer 4 - Rokusei
	warp_event 45,  5, SEVII_SIX_ISLAND_GYM_1,  1 ; 13 ; entry warp, its target is meaningless

	def_bg_events
	bg_event  0,  0, 2 ; SeviiSixIslandGym3SignText1
	bg_event 14,  0, 3 ; SeviiSixIslandGym3SignText2
	bg_event 28,  0, 4 ; SeviiSixIslandGym3SignText3

	def_object_events
	object_event 46,  2, SPRITE_ROKUSEI, STAY, DOWN, 1 ; Rokusei

	def_warps_to SEVII_SIX_ISLAND_GYM_3
