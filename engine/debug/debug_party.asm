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
	db ELECTRODE, 100 ; 255
	db KADABRA, 25
	db STARTER_PIKACHU, 1
;	db VENUSAUR, 5
;	db ARTICUNO, 99
;	db MOLTRES, 68
	db -1 ; end

DebugStart:
IF DEF(_DEBUG)
	xor a ; PLAYER_PARTY_DATA
	ld [wMonDataLocation], a

	; Fly anywhere.
	ld a, %11111111
	ld [wTownVisitedFlag], a
	ld a, %01111111 ; this to NOT enable Forlorn Valley
	ld [wTownVisitedFlag + 1], a
	ld a, %11111111
;	ld a, %00000111
	ld [wTownVisitedFlag_Sevii], a ; new, for sevii
	ld [wTownVisitedFlag_Sevii + 1], a ; new, for sevii

	; Get all badges except Earth Badge.
	ld a, ~(1 << BIT_EARTHBADGE)
	ld a, %11111111
;	ld a, %00010000
;	ld a, %00000010
;	ld a, %11111100
	ld [wObtainedBadges], a

	call SetDebugTeam

	; Mewtwo/Arceus gets test moves
	ld a, DOUBLE_IRON_BASH
	ld hl, wPartyMon1Moves
	ld [hl], a
	ld a, ROCK_CLIMB
	ld hl, wPartyMon1Moves + 1
	ld [hl], a
	ld a, DIVE
	ld hl, wPartyMon1Moves + 2
	ld [hl], a
	ld a, ANCESTOR_PWR
	ld hl, wPartyMon1Moves + 3
	ld [hl], a

	; Mew gets four HM moves.
	ld hl, wPartyMon2Moves
	ld a, WHIRLPOOL
	ld [hli], a
	ld a, WATERFALL
	ld [hli], a
	ld a, ROCK_SMASH
	ld [hli], a
	ld a, STRENGTH
	ld [hl], a

	; Pikachu gets Surf and Fly and Flash
	ld a, FLY
	ld hl, wPartyMon3Moves
	ld [hl], a
	ld a, CUT
	ld hl, wPartyMon3Moves + 1
	ld [hl], a
	ld a, SURF
	ld hl, wPartyMon3Moves + 2
	ld [hl], a
	ld a, FLASH
	ld hl, wPartyMon3Moves + 3
	ld [hl], a

	; moves to other members
	ld a, DIG
	ld hl, wPartyMon4Moves
	ld [hli], a
	ld a, TELEPORT
	ld [hli], a
	ld a, SOFTBOILED
	ld [hli], a
	ld a, FLASH
	ld [hl], a

;	; moves to other members
;	ld a, SCALD
;	ld hl, wPartyMon5Moves
;	ld [hl], a

	; Pikachu get transformed into Starter Pikachu
	ld de, wPartyMon3OT
	ld hl, SamuelNameForPikachu3
	ld bc, NAME_LENGTH
	call CopyData ; copies bc bytes from hl to de
	ld de, wPartyMon3OTID
	xor a
	ld [de], a
	inc de
	ld [de], a

;; this adds a status (SLP, PSN, etc) to the n-th mon
;	ld hl, wPartyMon3Status
;	set PSN, [hl]
;	ld hl, wPartyMon4Status
;	set PSN, [hl]

    ; define who is shiny
    ld a, 1
    ld hl, wPartyMon1CatchRate
    ld [hl], a
;    ld hl, wPartyMon2CatchRate
;    ld [hl], a
;    ld hl, wPartyMon3CatchRate
;    ld [hl], a
;    ld hl, wPartyMon4CatchRate
;    ld [hl], a
;    ld hl, wPartyMon5CatchRate
;    ld [hl], a
;    ld hl, wPartyMon6CatchRate
;    ld [hl], a

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

    ; Set some attacks as seen
    ld hl, wAttackdexSeen
    ld a, %11001101
    ld [hli], a

	; Rival chose Jolteon. ; edited, unused
;	ld hl, wRivalStarter
;	ld a, RIVAL_STARTER_JOLTEON
;	ld [hli], a
	ld hl, wUnknownDebugByte
	ld a, NUM_POKEMON
	ld [hli], a ; hl = wUnknownDebugByte
	ld a, STARTER_PIKACHU
	ld [hl], a ; hl = wPlayerStarter

	; Select gender: 0 male, 1 female, 2 enby
	ld a, 0
	ld [wPlayerGender], a

	; Give max money.
	ld hl, wPlayerMoney
	ld a, $99
	ld [hli], a
	ld [hli], a
	ld [hl], a

    ; set Pikachu happiness and mood to max
    ld a, $FF
    ld [wPikachuHappiness], a
    ld [wPikachuMood], a

	ld a, $1
	ld [wChampionsRoomCurScript], a

;	ld a, $FE
;	ld [wPlayTimeHours], a
;	ld a, $FF
;	ld [wPlayTimeHours+1], a
;	ld a, 59
;	ld [wPlayTimeMinutes], a

	SetEvent EVENT_GOT_HM01
	ResetEvent EVENT_SS_ANNE_LEFT

;	SetEvent EVENT_DIVE_GOT_OXYGEN_TANK

;	SetEvent EVENT_SEVII_DOTTED_HOLE_OPENED

	SetEvent EVENT_SEVII_UNLOCKED_TANOBY_CHAMBERS

;	SetEvent EVENT_ENABLED_IMPOSTER

	SetEvent EVENT_BEAT_OCHRE_GYM_ORAGE

	SetEvent EVENT_SEVII_TICKET_UNLOCKED_UP_TO_8

