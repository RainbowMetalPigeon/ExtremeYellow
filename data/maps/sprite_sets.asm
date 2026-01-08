MapSpriteSets:
	table_width 1, MapSpriteSets
	db $0e ; PALLET_TOWN ; edited, it was $01
	db $10 ; VIRIDIAN_CITY ; edited, it was $01
	db $12 ; PEWTER_CITY ; edited, it was $02
	db $12 ; CERULEAN_CITY ; edited, it was $02
	db $0f ; LAVENDER_TOWN ; edited, it was $03
	db $11 ; VERMILION_CITY ; edited, it was $04
	db $05 ; CELADON_CITY
	db $08 ; OCHRE_CITY, new, moved
	db $0c ; FUCHSIA_CITY ; edited, it was $0a
	db $0d ; OBSIDIAN_ISLAND, new, testing, custom made
	db $13 ; CINNABAR_ISLAND ; edited, it was $01
	db $06 ; INDIGO_PLATEAU
	db $07 ; SAFFRON_CITY
	db $01 ; ROUTE_1 ; is the only $01 left together with R22, we can modify them hopefully, maybe split south with 0e and north with 10?
	db $f1 ; ROUTE_2
	db $02 ; ROUTE_3
	db $02 ; ROUTE_4
	db $f9 ; ROUTE_5
	db $fa ; ROUTE_6
	db $fb ; ROUTE_7
	db $fc ; ROUTE_8
	db $02 ; ROUTE_9
	db $f2 ; ROUTE_10
	db $f3 ; ROUTE_11
	db $f4 ; ROUTE_12
	db $08 ; ROUTE_13
	db $08 ; ROUTE_14
	db $f5 ; ROUTE_15
	db $f6 ; ROUTE_16
	db $09 ; ROUTE_17
	db $f7 ; ROUTE_18
	db $0a ; ROUTE_19
	db $f8 ; ROUTE_20
	db $13 ; ROUTE_21 ; edited, it was $01
	db $01 ; ROUTE_22 ; is the only $01 left together with R1, we can modify them hopefully?
	db $06 ; ROUTE_23
	db $02 ; ROUTE_24
	db $02 ; ROUTE_25
	db $02 ; ROUTE_26, new
	db $0d ; ROUTE_27, new, testing, may need a split thingy between $0d (Obsidian) and $05 (Celadon)
	db $0d ; ROUTE_28, new, testing, may need a split thingy between $0d (Obsidian) and $04 (Vermilion)
	db $15 ; ROUTE_29, new, testing (for now same set as Route14)
	db $10 ; ROUTE_30, new, testing (for now same set as Viridian City, i.e. south of Route2)
	db $0f ; LAKE_OF_MIST, new
	assert_table_length FIRST_INDOOR_MAP

DEF EAST_WEST   EQU 1
DEF NORTH_SOUTH EQU 2

; Format:
; 00: determines whether the map is split EAST_WEST or NORTH_SOUTH
; 01: coordinate of dividing line
; 02: sprite set ID if in the West or North side
; 03: sprite set ID if in the East or South side
SplitMapSpriteSets:
	db NORTH_SOUTH, 37, $12, $10 ; $f1, edited, $10 was $01, and $12 was $02
	db NORTH_SOUTH, 50, $02, $0f ; $f2, edited, $0f was $03
	db EAST_WEST,   57, $04, $08 ; $f3
	db NORTH_SOUTH, 21, $0f, $14 ; $f4, edited, $0f was $03, and $14 was $08
	db EAST_WEST,    8, $0A, $08 ; $f5
	db EAST_WEST,   24, $09, $05 ; $f6
	db EAST_WEST,   34, $09, $0A ; $f7
	db EAST_WEST,   53, $13, $0B ; $f8, edited, $0B was $0A, and $13 was $01
	db NORTH_SOUTH, 33, $12, $07 ; $f9, edited, $12 was $02
	db NORTH_SOUTH,  2, $07, $11 ; $fa, edited, $11 was $04
	db EAST_WEST,   17, $05, $07 ; $fb
	db EAST_WEST,    3, $07, $0f ; $fc, edited, $0f was $03

SpriteSets:

; each sprite set has 9 walking sprites and 2 still sprites
DEF SPRITE_SET_LENGTH EQU 9 + 2

