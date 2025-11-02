; d contains the Pokemon you want to check
; sets carry flag if found
CheckIfOneGivenMonIsInParty::
	ld hl, wPartyCount
	ld a, [hli]
	ld b, a ; b has the number of Mons in the party
.loop
	ld a, [hli]
	cp d
	jp z, .targetInParty
	dec b
	jr nz, .loop
	cp 0 ; a is always >=1, so when we do cp 0 the carry flag is never set (a-0)
	ret
.targetInParty
	scf ; set carry flag
	ret

; =====================================

; input: d contains the type to check
; sets z flag if found
CheckIfACertainTypeIsInParty::
	ld hl, wPartyCount
	ld a, [hli]
	ld b, a ; b has the number of Mons in the party

.loop
	ld a, [hli] ; Mon ID
	ld [wd0b5], a
	call GetMonHeader
	ld a, [wMonHType1]
	cp d
	ret z
	ld a, [wMonHType2]
	cp d
	ret z
; if we're here, neither type1 or type2 match the type we're searching
; in which case, we go to the next mon
	dec b
	jr nz, .loop
; if we're here, we ran out of mons to check
	inc b ; this returns b to 1, and un-sets the z flag
	ret

; =====================================

; output: d and/or e contain the shared type, otherwise, $FF
CheckIfAllMonsShareAType::
	ld hl, wPartyCount
	ld a, [hli]
	ld b, a ; b has the number of Mons in the party

; save TYPE1 and TYPE2 of Mon1 of the team in d and e
; in wMultipurposeBuffer (+1) ?
	ld a, [hli] ; Mon1 ID

	ld [wd0b5], a
	call GetMonHeader
	ld a, [wMonHType1]
	ld d, a
	ld a, [wMonHType2]
	ld e, a

	ld a, b
	cp 1
	ret z ; if there's only 1 mon, of course it's ok
	push hl
	push bc

; check if TYPE1 of the Mon1 is shared by all other Mons
.loop1
	dec b
	jr z, .checkAlsoSecondType ; we checked them all
	ld a, [hli] ; (next) pokemon ID
	ld [wd0b5], a
	call GetMonHeader ; does not alter bc, hl, de
	ld a, [wMonHType1]
	cp d ; TYPE1-MonN vs TYPE1-Mon1
	jr z, .loop1 ; if it's shared we continue, otherwise we check the other type
	ld a, [wMonHType2]
	cp d ; TYPE2-MonN vs TYPE1-Mon1
	jr z, .loop1

	ld d, $FF ; load failure value in d if we found no match
.checkAlsoSecondType
; check if TYPE2 of the Mon1 is shared by all other Mons
	pop bc ; restore number of mons
	pop hl ; restore pointer to 2nd Mon
.loop2
	dec b
	ret z ; we checked them all
	ld a, [hli] ; (next) pokemon ID
	ld [wd0b5], a
	call GetMonHeader ; does not alter bc, hl, de
	ld a, [wMonHType1]
	cp e ; TYPE1-MonN vs TYPE2-Mon1
	jr z, .loop2 ; if it's shared we continue, otherwise we check the other type
	ld a, [wMonHType2]
	cp e ; TYPE2-MonN vs TYPE2-Mon1
	jr z, .loop2

	ld e, $FF ; load failure value in e if we found no match
	ret

; =====================================

; output: nz flag if team contains a non-status move
CheckIfAllMovesAreStatusMoves::
	ld hl, wPartyMon1Moves
	ld c, 0 ; c = which pokemon we're on
.monLoop
	ld b, NUM_MOVES
.moveLoop
	ld a, [hl]
	and a
	jr z, .checkNextMon ; it's NO_MOVE=0

	dec a
	push hl
	push bc
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes ; adds bc to hl a times
	ld a, BANK(Moves)
	ld de, wPlayerMoveNum
	call FarCopyData ; copies bc bytes from a:hl to de
	pop bc
	pop hl

	ld a, [wPlayerMovePower]
	and a
	ret nz ; exit if the move has BP!=0

; check next move
	inc hl
	dec b
	jr nz, .moveLoop
; we checked all moves for the current mon
.checkNextMon
	ld a, [wPartyCount]
	inc c
	cp c
	jr nz, .continue
; exit with the z flag
	xor a
	and a ; to ensure z flag is set
	ret
.continue
	ld hl, wPartyMon1Moves
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	jr .monLoop

; =====================================

; output: c flag if "invalid"
CheckIfTeamValidForSeviiSagesRewards::

; TBE: add a check for levels: no above 100

	ld d, ANCESTOR_PWR
	callfar IsMoveInParty ; z flag = whether a match was found (z = not found; nz = found)
	scf
	ret nz
	ld hl, ListOfSeviiSagesInvalidMons
.loop
	ld a, [hli]
	cp -1
	ret z
	ld d, a
	push hl
	callfar CheckIfOneGivenMonIsInParty ; carry flag if yes
	pop hl
	ret c
	jr .loop

ListOfSeviiSagesInvalidMons:
	db ZYGARDEC
	db UNECROZMA
	db MRAYQUAZA
	db EETERNATUS
	db ARCEUS
	db MISSINGNO
	db -1

; =====================================

; INPUT: d contains the Map Piece ID
; OUTPUT: de is the pointes to the corresponding pic
ConvertMapIDToMapPicID::
	ld a, d ; a contains the map piece ID, >= MAP_PIECES_1
	ld de, MysteryMap1Pic
	cp MAP_PIECES_1
	ret z
	ld de, MysteryMap2Pic
	cp MAP_PIECES_2
	ret z
	ld de, MysteryMap3Pic
	cp MAP_PIECES_3
	ret z
	ld de, MysteryMap4Pic
	cp MAP_PIECES_4
	ret z
	ld de, MysteryMap12Pic
	cp MAP_PIECES_12
	ret z
	ld de, MysteryMap13Pic
	cp MAP_PIECES_13
	ret z
	ld de, MysteryMap14Pic
	cp MAP_PIECES_14
	ret z
	ld de, MysteryMap23Pic
	cp MAP_PIECES_23
	ret z
	ld de, MysteryMap24Pic
	cp MAP_PIECES_24
	ret z
	ld de, MysteryMap34Pic
	cp MAP_PIECES_34
	ret z
	ld de, MysteryMap123Pic
	cp MAP_PIECES_123
	ret z
	ld de, MysteryMap124Pic
	cp MAP_PIECES_124
	ret z
	ld de, MysteryMap134Pic
	cp MAP_PIECES_134
	ret z
	ld de, MysteryMap234Pic
	cp MAP_PIECES_234
	ret z
	ld de, MysteryMap1234Pic
	ret

; =====================================

TallGrassBillsSecretGardenCheckSteps::
	ld a, [wTallGrassBillsSecretGardenSteps]
	ld b, a
	ld a, [wTallGrassBillsSecretGardenSteps + 1]
	ld c, a
	or b
	jr z, .stepsOver
