; d contains the Pokemon you want to check
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
	ld hl, AllFinalStageMons
; generate a random number between 0 and len(FullyEvolvedMons)-1, i.e. 0 and 105 included
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
	jr .doneOffset

.standardBattleMode ; depending on winning streak and which mon number, choose normal list or Megas' one
	ld a, [wBattleFacilityWhichMonIsRandomized]
	ld hl, wBattleFacilityWinningStreak
	ld b, [hl] ; how many consecutive victories do we have in this session?
	add b ; now a contains a+b, i.e. which mon in the BF trainer team's is being randomized + how many victories we have
	cp 7 ; is the sum of a+b at least 7?
	jr nc, .RNGLoopMega ; if yes, load the list of megas; if not, load the list of non-mega mons

; loopS for non-Mega
.RNGLoop
	ld hl, FullyEvolvedMons
; generate a random number between 0 and len(FullyEvolvedMons)-1, i.e. 0 and 84 included
	call Random
	cp 85 ; 84+1
	jr nc, .RNGLoop
; a contains a valid number, now we need to access the a-th element of the list we decided about earlier
.uglyLoop
	dec a
	cp $FF
	jr z, .doneUglyLoop
	inc hl
	jr .uglyLoop
.doneUglyLoop
; finally, we need to check if the mon we just generated is the same as any of the previously generated ones
	ld a, [wBattleFacilityMonNumber1]
	cp [hl] ; hl points to the mon we are trying to generate
	jr z, .RNGLoop
	ld a, [wBattleFacilityMonNumber2]
	cp [hl] ; hl points to the mon we are trying to generate
	jr z, .RNGLoop
	ld a, [wBattleFacilityMonNumber3]
	cp [hl] ; hl points to the mon we are trying to generate
	jr z, .RNGLoop
	ld a, [wBattleFacilityMonNumber4]
	cp [hl] ; hl points to the mon we are trying to generate
	jr z, .RNGLoop
	ld a, [wBattleFacilityMonNumber5]
	cp [hl] ; hl points to the mon we are trying to generate
	jr z, .RNGLoop
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

AllFinalStageMons: ; 0-105
;	db MEW ; no, to make it more unique, only you and Rival can have it
	db MEWTWO
	db ARTICUNO
	db ZAPDOS
	db MOLTRES
	db MMEWTWOX
	db MMEWTWOY
FullyEvolvedMons: ; 0-84
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
MegaEvolvedMons: ; 0-14
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

; =====================================
