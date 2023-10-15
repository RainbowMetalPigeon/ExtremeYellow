TrainerDataPointers:
	dw YoungsterData
	dw BugCatcherData
	dw LassData
	dw SailorData
;	dw JrTrainerMData ; removed
	dw JrTrainerFData
	dw PokemaniacData
	dw SuperNerdData
	dw HikerData
	dw BikerData
	dw BurglarData
;	dw EngineerData ; removed
;	dw UnusedJugglerData ; removed
	dw FisherData
	dw SwimmerData
	dw CueBallData
	dw GamblerData
	dw BeautyData
	dw PsychicData
	dw RockerData
	dw JugglerData
	dw TamerData
	dw BirdKeeperData
	dw BlackbeltData
	dw Rival1Data
	dw ProfOakData
;	dw ChiefData ; removed
	dw ScientistData
	dw GiovanniData
	dw RocketData
;	dw CooltrainerMData ; removed
	dw CooltrainerData
	dw BrunoData
	dw BrockData
	dw MistyData
	dw LtSurgeData
	dw ErikaData
	dw KogaData
	dw BlaineData
	dw SabrinaData
	dw GentlemanData
	dw Rival2Data
	dw Rival3Data
	dw LoreleiData
	dw ChannelerData
	dw AgathaData
	dw LanceData
; new classes
	dw OrageData
	dw PigeonData
	dw TravelerData
	dw BFTrainerData

; if first byte != $FF, then
	; first byte is level (of all pokemon on this team)
	; all the next bytes are pokemon species
	; null-terminated
; if first byte == $FF, then
	; first byte is $FF (obviously)
	; every next two bytes are a level and species
	; null-terminated

YoungsterData:
; Route 3
	db 11, RATTATA, EKANS, 0
	db 14, SPEAROW, 0
; Mt. Moon 1F
	db 10, RATTATA, RATTATA, ZUBAT, 0
; Route 24
	db 14, RATTATA, EKANS, ZUBAT, 0
; Route 25
	db 15, RATTATA, SPEAROW, 0
	db 17, SLOWPOKE, 0
	db 14, EKANS, SANDSHREW, 0
; SS Anne 1F Rooms
	db 21, NIDORAN_M, 0
; Route 11
	db 21, EKANS, 0
	db 19, SANDSHREW, ZUBAT, 0
	db 17, RATTATA, RATTATA, RATICATE, 0
	db 18, NIDORAN_M, NIDORINO, 0
; Unused
	db 17, SPEAROW, RATTATA, RATTATA, SPEAROW, 0
	db $FF, 19, RATTATA, 19, RATTATA, 19, RATTATA, 20, BEEDRILL, 20, BUTTERFREE, 21, SANDSHREW, 0 ; updated, only had a lv24 SANDSHREW; maybe will move it to Route 6

BugCatcherData:
; Viridian Forest
	db 7, CATERPIE, CATERPIE, 0
	db 6, METAPOD, CATERPIE, METAPOD, 0
	db 10, BUTTERFREE, BEEDRILL, 0 ; updated, previously, just CATERPIE
; Route 3 ; edited
	db 10, CATERPIE, METAPOD, BUTTERFREE, 0
	db 9, KAKUNA, BEEDRILL, METAPOD, BUTTERFREE, 0
	db 10, WEEDLE, KAKUNA, BEEDRILL, 0
; Mt. Moon 1F
	db 11, WEEDLE, KAKUNA, 0
	db 10, CATERPIE, METAPOD, CATERPIE, 0
; Route 24
	db 14, CATERPIE, WEEDLE, 0
; Route 6
	db 16, WEEDLE, CATERPIE, WEEDLE, 0
	db 20, BUTTERFREE, 0
; Obsidian Wood ; new
	db 39, BUTTERFREE, BEEDRILL, SCYTHER, PARASECT, 0
; Route 9
	db 19, BEEDRILL, BEEDRILL, 0
	db 20, CATERPIE, WEEDLE, VENONAT, 0
; Viridian Forest
	db 7, PINSIR, METAPOD, 0 ; pokeyellow only; updated
; Ochre Gym
	db 43, SCIZOR, BUTTERFREE, BEEDRILL, VENOMOTH, KLEAVOR, PINSIR, 0 ; new

LassData:
; Route 3
	db 9, PIDGEY, PIDGEY, 0
	db 10, RATTATA, NIDORAN_M, 0
	db 14, JIGGLYPUFF, 0
; Route 4
	db 31, PARAS, PARASECT, PARASECT, 0
; Mt. Moon 1F
	db 11, ODDISH, BELLSPROUT, 0
	db 14, CLEFAIRY, 0
; Route 24
	db 16, PIDGEY, NIDORAN_F, 0
	db 14, PIDGEY, NIDORAN_F, 0
; Route 25
	db 15, NIDORAN_M, NIDORAN_F, 0
	db 13, ODDISH, PIDGEY, ODDISH, 0
; SS Anne 1F Rooms
	db 18, PIDGEOTTO, NIDORAN_F, 0
; SS Anne 2F Rooms
	db 20, JIGGLYPUFF, 0
; Route 8
	db 23, NIDORAN_F, NIDORINA, 0
	db 24, MEOWTH, MEOWTH, MEOWTH, 0
	db 19, PIDGEOTTO, RATTATA, NIDORAN_F, MEOWTH, NIDORAN_M, 0
	db 22, CLEFAIRY, CLEFAIRY, 0
; Celadon Gym
	db 27, BELLSPROUT, WEEPINBELL, VICTREEBEL, 0 ; updated
	db 26, ODDISH, GLOOM, VILEPLUME, BELLOSSOM, 0 ; updated
; Viridian Forest
	db 6, NIDORAN_F, NIDORAN_M, 0 ; pokeyellow only

SailorData:
; SS Anne Stern
	db 18, MACHOP, SHELLDER, 0
	db 17, MACHOP, TENTACOOL, 0
