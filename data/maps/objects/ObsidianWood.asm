ObsidianWood_Object:
	db $3 ; border block

	def_warp_events
	warp_event 22,  0, OBSIDIAN_ISLAND, 3
	warp_event 23,  0, OBSIDIAN_ISLAND, 3
	warp_event  0, 30, OBSIDIAN_ISLAND, 7
	warp_event  0, 31, OBSIDIAN_ISLAND, 8

	def_bg_events
	bg_event 24,  2, 9 ; ObsidianWoodTextSignEntrance
	bg_event 32, 10, 10 ; ObsidianWoodTextSignSpiral
	bg_event 10,  9, 11 ; ObsidianWoodTextSignPlateau
	bg_event  2, 30, 12 ; ObsidianWoodTextSignExit

	def_object_events
	object_event 24, 25, SPRITE_YOUNGSTER, STAY, ANY_DIR, 1, OPP_YOUNGSTER, 15 ; scared kid
	object_event 40,  2, SPRITE_YOUNGSTER, STAY, ANY_DIR, 2, OPP_BUG_CATCHER, 12 ; cool bugs in this forest. what do you mean outside? rocket? what're you talk about?
	object_event  9, 31, SPRITE_COOLTRAINER_F, STAY, ANY_DIR, 3, OPP_COOLTRAINER, 31 ; came here for unusual mons, found rocket, help me training to defeat them; with that strength, i'm sure you can eradicate those sick rocket yourself; rumors say that safari swim till here
	object_event 45, 37, SPRITE_COOLTRAINER_F, STAY, ANY_DIR, 4, OPP_JR_TRAINER, 36 ; Junior Woodchucks, i'm a ten-star general, i'm stronger
	object_event 33, 10, SPRITE_COOLTRAINER_F, STAY, ANY_DIR, 5 ; to be edited: OW sprite

	object_event  1, 46, SPRITE_POKE_BALL, STAY, NONE, 6, MAX_ETHER
	object_event 32, 46, SPRITE_POKE_BALL, STAY, NONE, 7, MAX_ELIXER
	object_event 14, 16, SPRITE_POKE_BALL, STAY, NONE, 8, ULTRA_BALL

	def_warps_to OBSIDIAN_WOOD
