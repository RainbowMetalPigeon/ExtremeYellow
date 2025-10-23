WarpTileIDPointers:
	table_width 2, WarpTileIDPointers
	dw .OverworldWarpTileIDs
	dw .RedsHouse1WarpTileIDs
	dw .MartWarpTileIDs
	dw .ForestWarpTileIDs
	dw .RedsHouse2WarpTileIDs
	dw .DojoWarpTileIDs
	dw .PokecenterWarpTileIDs
	dw .GymWarpTileIDs
	dw .HouseWarpTileIDs
	dw .ForestGateWarpTileIDs
	dw .MuseumWarpTileIDs
	dw .UndergroundWarpTileIDs
	dw .GateWarpTileIDs
	dw .ShipWarpTileIDs
	dw .ShipPortWarpTileIDs
	dw .CemeteryWarpTileIDs
	dw .InteriorWarpTileIDs
	dw .CavernWarpTileIDs
	dw .LobbyWarpTileIDs
	dw .MansionWarpTileIDs
	dw .LabWarpTileIDs
	dw .ClubWarpTileIDs
	dw .FacilityWarpTileIDs
	dw .PlateauWarpTileIDs
	dw .BeachHouseWarpTileIDs
	dw .ResearchCenterWarpTileIDs ; new
	dw .IslandWarpTileIDs ; new
	dw .OverworldHauntedWarpTileIDs ; new
	dw .IslandOfNumbersdWarpTileIDs ; new
	dw .OverworldSeviiWarpTileIDs ; new
	dw .UnderwaterWarpTileIDs ; new
	dw .ShipWarpTileIDs ; new
	assert_table_length NUM_TILESETS

MACRO warp_tiles
	IF _NARG
		db \# ; all args
	ENDC
	db -1 ; end
ENDM

.OverworldWarpTileIDs:
	warp_tiles $1B, $58

.ForestGateWarpTileIDs:
.MuseumWarpTileIDs:
.GateWarpTileIDs:
	db $3B
	; fallthrough
.RedsHouse1WarpTileIDs:
.RedsHouse2WarpTileIDs:
	warp_tiles $1A, $1C

.MartWarpTileIDs:
.PokecenterWarpTileIDs:
	warp_tiles $5E

.ForestWarpTileIDs:
	warp_tiles $5A, $5C, $3A

.DojoWarpTileIDs:
.GymWarpTileIDs:
	warp_tiles $4A, $15 ; edited, last 1 are new

.HouseWarpTileIDs:
	warp_tiles $54, $5C, $32

.ShipWarpTileIDs:
	warp_tiles $37, $39, $1E, $4A

.InteriorWarpTileIDs:
	warp_tiles $15, $55, $04, $5f ; edited, last 1 are new

.CavernWarpTileIDs:
	warp_tiles $18, $1A, $22

.LobbyWarpTileIDs:
	warp_tiles $1A, $1C, $38

.MansionWarpTileIDs:
	warp_tiles $1A, $1C, $53, $6F ; edited, last 1 are new

.LabWarpTileIDs:
	warp_tiles $34

.FacilityWarpTileIDs:
	db $43, $58, $20, $48 ; edited, last 1 is new
	; fallthrough
.CemeteryWarpTileIDs:
	db $1B
	; fallthrough
.UndergroundWarpTileIDs:
	warp_tiles $13

.PlateauWarpTileIDs:
	db $1B, $3B
	; fallthrough
.ShipPortWarpTileIDs: ; edited
	warp_tiles ; end

.ClubWarpTileIDs: ; edited
	warp_tiles $4D ; new

.BeachHouseWarpTileIDs:
	warp_tiles ; end

.ResearchCenterWarpTileIDs: ; new
	warp_tiles $20, $30

.IslandWarpTileIDs: ; new
	warp_tiles $58

.OverworldHauntedWarpTileIDs: ; new, TBE
	warp_tiles $1B, $58

.IslandOfNumbersdWarpTileIDs: ; new
	warp_tiles $00 ; only warp is the black one that appears after missingno is defeated
	
.OverworldSeviiWarpTileIDs: ; new
	warp_tiles $1B, $58, $6F, $73

.UnderwaterWarpTileIDs: ; new
	warp_tiles $2A, $70

.SunkenShipWarpTileIDs: ; new
	warp_tiles $37, $39, $1E, $4A
