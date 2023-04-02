; See constants/pokemon_data_constants.asm
; The max number of evolutions per monster is MAX_EVOLUTIONS

EvosMovesPointerTable:
	table_width 2, EvosMovesPointerTable
	dw BulbasaurEvosMoves
	dw IvysaurEvosMoves
	dw VenusaurEvosMoves
	dw MVenusaurEvosMoves
	dw CharmanderEvosMoves
	dw CharmeleonEvosMoves
	dw CharizardEvosMoves
	dw MCharzardXEvosMoves
	dw MCharzardYEvosMoves
	dw SquirtleEvosMoves
	dw WartortleEvosMoves
	dw BlastoiseEvosMoves
	dw MBlastoiseEvosMoves
	dw CaterpieEvosMoves
	dw MetapodEvosMoves
	dw ButterfreeEvosMoves
	dw WeedleEvosMoves
	dw KakunaEvosMoves
	dw BeedrillEvosMoves
	dw MBeedrillEvosMoves
	dw PidgeyEvosMoves
	dw PidgeottoEvosMoves
	dw PidgeotEvosMoves
	dw MPidgeotEvosMoves
	dw RattataEvosMoves
	dw RaticateEvosMoves
	dw SpearowEvosMoves
	dw FearowEvosMoves
	dw EkansEvosMoves
	dw ArbokEvosMoves
	dw PichuEvosMoves
	dw PikachuEvosMoves
	dw RaichuEvosMoves
	dw SandshrewEvosMoves
	dw SandslashEvosMoves
	dw NidoranFEvosMoves
	dw NidorinaEvosMoves
	dw NidoqueenEvosMoves
	dw NidoranMEvosMoves
	dw NidorinoEvosMoves
	dw NidokingEvosMoves
	dw CleffaEvosMoves
	dw ClefairyEvosMoves
	dw ClefableEvosMoves
	dw VulpixEvosMoves
	dw NinetalesEvosMoves
	dw JigglypuffEvosMoves
	dw WigglytuffEvosMoves
	dw ZubatEvosMoves
	dw GolbatEvosMoves
	dw OddishEvosMoves
	dw GloomEvosMoves
	dw VileplumeEvosMoves
	dw ParasEvosMoves
	dw ParasectEvosMoves
	dw VenonatEvosMoves
	dw VenomothEvosMoves
	dw DiglettEvosMoves
	dw DugtrioEvosMoves
	dw MeowthEvosMoves
	dw PersianEvosMoves
	dw PsyduckEvosMoves
	dw GolduckEvosMoves
	dw MankeyEvosMoves
	dw PrimeapeEvosMoves
	dw GrowlitheEvosMoves
	dw ArcanineEvosMoves
	dw PoliwagEvosMoves
	dw PoliwhirlEvosMoves
	dw PoliwrathEvosMoves
	dw AbraEvosMoves
	dw KadabraEvosMoves
	dw AlakazamEvosMoves
	dw MachopEvosMoves
	dw MachokeEvosMoves
	dw MachampEvosMoves
	dw BellsproutEvosMoves
	dw WeepinbellEvosMoves
	dw VictreebelEvosMoves
	dw TentacoolEvosMoves
	dw TentacruelEvosMoves
	dw GeodudeEvosMoves
	dw GravelerEvosMoves
	dw GolemEvosMoves
	dw PonytaEvosMoves
	dw RapidashEvosMoves
	dw SlowpokeEvosMoves
	dw SlowbroEvosMoves
	dw MagnemiteEvosMoves
	dw MagnetonEvosMoves
	dw FarfetchdEvosMoves
	dw DoduoEvosMoves
	dw DodrioEvosMoves
	dw SeelEvosMoves
	dw DewgongEvosMoves
	dw GrimerEvosMoves
	dw MukEvosMoves
	dw ShellderEvosMoves
	dw CloysterEvosMoves
	dw GastlyEvosMoves
	dw HaunterEvosMoves
	dw GengarEvosMoves
	dw OnixEvosMoves
	dw DrowzeeEvosMoves
	dw HypnoEvosMoves
	dw KrabbyEvosMoves
	dw KinglerEvosMoves
	dw VoltorbEvosMoves
	dw ElectrodeEvosMoves
	dw ExeggcuteEvosMoves
	dw ExeggutorEvosMoves
	dw CuboneEvosMoves
	dw MarowakEvosMoves
	dw HitmonleeEvosMoves
	dw HitmonchanEvosMoves
	dw LickitungEvosMoves
	dw KoffingEvosMoves
	dw WeezingEvosMoves
	dw RhyhornEvosMoves
	dw RhydonEvosMoves
	dw ChanseyEvosMoves
	dw TangelaEvosMoves
	dw KangaskhanEvosMoves
	dw HorseaEvosMoves
	dw SeadraEvosMoves
	dw GoldeenEvosMoves
	dw SeakingEvosMoves
	dw StaryuEvosMoves
	dw StarmieEvosMoves
	dw MrMimeEvosMoves
	dw ScytherEvosMoves
	dw JynxEvosMoves
	dw ElectabuzzEvosMoves
	dw MagmarEvosMoves
	dw PinsirEvosMoves
	dw TaurosEvosMoves
	dw MagikarpEvosMoves
	dw GyaradosEvosMoves
	dw LaprasEvosMoves
	dw DittoEvosMoves
	dw EeveeEvosMoves
	dw VaporeonEvosMoves
	dw JolteonEvosMoves
	dw FlareonEvosMoves
	dw PorygonEvosMoves
	dw OmanyteEvosMoves
	dw OmastarEvosMoves
	dw KabutoEvosMoves
	dw KabutopsEvosMoves
	dw AerodactylEvosMoves
	dw SnorlaxEvosMoves
	dw ArticunoEvosMoves
	dw ZapdosEvosMoves
	dw MoltresEvosMoves
	dw DratiniEvosMoves
	dw DragonairEvosMoves
	dw DragoniteEvosMoves
	dw MewtwoEvosMoves
	dw MewEvosMoves
	dw ArceusEvosMoves
	dw FossilKabutopsEvosMoves
	dw FossilAerodactylEvosMoves
	dw MonGhostEvosMoves
	assert_table_length NUM_POKEMON_INDEXES

BulbasaurEvosMoves:
; Evolutions
	db EV_LEVEL, 16, IVYSAUR
	db 0
; Learnset
	db 7, LEECH_SEED
	db 9, VINE_WHIP
	db 13, POISONPOWDER
	db 15, SLEEP_POWDER
	db 18, RAZOR_LEAF
	db 21, MAGICAL_LEAF
	db 25, GROWTH
	db 28, DOUBLE_EDGE
	db 30, PETAL_DANCE
	db 32, SLUDGE_WAVE
	db 35, LEAF_STORM
	db 39, ENERGY_BALL
	db 42, SOLARBEAM
	db 0

IvysaurEvosMoves:
; Evolutions
	db EV_LEVEL, 32, VENUSAUR
	db 0
; Learnset
	db 7, LEECH_SEED
	db 9, VINE_WHIP
	db 13, POISONPOWDER
	db 15, SLEEP_POWDER
	db 20, RAZOR_LEAF
	db 24, MAGICAL_LEAF
	db 28, GROWTH
	db 31, DOUBLE_EDGE
	db 33, PETAL_DANCE
	db 35, SLUDGE_WAVE
	db 38, LEAF_STORM
	db 42, ENERGY_BALL
	db 47, SOLARBEAM
	db 0

VenusaurEvosMoves:
; Evolutions
	db EV_ITEM, MEGA_STONE_X, 1, MVENUSAUR
	db EV_ITEM, MEGA_STONE_Y, 1, MVENUSAUR
	db 0
; Learnset
	db 7, LEECH_SEED
	db 9, VINE_WHIP
	db 13, POISONPOWDER
	db 15, SLEEP_POWDER
	db 20, RAZOR_LEAF
	db 24, MAGICAL_LEAF
	db 28, GROWTH
	db 31, DOUBLE_EDGE
	db 34, PETAL_DANCE
	db 38, SLUDGE_WAVE
	db 42, LEAF_STORM
	db 48, ENERGY_BALL
	db 53, SOLARBEAM
	db 60, FRENZY_PLANT
	db 0

MVenusaurEvosMoves:
; Evolutions
	db 0
