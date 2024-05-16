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

TMMartClerkDialogue::
	ld a, 1
	ld [wUpdateSpritesEnabled], a

	ld de, wItemList

	; beginner?
	ld a, TX_SCRIPT_MART
	ld [de], a
	inc de

; 50-to-55 custom additions -----------------------------------

	; TM01
	CheckHideShow HS_MT_MOON_B2F_ITEM_2
	jr z, .checkTM02
	ld a, TM_MEGA_PUNCH
	ld [de], a
	inc de
.checkTM02

	; TM02
	CheckHideShow HS_ROCKET_HIDEOUT_B4F_ITEM_2
	jr z, .checkTM03
	ld a, TM_MEGAHORN
	ld [de], a
	inc de
.checkTM03

	; TM03
	CheckHideShow HS_SILPH_CO_7F_ITEM_2
	jr z, .checkTM04
	ld a, TM_SWORDS_DANCE
	ld [de], a
	inc de
.checkTM04

	; TM04
	CheckHideShow HS_ROUTE_4_ITEM
	jr z, .checkTM05
	ld a, TM_COUNTER
	ld [de], a
	inc de
.checkTM05

	; TM05
	CheckHideShow HS_VICTORY_ROAD_2F_ITEM_3
	jr z, .checkTM06
	ld a, TM_DRAGON_CLAW
	ld [de], a
	inc de
.checkTM06

	; TM06
	CheckEvent EVENT_GOT_TM06
	jr z, .checkTM07
	ld a, TM_TOXIC
	ld [de], a
	inc de
.checkTM07

	; TM07
	CheckHideShow HS_ROCKET_HIDEOUT_B2F_ITEM_3
	jr z, .checkTM08
	ld a, TM_DARK_PULSE
	ld [de], a
	inc de
.checkTM08

	; TM08
	CheckHideShow HS_SS_ANNE_1F_ROOMS_ITEM
	jr z, .checkTM09
	ld a, TM_BODY_SLAM
	ld [de], a
	inc de
.checkTM09

	; TM09
	CheckHideShow HS_OBSIDIAN_WAREHOUSE_ITEM_2
	jr z, .checkTM10
	ld a, TM_METEOR_MASH
	ld [de], a
	inc de
.checkTM10

	; TM10
	CheckHideShow HS_ROCKET_HIDEOUT_B3F_ITEM_1
	jr z, .checkTM11
	ld a, TM_DOUBLE_EDGE
	ld [de], a
	inc de
.checkTM11

	; TM11
	CheckEvent EVENT_GOT_TM11
	jr z, .checkTM12
	ld a, TM_BUBBLEBEAM
	ld [de], a
	inc de
.checkTM12

	; TM12
	CheckHideShow HS_MT_MOON_1F_ITEM_6
	jr z, .checkTM13
	ld a, TM_METRONOME
	ld [de], a
	inc de
.checkTM13

	; TM13
	CheckEvent EVENT_GOT_TM13
	jr z, .checkTM14
	ld a, TM_ICE_BEAM
	ld [de], a
	inc de
.checkTM14

	; TM14
	CheckHideShowExtra HS_POKEMON_MANSION_B1F_ITEM_3
	jr z, .checkTM15
	ld a, TM_BLIZZARD
	ld [de], a
	inc de
.checkTM15

	; TM15
	CheckEvent EVENT_OBTAINED_PRIZE_TM_2
	jr z, .checkTM16
	ld a, TM_HYPER_BEAM
	ld [de], a
	inc de
.checkTM16

	; TM16
	CheckHideShow HS_ROUTE_12_ITEM_1
	jr z, .checkTM17
	ld a, TM_MIRROR_COAT
	ld [de], a
	inc de
.checkTM17

	; TM17
	CheckHideShow HS_VICTORY_ROAD_2F_ITEM_1
	jr z, .checkTM18
	ld a, TM_DRAININGKISS
	ld [de], a
	inc de
.checkTM18

	; TM18
	CheckEvent EVENT_GOT_TM18
	jr z, .checkTM19
	ld a, TM_FLASH_CANNON
	ld [de], a
	inc de
.checkTM19

	; TM19
	CheckHideShow HS_ROUTE_25_ITEM
	jr z, .checkTM20
	ld a, TM_SEISMIC_TOSS
	ld [de], a
	inc de
.checkTM20

	; TM20
	CheckHideShow HS_ROUTE_15_ITEM
	jr z, .checkTM21
	ld a, TM_FEINT_ATTACK
	ld [de], a
	inc de
.checkTM21

	; TM21
	CheckEvent EVENT_GOT_TM21
	jr z, .checkTM22
	ld a, TM_GIGA_DRAIN
	ld [de], a
	inc de
