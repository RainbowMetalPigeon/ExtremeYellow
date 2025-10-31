INCLUDE "constants.asm"


SECTION "Maps 1", ROMX

INCLUDE "data/maps/headers/CeladonCity.asm"
INCLUDE "data/maps/objects/CeladonCity.asm"
CeladonCity_Blocks: INCBIN "maps/CeladonCity.blk"

INCLUDE "data/maps/headers/PalletTown.asm"
INCLUDE "data/maps/objects/PalletTown.asm"
PalletTown_Blocks: INCBIN "maps/PalletTown.blk"

INCLUDE "data/maps/headers/ViridianCity.asm"
INCLUDE "data/maps/objects/ViridianCity.asm"
ViridianCity_Blocks: INCBIN "maps/ViridianCity.blk"

INCLUDE "data/maps/headers/PewterCity.asm"
	ds 1
INCLUDE "data/maps/objects/PewterCity.asm"
PewterCity_Blocks: INCBIN "maps/PewterCity.blk"

INCLUDE "data/maps/headers/CeruleanCity.asm"
INCLUDE "data/maps/objects/CeruleanCity.asm"
CeruleanCity_Blocks: INCBIN "maps/CeruleanCity.blk"

INCLUDE "data/maps/headers/VermilionCity.asm"
INCLUDE "data/maps/objects/VermilionCity.asm"
VermilionCity_Blocks: INCBIN "maps/VermilionCity.blk"

INCLUDE "data/maps/headers/FuchsiaCity.asm"
INCLUDE "data/maps/objects/FuchsiaCity.asm"
FuchsiaCity_Blocks: INCBIN "maps/FuchsiaCity.blk"

INCLUDE "data/maps/headers/OchreCity.asm"		; new
INCLUDE "data/maps/objects/OchreCity.asm"		; new
OchreCity_Blocks: INCBIN "maps/OchreCity.blk"	; new

INCLUDE "data/maps/headers/ObsidianIsland.asm"			; new, testing
INCLUDE "data/maps/objects/ObsidianIsland.asm"			; new, testing
ObsidianIsland_Blocks: INCBIN "maps/ObsidianIsland.blk"	; new, testing


SECTION "Maps 2", ROMX

INCLUDE "scripts/PalletTown.asm"
INCLUDE "scripts/ViridianCity.asm"
INCLUDE "scripts/PewterCity.asm"
INCLUDE "scripts/CeruleanCity.asm"
INCLUDE "scripts/VermilionCity.asm"
INCLUDE "scripts/CeladonCity.asm"
INCLUDE "scripts/FuchsiaCity.asm"
INCLUDE "scripts/OchreCity.asm"					; new
INCLUDE "scripts/ObsidianIsland.asm"			; new

INCLUDE "data/maps/headers/BluesHouse.asm"
INCLUDE "scripts/BluesHouse.asm"
INCLUDE "data/maps/objects/BluesHouse.asm"
BluesHouse_Blocks: INCBIN "maps/BluesHouse.blk"

INCLUDE "data/maps/headers/SilphCo4F.asm"
INCLUDE "scripts/SilphCo4F.asm"
INCLUDE "data/maps/objects/SilphCo4F.asm"
SilphCo4F_Blocks: INCBIN "maps/SilphCo4F.blk"

INCLUDE "data/maps/headers/SilphCo5F.asm"
INCLUDE "scripts/SilphCo5F.asm"
INCLUDE "data/maps/objects/SilphCo5F.asm"
SilphCo5F_Blocks: INCBIN "maps/SilphCo5F.blk"

INCLUDE "data/maps/headers/SilphCo6F.asm"
INCLUDE "scripts/SilphCo6F.asm"
INCLUDE "data/maps/objects/SilphCo6F.asm"
SilphCo6F_Blocks: INCBIN "maps/SilphCo6F.blk"


SECTION "Maps 3", ROMX

INCLUDE "data/maps/headers/CinnabarIsland.asm"
INCLUDE "data/maps/objects/CinnabarIsland.asm"
CinnabarIsland_Blocks: INCBIN "maps/CinnabarIsland.blk"

INCLUDE "data/maps/headers/Route1.asm"
INCLUDE "data/maps/objects/Route1.asm"
Route1_Blocks: INCBIN "maps/Route1.blk"

UndergroundPathRoute8_Blocks: INCBIN "maps/UndergroundPathRoute8.blk"

OaksLab_Blocks: INCBIN "maps/OaksLab.blk"

Route16FlyHouse_Blocks:
Route2TradeHouse_Blocks:
SaffronPidgeyHouse_Blocks:
PewterNidoranHouse_Blocks: INCBIN "maps/PewterNidoranHouse.blk" ; edited

MrPsychicsHouse_Blocks: INCBIN "maps/MrPsychicsHouse.blk" ; new

ViridianNicknameHouse_Blocks: INCBIN "maps/ViridianNicknameHouse.blk" ; edited

PewterHouses_Blocks: INCBIN "maps/PewterHouses.blk" ; edited, was SpeechHouse

VermilionHouses_Blocks: ; new, merge of all Vermilion houses
LavenderHouses_Blocks: INCBIN "maps/LavenderHouses.blk" ; new, merge of all Lavender houses

CeladonMansionRoofHouse_Blocks: INCBIN "maps/CeladonMansionRoofHouse.blk" ; edited

ViridianSchoolHouse_Blocks: INCBIN "maps/ViridianSchoolHouse.blk"

CeruleanTrashedHouse_Blocks: INCBIN "maps/CeruleanTrashedHouse.blk" ; unused?

DiglettsCaveRoute11_Blocks:
DiglettsCaveRoute2_Blocks: INCBIN "maps/DiglettsCaveRoute2.blk"


SECTION "Maps 4", ROMX

INCLUDE "scripts/CinnabarIsland.asm"

INCLUDE "scripts/Route1.asm"

INCLUDE "data/maps/headers/OaksLab.asm"
INCLUDE "scripts/OaksLab.asm"
INCLUDE "data/maps/objects/OaksLab.asm"

INCLUDE "data/maps/headers/ViridianMart.asm"
INCLUDE "scripts/ViridianMart.asm"
INCLUDE "data/maps/objects/ViridianMart.asm"
ViridianMart_Blocks: INCBIN "maps/ViridianMart.blk"

INCLUDE "data/maps/headers/ViridianSchoolHouse.asm"
INCLUDE "scripts/ViridianSchoolHouse.asm"
INCLUDE "data/maps/objects/ViridianSchoolHouse.asm"

INCLUDE "data/maps/headers/ViridianNicknameHouse.asm"
	ds 1
INCLUDE "scripts/ViridianNicknameHouse.asm"
INCLUDE "data/maps/objects/ViridianNicknameHouse.asm"

INCLUDE "data/maps/headers/PewterHouses.asm"
INCLUDE "scripts/PewterHouses.asm"
INCLUDE "data/maps/objects/PewterHouses.asm"

INCLUDE "data/maps/headers/CeruleanMelaniesHouse.asm"
INCLUDE "scripts/CeruleanMelaniesHouse.asm"
INCLUDE "data/maps/objects/CeruleanMelaniesHouse.asm"
CeruleanMelaniesHouse_Blocks: INCBIN "maps/CeruleanMelaniesHouse.blk" ; new

INCLUDE "data/maps/headers/BikeShop.asm"
INCLUDE "scripts/BikeShop.asm"
INCLUDE "data/maps/objects/BikeShop.asm"
BikeShop_Blocks: INCBIN "maps/BikeShop.blk"

; edited, merge of all Lavender houses
INCLUDE "data/maps/headers/LavenderHouses.asm"
INCLUDE "scripts/LavenderHouses.asm"
INCLUDE "data/maps/objects/LavenderHouses.asm"

; edited, merge of all Vermilion houses
INCLUDE "data/maps/headers/VermilionHouses.asm"
INCLUDE "scripts/VermilionHouses.asm"
INCLUDE "data/maps/objects/VermilionHouses.asm"

INCLUDE "data/maps/headers/VermilionDock.asm"
INCLUDE "scripts/VermilionDock.asm"
INCLUDE "data/maps/objects/VermilionDock.asm"
VermilionDock_Blocks: INCBIN "maps/VermilionDock.blk"

INCLUDE "data/maps/headers/CeladonMansionRoofHouse.asm"
INCLUDE "scripts/CeladonMansionRoofHouse.asm"
INCLUDE "data/maps/objects/CeladonMansionRoofHouse.asm"

INCLUDE "data/maps/headers/SaffronPidgeyHouse.asm"
INCLUDE "scripts/SaffronPidgeyHouse.asm"
INCLUDE "data/maps/objects/SaffronPidgeyHouse.asm"

INCLUDE "data/maps/headers/MrPsychicsHouse.asm"
INCLUDE "scripts/MrPsychicsHouse.asm"
INCLUDE "data/maps/objects/MrPsychicsHouse.asm"

INCLUDE "data/maps/headers/DiglettsCaveRoute2.asm"
INCLUDE "scripts/DiglettsCaveRoute2.asm"
INCLUDE "data/maps/objects/DiglettsCaveRoute2.asm"

INCLUDE "data/maps/headers/Route2TradeHouse.asm"
INCLUDE "scripts/Route2TradeHouse.asm"
INCLUDE "data/maps/objects/Route2TradeHouse.asm"

INCLUDE "data/maps/headers/Route5Gate.asm"
INCLUDE "scripts/Route5Gate.asm"
INCLUDE "data/maps/objects/Route5Gate.asm"
Route5Gate_Blocks: INCBIN "maps/Route5Gate.blk"

INCLUDE "data/maps/headers/Route6Gate.asm"
INCLUDE "scripts/Route6Gate.asm"
INCLUDE "data/maps/objects/Route6Gate.asm"
Route6Gate_Blocks: INCBIN "maps/Route6Gate.blk"

INCLUDE "data/maps/headers/Route7Gate.asm"
INCLUDE "scripts/Route7Gate.asm"
INCLUDE "data/maps/objects/Route7Gate.asm"
Route7Gate_Blocks: INCBIN "maps/Route7Gate.blk"

INCLUDE "data/maps/headers/Route8Gate.asm"
INCLUDE "scripts/Route8Gate.asm"
INCLUDE "data/maps/objects/Route8Gate.asm"
Route8Gate_Blocks: INCBIN "maps/Route8Gate.blk"

INCLUDE "data/maps/headers/UndergroundPathRoute8.asm"
INCLUDE "scripts/UndergroundPathRoute8.asm"
INCLUDE "data/maps/objects/UndergroundPathRoute8.asm"

INCLUDE "data/maps/headers/PowerPlant.asm"
INCLUDE "scripts/PowerPlant.asm"
INCLUDE "data/maps/objects/PowerPlant.asm"
PowerPlant_Blocks: INCBIN "maps/PowerPlant.blk"

INCLUDE "data/maps/headers/DiglettsCaveRoute11.asm"
INCLUDE "scripts/DiglettsCaveRoute11.asm"
INCLUDE "data/maps/objects/DiglettsCaveRoute11.asm"

INCLUDE "data/maps/headers/Route16FlyHouse.asm"
INCLUDE "scripts/Route16FlyHouse.asm"
INCLUDE "data/maps/objects/Route16FlyHouse.asm"

INCLUDE "data/maps/headers/Route22Gate.asm"
INCLUDE "scripts/Route22Gate.asm"
INCLUDE "data/maps/objects/Route22Gate.asm"
Route22Gate_Blocks: INCBIN "maps/Route22Gate.blk"

INCLUDE "data/maps/headers/BillsHouse.asm"
INCLUDE "scripts/BillsHouse.asm"
INCLUDE "data/maps/objects/BillsHouse.asm"
BillsHouse_Blocks: INCBIN "maps/BillsHouse.blk"


SECTION "Maps 5", ROMX

INCLUDE "data/maps/headers/LavenderTown.asm"
INCLUDE "scripts/LavenderTown.asm"
INCLUDE "data/maps/objects/LavenderTown.asm"
LavenderTown_Blocks: INCBIN "maps/LavenderTown.blk"


SECTION "Maps 6", ROMX

INCLUDE "data/maps/headers/PokemonMansion1F.asm"
INCLUDE "scripts/PokemonMansion1F.asm"
INCLUDE "data/maps/objects/PokemonMansion1F.asm"
PokemonMansion1F_Blocks: INCBIN "maps/PokemonMansion1F.blk"

INCLUDE "data/maps/headers/RockTunnel1F.asm"
INCLUDE "scripts/RockTunnel1F.asm"
INCLUDE "data/maps/objects/RockTunnel1F.asm"
RockTunnel1F_Blocks: INCBIN "maps/RockTunnel1F.blk"

INCLUDE "data/maps/headers/SeafoamIslands1F.asm"
INCLUDE "scripts/SeafoamIslands1F.asm"
INCLUDE "data/maps/objects/SeafoamIslands1F.asm"
SeafoamIslands1F_Blocks: INCBIN "maps/SeafoamIslands1F.blk"

INCLUDE "data/maps/headers/VictoryRoad3F.asm"
INCLUDE "scripts/VictoryRoad3F.asm"
INCLUDE "data/maps/objects/VictoryRoad3F.asm"
VictoryRoad3F_Blocks: INCBIN "maps/VictoryRoad3F.blk"