;	SetEvent EVENT_IN_SEVII

	SetEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE

;	SetEvent EVENT_DEFEATED_MISSINGNO

;   SetEvent EVENT_BEAT_SAFARI_ZONE_NORTH_TRAINER_0
;	SetEvent EVENT_BEAT_OBSIDIAN_WAREHOUSE_FINAL_TRAINER_4
;	SetEvent EVENT_BEAT_CHAMPION_FINAL_REMATCH
;	SetEvent EVENT_GOT_HM01
;	SetEvent EVENT_SS_ANNE_LEFT
;	SetEvent EVENT_LEFT_BILLS_HOUSE_AFTER_HELPING
	SetEvent EVENT_RETURNED_LUNAR_RELIC
;	SetEvent EVENT_BEAT_POWER_PLANT_VOLTORB_0
;	SetEvent EVENT_BEAT_POWER_PLANT_VOLTORB_1
;	SetEvent EVENT_BEAT_POWER_PLANT_VOLTORB_2
;	SetEvent EVENT_BEAT_POWER_PLANT_VOLTORB_3
;	SetEvent EVENT_BEAT_POWER_PLANT_VOLTORB_4
;	SetEvent EVENT_BEAT_POWER_PLANT_VOLTORB_5
;	SetEvent EVENT_BEAT_POWER_PLANT_VOLTORB_6
;	SetEvent EVENT_BEAT_POWER_PLANT_VOLTORB_7

    SetEvent EVENT_OBTAIN_MAP_PIECE_1_BIRD_FAN_CLUB
    SetEvent EVENT_OBTAIN_MAP_PIECE_2_PIGEON
    SetEvent EVENT_OBTAIN_MAP_PIECE_3_TREASURE_HUNTER
    SetEvent EVENT_OBTAIN_MAP_PIECE_4_RESCUED_TRAVELER

	SetEvent EVENT_HAUNTED_HOUSE_4_MOM_IN_ROOM_SW

/*
;; BATTLE_FACILITY testing
	ld a, 1
	ld [wBattleFacilityStandardRecordNormalLC], a
	ld a, 0
	ld [wBattleFacilityHardcoreRecordNormalLC], a
	ld a, 3
	ld [wBattleFacilityStandardRecordInverseLC], a
	ld a, 4
	ld [wBattleFacilityHardcoreRecordInverseLC], a
;   ---
	ld a, 10
	ld [wBattleFacilityStandardRecordNormalNFE], a
	ld a, 20
	ld [wBattleFacilityHardcoreRecordNormalNFE], a
	ld a, 30
	ld [wBattleFacilityStandardRecordInverseNFE], a
	ld a, 40
	ld [wBattleFacilityHardcoreRecordInverseNFE], a
;   ---
	ld a, 254
	ld [wBattleFacilityStandardRecordNormalAG], a
	ld a, 42
	ld [wBattleFacilityHardcoreRecordNormalAG], a
	ld a, 5
	ld [wBattleFacilityStandardRecordInverseAG], a
	ld a, 255
	ld [wBattleFacilityHardcoreRecordInverseAG], a
;   ---
	ld a, 35
    ld [wBattleFacilityBacklogPPUPs], a
    ld a, 25
    ld [wBattleFacilityBacklogPerfecters], a
    ld a, 15
    ld [wBattleFacilityBacklogChromogenes], a
*/

	ret

DebugSetPokedexEntries:
	ld b, wPokedexOwnedEnd - wPokedexOwned - 1
	ld a, %11111111
	ld a, %10101010
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ld [hl], %00000001
	ret

SamuelNameForPikachu3: db "SAMUEL @" ; new, with a space to make it harder for players to emulate it

DebugItemsList:
	db ESCAPE_ROPE, 99
	db POKE_BALL, 11
	db POKE_FLUTE, 1
	db SUPER_ROD, 1
	db TOWN_MAP, 1
	db ITEMFINDER, 1
	db PERFECTER, 99
	db LEGEND_CANDY, 42
	db RARE_CANDY, 42
	db CHEAT_CANDY, 1
	db LINK_CABLE, 3
	db MYSTERY_MAP, 1
    db ONIGIRI_BOX, 99
	db CHROMOGENE, 99
;	db SEVII_COOKIE, 3
	db FLAME_PLUME, 1
	db MASTER_BALL, 99
	db BICYCLE, 1
	db FULL_RESTORE, 99
	db SECRET_KEY, 1
	db CARD_KEY, 1
	db REVIVE, 99
	db LIFT_KEY, 1
	db GOLD_TEETH, 1
	db SILPH_SCOPE, 1
;	db ICE_ORB, 1
;	db THUNDER_ORB, 1
;	db FIRE_ORB, 1
;	db TM_WILL_O_WISP, 3
	db MAX_REPEL, 3
	db LUNAR_RELIC, 1
	db MEGA_STONE_X, 99
	db MEGA_STONE_Y, 99
;	db EXP_ALL, 1
    db SHINY_CHARM, 1
;	db LIGHT_BALL, 1
    db ULTRA_BALL, 99
;	db GREAT_BALL, 99
;	db HM_ROCK_SMASH, 1
;	db HM_ROCK_CLIMB, 1
;   db HM_WATERFALL, 1
;	db HM_DIVE, 1
;	db HM_WHIRLPOOL, 1
;	db AMULET_COIN, 1
;	db TOPAZ, 1
;	db TIGERS_EYE, 1
	db S_S_TICKET, 1
	db SEVII_TICKET, 1
;	db PEARL, 7
;	db ROOM_KEY_34, 1
;	db ROOM_KEY_37, 1
	db -1 ; end

ELSE
	ret
ENDC