; decrease step counter by 1
	dec bc
	ld a, b
	ld [wTallGrassBillsSecretGardenSteps], a
	ld a, c
	ld [wTallGrassBillsSecretGardenSteps + 1], a
	ret
.stepsOver
	SetEvent EVENT_WALKED_ALL_STEPS_SECRET_GARDEN
	ret

; =====================================

Route32RespawnItemsCheckSteps::
	ld a, [wRoute32RespawnItemsSteps]
	ld b, a
	ld a, [wRoute32RespawnItemsSteps + 1]
	ld c, a
	or b
	jr z, .stepsOver
; decrease step counter by 1
	dec bc
	ld a, b
	ld [wRoute32RespawnItemsSteps], a
	ld a, c
	ld [wRoute32RespawnItemsSteps + 1], a
	ret
.stepsOver
	callfar ResetSeviiRoute32HiddenItems
	ld hl, 1000 ; e.g. 20 for testing purposes
	ld a, h
	ld [wRoute32RespawnItemsSteps], a
	ld a, l
	ld [wRoute32RespawnItemsSteps + 1], a
	ret

; =====================================

RandomizeTeamForBattleFacilityTrainer::
	ld de, wBattleFacilityMonNumber1
	ld a, [wBattleFacilityWhichMonIsRandomized]
	inc a
	ld [wBattleFacilityWhichMonIsRandomized], a
	dec a
	cp 5
	jr nc, .continue ; we don't need to move the address next if we are treating already the 6th mon
.storeMonAddressLoop
	dec a
	cp $FF
	jr z, .continue
	inc de
	jr .storeMonAddressLoop
.continue

; depending on battle mode, we choose ANY random (fully evolved) mon, or only out of 1-or-2 specific lists
	ld a, [wBattleFacilityBattleMode] ; 0 = standard, 1 = hardcore
	and a
	jr z, .standardBattleMode

; hardcore battle mode = we choose out of the bigger list of megas, legendaries, and other fully evo
.RNGLoopHardcore
	ld a, [wBattleFacilityPokemonPool] ; 0 for ANYTHING GOES, 1 for NFE, 2 for LC
	and a
	jr z, .poolAGHardcore
	cp 1
	jr z, .poolNFEHardcore
.poolLCHardcore
	ld hl, LittleCupPokemon
	call Random
	cp 66
	jr nc, .poolLCHardcore
	jr .uglyLoopHardcore
.poolNFEHardcore
	ld hl, NonFullyEvolvedPokemon
	call Random
	cp 28
	jr nc, .poolNFEHardcore
	jr .uglyLoopHardcore
.poolAGHardcore ; generate a random number between 0 and len(AllFinalStageMons)-1, i.e. 0 and 105 included
	ld hl, AllFinalStageMons
	call Random
	cp 106 ; 105+1
	jr nc, .RNGLoopHardcore
; a contains a valid number, now we need to access the a-th element of the list we decided about earlier
.uglyLoopHardcore
	dec a
	cp $FF
	jr z, .doneUglyLoopHardcore
	inc hl
	jr .uglyLoopHardcore
.doneUglyLoopHardcore
; finally, we need to check if the mon we just generated is the same as any of the previously generated ones
	ld a, [wBattleFacilityMonNumber1]
	cp [hl] ; hl points to the mon we are trying to generate
	jr z, .RNGLoopHardcore
	ld a, [wBattleFacilityMonNumber2]
	cp [hl] ; hl points to the mon we are trying to generate
	jr z, .RNGLoopHardcore
	ld a, [wBattleFacilityMonNumber3]
	cp [hl] ; hl points to the mon we are trying to generate
	jr z, .RNGLoopHardcore
	ld a, [wBattleFacilityMonNumber4]
	cp [hl] ; hl points to the mon we are trying to generate
	jr z, .RNGLoopHardcore
	ld a, [wBattleFacilityMonNumber5]
	cp [hl] ; hl points to the mon we are trying to generate
	jr z, .RNGLoopHardcore
	jp .doneOffset

.standardBattleMode ; depending on winning streak and which mon number, choose normal list or Megas' one
; but first let's check what pool to draw from, as only AG will have Megas
	ld a, [wBattleFacilityPokemonPool] ; 0 for ANYTHING GOES, 1 for NFE, 2 for LC
	and a
	jr z, .poolAGStandard
	cp 1
	jr z, .poolNFEStandard
.poolLCStandard
	ld hl, LittleCupPokemon
	call Random
	cp 66
	jr nc, .poolLCStandard
	jr .uglyLoopStandard
.poolNFEStandard
	ld hl, NonFullyEvolvedPokemon
	call Random
	cp 28
	jr nc, .poolNFEStandard
	jr .uglyLoopStandard
.poolAGStandard
	ld a, [wBattleFacilityWhichMonIsRandomized]
	ld hl, wBattleFacilityWinningStreak
	ld b, [hl] ; how many consecutive victories do we have in this session?
	add b ; now a contains a+b, i.e. which mon in the BF trainer team's is being randomized + how many victories we have
	cp 7 ; is the sum of a+b at least 7?
	jr nc, .RNGLoopMega ; if yes, load the list of megas; if not, load the list of non-mega mons

; loopS for non-Mega
.RNGLoop ; generate a random number between 0 and len(FullyEvolvedMons)-1, i.e. 0 and 84 included
	ld hl, FullyEvolvedMons
	call Random
	cp 85 ; 84+1
	jr nc, .RNGLoop

; a contains a valid number, now we need to access the a-th element of the list we decided about earlier
.uglyLoopStandard
	dec a
	cp $FF
	jr z, .doneUglyLoopStandard
	inc hl
	jr .uglyLoopStandard
.doneUglyLoopStandard
; finally, we need to check if the mon we just generated is the same as any of the previously generated ones
	ld a, [wBattleFacilityMonNumber1]
	cp [hl] ; hl points to the mon we are trying to generate
	jr z, .standardBattleMode
	ld a, [wBattleFacilityMonNumber2]
	cp [hl] ; hl points to the mon we are trying to generate
	jr z, .standardBattleMode
	ld a, [wBattleFacilityMonNumber3]
	cp [hl] ; hl points to the mon we are trying to generate
	jr z, .standardBattleMode
	ld a, [wBattleFacilityMonNumber4]
	cp [hl] ; hl points to the mon we are trying to generate
	jr z, .standardBattleMode
	ld a, [wBattleFacilityMonNumber5]
	cp [hl] ; hl points to the mon we are trying to generate
	jr z, .standardBattleMode
	jr .doneOffset

; loopS for Mega
.RNGLoopMega
	ld hl, MegaEvolvedMons
; generate a random number between 0 and len(MegaEvolvedMons)-1, i.e. 0 and 14 included (14 and not 16 because we skip Mega Mewtwos)
	call Random
	cp 15 ; 14+1
	jr nc, .RNGLoopMega