; SS Anne B1F Rooms
	db 21, SHELLDER, 0
	db 17, HORSEA, SHELLDER, TENTACOOL, 0
	db 18, TENTACOOL, STARYU, 0
	db 17, HORSEA, HORSEA, HORSEA, 0
	db 20, MACHOP, 0
; Vermilion Gym
	db 23, ELEKID, PIKACHU, PIKACHU, RAICHU, 0 ; updated

JrTrainerFData:
; Cerulean Gym
	db 19, GOLDEEN, KRABBY, PSYDUCK, 0 ; updated
; Route 6
	db 16, ODDISH, BELLSPROUT, 0
	db 16, PIDGEY, PIDGEY, PIDGEY, 0
; Unused
	db 22, BULBASAUR, 0
; Route 9
	db 18, ODDISH, BELLSPROUT, ODDISH, BELLSPROUT, 0
	db 23, MEOWTH, 0
; Route 10
	db 20, JIGGLYPUFF, CLEFAIRY, 0
	db 21, PIDGEY, PIDGEOTTO, 0
; Rock Tunnel B1F
	db 21, JIGGLYPUFF, PIDGEOTTO, MEOWTH, 0
	db 22, ODDISH, BULBASAUR, 0
; Celadon Gym
	db 26, BULBASAUR, IVYSAUR, EXEGGCUTE, EXEGGUTOR, 0 ; updated
; Route 13
	db 24, PIDGEOTTO, MEOWTH, RATTATA, PIDGEOTTO, MEOWTH, 0
	db 30, POLIWAG, POLIWHIRL, 0
	db 27, PIDGEY, MEOWTH, PIDGEOTTO, PIDGEOTTO, 0
	db 28, GOLDEEN, POLIWHIRL, HORSEA, 0
; Route 20
	db 31, GOLDEEN, SEAKING, 0
; Rock Tunnel 1F
	db 22, BELLSPROUT, CLEFAIRY, 0
	db 20, MEOWTH, ODDISH, PIDGEOTTO, 0
	db 19, PIDGEOTTO, RATTATA, RATICATE, BELLSPROUT, 0
; Route 15
	db 28, GLOOM, ODDISH, GLOOM, 0
	db 29, PIDGEY, PIDGEOTTO, 0
	db 33, CLEFAIRY, 0
	db 29, WEEPINBELL, GLOOM, TANGELA, 0
; Route 20
	db 30, TENTACOOL, HORSEA, SEEL, 0
; Route 6
	db 20, CHARMANDER, 0 ; updated, removed Cubone
;JrTrainerMData: ; removed, did a + 25 to merge with the above
; Pewter Gym
	db 9, GEODUDE, ONIX, 0 ; updated
; Route 24/Route 25
	db 14, RATTATA, EKANS, 0
; Route 24
	db 18, MANKEY, 0
; Route 6
	db 20, SQUIRTLE, 0
	db 16, SPEAROW, RATICATE, 0
; Unused
	db 18, DIGLETT, DIGLETT, SANDSHREW, 0
; Route 9
	db 21, GROWLITHE, CHARMANDER, 0 ; unused?
	db 19, RATTATA, DIGLETT, EKANS, SANDSHREW, 0
; Route 12
	db 29, NIDORAN_M, NIDORINO, 0 ; unused
	db 16, WEEPINBELL, 0

PokemaniacData:
; Route 10
	db 30, RHYHORN, LICKITUNG, 0
	db 20, SANDSHREW, SLOWPOKE, 0 ; updated, removed Cubone
; Rock Tunnel B1F
	db 21, SLOWPOKE, SLOWPOKE, SLOWPOKE, 0
	db 20, CHARMELEON, WARTORTLE, IVYSAUR, 0 ; updated, all starters
	db 25, SLOWPOKE, 0
; Victory Road 2F
	db 51, PICHU, CLEFFA, SMOOCHUM, TYROGUE, HAPPINY, 0 ; updated, baby mons
; Rock Tunnel 1F
	db 23, SANDSLASH, SLOWPOKE, 0 ; updated, removed Cubone
; Ochre Gym
	db 44, CLEFABLE, WIGGLYTUFF, MR_MIME, SYLVEON, 0 ; new

SuperNerdData:
; Mt. Moon 1F
	db 11, MAGNEMITE, VOLTORB, 0
; Mt. Moon B2F
	db 12, GRIMER, VOLTORB, KOFFING, 0
; Route 8
	db 20, VOLTORB, KOFFING, VOLTORB, MAGNEMITE, 0
	db 22, GRIMER, MUK, GRIMER, 0
	db 26, KOFFING, 0
; Unused
	db 22, KOFFING, MAGNEMITE, WEEZING, 0
	db 20, MAGNEMITE, MAGNEMITE, KOFFING, MAGNEMITE, 0
	db 24, MAGNEMITE, VOLTORB, 0
; Cinnabar Gym
	db 47, RAPIDASH, NINETALES, MAGBY, MAGMAR, MAGMORTAR, 0 ; updated
	db 47, MAGBY, MAGMAR, MAGMORTAR, CHARMANDER, CHARMELEON, CHARIZARD, 0 ; updated
	db 50, MAGMORTAR, CHARIZARD, ARCANINE, 0 ; updated
;	db 37, GROWLITHE, VULPIX, 0 ; newly unused
; Ochre Gym
	db 43, PERSIAN, KANGASKHAN, BLISSEY, TAUROS, SNORLAX, PORYGONZ, 0 ; new

HikerData:
; Mt. Moon 1F
	db 10, GEODUDE, GEODUDE, ONIX, 0
; Route 25
	db 15, MACHOP, GEODUDE, 0
	db 13, GEODUDE, GEODUDE, MACHOP, GEODUDE, 0
	db 17, ONIX, 0
; Route 9
	db 21, GEODUDE, ONIX, 0
	db 20, GEODUDE, MACHOP, GEODUDE, 0
; Route 10
	db 21, GEODUDE, ONIX, 0
	db 19, ONIX, GRAVELER, 0