INCLUDE "data/maps/headers/RocketHideoutB1F.asm"
INCLUDE "scripts/RocketHideoutB1F.asm"
INCLUDE "data/maps/objects/RocketHideoutB1F.asm"
RocketHideoutB1F_Blocks: INCBIN "maps/RocketHideoutB1F.blk"

INCLUDE "data/maps/headers/RocketHideoutB2F.asm"
INCLUDE "scripts/RocketHideoutB2F.asm"
INCLUDE "data/maps/objects/RocketHideoutB2F.asm"
RocketHideoutB2F_Blocks: INCBIN "maps/RocketHideoutB2F.blk"

INCLUDE "data/maps/headers/RocketHideoutB3F.asm"
INCLUDE "scripts/RocketHideoutB3F.asm"
INCLUDE "data/maps/objects/RocketHideoutB3F.asm"
RocketHideoutB3F_Blocks: INCBIN "maps/RocketHideoutB3F.blk"

INCLUDE "data/maps/headers/RocketHideoutB4F.asm"
INCLUDE "scripts/RocketHideoutB4F.asm"
INCLUDE "data/maps/objects/RocketHideoutB4F.asm"
RocketHideoutB4F_Blocks: INCBIN "maps/RocketHideoutB4F.blk"

INCLUDE "data/maps/headers/SafariZoneEast.asm"
INCLUDE "scripts/SafariZoneEast.asm"
INCLUDE "data/maps/objects/SafariZoneEast.asm"
SafariZoneEast_Blocks: INCBIN "maps/SafariZoneEast.blk"

INCLUDE "data/maps/headers/SafariZoneNorth.asm"
INCLUDE "scripts/SafariZoneNorth.asm"
INCLUDE "data/maps/objects/SafariZoneNorth.asm"
SafariZoneNorth_Blocks: INCBIN "maps/SafariZoneNorth.blk"

INCLUDE "data/maps/headers/SafariZoneCenter.asm"
INCLUDE "scripts/SafariZoneCenter.asm"
INCLUDE "data/maps/objects/SafariZoneCenter.asm"
SafariZoneCenter_Blocks: INCBIN "maps/SafariZoneCenter.blk"

INCLUDE "data/maps/headers/CeruleanCave2F.asm"
INCLUDE "scripts/CeruleanCave2F.asm"
INCLUDE "data/maps/objects/CeruleanCave2F.asm"
CeruleanCave2F_Blocks: INCBIN "maps/CeruleanCave2F.blk"

INCLUDE "data/maps/headers/CeruleanCaveB1F.asm"
INCLUDE "scripts/CeruleanCaveB1F.asm"
INCLUDE "data/maps/objects/CeruleanCaveB1F.asm"
CeruleanCaveB1F_Blocks: INCBIN "maps/CeruleanCaveB1F.blk"

INCLUDE "data/maps/headers/RockTunnelB1F.asm"
INCLUDE "scripts/RockTunnelB1F.asm"
INCLUDE "data/maps/objects/RockTunnelB1F.asm"
RockTunnelB1F_Blocks: INCBIN "maps/RockTunnelB1F.blk"

INCLUDE "data/maps/headers/SeafoamIslandsB1F.asm"
INCLUDE "scripts/SeafoamIslandsB1F.asm"
INCLUDE "data/maps/objects/SeafoamIslandsB1F.asm"
SeafoamIslandsB1F_Blocks: INCBIN "maps/SeafoamIslandsB1F.blk"

INCLUDE "data/maps/headers/SeafoamIslandsB2F.asm"
INCLUDE "scripts/SeafoamIslandsB2F.asm"
INCLUDE "data/maps/objects/SeafoamIslandsB2F.asm"
SeafoamIslandsB2F_Blocks: INCBIN "maps/SeafoamIslandsB2F.blk"

INCLUDE "data/maps/headers/SeafoamIslandsB3F.asm"
INCLUDE "scripts/SeafoamIslandsB3F.asm"
INCLUDE "data/maps/objects/SeafoamIslandsB3F.asm"
SeafoamIslandsB3F_Blocks: INCBIN "maps/SeafoamIslandsB3F.blk"

INCLUDE "data/maps/headers/SeafoamIslandsB4F.asm"
INCLUDE "scripts/SeafoamIslandsB4F.asm"
INCLUDE "data/maps/objects/SeafoamIslandsB4F.asm"
SeafoamIslandsB4F_Blocks: INCBIN "maps/SeafoamIslandsB4F.blk"

; --- new dungeon maps, prolly they need to stay here because this Section is in the same bank as the "Dungeon Warps" one ---

INCLUDE "data/maps/headers/CeruleanCaveExtraTop.asm"
INCLUDE "scripts/CeruleanCaveExtraTop.asm"
INCLUDE "data/maps/objects/CeruleanCaveExtraTop.asm"
CeruleanCaveExtraTop_Blocks: INCBIN "maps/CeruleanCaveExtraTop.blk"

INCLUDE "data/maps/headers/CeruleanCaveExtraMiddle.asm"
INCLUDE "scripts/CeruleanCaveExtraMiddle.asm"
INCLUDE "data/maps/objects/CeruleanCaveExtraMiddle.asm"
CeruleanCaveExtraMiddle_Blocks: INCBIN "maps/CeruleanCaveExtraMiddle.blk"

INCLUDE "data/maps/headers/CeruleanCaveExtraBottom.asm"
INCLUDE "scripts/CeruleanCaveExtraBottom.asm"
INCLUDE "data/maps/objects/CeruleanCaveExtraBottom.asm"
CeruleanCaveExtraBottom_Blocks: INCBIN "maps/CeruleanCaveExtraBottom.blk"

INCLUDE "data/maps/headers/CeruleanCaveExtraFinal.asm"
INCLUDE "scripts/CeruleanCaveExtraFinal.asm"
INCLUDE "data/maps/objects/CeruleanCaveExtraFinal.asm"
CeruleanCaveExtraFinal_Blocks: INCBIN "maps/CeruleanCaveExtraFinal.blk"

INCLUDE "data/maps/headers/OchreWonderland.asm"
INCLUDE "scripts/OchreWonderland.asm"
INCLUDE "data/maps/objects/OchreWonderland.asm"
OchreWonderland_Blocks: INCBIN "maps/OchreWonderland.blk"

INCLUDE "data/maps/headers/CinnabarVolcano.asm"
INCLUDE "scripts/CinnabarVolcano.asm"
INCLUDE "data/maps/objects/CinnabarVolcano.asm"
CinnabarVolcano_Blocks: INCBIN "maps/CinnabarVolcano.blk"

INCLUDE "data/maps/headers/CinnabarVolcanoBF.asm"
INCLUDE "scripts/CinnabarVolcanoBF.asm"
INCLUDE "data/maps/objects/CinnabarVolcanoBF.asm"
CinnabarVolcanoBF_Blocks: INCBIN "maps/CinnabarVolcanoBF.blk"


SECTION "Maps 7", ROMX

INCLUDE "data/maps/headers/Route7.asm"
INCLUDE "data/maps/objects/Route7.asm"
Route7_Blocks: INCBIN "maps/Route7.blk"

CeladonPokecenter_Blocks:
RockTunnelPokecenter_Blocks: INCBIN "maps/RockTunnelPokecenter.blk" ; testing
MtMoonPokecenter_Blocks: INCBIN "maps/MtMoonPokecenter.blk"

Route11Gate2F_Blocks: ; UNUSED
Route18Gate2F_Blocks: ; UNUSED
Route16Gate2F_Blocks: ; UNUSED
Route15Gate2F_Blocks: ; UNUSED
Route12Gate2F_Blocks: INCBIN "maps/Route11Gate2F.blk"

Route11Gate1F_Blocks:
Route18Gate1F_Blocks:
Route15Gate1F_Blocks: INCBIN "maps/EastWestGate2Floors.blk"

SECTION "Maps 8", ROMX

INCLUDE "scripts/Route7.asm"

INCLUDE "data/maps/headers/RedsHouse1F.asm"
INCLUDE "scripts/RedsHouse1F.asm"
INCLUDE "data/maps/objects/RedsHouse1F.asm"
RedsHouse1F_Blocks: INCBIN "maps/RedsHouse1F.blk"

INCLUDE "data/maps/headers/CeladonMart3F.asm"
INCLUDE "scripts/CeladonMart3F.asm"
INCLUDE "data/maps/objects/CeladonMart3F.asm"
CeladonMart3F_Blocks: INCBIN "maps/CeladonMart3F.blk"

INCLUDE "data/maps/headers/CeladonMart4F.asm"
INCLUDE "scripts/CeladonMart4F.asm"
INCLUDE "data/maps/objects/CeladonMart4F.asm"
CeladonMart4F_Blocks: INCBIN "maps/CeladonMart4F.blk"

INCLUDE "data/maps/headers/CeladonMartRoof.asm"
INCLUDE "scripts/CeladonMartRoof.asm"
INCLUDE "data/maps/objects/CeladonMartRoof.asm"
CeladonMartRoof_Blocks: INCBIN "maps/CeladonMartRoof.blk"

INCLUDE "data/maps/headers/CeladonMartElevator.asm"
INCLUDE "scripts/CeladonMartElevator.asm"
INCLUDE "data/maps/objects/CeladonMartElevator.asm"
CeladonMartElevator_Blocks: INCBIN "maps/CeladonMartElevator.blk"

INCLUDE "data/maps/headers/CeladonMansion1F.asm"
INCLUDE "scripts/CeladonMansion1F.asm"
INCLUDE "data/maps/objects/CeladonMansion1F.asm"
CeladonMansion1F_Blocks: INCBIN "maps/CeladonMansion1F.blk"

INCLUDE "data/maps/headers/CeladonMansion2F.asm"
INCLUDE "scripts/CeladonMansion2F.asm"
INCLUDE "data/maps/objects/CeladonMansion2F.asm"
CeladonMansion2F_Blocks: INCBIN "maps/CeladonMansion2F.blk"

; UNUSED
INCLUDE "data/maps/headers/CeladonMansion3F.asm"
INCLUDE "scripts/CeladonMansion3F.asm"
INCLUDE "data/maps/objects/CeladonMansion3F.asm"
CeladonMansion3F_Blocks: INCBIN "maps/CeladonMansion3F.blk"

INCLUDE "data/maps/headers/CeladonMansionRoof.asm"
INCLUDE "scripts/CeladonMansionRoof.asm"
INCLUDE "data/maps/objects/CeladonMansionRoof.asm"
CeladonMansionRoof_Blocks: INCBIN "maps/CeladonMansionRoof.blk"

INCLUDE "data/maps/headers/CeladonPokecenter.asm"
INCLUDE "scripts/CeladonPokecenter.asm"
INCLUDE "data/maps/objects/CeladonPokecenter.asm"

INCLUDE "data/maps/headers/CeladonGym.asm"
INCLUDE "scripts/CeladonGym.asm"
INCLUDE "data/maps/objects/CeladonGym.asm"
CeladonGym_Blocks: INCBIN "maps/CeladonGym.blk"

INCLUDE "data/maps/headers/GameCorner.asm"
INCLUDE "scripts/GameCorner.asm"
INCLUDE "data/maps/objects/GameCorner.asm"
GameCorner_Blocks: INCBIN "maps/GameCorner.blk"

INCLUDE "data/maps/headers/CeladonMart5F.asm"
INCLUDE "scripts/CeladonMart5F.asm"
INCLUDE "data/maps/objects/CeladonMart5F.asm"
CeladonMart5F_Blocks: INCBIN "maps/CeladonMart5F.blk"

INCLUDE "data/maps/headers/GameCornerPrizeRoom.asm"
INCLUDE "scripts/GameCornerPrizeRoom.asm"
INCLUDE "data/maps/objects/GameCornerPrizeRoom.asm"
GameCornerPrizeRoom_Blocks: INCBIN "maps/GameCornerPrizeRoom.blk"

INCLUDE "data/maps/headers/CeladonDiner.asm"
INCLUDE "scripts/CeladonDiner.asm"
INCLUDE "data/maps/objects/CeladonDiner.asm"
CeladonDiner_Blocks: INCBIN "maps/CeladonDiner.blk"

INCLUDE "data/maps/headers/CeladonChiefHouse.asm"
INCLUDE "scripts/CeladonChiefHouse.asm"
INCLUDE "data/maps/objects/CeladonChiefHouse.asm"
CeladonChiefHouse_Blocks: INCBIN "maps/CeladonChiefHouse.blk"

INCLUDE "data/maps/headers/CeladonHotel.asm"
INCLUDE "scripts/CeladonHotel.asm"
INCLUDE "data/maps/objects/CeladonHotel.asm"
CeladonHotel_Blocks: INCBIN "maps/CeladonHotel.blk"

INCLUDE "data/maps/headers/MtMoonPokecenter.asm"
INCLUDE "scripts/MtMoonPokecenter.asm"
INCLUDE "data/maps/objects/MtMoonPokecenter.asm"

INCLUDE "data/maps/headers/RockTunnelPokecenter.asm"
INCLUDE "scripts/RockTunnelPokecenter.asm"
INCLUDE "data/maps/objects/RockTunnelPokecenter.asm"