; a contains a valid number, now we need to access the a-th element of the list we decided about earlier
.uglyLoopMega
	dec a
	cp $FF
	jr z, .doneUglyLoopMega
	inc hl
	jr .uglyLoopMega
.doneUglyLoopMega
; finally, we need to check if the mon we just generated is the same as any of the previously generated ones
	ld a, [wBattleFacilityMonNumber1]
	cp [hl] ; hl points to the mon we are trying to generate
	jr z, .RNGLoopMega
	ld a, [wBattleFacilityMonNumber2]
	cp [hl] ; hl points to the mon we are trying to generate
	jr z, .RNGLoopMega
	ld a, [wBattleFacilityMonNumber3]
	cp [hl] ; hl points to the mon we are trying to generate
	jr z, .RNGLoopMega
	ld a, [wBattleFacilityMonNumber4]
	cp [hl] ; hl points to the mon we are trying to generate
	jr z, .RNGLoopMega
	ld a, [wBattleFacilityMonNumber5]
	cp [hl] ; hl points to the mon we are trying to generate
	jr z, .RNGLoopMega

.doneOffset
	ld a, [hl]
	ld [wcf91], a
	ld b, a
	ld a, [wBattleFacilityWhichMonIsRandomized]
	cp 6
	ret z ; if we're treating the 6th mon, we don't save anything in the non-existing wBattleFacilityMonNumber6, otherwise we mess up stuff
	ld a, b
	ld [de], a ; saves Mon in wBattleFacilityMonNumberN
	ret

AllAnythingGoesPokemon: ; 114: [0,113]
	db MEW ; only rival
	db VENUSTOISE ; only Oak
	db MISSINGNO ; only you
	db ZYGARDEC ; only Traveler
	db UNECROZMA ; only Traveler
	db MRAYQUAZA ; only Traveler
	db EETERNATUS ; only Traveler
	db ARCEUS ; only Traveler
AllFinalStageMons: ; 106: [0,105]
	db MEWTWO
	db ARTICUNO
	db ZAPDOS
	db MOLTRES
	db MMEWTWOX
	db MMEWTWOY
FullyEvolvedMons: ; 85: [0,84]
	; weaks
	db BUTTERFREE
	db BEEDRILL
	db CLEFABLE
	db WIGGLYTUFF
	db PARASECT
	db VENOMOTH
	db GOLDUCK
	db FARFETCHD
	db DEWGONG
	db MUK
	db HYPNO
	db KINGLER
	db ELECTRODE
	db MAROWAK
	db WEEZING
	db SEAKING
	db DITTO
	; average
	db PIDGEOT
	db RATICATE
	db FEAROW
	db ARBOK
	db RAICHU
	db SANDSLASH
	db NINETALES
	db CROBAT
	db VILEPLUME
	db BELLOSSOM
	db ARCANINE
	db POLIWRATH
	db POLITOED
	db GOLEM
	db RAPIDASH
	db DODRIO
	db HITMONLEE
	db HITMONCHAN
	db HITMONTOP
	db LICKILICKY
	db KANGASKHAN
	db MR_MIME
	db PINSIR
	db OMASTAR
	db KABUTOPS
	db VICTREEBEL
	db TENTACRUEL
	db SLOWKING
	db CLOYSTER
	db TANGROWTH
	db KLEAVOR
	db ELECTIVIRE
	db MAGMORTAR
	db AERODACTYL
	; strong
	db VENUSAUR
	db CHARIZARD
	db BLASTOISE
	db NIDOQUEEN
	db NIDOKING
	db DUGTRIO
	db PERSIAN
	db ANNIHILAPE
	db ALAKAZAM
	db SLOWBRO
	db MAGNEZONE
	db GENGAR
	db STEELIX
	db EXEGGUTOR
	db RHYPERIOR
	db BLISSEY
	db KINGDRA
	db STARMIE
	db SCIZOR
	db JYNX
	db TAUROS
	db GYARADOS
	db LAPRAS
	db SNORLAX
	db DRAGONITE
	db VAPOREON
	db JOLTEON
	db FLAREON
	db ESPEON
	db LEAFEON
	db GLACEON
	db SYLVEON
	db PORYGONZ
	db MACHAMP
MegaEvolvedMons: ; 15: [0,14]
	db MVENUSAUR
	db MCHARZARDX
	db MCHARZARDY
	db MBLASTOISE
	db MBEEDRILL
	db MPIDGEOT
	db MALAKAZAM
	db MSLOWBRO
	db MGENGAR
	db MSTEELIX
	db MKANGASKAN
	db MSCIZOR
	db MPINSIR
	db MGYARADOS
	db MARODACTYL
	db -1 ; ender for the pools checks

LittleCupPokemon: ; 66: [0,65]
	db BULBASAUR
	db CHARMANDER
	db SQUIRTLE
	db CATERPIE
	db WEEDLE
	db PIDGEY
	db RATTATA
	db SPEAROW
	db EKANS
	db PICHU
	db SANDSHREW
	db NIDORAN_F
	db NIDORAN_M
	db CLEFFA
	db VULPIX
	db IGGLYBUFF
	db ZUBAT
	db ODDISH
	db PARAS
	db VENONAT
	db DIGLETT
	db MEOWTH
	db PSYDUCK
	db MANKEY
	db GROWLITHE
	db POLIWAG
	db ABRA
	db MACHOP
	db BELLSPROUT
	db TENTACOOL
	db GEODUDE
	db PONYTA
	db SLOWPOKE
	db MAGNEMITE
	db DODUO
	db SEEL
	db GRIMER
	db SHELLDER
	db GASTLY
	db ONIX
	db DROWZEE
	db KRABBY
	db VOLTORB
	db EXEGGCUTE
	db CUBONE
	db TYROGUE
	db LICKITUNG
	db KOFFING
	db RHYHORN
	db HAPPINY
	db TANGELA
	db HORSEA
	db GOLDEEN
	db STARYU
	db MIME_JR
	db SCYTHER
	db SMOOCHUM
	db ELEKID
	db MAGBY
	db MAGIKARP
	db EEVEE
	db PORYGON
	db OMANYTE
	db KABUTO
	db MUNCHLAX
	db DRATINI
	db -1

NonFullyEvolvedPokemon: ; 28: [0,27]
	db IVYSAUR
	db CHARMELEON
	db WARTORTLE
	db METAPOD
	db KAKUNA
	db PIDGEOTTO
	db PIKACHU
	db NIDORINA
	db NIDORINO
	db CLEFAIRY
	db JIGGLYPUFF
	db GOLBAT
	db GLOOM
	db PRIMEAPE
	db POLIWHIRL
	db KADABRA
	db MACHOKE
	db WEEPINBELL
	db GRAVELER
	db MAGNETON
	db HAUNTER
	db RHYDON
	db CHANSEY
	db SEADRA
	db ELECTABUZZ
	db MAGMAR
	db PORYGON2
	db DRAGONAIR
	db -1

