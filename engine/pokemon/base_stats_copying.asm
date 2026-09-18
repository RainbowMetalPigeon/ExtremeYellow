; from Vortiene:
; in Evolution_PartyMonLoop
; copydata is a function that copies hl to de for bc amount of bytes
; in this case, it's copying data from base stats data to wMonHeader
; for the current pokemon
; since wMonHeader will have everything you need for this whole Evolution code after doing this copy, and the wram value will stay the same regardless of the bank you're in
; all you need to do is run this code specifically in the same bank as base stats then go back to the evolution bank
; which can all be achieved by just callfar'ing a function that does the above code in the base stats bank then returns

BaseStatsCopying::
	ld a, [wd11e]
	dec a
	ld hl, BaseStats
	ld bc, BASE_DATA_SIZE
	call AddNTimes
	ld de, wMonHeader
	call CopyData ; function that copies hl to de for bc amount of bytes = so BaseStats is copied into wMonHeader for BASE_DATA_SIZE amount of bytes

; new, to personalize the Special split
	ld a, [wPersonalizationSpecialSplit] ; 0=OFF (unified), 1=ON (split)
	and a
	jr nz, .specialSplitDone
	ld a, [wd11e]
	ld c, a
	call FindUnifiedSpecialValue ; input: c, output: d
	ld a, d
	ld [wMonHBaseSpecialAttack], a
	ld [wMonHBaseSpecialDefense], a
.specialSplitDone

; new, for for randomized mons
	CheckAndResetEvent EVENT_LOAD_RANDOMIZED_1_TYPES
	jr nz, .loadRandomizedTypesOne
	CheckAndResetEvent EVENT_LOAD_RANDOMIZED_2_TYPES
	jr z, .checkTCGMode
; second randomized mon
	ld a, [wRandomizedMon2_Type1]
	call ConvertVanillaTypeToTCGType
	ld [wMonHType1], a
	ld a, [wRandomizedMon2_Type2]
	call ConvertVanillaTypeToTCGType
	ld [wMonHType2], a
	ret
.loadRandomizedTypesOne
	ld a, [wRandomizedMon1_Type1]
	call ConvertVanillaTypeToTCGType
	ld [wMonHType1], a
	ld a, [wRandomizedMon1_Type2]
	call ConvertVanillaTypeToTCGType
	ld [wMonHType2], a
	ret
.checkTCGMode

; new, for TCG mode
	ld a, [wPersonalizationTCGMode]
	and a
	jr z, .checkVanillaDelta
; TCG, check if delta or not
	CheckAndResetEvent EVENT_LOAD_DELTA_SPECIES_TYPES
	ld hl, ListOfMonsAndTypesToChange_TCG
	jr z, .listOfTypesGotten
	ld hl, ListOfMonsAndTypesToChange_TCGDelta
	jr .listOfTypesGotten

.checkVanillaDelta
; new, for delta species
	CheckAndResetEvent EVENT_LOAD_DELTA_SPECIES_TYPES
	jr z, .checkAlteredTypes
	ld hl, ListOfMonsAndTypesToChange_Delta
	jr .listOfTypesGotten

.checkAlteredTypes
; new, to personalize types
	ld a, [wPersonalizationTypes] ; 0=CLASSIC, 1=NEW
	and a
	ret z ; if types are the hard-coded ones, we're good

; otherwise, overwrite them
	ld hl, ListOfMonsAndTypesToChange_Altered
.listOfTypesGotten
	ld a, [wd11e]
	ld b, a ; b holds the current mon species
.loopTypesToChange
	ld a, [hli] ; a points to the mon species entry, and hl points to the first type
	cp -1 ; terminator
	ret z
; we didn't hit the terminator
	cp b ; is the current pokemon we're looking at the same as the table entry?
	jr nz, .increaseHLby2 ; if not, go to the next entry
; it's a match!
	ld a, [hli] ; a contains the first new type, hl points to the second new type
	ld [wMonHType1], a
	ld a, [hl]
	ld [wMonHType2], a
	ret
.increaseHLby2
	inc hl ; hl points to the second type
	inc hl ; hl points to the next mon species
	jr .loopTypesToChange

ListOfMonsAndTypesToChange_Altered:
	db VENUSAUR, GRASS, GROUND
	db MVENUSAUR, GRASS, GROUND
	db CHARIZARD, FIRE, DRAGON
	db MCHARZARDY, FIRE, DRAGON
	db BLASTOISE, WATER, STEEL
	db MBLASTOISE, WATER, STEEL
	db BUTTERFREE, BUG, PSYCHIC_TYPE
	db PIDGEY, FLYING, FLYING
	db PIDGEOTTO, FLYING, FLYING
	db PIDGEOT, FLYING, FLYING
	db MPIDGEOT, FLYING, FLYING
	db RATTATA, NORMAL, GROUND
	db RATICATE, NORMAL, GROUND
	db SPEAROW, FLYING, FIGHTING
	db FEAROW, FLYING, FIGHTING
	db ARBOK, POISON, DARK
	db PICHU, ELECTRIC, GROUND ; V2
	db PIKACHU, ELECTRIC, GROUND ; V2
	db RAICHU, ELECTRIC, GROUND ; V2
	db MRAICHUX, ELECTRIC, FLYING ; V2
	db MRAICHUY, ELECTRIC, FAIRY ; V2
	db NIDOQUEEN, POISON, FAIRY
	db NIDOKING, POISON, FIGHTING
	db VULPIX, FIRE, GHOST
	db NINETALES, FIRE, GHOST
	db ZUBAT, DARK, FLYING ; V2
	db GOLBAT, DARK, FLYING ; V2
	db CROBAT, DARK, FLYING ; V2
	db BELLOSSOM, GRASS, FIRE
	db PARAS, BUG, GHOST
	db PARASECT, BUG, GHOST
	db VENOMOTH, POISON, PSYCHIC_TYPE
	db PSYDUCK, WATER, PSYCHIC_TYPE
	db GOLDUCK, WATER, PSYCHIC_TYPE
	db PRIMEAPE, FIGHTING, DARK
	db ARCANINE, FIRE, DRAGON
	db GEODUDE, ROCK, ROCK
	db GRAVELER, ROCK, ROCK
	db GOLEM, ROCK, ROCK
	db PONYTA, FIRE, GROUND
	db RAPIDASH, FIRE, GROUND
	db DODUO, FLYING, GROUND
	db DODRIO, FLYING, GROUND
	db DEWGONG, ICE, FAIRY
	db GRIMER, POISON, GROUND
	db MUK, POISON, GROUND
	db SHELLDER, WATER, ROCK
	db CLOYSTER, ICE, ROCK
	db GASTLY, GHOST, DARK
	db HAUNTER, GHOST, DARK
	db GENGAR, GHOST, DARK
	db MGENGAR, GHOST, DARK
	db DROWZEE, PSYCHIC_TYPE, DARK
	db HYPNO, PSYCHIC_TYPE, DARK
	db KRABBY, WATER, BUG
	db KINGLER, WATER, BUG
	db VOLTORB, ELECTRIC, FIRE
	db ELECTRODE, ELECTRIC, FIRE
	db CUBONE, GROUND, GHOST
	db MAROWAK, GROUND, GHOST
	db HITMONLEE, FIGHTING, GROUND
	db HITMONCHAN, FIGHTING, NORMAL
	db HITMONTOP, FIGHTING, FLYING
	db KOFFING, POISON, FIRE
	db WEEZING, POISON, FIRE
	db RHYDON, ROCK, FIGHTING
	db RHYPERIOR, ROCK, FIGHTING
	db HAPPINY, FAIRY, FAIRY
	db CHANSEY, FAIRY, FAIRY
	db BLISSEY, FAIRY, FAIRY
	db TANGELA, GRASS, DARK
	db TANGROWTH, GRASS, DARK
	db SEADRA, WATER, POISON
	db KINGDRA, DRAGON, POISON
	db GOLDEEN, WATER, NORMAL
	db SEAKING, WATER, NORMAL
	db STARYU, WATER, FAIRY
	db STARMIE, WATER, FAIRY
	db MSTARMIE, WATER, FAIRY ; V2
	db ELEKID, ELECTRIC, FIGHTING
	db ELECTABUZZ, ELECTRIC, FIGHTING
	db ELECTIVIRE, ELECTRIC, FIGHTING
	db MAGBY, FIRE, DARK
	db MAGMAR, FIRE, DARK
	db MAGMORTAR, FIRE, DARK
	db TAUROS, NORMAL, GROUND
	db GYARADOS, DRAGON, DARK ; V2
	db PORYGON, ELECTRIC, GHOST
	db PORYGON2, ELECTRIC, GHOST
	db PORYGONZ, ELECTRIC, GHOST
	db KABUTO, ROCK, BUG
	db KABUTOPS, ROCK, BUG
	db AERODACTYL, ROCK, DRAGON
	db MARODACTYL, ROCK, DRAGON
	db DRATINI, DRAGON, FAIRY
	db DRAGONAIR, DRAGON, FAIRY
	db DRAGONITE, DRAGON, FAIRY
	db MDRAGONITE, DRAGON, FAIRY ; V2
	db -1

