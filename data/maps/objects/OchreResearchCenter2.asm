OchreResearchCenter2_Object:
	db $17 ; border block

	def_warp_events
	warp_event  8, 12, OCHRE_RESEARCH_CENTER_1, 7 ; 1
	warp_event 10, 12, OCHRE_RESEARCH_CENTER_2, 3 ; 2
	warp_event  8,  0, OCHRE_RESEARCH_CENTER_2, 2 ; 3

	def_bg_events
	bg_event 11, 12, 13 ; OchreResearchCenterSign_Fossil
	bg_event  9,  0, 14 ; OchreResearchCenterSign_Dreams
	bg_event  4,  1, 15 ; OchreResearchCenterSign_Monitor

	def_object_events
	; fossil
	object_event  1, 17, SPRITE_SCIENTIST, STAY, RIGHT, 1 ; cinnabar
	object_event  5, 15, SPRITE_SCIENTIST_F, STAY, DOWN, 2 ; devon
	object_event  3, 15, SPRITE_SCIENTIST, STAY, DOWN, 3 ; sinnoh oreburgh
	object_event  2, 18, SPRITE_SCIENTIST_F, STAY, UP, 4 ; unova nacrene
	object_event  4, 18, SPRITE_SCIENTIST_F, STAY, UP, 5 ; kalos ambrette
	object_event  6, 18, SPRITE_SCIENTIST_F, STAY, UP, 6 ; alola
	object_event 10, 17, SPRITE_SCIENTIST_F, STAY, LEFT, 7 ; galar
	object_event  2, 16, SPRITE_FOSSIL, STAY, NONE, 8 ; a fossil
	; dream
	object_event 10,  5, SPRITE_SCIENTIST, STAY, UP, 9 ; devon
	object_event  5,  2, SPRITE_SCIENTIST_F, STAY, UP, 10 ; unova
	object_event  2,  6, SPRITE_SCIENTIST_F, STAY, UP, 11 ; interim
	object_event  2,  5, SPRITE_CLEFAIRY, STAY, DOWN, 12 ; sleeping

	def_warps_to OCHRE_RESEARCH_CENTER_2
