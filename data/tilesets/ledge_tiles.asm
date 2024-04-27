LedgeTiles:
	; player direction, tile player standing on, ledge tile, input required
	db SPRITE_FACING_DOWN,  $2C, $37, D_DOWN
	db SPRITE_FACING_DOWN,  $2C, $36, D_DOWN ; new, for Cerulean
	db SPRITE_FACING_DOWN,  $39, $36, D_DOWN
	db SPRITE_FACING_DOWN,  $39, $37, D_DOWN
	db SPRITE_FACING_LEFT,  $2C, $27, D_LEFT
	db SPRITE_FACING_LEFT,  $39, $27, D_LEFT
	db SPRITE_FACING_RIGHT, $2C, $0D, D_RIGHT
	db SPRITE_FACING_RIGHT, $2C, $1D, D_RIGHT
	db SPRITE_FACING_RIGHT, $39, $0D, D_RIGHT
	; new, for Haunted House, testing, may need a separate list if there are overlaps with OVERWORLD
	; need to modify the button vs the direction, due to the scrambling happening in CheckIfDirectionalButtonIsPressed
	db SPRITE_FACING_DOWN,  $11, $67, D_RIGHT ; going DOWN
	db SPRITE_FACING_RIGHT, $11, $68, D_UP    ; going RIGHT
	db SPRITE_FACING_UP,    $11, $69, D_LEFT  ; going UP
	db SPRITE_FACING_LEFT,  $11, $6A, D_DOWN  ; going LEFT
	db SPRITE_FACING_RIGHT, $64, $68, D_UP    ; going RIGHT
	db SPRITE_FACING_LEFT,  $64, $6A, D_DOWN  ; going LEFT
	db -1 ; end