; input: c = species
; output: d = that species' unified (pre-split) Special value
; (input in c and output in d, not a/b/hl, since this is farcall'd from
; another bank for the Stat Exp hook in GainExperience - callfar's own
; bankswitch setup clobbers a, b and hl, but preserves c, d, e and flags)
; used both to force Sp.Atk/Sp.Def equal when the split is off, and to keep
; Stat Exp gain from a defeated mon toggle-independent (see GainExperience)
FindUnifiedSpecialValue::
	ld hl, ListOfMonsAndUnifiedSpecial
.loop
	ld a, [hli]
	cp -1 ; terminator - shouldn't happen if the table is complete
	ret z
	cp c
	jr nz, .skip
	ld a, [hl]
	ld d, a
	ret
.skip
	inc hl
	jr .loop

ListOfMonsAndUnifiedSpecial:
	db BULBASAUR, 65
	db IVYSAUR, 80
	db VENUSAUR, 100
	db MVENUSAUR, 122
	db CHARMANDER, 50
	db CHARMELEON, 65
	db CHARIZARD, 85
	db MCHARZARDX, 85
	db MCHARZARDY, 159
	db SQUIRTLE, 50
	db WARTORTLE, 65
	db BLASTOISE, 85
	db MBLASTOISE, 135
	db CATERPIE, 20
	db METAPOD, 25
	db BUTTERFREE, 90
	db WEEDLE, 20
	db KAKUNA, 25
	db BEEDRILL, 45
	db MBEEDRILL, 48
	db PIDGEY, 35
	db PIDGEOTTO, 50
	db PIDGEOT, 70
	db MPIDGEOT, 135
	db RATTATA, 25
	db RATICATE, 50
	db SPEAROW, 31
	db FEAROW, 61
	db EKANS, 40
	db ARBOK, 65
	db PICHU, 35
	db PIKACHU, 50
	db RAICHU, 90
	db MRAICHUX, 95
	db MRAICHUY, 160
	db SANDSHREW, 30
	db SANDSLASH, 55
	db NIDORAN_F, 40
	db NIDORINA, 55
	db NIDOQUEEN, 75
	db NIDORAN_M, 40
	db NIDORINO, 55
	db NIDOKING, 75
	db CLEFFA, 45
	db CLEFAIRY, 60
	db CLEFABLE, 95
	db MCLEFABLE, 135
	db VULPIX, 65
	db NINETALES, 100
	db IGGLYBUFF, 20
	db JIGGLYPUFF, 25
	db WIGGLYTUFF, 68
	db ZUBAT, 40
	db GOLBAT, 75
	db CROBAT, 80
	db ODDISH, 75
	db GLOOM, 85
	db VILEPLUME, 110
	db BELLOSSOM, 90
	db PARAS, 55
	db PARASECT, 80
	db VENONAT, 40
	db VENOMOTH, 90
	db DIGLETT, 45
	db DUGTRIO, 70
	db MEOWTH, 40
	db PERSIAN, 65
	db PSYDUCK, 50
	db GOLDUCK, 80
	db MANKEY, 35
	db PRIMEAPE, 60
	db ANNIHILAPE, 70
	db GROWLITHE, 50
	db ARCANINE, 80
	db POLIWAG, 40
	db POLIWHIRL, 50
	db POLIWRATH, 70
	db POLITOED, 90
	db ABRA, 105
	db KADABRA, 120
	db ALAKAZAM, 135
	db MALAKAZAM, 175
	db MACHOP, 35
	db MACHOKE, 50
	db MACHAMP, 65
	db BELLSPROUT, 70
	db WEEPINBELL, 85
	db VICTREEBEL, 100
	db MVICTREBEL, 135
	db TENTACOOL, 100
	db TENTACRUEL, 120
	db GEODUDE, 30
	db GRAVELER, 45
	db GOLEM, 55
	db PONYTA, 65
	db RAPIDASH, 80
	db SLOWPOKE, 40
	db SLOWBRO, 80
	db MSLOWBRO, 105
	db SLOWKING, 105
	db MAGNEMITE, 95
	db MAGNETON, 120
	db MAGNEZONE, 130
	db FARFETCHD, 58
	db DODUO, 35
	db DODRIO, 60
	db SEEL, 70
	db DEWGONG, 95
	db GRIMER, 40
	db MUK, 65
	db SHELLDER, 45
	db CLOYSTER, 85
	db GASTLY, 100
	db HAUNTER, 115
	db GENGAR, 130
	db MGENGAR, 170
	db ONIX, 30
	db STEELIX, 65
	db MSTEELIX, 75
	db DROWZEE, 90
	db HYPNO, 115
	db KRABBY, 25
	db KINGLER, 50
	db VOLTORB, 55
	db ELECTRODE, 80
	db EXEGGCUTE, 60
	db EXEGGUTOR, 125
	db CUBONE, 40
	db MAROWAK, 50
	db TYROGUE, 35
	db HITMONLEE, 35
	db HITMONCHAN, 35
	db HITMONTOP, 35
	db LICKITUNG, 60
	db LICKILICKY, 80
	db KOFFING, 60
	db WEEZING, 85
	db RHYHORN, 30
	db RHYDON, 45
	db RHYPERIOR, 55
	db HAPPINY, 65
	db CHANSEY, 105
	db BLISSEY, 135
	db TANGELA, 100
	db TANGROWTH, 110
	db KANGASKHAN, 40
	db MKANGASKAN, 80
	db HORSEA, 70
	db SEADRA, 95
	db KINGDRA, 95
	db GOLDEEN, 50
	db SEAKING, 80
	db STARYU, 70
	db STARMIE, 100
	db MSTARMIE, 130
	db MIME_JR, 70
	db MR_MIME, 100
	db SCYTHER, 55
	db SCIZOR, 68
	db MSCIZOR, 83
	db KLEAVOR, 70
	db SMOOCHUM, 65
	db JYNX, 95
	db ELEKID, 55
	db ELECTABUZZ, 85
	db ELECTIVIRE, 90
	db MAGBY, 55
	db MAGMAR, 85
	db MAGMORTAR, 125
	db PINSIR, 55
	db MPINSIR, 78
	db TAUROS, 70
	db MAGIKARP, 20
	db GYARADOS, 100
	db MGYARADOS, 130
	db LAPRAS, 95
	db DITTO, 48
	db EEVEE, 65
	db VAPOREON, 110
	db JOLTEON, 110
	db FLAREON, 110
	db ESPEON, 130
	db UMBREON, 130
	db LEAFEON, 65
	db GLACEON, 130
	db SYLVEON, 130
	db PORYGON, 75
	db PORYGON2, 105
	db PORYGONZ, 135
	db OMANYTE, 90
	db OMASTAR, 115
	db KABUTO, 45
	db KABUTOPS, 70
	db AERODACTYL, 60
	db MARODACTYL, 70
	db MUNCHLAX, 40
	db SNORLAX, 65
	db ARTICUNO, 125
	db ZAPDOS, 125
	db MOLTRES, 125
	db DRATINI, 50
	db DRAGONAIR, 70
	db DRAGONITE, 100
	db MDRAGONITE, 145
	db ARM_MEWTWO, 90
	db MEWTWO, 154
	db MMEWTWOX, 154
	db MMEWTWOY, 194
	db MEW, 100
	db MELTAN, 55
	db MELMETAL, 80
	db VENUSTOISE, 131
	db THU_FI_ZER, 145
	db MZYGARDE, 216
	db UNECROZMA, 167
	db MRAYQUAZA, 180
	db EETERNATUS, 250
	db ARCEUS, 120
	db MISSINGNO, 6
	db BLUESDAD, 255
	db BLUESMOM, 255
	db DAD, 255
	db -1

