CeladonMansion2F_Object:
	db $f ; border block

	def_warp_events
	warp_event  6,  1, CELADON_MANSION_3F, 1
	warp_event  7,  1, CELADON_MANSION_1F, 4
	warp_event  2,  1, CELADON_MANSION_1F, 5
	warp_event  4,  1, CELADON_MANSION_3F, 4

	def_bg_events
	bg_event  4,  9, 1 ; CeladonMansion2Text1
;	bg_event xx, xx, n ; CeladonMansion2TextM ; Drush/issotm, Sylvie/Rangi42, ax6, Crystal_, luckytyphlosion
;	bg_event xx, xx, n ; CeladonMansion2TextM ; PlagueVonKarma, Chatot4444, Lily, Xillicis,
;	bg_event xx, xx, n ; CeladonMansion2TextM ; Orange, MauveSea, LJSTAR, Sanqui

	def_object_events
	object_event  0,  6, SPRITE_BIRD, STAY, ANY_DIR, 1 ; pigeon, temp
;	object_event xx, xx, SPRITE_BIKE_SHOP_CLERK, STAY, ANY_DIR, 2 ; Vortiene
;	object_event xx, xx, SPRITE_CLERK, STAY, ANY_DIR, 3 ; Cramorant ; Bird?
;	object_event xx, xx, SPRITE_SUPER_NERD, STAY, ANY_DIR, 4 ; Carrot ; Plant?
;	object_event xx, xx, SPRITE_SILPH_WORKER, STAY, ANY_DIR, 5 ; Mord
;	object_event xx, xx, SPRITE_SILPH_WORKER, STAY, ANY_DIR, 6 ; Dannye ; Monster?
;	object_event xx, xx, SPRITE_SILPH_WORKER, STAY, ANY_DIR, 7 ; JoJo ; Snorlax?
;	object_event xx, xx, SPRITE_COOLTRAINER_F, STAY, ANY_DIR, n ; SatoMew ; Mew=Monster?

	def_warps_to CELADON_MANSION_2F
