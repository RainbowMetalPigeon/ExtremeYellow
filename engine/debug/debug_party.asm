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
	db ONIX, 100
	db EEVEE, 95
	db SNORLAX, 80
	db MEOWTH, 30
	db TYROGUE, 10
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
	ld a, BITE
	ld hl, wPartyMon1Moves
	ld [hl], a
	ld a, TWISTER
	ld hl, wPartyMon1Moves + 1
	ld [hl], a
	ld a, TWINEEDLE
	ld hl, wPartyMon1Moves + 2
	ld [hl], a

	; Pikachu gets Surf.
	ld a, SURF
	ld hl, wPartyMon6Moves + 2
	ld [hl], a

	; Snorlax gets four HM moves.
	ld hl, wPartyMon3Moves
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

	; Give max money.
	ld hl, wPlayerMoney
	ld a, $99
	ld [hli], a
	ld [hli], a
	ld [hl], a

	; set fast text and set mode - new
	ld a, %01100001
	ld [wOptions], a

	ret

DebugSetPokedexEntries:
	ld b, wPokedexOwnedEnd - wPokedexOwned - 1
	ld a, %11111111
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ld [hl], %00000111
	ret

DebugItemsList:
	db MASTER_BALL, 99
	db TOWN_MAP, 1
	db METAL_COAT, 99
	db MEGA_STONE_X, 99
	db MEGA_STONE_Y, 99
	db RARE_CANDY, 99
	db THUNDER_STONE, 99
	db FIRE_STONE, 99
	db WATER_STONE, 99 ; FULL_HEAL
	db ICE_STONE, 99
	db MOON_STONE, 99
	db LEAF_STONE, 99
	db KINGS_ROCK, 99
	db SUN_STONE, 99
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
