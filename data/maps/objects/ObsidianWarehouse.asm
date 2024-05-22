ObsidianWarehouse_Object:
	db $2e ; border block

	def_warp_events
	; exit doors
	warp_event 12, 43, OBSIDIAN_ISLAND, 10		; 1
	warp_event 13, 43, OBSIDIAN_ISLAND, 10		; 2
	warp_event 46, 43, OBSIDIAN_ISLAND, 11		; 3
	warp_event 47, 43, OBSIDIAN_ISLAND, 11		; 4
	; internal doors
	warp_event 27, 34, OBSIDIAN_WAREHOUSE, 7	; 5
	warp_event 27, 35, OBSIDIAN_WAREHOUSE, 8	; 6
	warp_event 34, 34, OBSIDIAN_WAREHOUSE, 5	; 7
	warp_event 34, 35, OBSIDIAN_WAREHOUSE, 6	; 8
	warp_event 27, 14, OBSIDIAN_WAREHOUSE, 11	; 9
	warp_event 27, 15, OBSIDIAN_WAREHOUSE, 12	; 10
	warp_event 34, 14, OBSIDIAN_WAREHOUSE, 9	; 11
	warp_event 34, 15, OBSIDIAN_WAREHOUSE, 10	; 12
	warp_event 27,  4, OBSIDIAN_WAREHOUSE, 15	; 13
	warp_event 27,  5, OBSIDIAN_WAREHOUSE, 16	; 14
	warp_event 34,  4, OBSIDIAN_WAREHOUSE, 13	; 15
	warp_event 34,  5, OBSIDIAN_WAREHOUSE, 14	; 16
	; stairs
	warp_event  4, 25, OBSIDIAN_WAREHOUSE, 19	; 17
	warp_event 21, 28, OBSIDIAN_WAREHOUSE, 20	; 18
	warp_event  4,  1, OBSIDIAN_WAREHOUSE, 17	; 19
	warp_event 21,  4, OBSIDIAN_WAREHOUSE, 18	; 20
	; teleporter
	warp_event 49,  9, OBSIDIAN_WAREHOUSE_FINAL, 1	; 21

	def_bg_events
	bg_event 55,  3, 15 ; ObsidianWarehouseStatueText

	def_object_events
	; trainers
	object_event 13, 34, SPRITE_ROCKET, STAY, DOWN, 1, OPP_ROCKET, 42
	object_event 36, 39, SPRITE_ROCKET, STAY, LEFT, 2, OPP_ROCKET, 43
	object_event 11, 15, SPRITE_ROCKET, STAY, UP, 3, OPP_ROCKET, 44
	object_event 49,  2, SPRITE_ROCKET, STAY, LEFT, 4, OPP_ROCKET, 45
	; items
	object_event  9, 39, SPRITE_POKE_BALL, STAY, NONE, 5, MAX_ELIXER
	object_event 23, 30, SPRITE_POKE_BALL, STAY, NONE, 6, TM_METEOR_MASH ; previously was at SilphCo5F
	object_event 36, 42, SPRITE_POKE_BALL, STAY, NONE, 7, IRON
	object_event 45, 26, SPRITE_POKE_BALL, STAY, NONE, 8, TM_GYRO_BALL ; newly added
	object_event 11, 11, SPRITE_POKE_BALL, STAY, NONE, 9, PP_UP
	object_event 12, 10, SPRITE_POKE_BALL, STAY, NONE, 10, NUGGET
	object_event 56, 11, SPRITE_POKE_BALL, STAY, NONE, 11, MAX_REVIVE
	object_event 50, 10, SPRITE_POKE_BALL, STAY, NONE, 12, GOLD_TEETH ; fundamental!!!
	object_event 58, 42, SPRITE_POKE_BALL, STAY, NONE, 13, RARE_CANDY
	object_event 56,  3, SPRITE_POKE_BALL, STAY, NONE, 14, ESCAPE_ROPE

	def_warps_to OBSIDIAN_WAREHOUSE