; Learnset
	db 12, LEECH_SEED
	db 14, VINE_WHIP
	db 18, POISONPOWDER
	db 20, SLEEP_POWDER
	db 25, RAZOR_LEAF
	db 29, MAGICAL_LEAF
	db 33, GROWTH
	db 36, DOUBLE_EDGE
	db 39, PETAL_DANCE
	db 43, SLUDGE_WAVE
	db 45, AMNESIA
	db 47, LEAF_STORM
	db 53, ENERGY_BALL
	db 55, GUNK_SHOT
	db 58, SOLARBEAM
	db 65, FRENZY_PLANT
	db 0

CharmanderEvosMoves:
; Evolutions
	db EV_LEVEL, 16, CHARMELEON
	db 0
; Learnset
	db 9, EMBER
	db 12, DRAGONBREATH
	db 15, LEER
	db 17, FIRE_PUNCH
	db 20, SLASH
	db 24, SMOKESCREEN
	db 27, FLAMETHROWER
	db 29, IRON_TAIL
	db 31, CRUNCH
	db 35, FIRE_SPIN
	db 40, FLARE_BLITZ
	db 0

CharmeleonEvosMoves:
; Evolutions
	db EV_LEVEL, 36, CHARIZARD
	db 0
; Learnset
	db 9, EMBER
	db 12, DRAGONBREATH
	db 15, LEER
	db 19, FIRE_PUNCH
	db 24, SLASH
	db 27, SMOKESCREEN
	db 30, FLAMETHROWER
	db 33, IRON_TAIL
	db 35, CRUNCH
	db 41, FIRE_SPIN
	db 49, FLARE_BLITZ
	db 0

CharizardEvosMoves:
; Evolutions
	db EV_ITEM, MEGA_STONE_X, 1, MCHARZARDX
	db EV_ITEM, MEGA_STONE_Y, 1, MCHARZARDY
	db 0
; Learnset
	db 9, EMBER
	db 12, DRAGONBREATH
	db 15, LEER
	db 19, FIRE_PUNCH
	db 24, SLASH
	db 27, SMOKESCREEN
	db 30, FLAMETHROWER
	db 33, IRON_TAIL
	db 35, CRUNCH
	db 38, AIR_SLASH
	db 42, STEEL_WING
	db 46, FIRE_SPIN
	db 51, ROOST
	db 57, FLARE_BLITZ
	db 60, BLAST_BURN
	db 0

MCharzardXEvosMoves:
; Evolutions
	db 0
; Learnset
	db 14, EMBER
	db 17, DRAGONBREATH
	db 20, LEER
	db 22, DRAGON_RAGE
	db 24, FIRE_PUNCH
	db 29, SLASH
	db 32, SMOKESCREEN
	db 35, FLAMETHROWER
	db 40, CRUNCH
	db 43, AIR_SLASH
	db 45, DRAGON_CLAW
	db 47, STEEL_WING
	db 51, FIRE_SPIN
	db 56, ROOST
	db 59, SHADOW_CLAW
	db 62, FLARE_BLITZ
	db 65, BLAST_BURN
	db 0

MCharzardYEvosMoves:
; Evolutions
	db 0
; Learnset
	db 14, EMBER
	db 17, DRAGONBREATH
	db 20, LEER
	db 22, DRAGON_RAGE
	db 24, FIRE_PUNCH
	db 29, SLASH
	db 32, SMOKESCREEN
	db 35, FLAMETHROWER
	db 40, CRUNCH
	db 43, AIR_SLASH
	db 45, HURRICANE
	db 47, STEEL_WING
	db 51, FIRE_SPIN
	db 56, ROOST
	db 59, FIRE_BLAST
	db 62, FLARE_BLITZ
	db 65, BLAST_BURN
	db 0

SquirtleEvosMoves:
; Evolutions
	db EV_LEVEL, 16, WARTORTLE
	db 0
; Learnset
	db 8, BUBBLE
	db 12, BITE
	db 15, WATER_GUN
	db 17, HAZE
	db 18, MIST
	db 20, MUD_SLAP
	db 21, WATER_PULSE
	db 24, DEFENSE_CURL
	db 26, HEADBUTT
	db 28, CRUNCH
	db 30, SUBMISSION
	db 33, IRON_TAIL
	db 35, ICE_PUNCH
	db 37, SCALD
	db 40, AQUA_JET
	db 42, ZEN_HEADBUTT
	db 45, ROCK_TOMB
	db 47, HYDRO_PUMP
	db 0

WartortleEvosMoves:
; Evolutions
	db EV_LEVEL, 36, BLASTOISE
	db 0
; Learnset
	db 8, BUBBLE
	db 12, BITE
	db 15, WATER_GUN
	db 18, HAZE
	db 21, MIST
	db 23, MUD_SLAP
	db 25, WATER_PULSE
	db 28, DEFENSE_CURL
	db 30, HEADBUTT
	db 32, CRUNCH
	db 34, SUBMISSION
	db 37, IRON_TAIL
	db 39, ICE_PUNCH
	db 41, SCALD
	db 44, AQUA_JET
	db 46, ZEN_HEADBUTT
	db 49, ROCK_TOMB
	db 51, HYDRO_PUMP
	db 0

BlastoiseEvosMoves:
; Evolutions
	db EV_ITEM, MEGA_STONE_X, 1, MBLASTOISE
	db EV_ITEM, MEGA_STONE_Y, 1, MBLASTOISE
	db 0
; Learnset
	db 8, BUBBLE
	db 12, BITE
	db 15, WATER_GUN
	db 18, HAZE
	db 21, MIST
	db 23, MUD_SLAP
	db 25, WATER_PULSE
	db 28, DEFENSE_CURL
	db 30, HEADBUTT
	db 32, CRUNCH
	db 34, SUBMISSION
	db 36, FLASH_CANNON
	db 41, IRON_TAIL
	db 43, ICE_PUNCH
	db 45, SCALD
	db 48, AQUA_JET
	db 50, ZEN_HEADBUTT
	db 53, ROCK_TOMB
	db 55, HYDRO_PUMP
	db 60, HYDRO_CANNON
	db 0

MBlastoiseEvosMoves:
; Evolutions
	db 0
; Learnset
	db 13, BUBBLE
	db 17, BITE
	db 20, WATER_GUN
	db 23, HAZE
	db 26, MIST
	db 28, MUD_SLAP
	db 30, WATER_PULSE
	db 33, DEFENSE_CURL
	db 35, HEADBUTT
	db 37, CRUNCH
	db 39, SUBMISSION
	db 41, FLASH_CANNON
	db 43, ZAP_CANNON
	db 46, IRON_TAIL
	db 48, ICE_PUNCH
	db 50, SCALD
	db 53, AQUA_JET
	db 55, ZEN_HEADBUTT
	db 57, BULLET_SEED
	db 58, ROCK_TOMB
	db 60, HYDRO_PUMP
	db 65, HYDRO_CANNON
	db 0

CaterpieEvosMoves:
; Evolutions
	db EV_LEVEL, 7, METAPOD
	db 0
; Learnset
	db 0

MetapodEvosMoves:
; Evolutions
	db EV_LEVEL, 10, BUTTERFREE
	db 0
; Learnset
	db 7, HARDEN
	db 0

ButterfreeEvosMoves:
; Evolutions
	db 0
; Learnset
	db 10, CONFUSION
	db 11, SUPERSONIC
	db 12, POISONPOWDER
	db 14, STUN_SPORE
	db 15, SLEEP_POWDER
	db 16, PSYBEAM
	db 17, SWIFT
	db 18, GUST
	db 21, AIR_SLASH
	db 23, MEGA_DRAIN
	db 25, GUST
	db 28, TWISTER
	db 31, DREAM_EATER
	db 33, INFESTATION
	db 35, ENERGY_BALL
	db 37, ROOST
	db 39, AIR_CUTTER
	db 41, AERIAL_ACE
	db 44, HURRICANE
	db 0

WeedleEvosMoves:
; Evolutions
	db EV_LEVEL, 7, KAKUNA
	db 0
; Learnset
	db 0

KakunaEvosMoves:
; Evolutions
	db EV_LEVEL, 10, BEEDRILL
	db 0
; Learnset
	db 0

BeedrillEvosMoves:
; Evolutions
	db EV_ITEM, MEGA_STONE_X, 1, MBEEDRILL
	db EV_ITEM, MEGA_STONE_Y, 1, MBEEDRILL
	db 0
; Learnset
	db 10, FURY_ATTACK
	db 13, FOCUS_ENERGY
	db 15, POISON_STING
	db 18, TWINEEDLE
	db 21, SWIFT
	db 24, PIN_MISSILE
	db 26, MEGA_DRAIN
	db 29, ROOST
	db 32, AGILITY
	db 34, INFESTATION
	db 36, AERIAL_ACE
	db 42, SLUDGE_WAVE
	db 45, SOLARBEAM
	db 0

