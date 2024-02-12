OchreResearchCenter1_Object:
	db $17 ; border block

	def_warp_events
	warp_event  2, 31, OCHRE_CITY, 7 ; 1
	warp_event  3, 31, OCHRE_CITY, 7 ; 2
	warp_event 10, 24, OCHRE_RESEARCH_CENTER_1, 4 ; 3
	warp_event  8, 12, OCHRE_RESEARCH_CENTER_1, 3 ; 4
	warp_event 10, 12, OCHRE_RESEARCH_CENTER_1, 6 ; 5
	warp_event  8,  0, OCHRE_RESEARCH_CENTER_1, 5 ; 6
	warp_event 10,  0, OCHRE_RESEARCH_CENTER_2, 1 ; 7

	def_bg_events
	bg_event 11, 24, 10 ; OchreResearchCenterSign_Hall
	bg_event 11, 12, 11 ; OchreResearchCenterSign_Ball
	bg_event 11,  0, 12 ; OchreResearchCenterSign_Power

	def_object_events
	; hall
	object_event  2, 26, SPRITE_SUPER_NERD, STAY, DOWN, 1 ; receptionist
	; balls
	object_event  9, 15, SPRITE_SCIENTIST_F, STAY, DOWN, 2 ; kalos
	object_event  5, 16, SPRITE_MIDDLE_AGED_MAN, STAY, RIGHT, 3 ; Kurtz
	object_event  7, 18, SPRITE_SCIENTIST, STAY, UP, 4 ; silph
	object_event  7, 16, SPRITE_POKE_BALL, STAY, NONE, 5 ; heavy
	object_event  8, 16, SPRITE_POKE_BALL, STAY, NONE, 6 ; fast
	; power
	object_event  8,  6, SPRITE_SCIENTIST_F, STAY, UP, 7 ; galar
	object_event  0,  5, SPRITE_SCIENTIST_F, STAY, UP, 8 ; valley windworks: subquest for Thunder Orb
	object_event  6,  2, SPRITE_SCIENTIST, WALK, LEFT_RIGHT, 9 ; kanto

	def_warps_to OCHRE_RESEARCH_CENTER_1