INCLUDE "data/maps/headers/Route11Gate1F.asm"
INCLUDE "scripts/Route11Gate1F.asm"
INCLUDE "data/maps/objects/Route11Gate1F.asm"

INCLUDE "data/maps/headers/Route11Gate2F.asm"
INCLUDE "scripts/Route11Gate2F.asm"
INCLUDE "data/maps/objects/Route11Gate2F.asm"

INCLUDE "data/maps/headers/Route12Gate1F.asm"
INCLUDE "scripts/Route12Gate1F.asm"
INCLUDE "data/maps/objects/Route12Gate1F.asm"
Route12Gate1F_Blocks: INCBIN "maps/Route12Gate1F.blk"

INCLUDE "data/maps/headers/Route12Gate2F.asm"
INCLUDE "scripts/Route12Gate2F.asm"
INCLUDE "data/maps/objects/Route12Gate2F.asm"

INCLUDE "data/maps/headers/Route15Gate1F.asm"
INCLUDE "scripts/Route15Gate1F.asm"
INCLUDE "data/maps/objects/Route15Gate1F.asm"

INCLUDE "data/maps/headers/Route15Gate2F.asm"
INCLUDE "scripts/Route15Gate2F.asm"
INCLUDE "data/maps/objects/Route15Gate2F.asm"

INCLUDE "data/maps/headers/Route16Gate1F.asm"
INCLUDE "scripts/Route16Gate1F.asm"
INCLUDE "data/maps/objects/Route16Gate1F.asm"
Route16Gate1F_Blocks: INCBIN "maps/Route16Gate1F.blk"

INCLUDE "data/maps/headers/Route16Gate2F.asm"
INCLUDE "scripts/Route16Gate2F.asm"
INCLUDE "data/maps/objects/Route16Gate2F.asm"

INCLUDE "data/maps/headers/Route18Gate1F.asm"
INCLUDE "scripts/Route18Gate1F.asm"
INCLUDE "data/maps/objects/Route18Gate1F.asm"

INCLUDE "data/maps/headers/Route18Gate2F.asm"
INCLUDE "scripts/Route18Gate2F.asm"
INCLUDE "data/maps/objects/Route18Gate2F.asm"

INCLUDE "data/maps/headers/MtMoon1F.asm"
INCLUDE "scripts/MtMoon1F.asm"
INCLUDE "data/maps/objects/MtMoon1F.asm"
MtMoon1F_Blocks: INCBIN "maps/MtMoon1F.blk"

INCLUDE "data/maps/headers/MtMoonB2F.asm"
INCLUDE "scripts/MtMoonB2F.asm"
INCLUDE "data/maps/objects/MtMoonB2F.asm"
MtMoonB2F_Blocks: INCBIN "maps/MtMoonB2F.blk"
INCLUDE "scripts/MtMoonB2F_2.asm"

INCLUDE "data/maps/headers/SafariZoneWest.asm"
INCLUDE "scripts/SafariZoneWest.asm"
INCLUDE "data/maps/objects/SafariZoneWest.asm"
SafariZoneWest_Blocks: INCBIN "maps/SafariZoneWest.blk"

INCLUDE "data/maps/headers/SafariZoneSecretHouse.asm"
INCLUDE "scripts/SafariZoneSecretHouse.asm"
INCLUDE "data/maps/objects/SafariZoneSecretHouse.asm"
SafariZoneSecretHouse_Blocks: INCBIN "maps/SafariZoneSecretHouse.blk"


SECTION "Maps 9", ROMX

INCLUDE "data/maps/headers/TradeCenter.asm"
INCLUDE "scripts/TradeCenter.asm"
INCLUDE "data/maps/objects/TradeCenter.asm"
TradeCenter_Blocks: INCBIN "maps/TradeCenter.blk"

INCLUDE "data/maps/headers/Colosseum.asm"
INCLUDE "scripts/Colosseum.asm"
INCLUDE "data/maps/objects/Colosseum.asm"
Colosseum_Blocks: INCBIN "maps/Colosseum.blk"


SECTION "Maps 10", ROMX

INCLUDE "data/maps/headers/Route22.asm"
INCLUDE "data/maps/objects/Route22.asm"
Route22_Blocks: INCBIN "maps/Route22.blk"

INCLUDE "data/maps/headers/Route20.asm"
INCLUDE "data/maps/objects/Route20.asm"
Route20_Blocks: INCBIN "maps/Route20.blk"

INCLUDE "data/maps/headers/Route23.asm"
INCLUDE "data/maps/objects/Route23.asm"
Route23_Blocks: INCBIN "maps/Route23.blk"

INCLUDE "data/maps/headers/Route24.asm"
INCLUDE "data/maps/objects/Route24.asm"
Route24_Blocks: INCBIN "maps/Route24.blk"

INCLUDE "data/maps/headers/Route25.asm"
INCLUDE "data/maps/objects/Route25.asm"
Route25_Blocks: INCBIN "maps/Route25.blk"

INCLUDE "data/maps/headers/IndigoPlateau.asm"
INCLUDE "scripts/IndigoPlateau.asm"
INCLUDE "data/maps/objects/IndigoPlateau.asm"
IndigoPlateau_Blocks: INCBIN "maps/IndigoPlateau.blk"

INCLUDE "data/maps/headers/SaffronCity.asm"
INCLUDE "data/maps/objects/SaffronCity.asm"
SaffronCity_Blocks: INCBIN "maps/SaffronCity.blk"
INCLUDE "scripts/SaffronCity.asm"

INCLUDE "scripts/Route20.asm"
INCLUDE "scripts/Route22.asm"
INCLUDE "scripts/Route23.asm"
INCLUDE "scripts/Route24.asm"
INCLUDE "scripts/Route25.asm"

INCLUDE "data/maps/headers/VictoryRoad2F.asm"
INCLUDE "scripts/VictoryRoad2F.asm"
INCLUDE "data/maps/objects/VictoryRoad2F.asm"
VictoryRoad2F_Blocks: INCBIN "maps/VictoryRoad2F.blk"

INCLUDE "data/maps/headers/MtMoonB1F.asm"
INCLUDE "scripts/MtMoonB1F.asm"
INCLUDE "data/maps/objects/MtMoonB1F.asm"
MtMoonB1F_Blocks: INCBIN "maps/MtMoonB1F.blk"

INCLUDE "data/maps/headers/SilphCo7F.asm"
INCLUDE "scripts/SilphCo7F.asm"
INCLUDE "data/maps/objects/SilphCo7F.asm"
SilphCo7F_Blocks: INCBIN "maps/SilphCo7F.blk"

INCLUDE "data/maps/headers/PokemonMansion2F.asm"
INCLUDE "scripts/PokemonMansion2F.asm"
INCLUDE "data/maps/objects/PokemonMansion2F.asm"
PokemonMansion2F_Blocks: INCBIN "maps/PokemonMansion2F.blk"

INCLUDE "data/maps/headers/PokemonMansion3F.asm"
INCLUDE "scripts/PokemonMansion3F.asm"
INCLUDE "data/maps/objects/PokemonMansion3F.asm"
PokemonMansion3F_Blocks: INCBIN "maps/PokemonMansion3F.blk"

INCLUDE "data/maps/headers/PokemonMansionB1F.asm"
INCLUDE "scripts/PokemonMansionB1F.asm"
INCLUDE "data/maps/objects/PokemonMansionB1F.asm"
PokemonMansionB1F_Blocks: INCBIN "maps/PokemonMansionB1F.blk"


SECTION "Maps 11", ROMX

INCLUDE "data/maps/headers/Route2.asm"
INCLUDE "data/maps/objects/Route2.asm"
Route2_Blocks: INCBIN "maps/Route2.blk"

INCLUDE "data/maps/headers/Route3.asm"
INCLUDE "data/maps/objects/Route3.asm"
Route3_Blocks: INCBIN "maps/Route3.blk"

INCLUDE "data/maps/headers/Route4.asm"
INCLUDE "data/maps/objects/Route4.asm"
Route4_Blocks: INCBIN "maps/Route4.blk"

INCLUDE "data/maps/headers/Route5.asm"
INCLUDE "data/maps/objects/Route5.asm"
Route5_Blocks: INCBIN "maps/Route5.blk"

INCLUDE "data/maps/headers/Route9.asm"
INCLUDE "data/maps/objects/Route9.asm"
Route9_Blocks: INCBIN "maps/Route9.blk"

INCLUDE "data/maps/headers/Route13.asm"
INCLUDE "data/maps/objects/Route13.asm"
Route13_Blocks: INCBIN "maps/Route13.blk"

INCLUDE "data/maps/headers/Route14.asm"
INCLUDE "data/maps/objects/Route14.asm"
Route14_Blocks: INCBIN "maps/Route14.blk"

INCLUDE "data/maps/headers/Route17.asm"
INCLUDE "data/maps/objects/Route17.asm"
Route17_Blocks: INCBIN "maps/Route17.blk"

INCLUDE "data/maps/headers/Route19.asm"
INCLUDE "data/maps/objects/Route19.asm"
Route19_Blocks: INCBIN "maps/Route19.blk"

INCLUDE "data/maps/headers/Route21.asm"
INCLUDE "data/maps/objects/Route21.asm"
Route21_Blocks: INCBIN "maps/Route21.blk"

Route12SuperRodHouse_Blocks:
Daycare_Blocks: INCBIN "maps/Daycare.blk"

FuchsiaGoodRodHouse_Blocks: INCBIN "maps/FuchsiaGoodRodHouse.blk"

INCLUDE "data/maps/headers/Route21Dive.asm"
INCLUDE "scripts/Route21Dive.asm"
INCLUDE "data/maps/objects/Route21Dive.asm"
Route21Dive_Blocks: INCBIN "maps/Route21Dive.blk"

INCLUDE "data/maps/headers/SunkenShip1F.asm"
INCLUDE "scripts/SunkenShip1F.asm"
INCLUDE "data/maps/objects/SunkenShip1F.asm"
SunkenShip1F_Blocks: INCBIN "maps/SunkenShip1F.blk"


SECTION "Maps 12", ROMX

INCLUDE "scripts/Route2.asm"
INCLUDE "scripts/Route3.asm"
INCLUDE "scripts/Route4.asm"
INCLUDE "scripts/Route5.asm"
INCLUDE "scripts/Route9.asm"
INCLUDE "scripts/Route13.asm"
INCLUDE "scripts/Route14.asm"
INCLUDE "scripts/Route17.asm"
INCLUDE "scripts/Route19.asm"
INCLUDE "scripts/Route21.asm"

INCLUDE "data/maps/headers/CeladonMart2F.asm"
INCLUDE "scripts/CeladonMart2F.asm"
INCLUDE "data/maps/objects/CeladonMart2F.asm"
CeladonMart2F_Blocks: INCBIN "maps/CeladonMart2F.blk"

INCLUDE "data/maps/headers/FuchsiaGoodRodHouse.asm"
INCLUDE "scripts/FuchsiaGoodRodHouse.asm"
INCLUDE "data/maps/objects/FuchsiaGoodRodHouse.asm"

INCLUDE "data/maps/headers/Daycare.asm"
INCLUDE "scripts/Daycare.asm"
INCLUDE "data/maps/objects/Daycare.asm"

INCLUDE "data/maps/headers/Route12SuperRodHouse.asm"
INCLUDE "scripts/Route12SuperRodHouse.asm"
INCLUDE "data/maps/objects/Route12SuperRodHouse.asm"

INCLUDE "data/maps/headers/SilphCo8F.asm"
INCLUDE "scripts/SilphCo8F.asm"
INCLUDE "data/maps/objects/SilphCo8F.asm"
SilphCo8F_Blocks: INCBIN "maps/SilphCo8F.blk"


SECTION "Maps 13", ROMX

INCLUDE "data/maps/headers/Route6.asm"
INCLUDE "data/maps/objects/Route6.asm"
Route6_Blocks: INCBIN "maps/Route6.blk"

INCLUDE "data/maps/headers/Route8.asm"
INCLUDE "data/maps/objects/Route8.asm"
Route8_Blocks: INCBIN "maps/Route8.blk"

INCLUDE "data/maps/headers/Route10.asm"
INCLUDE "data/maps/objects/Route10.asm"
Route10_Blocks: INCBIN "maps/Route10.blk"

INCLUDE "data/maps/headers/Route11.asm"
INCLUDE "data/maps/objects/Route11.asm"
Route11_Blocks: INCBIN "maps/Route11.blk"

INCLUDE "data/maps/headers/Route12.asm"
INCLUDE "data/maps/objects/Route12.asm"
Route12_Blocks: INCBIN "maps/Route12.blk"

INCLUDE "data/maps/headers/Route15.asm"
INCLUDE "data/maps/objects/Route15.asm"
Route15_Blocks: INCBIN "maps/Route15.blk"

INCLUDE "data/maps/headers/Route16.asm"
INCLUDE "data/maps/objects/Route16.asm"
Route16_Blocks: INCBIN "maps/Route16.blk"

INCLUDE "data/maps/headers/Route18.asm"
INCLUDE "data/maps/objects/Route18.asm"
Route18_Blocks: INCBIN "maps/Route18.blk"

	INCBIN "maps/UnusedPokecenterCopy.blk"


SECTION "Maps 14", ROMX

