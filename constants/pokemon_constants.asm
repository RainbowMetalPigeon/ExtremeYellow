; pokemon ids
; indexes for:
; - MonsterNames (see data/pokemon/names.asm)
; - EvosMovesPointerTable (see data/pokemon/evos_moves.asm)
; - CryData (see data/pokemon/cries.asm)
; - PokedexOrder (see data/pokemon/dex_order.asm)
; - PokedexEntryPointers (see data/pokemon/dex_entries.asm)
	const_def
	const NO_MON             ; $00
	const BULBASAUR          ; 1
	const IVYSAUR            ; 2
	const VENUSAUR           ; 3
	const MVENUSAUR          ; 4
	const CHARMANDER         ; 5
	const CHARMELEON         ; 6
	const CHARIZARD          ; 7
	const MCHARZARDX         ; 8
	const MCHARZARDY         ; 9
	const SQUIRTLE           ; 10
	const WARTORTLE          ; 11
	const BLASTOISE          ; 12
	const MBLASTOISE         ; 13
	const CATERPIE           ; 14
	const METAPOD            ; 15
	const BUTTERFREE         ; 16
	const WEEDLE             ; 17
	const KAKUNA             ; 18
	const BEEDRILL           ; 19
	const MBEEDRILL          ; 20
	const PIDGEY             ; 21
	const PIDGEOTTO          ; 22
	const PIDGEOT            ; 23
	const MPIDGEOT           ; 24
	const RATTATA            ; 25
	const RATICATE           ; 26
	const SPEAROW            ; 27
	const FEAROW             ; 28
	const EKANS              ; 29
	const ARBOK              ; 30
	const PICHU              ; 31
	const PIKACHU            ; 32
	const RAICHU             ; 33
	const SANDSHREW          ; 34
	const SANDSLASH          ; 35
	const NIDORAN_F          ; 36
	const NIDORINA           ; 37
	const NIDOQUEEN          ; 38
	const NIDORAN_M          ; 39
	const NIDORINO           ; 40
	const NIDOKING           ; 41
	const CLEFFA             ; 42
	const CLEFAIRY           ; 43
	const CLEFABLE           ; 44
	const VULPIX             ; 45
	const NINETALES          ; 46
	const JIGGLYPUFF         ; 47
	const WIGGLYTUFF         ; 48
	const ZUBAT              ; 49
	const GOLBAT             ; 50
	const ODDISH             ; 51
	const GLOOM              ; 52
	const VILEPLUME          ; 53
	const PARAS              ; 54
	const PARASECT           ; 55
	const VENONAT            ; 56
	const VENOMOTH           ; 57
	const DIGLETT            ; 58
	const DUGTRIO            ; 59
	const MEOWTH             ; 60
	const PERSIAN            ; 61
	const PSYDUCK            ; 62
	const GOLDUCK            ; 63
	const MANKEY             ; 64
	const PRIMEAPE           ; 65
	const GROWLITHE          ; 66
	const ARCANINE           ; 67
	const POLIWAG            ; 68
	const POLIWHIRL          ; 69
	const POLIWRATH          ; 70
	const ABRA               ; 71
	const KADABRA            ; 72
	const ALAKAZAM           ; 73
	const MACHOP             ; 74
	const MACHOKE            ; 75
	const MACHAMP            ; 76
	const BELLSPROUT         ; 77
	const WEEPINBELL         ; 78
	const VICTREEBEL         ; 79
	const TENTACOOL          ; 80
	const TENTACRUEL         ; 81
	const GEODUDE            ; 82
	const GRAVELER           ; 83
	const GOLEM              ; 84
	const PONYTA             ; 85
	const RAPIDASH           ; 86
	const SLOWPOKE           ; 87
	const SLOWBRO            ; 88
	const MAGNEMITE          ; 89
	const MAGNETON           ; 90
	const FARFETCHD          ; 91
	const DODUO              ; 92
	const DODRIO             ; 93
	const SEEL               ; 94
	const DEWGONG            ; 95
	const GRIMER             ; 96
	const MUK                ; 97
	const SHELLDER           ; 98
	const CLOYSTER           ; 99
	const GASTLY             ; 100
	const HAUNTER            ; 101
	const GENGAR             ; 102
	const ONIX               ; 103
	const DROWZEE            ; 104
	const HYPNO              ; 105
	const KRABBY             ; 106
	const KINGLER            ; 107
	const VOLTORB            ; 108
	const ELECTRODE          ; 109
	const EXEGGCUTE          ; 110
	const EXEGGUTOR          ; 111
	const CUBONE             ; 112
	const MAROWAK            ; 113
	const HITMONLEE          ; 114
	const HITMONCHAN         ; 115
	const LICKITUNG          ; 116
	const KOFFING            ; 117
	const WEEZING            ; 118
	const RHYHORN            ; 119
	const RHYDON             ; 120
	const CHANSEY            ; 121
	const TANGELA            ; 122
	const KANGASKHAN         ; 123
	const HORSEA             ; 124
	const SEADRA             ; 125
	const GOLDEEN            ; 126
	const SEAKING            ; 127
	const STARYU             ; 128
	const STARMIE            ; 129
	const MR_MIME            ; 130
	const SCYTHER            ; 131
	const JYNX               ; 132
	const ELECTABUZZ         ; 133
	const MAGMAR             ; 134
	const PINSIR             ; 135
	const TAUROS             ; 136
	const MAGIKARP           ; 137
	const GYARADOS           ; 138
	const LAPRAS             ; 139
	const DITTO              ; 140
	const EEVEE              ; 141
	const VAPOREON           ; 142
	const JOLTEON            ; 143
	const FLAREON            ; 144
	const PORYGON            ; 145
	const OMANYTE            ; 146
	const OMASTAR            ; 147
	const KABUTO             ; 148
	const KABUTOPS           ; 149
	const AERODACTYL         ; 150
	const SNORLAX            ; 151
	const ARTICUNO           ; 152
	const ZAPDOS             ; 153
	const MOLTRES            ; 154
	const DRATINI            ; 155
	const DRAGONAIR          ; 156
	const DRAGONITE          ; 157
	const MEWTWO             ; 158
	const MEW                ; 159
	const ARCEUS             ; 160
	const FOSSIL_KABUTOPS    ; 161
	const FOSSIL_AERODACTYL  ; 162
	const MON_GHOST          ; 163

DEF NUM_POKEMON_INDEXES EQU const_value - 1

; player starter
DEF STARTER_PIKACHU EQU PIKACHU

; rival starters
DEF RIVAL_STARTER_JOLTEON  EQU 1
DEF RIVAL_STARTER_FLAREON  EQU 2
DEF RIVAL_STARTER_VAPOREON EQU 3

; ghost Marowak in Pokémon Tower
DEF RESTLESS_SOUL EQU MAROWAK