; Rock Tunnel B1F
	db 21, GEODUDE, GEODUDE, GRAVELER, 0
	db 25, GRAVELER, 0
; Route 9/Rock Tunnel B1F
	db 20, MACHOP, ONIX, 0
; Rock Tunnel 1F
	db 19, GEODUDE, MACHOP, GEODUDE, GEODUDE, 0
	db 20, ONIX, ONIX, GEODUDE, 0
	db 21, GEODUDE, GRAVELER, 0
; Route 26
	db $FF, 6, ONIX, 7, ONIX, 8, ONIX, 9, ONIX, 10, ONIX, 0 ; new

BikerData:
; Route 13
	db 28, KOFFING, KOFFING, KOFFING, 0
; Route 14
	db 29, KOFFING, GRIMER, 0
; Route 15
	db 25, KOFFING, KOFFING, WEEZING, KOFFING, GRIMER, 0
	db 28, KOFFING, GRIMER, WEEZING, 0
; Route 16
	db 29, GRIMER, KOFFING, 0
	db 33, WEEZING, 0
	db 26, GRIMER, GRIMER, GRIMER, GRIMER, 0
; Route 17
	db 28, WEEZING, KOFFING, WEEZING, 0
	db 33, MUK, 0
	db 29, VOLTORB, VOLTORB, 0
	db 29, WEEZING, MUK, 0
	db 25, KOFFING, WEEZING, KOFFING, KOFFING, WEEZING, 0
; Route 14
	db 26, KOFFING, KOFFING, GRIMER, KOFFING, 0
	db 28, GRIMER, GRIMER, KOFFING, 0
	db 29, KOFFING, MUK, 0

BurglarData:
; Unused
	db 29, GROWLITHE, VULPIX, 0
	db 33, GROWLITHE, 0
	db 28, VULPIX, CHARMANDER, PONYTA, 0
; Cinnabar Gym
	db 50, ARCANINE, NINETALES, RAPIDASH, 0 ; updated
	db 49, PONYTA, RAPIDASH, GROWLITHE, ARCANINE, 0 ; updated
	db 51, MAGMORTAR, CHARIZARD, 0 ; updated
; Mansion 2F
	db 34, CHARMELEON, CHARMELEON, MAGMAR, 0
; Mansion 3F
	db 38, NINETALES, 0
; Mansion B1F
	db 36, ARCANINE, PONYTA, 0

;UnusedJugglerData: ; removed
; none

FisherData:
; SS Anne 2F Rooms
	db 17, GOLDEEN, TENTACOOL, GOLDEEN, 0
; SS Anne B1F Rooms
	db 17, TENTACOOL, STARYU, SHELLDER, 0
; Route 12
	db 22, GOLDEEN, POLIWAG, GOLDEEN, 0
	db 24, TENTACOOL, GOLDEEN, 0
	db 27, GOLDEEN, 0
	db 21, POLIWAG, SHELLDER, GOLDEEN, HORSEA, 0
; Route 21
	db 28, SEAKING, GOLDEEN, SEAKING, SEAKING, 0
	db 31, SHELLDER, CLOYSTER, 0
	db 27, MAGIKARP, GYARADOS, GYARADOS, GYARADOS, GYARADOS, GYARADOS, 0
	db 33, SEAKING, GOLDEEN, 0
; Route 12
	db 24, MAGIKARP, GYARADOS, GYARADOS, 0

SwimmerData:
; Cerulean Gym
	db 16, HORSEA, SHELLDER, SEEL, 0 ; updated
; Route 19
	db 30, TENTACRUEL, CLOYSTER, 0
	db 29, GOLDEEN, HORSEA, STARYU, 0
	db 30, POLIWAG, POLIWHIRL, 0
	db 27, HORSEA, TENTACOOL, TENTACRUEL, GOLDEEN, 0
	db 29, GOLDEEN, SHELLDER, SEAKING, 0
	db 30, HORSEA, HORSEA, 0
	db 27, TENTACOOL, TENTACOOL, STARYU, HORSEA, TENTACRUEL, 0
; Route 20
	db 31, SHELLDER, CLOYSTER, 0
	db 35, STARYU, 0
	db 28, HORSEA, HORSEA, SEADRA, HORSEA, 0
; Route 21
	db 33, SEADRA, TENTACRUEL, 0
	db 37, STARMIE, 0
	db 33, STARYU, WARTORTLE, 0
	db 32, POLIWRATH, TENTACRUEL, SEADRA, 0

CueBallData:
; Route 16
	db 28, MACHOKE, PRIMEAPE, MACHOKE, 0
	db 29, PRIMEAPE, MACHOKE, 0
	db 33, MACHOKE, 0
; Route 17
	db 29, PRIMEAPE, PRIMEAPE, 0
	db 29, MACHOKE, MACHOKE, 0
	db 33, MACHOKE, 0
	db 26, MANKEY, MANKEY, MACHOKE, MACHOP, 0
	db 29, PRIMEAPE, MACHOKE, 0
; Route 21
	db 31, TENTACOOL, TENTACRUEL, TENTACRUEL, 0

GamblerData:
; Route 11
	db 18, POLIWAG, HORSEA, 0
	db 18, BELLSPROUT, ODDISH, 0
	db 18, VOLTORB, MAGNEMITE, 0
	db 18, GROWLITHE, VULPIX, 0
; Route 8
	db 22, POLIWAG, POLIWAG, POLIWHIRL, 0
; Unused
	db 22, ONIX, GEODUDE, GRAVELER, 0
; Route 8
	db 24, GROWLITHE, VULPIX, 0

BeautyData:
; Celadon Gym
	db 26, GLOOM, WEEPINBELL, PARASECT, TANGELA, 0 ; updated
	db 28, VICTREEBEL, VILEPLUME, 0 ; updated
	db 29, TANGROWTH, 0 ; updated
; Route 13
	db 27, RATICATE, VULPIX, RATICATE, 0
	db 29, CLEFAIRY, MEOWTH, 0
