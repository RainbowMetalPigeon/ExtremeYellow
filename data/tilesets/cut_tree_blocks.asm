CutTreeBlockSwaps:
	; first byte = tileset block containing the cut tree
	; second byte = corresponding tileset block after the cut animation happens
	db $32, $6D
	db $33, $6C
	db $34, $6F
	db $35, $4C
	db $60, $6E
	db $0B, $0A
	db $3C, $35
	db $3F, $35
	db $3D, $36
	db $B8, $4C ; new, for OVERWORLD (used in FUCHSIA_CITY)
	db $B9, $BA ; new, for OVERWORLD (used in FUCHSIA_CITY)
	db $4D, $4E ; new, for ISLAND blockset
	db $8B, $05 ; new, for CAVERN blockset
	db -1 ; end
