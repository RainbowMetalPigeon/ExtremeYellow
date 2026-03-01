SeviiAlteringCave4_Object:
	db $cc ; border block

	def_warp_events
	warp_event  3,  5, SEVII_ALTERING_CAVE, 3

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3
;	bg_event 11, 11, 5 ; Route2Text4

	def_object_events
	object_event  1,  1, SPRITE_POKE_BALL, STAY, NONE, 1
	object_event  2,  1, SPRITE_POKE_BALL, STAY, NONE, 2
	object_event  3,  1, SPRITE_POKE_BALL, STAY, NONE, 3

	def_warps_to SEVII_ALTERING_CAVE_4