; =====================================

; c flag if the team has a non-allowed mon
CheckIfTeamIsValidForSelectedBFPool::
	ld de, wPartyCount
	ld a, [de]
	inc de
	ld c, a ; c holds the number of mons in player's team

.loopCheckForAG
	ld hl, AllAnythingGoesPokemon
	ld a, [de]
	inc de
	push de
	ld de, 1
	call IsInArray ; Search an array at hl for the value in a. Entry size is de bytes. Return count b and carry if found.
	pop de
	ret c
	dec c
	jr nz, .loopCheckForAG

; match AG not found, check if we need to look for NFE mons
	ld a, [wBattleFacilityPokemonPool] ; 1 for NFE, 2 for LC
	cp 1
	jr z, .matchNotFound

; we need to check for NFE too
	ld de, wPartyCount
	ld a, [de]
	inc de
	ld c, a ; c holds the number of mons in player's team
.loopCheckForNFE
	ld hl, NonFullyEvolvedPokemon
	ld a, [de]
	inc de
	push de
	ld de, 1
	call IsInArray ; Search an array at hl for the value in a. Entry size is de bytes. Return count b and carry if found.
	pop de
	ret c
	dec c
	jr nz, .loopCheckForNFE

.matchNotFound
	and a ; to reset the c flag
	ret

; =====================================

RandomizeTeamForRandomizationOption::
; let's not randomize PIGEON, TRAVELER, MISSINGNO_T, COPYCAT, OAK, and SAGES
	CheckEvent EVENT_IN_SEVII
	jr nz, .checkByTrainer
	ld a, [wCurMap]
	cp COPYCATS_HOUSE_1F
	ret z
.checkByTrainer
	ld a, [wCurOpponent]
	cp OPP_PIGEON
	ret z
	cp OPP_TRAVELER
	ret z
	cp OPP_MISSINGNO_T
	ret z
	cp OPP_PROF_OAK
	ret z
	cp OPP_ICHINO
	ret z
	cp OPP_NIUE
	ret z
	cp OPP_SANTRE
	ret z
	cp OPP_YOTTRO
	ret z
	cp OPP_GONQUE
	ret z
	cp OPP_ROKUSEI
	ret z
	cp OPP_NANETTE
	ret z
	cp OPP_SUUJERO
	ret z
; and we want to give a broken team to the Champion's "mega team"
	cp OPP_RIVAL3
	jr nz, .normalRandomization
; opponent is Rival3, now we need to check if it's the right number
	ld a, [wTrainerNo]
	cp 1
	jr z, .RNGLoopMega
	cp 3
	jr z, .RNGLoopMega
	cp 5
	jr z, .RNGLoopMega
	jr .normalRandomization
; let's give the champion's "mega team" only megas
.RNGLoopMega
	ld hl, MegaEvolvedMons
; generate a random number between 0 and len(MegaEvolvedMons)-1, i.e. 0 and 16 included
	call Random
	cp 17 ; 16+1
	jr nc, .RNGLoopMega
; a contains a valid number, now we need to access the a-th element of the list we decided about earlier
.uglyLoopMega
	dec a
	cp $FF
	jr z, .doneUglyLoopMega
	inc hl
	jr .uglyLoopMega
.doneUglyLoopMega
	ld a, [hl]
	jr .conclude
.normalRandomization ; double label just for clarity
.sanityLoop
	call Random
	cp 0
	jr z, .sanityLoop ; we don't want the non-pokemon with index 0
	cp NUM_POKEMON_RANDOMIZABLE+1
	jr nc, .sanityLoop ; we don't want anything beyond Venustoise
.conclude
	ld [wcf91], a
	ret

; =====================================

TMMartClerkDialogue::
	ld a, 1
	ld [wUpdateSpritesEnabled], a

	ld de, wItemList

	inc de ; needed later to write down the number of TMs available
	ld b, 0 ; used as a counter of the number of TMs on sale

; 55 custom additions ----------------------------------------------------

	; TM01
	CheckHideShow HS_MT_MOON_B2F_ITEM_2
	jr z, .checkTM02
	ld a, TM_MEGA_PUNCH
	ld [de], a
	inc de
	inc b
.checkTM02

	; TM02
	CheckHideShow HS_ROCKET_HIDEOUT_B4F_ITEM_2
	jr z, .checkTM03
	ld a, TM_MEGAHORN
	ld [de], a
	inc de
	inc b
.checkTM03

	; TM03
	CheckHideShow HS_SILPH_CO_7F_ITEM_2
	jr z, .checkTM04
	ld a, TM_SWORDS_DANCE
	ld [de], a
	inc de
	inc b
.checkTM04

	; TM04
	CheckHideShow HS_ROUTE_4_ITEM_1
	jr z, .checkTM05
	ld a, TM_COUNTER
	ld [de], a
	inc de
	inc b
.checkTM05

	; TM05
	CheckHideShow HS_VICTORY_ROAD_2F_ITEM_3
	jr z, .checkTM06
	ld a, TM_DRAGON_CLAW
	ld [de], a
	inc de
	inc b
.checkTM06

	; TM06
	CheckEvent EVENT_GOT_TM06
	jr z, .checkTM07
	ld a, TM_TOXIC
	ld [de], a
	inc de
	inc b
.checkTM07

	; TM07
	CheckHideShow HS_ROCKET_HIDEOUT_B2F_ITEM_3
	jr z, .checkTM08
	ld a, TM_DARK_PULSE
	ld [de], a
	inc de
	inc b
.checkTM08

	; TM08
	CheckHideShow HS_SS_ANNE_1F_ROOMS_ITEM
	jr z, .checkTM09
	ld a, TM_BODY_SLAM
	ld [de], a
	inc de
	inc b
.checkTM09

	; TM09
	CheckHideShow HS_OBSIDIAN_WAREHOUSE_ITEM_2
	jr z, .checkTM10
	ld a, TM_METEOR_MASH
	ld [de], a
	inc de
	inc b
.checkTM10

	; TM10
	CheckHideShow HS_ROCKET_HIDEOUT_B3F_ITEM_1
	jr z, .checkTM11
	ld a, TM_DOUBLE_EDGE
	ld [de], a
	inc de
	inc b
.checkTM11

	; TM11
	CheckEvent EVENT_GOT_TM11
	jr z, .checkTM12
	ld a, TM_BUBBLEBEAM
	ld [de], a
	inc de
	inc b
.checkTM12

	; TM12
	CheckHideShow HS_MT_MOON_1F_ITEM_6
	jr z, .checkTM13
	ld a, TM_METRONOME
	ld [de], a
	inc de
	inc b
.checkTM13

	; TM13
	CheckEvent EVENT_GOT_TM13
	jr z, .checkTM14
	ld a, TM_ICE_BEAM
	ld [de], a
	inc de
	inc b