UpdatePartyMonTypesAfterPersonalization:
; do nothing if we don't have a party
	ld a, [wPartyCount]
	and a
	ret z
; do something if we have a party
	ld a, [wPersonalizationTypes] ; 0=NO, 1=YES
	and a
	jr z, .vanillaTypes
; new types
	ld a, [wPartyCount]
	ld c, a ; c is the counter
.loopUpdateNew
	ld a, [wPartyCount]
	sub c ; a-c
	push bc

; get the header of the mon of this round of the party loop
	ld hl, wPartyMon1
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	push hl ; hl points to the header of the "a-c"th mon in the party
	ld bc, wPartyMon1Species - wPartyMon1
	add hl, bc ; hl points to the species of the "a-c"th mon in the party
; check if the species needs treatement
	ld a, [hl]
	ld b, a ; b holds the current mon species
	ld de, ListOfMonsAndTypesToChange_Altered
.loopTypesToChange
	ld a, [de] ; a points to the mon species entry, and de points to the first type
	inc de
	cp -1 ; terminator
	jr z, .matchNotFound
; we didn't hit the terminator
	cp b ; is the current pokemon we're looking at the same as the table entry?
	jr nz, .increaseDEby2 ; if not, go to the next entry
; it's a match!
	jr .matchFound
.increaseDEby2
	inc de ; de points to the second type
	inc de ; de points to the next mon species
	jr .loopTypesToChange
.matchNotFound
	pop hl
	jr .completeThisRoundOfPartLoop

.matchFound
	pop hl ; hl points again to the header of the "a-c"th mon in the party
	ld bc, wPartyMon1Type - wPartyMon1 ; $5
	add hl, bc
; now hl points to the 1st type of the "a-c"th mon in the party
	ld a, [de] ; a contains the first new type, de points to the second new type
	inc de
	ld [hl], a
	inc hl
	ld a, [de]
	ld [hl], a

.completeThisRoundOfPartLoop
	pop bc
	dec c
	jr nz, .loopUpdateNew
	ret

.vanillaTypes
; here we need to restore the types to the vanilla one, so can take it simpler,
; and just re-write the types of EVERY party's mon with the header's ones
; insignificantly slower when playing, so much cleaner and simpler to read here

	ld a, [wPartyCount]
	ld c, a ; c is the counter
.loopUpdateVanilla
	ld a, [wPartyCount]
	sub c ; a-c
	push bc

; get the header of the mon of this round of the party loop
	ld hl, wPartyMon1
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes ; hl points to the header of the "a-c"th mon in the party
	ld bc, wPartyMon1Species - wPartyMon1
	add hl, bc ; hl points to the species of the "a-c"th mon in the party
	push hl

	ld a, [hl]
	dec a
	ld hl, BaseStats
	ld bc, BASE_DATA_SIZE
	call AddNTimes
	ld de, wMonHeader
	call CopyData

	pop hl
	ld bc, wPartyMon1Type - wPartyMon1 ; $5
	add hl, bc ; now hl points to the 1st type of the "a-c"th mon in the party

	ld a, [wMonHType1]
	ld [hl], a
	inc hl
	ld a, [wMonHType2]
	ld [hl], a

	pop bc
	dec c
	jr nz, .loopUpdateVanilla
	ret

; new, called on Personalization menu exit to refresh every party mon's
; Sp.Atk/Sp.Def immediately after toggling the split, in either direction -
; unlike the Types equivalent above, every mon is affected (not just ones
; with an entry in a table), so no per-mon "does this need treatment" check
; is needed: just refresh wMonHeader then recompute stats for each mon
UpdatePartyMonSpecialStatsAfterPersonalization::
	ld a, [wPartyCount]
	and a
	ret z ; do nothing if we don't have a party
	ld c, a ; c is the counter
.loop
	ld a, [wPartyCount]
	sub c ; a-c
	push bc

; get the base address of the mon of this round of the party loop
	ld hl, wPartyMon1
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes ; hl points to the base of the "a-c"th mon in the party
	push hl ; keep the base address around for later

