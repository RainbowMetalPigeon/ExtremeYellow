CeladonMansion2F_Object:
	db $f ; border block

	def_warp_events
	warp_event  8,  1, CELADON_MANSION_3F, 1
	warp_event  9,  1, CELADON_MANSION_1F, 4
	warp_event  4,  1, CELADON_MANSION_1F, 5
	warp_event  6,  1, CELADON_MANSION_3F, 4

	def_bg_events
	bg_event  6,  9, 9 ; CeladonMansion2TextSign1
	bg_event  1,  3, 10 ; CeladonMansion2TextSign2 ; Drush/ISSOtm, ax6, (Sylvie/Rangi42), -Crystal-, -luckytyphlosion-
	bg_event  3,  3, 11 ; CeladonMansion2TextSign3 ; Vortiene, PlagueVonKarma, Lily, Xillicis
	bg_event  5,  3, 12 ; CeladonMansion2TextSign4 ; MauveSea, LJSTAR, [Sanqui]

	def_object_events
	object_event  2,  4, SPRITE_BIRD, STAY, ANY_DIR, 1 ; pigeon
	object_event  5,  6, SPRITE_CRAMORANT, WALK, ANY_DIR, 2 ; Cramorant
	object_event  0,  5, SPRITE_CARROT, WALK, ANY_DIR, 3 ; Vimescarrot = BlueZangoose
	object_event  1,  7, SPRITE_MORD, WALK, ANY_DIR, 4 ; Mord
	object_event  2,  8, SPRITE_CUBONE, WALK, ANY_DIR, 5 ; Dannye
	object_event  4,  8, SPRITE_MEW, WALK, ANY_DIR, 6 ; SatoMew
	object_event  3,  6, SPRITE_SNORLAX, STAY, DOWN, 7 ; JoJo
	object_event  6,  5, SPRITE_FRENCHORANGE, STAY, ANY_DIR, 8 ; Orange

	def_warps_to CELADON_MANSION_2F
