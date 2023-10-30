CeladonMansion2F_Object:
	db $f ; border block

	def_warp_events
	warp_event  8,  1, CELADON_MANSION_3F, 1
	warp_event  9,  1, CELADON_MANSION_1F, 4
	warp_event  4,  1, CELADON_MANSION_1F, 5
	warp_event  6,  1, CELADON_MANSION_3F, 4

	def_bg_events
	bg_event  6,  9, 8 ; CeladonMansion2TextSign1
	bg_event  1,  3, 9 ; CeladonMansion2TextSign2 ; Drush/issotm, (Sylvie/Rangi42), ax6, -Crystal-, -luckytyphlosion-
	bg_event  3,  3, 10 ; CeladonMansion2TextSign3 ; Vortiene, PlagueVonKarma, Lily, Xillicis
	bg_event  5,  3, 11 ; CeladonMansion2TextSign4 ; Orange, MauveSea, LJSTAR, [Sanqui]

	def_object_events
	object_event  2,  4, SPRITE_BIRD, STAY, ANY_DIR, 1 ; pigeon, temp
	object_event  5,  6, SPRITE_BIRD, STAY, ANY_DIR, 2 ; Cramorant ; Bird?
	object_event  0,  5, SPRITE_ODDISH, STAY, ANY_DIR, 3 ; Carrot ; Plant?
	object_event  1,  7, SPRITE_SILPH_WORKER, STAY, ANY_DIR, 4 ; Mord
	object_event  2,  8, SPRITE_MONSTER, STAY, ANY_DIR, 5 ; Dannye ; Monster?
	object_event  4,  8, SPRITE_MONSTER, STAY, ANY_DIR, 6 ; SatoMew ; Mew=Monster?
	object_event  9,  8, SPRITE_SNORLAX, STAY, DOWN, 7 ; JoJo ; Snorlax?

	def_warps_to CELADON_MANSION_2F
