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

; new, for delta species, TBE
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
	db GYARADOS, WATER, DRAGON
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

	db NIDORAN_F, STEEL, STEEL
	db NIDORINA, STEEL, STEEL
	db NIDOQUEEN, STEEL, STEEL

	db NIDORAN_M, DARK, DARK
	db NIDORINO, DARK, DARK
	db NIDOKING, DARK, DARK

	db ZUBAT, BUG, STEEL
	db GOLBAT, BUG, STEEL
	db CROBAT, BUG, STEEL

; 2

	db EEVEE, STEEL, STEEL
	db ESPEON, PSYCHIC_TYPE, STEEL
	db FLAREON, FIRE, STEEL
	db JOLTEON, ELECTRIC, STEEL
	db UMBREON, DARK, STEEL
	db VAPOREON, WATER, STEEL

	db HORSEA, FIRE, ROCK
	db SEADRA, FIRE, ROCK
	db KINGDRA, FIRE, ROCK

	db ODDISH, FAIRY, FAIRY
	db GLOOM, FAIRY, FAIRY
	db VILEPLUME, FAIRY, STEEL
	db BELLOSSOM, WATER, WATER

	db PSYDUCK, ELECTRIC, ELECTRIC
	db GOLDUCK, ELECTRIC, ELECTRIC

	db MEOWTH, DARK, STEEL
	db PERSIAN, DARK, STEEL

	db EKANS, FIRE, FIRE
	db ARBOK, FIRE, FIRE

	db VULPIX, PSYCHIC_TYPE, FAIRY
	db NINETALES, PSYCHIC_TYPE, FAIRY

	db KRABBY, FIRE, FIRE
	db KINGLER, FIRE, STEEL

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

	db MAGIKARP, STEEL, STEEL
	db GYARADOS, ELECTRIC, FIRE
	db MGYARADOS, ELECTRIC, FIRE

	db STARYU, ICE, ICE
	db STARMIE, ICE, STEEL
	db MSTARMIE, ICE, STEEL

	db EXEGGCUTE, ROCK, ROCK
	db EXEGGUTOR, ROCK, ROCK

	db SQUIRTLE, ROCK, ROCK
	db WARTORTLE, ROCK, ROCK
	db BLASTOISE, ROCK, STEEL
	db MBLASTOISE, ROCK, STEEL

	db CHARMANDER, ELECTRIC, ELECTRIC
	db CHARMELEON, ELECTRIC, ELECTRIC
	db CHARIZARD, ELECTRIC, DARK
	db MCHARZARDX, ELECTRIC, DARK
	db MCHARZARDY, ELECTRIC, DARK

	db BULBASAUR, ICE, GHOST
	db IVYSAUR, ICE, GHOST
	db VENUSAUR, ICE, GHOST
	db MVENUSAUR, ICE, GHOST

; 4

	db PINSIR, GROUND, FIGHTING
	db MPINSIR, GROUND, FIGHTING

	db MUNCHLAX, BUG, BUG
	db SNORLAX, BUG, BUG

	db DRATINI, ELECTRIC, GRASS
	db DRAGONAIR, ELECTRIC, GRASS
	db DRAGONITE, ELECTRIC, GRASS
	db MDRAGONITE, ELECTRIC, GRASS

	db KABUTO, ELECTRIC, ELECTRIC
	db KABUTOPS, ELECTRIC, ELECTRIC
	
	db OMANYTE, GHOST, FAIRY
	db OMASTAR, GHOST, FAIRY
	
	db AERODACTYL, FIRE, FIRE
	db MARODACTYL, FIRE, FIRE

	db CUBONE, FIGHTING, FIGHTING
	db MAROWAK, FIGHTING, STEEL

; 5

	db ARM_MEWTWO, FIRE, ELECTRIC
	db MEWTWO, FIRE, ELECTRIC
	db MMEWTWOX, FIRE, ELECTRIC
	db MMEWTWOY, FIRE, ELECTRIC

	db MEW, FIRE, WATER

	db -1