.checkTM22

	; TM22
	CheckHideShowExtra HS_POKEMON_MANSION_B1F_ITEM_4
	jr z, .checkTM23
	ld a, TM_STONE_EDGE
	ld [de], a
	inc de
.checkTM23

	; TM23
	CheckEvent EVENT_OBTAINED_PRIZE_TM_1
	jr z, .checkTM24
	ld a, TM_WILL_O_WISP
	ld [de], a
	inc de
.checkTM24

	; TM24
	CheckEvent EVENT_GOT_TM24
	jr z, .checkTM25
	ld a, TM_THUNDERBOLT
	ld [de], a
	inc de
.checkTM25

	; TM25
	CheckHideShow HS_POWER_PLANT_ITEM_3
	jr z, .checkTM26
	ld a, TM_THUNDER
	ld [de], a
	inc de
.checkTM26

	; TM26
	CheckHideShow HS_SILPH_CO_10F_ITEM_1
	jr z, .checkTM27
	ld a, TM_EARTHQUAKE
	ld [de], a
	inc de
.checkTM27

	; TM27
	CheckHideShow HS_VIRIDIAN_GYM_ITEM_2
	jr z, .checkTM28
	ld a, TM_FISSURE
	ld [de], a
	inc de
.checkTM28

	; TM28
	CheckHideShow HS_CERULEAN_ROCKET
	jr z, .checkTM29
	ld a, TM_DIG
	ld [de], a
	inc de
.checkTM29

	; TM29
	CheckEvent EVENT_GOT_TM29
	jr z, .checkTM30
	ld a, TM_PSYCHIC_M
	ld [de], a
	inc de
.checkTM30

	; TM30
	CheckHideShow HS_ROUTE_9_ITEM
	jr z, .checkTM31
	ld a, TM_MOONBLAST
	ld [de], a
	inc de
.checkTM31











	; TM45
	CheckHideShow HS_POWER_PLANT_ITEM_4
	jr z, .checkTM46
	ld a, TM_THUNDER_WAVE
	ld [de], a
	inc de
.checkTM46


; ender of the custom itemlist load function -----------------
	ld a, -1
	ld [de], a

	ld a, PRICEDITEMLISTMENU
	ld [wListMenuID], a
	callfar DisplayPokemartDialogue_

	ret

; ------------------------

TMMartClerkDialogue2::
	callfar CountHowManyBadges ; d contains the number of badges
	ld a, d
	and a
	jr nz, .atLeastABadge
; we have no badges
	ld hl, TMPokemartGreetingTextBadgeless
	call PrintText
	jr .endScript
.atLeastABadge
	push af
	ld hl, TMPokemartGreetingText
	call PrintText
	pop af
	cp 1
	jr z, .badgesN1
	cp 2
	jr z, .badgesN2
	cp 3
	jr z, .badgesN3
	cp 4
	jr z, .badgesN4
	cp 5
	jr z, .badgesN5
	cp 6
	jr z, .badgesN6
	cp 7
	jr z, .badgesN7
; 8 badges
	ld hl, TMClerkItemsBadgesN8
	jr .continue
.badgesN7
	ld hl, TMClerkItemsBadgesN7
	jr .continue
.badgesN6
	ld hl, TMClerkItemsBadgesN6
	jr .continue
.badgesN5
	ld hl, TMClerkItemsBadgesN5
	jr .continue
.badgesN4
	ld hl, TMClerkItemsBadgesN4
	jr .continue
.badgesN3
	ld hl, TMClerkItemsBadgesN3
	jr .continue
.badgesN2
	ld hl, TMClerkItemsBadgesN2
	jr .continue
.badgesN1
	ld hl, TMClerkItemsBadgesN1
.continue
	inc hl
	call LoadItemList
	ld a, PRICEDITEMLISTMENU
	ld [wListMenuID], a
	callfar DisplayPokemartDialogue_
.endScript
	ret

TMPokemartGreetingTextBadgeless:
    text_far _TMPokemartGreetingTextBadgeless
    text_end

TMPokemartGreetingText:
    text_far _TMPokemartGreetingText
    text_end

TMClerkItemsBadgesN1:
    script_mart TM_BIDE

TMClerkItemsBadgesN2:
    script_mart TM_MEGA_PUNCH, TM_COUNTER, TM_BUBBLEBEAM, TM_METRONOME, TM_SEISMIC_TOSS, TM_BIDE, TM_THUNDER_WAVE

TMClerkItemsBadgesN3:
    script_mart TM_MEGA_PUNCH, TM_COUNTER, TM_BODY_SLAM, TM_BUBBLEBEAM, TM_METRONOME, TM_SEISMIC_TOSS, TM_THUNDERBOLT, TM_DIG, TM_BIDE, TM_X_SCISSOR, TM_THUNDER_WAVE