INCLUDE "scripts/Route6.asm"
INCLUDE "scripts/Route8.asm"
INCLUDE "scripts/Route10.asm"
INCLUDE "scripts/Route11.asm"
INCLUDE "scripts/Route12.asm"
INCLUDE "scripts/Route15.asm"
INCLUDE "scripts/Route16.asm"
INCLUDE "scripts/Route18.asm"

INCLUDE "data/maps/headers/PokemonFanClub.asm"
INCLUDE "scripts/PokemonFanClub.asm"
INCLUDE "data/maps/objects/PokemonFanClub.asm"
PokemonFanClub_Blocks: INCBIN "maps/PokemonFanClub.blk"

INCLUDE "data/maps/headers/SilphCo2F.asm"
INCLUDE "scripts/SilphCo2F.asm"
INCLUDE "data/maps/objects/SilphCo2F.asm"
SilphCo2F_Blocks: INCBIN "maps/SilphCo2F.blk"

INCLUDE "data/maps/headers/SilphCo3F.asm"
INCLUDE "scripts/SilphCo3F.asm"
INCLUDE "data/maps/objects/SilphCo3F.asm"
SilphCo3F_Blocks: INCBIN "maps/SilphCo3F.blk"

INCLUDE "data/maps/headers/SilphCo10F.asm"
INCLUDE "scripts/SilphCo10F.asm"
INCLUDE "data/maps/objects/SilphCo10F.asm"
SilphCo10F_Blocks: INCBIN "maps/SilphCo10F.blk"

INCLUDE "data/maps/headers/LancesRoom.asm"
INCLUDE "scripts/LancesRoom.asm"
INCLUDE "data/maps/objects/LancesRoom.asm"
LancesRoom_Blocks: INCBIN "maps/LancesRoom.blk"

INCLUDE "data/maps/headers/HallOfFame.asm"
INCLUDE "scripts/HallOfFame.asm"
INCLUDE "data/maps/objects/HallOfFame.asm"
HallOfFame_Blocks: INCBIN "maps/HallOfFame.blk"


SECTION "Maps 15", ROMX

CopycatsHouse2F_Blocks: ; UNUSED
RedsHouse2F_Blocks: INCBIN "maps/RedsHouse2F.blk"

Museum1F_Blocks: INCBIN "maps/Museum1F.blk"

Museum2F_Blocks: INCBIN "maps/Museum2F.blk"

UndergroundPathRoute7_Blocks:
UndergroundPathRoute7Copy_Blocks:
UndergroundPathRoute6_Blocks:
UndergroundPathRoute5_Blocks: INCBIN "maps/UndergroundPathRoute5.blk"

Route2AllGates_Blocks: INCBIN "maps/Route2AllGates.blk" ; new, merge of all Route 2 gates

INCLUDE "data/maps/headers/RedsHouse2F.asm"
INCLUDE "scripts/RedsHouse2F.asm"
INCLUDE "data/maps/objects/RedsHouse2F.asm"


SECTION "Maps 16", ROMX

INCLUDE "data/maps/headers/Museum1F.asm"
INCLUDE "scripts/Museum1F.asm"
INCLUDE "data/maps/objects/Museum1F.asm"

INCLUDE "data/maps/headers/Museum2F.asm"
INCLUDE "scripts/Museum2F.asm"
INCLUDE "data/maps/objects/Museum2F.asm"

INCLUDE "data/maps/headers/PewterGym.asm"
INCLUDE "scripts/PewterGym.asm"
INCLUDE "data/maps/objects/PewterGym.asm"
PewterGym_Blocks: INCBIN "maps/PewterGym.blk"

INCLUDE "data/maps/headers/PewterPokecenter.asm"
INCLUDE "scripts/PewterPokecenter.asm"
INCLUDE "data/maps/objects/PewterPokecenter.asm"

INCLUDE "data/maps/headers/CeruleanPokecenter.asm"
INCLUDE "scripts/CeruleanPokecenter.asm"
INCLUDE "data/maps/objects/CeruleanPokecenter.asm"

INCLUDE "data/maps/headers/CeruleanGym.asm"
INCLUDE "scripts/CeruleanGym.asm"
INCLUDE "data/maps/objects/CeruleanGym.asm"
CeruleanGym_Blocks: INCBIN "maps/CeruleanGym.blk"

INCLUDE "data/maps/headers/LavenderPokecenter.asm"
INCLUDE "scripts/LavenderPokecenter.asm"
INCLUDE "data/maps/objects/LavenderPokecenter.asm"

INCLUDE "data/maps/headers/VermilionPokecenter.asm"
INCLUDE "scripts/VermilionPokecenter.asm"
INCLUDE "data/maps/objects/VermilionPokecenter.asm"

INCLUDE "data/maps/headers/VermilionGym.asm"
INCLUDE "scripts/VermilionGym.asm"
INCLUDE "data/maps/objects/VermilionGym.asm"
VermilionGym_Blocks: INCBIN "maps/VermilionGym.blk"

INCLUDE "data/maps/headers/CopycatsHouse2F.asm"
INCLUDE "scripts/CopycatsHouse2F.asm"
INCLUDE "data/maps/objects/CopycatsHouse2F.asm"

INCLUDE "data/maps/headers/FightingDojo.asm"
INCLUDE "scripts/FightingDojo.asm"
INCLUDE "data/maps/objects/FightingDojo.asm"
FightingDojo_Blocks: INCBIN "maps/FightingDojo.blk"

INCLUDE "data/maps/headers/SaffronGym.asm"
INCLUDE "scripts/SaffronGym.asm"
INCLUDE "data/maps/objects/SaffronGym.asm"
SaffronGym_Blocks: INCBIN "maps/SaffronGym.blk"

INCLUDE "data/maps/headers/SilphCo1F.asm"
INCLUDE "scripts/SilphCo1F.asm"
INCLUDE "data/maps/objects/SilphCo1F.asm"
SilphCo1F_Blocks: INCBIN "maps/SilphCo1F.blk"

INCLUDE "data/maps/headers/SaffronPokecenter.asm"
INCLUDE "scripts/SaffronPokecenter.asm"
INCLUDE "data/maps/objects/SaffronPokecenter.asm"

; edited, merge of alla route 2 gates
INCLUDE "data/maps/headers/Route2AllGates.asm"
INCLUDE "scripts/Route2AllGates.asm"
INCLUDE "data/maps/objects/Route2AllGates.asm"

INCLUDE "data/maps/headers/UndergroundPathRoute5.asm"
INCLUDE "scripts/UndergroundPathRoute5.asm"
INCLUDE "data/maps/objects/UndergroundPathRoute5.asm"

INCLUDE "data/maps/headers/UndergroundPathRoute6.asm"
INCLUDE "scripts/UndergroundPathRoute6.asm"
INCLUDE "data/maps/objects/UndergroundPathRoute6.asm"

INCLUDE "data/maps/headers/UndergroundPathRoute7.asm"
INCLUDE "scripts/UndergroundPathRoute7.asm"
INCLUDE "data/maps/objects/UndergroundPathRoute7.asm"

INCLUDE "data/maps/headers/SilphCo9F.asm"
INCLUDE "scripts/SilphCo9F.asm"
INCLUDE "data/maps/objects/SilphCo9F.asm"
SilphCo9F_Blocks: INCBIN "maps/SilphCo9F.blk"

INCLUDE "data/maps/headers/VictoryRoad1F.asm"
INCLUDE "scripts/VictoryRoad1F.asm"
INCLUDE "data/maps/objects/VictoryRoad1F.asm"
VictoryRoad1F_Blocks: INCBIN "maps/VictoryRoad1F.blk"

INCLUDE "data/maps/headers/OchreGym.asm"
INCLUDE "scripts/OchreGym.asm"
INCLUDE "data/maps/objects/OchreGym.asm"
OchreGym_Blocks: INCBIN "maps/OchreGym.blk"

INCLUDE "data/maps/headers/CinnabarPokecenter.asm"
INCLUDE "scripts/CinnabarPokecenter.asm"
INCLUDE "data/maps/objects/CinnabarPokecenter.asm"

INCLUDE "data/maps/headers/FuchsiaPokecenter.asm"
INCLUDE "scripts/FuchsiaPokecenter.asm"
INCLUDE "data/maps/objects/FuchsiaPokecenter.asm"

; new! Center+Mart, testing
INCLUDE "data/maps/headers/OchrePokecenter.asm"
INCLUDE "scripts/OchrePokecenter.asm"
INCLUDE "data/maps/objects/OchrePokecenter.asm"
INCLUDE "data/maps/headers/ObsidianPokecenter.asm"
INCLUDE "scripts/ObsidianPokecenter.asm"
INCLUDE "data/maps/objects/ObsidianPokecenter.asm"
PewterPokecenter_Blocks:
CeruleanPokecenter_Blocks:
VermilionPokecenter_Blocks:
LavenderPokecenter_Blocks:
SaffronPokecenter_Blocks:
FuchsiaPokecenter_Blocks:
CinnabarPokecenter_Blocks:
ObsidianPokecenter_Blocks:
OchrePokecenter_Blocks: INCBIN "maps/PokemonCenterAndMart.blk"


SECTION "Maps 17", ROMX

ViridianForest_Blocks: INCBIN "maps/ViridianForest.blk"
UndergroundPathNorthSouth_Blocks: INCBIN "maps/UndergroundPathNorthSouth.blk"
UndergroundPathWestEast_Blocks: INCBIN "maps/UndergroundPathWestEast.blk"

	INCBIN "maps/UnusedDiglettsCaveCopy.blk"

SSAnneB1FRooms_Blocks:
SSAnne2FRooms_Blocks: INCBIN "maps/SSAnne2FRooms.blk"

INCLUDE "data/maps/headers/PokemonTower1F.asm"
INCLUDE "scripts/PokemonTower1F.asm"
INCLUDE "data/maps/objects/PokemonTower1F.asm"
PokemonTower1F_Blocks: INCBIN "maps/PokemonTower1F.blk"

INCLUDE "data/maps/headers/PokemonTower2F.asm"
INCLUDE "scripts/PokemonTower2F.asm"
INCLUDE "data/maps/objects/PokemonTower2F.asm"
PokemonTower2F_Blocks: INCBIN "maps/PokemonTower2F.blk"

INCLUDE "data/maps/headers/PokemonTower3F.asm"
INCLUDE "scripts/PokemonTower3F.asm"
INCLUDE "data/maps/objects/PokemonTower3F.asm"
PokemonTower3F_Blocks: INCBIN "maps/PokemonTower3F.blk"

INCLUDE "data/maps/headers/PokemonTower4F.asm"
INCLUDE "scripts/PokemonTower4F.asm"
INCLUDE "data/maps/objects/PokemonTower4F.asm"
PokemonTower4F_Blocks: INCBIN "maps/PokemonTower4F.blk"

INCLUDE "data/maps/headers/PokemonTower5F.asm"
INCLUDE "scripts/PokemonTower5F.asm"
INCLUDE "data/maps/objects/PokemonTower5F.asm"
PokemonTower5F_Blocks: INCBIN "maps/PokemonTower5F.blk"

INCLUDE "data/maps/headers/PokemonTower6F.asm"
INCLUDE "scripts/PokemonTower6F.asm"
INCLUDE "data/maps/objects/PokemonTower6F.asm"
PokemonTower6F_Blocks: INCBIN "maps/PokemonTower6F.blk"

	INCBIN "maps/UnusedEmptyMap.blk"

INCLUDE "data/maps/headers/PokemonTower7F.asm"
INCLUDE "scripts/PokemonTower7F.asm"
INCLUDE "data/maps/objects/PokemonTower7F.asm"
PokemonTower7F_Blocks: INCBIN "maps/PokemonTower7F.blk"


SECTION "Maps 18", ROMX

INCLUDE "data/maps/headers/ViridianForest.asm"
INCLUDE "scripts/ViridianForest.asm"
INCLUDE "data/maps/objects/ViridianForest.asm"

INCLUDE "data/maps/headers/SSAnne1F.asm"
INCLUDE "scripts/SSAnne1F.asm"
INCLUDE "data/maps/objects/SSAnne1F.asm"
SSAnne1F_Blocks: INCBIN "maps/SSAnne1F.blk"

INCLUDE "data/maps/headers/SSAnne2F.asm"
INCLUDE "scripts/SSAnne2F.asm"
INCLUDE "data/maps/objects/SSAnne2F.asm"
SSAnne2F_Blocks: INCBIN "maps/SSAnne2F.blk"

INCLUDE "data/maps/headers/SSAnneB1F.asm"
INCLUDE "scripts/SSAnneB1F.asm"
INCLUDE "data/maps/objects/SSAnneB1F.asm"
SSAnneB1F_Blocks: INCBIN "maps/SSAnneB1F.blk"

INCLUDE "data/maps/headers/SSAnneBow.asm"
INCLUDE "scripts/SSAnneBow.asm"
INCLUDE "data/maps/objects/SSAnneBow.asm"
SSAnneBow_Blocks: INCBIN "maps/SSAnneBow.blk"

INCLUDE "data/maps/headers/SSAnneKitchen.asm"
INCLUDE "scripts/SSAnneKitchen.asm"
INCLUDE "data/maps/objects/SSAnneKitchen.asm"
SSAnneKitchen_Blocks: INCBIN "maps/SSAnneKitchen.blk"

