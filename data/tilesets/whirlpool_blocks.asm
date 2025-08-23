UndoWhirlpoolBlockSwaps:: ; new, for whirlpool
	; first byte = tileset block containing the whirlpool
	; second byte = corresponding tileset block after the undo whirlpool animation happens
	db $23, $19
	db $26, $18
	db $45, $18
	db $27, $6B
	db $44, $8B
	db -1 ; end
	