; Route 20
	db 35, SEAKING, 0
	db 30, SHELLDER, SHELLDER, CLOYSTER, 0
	db 31, POLITOED, SEAKING, 0
; Route 15
	db 29, PIDGEOTTO, WIGGLYTUFF, 0
	db 29, BULBASAUR, IVYSAUR, 0
; Unused
	db 33, WEEPINBELL, BELLSPROUT, WEEPINBELL, 0
; Route 19
	db 27, POLIWRATH, GOLDEEN, SEAKING, GOLDEEN, POLIWRATH, 0
	db 30, GOLDEEN, SEAKING, 0
	db 29, STARYU, STARMIE, STARMIE, 0
; Route 20
	db 30, SEADRA, HORSEA, SEADRA, 0

PsychicData:
; Saffron Gym
	db 45, JYNX, SLOWBRO, EXEGGUTOR, MR_MIME, 0 ; updated
	db 46, EXEGGUTOR, ALAKAZAM, STARMIE, 0 ; updated
	db 45, ALAKAZAM, SLOWKING, STARMIE, JYNX, 0 ; updated
	db 45, SLOWKING, HYPNO, MR_MIME, SLOWBRO, 0 ; updated

RockerData:
; Vermilion Gym
	db 23, ELEKID, VOLTORB, VOLTORB, ELECTRODE, 0 ; updated
; Route 12
	db 29, VOLTORB, ELECTRODE, 0
;EngineerData: ; removed
; Ochre Gym
	db 45, MAGNEZONE, STEELIX, SCIZOR, 0 ; new
; Route 11
	db 21, MAGNEMITE, 0
	db 18, MAGNEMITE, MAGNEMITE, MAGNETON, 0

JugglerData:
; Silph Co. 5F
	db 29, KADABRA, MR_MIME, 0
; Victory Road 2F
	db 49, ELECTRODE, GOLEM, CLOYSTER, DITTO, ALAKAZAM, 0 ; updated, spherical mons and Alakazam
; Fuchsia Gym
	db 38, MUK, WEEZING, ARBOK, HAUNTER, 0 ; updated
	db 37, WEEZING, ELECTRODE, GOLEM, CLOYSTER, LICKILICKY, SNORLAX, 0 ; updated
; Victory Road 2F
	db 49, MIME_JR, HYPNO, SLOWBRO, JYNX, MR_MIME, 0 ; updated, all psychic not used by others in Victory Road
; Unused
	db 33, HYPNO, 0
; Fuchsia Gym
	db 38, BEEDRILL, TENTACRUEL, GOLBAT, VENUSAUR, 0 ; updated
	db 38, HYPNO, KADABRA, HAUNTER, VENUSAUR, 0 ; updated

TamerData:
; Fuchsia Gym
	db 38, NIDOQUEEN, VICTREEBEL, VILEPLUME, NIDOKING, 0 ; updated
	db 33, ARBOK, MUK, WEEZING, VENOMOTH, 0 ; updated
; Viridian Gym
	db 51, STEELIX, RHYPERIOR, NIDOKING, 0 ; updated
	db 51, RHYHORN, RHYDON, RHYPERIOR, TAUROS, 0 ; updated
; Victory Road 2F
	db 48, HITMONTOP, KINGDRA, POLITOED, LICKILICKY, RHYPERIOR, 0 ; updated, all new ones
; Unused
	db 42, RHYHORN, PRIMEAPE, ARBOK, TAUROS, 0

BirdKeeperData:
; Route 13
	db 29, PIDGEOTTO, PIDGEOTTO, 0
	db 25, FEAROW, PIDGEOTTO, PIDGEOTTO, FEAROW, FEAROW, 0
	db 26, PIDGEY, PIDGEOTTO, SPEAROW, FEAROW, 0
; Route 14
	db 33, FARFETCHD, 0
	db 29, FEAROW, FEAROW, 0
; Route 15
	db 26, PIDGEOTTO, FARFETCHD, DODUO, PIDGEOTTO, 0
	db 28, DODRIO, DODUO, DODUO, 0
; Route 18
	db 29, FEAROW, FEAROW, 0
	db 34, DODRIO, 0
	db 26, SPEAROW, FEAROW, FEAROW, FEAROW, 0
; Route 20
	db 30, FEAROW, FEAROW, PIDGEOTTO, 0
; Unused
	db 39, PIDGEOTTO, PIDGEOTTO, PIDGEOTTO, PIDGEOTTO, 0
	db 42, FARFETCHD, FEAROW, 0
; Route 14
	db 28, PIDGEOTTO, DODUO, PIDGEOTTO, 0
	db 26, PIDGEOTTO, FEAROW, PIDGEOTTO, FEAROW, 0
	db 29, PIDGEOTTO, FEAROW, 0
	db 31, FEAROW, DODRIO, FEAROW, 0
; Ochre Gym
	db 43, FEAROW, BUTTERFREE, FARFETCHD, PIDGEOT, SCYTHER, DODRIO, 0 ; new

BlackbeltData:
; Fighting Dojo ; all updated
	db 37, HITMONLEE, HITMONCHAN, HITMONTOP, 0
	db 32, MANKEY, PRIMEAPE, ANNIHILAPE, 0
	db 32, MACHOP, MACHOKE, MACHAMP, 0
	db 36, POLIWRATH, 0
	db 35, POLIWRATH, MACHOKE, PRIMEAPE, 0
; Viridian Gym
	db 52, MACHAMP, NIDOKING, 0 ; updated
	db 51, MACHAMP, RHYPERIOR, NIDOKING, 0 ; updated
	db 49, MACHAMP, RHYDON, NIDOQUEEN, RHYPERIOR, NIDOKING, GOLEM, 0 ; updated
; Victory Road 2F
	db 64, MACHAMP, 0 ; updated, one single overleveled mon

;ChiefData: ; removed
; none

ScientistData:
; Unused
	db 34, KOFFING, VOLTORB, 0