MBeedrillEvosMoves:
; Evolutions
	db 0
; Learnset
	db 15, FURY_ATTACK
	db 18, FOCUS_ENERGY
	db 20, POISON_STING
	db 23, TWINEEDLE
	db 26, SWIFT
	db 29, PIN_MISSILE
	db 31, MEGA_DRAIN
	db 34, ROOST
	db 37, AGILITY
	db 39, INFESTATION
	db 40, STEEL_WING
	db 41, AERIAL_ACE
	db 42, X_SCISSOR
	db 47, SLUDGE_WAVE
	db 50, SOLARBEAM
	db 53, GUNK_SHOT
	db 0

PidgeyEvosMoves:
; Evolutions
	db EV_LEVEL, 18, PIDGEOTTO
	db 0
; Learnset
	db 5, SAND_ATTACK
	db 7, PECK
	db 9, GUST
	db 12, QUICK_ATTACK
	db 15, TWISTER
	db 17, WING_ATTACK
	db 19, SWIFT
	db 23, AGILITY
	db 28, ROOST
	db 32, STEEL_WING
	db 31, MIRROR_MOVE
	db 34, AERIAL_ACE
	db 37, AIR_SLASH
	db 40, AIR_CUTTER
	db 44, HURRICANE
	db 0

PidgeottoEvosMoves:
; Evolutions
	db EV_LEVEL, 36, PIDGEOT
	db 0
; Learnset
	db 5, SAND_ATTACK
	db 7, PECK
	db 9, GUST
	db 12, QUICK_ATTACK
	db 15, TWISTER
	db 19, WING_ATTACK
	db 23, SWIFT
	db 27, AGILITY
	db 32, ROOST
	db 36, STEEL_WING
	db 35, MIRROR_MOVE
	db 38, AERIAL_ACE
	db 41, AIR_SLASH
	db 44, AIR_CUTTER
	db 48, HURRICANE
	db 0

PidgeotEvosMoves:
; Evolutions
	db EV_ITEM, MEGA_STONE_X, 1, MPIDGEOT
	db EV_ITEM, MEGA_STONE_Y, 1, MPIDGEOT
	db 0
; Learnset
	db 5, SAND_ATTACK
	db 7, PECK
	db 9, GUST
	db 12, QUICK_ATTACK
	db 15, TWISTER
	db 19, WING_ATTACK
	db 23, SWIFT
	db 27, AGILITY
	db 32, ROOST
	db 36, STEEL_WING
	db 39, MIRROR_MOVE
	db 42, AERIAL_ACE
	db 45, AIR_SLASH
	db 48, AIR_CUTTER
	db 52, HURRICANE
	db 0

MPidgeotEvosMoves:
; Evolutions
	db 0
; Learnset
	db 10, SAND_ATTACK
	db 12, PECK
	db 14, GUST
	db 17, QUICK_ATTACK
	db 20, TWISTER
	db 24, WING_ATTACK
	db 28, SWIFT
	db 32, AGILITY
	db 37, ROOST
	db 39, HEAT_WAVE
	db 41, STEEL_WING
	db 43, THUNDER
	db 44, MIRROR_MOVE
	db 45, BLIZZARD
	db 47, AERIAL_ACE
	db 50, AIR_SLASH
	db 53, AIR_CUTTER
	db 57, HURRICANE
	db 0

RattataEvosMoves:
; Evolutions
	db EV_LEVEL, 20, RATICATE
	db 0
; Learnset
	db 4, QUICK_ATTACK
	db 7, FOCUS_ENERGY
	db 10, BITE
	db 12, DEFENSE_CURL
	db 14, HYPER_FANG
	db 16, TAKE_DOWN
	db 20, SUPER_FANG
	db 23, SCREECH
	db 26, SWIFT
	db 30, CRUNCH
	db 32, IRON_TAIL
	db 35, DOUBLE_EDGE
	db 39, SWORDS_DANCE
	db 43, HEADBUTT
	db 0

RaticateEvosMoves:
; Evolutions
	db 0
; Learnset
	db 4, QUICK_ATTACK
	db 7, FOCUS_ENERGY
	db 10, BITE
	db 12, DEFENSE_CURL
	db 14, HYPER_FANG
	db 16, TAKE_DOWN
	db 24, SUPER_FANG
	db 25, SCREECH
	db 29, SWIFT
	db 34, CRUNCH
	db 37, IRON_TAIL
	db 39, DOUBLE_EDGE
	db 43, SWORDS_DANCE
	db 47, HEADBUTT
	db 0

SpearowEvosMoves:
; Evolutions
	db EV_LEVEL, 20, FEAROW
	db 0
; Learnset
	db 4, LEER
	db 9, FURY_ATTACK
	db 14, WING_ATTACK
	db 18, AERIAL_ACE
	db 21, TAKE_DOWN
	db 23, MIRROR_MOVE
	db 25, AGILITY
	db 27, SWIFT
	db 29, FOCUS_ENERGY
	db 31, DRILL_PECK
	db 33, ROOST
	db 36, STEEL_WING
	db 0

FearowEvosMoves:
; Evolutions
	db 0
; Learnset
	db 4, LEER
	db 9, FURY_ATTACK
	db 14, WING_ATTACK
	db 18, AERIAL_ACE
	db 23, TAKE_DOWN
	db 25, MIRROR_MOVE
	db 27, AGILITY
	db 30, SWIFT
	db 32, FOCUS_ENERGY
	db 34, DRILL_PECK
	db 36, ROOST
	db 39, STEEL_WING
	db 0

EkansEvosMoves:
; Evolutions
	db EV_LEVEL, 22, ARBOK
	db 0
; Learnset
	db 4, POISON_STING
	db 9, BITE
	db 12, GLARE
	db 17, SCREECH
	db 20, ACID
	db 23, DISABLE
	db 24, CRUNCH
	db 26, SLUDGE
	db 28, HEADBUTT
	db 30, MEGA_DRAIN
	db 32, SLUDGE_WAVE
	db 34, SLAM
	db 36, IRON_TAIL
	db 39, TAKE_DOWN
	db 43, HAZE
	db 46, GUNK_SHOT
	db 0

ArbokEvosMoves:
; Evolutions
	db 0
; Learnset
	db 4, POISON_STING
	db 9, BITE
	db 12, GLARE
	db 17, SCREECH
	db 20, ACID
	db 24, DISABLE
	db 26, CRUNCH
	db 28, SLUDGE
	db 31, HEADBUTT
	db 33, MEGA_DRAIN
	db 35, SLUDGE_WAVE
	db 37, SLAM
	db 39, IRON_TAIL
	db 43, TAKE_DOWN
	db 47, HAZE
	db 52, GUNK_SHOT
	db 0

PichuEvosMoves:
; Evolutions
	db EV_LEVEL, 10, PIKACHU
	db 0
; Learnset
	db 10, THUNDER_WAVE
	db 11, LEER
	db 12, DOUBLE_TEAM
	db 13, DEFENSE_CURL
	db 14, QUICK_ATTACK
	db 15, FLY
	db 16, SURF
	db 17, DOUBLE_KICK
	db 18, SLAM
	db 19, AGILITY
	db 20, SWIFT
	db 21, MUD_SLAP
	db 22, SING
	db 23, THUNDERBOLT
	db 24, TAKE_DOWN
	db 25, THUNDERPUNCH
	db 26, HEADBUTT
	db 27, VOLT_TACKLE
	db 28, IRON_TAIL
	db 29, LIGHT_SCREEN
	db 30, SHOCK_WAVE
	db 31, PLAY_ROUGH
	db 32, THUNDER
	db 33, EXTREMESPEED
	db 34, SUBMISSION
	db 35, ZAP_CANNON
	db 36, PETAL_DANCE
	db 37, PSYCHIC_M
	db 0

PikachuEvosMoves:
; Evolutions
	db EV_ITEM, THUNDER_STONE, 1, RAICHU
	db 0
; Learnset
	db 6, THUNDER_WAVE
	db 7, LEER
	db 8, DOUBLE_TEAM
	db 9, DEFENSE_CURL
	db 11, QUICK_ATTACK
	db 12, FLY
	db 13, SURF
	db 14, DOUBLE_KICK
	db 17, SLAM
	db 19, AGILITY
	db 21, SWIFT
	db 23, MUD_SLAP
	db 25, SING
	db 27, THUNDERBOLT
	db 29, TAKE_DOWN
	db 31, THUNDERPUNCH
	db 34, HEADBUTT
	db 36, VOLT_TACKLE
	db 37, IRON_TAIL
	db 39, LIGHT_SCREEN
	db 41, SHOCK_WAVE
	db 44, PLAY_ROUGH
	db 47, THUNDER
	db 50, EXTREMESPEED
	db 55, SUBMISSION
	db 60, ZAP_CANNON
	db 81, PETAL_DANCE
	db 0

