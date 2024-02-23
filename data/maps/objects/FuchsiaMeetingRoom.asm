FuchsiaMeetingRoom_Object:
	db $17 ; border block

	def_warp_events
	warp_event  4,  7, LAST_MAP, 7
	warp_event  5,  7, LAST_MAP, 7

	def_bg_events

	def_object_events ; edited
	; after defeating Giovanni in Obsidian
	object_event  4,  1, SPRITE_SAFARI_ZONE_WORKER, STAY, DOWN, 1 ; person
	object_event  0,  2, SPRITE_SAFARI_ZONE_WORKER, STAY, UP, 2 ; person
	object_event 10,  1, SPRITE_SAFARI_ZONE_WORKER, STAY, DOWN, 3 ; person
	; before defeating Giovanni in Obsidian
	object_event  9,  2, SPRITE_SAFARI_ZONE_WORKER, STAY, RIGHT, 4 ; person
	object_event 11,  1, SPRITE_SAFARI_ZONE_WORKER, STAY, DOWN, 5 ; person
	object_event 12,  3, SPRITE_SAFARI_ZONE_WORKER, STAY, LEFT, 6 ; person
	object_event 10,  4, SPRITE_SILPH_WORKER, STAY, UP, 7 ; Koga

	def_warps_to FUCHSIA_MEETING_ROOM
