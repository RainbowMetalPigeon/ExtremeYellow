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
; new, to personalize types
	ld a, [wPersonalizationTypes] ; 0=CLASSIC, 1=NEW
	and a
	ret z ; if types are the hard-coded ones, we're good
; otherwise, overwrite them
	ld hl, ListOfMonsAndTypesToChange
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

ListOfMonsAndTypesToChange:
	db VENUSAUR, GRASS, GROUND
	db MVENUSAUR, GRASS, GROUND
	db CHARIZARD, FIRE, DRAGON
	db MCHARZARDY, FIRE, DRAGON
	db BLASTOISE, WATER, ROCK
	db MBLASTOISE, WATER, ROCK
	db BUTTERFREE, BUG, PSYCHIC_TYPE
	db PIDGEY, FLYING, FLYING
	db PIDGEOTTO, FLYING, FLYING
	db PIDGEOT, FLYING, FLYING
	db MPIDGEOT, FLYING, FLYING
	db RATTATA, NORMAL, GROUND
	db RATICATE, NORMAL, GROUND
	db ARBOK, POISON, DARK
	db VULPIX, FIRE, GHOST
	db NINETALES, FIRE, GHOST
	db BELLOSSOM, GRASS, FIRE
	db PSYDUCK, WATER, PSYCHIC_TYPE
	db GOLDUCK, WATER, PSYCHIC_TYPE
	db ARCANINE, FIRE, DRAGON ; TBV
	db GEODUDE, ROCK, ROCK
	db GRAVELER, ROCK, ROCK
	db GOLEM, ROCK, ROCK
	db DODRIO, FLYING, FIGHTING
	db MUK, POISON, FIGHTING
	db CLOYSTER, ICE, ROCK
	db GASTLY, GHOST, DARK
	db HAUNTER, GHOST, DARK
	db GENGAR, GHOST, DARK
	db MGENGAR, GHOST, DARK
	db DROWZEE, PSYCHIC_TYPE, DARK
	db HYPNO, PSYCHIC_TYPE, DARK
	db KINGLER, WATER, ROCK
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
	db ELEKID, ELECTRIC, FIGHTING
	db ELECTABUZZ, ELECTRIC, FIGHTING
	db ELECTIVIRE, ELECTRIC, FIGHTING
	db MAGBY, FIRE, POISON
	db MAGMAR, FIRE, POISON
	db MAGMORTAR, FIRE, POISON
	db TAUROS, NORMAL, GROUND
	db GYARADOS, WATER, DRAGON
	db MGYARADOS, WATER, DRAGON
	db PORYGON, ELECTRIC, GHOST
	db PORYGON2, ELECTRIC, GHOST
	db PORYGONZ, ELECTRIC, GHOST
	db KABUTO, ROCK, BUG
	db KABUTOPS, ROCK, BUG
	db AERODACTYL, ROCK, DRAGON
	db MARODACTYL, ROCK, DRAGON
	db DRATINI, DRAGON, WATER
	db DRAGONAIR, DRAGON, WATER
	db -1

UpdatePartyMonTypesAfterPersonalization:
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
	ld de, ListOfMonsAndTypesToChange
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
	ld hl, ListOfMonsAndTypesToChange
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