RaichuEvosMoves:
; Evolutions
	db 0
; Learnset
	db 11, THUNDER_WAVE
	db 12, LEER
	db 13, DOUBLE_TEAM
	db 14, DEFENSE_CURL
	db 16, QUICK_ATTACK
	db 18, SURF
	db 19, DOUBLE_KICK
	db 22, SLAM
	db 24, AGILITY
	db 26, SWIFT
	db 28, MUD_SLAP
	db 30, SING
	db 32, THUNDERBOLT
	db 34, TAKE_DOWN
	db 36, THUNDERPUNCH
	db 39, HEADBUTT
	db 41, VOLT_TACKLE
	db 42, IRON_TAIL
	db 44, LIGHT_SCREEN
	db 46, SHOCK_WAVE
	db 49, PLAY_ROUGH
	db 52, THUNDER
	db 55, EXTREMESPEED
	db 60, SUBMISSION
	db 65, ZAP_CANNON
	db 86, PETAL_DANCE
	db 0

SandshrewEvosMoves:
; Evolutions
	db EV_LEVEL, 22, SANDSLASH
	db 0
; Learnset
	db 10, SAND_ATTACK
	db 13, DEFENSE_CURL
	db 15, MUD_SLAP
	db 18, SLASH
	db 21, SWIFT
	db 23, AGILITY
	db 24, FURY_SWIPES
	db 25, POISON_STING
	db 27, ICE_PUNCH
	db 29, LEECH_LIFE
	db 32, HEADBUTT
	db 34, ROCK_TOMB
	db 37, DIG
	db 39, NIGHT_SLASH
	db 42, SHADOW_CLAW
	db 44, PIN_MISSILE
	db 46, SUPER_FANG
	db 48, SWORDS_DANCE
	db 50, SUBMISSION
	db 52, EARTHQUAKE
	db 0

SandslashEvosMoves:
; Evolutions
	db 0
; Learnset
	db 10, SAND_ATTACK
	db 13, DEFENSE_CURL
	db 15, MUD_SLAP
	db 18, SLASH
	db 21, SWIFT
	db 24, AGILITY
	db 26, FURY_SWIPES
	db 27, POISON_STING
	db 30, ICE_PUNCH
	db 33, LEECH_LIFE
	db 36, HEADBUTT
	db 39, ROCK_TOMB
	db 41, DIG
	db 43, NIGHT_SLASH
	db 45, SHADOW_CLAW
	db 47, PIN_MISSILE
	db 49, SUPER_FANG
	db 51, SWORDS_DANCE
	db 54, SUBMISSION
	db 59, EARTHQUAKE
	db 0

NidoranFEvosMoves:
; Evolutions
	db EV_LEVEL, 16, NIDORINA
	db 0
; Learnset
	db 7, LEER
	db 8, SCRATCH
	db 9, DEFENSE_CURL
	db 10, FURY_SWIPES
	db 12, DOUBLE_KICK
	db 15, POISON_STING
	db 17, MUD_SLAP
	db 18, SUPERSONIC
	db 20, BODY_SLAM
	db 22, BITE
	db 24, FOCUS_ENERGY
	db 25, MUD_SHOT
	db 27, HEADBUTT
	db 28, SUPER_FANG
	db 30, TAKE_DOWN
	db 31, TOXIC
	db 33, CRUNCH
	db 35, IRON_TAIL
	db 37, ROCK_TOMB
	db 39, SLUDGE_WAVE
	db 41, AERIAL_ACE
	db 0

NidorinaEvosMoves:
; Evolutions
	db EV_ITEM, MOON_STONE, 1, NIDOQUEEN
	db 0
; Learnset
	db 7, LEER
	db 8, SCRATCH
	db 9, DEFENSE_CURL
	db 10, FURY_SWIPES
	db 12, DOUBLE_KICK
	db 15, POISON_STING
	db 18, MUD_SLAP
	db 20, SUPERSONIC
	db 22, BODY_SLAM
	db 24, BITE
	db 26, FOCUS_ENERGY
	db 28, MUD_SHOT
	db 30, HEADBUTT
	db 32, SUPER_FANG
	db 34, TAKE_DOWN
	db 37, TOXIC
	db 39, CRUNCH
	db 41, IRON_TAIL
	db 43, ROCK_TOMB
	db 45, SLUDGE_WAVE
	db 47, AERIAL_ACE
	db 0

NidoqueenEvosMoves:
; Evolutions
	db 0
; Learnset
	db 7, LEER
	db 8, SCRATCH
	db 10, FURY_SWIPES
	db 12, DOUBLE_KICK
	db 15, POISON_STING
	db 18, MUD_SLAP
	db 20, SUPERSONIC
	db 22, BODY_SLAM
	db 24, BITE
	db 26, FOCUS_ENERGY
	db 28, MUD_SHOT
	db 30, HEADBUTT
	db 32, SUPER_FANG
	db 34, TAKE_DOWN
	db 36, SUPERPOWER
	db 37, FIRE_PUNCH
	db 38, THUNDERPUNCH
	db 39, ICE_PUNCH
	db 40, SHADOW_CLAW
	db 42, TOXIC
	db 44, CRUNCH
	db 46, IRON_TAIL
	db 48, ROCK_TOMB
	db 50, SLUDGE_WAVE
	db 52, SUBMISSION
	db 54, AERIAL_ACE
	db 56, LOVELY_KISS
	db 60, HORN_DRILL
	db 0

NidoranMEvosMoves:
; Evolutions
	db EV_LEVEL, 16, NIDORINO
	db 0
; Learnset
	db 7, GROWL
	db 8, SCRATCH
	db 9, DEFENSE_CURL
	db 10, FURY_SWIPES
	db 11, PECK
	db 12, DOUBLE_KICK
	db 13, HORN_ATTACK
	db 15, POISON_STING
	db 17, MUD_SLAP
	db 19, SUPERSONIC
	db 20, BODY_SLAM
	db 22, BITE
	db 24, FOCUS_ENERGY
	db 26, MUD_SHOT
	db 28, HEADBUTT
	db 30, SUPER_FANG
	db 32, TAKE_DOWN
	db 34, TOXIC
	db 36, CRUNCH
	db 38, IRON_TAIL
	db 40, ROCK_TOMB
	db 42, SLUDGE_WAVE
	db 44, AERIAL_ACE
	db 0

NidorinoEvosMoves:
; Evolutions
	db EV_ITEM, MOON_STONE, 1, NIDOKING
	db 0
; Learnset
	db 7, GROWL
	db 8, SCRATCH
	db 9, DEFENSE_CURL
	db 10, FURY_SWIPES
	db 11, PECK
	db 12, DOUBLE_KICK
	db 13, HORN_ATTACK
	db 15, POISON_STING
	db 18, MUD_SLAP
	db 20, SUPERSONIC
	db 22, BODY_SLAM
	db 24, BITE
	db 26, FOCUS_ENERGY
	db 28, MUD_SHOT
	db 30, HEADBUTT
	db 32, SUPER_FANG
	db 34, TAKE_DOWN
	db 37, TOXIC
	db 39, CRUNCH
	db 41, IRON_TAIL
	db 43, ROCK_TOMB
	db 45, SLUDGE_WAVE
	db 47, AERIAL_ACE
	db 0

NidokingEvosMoves:
; Evolutions
	db 0
; Learnset
	db 7, GROWL
	db 8, SCRATCH
	db 10, FURY_SWIPES
	db 12, DOUBLE_KICK
	db 13, HORN_ATTACK
	db 15, POISON_STING
	db 18, MUD_SLAP
	db 20, SUPERSONIC
	db 22, BODY_SLAM
	db 24, BITE
	db 26, FOCUS_ENERGY
	db 28, MUD_SHOT
	db 30, HEADBUTT
	db 32, SUPER_FANG
	db 34, TAKE_DOWN
	db 36, SUPERPOWER
	db 37, FIRE_PUNCH
	db 38, THUNDERPUNCH
	db 39, ICE_PUNCH
	db 40, SHADOW_CLAW
	db 41, THRASH
	db 42, TOXIC
	db 44, CRUNCH
	db 46, IRON_TAIL
	db 48, MEGAHORN
	db 50, ROCK_TOMB
	db 52, SLUDGE_WAVE
	db 54, SUBMISSION
	db 56, AERIAL_ACE
	db 58, LOVELY_KISS
	db 62, HORN_DRILL
	db 65, HEAD_SMASH
	db 0

