; FORMAT: tileset number, tile 1, tile 2
; terminated by -1
; these entries indicate that the player may not cross between tile 1 and tile 2
; it's mainly used to simulate differences in elevation

TilePairCollisionsLand::
	db CAVERN, $20, $05
	db CAVERN, $41, $05
	db CAVERN, $2A, $05
	db CAVERN, $05, $21
	; new, between stairs and short rocks
	db CAVERN, $18, $05
	db CAVERN, $1A, $05
	
	db FOREST, $30, $2E
	db FOREST, $52, $2E
	db FOREST, $55, $2E
	db FOREST, $56, $2E
	db FOREST, $20, $2E
	db FOREST, $5E, $2E
	db FOREST, $5F, $2E

;	db OVERWORLD, $30, $01 ; new
;	db OVERWORLD, $63, $01 ; new
	db OVERWORLD, $39, $11 ; new
	db OVERWORLD, $11, $62 ; new
;	db OVERWORLD, $58, $62 ; new
	; to prevent walking onto rock plateau from above, now that is walkable
	db OVERWORLD, $2C, $11 ; new
	db OVERWORLD, $23, $11 ; new
	db OVERWORLD, $52, $11 ; new
	db OVERWORLD, $39, $11 ; new
	db OVERWORLD, $30, $11 ; new
;	db OVERWORLD, $58, $11 ; new, should be unnecessary in all cases? it's between a cavern entrance and the rock plateau, but you should just warp
	db OVERWORLD, $20, $11 ; new
	db OVERWORLD, $5B, $11 ; new
	db OVERWORLD, $62, $2C ; new, between new rock plateau and route grassy ground ; $39
	db OVERWORLD, $6C, $58 ; cannot go from 4th copy of rock tile, which is always walkable, into the bottomleft corner of the cavern entrance
	                       ; this 4th copy has been placed only NORTH of the entrances, and never SOUTH
	db -1 ; end

TilePairCollisionsWater::
	db FOREST, $14, $2E
	db FOREST, $48, $2E
	db CAVERN, $14, $05
	; to prevent landing onto rock plateau from above, now that is walkable
	db OVERWORLD, $14, $11 ; new
	db -1 ; end