; Silph Co. 2F
	db 26, GRIMER, WEEZING, KOFFING, WEEZING, 0
	db 28, MAGNEMITE, VOLTORB, MAGNETON, 0
; Silph Co. 3F/Mansion 1F
	db 29, ELECTRODE, WEEZING, 0
; Silph Co. 4F
	db 33, ELECTRODE, 0
; Silph Co. 5F
	db 26, MAGNETON, KOFFING, WEEZING, MAGNEMITE, 0
; Silph Co. 6F
	db 25, VOLTORB, KOFFING, MAGNETON, MAGNEMITE, KOFFING, 0
; Silph Co. 7F
	db 29, ELECTRODE, MUK, 0
; Silph Co. 8F
	db 29, GRIMER, ELECTRODE, 0
; Silph Co. 9F
	db 28, VOLTORB, KOFFING, MAGNETON, 0
; Silph Co. 10F
	db 29, MAGNEMITE, KOFFING, 0
; Mansion 3F
	db 33, MAGNETON, MAGNETON, ELECTRODE, 0
; Mansion B1F
	db 34, MAGNETON, ELECTRODE, 0

GentlemanData:
; SS Anne 1F Rooms
	db 18, GROWLITHE, GROWLITHE, 0
	db 19, NIDORAN_M, NIDORAN_F, 0
; SS Anne 2F Rooms/Vermilion Gym
	db 23, ELEKID, MAGNEMITE, MAGNEMITE, MAGNETON, 0 ; updated
; Unused
	db 48, PRIMEAPE, 0
; SS Anne 2F Rooms
	db 17, GROWLITHE, PONYTA, 0

ChannelerData:
; Unused
	db 22, GASTLY, 0
	db 24, GASTLY, 0
	db 23, GASTLY, GASTLY, 0
	db 24, GASTLY, 0
; Pokémon Tower 3F
	db 23, GASTLY, 0
	db 24, GASTLY, 0
; Unused
	db 24, HAUNTER, 0
; Pokémon Tower 3F
	db 22, GASTLY, 0
; Pokémon Tower 4F
	db 24, GASTLY, 0
	db 23, GASTLY, GASTLY, 0
; Unused
	db 24, GASTLY, 0
; Pokémon Tower 4F
	db 22, GASTLY, 0
; Unused
	db 24, GASTLY, 0
; Pokémon Tower 5F
	db 23, HAUNTER, 0
; Unused
	db 24, GASTLY, 0
; Pokémon Tower 5F
	db 22, GASTLY, 0
	db 24, GASTLY, 0
	db 22, HAUNTER, 0
; Pokémon Tower 6F
	db 22, GASTLY, GASTLY, GASTLY, 0
	db 24, GASTLY, 0
	db 24, GASTLY, 0
; Saffron Gym
	db 45, GASTLY, HAUNTER, GENGAR, ANNIHILAPE, 0 ; updated
	db 47, GENGAR, ANNIHILAPE, 0 ; updated
	db 44, GASTLY, GASTLY, GASTLY, HAUNTER, HAUNTER, GENGAR, 0 ; updated
; Ochre Gym
	db 47, UMBREON, 0 ; new

RocketData:
; Mt. Moon B2F
	db 13, RATTATA, ZUBAT, 0
	db 11, SANDSHREW, RATTATA, ZUBAT, 0
	db 12, ZUBAT, EKANS, 0
	db 16, RATICATE, 0
; Cerulean City
	db 17, MACHOP, DROWZEE, 0
; Route 24
	db 15, EKANS, ZUBAT, 0
; Game Corner
	db 20, RATICATE, ZUBAT, 0
; Rocket Hideout B1F
	db 21, DROWZEE, MACHOP, 0
	db 21, RATICATE, RATICATE, 0
	db 20, GRIMER, KOFFING, KOFFING, 0
	db 19, RATTATA, RATICATE, RATICATE, RATTATA, 0
	db 22, GRIMER, KOFFING, 0
; Rocket Hideout B2F
	db 17, ZUBAT, KOFFING, GRIMER, ZUBAT, RATICATE, 0
; Rocket Hideout B3F
	db 20, RATTATA, RATICATE, DROWZEE, 0
	db 21, MACHOP, MACHOP, 0
; Rocket Hideout B4F
	db 23, SANDSHREW, ARBOK, SANDSLASH, 0
	db 23, ARBOK, SANDSLASH, ARBOK, 0
	db 21, KOFFING, GOLBAT, 0
; Pokémon Tower 7F
	db 25, ZUBAT, GOLBAT, GOLBAT, 0
	db 26, KOFFING, HYPNO, 0
	db 23, ZUBAT, RATTATA, RATICATE, GOLBAT, 0
; Unused
	db 26, HYPNO, KOFFING, 0
; Silph Co. 2F
	db 27, CUBONE, GOLBAT, RATICATE, 0
	db 25, GOLBAT, GOLBAT, GOLBAT, RATICATE, GOLBAT, 0
; Silph Co. 3F
	db 28, RATICATE, HYPNO, RATICATE, 0
; Silph Co. 4F
	db 29, MACHOKE, HYPNO, 0
	db 27, ARBOK, GOLBAT, CUBONE, KOFFING, 0
; Silph Co. 5F
	db 33, ARBOK, 0
	db 33, HYPNO, 0
; Silph Co. 6F
	db 29, MACHOP, MACHOKE, 0
	db 28, ZUBAT, GOLBAT, GOLBAT, 0
; Silph Co. 7F
	db 26, RATICATE, ARBOK, KOFFING, GOLBAT, 0
	db 27, CUBONE, MACHOKE, 0
	db 29, SANDSLASH, SANDSLASH, 0
; Silph Co. 8F
	db 26, RATICATE, GOLBAT, GOLBAT, RATICATE, 0
	db 28, WEEZING, GOLBAT, KOFFING, 0
; Silph Co. 9F
	db 28, HYPNO, GRIMER, MACHOKE, 0
	db 28, GOLBAT, HYPNO, HYPNO, 0
; Silph Co. 10F
	db 33, MACHOKE, 0
