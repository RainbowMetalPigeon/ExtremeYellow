SpawnTraveler::
    ld hl, wCurrentMapScriptFlags
    bit 5, [hl]
    res 5, [hl]
    ret z
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE
	ret z
	CheckEvent EVENT_BEAT_INTERDIMENSIONAL_TRAVELER
	ret nz
	call Random
	cp 13
	jr c, .makeAppear
    call LoopHideTraveler
    call LoopHideTravelerExtra
	ret
.makeAppear
    call LoopShowTraveler
    call LoopShowTravelerExtra
    ret

LoopShowTraveler::
	ld hl, TravelerToHideShow
.loop
	ld a, [hli]
	cp $ff
	ret z
	push hl
	ld [wMissableObjectIndex], a
	predef ShowObject
	pop hl
	jr .loop

LoopHideTraveler::
	ld hl, TravelerToHideShow
.loop
	ld a, [hli]
	cp $ff
	ret z
	push hl
	ld [wMissableObjectIndex], a
	predef HideObject
	pop hl
	jr .loop

LoopShowTravelerExtra::
	ld hl, TravelerToHideShowExtra
.loop
	ld a, [hli]
	cp $ff
	ret z
	push hl
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	pop hl
	jr .loop

LoopHideTravelerExtra::
	ld hl, TravelerToHideShowExtra
.loop
	ld a, [hli]
	cp $ff
	ret z
	push hl
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	pop hl
	jr .loop

TravelerToHideShow::
	db HS_VIRIDIAN_CITY_TRAVELER
	db HS_PEWTER_CITY_TRAVELER
	db HS_CERULEAN_CITY_TRAVELER
	db HS_VERMILION_CITY_TRAVELER
	db HS_CELADON_CITY_TRAVELER
	db HS_SAFFRON_CITY_TRAVELER
	db $ff

TravelerToHideShowExtra::
	db HS_LAVENDER_TOWN_TRAVELER
	db HS_OCHRE_CITY_TRAVELER
	db HS_FUCHSIA_CITY_TRAVELER
	db HS_OBSIDIAN_ISLAND_TRAVELER
	db HS_CINNABAR_ISLAND_TRAVELER
	db $ff

; --------------------------------

CheckIfMegaMewtwoInParty:: ; testing
	ld hl, wPartyCount
	ld a, [hli]
	ld b, a ; b has the numnber of Mons in the party
.loop
	ld a, [hli]
	cp MMEWTWOX
	jp z, .MMewtwoInParty
	cp MMEWTWOY
	jp z, .MMewtwoInParty
	dec b
	jr nz, .loop
	cp 0 ; a is always >=1, so when we do cp 0 the carry flag is never set (a-0)
		 ; this is the opposite of what happens if a Mega Mewtwo IS in the party
	ret
.MMewtwoInParty
	scf ; set carry flag
	ret