.checkTM14

	; TM14
	CheckHideShowExtra HS_POKEMON_MANSION_B1F_ITEM_3
	jr z, .checkTM15
	ld a, TM_BLIZZARD
	ld [de], a
	inc de
	inc b
.checkTM15

	; TM15
	CheckEvent EVENT_OBTAINED_PRIZE_TM_2
	jr z, .checkTM16
	ld a, TM_HYPER_BEAM
	ld [de], a
	inc de
	inc b
.checkTM16

	; TM16
	CheckHideShow HS_ROUTE_12_ITEM_1
	jr z, .checkTM17
	ld a, TM_MIRROR_COAT
	ld [de], a
	inc de
	inc b
.checkTM17

	; TM17
	CheckHideShow HS_VICTORY_ROAD_2F_ITEM_1
	jr z, .checkTM18
	ld a, TM_DRAININGKISS
	ld [de], a
	inc de
	inc b
.checkTM18

	; TM18
	CheckEvent EVENT_GOT_TM18
	jr z, .checkTM19
	ld a, TM_FLASH_CANNON
	ld [de], a
	inc de
	inc b
.checkTM19

	; TM19
	CheckHideShow HS_ROUTE_25_ITEM
	jr z, .checkTM20
	ld a, TM_SEISMIC_TOSS
	ld [de], a
	inc de
	inc b
.checkTM20

	; TM20
	CheckHideShow HS_ROUTE_15_ITEM
	jr z, .checkTM21
	ld a, TM_FEINT_ATTACK
	ld [de], a
	inc de
	inc b
.checkTM21

	; TM21
	CheckEvent EVENT_GOT_TM21
	jr z, .checkTM22
	ld a, TM_GIGA_DRAIN
	ld [de], a
	inc de
	inc b
.checkTM22

	; TM22
	CheckHideShowExtra HS_POKEMON_MANSION_B1F_ITEM_4
	jr z, .checkTM23
	ld a, TM_STONE_EDGE
	ld [de], a
	inc de
	inc b
.checkTM23

	; TM23
	CheckEvent EVENT_OBTAINED_PRIZE_TM_1
	jr z, .checkTM24
	ld a, TM_WILL_O_WISP
	ld [de], a
	inc de
	inc b
.checkTM24

	; TM24
	CheckEvent EVENT_GOT_TM24
	jr z, .checkTM25
	ld a, TM_THUNDERBOLT
	ld [de], a
	inc de
	inc b
.checkTM25

	; TM25
	CheckHideShow HS_POWER_PLANT_ITEM_3
	jr z, .checkTM26
	ld a, TM_THUNDER
	ld [de], a
	inc de
	inc b
.checkTM26

	; TM26
	CheckHideShow HS_SILPH_CO_10F_ITEM_1
	jr z, .checkTM27
	ld a, TM_EARTHQUAKE
	ld [de], a
	inc de
	inc b
.checkTM27

	; TM27
	CheckEvent EVENT_BEAT_VIRIDIAN_GYM_GIOVANNI
	jr z, .checkTM28
	ld a, TM_FISSURE
	ld [de], a
	inc de
	inc b
.checkTM28

	; TM28
	CheckHideShow HS_CERULEAN_ROCKET
	jr z, .checkTM29
	ld a, TM_DIG
	ld [de], a
	inc de
	inc b
.checkTM29

	; TM29
	CheckEvent EVENT_GOT_TM29
	jr z, .checkTM30
	ld a, TM_PSYCHIC_M
	ld [de], a
	inc de
	inc b
.checkTM30

	; TM30
	CheckHideShow HS_ROUTE_9_ITEM
	jr z, .checkTM31
	ld a, TM_MOONBLAST
	ld [de], a
	inc de
	inc b
.checkTM31

	; TM31
	CheckEvent EVENT_GOT_TM31
	jr z, .checkTM32
	ld a, TM_MIMIC
	ld [de], a
	inc de
	inc b
.checkTM32

	; TM32
	CheckHideShowExtra HS_SAFARI_ZONE_WEST_ITEM_2
	jr z, .checkTM33
	ld a, TM_DOUBLE_TEAM
	ld [de], a
	inc de
	inc b
.checkTM33

	; TM33
	CheckHideShow HS_ROUTE_24_ITEM_1
	jr z, .checkTM34
	ld a, TM_REFLECT
	ld [de], a
	inc de
	inc b
.checkTM34

	; TM34
	CheckEvent EVENT_GOT_TM34
	jr z, .checkTM35
	ld a, TM_BIDE
	ld [de], a
	inc de
	inc b
.checkTM35

	; TM35
	CheckEvent EVENT_GOT_TM35
	jr z, .checkTM36
	ld a, TM_HYDRO_PUMP
	ld [de], a
	inc de
	inc b
.checkTM36

	; TM36
	CheckEvent EVENT_GOT_TM36
	jr z, .checkTM37
	ld a, TM_SELFDESTRUCT
	ld [de], a
	inc de
	inc b
.checkTM37

	; TM37
	CheckHideShowExtra HS_SAFARI_ZONE_EAST_ITEM_4
	jr z, .checkTM38
	ld a, TM_CLOSE_COMBAT
	ld [de], a
	inc de
	inc b
.checkTM38

	; TM38
	CheckEvent EVENT_GOT_TM38
	jr z, .checkTM39
	ld a, TM_FIRE_BLAST
	ld [de], a
	inc de
	inc b
.checkTM39

	; TM39
	CheckEvent EVENT_GOT_TM39
	jr z, .checkTM40
	ld a, TM_SHADOW_SNEAK
	ld [de], a
	inc de
	inc b
.checkTM40

	; TM40
	CheckHideShowExtra HS_SAFARI_ZONE_NORTH_ITEM_2
	jr z, .checkTM41
	ld a, TM_OUTRAGE
	ld [de], a
	inc de
	inc b
.checkTM41

	; TM41
	CheckEvent EVENT_GOT_TM41
	jr z, .checkTM42
	ld a, TM_BRAVE_BIRD
	ld [de], a
	inc de
	inc b
.checkTM42

	; TM42
	CheckEvent EVENT_GOT_TM42
	jr z, .checkTM43
	ld a, TM_REST
	ld [de], a
	inc de
	inc b
.checkTM43

	; TM43
	CheckHideShowExtra HS_VICTORY_ROAD_1F_ITEM_1
	jr z, .checkTM44
	ld a, TM_GUNK_SHOT
	ld [de], a
	inc de
	inc b
.checkTM44

	; TM44
	CheckHideShow HS_SS_ANNE_B1F_ROOMS_ITEM_2
	jr z, .checkTM45
	ld a, TM_X_SCISSOR
	ld [de], a
	inc de
	inc b
.checkTM45

	; TM45
	CheckHideShow HS_POWER_PLANT_ITEM_4
	jr z, .checkTM46
	ld a, TM_THUNDER_WAVE
	ld [de], a
	inc de
	inc b