; sprite set $01
	table_width 1
	db SPRITE_PIKACHU
	db SPRITE_BLUE
	db SPRITE_YOUNGSTER
	db SPRITE_GIRL
	db SPRITE_FISHER
	db SPRITE_COOLTRAINER_M
	db SPRITE_GAMBLER
	db SPRITE_OAK
	db SPRITE_SWIMMER
	db SPRITE_POKE_BALL
	db SPRITE_GAMBLER_ASLEEP
	assert_table_length SPRITE_SET_LENGTH

; sprite set $02
	table_width 1
	db SPRITE_PIKACHU
	db SPRITE_YOUNGSTER
	db SPRITE_ROCKET
	db SPRITE_SUPER_NERD
	db SPRITE_HIKER
	db SPRITE_BLUE
	db SPRITE_OFFICER_JENNY
	db SPRITE_COOLTRAINER_F
	db SPRITE_COOLTRAINER_M
	db SPRITE_POKE_BALL
	db SPRITE_BOULDER ; edited, was SPRITE_UNUSED_GAMBLER_ASLEEP_2
	assert_table_length SPRITE_SET_LENGTH

; sprite set $03
	table_width 1
	db SPRITE_PIKACHU
	db SPRITE_LITTLE_GIRL
	db SPRITE_GIRL
	db SPRITE_SUPER_NERD
	db SPRITE_HIKER
	db SPRITE_GAMBLER
	db SPRITE_MONSTER
	db SPRITE_COOLTRAINER_F
	db SPRITE_COOLTRAINER_M
	db SPRITE_POKE_BALL
	db SPRITE_BOULDER ; edited, was SPRITE_UNUSED_GAMBLER_ASLEEP_2
	assert_table_length SPRITE_SET_LENGTH

; sprite set $04
	table_width 1
	db SPRITE_PIKACHU
	db SPRITE_OFFICER_JENNY
	db SPRITE_SUPER_NERD
	db SPRITE_YOUNGSTER
	db SPRITE_GAMBLER
	db SPRITE_MONSTER
	db SPRITE_SAILOR
	db SPRITE_COOLTRAINER_F
	db SPRITE_COOLTRAINER_M
	db SPRITE_POKE_BALL
	db SPRITE_UNUSED_GAMBLER_ASLEEP_2
	assert_table_length SPRITE_SET_LENGTH

; sprite set $05
	table_width 1
	db SPRITE_PIKACHU
	db SPRITE_LITTLE_GIRL
	db SPRITE_BLUE ; edited, TBE
	db SPRITE_GIRL
	db SPRITE_FISHER
	db SPRITE_TRAVELER ; edited, was SPRITE_MIDDLE_AGED_MAN
	db SPRITE_GRAMPS
	db SPRITE_MONSTER
	db SPRITE_ROCKET
	db SPRITE_POKE_BALL
	db SPRITE_SNORLAX
	assert_table_length SPRITE_SET_LENGTH

; sprite set $06
	table_width 1
	db SPRITE_PIKACHU
	db SPRITE_GYM_GUIDE
	db SPRITE_MONSTER
	db SPRITE_BLUE
	db SPRITE_COOLTRAINER_F
	db SPRITE_COOLTRAINER_M
	db SPRITE_SWIMMER
	db SPRITE_GUARD
	db SPRITE_PINK ; edited
	db SPRITE_POKE_BALL
	db SPRITE_UNUSED_GAMBLER_ASLEEP_2
	assert_table_length SPRITE_SET_LENGTH

; sprite set $07 ; edited for traveler
	table_width 1
	db SPRITE_PIKACHU
	db SPRITE_ROCKET
	db SPRITE_SCIENTIST
	db SPRITE_SILPH_WORKER
	db SPRITE_ERIKA
	db SPRITE_GENTLEMAN
	db SPRITE_BIRD
	db SPRITE_TRAVELER ; was SPRITE_ROCKER
	db SPRITE_COOLTRAINER_M
	db SPRITE_POKE_BALL
	db SPRITE_UNUSED_GAMBLER_ASLEEP_2
	assert_table_length SPRITE_SET_LENGTH