CleffaEvosMoves:
; Evolutions
	db EV_LEVEL, 10, CLEFAIRY
	db 0
; Learnset
	db 10, MINIMIZE
	db 11, METRONOME
	db 12, SING
	db 13, TELEPORT
	db 14, MUD_SLAP
	db 15, DEFENSE_CURL
	db 16, SWIFT
	db 17, DRAIN_PUNCH
	db 18, IRON_TAIL
	db 19, MAGICAL_LEAF
	db 20, METEOR_MASH
	db 21, FLAMETHROWER
	db 22, MOONBLAST
	db 23, LIGHT_SCREEN
	db 24, ICE_PUNCH
	db 25, THUNDERPUNCH
	db 26, FIRE_PUNCH
	db 27, AMNESIA
	db 28, HEADBUTT
	db 29, ZEN_HEADBUTT
	db 30, DREAM_EATER
	db 31, PETAL_DANCE
	db 32, PLAY_ROUGH
	db 33, NIGHT_SLASH
	db 0

ClefairyEvosMoves:
; Evolutions
	db EV_ITEM, MOON_STONE, 1, CLEFABLE
	db 0
; Learnset
	db 8, MINIMIZE
	db 10, METRONOME
	db 12, SING
	db 14, TELEPORT
	db 16, MUD_SLAP
	db 19, DEFENSE_CURL
	db 22, SWIFT
	db 24, DRAIN_PUNCH
	db 27, IRON_TAIL
	db 29, MAGICAL_LEAF
	db 32, METEOR_MASH
	db 34, FLAMETHROWER
	db 36, MOONBLAST
	db 40, LIGHT_SCREEN
	db 42, ICE_PUNCH
	db 43, THUNDERPUNCH
	db 44, FIRE_PUNCH
	db 46, AMNESIA
	db 48, HEADBUTT
	db 49, ZEN_HEADBUTT
	db 51, DREAM_EATER
	db 54, PETAL_DANCE
	db 57, PLAY_ROUGH
	db 0

ClefableEvosMoves:
; Evolutions
	db 0
; Learnset
	db 8, MINIMIZE
	db 10, METRONOME
	db 12, SING
	db 14, TELEPORT
	db 16, MUD_SLAP
	db 19, DEFENSE_CURL
	db 22, SWIFT
	db 27, DRAIN_PUNCH
	db 30, IRON_TAIL
	db 32, MAGICAL_LEAF
	db 35, METEOR_MASH
	db 37, FLAMETHROWER
	db 39, MOONBLAST
	db 43, LIGHT_SCREEN
	db 45, ICE_PUNCH
	db 46, THUNDERPUNCH
	db 47, FIRE_PUNCH
	db 49, AMNESIA
	db 51, HEADBUTT
	db 52, ZEN_HEADBUTT
	db 54, DREAM_EATER
	db 57, PETAL_DANCE
	db 60, PLAY_ROUGH
	db 0

VulpixEvosMoves:
; Evolutions
	db EV_ITEM, FIRE_STONE, 1, NINETALES
	db 0
; Learnset
	db 16, QUICK_ATTACK
	db 28, CONFUSE_RAY
	db 35, FLAMETHROWER
	db 42, FIRE_SPIN
	db 0

NinetalesEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

JigglypuffEvosMoves:
; Evolutions
	db EV_ITEM, MOON_STONE, 1, WIGGLYTUFF
	db 0
; Learnset
	db 9, POUND
	db 14, DISABLE
	db 19, DEFENSE_CURL
	db 29, REST
	db 34, BODY_SLAM
	db 39, DOUBLE_EDGE
	db 0

WigglytuffEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

ZubatEvosMoves:
; Evolutions
	db EV_LEVEL, 22, GOLBAT
	db 0
; Learnset
	db 10, SUPERSONIC
	db 15, BITE
	db 21, CONFUSE_RAY
	db 28, WING_ATTACK
	db 36, HAZE
	db 0

GolbatEvosMoves:
; Evolutions
	db 0
; Learnset
	db 10, SUPERSONIC
	db 15, BITE
	db 21, CONFUSE_RAY
	db 32, WING_ATTACK
	db 43, HAZE
	db 0

OddishEvosMoves:
; Evolutions
	db EV_LEVEL, 21, GLOOM
	db 0
; Learnset
	db 15, POISONPOWDER
	db 17, STUN_SPORE
	db 19, SLEEP_POWDER
	db 24, ACID
	db 33, PETAL_DANCE
	db 46, SOLARBEAM
	db 0

GloomEvosMoves:
; Evolutions
	db EV_ITEM, LEAF_STONE, 1, VILEPLUME
	db 0
; Learnset
	db 15, POISONPOWDER
	db 17, STUN_SPORE
	db 19, SLEEP_POWDER
	db 28, ACID
	db 38, PETAL_DANCE
	db 52, SOLARBEAM
	db 0

VileplumeEvosMoves:
; Evolutions
	db 0
; Learnset
	db 15, POISONPOWDER
	db 17, STUN_SPORE
	db 19, SLEEP_POWDER
	db 0

ParasEvosMoves:
; Evolutions
	db EV_LEVEL, 24, PARASECT
	db 0
; Learnset
	db 13, STUN_SPORE
	db 20, LEECH_LIFE
	db 27, SPORE
	db 34, SLASH
	db 41, GROWTH
	db 0

ParasectEvosMoves:
; Evolutions
	db 0
; Learnset
	db 13, STUN_SPORE
	db 20, LEECH_LIFE
	db 30, SPORE
	db 39, SLASH
	db 48, GROWTH
	db 0

VenonatEvosMoves:
; Evolutions
	db EV_LEVEL, 31, VENOMOTH
	db 0
; Learnset
	db 11, SUPERSONIC
	db 19, CONFUSION
	db 22, POISONPOWDER
	db 27, LEECH_LIFE
	db 30, STUN_SPORE
	db 35, PSYBEAM
	db 38, SLEEP_POWDER
	db 43, PSYCHIC_M
	db 0

VenomothEvosMoves:
; Evolutions
	db 0
; Learnset
	db 22, POISONPOWDER
	db 27, LEECH_LIFE
	db 30, STUN_SPORE
	db 38, PSYBEAM
	db 43, SLEEP_POWDER
	db 50, PSYCHIC_M
	db 0

DiglettEvosMoves:
; Evolutions
	db EV_LEVEL, 26, DUGTRIO
	db 0
; Learnset
	db 15, GROWL
	db 19, DIG
	db 24, SAND_ATTACK
	db 31, SLASH
	db 40, EARTHQUAKE
	db 0

DugtrioEvosMoves:
; Evolutions
	db 0
; Learnset
	db 15, GROWL
	db 19, DIG
	db 24, SAND_ATTACK
	db 35, SLASH
	db 47, EARTHQUAKE
	db 0

MeowthEvosMoves:
; Evolutions
	db EV_LEVEL, 28, PERSIAN
	db 0
; Learnset
	db 12, BITE
	db 17, PAY_DAY
	db 24, SCREECH
	db 33, FURY_SWIPES
	db 44, SLASH
	db 0

PersianEvosMoves:
; Evolutions
	db 0
; Learnset
	db 12, BITE
	db 17, PAY_DAY
	db 24, SCREECH
	db 37, FURY_SWIPES
	db 51, SLASH
	db 0

PsyduckEvosMoves:
; Evolutions
	db EV_LEVEL, 33, GOLDUCK
	db 0
; Learnset
	db 31, DISABLE
	db 36, CONFUSION
	db 43, FURY_SWIPES
	db 52, HYDRO_PUMP
	db 0

GolduckEvosMoves:
; Evolutions
	db 0
; Learnset
	db 31, DISABLE
	db 39, CONFUSION
	db 48, FURY_SWIPES
	db 59, HYDRO_PUMP
	db 0

MankeyEvosMoves:
; Evolutions
	db EV_LEVEL, 28, PRIMEAPE
	db 0
; Learnset
	db 9, LOW_KICK
	db 15, KARATE_CHOP
	db 21, FURY_SWIPES
	db 27, FOCUS_ENERGY
	db 33, SEISMIC_TOSS
	db 39, THRASH
	db 45, SCREECH
	db 0

