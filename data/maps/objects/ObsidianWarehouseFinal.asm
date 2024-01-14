ObsidianWarehouseFinal_Object:
	db $2e ; border block

	def_warp_events
	warp_event  5, 19, OBSIDIAN_WAREHOUSE, 21	; teleporter
	warp_event  6,  0, OBSIDIAN_ISLAND, 10		; exit stairs

	def_bg_events

	def_object_events
	; Jessie & James
	object_event  4, 12, SPRITE_JAMES, STAY, DOWN, 1 ; opp 50
	object_event  5, 12, SPRITE_JESSIE, STAY, DOWN, 2
	; Executives
	object_event  4,  9, SPRITE_ROCKET, STAY, RIGHT, 3, OPP_ROCKET, 51
	object_event  7,  9, SPRITE_ROCKET, STAY, LEFT, 4, OPP_ROCKET, 52
	object_event  6,  7, SPRITE_ROCKET, STAY, DOWN, 5, OPP_ROCKET, 53
	object_event  8,  5, SPRITE_ROCKET, STAY, LEFT, 6, OPP_ROCKET, 54 ; =$36
	; Giovanni
	object_event  5,  1, SPRITE_GIOVANNI, STAY, DOWN, 7, OPP_GIOVANNI, 3

	def_warps_to OBSIDIAN_WAREHOUSE_FINAL