; sprite set $08
	table_width 1
	db SPRITE_PIKACHU
	db SPRITE_BIKER
	db SPRITE_SUPER_NERD
	db SPRITE_BIRD ; was SPRITE_MIDDLE_AGED_MAN, but is never used?
	db SPRITE_COOLTRAINER_F
	db SPRITE_COOLTRAINER_M
	db SPRITE_BEAUTY
	db SPRITE_FISHER
	db SPRITE_TRAVELER ; edited, was a SPRITE_ROCKER
	db SPRITE_POKE_BALL
	db SPRITE_SNORLAX
	assert_table_length SPRITE_SET_LENGTH

; sprite set $09
	table_width 1
	db SPRITE_PIKACHU
	db SPRITE_BIKER
	db SPRITE_COOLTRAINER_M
	db SPRITE_SILPH_WORKER
	db SPRITE_FISHER
	db SPRITE_ROCKER
	db SPRITE_HIKER
	db SPRITE_GAMBLER
	db SPRITE_MIDDLE_AGED_MAN
	db SPRITE_POKE_BALL
	db SPRITE_SNORLAX
	assert_table_length SPRITE_SET_LENGTH

; sprite set $0a
	table_width 1
	db SPRITE_PIKACHU
	db SPRITE_COOLTRAINER_M
	db SPRITE_CHANSEY
	db SPRITE_FISHER
	db SPRITE_GAMBLER
	db SPRITE_MONSTER
	db SPRITE_SEEL
	db SPRITE_SWIMMER
	db SPRITE_YOUNGSTER
	db SPRITE_POKE_BALL
	db SPRITE_FOSSIL
	assert_table_length SPRITE_SET_LENGTH

; sprite set $0b ; new, copy of $0a with the addition of Misty
	table_width 1
	db SPRITE_PIKACHU
	db SPRITE_MISTY ; for Misty
	db SPRITE_CHANSEY
	db SPRITE_FISHER
	db SPRITE_GAMBLER
	db SPRITE_MONSTER
	db SPRITE_SEEL
	db SPRITE_SWIMMER
	db SPRITE_YOUNGSTER
	db SPRITE_POKE_BALL
	db SPRITE_FOSSIL
	assert_table_length SPRITE_SET_LENGTH

; sprite set $0c ; new, copy of $0a for Fuchsia
	table_width 1
	db SPRITE_PIKACHU
	db SPRITE_ROCKET ; for guarding the Safari Zone
	db SPRITE_CHANSEY
	db SPRITE_FISHER
	db SPRITE_GAMBLER
	db SPRITE_MONSTER
	db SPRITE_SEEL
	db SPRITE_TRAVELER ; edited, was SPRITE_SWIMMER
	db SPRITE_GIRL ; edited, was SPRITE_YOUNGSTER
	db SPRITE_POKE_BALL
	db SPRITE_FOSSIL
	assert_table_length SPRITE_SET_LENGTH

; sprite set $0d ; new, for Obsidian
	table_width 1
	db SPRITE_PIKACHU
	db SPRITE_YOUNGSTER
	db SPRITE_ROCKET
	db SPRITE_TRAVELER
	db SPRITE_FISHER
	db SPRITE_SCIENTIST
	db SPRITE_OFFICER_JENNY
	db SPRITE_COOLTRAINER_F
	db SPRITE_COOLTRAINER_M
	db SPRITE_POKE_BALL
	db SPRITE_UNUSED_GAMBLER_ASLEEP_2
	assert_table_length SPRITE_SET_LENGTH

; sprite set $0e ; new, copy of $01 for Pallet Town
	table_width 1
	db SPRITE_PIKACHU
	db SPRITE_BLUE
	db SPRITE_YOUNGSTER
	db SPRITE_GIRL
	db SPRITE_FISHER
	db SPRITE_DARK_GUIDE ; it was SPRITE_COOLTRAINER_M
	db SPRITE_GAMBLER
	db SPRITE_OAK
	db SPRITE_SWIMMER
	db SPRITE_POKE_BALL
	db SPRITE_GAMBLER_ASLEEP
	assert_table_length SPRITE_SET_LENGTH

; sprite set $0f ; copy of $03 for Lavender
	table_width 1
	db SPRITE_PIKACHU
	db SPRITE_LITTLE_GIRL
	db SPRITE_GIRL
	db SPRITE_SUPER_NERD
	db SPRITE_HIKER
	db SPRITE_GAMBLER
	db SPRITE_TRAVELER ; edited, was SPRITE_MONSTER
	db SPRITE_COOLTRAINER_F
	db SPRITE_COOLTRAINER_M
	db SPRITE_POKE_BALL
	db SPRITE_ROCKSMASHABLE_ROCK ; edited, was SPRITE_UNUSED_GAMBLER_ASLEEP_2
	assert_table_length SPRITE_SET_LENGTH

