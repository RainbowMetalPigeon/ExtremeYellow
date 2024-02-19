PikachuGrotto_Object:
	db $3 ; border block

	def_warp_events
	warp_event 10, 21, ROUTE_30, 1
	warp_event 11, 21, ROUTE_30, 1

	def_bg_events
;	bg_event 11, 29, 8 ; RockTunnel1Text8

	def_object_events
	object_event 11, 10, SPRITE_POKE_BALL, STAY, NONE, 1, LIGHT_BALL

	def_warps_to PIKACHU_GROTTO