; refresh wMonHeader (types+stats, toggle-aware) for this mon's species
	ld bc, wPartyMon1Species - wPartyMon1
	add hl, bc
	ld a, [hl]
	ld [wd11e], a
	call BaseStatsCopying

; recalculate this mon's actual stats (incl. stat exp), now that wMonHeader is fresh
	pop hl ; hl = base address of this mon again
	push hl
	ld bc, wPartyMon1Level - wPartyMon1
	add hl, bc
	ld a, [hl]
	ld [wCurEnemyLVL], a ; CalcStat reads the level to use from here, not from the mon's own struct - was missing entirely, causing every party mon's stats to be recalculated at whatever level was last left in this global
	pop hl
	push hl
	ld bc, wPartyMon1Stats - wPartyMon1
	add hl, bc
	ld d, h
	ld e, l ; de = this mon's Stats block start (CalcStats output pointer)
	pop hl
	ld bc, wPartyMon1HPExp - 1 - wPartyMon1
	add hl, bc ; hl = this mon's (HPExp - 1) (CalcStats' stat-exp-relative input)
	ld b, $1 ; consider stat exp
	call CalcStats

	pop bc
	dec c
	jr nz, .loop
	ret

; input: mon species in d
; outpit: types in d and e
ExtractMonsTypesForMovingIntoParty::
	ld a, [wPersonalizationTypes] ; 0=NO, 1=YES
	and a
	jr z, .vanillaTypes

; new types
	push de
	ld a, d
	ld b, a ; b holds the current mon species
	ld hl, ListOfMonsAndTypesToChange_Altered
.loopTypesToChange
	ld a, [hl] ; a points to the mon species entry, and hl points to the first type
	inc hl
	cp -1 ; terminator
	jr z, .matchNotFound
; we didn't hit the terminator
	cp b ; is the current pokemon we're looking at the same as the table entry?
	jr nz, .increasehlby2 ; if not, go to the next entry
; it's a match!
	jr .matchFound
.increasehlby2
	inc hl ; hl points to the second type
	inc hl ; hl points to the next mon species
	jr .loopTypesToChange
.matchFound
	pop de
	ld a, [hl]
	ld d, a
	ld a, [hl]
	ld e, a
	ret
.matchNotFound
	pop de
; fallthrough

.vanillaTypes
	ld a, d ; a has the mon's species
	dec a
	ld hl, BaseStats
	ld bc, BASE_DATA_SIZE
	call AddNTimes
	ld de, wMonHeader
	call CopyData

	ld a, [wMonHType1]
	ld d, a
	ld a, [wMonHType2]
	ld e, a
	ret

; mon ID in d
; c flag if match found
CheckIfMonHasDeltaSpecies::
	ld hl, ListOfMonsAndTypesToChange_Delta
.loop
	ld a, [hli] ; hl points now to the first type
	cp -1 ; terminator
	jr z, .unsetCFlag
	cp d
	jr z, .setCFlag ; match found
	inc hl
	inc hl
	jr .loop
.setCFlag
	scf
	ret
.unsetCFlag
	xor a
	ret

ListOfMonsAndTypesToChange_Delta:
; 1
	db WEEDLE, GRASS, GRASS
	db KAKUNA, GRASS, GRASS
	db BEEDRILL, GRASS, STEEL
	db MBEEDRILL, GRASS, STEEL
	db SANDSHREW, ROCK, ROCK
	db SANDSLASH, ROCK, STEEL
	db PICHU, STEEL, STEEL
	db PIKACHU, STEEL, STEEL
	db RAICHU, STEEL, STEEL
	db MRAICHUX, STEEL, STEEL
	db MRAICHUY, STEEL, STEEL
	db PIDGEY, ELECTRIC, ELECTRIC
	db PIDGEOTTO, ELECTRIC, ELECTRIC
	db PIDGEOT, ELECTRIC, STEEL
	db MPIDGEOT, ELECTRIC, STEEL
	db MANKEY, FIRE, FIRE
	db PRIMEAPE, FIRE, FIRE
	db ANNIHILAPE, FIRE, FIRE
	db SPEAROW, ELECTRIC, ELECTRIC
	db FEAROW, ELECTRIC, ELECTRIC
	db ZUBAT, BUG, BUG
	db GOLBAT, BUG, BUG
	db CROBAT, BUG, STEEL
	db HORSEA, FIRE, ROCK
	db SEADRA, FIRE, ROCK
	db KINGDRA, FIRE, ROCK
	db KRABBY, FIRE, FIRE
	db KINGLER, FIRE, STEEL
; 2
	db EEVEE, STEEL, STEEL
	db ESPEON, PSYCHIC_TYPE, STEEL
	db FLAREON, FIRE, STEEL
	db JOLTEON, ELECTRIC, STEEL
	db UMBREON, DARK, STEEL
	db VAPOREON, WATER, STEEL
	db ODDISH, WATER, WATER
	db GLOOM, FAIRY, FAIRY
	db VILEPLUME, FAIRY, STEEL
	db BELLOSSOM, WATER, WATER
	db MEOWTH, DARK, STEEL
	db PERSIAN, DARK, STEEL
	db EKANS, FIRE, FIRE
	db ARBOK, FIRE, FIRE
	db VULPIX, PSYCHIC_TYPE, FAIRY
	db NINETALES, PSYCHIC_TYPE, FAIRY
	db NIDORAN_F, STEEL, STEEL
	db NIDORINA, STEEL, STEEL
	db NIDOQUEEN, STEEL, STEEL
	db NIDORAN_M, DARK, DARK
	db NIDORINO, DARK, DARK
	db NIDOKING, DARK, DARK
	db PSYDUCK, ELECTRIC, ELECTRIC
	db GOLDUCK, ELECTRIC, ELECTRIC
	db SHELLDER, FIGHTING, ROCK
	db CLOYSTER, FIGHTING, ROCK
	db SEEL, NORMAL, DRAGON
	db DEWGONG, NORMAL, DRAGON
; 3
	db SMOOCHUM, FIRE, FIRE
	db JYNX, FIRE, FIRE
	db LICKITUNG, PSYCHIC_TYPE, GHOST
	db LICKILICKY, PSYCHIC_TYPE, GHOST
	db ELEKID, GROUND, GROUND
	db ELECTABUZZ, GROUND, GROUND
	db ELECTIVIRE, GROUND, GROUND
	db EXEGGCUTE, ROCK, ROCK
	db EXEGGUTOR, ROCK, ROCK
	db CHARMANDER, ELECTRIC, ELECTRIC
	db CHARMELEON, ELECTRIC, ELECTRIC
	db CHARIZARD, ELECTRIC, DARK
	db MCHARZARDX, ELECTRIC, DARK
	db MCHARZARDY, ELECTRIC, DARK
	db BULBASAUR, ICE, GHOST
	db IVYSAUR, ICE, GHOST
	db VENUSAUR, ICE, GHOST
	db MVENUSAUR, ICE, GHOST
	db SQUIRTLE, ROCK, ROCK
	db WARTORTLE, ROCK, ROCK
	db BLASTOISE, ROCK, STEEL
	db MBLASTOISE, ROCK, STEEL
	db MAGIKARP, STEEL, STEEL
	db GYARADOS, ELECTRIC, FIRE
	db MGYARADOS, ELECTRIC, FIRE
	db STARYU, ICE, ICE
	db STARMIE, ICE, STEEL
	db MSTARMIE, ICE, STEEL