; Silph Co. 11F
	db 25, RATICATE, RATICATE, GOLBAT, RATICATE, ARBOK, 0
	db 32, MACHOKE, HYPNO, SANDSLASH, 0 ; updated, removed Marowak; also not used in Yellow, leftover from RB
; Obsidian Warehouse, grunts
	db 27, CUBONE, 0 ; $2a=42
	db 37, RATICATE, HYPNO, GOLBAT, 0
	db 37, MUK, SANDSLASH, ARBOK, 0
	db 38, MACHOKE, WEEZING, 0
; Jessie & James ; updated
	db 14, EKANS, KOFFING, MEOWTH, 0 ; Mt Moon ; $2e=46
	db 25, ARBOK, WEEZING, MEOWTH, 0 ; Rocket Hideout ; $2f=47
	db 32, ARBOK, LICKITUNG, WEEZING, WEEPINBELL, MEOWTH, 0 ; Pokemon Tower ; $30=48
	db 36, ARBOK, LICKILICKY, WEEZING, VICTREEBEL, MEOWTH, 0 ; Silph Co ; $31=49
	db 39, ARBOK, LICKILICKY, WEEZING, VICTREEBEL, MEOWTH, 0 ; Obsidian Warehouse ; $32=50
; Obsidian Warehouse, executives
	db 40, CROBAT, WEEZING, 0 ; Proton ; $33=51
	db $FF, 39, KOFFING, 39, KOFFING, 39, KOFFING, 39, KOFFING, 39, KOFFING, 41, WEEZING, 0 ; Petrel
	db 42, ARBOK, VILEPLUME, UMBREON, 0 ; Ariana
	db 43, WEEZING, ELECTRODE, CROBAT, MAGMORTAR, UMBREON, 0 ; Archer

CooltrainerData:
; Celadon Gym
	db 29, EXEGGUTOR, IVYSAUR, TANGROWTH, 0 ; updated
; Victory Road 3F
	db 49, ELECTIVIRE, CLOYSTER, VICTREEBEL, NINETALES, POLIWRATH, 0 ; updated
	db 49, STEELIX, SLOWKING, BLISSEY, KLEAVOR, SCIZOR, 0 ; updated
; Unused
	db 46, VILEPLUME, BUTTERFREE, 0
; Victory Road 1F
	db $FF, 50, JIGGLYPUFF, 50, ALAKAZAM, 50, DITTO, 50, CLEFABLE, 50, NIDOQUEEN, 55, BLASTOISE, 0 ; updated, pseudo-Green, manga
; Unused
	db 45, IVYSAUR, VENUSAUR, 0
	db 45, NIDORINA, NIDOQUEEN, 0
	db 43, PERSIAN, NINETALES, RAICHU, 0
; Pewter Gym
	db 10, GEODUDE, GEODUDE, RHYHORN, ONIX, AERODACTYL, 0 ; new
; Vermilion Gym
	db 26, PICHU, ELEKID, VOLTORB, MAGNEMITE, MAGNEMITE, 0 ; new
; Fuchsia Gym
	db 41, VENOMOTH, WEEZING, TENTACRUEL, NIDOQUEEN, CROBAT, 0 ; new
; Cinnabar Gym
	db 52, ARCANINE, MAGMAR, NINETALES, RAPIDASH, CHARIZARD, 0 ; new
; Ochre Gym
	db 45, KLEAVOR, UMBREON, FEAROW, CLEFABLE, STEELIX, SNORLAX, 0 ; new
;CooltrainerMData: ; removed, did a + 13 to merge with the above
; Viridian Gym
	db 50, DUGTRIO, GOLEM, RHYDON, STEELIX, 0 ; updated
; Victory Road 3F
	db 49, ARCANINE, EXEGGUTOR, MAGNEZONE, TANGROWTH, STARMIE, 0 ; updated
	db 49, CROBAT, PORYGONZ, BELLOSSOM, MAGMORTAR, ANNIHILAPE, 0 ; updated
; Unused
	db 45, KINGLER, STARMIE, 0
; Victory Road 1F
	db $FF, 50, POLIWRATH, 55, VENUSAUR, 50, PIKACHU, 50, SNORLAX, 50, GYARADOS, 50, AERODACTYL, 0 ; updated, pseudo-Red, manga
; Unused
	db 44, IVYSAUR, WARTORTLE, CHARMELEON, 0
	db 49, NIDOKING, 0
	db 44, KINGLER, CLOYSTER, 0
; Viridian Gym
	db 50, NIDOQUEEN, NIDOKING, SANDSLASH, DUGTRIO, 0 ; updated
	db 52, GOLEM, RHYPERIOR, 0 ; updated
; Victory Road 1F
	db $FF, 50, SCIZOR, 55, CHARIZARD, 50, GOLDUCK, 50, MACHAMP, 50, PORYGON2, 50, RHYPERIOR, 0 ; updated, pseudo-Blue, manga
; Cerulean Gym
	db 19, WARTORTLE, SLOWPOKE, SEEL, KRABBY, TENTACOOL, 0 ; new
; Celadon Gym
	db 30, IVYSAUR, PARASECT, BELLOSSOM, VICTREEBEL, EXEGGUTOR, 0 ; new
; Saffron Gym
	db 48, JYNX, EXEGGUTOR, STARMIE, ALAKAZAM, GENGAR, 0 ; new
; Viridian Gym
	db 53, MACHAMP, SANDSLASH, TAUROS, GOLEM, STEELIX, 0 ; new
; Victory Road 1F ;
	db $FF, 50, RATICATE, 50, DODRIO, 50, GOLEM, 50, OMASTAR, 50, BUTTERFREE, 55, PIKACHU, 0 ; pseudo-Yellow

BrockData:
	db $FF, 10, GEODUDE, 10, OMANYTE, 10, KABUTO, 10, RHYHORN, 10, VULPIX, 11, ONIX, 0 ; updated
	db 70, GOLEM, OMASTAR, KABUTOPS, RHYPERIOR, KLEAVOR, MARODACTYL, 0 ; rematch

