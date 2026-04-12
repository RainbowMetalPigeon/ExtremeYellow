PokemonMansionB1F_Object:
	db $1 ; border block

	def_warp_events
	warp_event 23, 22, POKEMON_MANSION_1F, 6

	def_bg_events

	def_object_events
	object_event 16, 23, SPRITE_SUPER_NERD, STAY, NONE, 1, OPP_BURGLAR, 9
	object_event 27, 11, SPRITE_SCIENTIST, STAY, DOWN, 2, OPP_SCIENTIST, 13
	object_event 25,  1, SPRITE_SUPER_NERD, WALK, ANY_DIR, 3, OPP_BURGLAR, 10 ; new
	object_event 10,  2, SPRITE_POKE_BALL, STAY, NONE, 4, RARE_CANDY
	object_event  1, 22, SPRITE_POKE_BALL, STAY, NONE, 5, FULL_RESTORE
	object_event 19, 25, SPRITE_POKE_BALL, STAY, NONE, 6, TM_BLIZZARD
	object_event  5,  4, SPRITE_POKE_BALL, STAY, NONE, 7, TM_STONE_EDGE
	object_event 16, 20, SPRITE_POKEDEX, STAY, NONE, 8 ; person
	object_event  5, 13, SPRITE_POKE_BALL, STAY, NONE, 9, SECRET_KEY
	object_event  3,  6, SPRITE_BLUE, STAY, RIGHT, 10 ; new, rival

	def_warps_to POKEMON_MANSION_B1F
