WarpPadAndHoleData:
	; tileset id, tile id, value for [wStandingOnWarpPadOrHole]
	db FACILITY, $20, 1 ; warp pad
	db FACILITY, $48, 1 ; warp pad ; new
	db FACILITY, $11, 2 ; hole
	db CAVERN,   $22, 2 ; hole
	db INTERIOR, $55, 1 ; warp pad
	db GYM,      $15, 1 ; warp pad, new, for Ochre Gym teleporters
	db -1 ; end