; sprite set $10 ; copy of $01 for Viridian
	table_width 1
	db SPRITE_PIKACHU
	db SPRITE_BLUE
	db SPRITE_YOUNGSTER
	db SPRITE_GIRL
	db SPRITE_FISHER
	db SPRITE_COOLTRAINER_M
	db SPRITE_GAMBLER
	db SPRITE_OAK
	db SPRITE_TRAVELER ; edited, was SPRITE_SWIMMER
	db SPRITE_POKE_BALL
	db SPRITE_GAMBLER_ASLEEP
	assert_table_length SPRITE_SET_LENGTH

; sprite set $11, copy of $04 for Vermilion
	table_width 1
	db SPRITE_PIKACHU
	db SPRITE_OFFICER_JENNY
	db SPRITE_TRAVELER ; edited, was SPRITE_SUPER_NERD
	db SPRITE_YOUNGSTER
	db SPRITE_GAMBLER
	db SPRITE_MONSTER
	db SPRITE_SAILOR
	db SPRITE_COOLTRAINER_F
	db SPRITE_COOLTRAINER_M
	db SPRITE_POKE_BALL
	db SPRITE_UNUSED_GAMBLER_ASLEEP_2
	assert_table_length SPRITE_SET_LENGTH

; sprite set $12, copy of $02 for Pewter and Cerulean
	table_width 1
	db SPRITE_PIKACHU
	db SPRITE_TRAVELER ; edited, was SPRITE_YOUNGSTER
	db SPRITE_ROCKET
	db SPRITE_SUPER_NERD
	db SPRITE_HIKER
	db SPRITE_BLUE
	db SPRITE_OFFICER_JENNY
	db SPRITE_COOLTRAINER_F
	db SPRITE_COOLTRAINER_M
	db SPRITE_POKE_BALL
	db SPRITE_BOULDER ; edited, was SPRITE_UNUSED_GAMBLER_ASLEEP_2
	assert_table_length SPRITE_SET_LENGTH

; sprite set $13, copy of $01 for Cinnabar, R21, R22
	table_width 1
	db SPRITE_PIKACHU
	db SPRITE_BLUE
	db SPRITE_TRAVELER ; was SPRITE_YOUNGSTER
	db SPRITE_GIRL
	db SPRITE_FISHER
	db SPRITE_COOLTRAINER_M
	db SPRITE_GAMBLER
	db SPRITE_OAK
	db SPRITE_SWIMMER
	db SPRITE_POKE_BALL
	db SPRITE_GAMBLER_ASLEEP
	assert_table_length SPRITE_SET_LENGTH

; sprite set $14, copy of $08, for South part of R12
	table_width 1
	db SPRITE_PIKACHU
	db SPRITE_BIKER
	db SPRITE_SUPER_NERD
	db SPRITE_BLUE ; this is the difference wrt $08
	db SPRITE_COOLTRAINER_F
	db SPRITE_COOLTRAINER_M
	db SPRITE_BEAUTY
	db SPRITE_FISHER
	db SPRITE_TRAVELER
	db SPRITE_POKE_BALL
	db SPRITE_SNORLAX
	assert_table_length SPRITE_SET_LENGTH

; sprite set $15, copy of $08, for Route 29
	table_width 1
	db SPRITE_PIKACHU
	db SPRITE_SWIMMER ; edited, was SPRITE_BIKER
	db SPRITE_HIKER ; edited, was SPRITE_SUPER_NERD
	db SPRITE_SLOWKING ; edited, was SPRITE_MIDDLE_AGED_MAN / SPRITE_BIRD
	db SPRITE_COOLTRAINER_F
	db SPRITE_COOLTRAINER_M
	db SPRITE_BEAUTY
	db SPRITE_FISHER
	db SPRITE_TRAVELER ; edited, was a SPRITE_ROCKER
	db SPRITE_POKE_BALL
	db SPRITE_SNORLAX
	assert_table_length SPRITE_SET_LENGTH