; 4
	db PINSIR, GROUND, FIGHTING
	db MPINSIR, GROUND, FIGHTING
	db MUNCHLAX, BUG, BUG
	db SNORLAX, BUG, BUG
	db AERODACTYL, FIRE, FIRE
	db MARODACTYL, FIRE, FIRE
	db CUBONE, FIGHTING, FIGHTING
	db MAROWAK, FIGHTING, STEEL
	db DRATINI, ELECTRIC, GRASS
	db DRAGONAIR, ELECTRIC, GRASS
	db DRAGONITE, ELECTRIC, GRASS
	db MDRAGONITE, ELECTRIC, GRASS
	db KABUTO, ELECTRIC, ELECTRIC
	db KABUTOPS, ELECTRIC, ELECTRIC
	db OMANYTE, GHOST, FAIRY
	db OMASTAR, GHOST, FAIRY
; 5
	db ARM_MEWTWO, FIRE, ELECTRIC
	db MEWTWO, FIRE, ELECTRIC
	db MMEWTWOX, FIRE, ELECTRIC
	db MMEWTWOY, FIRE, ELECTRIC
	db MEW, FIRE, WATER
	db VENUSTOISE, ROCK, GHOST
	db -1

ListOfMonsAndTypesToChange_TCG:
	db BULBASAUR, TCG_GRASS, TCG_GRASS
	db IVYSAUR, TCG_GRASS, TCG_GRASS
	db VENUSAUR, TCG_GRASS, TCG_GRASS
	db MVENUSAUR, TCG_GRASS, TCG_GRASS
	db CHARMANDER, TCG_FIRE, TCG_FIRE
	db CHARMELEON, TCG_FIRE, TCG_FIRE
	db CHARIZARD, TCG_FIRE, TCG_FIRE
	db MCHARZARDX, TCG_FIRE, TCG_FIRE
	db MCHARZARDY, TCG_FIRE, TCG_FIRE
	db SQUIRTLE, TCG_WATER, TCG_WATER
	db WARTORTLE, TCG_WATER, TCG_WATER
	db BLASTOISE, TCG_WATER, TCG_WATER
	db MBLASTOISE, TCG_WATER, TCG_WATER
	db CATERPIE, TCG_GRASS, TCG_GRASS
	db METAPOD, TCG_GRASS, TCG_GRASS
	db BUTTERFREE, TCG_GRASS, TCG_GRASS
	db WEEDLE, TCG_GRASS, TCG_GRASS
	db KAKUNA, TCG_GRASS, TCG_GRASS
	db BEEDRILL, TCG_GRASS, TCG_GRASS
	db MBEEDRILL, TCG_GRASS, TCG_GRASS
	db PIDGEY, TCG_COLORLESS, TCG_COLORLESS
	db PIDGEOTTO, TCG_COLORLESS, TCG_COLORLESS
	db PIDGEOT, TCG_COLORLESS, TCG_COLORLESS
	db MPIDGEOT, TCG_COLORLESS, TCG_COLORLESS
	db RATTATA, TCG_COLORLESS, TCG_COLORLESS
	db RATICATE, TCG_COLORLESS, TCG_COLORLESS
	db SPEAROW, TCG_COLORLESS, TCG_COLORLESS
	db FEAROW, TCG_COLORLESS, TCG_COLORLESS
	db EKANS, TCG_GRASS, TCG_GRASS
	db ARBOK, TCG_GRASS, TCG_GRASS
	db PICHU, TCG_LIGHTNING, TCG_LIGHTNING
	db PIKACHU, TCG_LIGHTNING, TCG_LIGHTNING
	db RAICHU, TCG_LIGHTNING, TCG_LIGHTNING
	db MRAICHUX, TCG_LIGHTNING, TCG_LIGHTNING
	db MRAICHUY, TCG_LIGHTNING, TCG_LIGHTNING
	db SANDSHREW, TCG_FIGHTING, TCG_FIGHTING
	db SANDSLASH, TCG_FIGHTING, TCG_FIGHTING
	db NIDORAN_F, TCG_GRASS, TCG_GRASS
	db NIDORINA, TCG_GRASS, TCG_GRASS
	db NIDOQUEEN, TCG_GRASS, TCG_GRASS
	db NIDORAN_M, TCG_GRASS, TCG_GRASS
	db NIDORINO, TCG_GRASS, TCG_GRASS
	db NIDOKING, TCG_GRASS, TCG_GRASS
	db CLEFFA, TCG_PSYCHIC, TCG_PSYCHIC
	db CLEFAIRY, TCG_PSYCHIC, TCG_PSYCHIC
	db CLEFABLE, TCG_PSYCHIC, TCG_PSYCHIC
	db MCLEFABLE, TCG_PSYCHIC, TCG_PSYCHIC
	db VULPIX, TCG_FIRE, TCG_FIRE
	db NINETALES, TCG_FIRE, TCG_FIRE
	db IGGLYBUFF, TCG_PSYCHIC, TCG_PSYCHIC
	db JIGGLYPUFF, TCG_PSYCHIC, TCG_PSYCHIC
	db WIGGLYTUFF, TCG_PSYCHIC, TCG_PSYCHIC
	db ZUBAT, TCG_GRASS, TCG_GRASS
	db GOLBAT, TCG_GRASS, TCG_GRASS
	db CROBAT, TCG_GRASS, TCG_GRASS
	db ODDISH, TCG_GRASS, TCG_GRASS
	db GLOOM, TCG_GRASS, TCG_GRASS
	db VILEPLUME, TCG_GRASS, TCG_GRASS
	db BELLOSSOM, TCG_GRASS, TCG_GRASS
	db PARAS, TCG_GRASS, TCG_GRASS
	db PARASECT, TCG_GRASS, TCG_GRASS
	db VENONAT, TCG_GRASS, TCG_GRASS
	db VENOMOTH, TCG_GRASS, TCG_GRASS
	db DIGLETT, TCG_FIGHTING, TCG_FIGHTING
	db DUGTRIO, TCG_FIGHTING, TCG_FIGHTING
	db MEOWTH, TCG_COLORLESS, TCG_COLORLESS
	db PERSIAN, TCG_COLORLESS, TCG_COLORLESS
	db PSYDUCK, TCG_WATER, TCG_WATER
	db GOLDUCK, TCG_WATER, TCG_WATER
	db MANKEY, TCG_FIGHTING, TCG_FIGHTING
	db PRIMEAPE, TCG_FIGHTING, TCG_FIGHTING
	db ANNIHILAPE, TCG_FIGHTING, TCG_FIGHTING
	db GROWLITHE, TCG_FIRE, TCG_FIRE
	db ARCANINE, TCG_FIRE, TCG_FIRE
	db POLIWAG, TCG_WATER, TCG_WATER
	db POLIWHIRL, TCG_WATER, TCG_WATER
	db POLIWRATH, TCG_WATER, TCG_WATER
	db POLITOED, TCG_WATER, TCG_WATER
	db ABRA, TCG_PSYCHIC, TCG_PSYCHIC
	db KADABRA, TCG_PSYCHIC, TCG_PSYCHIC
	db ALAKAZAM, TCG_PSYCHIC, TCG_PSYCHIC
	db MALAKAZAM, TCG_PSYCHIC, TCG_PSYCHIC
	db MACHOP, TCG_FIGHTING, TCG_FIGHTING
	db MACHOKE, TCG_FIGHTING, TCG_FIGHTING
	db MACHAMP, TCG_FIGHTING, TCG_FIGHTING
	db BELLSPROUT, TCG_GRASS, TCG_GRASS
	db WEEPINBELL, TCG_GRASS, TCG_GRASS
	db VICTREEBEL, TCG_GRASS, TCG_GRASS
	db MVICTREBEL, TCG_GRASS, TCG_GRASS
	db TENTACOOL, TCG_WATER, TCG_WATER
	db TENTACRUEL, TCG_WATER, TCG_WATER
	db GEODUDE, TCG_FIGHTING, TCG_FIGHTING
	db GRAVELER, TCG_FIGHTING, TCG_FIGHTING
	db GOLEM, TCG_FIGHTING, TCG_FIGHTING
	db PONYTA, TCG_FIGHTING, TCG_FIGHTING
	db RAPIDASH, TCG_FIGHTING, TCG_FIGHTING
	db SLOWPOKE, TCG_WATER, TCG_WATER
	db SLOWBRO, TCG_WATER, TCG_WATER
	db MSLOWBRO, TCG_WATER, TCG_WATER
	db SLOWKING, TCG_WATER, TCG_WATER
	db MAGNEMITE, TCG_METAL, TCG_METAL
	db MAGNETON, TCG_METAL, TCG_METAL
	db MAGNEZONE, TCG_METAL, TCG_METAL
	db FARFETCHD, TCG_COLORLESS, TCG_COLORLESS
	db DODUO, TCG_COLORLESS, TCG_COLORLESS
	db DODRIO, TCG_COLORLESS, TCG_COLORLESS
	db SEEL, TCG_WATER, TCG_WATER
	db DEWGONG, TCG_WATER, TCG_WATER
	db GRIMER, TCG_GRASS, TCG_GRASS
	db MUK, TCG_GRASS, TCG_GRASS
	db SHELLDER, TCG_WATER, TCG_WATER
	db CLOYSTER, TCG_WATER, TCG_WATER
	db GASTLY, TCG_PSYCHIC, TCG_PSYCHIC
	db HAUNTER, TCG_PSYCHIC, TCG_PSYCHIC
	db GENGAR, TCG_PSYCHIC, TCG_PSYCHIC
	db MGENGAR, TCG_PSYCHIC, TCG_PSYCHIC
	db ONIX, TCG_FIGHTING, TCG_FIGHTING
	db STEELIX, TCG_METAL, TCG_METAL
	db MSTEELIX, TCG_METAL, TCG_METAL
	db DROWZEE, TCG_PSYCHIC, TCG_PSYCHIC
	db HYPNO, TCG_PSYCHIC, TCG_PSYCHIC
	db KRABBY, TCG_WATER, TCG_WATER
	db KINGLER, TCG_WATER, TCG_WATER
	db VOLTORB, TCG_LIGHTNING, TCG_LIGHTNING
	db ELECTRODE, TCG_LIGHTNING, TCG_LIGHTNING
	db EXEGGCUTE, TCG_GRASS, TCG_GRASS
	db EXEGGUTOR, TCG_GRASS, TCG_GRASS
	db CUBONE, TCG_FIGHTING, TCG_FIGHTING
	db MAROWAK, TCG_FIGHTING, TCG_FIGHTING
	db TYROGUE, TCG_FIGHTING, TCG_FIGHTING
	db HITMONLEE, TCG_FIGHTING, TCG_FIGHTING
	db HITMONCHAN, TCG_FIGHTING, TCG_FIGHTING
	db HITMONTOP, TCG_FIGHTING, TCG_FIGHTING
	db LICKITUNG, TCG_COLORLESS, TCG_COLORLESS
	db LICKILICKY, TCG_COLORLESS, TCG_COLORLESS
	db KOFFING, TCG_GRASS, TCG_GRASS
	db WEEZING, TCG_GRASS, TCG_GRASS
	db RHYHORN, TCG_FIGHTING, TCG_FIGHTING
	db RHYDON, TCG_FIGHTING, TCG_FIGHTING
	db RHYPERIOR, TCG_FIGHTING, TCG_FIGHTING
	db HAPPINY, TCG_COLORLESS, TCG_COLORLESS
	db CHANSEY, TCG_COLORLESS, TCG_COLORLESS
	db BLISSEY, TCG_COLORLESS, TCG_COLORLESS
	db TANGELA, TCG_GRASS, TCG_GRASS
	db TANGROWTH, TCG_GRASS, TCG_GRASS
	db KANGASKHAN, TCG_COLORLESS, TCG_COLORLESS
	db MKANGASKAN, TCG_COLORLESS, TCG_COLORLESS
	db HORSEA, TCG_WATER, TCG_WATER
	db SEADRA, TCG_WATER, TCG_WATER
	db KINGDRA, TCG_DRAGON, TCG_DRAGON
	db GOLDEEN, TCG_WATER, TCG_WATER
	db SEAKING, TCG_WATER, TCG_WATER
	db STARYU, TCG_WATER, TCG_WATER
	db STARMIE, TCG_WATER, TCG_WATER
	db MSTARMIE, TCG_WATER, TCG_WATER
	db MIME_JR, TCG_PSYCHIC, TCG_PSYCHIC
	db MR_MIME, TCG_PSYCHIC, TCG_PSYCHIC
	db SCYTHER, TCG_GRASS, TCG_GRASS
	db SCIZOR, TCG_METAL, TCG_METAL
	db MSCIZOR, TCG_METAL, TCG_METAL
	db KLEAVOR,TCG_FIGHTING,TCG_FIGHTING
	db SMOOCHUM, TCG_PSYCHIC, TCG_PSYCHIC
	db JYNX, TCG_PSYCHIC, TCG_PSYCHIC
	db ELEKID, TCG_LIGHTNING, TCG_LIGHTNING
	db ELECTABUZZ, TCG_LIGHTNING, TCG_LIGHTNING
	db ELECTIVIRE, TCG_LIGHTNING, TCG_LIGHTNING
	db MAGBY, TCG_FIRE, TCG_FIRE
	db MAGMAR, TCG_FIRE, TCG_FIRE
	db MAGMORTAR, TCG_FIRE, TCG_FIRE
	db PINSIR, TCG_GRASS, TCG_GRASS
	db MPINSIR, TCG_GRASS, TCG_GRASS
	db TAUROS, TCG_COLORLESS, TCG_COLORLESS
	db MAGIKARP, TCG_WATER, TCG_WATER
	db GYARADOS, TCG_WATER, TCG_WATER
	db MGYARADOS, TCG_WATER, TCG_WATER
	db LAPRAS, TCG_WATER, TCG_WATER
	db DITTO, TCG_COLORLESS, TCG_COLORLESS
	db EEVEE, TCG_COLORLESS, TCG_COLORLESS
	db VAPOREON, TCG_WATER, TCG_WATER
	db JOLTEON, TCG_LIGHTNING, TCG_LIGHTNING
	db FLAREON, TCG_FIRE, TCG_FIRE
	db ESPEON, TCG_PSYCHIC, TCG_PSYCHIC
	db UMBREON, TCG_DARK, TCG_DARK
	db LEAFEON, TCG_GRASS, TCG_GRASS
	db GLACEON, TCG_WATER, TCG_WATER
	db SYLVEON, TCG_PSYCHIC, TCG_PSYCHIC
	db PORYGON, TCG_COLORLESS, TCG_COLORLESS
	db PORYGON2, TCG_COLORLESS, TCG_COLORLESS
	db PORYGONZ, TCG_COLORLESS, TCG_COLORLESS
	db OMANYTE, TCG_WATER, TCG_WATER
	db OMASTAR, TCG_WATER, TCG_WATER
	db KABUTO, TCG_FIGHTING, TCG_FIGHTING
	db KABUTOPS, TCG_FIGHTING, TCG_FIGHTING
	db AERODACTYL, TCG_FIGHTING, TCG_FIGHTING
	db MARODACTYL, TCG_FIGHTING, TCG_FIGHTING
	db MUNCHLAX, TCG_COLORLESS, TCG_COLORLESS
	db SNORLAX, TCG_COLORLESS, TCG_COLORLESS
	db ARTICUNO, TCG_WATER, TCG_WATER
	db ZAPDOS, TCG_LIGHTNING, TCG_LIGHTNING
	db MOLTRES, TCG_FIRE, TCG_FIRE
	db DRATINI, TCG_DRAGON, TCG_DRAGON
	db DRAGONAIR, TCG_DRAGON, TCG_DRAGON
	db DRAGONITE, TCG_DRAGON, TCG_DRAGON
	db MDRAGONITE, TCG_DRAGON, TCG_DRAGON
	db ARM_MEWTWO, TCG_PSYCHIC, TCG_PSYCHIC
	db MEWTWO, TCG_PSYCHIC, TCG_PSYCHIC
	db MMEWTWOX, TCG_PSYCHIC, TCG_PSYCHIC
	db MMEWTWOY, TCG_PSYCHIC, TCG_PSYCHIC
	db MEW, TCG_PSYCHIC, TCG_PSYCHIC
	db MELTAN, TCG_METAL, TCG_METAL
	db MELMETAL, TCG_METAL, TCG_METAL
	db VENUSTOISE, TCG_GRASS, TCG_WATER
	db THU_FI_ZER, TCG_COLORLESS, TCG_COLORLESS
	db MZYGARDE, TCG_DRAGON, TCG_DRAGON
	db UNECROZMA, TCG_DRAGON, TCG_DRAGON
	db MRAYQUAZA, TCG_DRAGON, TCG_DRAGON
	db EETERNATUS, TCG_DRAGON, TCG_DRAGON
	db ARCEUS, TCG_COLORLESS, TCG_COLORLESS
	db MISSINGNO, TCG_COLORLESS, TCG_COLORLESS
	db BLUESDAD, TCG_COLORLESS, TCG_COLORLESS
	db BLUESMOM, TCG_COLORLESS, TCG_COLORLESS
	db DAD, TCG_COLORLESS, TCG_COLORLESS
	db -1

