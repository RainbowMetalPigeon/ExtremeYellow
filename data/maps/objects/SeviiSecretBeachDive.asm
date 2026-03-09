SeviiSecretBeachDive_Object:
	db $08 ; border block

	def_warp_events
;	warp_event 26, 21, SEVII_DOTTED_HOLE, 1

	def_bg_events
;	bg_event 25, 21, 15
;	bg_event 26, 21, 16

	def_object_events
;	object_event 53,  5, SPRITE_HIKER, STAY, LEFT, 1
;	; trainers
;	object_event 45, 10, SPRITE_SUPER_NERD, STAY, UP, 2, OPP_ENGINEER, 6
;	; non-persons
;	object_event 23, 14, SPRITE_ROCKSMASHABLE_ROCK, STAY, ROCKSMASHABLE_ROCK_MOVEMENT_BYTE_2, 10
;	object_event 51, 25, SPRITE_POKE_BALL, STAY, NONE, 14, RARE_CANDY

	def_warps_to SEVII_SECRET_BEACH_DIVE
