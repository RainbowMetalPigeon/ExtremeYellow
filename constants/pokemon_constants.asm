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
	const IGGLYBUFF          ; 47
	const JIGGLYPUFF         ; 48
	const WIGGLYTUFF         ; 49
	const ZUBAT              ; 50
	const GOLBAT             ; 51
	const CROBAT             ; 52
	const ODDISH             ; 53
	const GLOOM              ; 54
	const VILEPLUME          ; 55
	const BELLOSSOM          ; 56
	const PARAS              ; 57
	const PARASECT           ; 58
	const VENONAT            ; 59
	const VENOMOTH           ; 60
	const DIGLETT            ; 61
	const DUGTRIO            ; 62
	const MEOWTH             ; 63
	const PERSIAN            ; 64
	const PSYDUCK            ; 65
	const GOLDUCK            ; 66
	const MANKEY             ; 67
	const PRIMEAPE           ; 68
	const ANNIHILAPE         ; 69
	const GROWLITHE          ; 70
	const ARCANINE           ; 71
	const POLIWAG            ; 72
	const POLIWHIRL          ; 73
	const POLIWRATH          ; 74
	const POLITOED           ; 75
	const ABRA               ; 76
	const KADABRA            ; 77
	const ALAKAZAM           ; 78
	const MALAKAZAM          ; 79
	const MACHOP             ; 80
	const MACHOKE            ; 81
	const MACHAMP            ; 82
	const BELLSPROUT         ; 83
	const WEEPINBELL         ; 84
	const VICTREEBEL         ; 85
	const TENTACOOL          ; 86
	const TENTACRUEL         ; 87
	const GEODUDE            ; 88
	const GRAVELER           ; 89
	const GOLEM              ; 90
	const PONYTA             ; 91
	const RAPIDASH           ; 92
	const SLOWPOKE           ; 93
	const SLOWBRO            ; 94
	const MSLOWBRO           ; 95
	const SLOWKING           ; 96
	const MAGNEMITE          ; 97
	const MAGNETON           ; 98
	const MAGNEZONE          ; 99
	const FARFETCHD          ; 100
	const DODUO              ; 101
	const DODRIO             ; 102
	const SEEL               ; 103
	const DEWGONG            ; 104
	const GRIMER             ; 105
	const MUK                ; 106
	const SHELLDER           ; 107
	const CLOYSTER           ; 108
	const GASTLY             ; 109
	const HAUNTER            ; 110
	const GENGAR             ; 111
	const MGENGAR            ; 112
	const ONIX               ; 113
	const STEELIX            ; 114
	const MSTEELIX           ; 115
	const DROWZEE            ; 116
	const HYPNO              ; 117
	const KRABBY             ; 118
	const KINGLER            ; 119
	const VOLTORB            ; 120
	const ELECTRODE          ; 121
	const EXEGGCUTE          ; 122
	const EXEGGUTOR          ; 123
	const CUBONE             ; 124
	const MAROWAK            ; 125
	const TYROGUE            ; 126
	const HITMONLEE          ; 127
	const HITMONCHAN         ; 128
	const HITMONTOP          ; 129
	const LICKITUNG          ; 130
	const LICKILICKY         ; 131
	const KOFFING            ; 132
	const WEEZING            ; 133
	const RHYHORN            ; 134
	const RHYDON             ; 135
	const RHYPERIOR          ; 136
	const HAPPINY            ; 137
	const CHANSEY            ; 138
	const BLISSEY            ; 139
	const TANGELA            ; 140
	const TANGROWTH          ; 141
	const KANGASKHAN         ; 142
	const MKANGASKAN         ; 143
	const HORSEA             ; 144
	const SEADRA             ; 145
	const KINGDRA            ; 146
	const GOLDEEN            ; 147
	const SEAKING            ; 148
	const STARYU             ; 149
	const STARMIE            ; 150
	const MIME_JR            ; 151
	const MR_MIME            ; 152
	const SCYTHER            ; 153
	const SCIZOR             ; 154
	const MSCIZOR            ; 155
	const KLEAVOR            ; 156
	const SMOOCHUM           ; 157
	const JYNX               ; 158
	const ELEKID             ; 159
	const ELECTABUZZ         ; 160
	const ELECTIVIRE         ; 161
	const MAGBY              ; 162
	const MAGMAR             ; 163
	const MAGMORTAR          ; 164
	const PINSIR             ; 165
	const MPINSIR            ; 166
	const TAUROS             ; 167
	const MAGIKARP           ; 168
	const GYARADOS           ; 169
	const MGYARADOS          ; 170
	const LAPRAS             ; 171
	const DITTO              ; 172
	const EEVEE              ; 173
	const VAPOREON           ; 174
	const JOLTEON            ; 175
	const FLAREON            ; 176
	const ESPEON             ; 177
	const UMBREON            ; 178
	const LEAFEON            ; 179
	const GLACEON            ; 180
	const SYLVEON            ; 181
	const PORYGON            ; 182
	const PORYGON2           ; 183
	const PORYGONZ           ; 184
	const OMANYTE            ; 185
	const OMASTAR            ; 186
	const KABUTO             ; 187
	const KABUTOPS           ; 188
	const AERODACTYL         ; 189
	const MARODACTYL         ; 190
	const MUNCHLAX           ; 191
	const SNORLAX            ; 192
	const ARTICUNO           ; 193
	const ZAPDOS             ; 194
	const MOLTRES            ; 195
	const DRATINI            ; 196
	const DRAGONAIR          ; 197
	const DRAGONITE          ; 198
	const MEWTWO             ; 199
	const MMEWTWOX           ; 200
	const MMEWTWOY           ; 201
	const MEW                ; 202
	const VENUSTOISE         ; 203
	const ZYGARDEC           ; 204
	const UNECROZMA          ; 205
	const MRAYQUAZA          ; 206
	const EETERNATUS         ; 207
	const ARCEUS             ; 208
	const FOSSIL_KABUTOPS    ; 209
	const FOSSIL_AERODACTYL  ; 210
	const MON_GHOST          ; 211
; map pieces, new
	const MAP_PIECES_1
	const MAP_PIECES_2
	const MAP_PIECES_3
	const MAP_PIECES_4
	const MAP_PIECES_12
	const MAP_PIECES_13
	const MAP_PIECES_14
	const MAP_PIECES_23
	const MAP_PIECES_24
	const MAP_PIECES_34
	const MAP_PIECES_123
	const MAP_PIECES_124
	const MAP_PIECES_134
	const MAP_PIECES_234
	const MAP_PIECES_1234	

DEF NUM_POKEMON_INDEXES EQU const_value - 1

; player starter
DEF STARTER_PIKACHU EQU PIKACHU

; rival starters
DEF RIVAL_STARTER_JOLTEON  EQU 1
DEF RIVAL_STARTER_FLAREON  EQU 2
DEF RIVAL_STARTER_VAPOREON EQU 3

; ghost Marowak in Pokémon Tower
DEF RESTLESS_SOUL EQU MAROWAK