MistyData:
	db $FF, 20, STARYU, 20, PSYDUCK, 20, POLIWHIRL, 20, GYARADOS, 20, VAPOREON, 21, STARMIE, 0 ; updated
	db 70, GOLDUCK, LAPRAS, POLITOED, VAPOREON, STARMIE, MBLASTOISE, 0 ; rematch; maybe GYARADOS instead of LAPRAS?

LtSurgeData:
	db $FF, 27, PIKACHU, 27, VOLTORB, 27, MAGNEMITE, 27, ELECTABUZZ, 27, JOLTEON, 28, RAICHU, 0 ; updated
	db 70, ELECTRODE, RAICHU, MAGNEZONE, ELECTIVIRE, JOLTEON, RAICHU, 0 ; rematch

ErikaData:
	db $FF, 31, PARASECT, 31, VILEPLUME, 31, BELLOSSOM, 31, VICTREEBEL, 31, LEAFEON, 32, TANGROWTH, 0 ; updated
	db 70, VICTREEBEL, VILEPLUME, BELLOSSOM, LEAFEON, TANGROWTH, MVENUSAUR, 0 ; rematch

KogaData:
	db $FF, 42, MUK, 42, BEEDRILL, 42, VENOMOTH, 42, TENTACRUEL, 42, CROBAT, 43, WEEZING, 0 ; updated
	db 70, MUK, GENGAR, TENTACRUEL, CROBAT, WEEZING, MBEEDRILL, 0 ; rematch

SabrinaData:
	db $FF, 49, EXEGGUTOR, 49, SLOWKING, 49, MR_MIME, 49, ESPEON, 49, HAUNTER, 50, ALAKAZAM, 0 ; updated
	db 70, EXEGGUTOR, MR_MIME, SLOWKING, ALAKAZAM, ESPEON, MALAKAZAM, 0 ; rematch

BlaineData:
	db $FF, 53, NINETALES, 53, RAPIDASH, 53, MAGMORTAR, 53, FLAREON, 53, RHYDON, 54, ARCANINE, 0 ; updated
	db 70, NINETALES, MAGMORTAR, RAPIDASH, FLAREON, ARCANINE, MCHARZARDY, 0 ; rematch

GiovanniData:
; Rocket Hideout B4F
	db $FF, 28, ONIX, 28, RHYHORN, 28, DUGTRIO, 28, KANGASKHAN, 28, MAROWAK, 29, PERSIAN, 0 ; updated
; Silph Co. 11F
	db $FF, 42, STEELIX, 42, NIDOKING, 42, RHYDON, 42, NIDOQUEEN, 42, GOLEM, 43, PERSIAN, 0 ; updated
; Obsidian Warehouse
	db $FF, 45, SANDSLASH, 45, DUGTRIO, 45, NIDOKING, 45, NIDOQUEEN, 45, KANGASKHAN, 46, PERSIAN, 0 ; new
; Viridian Gym
	db $FF, 54, DUGTRIO, 54, GOLEM, 54, NIDOQUEEN, 54, NIDOKING, 54, RHYPERIOR, 55, PERSIAN, 0 ; updated
	db 70, MAROWAK, STEELIX, NIDOKING, NIDOQUEEN, MKANGASKAN, PERSIAN, 0 ; rematch, Safari Zone
	db 75, MAROWAK, STEELIX, NIDOKING, RHYPERIOR, MKANGASKAN, PERSIAN, 0 ; rematch, Oak's lab

LoreleiData:
	db 56, DEWGONG, CLOYSTER, JYNX, GLACEON, LAPRAS, MSLOWBRO, 0 ; updated
	db 75, JYNX, DEWGONG, CLOYSTER, GLACEON, LAPRAS, MSLOWBRO, 0 ; rematch

BrunoData:
	db 58, HITMONTOP, HITMONCHAN, HITMONLEE, POLIWRATH, MACHAMP, MSTEELIX, 0 ; updated
	db 75, HITMONLEE, POLIWRATH, HITMONTOP, ANNIHILAPE, MACHAMP, MSTEELIX, 0 ; rematch

AgathaData:
	db 60, GENGAR, CROBAT, GENGAR, ANNIHILAPE, UMBREON, MGENGAR, 0 ; updated
	db 75, GENGAR, ANNIHILAPE, CROBAT, GENGAR, UMBREON, MGENGAR, 0 ; rematch

LanceData:
	db 62, GYARADOS, DRAGONITE, AERODACTYL, KINGDRA, DRAGONITE, MCHARZARDX, 0 ; updated
	db 75, AERODACTYL, DRAGONITE, GYARADOS, KINGDRA, DRAGONITE, MCHARZARDX, 0 ; rematch

Rival1Data:
	db 5, EEVEE, 0
; Route 22
	db 9, SPEAROW, RATTATA, PIDGEY, NIDORAN_M, MANKEY, EEVEE, 0 ; updated
; Cerulean City
	db 19, PIDGEOTTO, NIDOKING, CLEFABLE, SANDSHREW, MANKEY, EEVEE, 0 ; updated

Rival2Data:
; SS Anne 2F
	db 22, NIDOKING, PIDGEOTTO, CLEFABLE, SANDSLASH, RATICATE, EEVEE, 0 ; updated
; Pokémon Tower 2F
	db 27, PINSIR, PORYGONZ, KLEAVOR, CLOYSTER, NINETALES, UMBREON, 0 ; updated
; Silph Co. 7F
	db 42, ANNIHILAPE, ALAKAZAM, ELECTIVIRE, JYNX, MAGMORTAR, UMBREON, 0 ; updated
; Route 22
	db 55, JOLTEON, VAPOREON, FLAREON, LEAFEON, GLACEON, UMBREON, 0 ; updated