INCLUDE "data/maps/headers/SSAnneCaptainsRoom.asm"
INCLUDE "scripts/SSAnneCaptainsRoom.asm"
INCLUDE "data/maps/objects/SSAnneCaptainsRoom.asm"
SSAnneCaptainsRoom_Blocks: INCBIN "maps/SSAnneCaptainsRoom.blk"

INCLUDE "data/maps/headers/SSAnne1FRooms.asm"
INCLUDE "scripts/SSAnne1FRooms.asm"
INCLUDE "data/maps/objects/SSAnne1FRooms.asm"
SSAnne1FRooms_Blocks: INCBIN "maps/SSAnne1FRooms.blk"

INCLUDE "data/maps/headers/SSAnne2FRooms.asm"
INCLUDE "scripts/SSAnne2FRooms.asm"
INCLUDE "data/maps/objects/SSAnne2FRooms.asm"

INCLUDE "data/maps/headers/SSAnneB1FRooms.asm"
INCLUDE "scripts/SSAnneB1FRooms.asm"
INCLUDE "data/maps/objects/SSAnneB1FRooms.asm"

INCLUDE "data/maps/headers/UndergroundPathNorthSouth.asm"
INCLUDE "scripts/UndergroundPathNorthSouth.asm"
INCLUDE "data/maps/objects/UndergroundPathNorthSouth.asm"

INCLUDE "data/maps/headers/UndergroundPathWestEast.asm"
INCLUDE "scripts/UndergroundPathWestEast.asm"
INCLUDE "data/maps/objects/UndergroundPathWestEast.asm"

INCLUDE "data/maps/headers/DiglettsCave.asm"
INCLUDE "scripts/DiglettsCave.asm"
INCLUDE "data/maps/objects/DiglettsCave.asm"
DiglettsCave_Blocks: INCBIN "maps/DiglettsCave.blk"

INCLUDE "data/maps/headers/SilphCo11F.asm"
INCLUDE "scripts/SilphCo11F.asm"
INCLUDE "data/maps/objects/SilphCo11F.asm"
SilphCo11F_Blocks: INCBIN "maps/SilphCo11F.blk"


SECTION "Maps 19", ROMX

CopycatsHouse1F_Blocks: INCBIN "maps/CopycatsHouse1F.blk"

FuchsiaBillsGrandpasHouse_Blocks: INCBIN "maps/FuchsiaBillsGrandpasHouse.blk"

CeruleanBadgeHouse_Blocks: INCBIN "maps/CeruleanBadgeHouse.blk"


SECTION "Maps 20", ROMX

INCLUDE "scripts/CeruleanCity_2.asm"

INCLUDE "data/maps/headers/ViridianGym.asm"
INCLUDE "scripts/ViridianGym.asm"
INCLUDE "data/maps/objects/ViridianGym.asm"
ViridianGym_Blocks: INCBIN "maps/ViridianGym.blk"

INCLUDE "data/maps/headers/CeruleanCave1F.asm"
INCLUDE "scripts/CeruleanCave1F.asm"
INCLUDE "data/maps/objects/CeruleanCave1F.asm"
CeruleanCave1F_Blocks: INCBIN "maps/CeruleanCave1F.blk"

INCLUDE "data/maps/headers/CeruleanBadgeHouse.asm"
INCLUDE "scripts/CeruleanBadgeHouse.asm"
INCLUDE "data/maps/objects/CeruleanBadgeHouse.asm"


SECTION "Maps 21", ROMX

INCLUDE "data/maps/headers/FuchsiaBillsGrandpasHouse.asm"
INCLUDE "scripts/FuchsiaBillsGrandpasHouse.asm"
INCLUDE "data/maps/objects/FuchsiaBillsGrandpasHouse.asm"

INCLUDE "data/maps/headers/WardensHouse.asm"
INCLUDE "scripts/WardensHouse.asm"
INCLUDE "data/maps/objects/WardensHouse.asm"
WardensHouse_Blocks: INCBIN "maps/WardensHouse.blk"

INCLUDE "data/maps/headers/SafariZoneGate.asm"
INCLUDE "data/maps/objects/SafariZoneGate.asm"
SafariZoneGate_Blocks: INCBIN "maps/SafariZoneGate.blk"
INCLUDE "scripts/SafariZoneGate.asm"

INCLUDE "data/maps/headers/FuchsiaGym.asm"
INCLUDE "scripts/FuchsiaGym.asm"
INCLUDE "data/maps/objects/FuchsiaGym.asm"
FuchsiaGym_Blocks: INCBIN "maps/FuchsiaGym.blk"

INCLUDE "data/maps/headers/FuchsiaMeetingRoom.asm"
INCLUDE "scripts/FuchsiaMeetingRoom.asm"
INCLUDE "data/maps/objects/FuchsiaMeetingRoom.asm"
FuchsiaMeetingRoom_Blocks: INCBIN "maps/FuchsiaMeetingRoom.blk"

INCLUDE "data/maps/headers/CinnabarGym.asm"
INCLUDE "scripts/CinnabarGym.asm"
INCLUDE "data/maps/objects/CinnabarGym.asm"
CinnabarGym_Blocks: INCBIN "maps/CinnabarGym.blk"
INCLUDE "scripts/CinnabarGym_2.asm"

INCLUDE "data/maps/headers/CinnabarLab.asm"
INCLUDE "scripts/CinnabarLab.asm"
INCLUDE "data/maps/objects/CinnabarLab.asm"
CinnabarLab_Blocks: INCBIN "maps/CinnabarLab.blk"

; UNUSED
INCLUDE "data/maps/headers/CinnabarLabTradeRoom.asm"
INCLUDE "scripts/CinnabarLabTradeRoom.asm"
INCLUDE "data/maps/objects/CinnabarLabTradeRoom.asm"
CinnabarLabTradeRoom_Blocks: INCBIN "maps/CinnabarLabTradeRoom.blk"

; UNUSED
INCLUDE "data/maps/headers/CinnabarLabMetronomeRoom.asm"
INCLUDE "scripts/CinnabarLabMetronomeRoom.asm"
INCLUDE "data/maps/objects/CinnabarLabMetronomeRoom.asm"
CinnabarLabMetronomeRoom_Blocks: INCBIN "maps/CinnabarLabMetronomeRoom.blk"

; UNUSED
INCLUDE "data/maps/headers/CinnabarLabFossilRoom.asm"
INCLUDE "scripts/CinnabarLabFossilRoom.asm"
INCLUDE "data/maps/objects/CinnabarLabFossilRoom.asm"
CinnabarLabFossilRoom_Blocks: INCBIN "maps/CinnabarLabFossilRoom.blk"

INCLUDE "data/maps/headers/CopycatsHouse1F.asm"
INCLUDE "scripts/CopycatsHouse1F.asm"
INCLUDE "data/maps/objects/CopycatsHouse1F.asm"

INCLUDE "data/maps/headers/ChampionsRoom.asm"
INCLUDE "scripts/ChampionsRoom.asm"
INCLUDE "data/maps/objects/ChampionsRoom.asm"
ChampionsRoom_Blocks: INCBIN "maps/ChampionsRoom.blk"

INCLUDE "data/maps/headers/LoreleisRoom.asm"
INCLUDE "scripts/LoreleisRoom.asm"
INCLUDE "data/maps/objects/LoreleisRoom.asm"
LoreleisRoom_Blocks: INCBIN "maps/LoreleisRoom.blk"

INCLUDE "data/maps/headers/BrunosRoom.asm"
INCLUDE "scripts/BrunosRoom.asm"
INCLUDE "data/maps/objects/BrunosRoom.asm"
BrunosRoom_Blocks: INCBIN "maps/BrunosRoom.blk"

INCLUDE "data/maps/headers/AgathasRoom.asm"
INCLUDE "scripts/AgathasRoom.asm"
INCLUDE "data/maps/objects/AgathasRoom.asm"
AgathasRoom_Blocks: INCBIN "maps/AgathasRoom.blk"

INCLUDE "data/maps/headers/OchreResearchCenter1.asm"
INCLUDE "scripts/OchreResearchCenter1.asm"
INCLUDE "data/maps/objects/OchreResearchCenter1.asm"
OchreResearchCenter1_Blocks: INCBIN "maps/OchreResearchCenter1.blk"

INCLUDE "data/maps/headers/OchreResearchCenter2.asm"
INCLUDE "scripts/OchreResearchCenter2.asm"
INCLUDE "data/maps/objects/OchreResearchCenter2.asm"
OchreResearchCenter2_Blocks: INCBIN "maps/OchreResearchCenter2.blk"


SECTION "Maps 22", ROMX

INCLUDE "scripts/ViridianCity2.asm"
INCLUDE "scripts/VermilionCity2.asm"
INCLUDE "scripts/CeladonCity2.asm"
INCLUDE "scripts/Route1_2.asm"
INCLUDE "scripts/Route22_2.asm"
INCLUDE "scripts/RedsHouse1F2.asm"
INCLUDE "scripts/OaksLab2.asm"
INCLUDE "scripts/ViridianSchoolHouse2.asm"
INCLUDE "scripts/Museum1F2.asm"
INCLUDE "scripts/PewterPokecenter2.asm"
INCLUDE "scripts/PokemonTower2F_2.asm"
INCLUDE "scripts/CeladonMart3F_2.asm"
INCLUDE "scripts/CeladonMansion1F_2.asm"
;INCLUDE "scripts/CeladonMansion3F_2.asm" ; useless
INCLUDE "scripts/GameCorner2.asm"
INCLUDE "scripts/CeladonDiner2.asm"
INCLUDE "scripts/SafariZoneGate2.asm"
INCLUDE "scripts/CinnabarGym3.asm"
INCLUDE "scripts/MtMoonPokecenter2.asm"

INCLUDE "data/maps/headers/SummerBeachHouse.asm"
INCLUDE "scripts/SummerBeachHouse.asm"
SummerBeachHouse_Blocks: INCBIN "maps/SummerBeachHouse.blk"
INCLUDE "data/maps/objects/SummerBeachHouse.asm"
INCLUDE "scripts/SummerBeachHouse2.asm"

INCLUDE "scripts/BillsHouse2.asm"
INCLUDE "scripts/ViridianForest2.asm"
INCLUDE "scripts/SSAnne2FRooms_2.asm"
INCLUDE "scripts/SilphCo11F_2.asm"


SECTION "Maps New 1", ROMX ; new

INCLUDE "data/maps/headers/SecludedAtollNW.asm"
INCLUDE "scripts/SecludedAtollNW.asm"
INCLUDE "data/maps/objects/SecludedAtollNW.asm"
SecludedAtollNW_Blocks: INCBIN "maps/SecludedAtollNW.blk"

INCLUDE "data/maps/headers/SecludedAtollNE.asm"
INCLUDE "scripts/SecludedAtollNE.asm"
INCLUDE "data/maps/objects/SecludedAtollNE.asm"
SecludedAtollNE_Blocks: INCBIN "maps/SecludedAtollNE.blk"

INCLUDE "data/maps/headers/SecludedAtollSE.asm"
INCLUDE "scripts/SecludedAtollSE.asm"
INCLUDE "data/maps/objects/SecludedAtollSE.asm"
SecludedAtollSE_Blocks: INCBIN "maps/SecludedAtollSE.blk"

INCLUDE "data/maps/headers/SecludedAtollSW.asm"
INCLUDE "scripts/SecludedAtollSW.asm"
INCLUDE "data/maps/objects/SecludedAtollSW.asm"
SecludedAtollSW_Blocks: INCBIN "maps/SecludedAtollSW.blk"

INCLUDE "data/maps/headers/Route26.asm"
INCLUDE "data/maps/objects/Route26.asm"
Route26_Blocks: INCBIN "maps/Route26.blk"
INCLUDE "scripts/Route26.asm"

INCLUDE "data/maps/headers/Route28.asm"
INCLUDE "data/maps/objects/Route28.asm"
Route28_Blocks: INCBIN "maps/Route28.blk"
INCLUDE "scripts/Route28.asm"

INCLUDE "data/maps/headers/Route30.asm"
INCLUDE "data/maps/objects/Route30.asm"
Route30_Blocks: INCBIN "maps/Route30.blk"
INCLUDE "scripts/Route30.asm"

INCLUDE "data/maps/headers/PikachuGrotto.asm"
INCLUDE "data/maps/objects/PikachuGrotto.asm"
PikachuGrotto_Blocks: INCBIN "maps/PikachuGrotto.blk"
INCLUDE "scripts/PikachuGrotto.asm"

INCLUDE "data/maps/headers/CeladonUniversity1.asm"
INCLUDE "data/maps/objects/CeladonUniversity1.asm"
CeladonUniversity1_Blocks: INCBIN "maps/CeladonUniversity1.blk"
INCLUDE "scripts/CeladonUniversity1.asm"

INCLUDE "data/maps/headers/CeladonUniversity2.asm"
INCLUDE "data/maps/objects/CeladonUniversity2.asm"
CeladonUniversity2_Blocks: INCBIN "maps/CeladonUniversity2.blk"
INCLUDE "scripts/CeladonUniversity2.asm"