PrimeapeEvosMoves:
; Evolutions
	db 0
; Learnset
	db 9, LOW_KICK
	db 15, KARATE_CHOP
	db 21, FURY_SWIPES
	db 27, FOCUS_ENERGY
	db 37, SEISMIC_TOSS
	db 46, THRASH
	db 45, SCREECH
	db 0

GrowlitheEvosMoves:
; Evolutions
	db EV_ITEM, FIRE_STONE, 1, ARCANINE
	db 0
; Learnset
	db 18, EMBER
	db 23, LEER
	db 30, TAKE_DOWN
	db 39, AGILITY
	db 50, FLAMETHROWER
	db 0

ArcanineEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

PoliwagEvosMoves:
; Evolutions
	db EV_LEVEL, 25, POLIWHIRL
	db 0
; Learnset
	db 16, HYPNOSIS
	db 19, WATER_GUN
	db 31, BODY_SLAM
	db 38, AMNESIA
	db 45, HYDRO_PUMP
	db 0

PoliwhirlEvosMoves:
; Evolutions
	db EV_ITEM, WATER_STONE, 1, POLIWRATH
	db 0
; Learnset
	db 16, HYPNOSIS
	db 19, WATER_GUN
	db 33, BODY_SLAM
	db 41, AMNESIA
	db 49, HYDRO_PUMP
	db 0

PoliwrathEvosMoves:
; Evolutions
	db 0
; Learnset
	db 16, HYPNOSIS
	db 19, WATER_GUN
	db 0

AbraEvosMoves:
; Evolutions
	db EV_LEVEL, 16, KADABRA
	db 0
; Learnset
	db 0

KadabraEvosMoves:
; Evolutions
	db EV_TRADE, 1, ALAKAZAM
	db 0
; Learnset
	db 16, CONFUSION
	db 20, DISABLE
	db 27, PSYBEAM
	db 31, RECOVER
	db 38, PSYCHIC_M
	db 42, REFLECT
	db 0

AlakazamEvosMoves:
; Evolutions
	db 0
; Learnset
	db 16, CONFUSION
	db 20, DISABLE
	db 27, PSYBEAM
	db 31, RECOVER
	db 38, PSYCHIC_M
	db 42, REFLECT
	db 0

MachopEvosMoves:
; Evolutions
	db EV_LEVEL, 28, MACHOKE
	db 0
; Learnset
	db 20, LOW_KICK
	db 25, LEER
	db 32, FOCUS_ENERGY
	db 39, SEISMIC_TOSS
	db 46, SUBMISSION
	db 0

MachokeEvosMoves:
; Evolutions
	db EV_TRADE, 1, MACHAMP
	db 0
; Learnset
	db 20, LOW_KICK
	db 25, LEER
	db 36, FOCUS_ENERGY
	db 44, SEISMIC_TOSS
	db 52, SUBMISSION
	db 0

MachampEvosMoves:
; Evolutions
	db 0
; Learnset
	db 20, LOW_KICK
	db 25, LEER
	db 36, FOCUS_ENERGY
	db 44, SEISMIC_TOSS
	db 52, SUBMISSION
	db 0

BellsproutEvosMoves:
; Evolutions
	db EV_LEVEL, 21, WEEPINBELL
	db 0
; Learnset
	db 13, WRAP
	db 15, POISONPOWDER
	db 18, SLEEP_POWDER
	db 21, STUN_SPORE
	db 26, ACID
	db 33, RAZOR_LEAF
	db 42, SLAM
	db 0

WeepinbellEvosMoves:
; Evolutions
	db EV_ITEM, LEAF_STONE, 1, VICTREEBEL
	db 0
; Learnset
	db 13, WRAP
	db 15, POISONPOWDER
	db 18, SLEEP_POWDER
	db 23, STUN_SPORE
	db 29, ACID
	db 38, RAZOR_LEAF
	db 49, SLAM
	db 0

VictreebelEvosMoves:
; Evolutions
	db 0
; Learnset
	db 13, WRAP
	db 15, POISONPOWDER
	db 18, SLEEP_POWDER
	db 0

TentacoolEvosMoves:
; Evolutions
	db EV_LEVEL, 30, TENTACRUEL
	db 0
; Learnset
	db 7, SUPERSONIC
	db 13, WRAP
	db 18, POISON_STING
	db 22, WATER_GUN
	db 33, BARRIER
	db 40, SCREECH
	db 48, HYDRO_PUMP
	db 0

TentacruelEvosMoves:
; Evolutions
	db 0
; Learnset
	db 7, SUPERSONIC
	db 13, WRAP
	db 18, POISON_STING
	db 22, WATER_GUN
	db 35, BARRIER
	db 43, SCREECH
	db 50, HYDRO_PUMP
	db 0

GeodudeEvosMoves:
; Evolutions
	db EV_LEVEL, 25, GRAVELER
	db 0
; Learnset
	db 11, DEFENSE_CURL
	db 16, ROCK_THROW
	db 21, SELFDESTRUCT
	db 26, HARDEN
	db 31, EARTHQUAKE
	db 36, EXPLOSION
	db 0

GravelerEvosMoves:
; Evolutions
	db EV_TRADE, 1, GOLEM
	db 0
; Learnset
	db 11, DEFENSE_CURL
	db 16, ROCK_THROW
	db 21, SELFDESTRUCT
	db 29, HARDEN
	db 36, EARTHQUAKE
	db 43, EXPLOSION
	db 0

GolemEvosMoves:
; Evolutions
	db 0
; Learnset
	db 11, DEFENSE_CURL
	db 16, ROCK_THROW
	db 21, SELFDESTRUCT
	db 29, HARDEN
	db 36, EARTHQUAKE
	db 43, EXPLOSION
	db 0

PonytaEvosMoves:
; Evolutions
	db EV_LEVEL, 40, RAPIDASH
	db 0
; Learnset
	db 32, STOMP
	db 35, GROWL
	db 39, FIRE_SPIN
	db 43, TAKE_DOWN
	db 48, AGILITY
	db 0

RapidashEvosMoves:
; Evolutions
	db 0
; Learnset
	db 32, STOMP
	db 35, GROWL
	db 39, FIRE_SPIN
	db 47, TAKE_DOWN
	db 55, AGILITY
	db 0

SlowpokeEvosMoves:
; Evolutions
	db EV_LEVEL, 37, SLOWBRO
	db 0
; Learnset
	db 18, DISABLE
	db 22, HEADBUTT
	db 27, GROWL
	db 33, WATER_GUN
	db 40, AMNESIA
	db 48, PSYCHIC_M
	db 0

SlowbroEvosMoves:
; Evolutions
	db 0
; Learnset
	db 18, DISABLE
	db 22, HEADBUTT
	db 27, GROWL
	db 33, WATER_GUN
	db 37, DEFENSE_CURL
	db 44, AMNESIA
	db 55, PSYCHIC_M
	db 0

MagnemiteEvosMoves:
; Evolutions
	db EV_LEVEL, 30, MAGNETON
	db 0
; Learnset
	db 21, SONICBOOM
	db 25, THUNDERSHOCK
	db 29, SUPERSONIC
	db 35, THUNDER_WAVE
	db 41, SWIFT
	db 47, SCREECH
	db 0

MagnetonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 21, SONICBOOM
	db 25, THUNDERSHOCK
	db 29, SUPERSONIC
	db 38, THUNDER_WAVE
	db 46, SWIFT
	db 54, SCREECH
	db 0

FarfetchdEvosMoves:
; Evolutions
	db 0
; Learnset
	db 7, LEER
	db 15, FURY_ATTACK
	db 23, SWORDS_DANCE
	db 31, AGILITY
	db 39, SLASH
	db 0

DoduoEvosMoves:
; Evolutions
	db EV_LEVEL, 31, DODRIO
	db 0
; Learnset
	db 20, GROWL
	db 24, FURY_ATTACK
	db 30, DRILL_PECK
	db 44, AGILITY
	db 0

DodrioEvosMoves:
; Evolutions
	db 0
; Learnset
	db 20, GROWL
	db 24, FURY_ATTACK
	db 30, DRILL_PECK
	db 51, AGILITY
	db 0

SeelEvosMoves:
; Evolutions
	db EV_LEVEL, 34, DEWGONG
	db 0
; Learnset
	db 30, GROWL
	db 35, AURORA_BEAM
	db 40, REST
	db 45, TAKE_DOWN
	db 50, ICE_BEAM
	db 0

DewgongEvosMoves:
; Evolutions
	db 0
