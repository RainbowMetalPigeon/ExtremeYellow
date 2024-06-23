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
	; HITMONs each with their own specialty? LEE GROUND, CHAN... ELECTRIC?, TOP... PSYCHIC_TYPE? FLYING?
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