INCLUDE "data/maps/headers/ObsidianWood.asm"
INCLUDE "data/maps/objects/ObsidianWood.asm"
ObsidianWood_Blocks: INCBIN "maps/ObsidianWood.blk"
INCLUDE "scripts/ObsidianWood.asm"

INCLUDE "data/maps/headers/ObsidianWarehouse.asm"
INCLUDE "data/maps/objects/ObsidianWarehouse.asm"
ObsidianWarehouse_Blocks: INCBIN "maps/ObsidianWarehouse.blk"
INCLUDE "scripts/ObsidianWarehouse.asm"

INCLUDE "data/maps/headers/ObsidianWarehouseFinal.asm"
INCLUDE "data/maps/objects/ObsidianWarehouseFinal.asm"
ObsidianWarehouseFinal_Blocks: INCBIN "maps/ObsidianWarehouseFinal.blk"
INCLUDE "scripts/ObsidianWarehouseFinal.asm"

; hopefully these doen't NEED to be in ROM 6 with the other dungeon maps... because it's full
INCLUDE "data/maps/headers/OnixBurrowing.asm"
INCLUDE "scripts/OnixBurrowing.asm"
INCLUDE "data/maps/objects/OnixBurrowing.asm"
OnixBurrowing_Blocks: INCBIN "maps/OnixBurrowing.blk"

INCLUDE "data/maps/headers/SecludedCaves.asm"
INCLUDE "scripts/SecludedCaves.asm"
INCLUDE "data/maps/objects/SecludedCaves.asm"
SecludedCaves_Blocks: INCBIN "maps/SecludedCaves.blk"

INCLUDE "data/maps/headers/OchreRehabilitationCenter.asm"
INCLUDE "scripts/OchreRehabilitationCenter.asm"
INCLUDE "data/maps/objects/OchreRehabilitationCenter.asm"
OchreRehabilitationCenter_Blocks: INCBIN "maps/OchreRehabilitationCenter.blk"

INCLUDE "data/maps/headers/ObsidianMines.asm"
INCLUDE "scripts/ObsidianMines.asm"
INCLUDE "data/maps/objects/ObsidianMines.asm"
ObsidianMines_Blocks: INCBIN "maps/ObsidianMines.blk"

INCLUDE "data/maps/headers/OchreHouses.asm"
INCLUDE "scripts/OchreHouses.asm"
INCLUDE "data/maps/objects/OchreHouses.asm"
OchreHouses_Blocks: INCBIN "maps/OchreHouses.blk"

; Mateo's move deleter/relearner files
INCLUDE "scripts/MoveDeleter.asm"
INCLUDE "scripts/MoveRelearner.asm"

; moved from Maps 6/5
INCLUDE "data/maps/headers/CeladonMart1F.asm"
INCLUDE "scripts/CeladonMart1F.asm"
INCLUDE "data/maps/objects/CeladonMart1F.asm"
CeladonMart1F_Blocks: INCBIN "maps/CeladonMart1F.blk"

INCLUDE "data/maps/headers/ObsidianHouses.asm"
INCLUDE "scripts/ObsidianHouses.asm"
INCLUDE "data/maps/objects/ObsidianHouses.asm"
ObsidianHouses_Blocks: INCBIN "maps/ObsidianHouses.blk"

INCLUDE "data/maps/headers/SilphCoElevator.asm"
INCLUDE "scripts/SilphCoElevator.asm"
INCLUDE "data/maps/objects/SilphCoElevator.asm"
SilphCoElevator_Blocks: INCBIN "maps/SilphCoElevator.blk"

INCLUDE "data/maps/headers/RocketHideoutElevator.asm"
INCLUDE "scripts/RocketHideoutElevator.asm"
INCLUDE "data/maps/objects/RocketHideoutElevator.asm"
RocketHideoutElevator_Blocks: INCBIN "maps/RocketHideoutElevator.blk"

INCLUDE "data/maps/headers/SSAnne3F.asm"
INCLUDE "scripts/SSAnne3F.asm"
INCLUDE "data/maps/objects/SSAnne3F.asm"
SSAnne3F_Blocks: INCBIN "maps/SSAnne3F.blk"

INCLUDE "data/maps/headers/ViridianPokecenter.asm"
INCLUDE "scripts/ViridianPokecenter.asm"
INCLUDE "data/maps/objects/ViridianPokecenter.asm"
ViridianPokecenter_Blocks: INCBIN "maps/ViridianPokecenter.blk"

; new/edited because of MERGING
INCLUDE "data/maps/headers/SafariZoneQuadrupleRestHouse.asm"
INCLUDE "scripts/SafariZoneQuadrupleRestHouse.asm"
INCLUDE "data/maps/objects/SafariZoneQuadrupleRestHouse.asm"
SafariZoneQuadrupleRestHouse_Blocks: INCBIN "maps/SafariZoneQuadrupleRestHouse.blk" ; new/edited because of MERGING


SECTION "Maps New 2", ROMX ; new

INCLUDE "data/maps/headers/Route29.asm"
INCLUDE "data/maps/objects/Route29.asm"
Route29_Blocks: INCBIN "maps/Route29.blk"
INCLUDE "scripts/Route29.asm"

INCLUDE "data/maps/headers/HauntedHouse1.asm"
INCLUDE "data/maps/objects/HauntedHouse1.asm"
HauntedHouse1_Blocks: INCBIN "maps/HauntedHouse1.blk"
INCLUDE "scripts/HauntedHouse1.asm"

INCLUDE "data/maps/headers/HauntedHouse2.asm"
INCLUDE "data/maps/objects/HauntedHouse2.asm"
HauntedHouse2_Blocks: INCBIN "maps/HauntedHouse2.blk"
INCLUDE "scripts/HauntedHouse2.asm"

INCLUDE "data/maps/headers/HauntedHouse3.asm"
INCLUDE "data/maps/objects/HauntedHouse3.asm"
HauntedHouse3_Blocks: INCBIN "maps/HauntedHouse3.blk"
INCLUDE "scripts/HauntedHouse3.asm"

INCLUDE "data/maps/headers/HauntedHouse4.asm"
INCLUDE "data/maps/objects/HauntedHouse4.asm"
HauntedHouse4_Blocks: INCBIN "maps/HauntedHouse4.blk"
INCLUDE "scripts/HauntedHouse4.asm"

INCLUDE "data/maps/headers/HauntedRedsHouse.asm"
INCLUDE "data/maps/objects/HauntedRedsHouse.asm"
HauntedRedsHouse_Blocks: INCBIN "maps/HauntedRedsHouse.blk"
INCLUDE "scripts/HauntedRedsHouse.asm"

INCLUDE "data/maps/headers/HauntedPalletTown.asm"
INCLUDE "data/maps/objects/HauntedPalletTown.asm"
HauntedPalletTown_Blocks: INCBIN "maps/HauntedPalletTown.blk"
INCLUDE "scripts/HauntedPalletTown.asm"

INCLUDE "data/maps/headers/HauntedIslandOfNumbers.asm"
INCLUDE "data/maps/objects/HauntedIslandOfNumbers.asm"
HauntedIslandOfNumbers_Blocks: INCBIN "maps/HauntedIslandOfNumbers.blk"
INCLUDE "scripts/HauntedIslandOfNumbers.asm"

INCLUDE "data/maps/headers/BattleFacility.asm"
INCLUDE "data/maps/objects/BattleFacility.asm"
BattleFacility_Blocks: INCBIN "maps/BattleFacility.blk"
INCLUDE "scripts/BattleFacility.asm"

INCLUDE "data/maps/headers/CeladonHotelHall.asm"
INCLUDE "scripts/CeladonHotelHall.asm"
INCLUDE "data/maps/objects/CeladonHotelHall.asm"
CeladonHotelHall_Blocks: INCBIN "maps/CeladonHotelHall.blk"

INCLUDE "data/maps/headers/CeladonHotelRooms.asm"
INCLUDE "scripts/CeladonHotelRooms.asm"
INCLUDE "data/maps/objects/CeladonHotelRooms.asm"
CeladonHotelRooms_Blocks: INCBIN "maps/CeladonHotelRooms.blk"

INCLUDE "data/maps/headers/IndigoPlateauLobby.asm"
INCLUDE "scripts/IndigoPlateauLobby.asm"
INCLUDE "data/maps/objects/IndigoPlateauLobby.asm"
IndigoPlateauLobby_Blocks: INCBIN "maps/IndigoPlateauLobby.blk"

INCLUDE "data/maps/headers/Route27.asm"
INCLUDE "data/maps/objects/Route27.asm"
Route27_Blocks: INCBIN "maps/Route27.blk"
INCLUDE "scripts/Route27.asm"


; --------------------- NEW FOR SEVII ----------------------------


SECTION "Maps Sevii 1", ROMX ; new

INCLUDE "data/maps/headers/SeviiOneIslandCity.asm"
INCLUDE "scripts/SeviiOneIslandCity.asm"
INCLUDE "data/maps/objects/SeviiOneIslandCity.asm"
SeviiOneIslandCity_Blocks: INCBIN "maps/SeviiOneIslandCity.blk"

INCLUDE "data/maps/headers/SeviiTwoIslandCity.asm"
INCLUDE "scripts/SeviiTwoIslandCity.asm"
INCLUDE "data/maps/objects/SeviiTwoIslandCity.asm"
SeviiTwoIslandCity_Blocks: INCBIN "maps/SeviiTwoIslandCity.blk"

INCLUDE "data/maps/headers/SeviiThreeIslandCity.asm"
INCLUDE "scripts/SeviiThreeIslandCity.asm"
INCLUDE "data/maps/objects/SeviiThreeIslandCity.asm"
SeviiThreeIslandCity_Blocks: INCBIN "maps/SeviiThreeIslandCity.blk"

INCLUDE "data/maps/headers/SeviiFourIslandCity.asm"
INCLUDE "scripts/SeviiFourIslandCity.asm"
INCLUDE "data/maps/objects/SeviiFourIslandCity.asm"
SeviiFourIslandCity_Blocks: INCBIN "maps/SeviiFourIslandCity.blk"

INCLUDE "data/maps/headers/SeviiFiveIslandCity.asm"
INCLUDE "scripts/SeviiFiveIslandCity.asm"
INCLUDE "data/maps/objects/SeviiFiveIslandCity.asm"
SeviiFiveIslandCity_Blocks: INCBIN "maps/SeviiFiveIslandCity.blk"

INCLUDE "data/maps/headers/SeviiSixIslandCity.asm"
INCLUDE "scripts/SeviiSixIslandCity.asm"
INCLUDE "data/maps/objects/SeviiSixIslandCity.asm"
SeviiSixIslandCity_Blocks: INCBIN "maps/SeviiSixIslandCity.blk"

INCLUDE "data/maps/headers/SeviiSevenIslandCity.asm"
INCLUDE "scripts/SeviiSevenIslandCity.asm"
INCLUDE "data/maps/objects/SeviiSevenIslandCity.asm"
SeviiSevenIslandCity_Blocks: INCBIN "maps/SeviiSevenIslandCity.blk"

INCLUDE "data/maps/headers/SeviiEightIslandCity.asm"
INCLUDE "scripts/SeviiEightIslandCity.asm"
INCLUDE "data/maps/objects/SeviiEightIslandCity.asm"
SeviiEightIslandCity_Blocks: INCBIN "maps/SeviiEightIslandCity.blk"

INCLUDE "data/maps/headers/SeviiRoute31.asm"
INCLUDE "scripts/SeviiRoute31.asm"
INCLUDE "data/maps/objects/SeviiRoute31.asm"
SeviiRoute31_Blocks: INCBIN "maps/SeviiRoute31.blk"

INCLUDE "data/maps/headers/SeviiRoute32.asm"
INCLUDE "scripts/SeviiRoute32.asm"
INCLUDE "data/maps/objects/SeviiRoute32.asm"
SeviiRoute32_Blocks: INCBIN "maps/SeviiRoute32.blk"

INCLUDE "data/maps/headers/SeviiRoute32Dive.asm"
INCLUDE "scripts/SeviiRoute32Dive.asm"
INCLUDE "data/maps/objects/SeviiRoute32Dive.asm"
SeviiRoute32Dive_Blocks: INCBIN "maps/SeviiRoute32Dive.blk"