ListOfMonsAndTypesToChange_TCGDelta:
; 1
	db WEEDLE, TCG_GRASS, TCG_GRASS
	db KAKUNA, TCG_GRASS, TCG_GRASS
	db BEEDRILL, TCG_GRASS, TCG_METAL
	db MBEEDRILL, TCG_GRASS, TCG_METAL
	db SANDSHREW, TCG_FIGHTING, TCG_METAL
	db SANDSLASH, TCG_FIGHTING, TCG_METAL
	db PICHU, TCG_METAL, TCG_METAL
	db PIKACHU, TCG_METAL, TCG_METAL
	db RAICHU, TCG_METAL, TCG_METAL
	db MRAICHUX, TCG_METAL, TCG_METAL
	db MRAICHUY, TCG_METAL, TCG_METAL
	db PIDGEY, TCG_LIGHTNING, TCG_LIGHTNING
	db PIDGEOTTO, TCG_LIGHTNING, TCG_LIGHTNING
	db PIDGEOT, TCG_LIGHTNING, TCG_METAL
	db MPIDGEOT, TCG_LIGHTNING, TCG_METAL
	db MANKEY, TCG_FIRE, TCG_FIRE
	db PRIMEAPE, TCG_FIRE, TCG_FIRE
	db ANNIHILAPE, TCG_FIRE, TCG_FIRE
	db SPEAROW, TCG_LIGHTNING, TCG_LIGHTNING
	db FEAROW, TCG_LIGHTNING, TCG_LIGHTNING
	db ZUBAT, TCG_GRASS, TCG_GRASS
	db GOLBAT, TCG_GRASS, TCG_GRASS
	db CROBAT, TCG_GRASS, TCG_METAL
	db HORSEA, TCG_FIRE, TCG_FIGHTING
	db SEADRA, TCG_FIRE, TCG_FIRE
	db KINGDRA, TCG_FIRE, TCG_FIGHTING
	db KRABBY, TCG_FIRE, TCG_FIRE
	db KINGLER, TCG_FIRE, TCG_METAL
