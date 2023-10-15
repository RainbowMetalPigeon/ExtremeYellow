; not IshiharaTeam
SetDebugTeam:
	ld de, DebugTeam
.loop
	ld a, [de]
	cp -1
	ret z
	ld [wcf91], a
	inc de
	ld a, [de]
	ld [wCurEnemyLVL], a
	inc de
	call AddPartyMon
	jr .loop

DebugTeam:
	db MEWTWO, 98
	db SNORLAX, 80
	db ARCEUS, 10
	db STARTER_PIKACHU, 5
	db -1 ; end

DebugStart:
IF DEF(_DEBUG)
	xor a ; PLAYER_PARTY_DATA
	ld [wMonDataLocation], a

	; Fly anywhere.
	dec a ; $ff
	ld [wTownVisitedFlag], a
	ld [wTownVisitedFlag + 1], a

	; Get all badges except Earth Badge.
	ld a, ~(1 << BIT_EARTHBADGE)
	ld [wObtainedBadges], a

	call SetDebugTeam

	; Mewtwo gets Psychic or test moves
	ld a, ETERNABEAM
	ld hl, wPartyMon1Moves
	ld [hl], a
	ld a, TELEPORT
	ld hl, wPartyMon1Moves + 1
	ld [hl], a
	ld a, THOUSANDARROWS
	ld hl, wPartyMon1Moves + 2
	ld [hl], a
	ld a, PHOTONGEYSER
	ld hl, wPartyMon1Moves + 3
	ld [hl], a

	; Persian gets Moves.
	ld a, JUDGMENT
	ld hl, wPartyMon3Moves
	ld [hl], a
	ld a, INFESTATION
	ld hl, wPartyMon3Moves + 1
	ld [hl], a
	ld a, HYDRO_CANNON
	ld hl, wPartyMon3Moves + 2
	ld [hl], a
	ld a, FLASH
	ld hl, wPartyMon3Moves + 3
	ld [hl], a

	; Pikachu gets Surf.
	ld a, SURF
	ld hl, wPartyMon4Moves + 2
	ld [hl], a
	ld a, ANCESTOR_PWR
	ld hl, wPartyMon4Moves + 3
	ld [hl], a

	; Snorlax gets four HM moves.
	ld hl, wPartyMon2Moves
	ld a, FLY
	ld [hli], a
	ld a, CUT
	ld [hli], a
	ld a, SURF
	ld [hli], a
	ld a, STRENGTH
	ld [hl], a

	; Get some debug items.
	ld hl, wNumBagItems
	ld de, DebugItemsList
.items_loop
	ld a, [de]
	cp -1
	jr z, .items_end
	ld [wcf91], a
	inc de
	ld a, [de]
	inc de
	ld [wItemQuantity], a
	call AddItemToInventory
	jr .items_loop
.items_end

	; Complete the Pokédex.
	ld hl, wPokedexOwned
	call DebugSetPokedexEntries
	ld hl, wPokedexSeen
	call DebugSetPokedexEntries
	SetEvent EVENT_GOT_POKEDEX

	; Rival chose Jolteon.
	ld hl, wRivalStarter
	ld a, RIVAL_STARTER_JOLTEON
	ld [hli], a
	ld a, NUM_POKEMON
	ld [hli], a ; hl = wUnknownDebugByte
	ld a, STARTER_PIKACHU
	ld [hl], a ; hl = wPlayerStarter

	; Select gender: 0 male, 1 female, 2 enby
	ld a, 2
	ld [wPlayerGender], a

	; Give max money.
	ld hl, wPlayerMoney
	ld a, $99
	ld [hli], a
	ld [hli], a
	ld [hl], a

;	; set fast text and set mode - new
;	ld a, %01100001
;	ld [wOptions], a

	SetEvent EVENT_BEAT_INTERDIMENSIONAL_TRAVELER

	ret

DebugSetPokedexEntries:
	ld b, wPokedexOwnedEnd - wPokedexOwned - 1
	ld a, %11111111
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ld [hl], %11111111
	ret

DebugItemsList:
	db SUPER_ROD, 1
	db MASTER_BALL, 99
	db HEAVY_BALL, 99
	db FAST_BALL, 99
	db MEGA_STONE_X, 99
	db TOWN_MAP, 1
	db BICYCLE, 1
	db FULL_RESTORE, 99
	db SECRET_KEY, 1
	db CARD_KEY, 1
	db POKE_DOLL, 99 ; FULL_HEAL
	db REVIVE, 99
	db S_S_TICKET, 1
	db LIFT_KEY, 1
	db POKE_FLUTE, 1
	db ESCAPE_ROPE, 99
	db LEGEND_CANDY, 42
	db -1 ; end

DebugUnusedList:
	db OLD_AMBER, 1
	db DOME_FOSSIL, 1
	db HELIX_FOSSIL, 1
	db X_ACCURACY, 99
	db DIRE_HIT, 99
	db FRESH_WATER, 1
	db S_S_TICKET, 1
	db GOLD_TEETH, 1
	db COIN_CASE, 1
	db SILPH_SCOPE, 1
	db POKE_FLUTE, 1
	db LIFT_KEY, 1
	db ETHER, 99
	db MAX_ETHER, 99
	db ELIXER, 99
	db MAX_ELIXER, 99
;	db TM_RAZOR_WIND, 10
	db TM_HYDRO_PUMP, 10
	db TM_METEOR_MASH, 10
	db TM_BLIZZARD, 10
	db TM_HYPER_BEAM, 10
	db TM_STONE_EDGE, 10
;	db TM_DRAGON_RAGE, 10
	db TM_MIMIC, 10
	db TM_BIDE, 10
	db TM_METRONOME, 10
	db TM_SELFDESTRUCT, 10
	db TM_DARK_PULSE, 10
	db TM_BRAVE_BIRD, 10
	db TM_CLOSE_COMBAT, 10
	db TM_REST, 10
	db TM_SUBSTITUTE, 10
	db -1 ; end
ELSE
	ret
ENDC