; Learnset
	db 30, GROWL
	db 35, AURORA_BEAM
	db 44, REST
	db 50, TAKE_DOWN
	db 56, ICE_BEAM
	db 0

GrimerEvosMoves:
; Evolutions
	db EV_LEVEL, 38, MUK
	db 0
; Learnset
	db 30, POISON_GAS
	db 33, MINIMIZE
	db 37, SLUDGE
	db 42, HARDEN
	db 48, SCREECH
	db 55, ACID_ARMOR
	db 0

MukEvosMoves:
; Evolutions
	db 0
; Learnset
	db 30, POISON_GAS
	db 33, MINIMIZE
	db 37, SLUDGE
	db 45, HARDEN
	db 53, SCREECH
	db 60, ACID_ARMOR
	db 0

ShellderEvosMoves:
; Evolutions
	db EV_ITEM, WATER_STONE, 1, CLOYSTER
	db 0
; Learnset
	db 18, SUPERSONIC
	db 23, CLAMP
	db 30, AURORA_BEAM
	db 39, LEER
	db 50, ICE_BEAM
	db 0

CloysterEvosMoves:
; Evolutions
	db 0
; Learnset
	db 50, SPIKE_CANNON
	db 0

GastlyEvosMoves:
; Evolutions
	db EV_LEVEL, 25, HAUNTER
	db 0
; Learnset
	db 27, HYPNOSIS
	db 35, DREAM_EATER
	db 0

HaunterEvosMoves:
; Evolutions
	db EV_TRADE, 1, GENGAR
	db 0
; Learnset
	db 29, HYPNOSIS
	db 38, DREAM_EATER
	db 0

GengarEvosMoves:
; Evolutions
	db 0
; Learnset
	db 29, HYPNOSIS
	db 38, DREAM_EATER
	db 0

OnixEvosMoves:
; Evolutions
	db 0
; Learnset
	db 15, BIND
	db 19, ROCK_THROW
	db 33, SLAM
	db 43, HARDEN
	db 0

DrowzeeEvosMoves:
; Evolutions
	db EV_LEVEL, 26, HYPNO
	db 0
; Learnset
	db 12, DISABLE
	db 17, CONFUSION
	db 24, HEADBUTT
	db 29, POISON_GAS
	db 32, PSYCHIC_M
	db 37, MEDITATE
	db 0

HypnoEvosMoves:
; Evolutions
	db 0
; Learnset
	db 12, DISABLE
	db 17, CONFUSION
	db 24, HEADBUTT
	db 33, POISON_GAS
	db 37, PSYCHIC_M
	db 43, MEDITATE
	db 0

KrabbyEvosMoves:
; Evolutions
	db EV_LEVEL, 28, KINGLER
	db 0
; Learnset
	db 25, GUILLOTINE
	db 30, STOMP
	db 35, CRABHAMMER
	db 40, HARDEN
	db 0

KinglerEvosMoves:
; Evolutions
	db 0
; Learnset
	db 25, GUILLOTINE
	db 34, STOMP
	db 42, CRABHAMMER
	db 49, HARDEN
	db 0

VoltorbEvosMoves:
; Evolutions
	db EV_LEVEL, 30, ELECTRODE
	db 0
; Learnset
	db 17, SONICBOOM
	db 22, SELFDESTRUCT
	db 29, LIGHT_SCREEN
	db 36, SWIFT
	db 43, EXPLOSION
	db 0

ElectrodeEvosMoves:
; Evolutions
	db 0
; Learnset
	db 17, SONICBOOM
	db 22, SELFDESTRUCT
	db 29, LIGHT_SCREEN
	db 40, SWIFT
	db 50, EXPLOSION
	db 0

ExeggcuteEvosMoves:
; Evolutions
	db EV_ITEM, LEAF_STONE, 1, EXEGGUTOR
	db 0
; Learnset
	db 25, REFLECT
	db 28, LEECH_SEED
	db 32, STUN_SPORE
	db 37, POISONPOWDER
	db 42, SOLARBEAM
	db 48, SLEEP_POWDER
	db 0

ExeggutorEvosMoves:
; Evolutions
	db 0
; Learnset
	db 28, STOMP
	db 0

CuboneEvosMoves:
; Evolutions
	db EV_LEVEL, 28, MAROWAK
	db 0
; Learnset
	db 10, BONE_CLUB
	db 18, HEADBUTT
	db 25, LEER
	db 31, FOCUS_ENERGY
	db 38, THRASH
	db 43, BONEMERANG
	db 0

MarowakEvosMoves:
; Evolutions
	db 0
; Learnset
	db 10, BONE_CLUB
	db 18, HEADBUTT
	db 25, LEER
	db 33, FOCUS_ENERGY
	db 41, THRASH
	db 48, BONEMERANG
	db 0

HitmonleeEvosMoves:
; Evolutions
	db 0
; Learnset
	db 33, ROLLING_KICK
	db 38, JUMP_KICK
	db 43, FOCUS_ENERGY
	db 48, HI_JUMP_KICK
	db 53, SPLASH
	db 0

HitmonchanEvosMoves:
; Evolutions
	db 0
; Learnset
	db 33, FIRE_PUNCH
	db 38, ICE_PUNCH
	db 43, THUNDERPUNCH
	db 48, MEGA_PUNCH
	db 53, COUNTER
	db 0

LickitungEvosMoves:
; Evolutions
	db 0
; Learnset
	db 7, STOMP
	db 15, DISABLE
	db 23, DEFENSE_CURL
	db 31, SLAM
	db 39, SCREECH
	db 0

KoffingEvosMoves:
; Evolutions
	db EV_LEVEL, 35, WEEZING
	db 0
; Learnset
	db 32, SLUDGE
	db 37, SMOKESCREEN
	db 40, SELFDESTRUCT
	db 45, HAZE
	db 48, EXPLOSION
	db 0

WeezingEvosMoves:
; Evolutions
	db 0
; Learnset
	db 32, SLUDGE
	db 39, SMOKESCREEN
	db 43, SELFDESTRUCT
	db 49, HAZE
	db 53, EXPLOSION
	db 0

RhyhornEvosMoves:
; Evolutions
	db EV_LEVEL, 42, RHYDON
	db 0
; Learnset
	db 30, STOMP
	db 40, FURY_ATTACK
	db 45, HORN_DRILL
	db 50, LEER
	db 55, TAKE_DOWN
	db 0

RhydonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 30, STOMP
	db 40, FURY_ATTACK
	db 48, HORN_DRILL
	db 55, LEER
	db 64, TAKE_DOWN
	db 0

ChanseyEvosMoves:
; Evolutions
	db 0
; Learnset
	db 24, SING
	db 30, GROWL
	db 38, MINIMIZE
	db 44, DEFENSE_CURL
	db 48, LIGHT_SCREEN
	db 54, DOUBLE_EDGE
	db 0

TangelaEvosMoves:
; Evolutions
	db 0
; Learnset
	db 24, BIND
	db 27, ABSORB
	db 29, VINE_WHIP
	db 32, POISONPOWDER
	db 36, STUN_SPORE
	db 39, SLEEP_POWDER
	db 45, SLAM
	db 48, GROWTH
	db 0

KangaskhanEvosMoves:
; Evolutions
	db 0
; Learnset
	db 26, BITE
	db 36, MEGA_PUNCH
	db 41, LEER
	db 46, DIZZY_PUNCH
	db 0

HorseaEvosMoves:
; Evolutions
	db EV_LEVEL, 32, SEADRA
	db 0
; Learnset
	db 19, SMOKESCREEN
	db 24, LEER
	db 30, WATER_GUN
	db 37, AGILITY
	db 45, HYDRO_PUMP
	db 0

SeadraEvosMoves:
; Evolutions
	db 0
; Learnset
	db 19, SMOKESCREEN
	db 24, LEER
	db 30, WATER_GUN
	db 41, AGILITY
	db 52, HYDRO_PUMP
	db 0

GoldeenEvosMoves:
; Evolutions
	db EV_LEVEL, 33, SEAKING
	db 0
; Learnset
	db 19, SUPERSONIC
	db 24, HORN_ATTACK
	db 30, FURY_ATTACK
	db 37, WATERFALL
	db 45, HORN_DRILL
	db 54, AGILITY
	db 0

SeakingEvosMoves:
; Evolutions
	db 0
; Learnset
	db 19, SUPERSONIC
	db 24, HORN_ATTACK
	db 30, FURY_ATTACK
	db 39, WATERFALL
	db 48, HORN_DRILL
	db 54, AGILITY
	db 0

