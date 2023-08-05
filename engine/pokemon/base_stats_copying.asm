; from Vortiene:
; in Evolution_PartyMonLoop
; copydata is a function that copies hl to de for bc amount of bytes
; in this case, it's copying data from base stats data to wMonHeader
; for the current pokemon
; since wMonHeader will have everything you need for this whole Evolution code after doing this copy, and the wram value will stay the same regardless of the bank you're in
; all you need to do is run this code specifically in the same bank as base stats then go back to the evolution bank
; which can all be achieved by just callfar'ing a function that does the above code in the base stats bank then returns

BaseStatsCopying::
	ld a, [wd11e]
	dec a
	ld hl, BaseStats
	ld bc, BASE_DATA_SIZE
	call AddNTimes
	ld de, wMonHeader
	call CopyData ; function that copies hl to de for bc amount of bytes = so BaseStats is copied into wMonHeader for BASE_DATA_SIZE amount of bytes
	ret ; new