.checkTM46

	; TM46
	CheckEvent EVENT_GOT_TM46
	jr z, .checkTM47
	ld a, TM_PSYWAVE
	ld [de], a
	inc de
	inc b
.checkTM47

	; TM47
	CheckHideShow HS_VICTORY_ROAD_3F_ITEM_2
	jr z, .checkTM48
	ld a, TM_EXPLOSION
	ld [de], a
	inc de
	inc b
.checkTM48

	; TM48
	CheckEvent EVENT_GOT_TM48
	jr z, .checkTM49
	ld a, TM_ROCK_SLIDE
	ld [de], a
	inc de
	inc b
.checkTM49

	; TM49
	CheckEvent EVENT_GOT_TM49
	jr z, .checkTM50
	ld a, TM_SHADOW_BALL
	ld [de], a
	inc de
	inc b
.checkTM50

	; TM50
	CheckEvent EVENT_OBTAINED_PRIZE_TM_3
	jr z, .checkTM51
	ld a, TM_SUBSTITUTE
	ld [de], a
	inc de
	inc b
.checkTM51

	; TM51
	CheckEvent EVENT_GOT_TM51
	jr z, .checkTM52
	ld a, TM_FREEZE_DRY
	ld [de], a
	inc de
	inc b
.checkTM52

	; TM52
	CheckHideShow HS_OBSIDIAN_WAREHOUSE_ITEM_4
	jr z, .checkTM53
	ld a, TM_GYRO_BALL
	ld [de], a
	inc de
	inc b
.checkTM53

	; TM53
	CheckHideShowExtra HS_ONIX_BURROWING_ITEM
	jr z, .checkTM54
	ld a, TM_BODY_PRESS
	ld [de], a
	inc de
	inc b
.checkTM54

	; TM54
	CheckEvent EVENT_GOT_TM54
	jr z, .checkTM55
	ld a, TM_FLAIL
	ld [de], a
	inc de
	inc b
.checkTM55

	; TM55
	CheckHideShow HS_ROUTE_4_ITEM_2
	jr z, .checkTMDONE
	ld a, TM_CURSE
	ld [de], a
	inc de
	inc b
.checkTMDONE

; ender of the custom itemlist load function -----------------------------------
	ld a, -1
	ld [de], a

; check if already 1 TM is loaded
	ld a, b ; a should contain the number of TMs loaded
	and a
	jr z, .noTMsFound

; there is at least 1 TM in the least, let's load this value in the right place
	ld de, wItemList
	ld [de], a
	jr .atLeastOneTM

.noTMsFound
	ld hl, TMPokemartGreetingTextFoundNone
	call PrintText
	ret

.atLeastOneTM
	ld hl, TMPokemartGreetingText
	call PrintText

	ld a, PRICEDITEMLISTMENU
	ld [wListMenuID], a
	callfar DisplayPokemartDialogue_

	ret

; ------------------------

TMPokemartGreetingTextFoundNone:
    text_far _TMPokemartGreetingTextFoundNone
    text_end

TMPokemartGreetingText:
    text_far _TMPokemartGreetingText
    text_end

; =====================================

PrintBattleInfoCore::
	hlcoord 0, 0
	lb bc, SCREEN_HEIGHT - 2, SCREEN_WIDTH - 2
	call TextBoxBorder

	hlcoord 4, 1
	ld de, BattleInfoTitleText
	call PlaceString

; weather
	hlcoord 1, 3
	ld de, BattleInfoWeatherText
	call PlaceString
; choose which weather to print
	hlcoord 9, 3
	ld de, BattleInfoWeatherRainyText
	CheckEvent EVENT_WEATHER_RAIN_DANCE
	jr nz, .printWeather
	ld de, BattleInfoWeatherSunnyText
	CheckEvent EVENT_WEATHER_SUNNY_DAY
	jr nz, .printWeather
	ld de, BattleInfoWeatherSandstormText
	CheckEvent EVENT_WEATHER_SANDSTORM
	jr nz, .printWeather
	ld de, BattleInfoWeatherHailText
	CheckEvent EVENT_WEATHER_HAIL
	jr nz, .printWeather
	ld de, BattleInfoNullText
.printWeather
	call PlaceString
; print number of turns and caster
	ld a, [wWeatherCounterPlayer]
	and a
	jr nz, .printTurnsWeather
	ld a, [wWeatherCounterEnemy]
	and a
	jr nz, .printTurnsWeather
	jr .doneWithWeather
.printTurnsWeather
	hlcoord 17, 3
	call PrintOneDigitNumber
	ld de, LeftParenthesisString
	hlcoord 16, 3
	call PlaceString
	ld de, RightParenthesisString
	hlcoord 18, 3
	call PlaceString
.doneWithWeather

; terrain
	hlcoord 1, 5
	ld de, BattleInfoTerrainText
	call PlaceString
; choose which terrain to print
	hlcoord 8, 5
	ld de, BattleInfoTerrainMistyText
	CheckEvent EVENT_TERRAIN_MISTY
	jr nz, .printTerrain
	ld de, BattleInfoTerrainGrassyText
	CheckEvent EVENT_TERRAIN_GRASSY
	jr nz, .printTerrain
	ld de, BattleInfoTerrainPsychicText
	CheckEvent EVENT_TERRAIN_PSYCHIC
	jr nz, .printTerrain
	ld de, BattleInfoTerrainElectricText
	CheckEvent EVENT_TERRAIN_ELECTRIC
	jr nz, .printTerrain
	ld de, BattleInfoNullText
.printTerrain
	call PlaceString
; print number of turns and caster
	ld a, [wTerrainCounterPlayer]
	and a
	jr nz, .printTurnsTerrain
	ld a, [wTerrainCounterEnemy]
	and a
	jr nz, .printTurnsTerrain
	jr .doneWithTerrain
.printTurnsTerrain
	hlcoord 17, 5
	call PrintOneDigitNumber
	ld de, LeftParenthesisString
	hlcoord 16, 5
	call PlaceString
	ld de, RightParenthesisString
	hlcoord 18, 5
	call PlaceString
.doneWithTerrain

; trick room
	hlcoord 1, 7
	ld de, BattleInfoTrickRoomText
	call PlaceString
; check whether trick room is active or not
	hlcoord 11, 7
	ld de, BattleInfoTrickRoomActiveText
	CheckEvent EVENT_TRICK_ROOM
	jr nz, .printTrickRoom
	ld de, BattleInfoNullText
.printTrickRoom
	call PlaceString
; print number of turns and caster
	ld a, [wTrickRoomCounterPlayer]
	and a
	jr nz, .printTurnsTrickRoom
	ld a, [wTrickRoomCounterEnemy]
	and a
	jr nz, .printTurnsTrickRoom
	jr .doneWithTrickRoom
