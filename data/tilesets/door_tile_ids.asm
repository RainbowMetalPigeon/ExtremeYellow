DoorTileIDPointers:
	dbw OVERWORLD,   .OverworldDoorTileIDs
	dbw FOREST,      .ForestDoorTileIDs
	dbw MART,        .MartDoorTileIDs
	dbw HOUSE,       .HouseDoorTileIDs
	dbw FOREST_GATE, .TilesetMuseumDoorTileIDs
	dbw MUSEUM,      .TilesetMuseumDoorTileIDs
	dbw GATE,        .TilesetMuseumDoorTileIDs
	dbw SHIP,        .ShipDoorTileIDs
	dbw LOBBY,       .LobbyDoorTileIDs
	dbw MANSION,     .MansionDoorTileIDs
	dbw LAB,         .LabDoorTileIDs
	dbw FACILITY,    .FacilityDoorTileIDs
	dbw PLATEAU,     .PlateauDoorTileIDs
	dbw INTERIOR,    .InteriorDoorTileIDs
	dbw RESEARCH_CENTER, .ResearchCenterDoorTileIDs ; new
	dbw ISLAND,      .IslandDoorTileIDs ; new
	dbw CLUB,        .ClubDoorTileIDs ; new
	dbw OVERWORLD_HAUNTED, .OverworldHauntedDoorTileIDs ; new
	dbw OVERWORLD_SEVII,   .OverworldSeviiDoorTileIDs ; new
	db -1 ; end

MACRO door_tiles
	IF _NARG
		db \# ; all args
	ENDC
	db 0 ; end
ENDM

.OverworldDoorTileIDs:
	door_tiles $1B, $58

.ForestDoorTileIDs:
	door_tiles $3a

.MartDoorTileIDs:
	door_tiles $5e

.HouseDoorTileIDs:
	door_tiles $54

.TilesetMuseumDoorTileIDs:
	door_tiles $3b

.ShipDoorTileIDs:
	door_tiles $1e

.LobbyDoorTileIDs:
	door_tiles $1c, $38, $1a

.MansionDoorTileIDs:
	door_tiles $1a, $1c, $53

.LabDoorTileIDs:
	door_tiles $34

.FacilityDoorTileIDs:
	door_tiles $43, $58, $1b

.PlateauDoorTileIDs:
	door_tiles $3b, $1b

.InteriorDoorTileIDs:
	door_tiles $04, $15, $5f ; edited, last one is new

.ResearchCenterDoorTileIDs: ; new
	door_tiles $20, $30, $34

.IslandDoorTileIDs: ; new
	door_tiles $58

.ClubDoorTileIDs: ; new
	door_tiles $4D

.OverworldHauntedDoorTileIDs: ; new, TBE
	door_tiles $1B, $58

.OverworldSeviiDoorTileIDs: ; new
	door_tiles $1B, $58, $6F, $73