StaryuEvosMoves:
; Evolutions
	db EV_ITEM, WATER_STONE, 1, STARMIE
	db 0
; Learnset
	db 17, WATER_GUN
	db 22, HARDEN
	db 27, RECOVER
	db 32, SWIFT
	db 37, MINIMIZE
	db 42, LIGHT_SCREEN
	db 47, HYDRO_PUMP
	db 0

StarmieEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MrMimeEvosMoves:
; Evolutions
	db 0
; Learnset
	db 15, CONFUSION
	db 23, LIGHT_SCREEN
	db 39, MEDITATE
	db 47, SUBSTITUTE
	db 0

ScytherEvosMoves:
; Evolutions
	db 0
; Learnset
	db 17, LEER
	db 20, FOCUS_ENERGY
	db 24, DOUBLE_TEAM
	db 29, SLASH
	db 35, SWORDS_DANCE
	db 42, AGILITY
	db 50, WING_ATTACK
	db 0

JynxEvosMoves:
; Evolutions
	db 0
; Learnset
	db 18, LICK
	db 31, ICE_PUNCH
	db 39, BODY_SLAM
	db 47, THRASH
	db 58, BLIZZARD
	db 0

ElectabuzzEvosMoves:
; Evolutions
	db 0
; Learnset
	db 34, THUNDERSHOCK
	db 37, SCREECH
	db 42, THUNDERPUNCH
	db 49, LIGHT_SCREEN
	db 54, THUNDER
	db 0

MagmarEvosMoves:
; Evolutions
	db 0
; Learnset
	db 36, LEER
	db 39, CONFUSE_RAY
	db 43, FIRE_PUNCH
	db 48, SMOKESCREEN
	db 52, SMOG
	db 55, FLAMETHROWER
	db 0

PinsirEvosMoves:
; Evolutions
	db 0
; Learnset
	db 21, BIND
	db 25, SEISMIC_TOSS
	db 30, GUILLOTINE
	db 36, FOCUS_ENERGY
	db 43, HARDEN
	db 49, SLASH
	db 54, SWORDS_DANCE
	db 0

TaurosEvosMoves:
; Evolutions
	db 0
; Learnset
	db 21, STOMP
	db 35, LEER
	db 51, TAKE_DOWN
	db 0

MagikarpEvosMoves:
; Evolutions
	db EV_LEVEL, 20, GYARADOS
	db 0
; Learnset
	db 15, TACKLE
	db 100, ANCESTOR_PWR
	db 0

GyaradosEvosMoves:
; Evolutions
	db 0
; Learnset
	db 20, BITE
	db 25, DRAGON_RAGE
	db 32, LEER
	db 41, HYDRO_PUMP
	db 52, HYPER_BEAM
	db 0

LaprasEvosMoves:
; Evolutions
	db 0
; Learnset
	db 16, SING
	db 20, MIST
	db 25, BODY_SLAM
	db 31, CONFUSE_RAY
	db 38, ICE_BEAM
	db 46, HYDRO_PUMP
	db 0

DittoEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

EeveeEvosMoves:
; Evolutions
	db EV_ITEM, FIRE_STONE, 1, FLAREON
	db EV_ITEM, THUNDER_STONE, 1, JOLTEON
	db EV_ITEM, WATER_STONE, 1, VAPOREON
	db 0
; Learnset
	db 8, SAND_ATTACK
	db 16, GROWL
	db 23, QUICK_ATTACK
	db 30, BITE
	db 36, FOCUS_ENERGY
	db 42, TAKE_DOWN
	db 0

VaporeonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 8, SAND_ATTACK
	db 16, WATER_GUN
	db 23, QUICK_ATTACK
	db 30, BITE
	db 36, AURORA_BEAM
	db 42, HAZE
	db 42, MIST
	db 47, ACID_ARMOR
	db 52, HYDRO_PUMP
	db 0

JolteonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 8, SAND_ATTACK
	db 16, THUNDERSHOCK
	db 23, QUICK_ATTACK
	db 30, DOUBLE_KICK
	db 36, PIN_MISSILE
	db 42, THUNDER_WAVE
	db 47, AGILITY
	db 52, THUNDER
	db 0

FlareonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 8, SAND_ATTACK
	db 16, EMBER
	db 23, QUICK_ATTACK
	db 30, BITE
	db 36, FIRE_SPIN
	db 42, SMOG
	db 47, LEER
	db 52, FLAMETHROWER
	db 0

PorygonEvosMoves:
; Evolutions
	db 0
; Learnset
	db 23, PSYBEAM
	db 31, RECOVER
	db 34, AGILITY
	db 38, TRI_ATTACK
	db 40, SHOCK_WAVE
	db 44, ZAP_CANNON
	db 0

OmanyteEvosMoves:
; Evolutions
	db EV_LEVEL, 40, OMASTAR
	db 0
; Learnset
	db 34, HORN_ATTACK
	db 39, LEER
	db 46, SPIKE_CANNON
	db 53, HYDRO_PUMP
	db 0

OmastarEvosMoves:
; Evolutions
	db 0
; Learnset
	db 34, HORN_ATTACK
	db 39, LEER
	db 44, SPIKE_CANNON
	db 49, HYDRO_PUMP
	db 0

KabutoEvosMoves:
; Evolutions
	db EV_LEVEL, 40, KABUTOPS
	db 0
; Learnset
	db 34, ABSORB
	db 39, SLASH
	db 44, LEER
	db 49, HYDRO_PUMP
	db 0

KabutopsEvosMoves:
; Evolutions
	db 0
; Learnset
	db 34, ABSORB
	db 39, SLASH
	db 46, LEER
	db 53, HYDRO_PUMP
	db 0

AerodactylEvosMoves:
; Evolutions
	db 0
; Learnset
	db 33, SUPERSONIC
	db 38, BITE
	db 45, TAKE_DOWN
	db 54, HYPER_BEAM
	db 0

SnorlaxEvosMoves:
; Evolutions
	db 0
; Learnset
	db 35, BODY_SLAM
	db 41, HARDEN
	db 48, DOUBLE_EDGE
	db 56, HYPER_BEAM
	db 0

ArticunoEvosMoves:
; Evolutions
	db 0
; Learnset
	db 51, BLIZZARD
	db 55, AGILITY
	db 60, MIST
	db 0

ZapdosEvosMoves:
; Evolutions
	db 0
; Learnset
	db 51, THUNDER
	db 55, AGILITY
	db 60, LIGHT_SCREEN
	db 0

MoltresEvosMoves:
; Evolutions
	db 0
; Learnset
	db 51, LEER
	db 55, AGILITY
	db 60, DRILL_PECK
	db 0

DratiniEvosMoves:
; Evolutions
	db EV_LEVEL, 30, DRAGONAIR
	db 0
; Learnset
	db 10, THUNDER_WAVE
	db 20, AGILITY
	db 30, SLAM
	db 40, DRAGON_RAGE
	db 50, HYPER_BEAM
	db 0

DragonairEvosMoves:
; Evolutions
	db EV_LEVEL, 55, DRAGONITE
	db 0
; Learnset
	db 10, THUNDER_WAVE
	db 20, AGILITY
	db 35, SLAM
	db 45, DRAGON_RAGE
	db 55, HYPER_BEAM
	db 0

DragoniteEvosMoves:
; Evolutions
	db 0
; Learnset
	db 10, THUNDER_WAVE
	db 20, AGILITY
	db 35, SLAM
	db 45, DRAGON_RAGE
	db 60, HYPER_BEAM
	db 0

MewtwoEvosMoves:
; Evolutions
	db 0
; Learnset
	db 63, BARRIER
	db 66, PSYCHIC_M
	db 70, RECOVER
	db 75, MIST
	db 81, AMNESIA
	db 0

MewEvosMoves:
; Evolutions
	db 0
; Learnset
	db 10, TRANSFORM
	db 20, MEGA_PUNCH
	db 30, METRONOME
	db 40, PSYCHIC_M
	db 0

ArceusEvosMoves:
; Evolutions
	db 0
; Learnset
	db 10, MIST
	db 20, EARTHQUAKE
	db 30, SONICBOOM
	db 40, QUICK_ATTACK
	db 50, REST
	db 60, FLY
	db 70, RECOVER
	db 80, HYPER_BEAM
	db 90, EXPLOSION
	db 100, SPLASH
	db 0

FossilKabutopsEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

FossilAerodactylEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0

MonGhostEvosMoves:
; Evolutions
	db 0
; Learnset
	db 0