.printTurnsTrickRoom
	hlcoord 17, 7
	call PrintOneDigitNumber
	ld de, LeftParenthesisString
	hlcoord 16, 7
	call PlaceString
	ld de, RightParenthesisString
	hlcoord 18, 7
	call PlaceString
.doneWithTrickRoom

; player and enemy headers
	hlcoord 2, 9
	ld de, BattleInfoPlayerText
	call PlaceString
	hlcoord 9, 9
	ld de, BattleInfoSlashText
	call PlaceString
	hlcoord 12, 9
	ld de, BattleInfoEnemyText
	call PlaceString

; entry hazards names, player side
	hlcoord 1, 11
	ld de, BattleInfoEntryHazardAndScreensText_Spk
	call PlaceString
	hlcoord 1, 12
	ld de, BattleInfoEntryHazardAndScreensText_Tox
	call PlaceString
	hlcoord 1, 13
	ld de, BattleInfoEntryHazardAndScreensText_Rok
	call PlaceString
	hlcoord 1, 14
	ld de, BattleInfoEntryHazardAndScreensText_Web
	call PlaceString
	hlcoord 1, 15
	ld de, BattleInfoEntryHazardAndScreensText_Ref
	call PlaceString
	hlcoord 1, 16
	ld de, BattleInfoEntryHazardAndScreensText_Lig
	call PlaceString
; entry hazards names, enemy side
	hlcoord 14, 11
	ld de, BattleInfoEntryHazardAndScreensText_Spk
	call PlaceString
	hlcoord 14, 12
	ld de, BattleInfoEntryHazardAndScreensText_Tox
	call PlaceString
	hlcoord 14, 13
	ld de, BattleInfoEntryHazardAndScreensText_Rok
	call PlaceString
	hlcoord 14, 14
	ld de, BattleInfoEntryHazardAndScreensText_Web
	call PlaceString
	hlcoord 14, 15
	ld de, BattleInfoEntryHazardAndScreensText_Ref
	call PlaceString
	hlcoord 14, 16
	ld de, BattleInfoEntryHazardAndScreensText_Lig
	call PlaceString
; entry hazards values, player side
	hlcoord 4, 11
	ld a, [wHazardsSpikesPlayerSide]
	call PrintOneDigitNumber_SpecialZero
	hlcoord 4, 12
	ld a, [wHazardsToxicSpikesPlayerSide]
	call PrintOneDigitNumber_SpecialZero
	hlcoord 4, 13
	ld a, [wHazardsStealthRockPlayerSide]
	call PrintOneDigitNumber_SpecialZero
	hlcoord 4, 14
	ld a, [wHazardsStickyWebPlayerSide]
	call PrintOneDigitNumber_SpecialZero
	ld de, wPlayerBattleStatus3
	hlcoord 4, 15
	call PrintReflectStatus
	ld de, wPlayerBattleStatus3
	hlcoord 4, 16
	call PrintLightScreenStatus
; entry hazards values, enemy side
	hlcoord 17, 11
	ld a, [wHazardsSpikesEnemySide]
	call PrintOneDigitNumber_SpecialZero
	hlcoord 17, 12
	ld a, [wHazardsToxicSpikesEnemySide]
	call PrintOneDigitNumber_SpecialZero
	hlcoord 17, 13
	ld a, [wHazardsStealthRockEnemySide]
	call PrintOneDigitNumber_SpecialZero
	hlcoord 17, 14
	ld a, [wHazardsStickyWebEnemySide]
	call PrintOneDigitNumber_SpecialZero
	ld de, wEnemyBattleStatus3
	hlcoord 17, 15
	call PrintReflectStatus
	ld de, wEnemyBattleStatus3
	hlcoord 17, 16
	call PrintLightScreenStatus

; stat modifiers names
	hlcoord 7, 11
	ld de, BattleInfoBuffsText_Atk
	call PlaceString
	hlcoord 7, 12
	ld de, BattleInfoBuffsText_Def
	call PlaceString
	hlcoord 7, 13
	ld de, BattleInfoBuffsText_Spd
	call PlaceString
	hlcoord 7, 14
	ld de, BattleInfoBuffsText_Spc
	call PlaceString
	hlcoord 7, 15
	ld de, BattleInfoBuffsText_Acc
	call PlaceString
	hlcoord 7, 16
	ld de, BattleInfoBuffsText_Eva
	call PlaceString
; stat modifiers values, player side
	hlcoord 6, 11
	ld a, [wPlayerMonAttackMod]
	call PrintHumanStringFromStatModifier
	hlcoord 6, 12
	ld a, [wPlayerMonDefenseMod]
	call PrintHumanStringFromStatModifier
	hlcoord 6, 13
	ld a, [wPlayerMonSpeedMod]
	call PrintHumanStringFromStatModifier
	hlcoord 6, 14
	ld a, [wPlayerMonSpecialMod]
	call PrintHumanStringFromStatModifier
	hlcoord 6, 15
	ld a, [wPlayerMonAccuracyMod]
	call PrintHumanStringFromStatModifier
	hlcoord 6, 16
	ld a, [wPlayerMonEvasionMod]
	call PrintHumanStringFromStatModifier
; stat modifiers values, enemy side
	hlcoord 11, 11
	ld a, [wEnemyMonAttackMod]
	call PrintHumanStringFromStatModifier
	hlcoord 11, 12
	ld a, [wEnemyMonDefenseMod]
	call PrintHumanStringFromStatModifier
	hlcoord 11, 13
	ld a, [wEnemyMonSpeedMod]
	call PrintHumanStringFromStatModifier
	hlcoord 11, 14
	ld a, [wEnemyMonSpecialMod]
	call PrintHumanStringFromStatModifier
	hlcoord 11, 15
	ld a, [wEnemyMonAccuracyMod]
	call PrintHumanStringFromStatModifier
	hlcoord 11, 16
	ld a, [wEnemyMonEvasionMod]
	call PrintHumanStringFromStatModifier

	ret

; ------------------------

BattleInfoTitleText:
	db "BATTLE INFO:@"

BattleInfoNullText:
	db "--@"

BattleInfoSlashText:
	db "/@"

BattleInfoWeatherText:
	db "WEATH.:@"
BattleInfoWeatherRainyText:
	db "RAINY@"
BattleInfoWeatherSunnyText:
	db "SUNNY@"
BattleInfoWeatherSandstormText:
	db "SANDY@"
BattleInfoWeatherHailText:
	db "HAIL@"

BattleInfoTerrainText:
	db "TERR.:@"
BattleInfoTerrainMistyText:
	db "MISTY@"
BattleInfoTerrainGrassyText:
	db "GRASSY@"
BattleInfoTerrainPsychicText:
	db "PSYCHIC@"
BattleInfoTerrainElectricText:
	db "ELECTRIC@"

BattleInfoTrickRoomText:
	db "TRICK R.:@"
BattleInfoTrickRoomActiveText:
	db "ON@"

BattleInfoEntryHazardAndScreensText_Spk:
	db "SPK@"
