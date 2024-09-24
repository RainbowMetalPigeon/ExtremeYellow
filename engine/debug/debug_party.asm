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
	db MEW, 255 ; 255
	db VENUSTOISE, 35
	db STARTER_PIKACHU, 235
;	db SEAKING, 42
;	db PORYGONZ, 42
	db MISSINGNO, 255
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
	ld a, %11111111
;	ld a, %00000100
;	ld a, %01001100
	ld [wObtainedBadges], a

	call SetDebugTeam

	; Mewtwo/Arceus gets test moves
	ld a, ANCESTOR_PWR
	ld hl, wPartyMon1Moves
	ld [hl], a
	ld a, DRAGONBREATH
	ld hl, wPartyMon1Moves + 1
	ld [hl], a
	ld a, JUDGMENT
	ld hl, wPartyMon1Moves + 2
	ld [hl], a
	ld a, DISABLE
	ld hl, wPartyMon1Moves + 3
	ld [hl], a

	; Mew gets four HM moves.
	ld hl, wPartyMon2Moves
	ld a, EXPLOSION
	ld [hli], a
	ld a, FLY
	ld [hli], a
	ld a, CUT
	ld [hli], a
	ld a, STRENGTH
	ld [hl], a

	; Pikachu gets Surf and Fly and Flash
	ld a, FLY
	ld hl, wPartyMon3Moves
	ld [hl], a
	ld a, FLASH
	ld hl, wPartyMon3Moves + 2
	ld [hl], a
	ld a, SURF
	ld hl, wPartyMon3Moves + 3
	ld [hl], a

;	; moves to other members
;	ld a, WILL_O_WISP
;	ld hl, wPartyMon4Moves
;	ld [hl], a

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
; this adds a status (SLP, PSN, etc) to the 3rd mon
; still not clear which number corresponds to which status
; bit-wise system?
; 1, 2 = SLP
; 10 = PSN but is also SLP
;	ld a, 10
;	ld de, wPartyMon3Status
;	ld [de], a

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

    ; set Pikachu happiness and mood to max
    ld a, $FF
    ld [wPikachuHappiness], a
    ld [wPikachuMood], a

	ld a, $1
	ld [wChampionsRoomCurScript], a

	SetEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE

	SetEvent EVENT_DEFEATED_MISSINGNO

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

	ret

DebugSetPokedexEntries:
	ld b, wPokedexOwnedEnd - wPokedexOwned - 1
	ld a, %11111111
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ld [hl], %00000001
	ret

SamuelNameForPikachu3: db "SAMUEL @" ; new, with a space to make it harder for players to emulate it

DebugItemsList:
	db RARE_CANDY, 42
	db LINK_CABLE, 3
    db UPGRADE, 3
	db MYSTERY_MAP, 1
    db ONIGIRI_BOX, 99
	db CHROMOGENE, 99
	db TM_CURSE, 3
	db MASTER_BALL, 99
	db TOWN_MAP, 1
	db BICYCLE, 1
	db FULL_RESTORE, 99
	db SECRET_KEY, 1
	db CARD_KEY, 1
	db REVIVE, 99
	db S_S_TICKET, 1
	db LIFT_KEY, 1
	db POKE_FLUTE, 1
	db ESCAPE_ROPE, 99
	db LEGEND_CANDY, 42
	db GOLD_TEETH, 1
	db SILPH_SCOPE, 1
    ; 20
    db ICE_ORB, 1
    db THUNDER_ORB, 1
    db FIRE_ORB, 1
	db TM_MEGA_PUNCH, 3
	db MAX_REPEL, 3
	db LUNAR_RELIC, 1
	db POTION, 99 ; PP_UP, 42
	db MEGA_STONE_X, 99
	db MEGA_STONE_Y, 99
	db LAVA_STONE, 1
	db MAGMA_STONE, 1
	db MOLTEN_STONE, 1
;	db EXP_ALL, 1
    db SHINY_CHARM, 1
    db LIGHT_BALL, 1
    db PERFECTER, 99
    db ULTRA_BALL, 99
    db GREAT_BALL, 99
    db HM_CUT, 1
    db HM_FLASH, 1
    ; 39
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
