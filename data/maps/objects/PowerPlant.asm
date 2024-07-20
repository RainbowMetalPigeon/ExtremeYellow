PowerPlant_Object:
	db $2e ; border block

	def_warp_events
	warp_event  4, 35, LAST_MAP, 4
	warp_event  5, 35, LAST_MAP, 4
	warp_event  0, 11, LAST_MAP, 4

	def_bg_events

	def_object_events
	object_event 33,  6, SPRITE_LT_SURGE, STAY, ANY_DIR, 1 ; new, Lt Surge rematch
	object_event  9, 20, SPRITE_POKE_BALL, STAY, NONE, 2, VOLTORB, 40 | OW_POKEMON ; edited, to go beyond 200
	object_event 32, 18, SPRITE_POKE_BALL, STAY, NONE, 3, VOLTORB, 40 | OW_POKEMON ; edited, to go beyond 200
	object_event 21, 25, SPRITE_POKE_BALL, STAY, NONE, 4, VOLTORB, 40 | OW_POKEMON ; edited, to go beyond 200
	object_event 25, 18, SPRITE_POKE_BALL, STAY, NONE, 5, ELECTRODE, 43 | OW_POKEMON ; edited, to go beyond 200
	object_event 23, 34, SPRITE_POKE_BALL, STAY, NONE, 6, VOLTORB, 40 | OW_POKEMON ; edited, to go beyond 200
	object_event 26, 28, SPRITE_POKE_BALL, STAY, NONE, 7, VOLTORB, 40 | OW_POKEMON ; edited, to go beyond 200
	object_event 21, 14, SPRITE_POKE_BALL, STAY, NONE, 8, ELECTRODE, 43 | OW_POKEMON ; edited, to go beyond 200
	object_event 37, 32, SPRITE_POKE_BALL, STAY, NONE, 9, VOLTORB, 40 | OW_POKEMON ; edited, to go beyond 200
	object_event  4,  9, SPRITE_ZAPDOS, STAY, DOWN, 10, ZAPDOS, 50 | OW_POKEMON ; edited, to go beyond 200
	object_event  7, 25, SPRITE_POKE_BALL, STAY, NONE, 11, CARBOS
	object_event 34,  3, SPRITE_POKE_BALL, STAY, NONE, 12, RARE_CANDY
	object_event 26, 32, SPRITE_POKE_BALL, STAY, NONE, 13, TM_THUNDER
	object_event 20, 32, SPRITE_POKE_BALL, STAY, NONE, 14, TM_THUNDER_WAVE ; edited
	; removed the HP_UP at 28,  3!

	def_warps_to POWER_PLANT