; 2
	db EEVEE, TCG_METAL, TCG_METAL
	db ESPEON, TCG_PSYCHIC, TCG_METAL
	db FLAREON, TCG_FIRE, TCG_METAL
	db JOLTEON, TCG_LIGHTNING, TCG_METAL
	db UMBREON, TCG_DARK, TCG_METAL
	db VAPOREON, TCG_WATER, TCG_METAL
	db ODDISH, TCG_WATER, TCG_WATER
	db GLOOM, TCG_PSYCHIC, TCG_PSYCHIC
	db VILEPLUME, TCG_PSYCHIC, TCG_METAL
	db BELLOSSOM, TCG_WATER, TCG_WATER
	db MEOWTH, TCG_DARK, TCG_METAL
	db PERSIAN, TCG_DARK, TCG_METAL
	db EKANS, TCG_FIRE, TCG_FIRE
	db ARBOK, TCG_FIRE, TCG_FIRE
	db VULPIX, TCG_PSYCHIC, TCG_PSYCHIC
	db NINETALES, TCG_PSYCHIC, TCG_PSYCHIC
	db NIDORAN_F, TCG_METAL, TCG_METAL
	db NIDORINA, TCG_METAL, TCG_METAL
	db NIDOQUEEN, TCG_METAL, TCG_METAL
	db NIDORAN_M, TCG_DARK, TCG_DARK
	db NIDORINO, TCG_DARK, TCG_DARK
	db NIDOKING, TCG_DARK, TCG_DARK
	db PSYDUCK, TCG_LIGHTNING, TCG_LIGHTNING
	db GOLDUCK, TCG_LIGHTNING, TCG_LIGHTNING
	db SHELLDER, TCG_FIGHTING, TCG_FIGHTING
	db CLOYSTER, TCG_FIGHTING, TCG_FIGHTING
	db SEEL, TCG_COLORLESS, TCG_COLORLESS
	db DEWGONG, TCG_COLORLESS, TCG_COLORLESS