Rival3Data:
	db 65, MPIDGEOT, MALAKAZAM, MSCIZOR, MVENUSAUR, MCHARZARDY, MBLASTOISE, 0 ; updated
	db 70, ARTICUNO, ZAPDOS, MOLTRES, 0 ; new
	; teams for League Rematch
	db 80, MPINSIR, MPIDGEOT, MALAKAZAM, MVENUSAUR, MCHARZARDY, MBLASTOISE , 0 ; new
	db $FF, 85, ARTICUNO, 85, ZAPDOS, 85, MOLTRES, 85, MEWTWO, 85, MEW, 88, UMBREON, 0 ; new
	; teams for the randomized rematches
	db $FF, 80, JYNX, 80, SANDSLASH, 80, FEAROW, 80, CHARIZARD, 80, MPIDGEOT, 85, UMBREON, 0 ; team 5
	db $FF, 80, STEELIX, 80, ARCANINE, 80, MUK, 80, RHYPERIOR, 80, MBEEDRILL, 85, UMBREON, 0
	db $FF, 80, BLISSEY, 80, HITMONLEE, 80, MAROWAK, 80, SYLVEON, 80, MGYARADOS, 85, UMBREON, 0
	db $FF, 80, ELECTIVIRE, 80, SEAKING, 80, SLOWKING, 80, PERSIAN, 80, MALAKAZAM, 85, UMBREON, 0
	db $FF, 80, NINETALES, 80, GOLDUCK, 80, KANGASKHAN, 80, JOLTEON, 80, MSTEELIX, 85, UMBREON, 0
	db $FF, 80, LAPRAS, 80, CROBAT, 80, AERODACTYL, 80, GENGAR, 80, MPINSIR, 85, UMBREON, 0
	db $FF, 80, STARMIE, 80, GOLEM, 80, KINGLER, 80, ANNIHILAPE, 80, MARODACTYL, 85, UMBREON, 0
	db $FF, 80, NIDOQUEEN, 80, HITMONCHAN, 80, BEEDRILL, 80, LEAFEON, 80, MCHARZARDX, 85, UMBREON, 0
	db $FF, 80, KABUTOPS, 80, DITTO, 80, KLEAVOR, 80, DUGTRIO, 80, MCHARZARDY, 85, UMBREON, 0
	db $FF, 80, VILEPLUME, 80, BUTTERFREE, 80, OMASTAR, 80, SCIZOR, 80, MGENGAR, 85, UMBREON, 0
	db $FF, 80, MACHAMP, 80, POLIWRATH, 80, MAGMORTAR, 80, GLACEON, 80, MKANGASKAN, 85, UMBREON, 0
	db $FF, 80, NIDOKING, 80, RAPIDASH, 80, WIGGLYTUFF, 80, KINGDRA, 80, MVENUSAUR, 85, UMBREON, 0
	db $FF, 80, ALAKAZAM, 80, CLOYSTER, 80, PARASECT, 80, SNORLAX, 80, MSCIZOR, 85, UMBREON, 0
	db $FF, 80, LICKILICKY, 80, ELECTRODE, 80, PINSIR, 80, TAUROS, 80, MSLOWBRO, 85, UMBREON, 0
	db $FF, 80, PIDGEOT, 80, CLEFABLE, 80, RATICATE, 80, BLASTOISE, 80, MBLASTOISE, 85, UMBREON, 0
	db $FF, 80, ESPEON, 80, HITMONTOP, 80, VICTREEBEL, 80, DRAGONITE, 80, MSTEELIX, 85, UMBREON, 0 ; team 20
	db $FF, 80, VAPOREON, 80, ARBOK, 80, WEEZING, 80, SLOWBRO, 80, MSCIZOR, 85, UMBREON, 0
	db $FF, 80, FLAREON, 80, BELLOSSOM, 80, HYPNO, 80, GYARADOS, 80, MSLOWBRO, 85, UMBREON, 0
	db $FF, 80, RAICHU, 80, DEWGONG, 80, POLITOED, 80, VENUSAUR, 80, MPINSIR, 85, UMBREON, 0
	db $FF, 80, MR_MIME, 80, FARFETCHD, 80, TANGROWTH, 80, EXEGGUTOR, 80, MCHARZARDX, 85, UMBREON, 0
	db $FF, 80, MAGNEZONE, 80, DODRIO, 80, TENTACRUEL, 80, PORYGONZ, 80, MPIDGEOT, 85, UMBREON, 0
	db $FF, 80, VENOMOTH, 80, HYPNO, 80, ARCANINE, 80, SYLVEON, 80, MGENGAR, 85, UMBREON, 0
	db $FF, 80, MBLASTOISE, 80, MARODACTYL, 80, MBEEDRILL, 80, MALAKAZAM, 80, MMEWTWOY, 85, UMBREON, 0
	db $FF, 80, MKANGASKAN, 80, MGYARADOS, 80, MBEEDRILL, 80, MCHARZARDY, 80, MMEWTWOX, 85, UMBREON, 0
	db $FF, 80, MGYARADOS, 80, MKANGASKAN, 80, MARODACTYL, 80, MVENUSAUR, 80, MPINSIR, 85, UMBREON, 0 ; team 29

ProfOakData:
	db $FF, 82, TAUROS, 83, MGYARADOS, 84, MEWTWO, 85, MMEWTWOX, 86, MMEWTWOY, 87, VENUSTOISE, 0 ; updated

OrageData:
	db $FF, 46, BLISSEY, 46, DODRIO, 46, PINSIR, 46, SCIZOR, 46, UMBREON, 47, SYLVEON, 0 ; new

PigeonData:
	db 100, PIDGEY, DRAGONAIR, HAUNTER, PORYGON, MMEWTWOY, MAGIKARP, 0 ; new

TravelerData:
	db 100, ZYGARDEC, UNECROZMA, MRAYQUAZA, EETERNATUS, ARCEUS, 0 ; new
;	db 100, ZYGARDEC, UNECROZMA, MRAYQUAZA, EETERNATUS, ARCEUS, MMEWTWOX, 0 ; maybe for rematch?

BFTrainerData:
; TODO: prepare about 7x10 teams
