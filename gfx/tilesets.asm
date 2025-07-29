SECTION "Tilesets 1", ROMX

Overworld_GFX::     INCBIN "gfx/tilesets/overworld.2bpp"
	ds 32 ; why?
Overworld_Block::   INCBIN "gfx/blocksets/overworld.bst"

RedsHouse1_GFX::
RedsHouse2_GFX::    INCBIN "gfx/tilesets/reds_house.2bpp"
RedsHouse1_Block::
RedsHouse2_Block::  INCBIN "gfx/blocksets/reds_house.bst"

House_GFX::         INCBIN "gfx/tilesets/house.2bpp"
House_Block::       INCBIN "gfx/blocksets/house.bst"
Mansion_GFX::       INCBIN "gfx/tilesets/mansion.2bpp"
Mansion_Block::     INCBIN "gfx/blocksets/mansion.bst"
;ShipPort_GFX::      INCBIN "gfx/tilesets/ship_port.2bpp" ; moved away
;ShipPort_Block::    INCBIN "gfx/blocksets/ship_port.bst" ; moved away
;Interior_GFX::      INCBIN "gfx/tilesets/interior.2bpp" ; moved away
;Interior_Block::    INCBIN "gfx/blocksets/interior.bst" ; moved away
;Plateau_GFX::       INCBIN "gfx/tilesets/plateau.2bpp" ; moved away
;Plateau_Block::     INCBIN "gfx/blocksets/plateau.bst" ; moved away


SECTION "Tilesets 2", ROMX

Dojo_GFX::
Gym_GFX::           INCBIN "gfx/tilesets/gym.2bpp"
Dojo_Block::
Gym_Block::         INCBIN "gfx/blocksets/gym.bst"

Mart_GFX::
Pokecenter_GFX::    INCBIN "gfx/tilesets/pokecenter.2bpp"
Mart_Block::
Pokecenter_Block::  INCBIN "gfx/blocksets/pokecenter.bst"

ForestGate_GFX::
Museum_GFX::
Gate_GFX::          INCBIN "gfx/tilesets/gate.2bpp"
ForestGate_Block::
Museum_Block::
Gate_Block::        INCBIN "gfx/blocksets/gate.bst"

;Forest_GFX::        INCBIN "gfx/tilesets/forest.2bpp" ; moved away
;Forest_Block::      INCBIN "gfx/blocksets/forest.bst" ; moved away
Facility_GFX::      INCBIN "gfx/tilesets/facility.2bpp"
Facility_Block::    INCBIN "gfx/blocksets/facility.bst"


SECTION "Tilesets 3", ROMX

Cemetery_GFX::      INCBIN "gfx/tilesets/cemetery.2bpp"
Cemetery_Block::    INCBIN "gfx/blocksets/cemetery.bst"
;Cavern_GFX::        INCBIN "gfx/tilesets/cavern.2bpp" ; moved away
;Cavern_Block::      INCBIN "gfx/blocksets/cavern.bst" ; moved away
Lobby_GFX::         INCBIN "gfx/tilesets/lobby.2bpp"
Lobby_Block::       INCBIN "gfx/blocksets/lobby.bst"
Ship_GFX::          INCBIN "gfx/tilesets/ship.2bpp"
Ship_Block::        INCBIN "gfx/blocksets/ship.bst"
Lab_GFX::           INCBIN "gfx/tilesets/lab.2bpp"
Lab_Block::         INCBIN "gfx/blocksets/lab.bst"
Club_GFX::          INCBIN "gfx/tilesets/club.2bpp"
Club_Block::        INCBIN "gfx/blocksets/club.bst"
Underground_GFX::   INCBIN "gfx/tilesets/underground.2bpp"
Underground_Block:: INCBIN "gfx/blocksets/underground.bst"


SECTION "Tilesets 4", ROMX

BeachHouse_GFX::    INCBIN "gfx/tilesets/beach_house.2bpp"
	ds 384
BeachHouse_Block::  INCBIN "gfx/blocksets/beach_house.bst"
Cavern_GFX::        INCBIN "gfx/tilesets/cavern.2bpp"	; moved in
Cavern_Block::      INCBIN "gfx/blocksets/cavern.bst"	; moved in


SECTION "Tilesets 5", ROMX ; new, to contain even more beefy stuff

Interior_GFX::      INCBIN "gfx/tilesets/interior.2bpp" ; moved in
Interior_Block::    INCBIN "gfx/blocksets/interior.bst" ; moved in
Plateau_GFX::       INCBIN "gfx/tilesets/plateau.2bpp" ; moved in
Plateau_Block::     INCBIN "gfx/blocksets/plateau.bst" ; moved in
Forest_GFX::        INCBIN "gfx/tilesets/forest.2bpp" ; moved in
Forest_Block::      INCBIN "gfx/blocksets/forest.bst" ; moved in
ResearchCenter_GFX::   INCBIN "gfx/tilesets/research_center.2bpp" ; new
ResearchCenter_Block:: INCBIN "gfx/blocksets/research_center.bst" ; new
Island_GFX::   INCBIN "gfx/tilesets/island.2bpp" ; new
Island_Block:: INCBIN "gfx/blocksets/island.bst" ; new


SECTION "Tilesets 6", ROMX ; new, to contain even more beefy stuff

ShipPort_GFX::      INCBIN "gfx/tilesets/ship_port.2bpp" ; moved in
ShipPort_Block::    INCBIN "gfx/blocksets/ship_port.bst" ; moved in

OverworldHaunted_GFX::     INCBIN "gfx/tilesets/overworld_haunted.2bpp" ; new
;	ds 32 ; is this needed for anything at all?
OverworldHaunted_Block::   INCBIN "gfx/blocksets/overworld_haunted.bst" ; new

IslandOfNumbers_GFX::   INCBIN "gfx/tilesets/island_of_numbers.2bpp" ; new
IslandOfNumbers_Block:: INCBIN "gfx/blocksets/island_of_numbers.bst" ; new


SECTION "Tilesets 7", ROMX ; new

OverworldSevii_GFX::     INCBIN "gfx/tilesets/overworld_sevii.2bpp"
OverworldSevii_Block::   INCBIN "gfx/blocksets/overworld_sevii.bst"
