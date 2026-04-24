PokemonMansionB1F_Object:
	db $1 ; border block

	def_warp_events
	warp_event 23, 22, POKEMON_MANSION_1F, 6 ; 1
	; new, B2F
	warp_event   1,  1, POKEMON_MANSION_B1F, 11 ;  2
	warp_event  70, 26, POKEMON_MANSION_B1F, 12 ;  3
	warp_event  47,  2, POKEMON_MANSION_B1F, 13 ;  4
	warp_event  50, 15, POKEMON_MANSION_B1F, 14 ;  5
	warp_event  59, 14, POKEMON_MANSION_B1F, 15 ;  6
	warp_event  68, 15, POKEMON_MANSION_B1F, 16 ;  7
	warp_event  38, 25, POKEMON_MANSION_B1F, 17 ;  8
	warp_event  51, 22, POKEMON_MANSION_B1F, 18 ;  9
	warp_event  58, 23, POKEMON_MANSION_B1F, 19 ; 10
	; new, B3F
	warp_event  37,  1, POKEMON_MANSION_B1F,  2 ; 11
	warp_event 114, 26, POKEMON_MANSION_B1F,  3 ; 12
	warp_event  81,  6, POKEMON_MANSION_B1F,  4 ; 13
	warp_event  95, 14, POKEMON_MANSION_B1F,  5 ; 14
	warp_event 103, 12, POKEMON_MANSION_B1F,  6 ; 15
	warp_event 113, 14, POKEMON_MANSION_B1F,  7 ; 16
	warp_event  81, 24, POKEMON_MANSION_B1F,  8 ; 17
	warp_event  93, 24, POKEMON_MANSION_B1F,  9 ; 18
	warp_event 103, 24, POKEMON_MANSION_B1F, 10 ; 19

	def_bg_events
	bg_event 110, 22, 11 ; PokemonMansionB1FTextSign1
	bg_event 111, 22, 12 ; PokemonMansionB1FTextSign1

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