BattleInfoEntryHazardAndScreensText_Tox:
	db "TOX@"
BattleInfoEntryHazardAndScreensText_Rok:
	db "ROK@"
BattleInfoEntryHazardAndScreensText_Web:
	db "WEB@"
BattleInfoEntryHazardAndScreensText_Ref:
	db "REF@"
BattleInfoEntryHazardAndScreensText_Lig:
	db "LIG@"

BattleInfoBuffsText_Atk:
	db " ATK @"
BattleInfoBuffsText_Def:
	db " DEF @"
BattleInfoBuffsText_Spd:
	db " SPD @"
BattleInfoBuffsText_Spc:
	db " SPC @"
BattleInfoBuffsText_Acc:
	db " ACC @"
BattleInfoBuffsText_Eva:
	db " EVA @"

BattleInfoPlayerText:
	db "PLAYER@"
BattleInfoEnemyText:
	db "ENEMY@"

LeftParenthesisString:
	db "(@"
RightParenthesisString:
	db ")@"

; ------------------------

; inputs:
; de = wXBattleStatus3
; hl = coordinates (already provided in hlcoord format)
PrintReflectStatus:
	ld a, [de]
	bit HAS_REFLECT_UP, a
	jr nz, PrintLightScreenStatus.bitSet
	jr PrintLightScreenStatus.bitNotSet
PrintLightScreenStatus:
	ld a, [de]
	bit HAS_LIGHT_SCREEN_UP, a
	jr nz, .bitSet
.bitNotSet
	ld de, BitNotSetString
	jr .end
.bitSet
	ld de, BitSetString
.end
	call PlaceString
	ret

BitSetString:
	db "1@"
BitNotSetString:
	db "-@"

; ------------------------

; inputs:
; a = stat modifier (1 to 13, 7=neutral)
; hl = coordinates (already provided in hlcoord format)
PrintHumanStringFromStatModifier:
	cp 7
	ret z ; do nothing if it's default
	ld de, StatModifier13String
	cp 13
	jr z, .end
	ld de, StatModifier12String
	cp 12
	jr z, .end
	ld de, StatModifier11String
	cp 11
	jr z, .end
	ld de, StatModifier10String
	cp 10
	jr z, .end
	ld de, StatModifier9String
	cp 9
	jr z, .end
	ld de, StatModifier8String
	cp 8
	jr z, .end
	ld de, StatModifier6String
	cp 6
	jr z, .end
	ld de, StatModifier5String
	cp 5
	jr z, .end
	ld de, StatModifier4String
	cp 4
	jr z, .end
	ld de, StatModifier3String
	cp 3
	jr z, .end
	ld de, StatModifier2String
	cp 2
	jr z, .end
	ld de, StatModifier1String
.end
	call PlaceString
	ret

StatModifier13String:
	db "+6@"
StatModifier12String:
	db "+5@"
StatModifier11String:
	db "+4@"
StatModifier10String:
	db "+3@"
StatModifier9String:
	db "+2@"
StatModifier8String:
	db "+1@"
; missing 7, default
StatModifier6String:
	db "-1@"
StatModifier5String:
	db "-2@"
StatModifier4String:
	db "-3@"
StatModifier3String:
	db "-4@"
StatModifier2String:
	db "-5@"
StatModifier1String:
	db "-6@"

; ------------------------

; inputs:
; a = 1-digit number we want to print
; hl = coordinates
PrintOneDigitNumber:
	ld b, "0"
	add b
	ld [hl], a
	ret

PrintOneDigitNumber_SpecialZero:
	and a
	jr nz, PrintOneDigitNumber
	ld [hl], "-"
	ret

; =====================================

LoadHiddenMonNickAndSprite::
	ld hl, wEnemyMonNick  ; set name to "??????"
	ld a, "?"
	ld [hli], a
	ld a, "?"
	ld [hli], a
	ld a, "?"
	ld [hli], a
	ld a, "?"
	ld [hli], a
	ld a, "?"
	ld [hli], a
	ld a, "?"
	ld [hli], a
	ld [hl], "@"

	call ClearSprites
	hlcoord 0, 0
	lb bc, 4, 11
	call ClearScreenArea
	ld b, SET_PAL_BATTLE
	call RunPaletteCommand
	call GBPalNormal
	ld hl, TrainerSentOutText2
	call PrintText
	ld a, [wEnemyMonSpecies2]
	ld [wcf91], a
	push af ; new
	ld [wd0b5], a

	ld hl, wMonHSpriteDim
	ld a, $66
	ld [hli], a   ; write sprite dimensions
	ld bc, GhostPic
	ld a, c
	ld [hli], a   ; write front sprite pointer
	ld [hl], b
	ld a, MON_GHOST
	ld [wcf91], a

;	call GetMonHeader
	ld de, vFrontPic
	call LoadMonFrontSprite

	pop af
	ld [wcf91], a

	ret

TrainerSentOutText2:
	text_far _TrainerSentOutText
	text_end

; =====================================

DisplayPokemartDialogue_Far::
	ld hl, PokemartGreetingText
; new, for the taboo/forbidden merchant and Sevii Two Island Market
	push hl
	CheckEvent EVENT_IN_SEVII
	pop hl
	jr nz, .sevii
	ld a, [wCurMap]
	cp CERULEAN_CAVE_EXTRA_FINAL
	jr nz, .noSpecialMerchant
; we are talking to the forbidden merchant
	ld a, HS_CELADON_HOTEL_ROOMS_TROPHY_6
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld hl, ForbiddenMerchantGreetingText
	jr .noSpecialMerchant
.sevii
	ld a, [wCurMap]
	cp SEVII_TWO_ISLAND_CITY
	jr nz, .noSpecialMerchant
; we are talking to the 2-Island merchant
	ld hl, SeviiTwoIslandMerchantGreetingText
.noSpecialMerchant
; back to vanilla
	call PrintText
	ret

PokemartGreetingText::
	text_far _PokemartGreetingText
	text_end

ForbiddenMerchantGreetingText:: ; new
	text_far _ForbiddenMerchantGreetingText
	text_end

SeviiTwoIslandMerchantGreetingText:: ; new
	text_far _SeviiTwoIslandMerchantGreetingText
	text_end

; =====================================

_TrackPlayTime_Tanoby::
	CheckEvent EVENT_SEVII_TANOBY_TRACK_TIME
	ret z
; the event was triggered
	ld a, [wPlayTimeFrames]
	and a
	ret nz
; if frames=0, then 60 are passed, ergo 1 second
; increase the Tanoby second counter: wUniQuizAnswer abused for this instead of the vanilla wPlayTimeSeconds
	ld a, [wUniQuizAnswer]
	inc a
	ld [wUniQuizAnswer], a
	cp 120
	ret nz
; if we are here: 120 Tanoby seconds passed
	SetEvent EVENT_SEVII_TANOBY_TIME_PASSED
	ret