; 3
	db SMOOCHUM, TCG_FIRE, TCG_FIRE
	db JYNX, TCG_FIRE, TCG_FIRE
	db LICKITUNG, TCG_PSYCHIC, TCG_PSYCHIC
	db LICKILICKY, TCG_PSYCHIC, TCG_PSYCHIC
	db ELEKID, TCG_FIGHTING, TCG_FIGHTING
	db ELECTABUZZ, TCG_FIGHTING, TCG_FIGHTING
	db ELECTIVIRE, TCG_FIGHTING, TCG_FIGHTING
	db EXEGGCUTE, TCG_FIGHTING, TCG_FIGHTING
	db EXEGGUTOR, TCG_FIGHTING, TCG_FIGHTING
	db CHARMANDER, TCG_LIGHTNING, TCG_LIGHTNING
	db CHARMELEON, TCG_LIGHTNING, TCG_LIGHTNING
	db CHARIZARD, TCG_LIGHTNING, TCG_DARK
	db MCHARZARDX, TCG_LIGHTNING, TCG_DARK
	db MCHARZARDY, TCG_LIGHTNING, TCG_DARK
	db BULBASAUR, TCG_WATER, TCG_PSYCHIC
	db IVYSAUR, TCG_WATER, TCG_PSYCHIC
	db VENUSAUR, TCG_WATER, TCG_PSYCHIC
	db MVENUSAUR, TCG_WATER, TCG_PSYCHIC
	db SQUIRTLE, TCG_FIGHTING, TCG_FIGHTING
	db WARTORTLE, TCG_FIGHTING, TCG_FIGHTING
	db BLASTOISE, TCG_FIGHTING, TCG_METAL
	db MBLASTOISE, TCG_FIGHTING, TCG_METAL
	db MAGIKARP, TCG_METAL, TCG_METAL
	db GYARADOS, TCG_LIGHTNING, TCG_FIRE
	db MGYARADOS, TCG_LIGHTNING, TCG_FIRE
	db STARYU, TCG_WATER, TCG_WATER
	db STARMIE, TCG_WATER, TCG_METAL
	db MSTARMIE, TCG_WATER, TCG_METAL
; 4
	db PINSIR, TCG_FIGHTING, TCG_FIGHTING
	db MPINSIR, TCG_FIGHTING, TCG_FIGHTING
	db MUNCHLAX, TCG_GRASS, TCG_GRASS
	db SNORLAX, TCG_GRASS, TCG_GRASS
	db AERODACTYL, TCG_FIRE, TCG_FIRE
	db MARODACTYL, TCG_FIRE, TCG_FIRE
	db CUBONE, TCG_FIGHTING, TCG_FIGHTING
	db MAROWAK, TCG_FIGHTING, TCG_METAL

	db DRATINI, TCG_LIGHTNING, TCG_GRASS
	db DRAGONAIR, TCG_LIGHTNING, TCG_GRASS
	db DRAGONITE, TCG_LIGHTNING, TCG_GRASS
	db MDRAGONITE, TCG_LIGHTNING, TCG_GRASS
	db KABUTO, TCG_LIGHTNING, TCG_LIGHTNING
	db KABUTOPS, TCG_LIGHTNING, TCG_LIGHTNING
	db OMANYTE, TCG_PSYCHIC, TCG_PSYCHIC
	db OMASTAR, TCG_PSYCHIC, TCG_PSYCHIC
; 5
	db ARM_MEWTWO, TCG_FIRE, TCG_LIGHTNING
	db MEWTWO, TCG_FIRE, TCG_LIGHTNING
	db MMEWTWOX, TCG_FIRE, TCG_LIGHTNING
	db MMEWTWOY, TCG_FIRE, TCG_LIGHTNING
	db MEW, TCG_FIRE, TCG_WATER
	db VENUSTOISE, TCG_FIGHTING, TCG_PSYCHIC
	db -1

ConvertVanillaTypeToTCGType:
	ld b, a ; b stores the original type
	ld a, [wPersonalizationTCGMode]
	and a
	ld a, b ; restored original type
	ret z
; TCG mode is actually ON
	cp NORMAL
	jr z, .convertToTCG_Colorless
	cp FIGHTING
	jr z, .convertToTCG_Fighting
	cp FLYING
	jr z, .convertToTCG_Colorless
	cp POISON
	jr z, .convertToTCG_Grass
	cp GROUND
	jr z, .convertToTCG_Fighting
	cp ROCK
	jr z, .convertToTCG_Fighting
	cp BUG
	jr z, .convertToTCG_Grass
	cp STEEL
	jr z, .convertToTCG_Metal
	cp FIRE
	jr z, .convertToTCG_Fire
	cp WATER
	jr z, .convertToTCG_Water
	cp GRASS
	jr z, .convertToTCG_Grass
	cp ELECTRIC
	jr z, .convertToTCG_Lightning
	cp ICE
	jr z, .convertToTCG_Water
	cp DRAGON
	jr z, .convertToTCG_Dragon
	cp DARK
	jr z, .convertToTCG_Dark
; last cps are unnecessary
;	cp GHOST
;	jr z, .convertToTCG_Psychic
;	cp PSYCHIC_TYPE
;	jr z, .convertToTCG_Psychic
;	cp FAIRY ; last 
;	jr z, .convertToTCG_Psychic
;.convertToTCG_Psychic
	ld a, TCG_PSYCHIC
	ret
.convertToTCG_Colorless
	ld a, TCG_COLORLESS
	ret
.convertToTCG_Fire
	ld a, TCG_FIRE
	ret
.convertToTCG_Fighting
	ld a, TCG_FIGHTING
	ret
.convertToTCG_Metal
	ld a, TCG_METAL
	ret
.convertToTCG_Water
	ld a, TCG_WATER
	ret
.convertToTCG_Grass
	ld a, TCG_GRASS
	ret
.convertToTCG_Lightning
	ld a, TCG_LIGHTNING
	ret
.convertToTCG_Dragon
	ld a, TCG_DRAGON
	ret
.convertToTCG_Dark
	ld a, TCG_DARK
	ret
	