INCLUDE "data/maps/headers/SeviiOneIslandDock.asm"
INCLUDE "scripts/SeviiOneIslandDock.asm"
INCLUDE "data/maps/objects/SeviiOneIslandDock.asm"
INCLUDE "data/maps/headers/SeviiTwoIslandDock.asm"
INCLUDE "scripts/SeviiTwoIslandDock.asm"
INCLUDE "data/maps/objects/SeviiTwoIslandDock.asm"
INCLUDE "data/maps/headers/SeviiThreeIslandDock.asm"
INCLUDE "scripts/SeviiThreeIslandDock.asm"
INCLUDE "data/maps/objects/SeviiThreeIslandDock.asm"
INCLUDE "data/maps/headers/SeviiFourIslandDock.asm"
INCLUDE "scripts/SeviiFourIslandDock.asm"
INCLUDE "data/maps/objects/SeviiFourIslandDock.asm"
INCLUDE "data/maps/headers/SeviiFiveIslandDock.asm"
INCLUDE "scripts/SeviiFiveIslandDock.asm"
INCLUDE "data/maps/objects/SeviiFiveIslandDock.asm"
INCLUDE "data/maps/headers/SeviiSixIslandDock.asm"
INCLUDE "scripts/SeviiSixIslandDock.asm"
INCLUDE "data/maps/objects/SeviiSixIslandDock.asm"
INCLUDE "data/maps/headers/SeviiSevenIslandDock.asm"
INCLUDE "scripts/SeviiSevenIslandDock.asm"
INCLUDE "data/maps/objects/SeviiSevenIslandDock.asm"
INCLUDE "data/maps/headers/SeviiEightIslandDock.asm"
INCLUDE "scripts/SeviiEightIslandDock.asm"
INCLUDE "data/maps/objects/SeviiEightIslandDock.asm"
SeviiEightIslandDock_Blocks:
SeviiSevenIslandDock_Blocks:
SeviiSixIslandDock_Blocks:
SeviiFiveIslandDock_Blocks:
SeviiFourIslandDock_Blocks:
SeviiThreeIslandDock_Blocks:
SeviiTwoIslandDock_Blocks:
SeviiOneIslandDock_Blocks: INCBIN "maps/SeviiShipDock.blk"

INCLUDE "data/maps/headers/SeviiRoute33.asm"
INCLUDE "scripts/SeviiRoute33.asm"
INCLUDE "data/maps/objects/SeviiRoute33.asm"
SeviiRoute33_Blocks: INCBIN "maps/SeviiRoute33.blk"

INCLUDE "data/maps/headers/SeviiRoute34.asm"
INCLUDE "scripts/SeviiRoute34.asm"
INCLUDE "data/maps/objects/SeviiRoute34.asm"
SeviiRoute34_Blocks: INCBIN "maps/SeviiRoute34.blk"

INCLUDE "data/maps/headers/SeviiRoute35.asm"
INCLUDE "scripts/SeviiRoute35.asm"
INCLUDE "data/maps/objects/SeviiRoute35.asm"
SeviiRoute35_Blocks: INCBIN "maps/SeviiRoute35.blk"

INCLUDE "data/maps/headers/SeviiRoute36.asm"
INCLUDE "scripts/SeviiRoute36.asm"
INCLUDE "data/maps/objects/SeviiRoute36.asm"
SeviiRoute36_Blocks: INCBIN "maps/SeviiRoute36.blk"

INCLUDE "data/maps/headers/SeviiRoute37.asm"
INCLUDE "scripts/SeviiRoute37.asm"
INCLUDE "data/maps/objects/SeviiRoute37.asm"
SeviiRoute37_Blocks: INCBIN "maps/SeviiRoute37.blk"


SECTION "Maps Sevii 2", ROMX ; new

INCLUDE "data/maps/headers/SeviiOneIslandPokemonCenterAndMart.asm"
INCLUDE "scripts/SeviiOneIslandPokemonCenterAndMart.asm"
INCLUDE "data/maps/objects/SeviiOneIslandPokemonCenterAndMart.asm"
INCLUDE "data/maps/headers/SeviiThreeIslandPokemonCenterAndMart.asm"
INCLUDE "scripts/SeviiThreeIslandPokemonCenterAndMart.asm"
INCLUDE "data/maps/objects/SeviiThreeIslandPokemonCenterAndMart.asm"
INCLUDE "data/maps/headers/SeviiFourIslandPokemonCenterAndMart.asm"
INCLUDE "scripts/SeviiFourIslandPokemonCenterAndMart.asm"
INCLUDE "data/maps/objects/SeviiFourIslandPokemonCenterAndMart.asm"
INCLUDE "data/maps/headers/SeviiFiveIslandPokemonCenterAndMart.asm"
INCLUDE "scripts/SeviiFiveIslandPokemonCenterAndMart.asm"
INCLUDE "data/maps/objects/SeviiFiveIslandPokemonCenterAndMart.asm"
INCLUDE "data/maps/headers/SeviiSixIslandPokemonCenterAndMart.asm"
INCLUDE "scripts/SeviiSixIslandPokemonCenterAndMart.asm"
INCLUDE "data/maps/objects/SeviiSixIslandPokemonCenterAndMart.asm"
INCLUDE "data/maps/headers/SeviiSevenIslandPokemonCenterAndMart.asm"
INCLUDE "scripts/SeviiSevenIslandPokemonCenterAndMart.asm"
INCLUDE "data/maps/objects/SeviiSevenIslandPokemonCenterAndMart.asm"
SeviiSevenIslandPokemonCenterAndMart_Blocks:
SeviiSixIslandPokemonCenterAndMart_Blocks:
SeviiFiveIslandPokemonCenterAndMart_Blocks:
SeviiFourIslandPokemonCenterAndMart_Blocks:
SeviiThreeIslandPokemonCenterAndMart_Blocks:
SeviiOneIslandPokemonCenterAndMart_Blocks: INCBIN "maps/SeviiPokemonCenterAndMart.blk"

INCLUDE "data/maps/headers/SeviiRoute38.asm"
INCLUDE "scripts/SeviiRoute38.asm"
INCLUDE "data/maps/objects/SeviiRoute38.asm"
SeviiRoute38_Blocks: INCBIN "maps/SeviiRoute38.blk"

INCLUDE "data/maps/headers/SeviiIcefallCave1F.asm"
INCLUDE "scripts/SeviiIcefallCave1F.asm"
INCLUDE "data/maps/objects/SeviiIcefallCave1F.asm"
SeviiIcefallCave1F_Blocks: INCBIN "maps/SeviiIcefallCave1F.blk"

INCLUDE "data/maps/headers/SeviiTwoIslandPokemonCenter.asm"
INCLUDE "scripts/SeviiTwoIslandPokemonCenter.asm"
INCLUDE "data/maps/objects/SeviiTwoIslandPokemonCenter.asm"
SeviiTwoIslandPokemonCenter_Blocks: INCBIN "maps/SeviiPokemonCenter.blk"

INCLUDE "data/maps/headers/SeviiOneIslandHouses.asm"
INCLUDE "scripts/SeviiOneIslandHouses.asm"
INCLUDE "data/maps/objects/SeviiOneIslandHouses.asm"
SeviiOneIslandHouses_Blocks: INCBIN "maps/SeviiOneIslandHouses.blk"

INCLUDE "data/maps/headers/SeviiTwoIslandHouses.asm"
INCLUDE "scripts/SeviiTwoIslandHouses.asm"
INCLUDE "data/maps/objects/SeviiTwoIslandHouses.asm"
SeviiTwoIslandHouses_Blocks: INCBIN "maps/SeviiTwoIslandHouses.blk"

INCLUDE "data/maps/headers/SeviiThreeIslandHouses.asm"
INCLUDE "scripts/SeviiThreeIslandHouses.asm"
INCLUDE "data/maps/objects/SeviiThreeIslandHouses.asm"
SeviiThreeIslandHouses_Blocks: INCBIN "maps/SeviiThreeIslandHouses.blk"

INCLUDE "data/maps/headers/SeviiFourIslandHouses.asm"
INCLUDE "scripts/SeviiFourIslandHouses.asm"
INCLUDE "data/maps/objects/SeviiFourIslandHouses.asm"
SeviiFourIslandHouses_Blocks: INCBIN "maps/SeviiFourIslandHouses.blk"

INCLUDE "data/maps/headers/SeviiFiveIslandHouses.asm"
INCLUDE "scripts/SeviiFiveIslandHouses.asm"
INCLUDE "data/maps/objects/SeviiFiveIslandHouses.asm"
SeviiFiveIslandHouses_Blocks: INCBIN "maps/SeviiFiveIslandHouses.blk"

INCLUDE "data/maps/headers/SeviiSevenIslandHouses.asm"
INCLUDE "scripts/SeviiSevenIslandHouses.asm"
INCLUDE "data/maps/objects/SeviiSevenIslandHouses.asm"
SeviiSevenIslandHouses_Blocks: INCBIN "maps/SeviiSevenIslandHouses.blk"

INCLUDE "data/maps/headers/SeviiOneIslandGym1.asm"
INCLUDE "scripts/SeviiOneIslandGym1.asm"
INCLUDE "data/maps/objects/SeviiOneIslandGym1.asm"
SeviiOneIslandGym1_Blocks: INCBIN "maps/SeviiOneIslandGym1.blk"

INCLUDE "data/maps/headers/SeviiOneIslandGym2.asm"
INCLUDE "scripts/SeviiOneIslandGym2.asm"
INCLUDE "data/maps/objects/SeviiOneIslandGym2.asm"
SeviiOneIslandGym2_Blocks: INCBIN "maps/SeviiOneIslandGym2.blk"

INCLUDE "data/maps/headers/SeviiTwoIslandGym.asm"
INCLUDE "scripts/SeviiTwoIslandGym.asm"
INCLUDE "data/maps/objects/SeviiTwoIslandGym.asm"
SeviiTwoIslandGym_Blocks: INCBIN "maps/SeviiTwoIslandGym.blk"

INCLUDE "data/maps/headers/SeviiThreeIslandGym.asm"
INCLUDE "scripts/SeviiThreeIslandGym.asm"
INCLUDE "data/maps/objects/SeviiThreeIslandGym.asm"
SeviiThreeIslandGym_Blocks: INCBIN "maps/SeviiThreeIslandGym.blk"

INCLUDE "data/maps/headers/SeviiFourIslandGym.asm"
INCLUDE "scripts/SeviiFourIslandGym.asm"
INCLUDE "data/maps/objects/SeviiFourIslandGym.asm"
SeviiFourIslandGym_Blocks: INCBIN "maps/SeviiFourIslandGym.blk"

INCLUDE "data/maps/headers/SeviiFiveIslandGym.asm"
INCLUDE "scripts/SeviiFiveIslandGym.asm"
INCLUDE "data/maps/objects/SeviiFiveIslandGym.asm"
SeviiFiveIslandGym_Blocks: INCBIN "maps/SeviiFiveIslandGym.blk"

; --- these three need to be together
INCLUDE "data/maps/headers/SeviiSixIslandGym1.asm"
INCLUDE "scripts/SeviiSixIslandGym1.asm"
INCLUDE "data/maps/objects/SeviiSixIslandGym1.asm"
SeviiSixIslandGym1_Blocks: INCBIN "maps/SeviiSixIslandGym1.blk"
;
INCLUDE "data/maps/headers/SeviiSixIslandGym2.asm"
INCLUDE "scripts/SeviiSixIslandGym2.asm"
INCLUDE "data/maps/objects/SeviiSixIslandGym2.asm"
SeviiSixIslandGym2_Blocks: INCBIN "maps/SeviiSixIslandGym2.blk"
;
INCLUDE "data/maps/headers/SeviiSixIslandGym3.asm"
INCLUDE "scripts/SeviiSixIslandGym3.asm"
INCLUDE "data/maps/objects/SeviiSixIslandGym3.asm"
SeviiSixIslandGym3_Blocks: INCBIN "maps/SeviiSixIslandGym3.blk"
; -----------------------------------

INCLUDE "data/maps/headers/SeviiSevenIslandGym1.asm"
INCLUDE "scripts/SeviiSevenIslandGym1.asm"
INCLUDE "data/maps/objects/SeviiSevenIslandGym1.asm"
SeviiSevenIslandGym1_Blocks: INCBIN "maps/SeviiSevenIslandGym1.blk"

INCLUDE "data/maps/headers/SeviiSevenIslandGym2.asm"
INCLUDE "scripts/SeviiSevenIslandGym2.asm"
INCLUDE "data/maps/objects/SeviiSevenIslandGym2.asm"
SeviiSevenIslandGym2_Blocks: INCBIN "maps/SeviiSevenIslandGym2.blk"

INCLUDE "data/maps/headers/SeviiSevenIslandGym2Dive.asm"
INCLUDE "scripts/SeviiSevenIslandGym2Dive.asm"
INCLUDE "data/maps/objects/SeviiSevenIslandGym2Dive.asm"
SeviiSevenIslandGym2Dive_Blocks: INCBIN "maps/SeviiSevenIslandGym2Dive.blk"

INCLUDE "data/maps/headers/SeviiSevenIslandGym2DiveCavern.asm"
INCLUDE "scripts/SeviiSevenIslandGym2DiveCavern.asm"
INCLUDE "data/maps/objects/SeviiSevenIslandGym2DiveCavern.asm"
SeviiSevenIslandGym2DiveCavern_Blocks: INCBIN "maps/SeviiSevenIslandGym2DiveCavern.blk"

INCLUDE "data/maps/headers/SeviiSevenIslandGym3.asm"
INCLUDE "scripts/SeviiSevenIslandGym3.asm"
INCLUDE "data/maps/objects/SeviiSevenIslandGym3.asm"
SeviiSevenIslandGym3_Blocks: INCBIN "maps/SeviiSevenIslandGym3.blk"

INCLUDE "data/maps/headers/SeviiEmberSpa.asm"
INCLUDE "scripts/SeviiEmberSpa.asm"
INCLUDE "data/maps/objects/SeviiEmberSpa.asm"
SeviiEmberSpa_Blocks: INCBIN "maps/SeviiEmberSpa.blk"


SECTION "Maps Sevii 3", ROMX ; new

