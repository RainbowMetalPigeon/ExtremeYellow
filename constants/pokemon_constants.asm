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
	const MRAICHUX           ; 34
	const MRAICHUY           ; 35
	const SANDSHREW          ; 36
	const SANDSLASH          ; 37
	const NIDORAN_F          ; 38
	const NIDORINA           ; 39
	const NIDOQUEEN          ; 40
	const NIDORAN_M          ; 41
	const NIDORINO           ; 42
	const NIDOKING           ; 43
	const CLEFFA             ; 44
	const CLEFAIRY           ; 45
	const CLEFABLE           ; 46
	const MCLEFABLE          ; 47
	const VULPIX             ; 48
	const NINETALES          ; 49
	const IGGLYBUFF          ; 50
	const JIGGLYPUFF         ; 51
	const WIGGLYTUFF         ; 52
	const ZUBAT              ; 53
	const GOLBAT             ; 54
	const CROBAT             ; 55
	const ODDISH             ; 56
	const GLOOM              ; 57
	const VILEPLUME          ; 58
	const BELLOSSOM          ; 59
	const PARAS              ; 60
	const PARASECT           ; 61
	const VENONAT            ; 62
	const VENOMOTH           ; 63
	const DIGLETT            ; 64
	const DUGTRIO            ; 65
	const MEOWTH             ; 66
	const PERSIAN            ; 67
	const PSYDUCK            ; 68
	const GOLDUCK            ; 69
	const MANKEY             ; 70
	const PRIMEAPE           ; 71
	const ANNIHILAPE         ; 72
	const GROWLITHE          ; 73
	const ARCANINE           ; 74
	const POLIWAG            ; 75
	const POLIWHIRL          ; 76
	const POLIWRATH          ; 77
	const POLITOED           ; 78
	const ABRA               ; 79
	const KADABRA            ; 80
	const ALAKAZAM           ; 81
	const MALAKAZAM          ; 82
	const MACHOP             ; 83
	const MACHOKE            ; 84
	const MACHAMP            ; 85
	const BELLSPROUT         ; 86
	const WEEPINBELL         ; 87
	const VICTREEBEL         ; 88
	const MVICTREBEL         ; 89
	const TENTACOOL          ; 90
	const TENTACRUEL         ; 91
	const GEODUDE            ; 92
	const GRAVELER           ; 93
	const GOLEM              ; 94
	const PONYTA             ; 95
	const RAPIDASH           ; 96
	const SLOWPOKE           ; 97
	const SLOWBRO            ; 98
	const MSLOWBRO           ; 99
	const SLOWKING           ; 100
	const MAGNEMITE          ; 101
	const MAGNETON           ; 102
	const MAGNEZONE          ; 103
	const FARFETCHD          ; 104
	const DODUO              ; 105
	const DODRIO             ; 106
	const SEEL               ; 107
	const DEWGONG            ; 108
	const GRIMER             ; 109
	const MUK                ; 110
	const SHELLDER           ; 111
	const CLOYSTER           ; 112
	const GASTLY             ; 113
	const HAUNTER            ; 114
	const GENGAR             ; 115
	const MGENGAR            ; 116
	const ONIX               ; 117
	const STEELIX            ; 118
	const MSTEELIX           ; 119
	const DROWZEE            ; 120
	const HYPNO              ; 121
	const KRABBY             ; 122
	const KINGLER            ; 123
	const VOLTORB            ; 124
	const ELECTRODE          ; 125
	const EXEGGCUTE          ; 126
	const EXEGGUTOR          ; 127
	const CUBONE             ; 128
	const MAROWAK            ; 129
	const TYROGUE            ; 130
	const HITMONLEE          ; 131
	const HITMONCHAN         ; 132
	const HITMONTOP          ; 133
	const LICKITUNG          ; 134
	const LICKILICKY         ; 135
	const KOFFING            ; 136
	const WEEZING            ; 137
	const RHYHORN            ; 138
	const RHYDON             ; 139
	const RHYPERIOR          ; 140
	const HAPPINY            ; 141
	const CHANSEY            ; 142
	const BLISSEY            ; 143
	const TANGELA            ; 144
	const TANGROWTH          ; 145
	const KANGASKHAN         ; 146
	const MKANGASKAN         ; 147
	const HORSEA             ; 148
	const SEADRA             ; 149
	const KINGDRA            ; 150
	const GOLDEEN            ; 151
	const SEAKING            ; 152
	const STARYU             ; 153
	const STARMIE            ; 154
	const MSTARMIE           ; 155
	const MIME_JR            ; 156
	const MR_MIME            ; 157
	const SCYTHER            ; 158
	const SCIZOR             ; 159
	const MSCIZOR            ; 160
	const KLEAVOR            ; 161
	const SMOOCHUM           ; 162
	const JYNX               ; 163
	const ELEKID             ; 164
	const ELECTABUZZ         ; 165
	const ELECTIVIRE         ; 166
	const MAGBY              ; 167
	const MAGMAR             ; 168
	const MAGMORTAR          ; 169
	const PINSIR             ; 170
	const MPINSIR            ; 171
	const TAUROS             ; 172
	const MAGIKARP           ; 173
	const GYARADOS           ; 174
	const MGYARADOS          ; 175
	const LAPRAS             ; 176
	const DITTO              ; 177
	const EEVEE              ; 178
	const VAPOREON           ; 179
	const JOLTEON            ; 180
	const FLAREON            ; 181
	const ESPEON             ; 182
	const UMBREON            ; 183
	const LEAFEON            ; 184
	const GLACEON            ; 185
	const SYLVEON            ; 186
	const PORYGON            ; 187
	const PORYGON2           ; 188
	const PORYGONZ           ; 189
	const OMANYTE            ; 190
	const OMASTAR            ; 191
	const KABUTO             ; 192
	const KABUTOPS           ; 193
	const AERODACTYL         ; 194
	const MARODACTYL         ; 195
	const MUNCHLAX           ; 196
	const SNORLAX            ; 197
	const ARTICUNO           ; 198
	const ZAPDOS             ; 199
	const MOLTRES            ; 200
	const DRATINI            ; 201
	const DRAGONAIR          ; 202
	const DRAGONITE          ; 203
	const MDRAGONITE         ; 204
	const ARM_MEWTWO         ; 205
	const MEWTWO             ; 206
	const MMEWTWOX           ; 207
	const MMEWTWOY           ; 208
	const MEW                ; 209
	const MELTAN             ; 210
	const MELMETAL           ; 211
	const VENUSTOISE         ; 212
DEF NUM_POKEMON_RANDOMIZABLE EQU const_value - 1
	const THU_FI_ZER         ; 213
	const MZYGARDE           ; 214
	const UNECROZMA          ; 215
	const MRAYQUAZA          ; 216
	const EETERNATUS         ; 217
	const ARCEUS             ; 218
	const MISSINGNO          ; 219
	const BLUESDAD           ; 220
	const BLUESMOM           ; 221
	const DAD                ; 222
	const FOSSIL_KABUTOPS    ; 223
	const FOSSIL_AERODACTYL  ; 224
	const MON_GHOST          ; 225
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