TMClerkItemsBadgesN4:
    script_mart TM_MEGA_PUNCH, TM_MEGAHORN, TM_COUNTER, TM_DARK_PULSE, TM_BODY_SLAM, TM_DOUBLE_EDGE, TM_BUBBLEBEAM, TM_METRONOME, TM_SEISMIC_TOSS, TM_GIGA_DRAIN, TM_THUNDERBOLT, TM_DIG, TM_MOONBLAST, TM_BIDE, TM_X_SCISSOR, TM_THUNDER_WAVE

TMClerkItemsBadgesN5:
    script_mart TM_MEGA_PUNCH, TM_MEGAHORN, TM_COUNTER, TM_TOXIC, TM_DARK_PULSE, TM_BODY_SLAM, TM_DOUBLE_EDGE, TM_BUBBLEBEAM, TM_METRONOME, TM_ICE_BEAM, TM_FLASH_CANNON, TM_SEISMIC_TOSS, TM_FEINT_ATTACK, TM_GIGA_DRAIN, TM_THUNDERBOLT, TM_DIG, TM_MOONBLAST, TM_BIDE, TM_SHADOW_SNEAK, TM_X_SCISSOR, TM_THUNDER_WAVE, TM_ROCK_SLIDE, TM_SHADOW_BALL

TMClerkItemsBadgesN6:
    script_mart TM_MEGA_PUNCH, TM_MEGAHORN, TM_SWORDS_DANCE, TM_COUNTER, TM_TOXIC, TM_DARK_PULSE, TM_BODY_SLAM, TM_DOUBLE_EDGE, TM_BUBBLEBEAM, TM_METRONOME, TM_ICE_BEAM, TM_FLASH_CANNON, TM_SEISMIC_TOSS, TM_FEINT_ATTACK, TM_GIGA_DRAIN, TM_THUNDERBOLT, TM_EARTHQUAKE, TM_DIG, TM_PSYCHIC_M, TM_MOONBLAST, TM_MIMIC, TM_BIDE, TM_SELFDESTRUCT, TM_SHADOW_SNEAK, TM_X_SCISSOR, TM_THUNDER_WAVE, TM_PSYWAVE, TM_ROCK_SLIDE, TM_SHADOW_BALL

TMClerkItemsBadgesN7:
    script_mart TM_MEGA_PUNCH, TM_MEGAHORN, TM_SWORDS_DANCE, TM_COUNTER, TM_TOXIC, TM_DARK_PULSE, TM_BODY_SLAM, TM_METEOR_MASH, TM_DOUBLE_EDGE, TM_BUBBLEBEAM, TM_METRONOME, TM_ICE_BEAM, TM_BLIZZARD, TM_FLASH_CANNON, TM_SEISMIC_TOSS, TM_FEINT_ATTACK, TM_GIGA_DRAIN, TM_STONE_EDGE, TM_THUNDERBOLT, TM_EARTHQUAKE, TM_DIG, TM_PSYCHIC_M, TM_MOONBLAST, TM_MIMIC, TM_DOUBLE_TEAM, TM_BIDE, TM_HYDRO_PUMP, TM_SELFDESTRUCT, TM_CLOSE_COMBAT, TM_FIRE_BLAST, TM_SHADOW_SNEAK, TM_OUTRAGE, TM_X_SCISSOR, TM_THUNDER_WAVE, TM_PSYWAVE, TM_ROCK_SLIDE, TM_SHADOW_BALL

TMClerkItemsBadgesN8:
	script_mart TM_MEGA_PUNCH, TM_MEGAHORN, TM_SWORDS_DANCE, TM_COUNTER, TM_TOXIC, TM_DARK_PULSE, TM_BODY_SLAM, TM_METEOR_MASH, TM_DOUBLE_EDGE, TM_BUBBLEBEAM, TM_METRONOME, TM_ICE_BEAM, TM_BLIZZARD, TM_MIRROR_COAT, TM_FLASH_CANNON, TM_SEISMIC_TOSS, TM_FEINT_ATTACK, TM_GIGA_DRAIN, TM_STONE_EDGE, TM_THUNDERBOLT, TM_THUNDER, TM_EARTHQUAKE, TM_FISSURE, TM_DIG, TM_PSYCHIC_M, TM_MOONBLAST, TM_MIMIC, TM_DOUBLE_TEAM, TM_REFLECT, TM_BIDE, TM_HYDRO_PUMP, TM_SELFDESTRUCT, TM_CLOSE_COMBAT, TM_FIRE_BLAST, TM_SHADOW_SNEAK, TM_OUTRAGE, TM_BRAVE_BIRD, TM_REST, TM_X_SCISSOR, TM_THUNDER_WAVE, TM_PSYWAVE, TM_ROCK_SLIDE, TM_SHADOW_BALL