INCLUDE "data/maps/headers/SeviiFiveIslandWarehouseBF.asm"
INCLUDE "scripts/SeviiFiveIslandWarehouseBF.asm"
INCLUDE "data/maps/objects/SeviiFiveIslandWarehouseBF.asm"
SeviiFiveIslandWarehouseBF_Blocks: INCBIN "maps/SeviiFiveIslandWarehouseBF.blk"

INCLUDE "data/maps/headers/SeviiFiveIslandWarehouse1F.asm"
INCLUDE "scripts/SeviiFiveIslandWarehouse1F.asm"
INCLUDE "data/maps/objects/SeviiFiveIslandWarehouse1F.asm"
SeviiFiveIslandWarehouse1F_Blocks: INCBIN "maps/SeviiFiveIslandWarehouse1F.blk"

INCLUDE "data/maps/headers/SeviiFiveIslandWarehouse2F.asm"
INCLUDE "scripts/SeviiFiveIslandWarehouse2F.asm"
INCLUDE "data/maps/objects/SeviiFiveIslandWarehouse2F.asm"
SeviiFiveIslandWarehouse2F_Blocks: INCBIN "maps/SeviiFiveIslandWarehouse2F.blk"

INCLUDE "data/maps/headers/SeviiThreeIslandCaves.asm"
INCLUDE "scripts/SeviiThreeIslandCaves.asm"
INCLUDE "data/maps/objects/SeviiThreeIslandCaves.asm"
SeviiThreeIslandCaves_Blocks: INCBIN "maps/SeviiThreeIslandCaves.blk"

INCLUDE "data/maps/headers/SeviiThreeIslandSecretGarden.asm"
INCLUDE "scripts/SeviiThreeIslandSecretGarden.asm"
INCLUDE "data/maps/objects/SeviiThreeIslandSecretGarden.asm"
SeviiThreeIslandSecretGarden_Blocks: INCBIN "maps/SeviiThreeIslandSecretGarden.blk"

INCLUDE "data/maps/headers/SeviiBerryForest.asm"
INCLUDE "scripts/SeviiBerryForest.asm"
INCLUDE "data/maps/objects/SeviiBerryForest.asm"
SeviiBerryForest_Blocks: INCBIN "maps/SeviiBerryForest.blk"

INCLUDE "data/maps/headers/SeviiResortGorgeous.asm"
INCLUDE "scripts/SeviiResortGorgeous.asm"
INCLUDE "data/maps/objects/SeviiResortGorgeous.asm"
SeviiResortGorgeous_Blocks: INCBIN "maps/SeviiResortGorgeous.blk"

INCLUDE "data/maps/headers/SeviiLostCave1.asm"
INCLUDE "scripts/SeviiLostCave1.asm"
INCLUDE "data/maps/objects/SeviiLostCave1.asm"
SeviiLostCave1_Blocks: INCBIN "maps/SeviiLostCave1.blk"

INCLUDE "data/maps/headers/SeviiLostCave2.asm"
INCLUDE "scripts/SeviiLostCave2.asm"
INCLUDE "data/maps/objects/SeviiLostCave2.asm"
SeviiLostCave2_Blocks: INCBIN "maps/SeviiLostCave2.blk"

INCLUDE "data/maps/headers/SeviiLostCave3.asm"
INCLUDE "scripts/SeviiLostCave3.asm"
INCLUDE "data/maps/objects/SeviiLostCave3.asm"
SeviiLostCave3_Blocks: INCBIN "maps/SeviiLostCave3.blk"

INCLUDE "data/maps/headers/SeviiRoute38Houses.asm"
INCLUDE "scripts/SeviiRoute38Houses.asm"
INCLUDE "data/maps/objects/SeviiRoute38Houses.asm"
SeviiRoute38Houses_Blocks: INCBIN "maps/SeviiRoute38Houses.blk"

INCLUDE "data/maps/headers/SeviiPatternBush.asm"
INCLUDE "scripts/SeviiPatternBush.asm"
INCLUDE "data/maps/objects/SeviiPatternBush.asm"
SeviiPatternBush_Blocks: INCBIN "maps/SeviiPatternBush.blk"

INCLUDE "data/maps/headers/SeviiRoute43Caves.asm"
INCLUDE "scripts/SeviiRoute43Caves.asm"
INCLUDE "data/maps/objects/SeviiRoute43Caves.asm"
SeviiRoute43Caves_Blocks: INCBIN "maps/SeviiRoute43Caves.blk"

INCLUDE "data/maps/headers/SeviiRoute40.asm"
INCLUDE "scripts/SeviiRoute40.asm"
INCLUDE "data/maps/objects/SeviiRoute40.asm"
SeviiRoute40_Blocks: INCBIN "maps/SeviiRoute40.blk"

INCLUDE "data/maps/headers/SeviiRoute41.asm"
INCLUDE "scripts/SeviiRoute41.asm"
INCLUDE "data/maps/objects/SeviiRoute41.asm"
SeviiRoute41_Blocks: INCBIN "maps/SeviiRoute41.blk"

INCLUDE "data/maps/headers/SeviiRoute42.asm"
INCLUDE "scripts/SeviiRoute42.asm"
INCLUDE "data/maps/objects/SeviiRoute42.asm"
SeviiRoute42_Blocks: INCBIN "maps/SeviiRoute42.blk"

INCLUDE "data/maps/headers/SeviiRoute43.asm"
INCLUDE "scripts/SeviiRoute43.asm"
INCLUDE "data/maps/objects/SeviiRoute43.asm"
SeviiRoute43_Blocks: INCBIN "maps/SeviiRoute43.blk"

INCLUDE "data/maps/headers/SeviiRoute44.asm"
INCLUDE "scripts/SeviiRoute44.asm"
INCLUDE "data/maps/objects/SeviiRoute44.asm"
SeviiRoute44_Blocks: INCBIN "maps/SeviiRoute44.blk"

INCLUDE "data/maps/headers/SeviiRoute39.asm"
INCLUDE "scripts/SeviiRoute39.asm"
INCLUDE "data/maps/objects/SeviiRoute39.asm"
SeviiRoute39_Blocks: INCBIN "maps/SeviiRoute39.blk"

INCLUDE "data/maps/headers/SeviiRoute32DiveCavern1F1.asm"
INCLUDE "scripts/SeviiRoute32DiveCavern1F1.asm"
INCLUDE "data/maps/objects/SeviiRoute32DiveCavern1F1.asm"
SeviiRoute32DiveCavern1F1_Blocks: INCBIN "maps/SeviiRoute32DiveCavern1F1.blk"

INCLUDE "data/maps/headers/SeviiEightIslandCave.asm"
INCLUDE "scripts/SeviiEightIslandCave.asm"
INCLUDE "data/maps/objects/SeviiEightIslandCave.asm"
SeviiEightIslandCave_Blocks: INCBIN "maps/SeviiEightIslandCave.blk"

INCLUDE "data/maps/headers/SeviiTanobyChambers.asm"
INCLUDE "scripts/SeviiTanobyChambers.asm"
INCLUDE "data/maps/objects/SeviiTanobyChambers.asm"
SeviiTanobyChambers_Blocks: INCBIN "maps/SeviiTanobyChambers.blk"

INCLUDE "data/maps/headers/SeviiFourIslandHazardRoom.asm"
INCLUDE "scripts/SeviiFourIslandHazardRoom.asm"
INCLUDE "data/maps/objects/SeviiFourIslandHazardRoom.asm"
SeviiFourIslandHazardRoom_Blocks: INCBIN "maps/SeviiFourIslandHazardRoom.blk"

INCLUDE "data/maps/headers/SeviiDottedHole.asm"
INCLUDE "scripts/SeviiDottedHole.asm"
INCLUDE "data/maps/objects/SeviiDottedHole.asm"
SeviiDottedHole_Blocks: INCBIN "maps/SeviiDottedHole.blk"

INCLUDE "data/maps/headers/SeviiAlteringCave.asm"
INCLUDE "scripts/SeviiAlteringCave.asm"
INCLUDE "data/maps/objects/SeviiAlteringCave.asm"
SeviiAlteringCave_Blocks: INCBIN "maps/SeviiAlteringCave.blk"


SECTION "Maps Sevii 4", ROMX ; new

INCLUDE "data/maps/headers/SeviiMtEmber.asm"
INCLUDE "scripts/SeviiMtEmber.asm"
INCLUDE "data/maps/objects/SeviiMtEmber.asm"
SeviiMtEmber_Blocks: INCBIN "maps/SeviiMtEmber.blk"

INCLUDE "data/maps/headers/SeviiMtEmber4BF.asm"
INCLUDE "scripts/SeviiMtEmber4BF.asm"
INCLUDE "data/maps/objects/SeviiMtEmber4BF.asm"
SeviiMtEmber4BF_Blocks: INCBIN "maps/SeviiMtEmber4BF.blk"

INCLUDE "data/maps/headers/SeviiMtEmber3BF.asm"
INCLUDE "scripts/SeviiMtEmber3BF.asm"
INCLUDE "data/maps/objects/SeviiMtEmber3BF.asm"
SeviiMtEmber3BF_Blocks: INCBIN "maps/SeviiMtEmber3BF.blk"

INCLUDE "data/maps/headers/SeviiMtEmber2BF.asm"
INCLUDE "scripts/SeviiMtEmber2BF.asm"
INCLUDE "data/maps/objects/SeviiMtEmber2BF.asm"
SeviiMtEmber2BF_Blocks: INCBIN "maps/SeviiMtEmber2BF.blk"

INCLUDE "data/maps/headers/SeviiMtEmber1BF.asm"
INCLUDE "scripts/SeviiMtEmber1BF.asm"
INCLUDE "data/maps/objects/SeviiMtEmber1BF.asm"
SeviiMtEmber1BF_Blocks: INCBIN "maps/SeviiMtEmber1BF.blk"

INCLUDE "data/maps/headers/SeviiMtEmber1F.asm"
INCLUDE "scripts/SeviiMtEmber1F.asm"
INCLUDE "data/maps/objects/SeviiMtEmber1F.asm"
SeviiMtEmber1F_Blocks: INCBIN "maps/SeviiMtEmber1F.blk"

INCLUDE "data/maps/headers/SeviiMtEmber2F.asm"
INCLUDE "scripts/SeviiMtEmber2F.asm"
INCLUDE "data/maps/objects/SeviiMtEmber2F.asm"
SeviiMtEmber2F_Blocks: INCBIN "maps/SeviiMtEmber2F.blk"

INCLUDE "data/maps/headers/SeviiMtEmber3F.asm"
INCLUDE "scripts/SeviiMtEmber3F.asm"
INCLUDE "data/maps/objects/SeviiMtEmber3F.asm"
SeviiMtEmber3F_Blocks: INCBIN "maps/SeviiMtEmber3F.blk"

INCLUDE "data/maps/headers/SeviiMtEmber4F.asm"
INCLUDE "scripts/SeviiMtEmber4F.asm"
INCLUDE "data/maps/objects/SeviiMtEmber4F.asm"
SeviiMtEmber4F_Blocks: INCBIN "maps/SeviiMtEmber4F.blk"

INCLUDE "data/maps/headers/SeviiMtEmber5F.asm"
INCLUDE "scripts/SeviiMtEmber5F.asm"
INCLUDE "data/maps/objects/SeviiMtEmber5F.asm"
SeviiMtEmber5F_Blocks: INCBIN "maps/SeviiMtEmber5F.blk"

INCLUDE "data/maps/headers/SeviiMtEmber6F.asm"
INCLUDE "scripts/SeviiMtEmber6F.asm"
INCLUDE "data/maps/objects/SeviiMtEmber6F.asm"
SeviiMtEmber6F_Blocks: INCBIN "maps/SeviiMtEmber6F.blk"

INCLUDE "data/maps/headers/SeviiMtEmber7F.asm"
INCLUDE "scripts/SeviiMtEmber7F.asm"
INCLUDE "data/maps/objects/SeviiMtEmber7F.asm"
SeviiMtEmber7F_Blocks: INCBIN "maps/SeviiMtEmber7F.blk"

INCLUDE "data/maps/headers/SeviiMtEmber8F.asm"
INCLUDE "scripts/SeviiMtEmber8F.asm"
INCLUDE "data/maps/objects/SeviiMtEmber8F.asm"
SeviiMtEmber8F_Blocks: INCBIN "maps/SeviiMtEmber8F.blk"

INCLUDE "data/maps/headers/SeviiMtEmber9F.asm"
INCLUDE "scripts/SeviiMtEmber9F.asm"
INCLUDE "data/maps/objects/SeviiMtEmber9F.asm"
SeviiMtEmber9F_Blocks: INCBIN "maps/SeviiMtEmber9F.blk"

INCLUDE "data/maps/headers/SeviiMtEmber10F.asm"
INCLUDE "scripts/SeviiMtEmber10F.asm"
INCLUDE "data/maps/objects/SeviiMtEmber10F.asm"
SeviiMtEmber10F_Blocks: INCBIN "maps/SeviiMtEmber10F.blk"

INCLUDE "data/maps/headers/SeviiMtEmber11F.asm"
INCLUDE "scripts/SeviiMtEmber11F.asm"
INCLUDE "data/maps/objects/SeviiMtEmber11F.asm"
SeviiMtEmber11F_Blocks: INCBIN "maps/SeviiMtEmber11F.blk"
