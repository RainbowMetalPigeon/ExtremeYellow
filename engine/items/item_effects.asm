UseItem_::
	ld a, 1
	ld [wActionResultOrTookBattleTurn], a ; initialise to success value
	ld a, [wcf91] ;contains item_ID
	cp HM01
	jp nc, ItemUseTMHM
	ld hl, ItemUsePtrTable
	dec a
	add a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

ItemUsePtrTable:
; entries correspond to item ids
	dw ItemUseBall       ; MASTER_BALL
	dw ItemUseBall       ; ULTRA_BALL
	dw ItemUseBall       ; GREAT_BALL
	dw ItemUseBall       ; POKE_BALL
	dw ItemUseTownMap    ; TOWN_MAP
	dw ItemUseBicycle    ; BICYCLE
	dw ItemUseSurfboard  ; out-of-battle Surf effect
	dw ItemUseBall       ; SAFARI_BALL
	dw ItemUsePokedex    ; POKEDEX
	dw ItemUseEvoStone   ; MOON_STONE
	dw ItemUseMedicine   ; ANTIDOTE
	dw ItemUseMedicine   ; BURN_HEAL
	dw ItemUseMedicine   ; ICE_HEAL
	dw ItemUseMedicine   ; AWAKENING
	dw ItemUseMedicine   ; PARLYZ_HEAL
	dw ItemUseMedicine   ; FULL_RESTORE
	dw ItemUseMedicine   ; MAX_POTION
	dw ItemUseMedicine   ; HYPER_POTION
	dw ItemUseMedicine   ; SUPER_POTION
	dw ItemUseMedicine   ; POTION
	dw ItemUseBait       ; BOULDERBADGE
	dw ItemUseRock       ; CASCADEBADGE
	dw UnusableItem      ; THUNDERBADGE
	dw UnusableItem      ; RAINBOWBADGE
	dw UnusableItem      ; SOULBADGE
	dw UnusableItem      ; MARSHBADGE
	dw UnusableItem      ; VOLCANOBADGE
	dw UnusableItem      ; EARTHBADGE
	dw ItemUseEscapeRope ; ESCAPE_ROPE
	dw ItemUseRepel      ; REPEL
	dw UnusableItem      ; OLD_AMBER
	dw ItemUseEvoStone   ; FIRE_STONE
	dw ItemUseEvoStone   ; THUNDER_STONE
	dw ItemUseEvoStone   ; WATER_STONE
	dw ItemUseVitamin    ; HP_UP
	dw ItemUseVitamin    ; PROTEIN
	dw ItemUseVitamin    ; IRON
	dw ItemUseVitamin    ; CARBOS
	dw ItemUseVitamin    ; CALCIUM
	dw ItemUseVitamin    ; RARE_CANDY
	dw UnusableItem      ; DOME_FOSSIL
	dw UnusableItem      ; HELIX_FOSSIL
	dw UnusableItem      ; SECRET_KEY
	dw ItemUseVitamin    ; CHEAT_CANDY, new
	dw UnusableItem      ; BIKE_VOUCHER
	dw ItemUseXAccuracy  ; X_ACCURACY
	dw ItemUseEvoStone   ; LEAF_STONE
	dw ItemUseCardKey    ; CARD_KEY
	dw UnusableItem      ; NUGGET
	dw UnusableItem      ; ??? PP_UP
	dw ItemUsePokedoll   ; POKE_DOLL
	dw ItemUseMedicine   ; FULL_HEAL
	dw ItemUseMedicine   ; REVIVE
	dw ItemUseMedicine   ; MAX_REVIVE
	dw ItemUseGuardSpec  ; GUARD_SPEC
	dw ItemUseSuperRepel ; SUPER_REPL
	dw ItemUseMaxRepel   ; MAX_REPEL
	dw ItemUseDireHit    ; DIRE_HIT
	dw UnusableItem      ; COIN
	dw ItemUseMedicine   ; FRESH_WATER
	dw ItemUseMedicine   ; SODA_POP
	dw ItemUseMedicine   ; LEMONADE
	dw UnusableItem      ; S_S_TICKET
	dw UnusableItem      ; GOLD_TEETH
	dw ItemUseXStat      ; X_ATTACK
	dw ItemUseXStat      ; X_DEFEND
	dw ItemUseXStat      ; X_SPEED
	dw ItemUseXStat      ; X_SPECIAL
	dw ItemUseCoinCase   ; COIN_CASE
	dw ItemUseOaksParcel ; OAKS_PARCEL
	dw ItemUseItemfinder ; ITEMFINDER
	dw UnusableItem      ; SILPH_SCOPE
	dw ItemUsePokeflute  ; POKE_FLUTE
	dw UnusableItem      ; LIFT_KEY
	dw UnusableItem      ; EXP_ALL
	dw ItemUseOldRod     ; OLD_ROD
	dw ItemUseGoodRod    ; GOOD_ROD
	dw ItemUseSuperRod   ; SUPER_ROD
	dw ItemUsePPUp       ; PP_UP (real one)
	dw ItemUsePPRestore  ; ETHER
	dw ItemUsePPRestore  ; MAX_ETHER
	dw ItemUsePPRestore  ; ELIXER
	dw ItemUsePPRestore  ; MAX_ELIXER
	dw ItemUseEvoStone   ; MEGA_STONE_X, new
	dw ItemUseEvoStone   ; MEGA_STONE_Y, new
	dw ItemUseEvoStone   ; SUN_STONE, new
	dw ItemUseEvoStone   ; ICE_STONE, new
	dw ItemUseEvoStone   ; KINGS_ROCK, new
	dw ItemUseEvoStone	 ; METAL_COAT, new
	dw ItemUseEvoStone	 ; UPGRADE, new
	dw ItemUseEvoStone	 ; DUBIOUS_DISK, new
	dw ItemUseBall       ; FAST_BALL, new, testing
	dw ItemUseBall       ; HEAVY_BALL, new, testing
	dw ItemUseVitamin    ; LEGEND_CANDY, new
	dw UnusableItem      ; BIG_NUGGET, new
	dw ItemUseVitamin    ; PERFECTER, new
	dw UnusableItem      ; LUNAR_RELIC, new
	dw UnusableItem      ; ICE_ORB, new
	dw UnusableItem      ; THUNDER_ORB, new
	dw UnusableItem      ; FIRE_ORB, new
	dw UnusableItem      ; LIGHT_BALL, new, testing
	dw ItemShowMysteryMap ; MYSTERY_MAP, new, TBE
	dw UnusableItem      ; LAVA_STONE, new
	dw UnusableItem      ; MAGMA_STONE, new
	dw UnusableItem      ; MOLTEN_STONE, new
	dw UnusableItem      ; ARTIFACT, new
	dw ItemUseVitamin    ; CHROMOGENE, new
	dw UnusableItem      ; SHINY_CHARM, new
	dw UnusableItem      ; GUTSCHEIN, new
	dw ItemUseOnigiri    ; ONIGIRI_BOX, new
	dw ItemUseEvoStone   ; LINK_CABLE, new
	dw UnusableItem      ; AMULET_COIN, new

; new: code for MYSTERY_MAP, beginning ------------------------

ItemShowMysteryMap: ; new
	ld a, [wIsInBattle]
	and a
	jp nz, ItemUseNotTime
	CheckEvent EVENT_OBTAIN_MAP_PIECE_1_BIRD_FAN_CLUB
	jr z, .notAllPieces
	CheckEvent EVENT_OBTAIN_MAP_PIECE_2_PIGEON
	jr z, .notAllPieces
	CheckEvent EVENT_OBTAIN_MAP_PIECE_3_TREASURE_HUNTER
	jr z, .notAllPieces
	CheckEvent EVENT_OBTAIN_MAP_PIECE_4_RESCUED_TRAVELER
	jr z, .notAllPieces
	call EnableAutoTextBoxDrawing
	tx_pre MapMessageComplete
	jr .postPrinting
.notAllPieces
	call EnableAutoTextBoxDrawing
	tx_pre MapMessage
.postPrinting
;	ld a, [wcf91]
;	ld e, a
;	push de
	CheckEvent EVENT_OBTAIN_MAP_PIECE_1_BIRD_FAN_CLUB
	jr nz, .piece_1
; no piece 1
	CheckEvent EVENT_OBTAIN_MAP_PIECE_2_PIGEON
	jr nz, .piece_no1_2
; no piece 1, 2
	CheckEvent EVENT_OBTAIN_MAP_PIECE_3_TREASURE_HUNTER
	jr nz, .piece_no12_3
; no piece 1, 2, 3
	ld a, MAP_PIECES_4
	jp .printMap
.piece_no12_3
	CheckEvent EVENT_OBTAIN_MAP_PIECE_4_RESCUED_TRAVELER
	jr nz, .piece_no12_34
; no piece 1, 2, 4
	ld a, MAP_PIECES_3
	jr .printMap
.piece_no12_34
	ld a, MAP_PIECES_34
	jr .printMap
.piece_no1_2
	CheckEvent EVENT_OBTAIN_MAP_PIECE_3_TREASURE_HUNTER
	jr nz, .piece_no1_23
; piece 2 ; no piece 1, 3
	CheckEvent EVENT_OBTAIN_MAP_PIECE_4_RESCUED_TRAVELER
	jr nz, .piece_no13_24
; piece 2 ; no piece 1, 3, 4
	ld a, MAP_PIECES_2
	jr .printMap
.piece_no13_24
	ld a, MAP_PIECES_24
	jr .printMap
.piece_no1_23
	CheckEvent EVENT_OBTAIN_MAP_PIECE_4_RESCUED_TRAVELER
	jr nz, .piece_no1_234
; piece 2, 3 ; no piece 1, 4
	ld a, MAP_PIECES_23
	jr .printMap
.piece_no1_234
	ld a, MAP_PIECES_234
	jr .printMap
.piece_1
	CheckEvent EVENT_OBTAIN_MAP_PIECE_2_PIGEON
	jr nz, .piece_12
; piece 1 ; no piece 2
	CheckEvent EVENT_OBTAIN_MAP_PIECE_3_TREASURE_HUNTER
	jr nz, .piece_no2_13
; piece 1 ; no piece 2, 3
	CheckEvent EVENT_OBTAIN_MAP_PIECE_4_RESCUED_TRAVELER
	jr nz, .piece_no23_14
; piece 1 ; no piece 2, 3, 4
	ld a, MAP_PIECES_1
	jr .printMap
.piece_no23_14
	ld a, MAP_PIECES_14
	jr .printMap
.piece_no2_13
	CheckEvent EVENT_OBTAIN_MAP_PIECE_4_RESCUED_TRAVELER
	jr nz, .piece_no2_134
; piece 1, 3; no piece 2, 4
	ld a, MAP_PIECES_13
	jr .printMap
.piece_no2_134
	ld a, MAP_PIECES_134
	jr .printMap
.piece_12
	CheckEvent EVENT_OBTAIN_MAP_PIECE_3_TREASURE_HUNTER
	jr nz, .piece_123
; piece 1, 2 ; no piece, 3
	CheckEvent EVENT_OBTAIN_MAP_PIECE_4_RESCUED_TRAVELER
	jr nz, .piece_no3_124
; piece 1, 2 ; no piece 3, 4
	ld a, MAP_PIECES_12
	jr .printMap
.piece_no3_124
	ld a, MAP_PIECES_124
	jr .printMap
.piece_123
	CheckEvent EVENT_OBTAIN_MAP_PIECE_4_RESCUED_TRAVELER
	jr nz, .piece_1234
; piece 1, 2, 3 ; no piece 4
	ld a, MAP_PIECES_123
	jr .printMap
.piece_1234
	ld a, MAP_PIECES_1234
.printMap
	ld [wcf91], a
	callfar DisplayMonFrontSpriteInBox
	call ItemUseReloadOverworldData
;	pop de
;	ld a, e
;	ld [wcf91], a
	ret

MapMessage::
	text_far _MapMessage
	text_end

MapMessageComplete::
	text_far _MapMessageComplete
	text_end

; new: code for MYSTERY_MAP, end ------------------------

ItemUseOnigiri: ; new
	ld a, [wIsInBattle]
	and a
	jp nz, ItemUseNotTime
; we are not in battle; ask if we want to eat the box of onigiri with our team
	ld hl, AskOnigiriBoxText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .yes
; not eat now
	ld hl, RefusedOnigiriBoxText
	call PrintText
	ret
.yes
	ld hl, UsedOnigiriBoxText
	call PrintText
	ld a, SFX_HEAL_AILMENT
	call PlaySound
	push hl
	call RemoveUsedItem
	pop hl
	predef_jump HealParty

UsedOnigiriBoxText: ; new
	text_far _UsedOnigiriBoxText
	text_end

AskOnigiriBoxText: ; new
	text_far _AskOnigiriBoxText
	text_end

RefusedOnigiriBoxText: ; new
	text_far _RefusedOnigiriBoxText
	text_end

ItemUseBall:

; Balls can't be used out of battle.
	ld a, [wIsInBattle]
	and a
	jp z, ItemUseNotTime

; Balls can't catch trainers' Pokémon.
	dec a
	jp nz, ThrowBallAtTrainerMon

; new, to handle MissingNo and Master Ball
	ld a, [wCurMap]
	cp HAUNTED_ISLAND_OF_NUMBERS
	jr nz, .notMissingnoWithMaster
	ld hl, wcf91 ; get item ID
	ld a, [hl]
	cp MASTER_BALL
	jp z, ThrowMasterBallAtMissingno
.notMissingnoWithMaster

; If this is for the old man battle, skip checking if the party & box are full.
	ld a, [wBattleType]
	cp BATTLE_TYPE_OLD_MAN
	jr z, .canUseBall
	cp BATTLE_TYPE_PIKACHU
	jr z, .canUseBall

	ld a, [wPartyCount] ; is party full?
	cp PARTY_LENGTH
	jr nz, .canUseBall
	ld a, [wBoxCount] ; is box full?
	cp MONS_PER_BOX
	jp z, BoxFullCannotThrowBall

.canUseBall
	xor a
	ld [wCapturedMonSpecies], a

	ld a, [wBattleType]
	cp BATTLE_TYPE_SAFARI
	jr nz, .skipSafariZoneCode

.safariZone
	ld hl, wNumSafariBalls
	dec [hl] ; remove a Safari Ball

.skipSafariZoneCode
	call RunDefaultPaletteCommand

	ld a, $43 ; successful capture value
	ld [wPokeBallAnimData], a

	call LoadScreenTilesFromBuffer1
	ld hl, ItemUseText00
	call PrintText

; If the player is fighting an unidentified ghost, set the value that indicates
; the Pokémon can't be caught and skip the capture calculations.
	callfar IsGhostBattle
	ld b, $10 ; can't be caught value
	jp z, .setAnimData

	ld a, [wBattleType]
	cp BATTLE_TYPE_OLD_MAN
	jr z, .oldManBattle
	cp BATTLE_TYPE_PIKACHU
	jr z, .oldManBattle ; pikachu battle technically old man battle
	jr .notOldManBattle

.oldManBattle
	ld hl, wGrassRate
	ld de, wPlayerName
	ld bc, NAME_LENGTH
	call CopyData ; save the player's name in the Wild Monster data (part of the Cinnabar Island Missingno. glitch)
	ld a, [wBattleType]
	cp BATTLE_TYPE_OLD_MAN
	jp nz, .captured
	ld a, $1
	ld [wCapturedMonSpecies], a
	CheckEvent EVENT_02F
	ld b, $63
	jp nz, .setAnimData
	jp .captured
.notOldManBattle
; If the player is fighting the ghost Marowak, set the value that indicates the
; Pokémon can't be caught and skip the capture calculations.
	ld a, [wCurMap]
	cp POKEMON_TOWER_6F
	jr nz, .preloop ; edited, it was .loop
	ld a, [wEnemyMonSpecies2]
	cp RESTLESS_SOUL
	ld b, $10 ; can't be caught value
	jp z, .setAnimData

; Get the first random number. Let it be called Rand1.
; Rand1 must be within a certain range according the kind of ball being thrown.
; The ranges are as follows.
; Poké Ball:    [0, 255]
; Great Ball:   [0, 200]
; Ultra Ball:   [0, 150] ; only ultra now
; Safari Ball:  [0, 100] ; new
; Fast Ball:    [0, 255/63] ; new, if mon's base speed <100 or >=100
; Heavy Ball:   [0, 255/255/175/125/63] ; new, depending on mon's weight tier (see later the 5 tiers)
; Loop until an acceptable number is found.

; new, store base speed of opp mon in c for FAST_BALL - TODO move it within FAST BALL check?
.preloop
	ld a, [wEnemyMonSpecies]
	ld [wd0b5], a
	call GetMonHeader
	ld a, [wMonHBaseSpeed]
	ld c, a

.loop
	call Random
	ld b, a

; Get the item ID.
	ld hl, wcf91
	ld a, [hl]

; The Master Ball always succeeds.
	cp MASTER_BALL
	jp z, .captured

; Checks for FAST_BALL
	cp FAST_BALL
	jr nz, .notFastBall
	ld a, 99 ; base speed above which the FAST_BALL works wonders
	cp c ; compare with opp base speed
	jr nc, .checkForAilments ; if there is no carry, a-c>=0, BS<=99, slow mon, works as a pokeball
	srl b ; halves the random number
	srl b ; quarters the random number - now Rand1 is in range [0,63]
;	ld a, 1 ; testing
;	cp b
;	jr c, .loop
	jr .checkForAilments
.notFastBall

; Checks for HEAVY_BALL
	cp HEAVY_BALL
	jr nz, .notHeavyBall
	push hl
	push bc
	farcall GetEnemyWeight
	; de contains the higher and lower byte of the weight at the end of the farcall
	; this is because they're the only registers not touched by farcalling
	ld a, e
	ld c, a ; c is not used for the speed, so now it has the lower byte of the weight
	ld a, d ; a now has the higher byte of the weight
	pop bc
	pop hl
	cp $10 ; check tier weight - $04, $08, $0C, $10
	jr nc, .weightTier4 ; weight>=409.6 kg
	cp $0C
	jr nc, .weightTier3 ; 307.2<=weight<409.6 kg
	cp $08
	jr nc, .weightTier2 ; 204.8<=weight<307.2 kg
	; next two lines are commented here because I can't make Rand1 upper limit bigger than 255, so weightTier0 and weightTier1 behave the same
;	cp $04
;	jr nc, .checkForAilments ; 102.4<=weight<204.8 kg
	jr .checkForAilments ; weight<102.4 kg
.weightTier2
	ld a, 175
	cp b
	jr c, .loop
	jr .checkForAilments
.weightTier3
	ld a, 125
	cp b
	jr c, .loop
	jr .checkForAilments
.weightTier4
	srl b
	srl b ; capped at 63, faster equivalent to do the whole ld a, 125 and loop if c
	jr .checkForAilments
.notHeavyBall

; Anything will do for the basic Poké Ball.
	cp POKE_BALL
	jr z, .checkForAilments

; If it's a Great/Ultra/Safari Ball and Rand1 is greater than 200, try again.
	ld a, 200
	cp b
	jr c, .loop

; Less than or equal to 200 is good enough for a Great Ball.
	ld a, [hl]
	cp GREAT_BALL
	jr z, .checkForAilments

; If it's an Ultra/Safari Ball and Rand1 is greater than 150, try again. - updated
	ld a, 150
	cp b
	jr c, .loop

; new - Less than or equal to 150 is good enough for an Ultra Ball.
	ld a, [hl]
	cp ULTRA_BALL
	jr z, .checkForAilments

; new - If it's a Safari Ball and Rand1 is greater than 100, try again.
	ld a, 100
	cp b
	jr c, .loop

; new - Less than or equal to 100 is good enough for a Safari Ball.
	ld a, [hl]
	cp SAFARI_BALL
	jr z, .checkForAilments


.checkForAilments
; Pokémon can be caught more easily with a status ailment.
; Depending on the status ailment, a certain value will be subtracted from
; Rand1. Let this value be called Status.
; The larger Status is, the more easily the Pokémon can be caught.
; no status ailment:     Status = 0
; Burn/Paralysis/Poison: Status = 12
; Freeze/Sleep:          Status = 25
; If Status is greater than Rand1, the Pokémon will be caught for sure.
	ld a, [wEnemyMonStatus]
	and a
	jr z, .skipAilmentValueSubtraction ; no ailments
	and (1 << FRZ) | SLP_MASK
	ld c, 12
	jr z, .notFrozenOrAsleep
	ld c, 25
.notFrozenOrAsleep
	ld a, b
	sub c
	jp c, .captured
	ld b, a

.skipAilmentValueSubtraction
	push bc ; save (Rand1 - Status)

; Calculate MaxHP * 255.
	xor a
	ldh [hMultiplicand], a
	ld hl, wEnemyMonMaxHP
	ld a, [hli]
	ldh [hMultiplicand + 1], a
	ld a, [hl]
	ldh [hMultiplicand + 2], a
	ld a, 255
	ldh [hMultiplier], a
	call Multiply

; Determine BallFactor. It's 8 for Great Balls, 10 for Safari Balls, and 12 for the others. - updated
; new: more detailed calculations for Fast and Heavy
	ld a, [wcf91]
	cp GREAT_BALL
	jr z, .GreatBallFactor
	cp SAFARI_BALL
	jr z, .SafariBallFactor
	cp FAST_BALL
	jr z, .FastBallFactor
	cp HEAVY_BALL
	jr z, .HeavyBallFactor
	; if none of the above, it's Poke or Ultra
	ld a, 12
	jr .continueAfterBallFactor

.GreatBallFactor
	ld a, 8
	jr .continueAfterBallFactor
.SafariBallFactor
	ld a, 10
	jr .continueAfterBallFactor
.FastBallFactor
	ld a, [wEnemyMonSpecies]	; unnecessary, already loaded earlier? Need to check with debugger if it gets rewritten
	ld [wd0b5], a				; unnecessary, already loaded earlier? Need to check with debugger if it gets rewritten
	call GetMonHeader			; unnecessary, already loaded earlier? Need to check with debugger if it gets rewritten
	ld a, [wMonHBaseSpeed]
	ld c, a
	ld a, 99 ; base speed above which the FAST_BALL works wonders
	cp c ; compare with opp base speed
	ld a, 12
	jr nc, .continueAfterBallFactor ; if there is no carry, a-c>=0, BS<=99, slow mon, works as a pokeball
	ld a, 10
	jr .continueAfterBallFactor
.HeavyBallFactor
	push hl
	push bc
	farcall GetEnemyWeight
	; de contains the higher and lower byte of the weight at the end of the farcall
	; this is because they're the only registers not touched by farcalling
	ld a, e
	ld c, a ; c is not used for the speed, so now it has the lower byte of the weight
	ld a, d ; a now has the higher byte of the weight
	pop bc
	pop hl
	cp $10 ; check tier weight - $04, $08, $0C, $10
	jr nc, .weightTier4Bis ; weight>=409.6 kg
	cp $0C
	jr nc, .weightTier3Bis ; 307.2<=weight<409.6 kg
	cp $08
	jr nc, .weightTier2Bis ; 204.8<=weight<307.2 kg
	cp $04
	jr nc, .weightTier1Bis ; 102.4<=weight<204.8 kg
;	jr .weightTier0Bis ; weight<102.4 kg
;.weightTier0Bis
	ld a, 16
	jr .continueAfterBallFactor
.weightTier1Bis
	ld a, 12
	jr .continueAfterBallFactor
.weightTier2Bis
	ld a, 10
	jr .continueAfterBallFactor
.weightTier3Bis
	ld a, 8
	jr .continueAfterBallFactor
.weightTier4Bis
	ld a, 6
	jr .continueAfterBallFactor

.continueAfterBallFactor
; Note that the results of all division operations are floored.

; Calculate (MaxHP * 255) / BallFactor.
	ldh [hDivisor], a
	ld b, 4 ; number of bytes in dividend
	call Divide

; Divide the enemy's current HP by 4. HP is not supposed to exceed 999 so
; the result should fit in a. If the division results in a quotient of 0,
; change it to 1.
	ld hl, wEnemyMonHP
	ld a, [hli]
	ld b, a
	ld a, [hl]
	srl b
	rr a
	srl b
	rr a
	and a
	jr nz, .skip2
	inc a

.skip2

; Let W = ((MaxHP * 255) / BallFactor) / max(HP / 4, 1). Calculate W.
	ldh [hDivisor], a
	ld b, 4
	call Divide

; If W > 255, store 255 in [hQuotient + 3].
; Let X = min(W, 255) = [hQuotient + 3].
	ldh a, [hQuotient + 2]
	and a
	jr z, .skip3
	ld a, 255
	ldh [hQuotient + 3], a

.skip3
	pop bc ; b = Rand1 - Status

; If Rand1 - Status > CatchRate, the ball fails to capture the Pokémon.
	ld a, [wEnemyMonActualCatchRate]
	cp b
	jr c, .failedToCapture

; If W > 255, the ball captures the Pokémon.
	ldh a, [hQuotient + 2]
	and a
	jr nz, .captured

	call Random ; Let this random number be called Rand2.

; If Rand2 > X, the ball fails to capture the Pokémon.
	ld b, a
	ldh a, [hQuotient + 3]
	cp b
	jr c, .failedToCapture

.captured
	jr .skipShakeCalculations

.failedToCapture
	ldh a, [hQuotient + 3]
	ld [wPokeBallCaptureCalcTemp], a ; Save X.

; Calculate CatchRate * 100.
	xor a
	ldh [hMultiplicand], a
	ldh [hMultiplicand + 1], a
	ld a, [wEnemyMonActualCatchRate]
	ldh [hMultiplicand + 2], a
	ld a, 100
	ldh [hMultiplier], a
	call Multiply

; Determine BallFactor2.
; Poké Ball:         BallFactor2 = 255
; Great Ball:        BallFactor2 = 200
; Ultra/Safari Ball: BallFactor2 = 150
	ld a, [wcf91]
	ld b, 255
	cp POKE_BALL
	jr z, .skip4
	ld b, 200
	cp GREAT_BALL
	jr z, .skip4
	ld b, 150
	cp ULTRA_BALL
	jr z, .skip4

.skip4

; Let Y = (CatchRate * 100) / BallFactor2. Calculate Y.
	ld a, b
	ldh [hDivisor], a
	ld b, 4
	call Divide

; If Y > 255, there are 3 shakes.
; Note that this shouldn't be possible.
; The maximum value of Y is (255 * 100) / 150 = 170.
	ldh a, [hQuotient + 2]
	and a
	ld b, $63 ; 3 shakes
	jr nz, .setAnimData

; Calculate X * Y.
	ld a, [wPokeBallCaptureCalcTemp]
	ldh [hMultiplier], a
	call Multiply

; Calculate (X * Y) / 255.
	ld a, 255
	ldh [hDivisor], a
	ld b, 4
	call Divide

; Determine Status2.
; no status ailment:     Status2 = 0
; Burn/Paralysis/Poison: Status2 = 5
; Freeze/Sleep:          Status2 = 10
	ld a, [wEnemyMonStatus]
	and a
	jr z, .skip5
	and (1 << FRZ) | SLP_MASK
	ld b, 5
	jr z, .addAilmentValue
	ld b, 10

.addAilmentValue
; If the Pokémon has a status ailment, add Status2.
	ldh a, [hQuotient + 3]
	add b
	ldh [hQuotient + 3], a

.skip5
; Finally determine the number of shakes.
; Let Z = ((X * Y) / 255) + Status2 = [hQuotient + 3].
; The number of shakes depend on the range Z is in.
; 0  ≤ Z < 10: 0 shakes (the ball misses)
; 10 ≤ Z < 30: 1 shake
; 30 ≤ Z < 70: 2 shakes
; 70 ≤ Z:      3 shakes
	ldh a, [hQuotient + 3]
	cp 10
	ld b, $20
	jr c, .setAnimData
	cp 30
	ld b, $61
	jr c, .setAnimData
	cp 70
	ld b, $62
	jr c, .setAnimData
	ld b, $63

.setAnimData
	ld a, b
	ld [wPokeBallAnimData], a

.skipShakeCalculations
	ld c, 20
	call DelayFrames

; Do the animation.
	ld a, TOSS_ANIM
	ld [wAltAnimationID], a ; edited
	xor a
	ldh [hWhoseTurn], a
	ld [wAnimationType], a
	ld [wDamageMultipliers], a
	ld a, [wWhichPokemon]
	push af
	ld a, [wcf91]
	push af
	predef MoveAnimation
	pop af
	ld [wcf91], a
	pop af
	ld [wWhichPokemon], a

; Determine the message to display from the animation.
	ld a, [wPokeBallAnimData]
	cp $10
	ld hl, ItemUseBallText00
	jp z, .printMessage
	cp $20
	ld hl, ItemUseBallText01
	jp z, .printMessage
	cp $61
	ld hl, ItemUseBallText02
	jp z, .printMessage
	cp $62
	ld hl, ItemUseBallText03
	jp z, .printMessage
	cp $63
	ld hl, ItemUseBallText04
	jp z, .printMessage

; Save current HP.
	ld hl, wEnemyMonHP
	ld a, [hli]
	push af
	ld a, [hli]
	push af

; Save status ailment.
	inc hl
	ld a, [hl]
	push af

	push hl

; If the Pokémon is transformed, the Pokémon is assumed to be a Ditto.
; This is a bug because a wild Pokémon could have used Transform via
; Mirror Move even though the only wild Pokémon that knows Transform is Ditto.
	ld hl, wEnemyBattleStatus3
	bit TRANSFORMED, [hl]
	jr z, .notTransformed
	ld a, DITTO
	ld [wEnemyMonSpecies2], a
	jr .skip6

.notTransformed
; If the Pokémon is not transformed, set the transformed bit and copy the
; DVs to wTransformedEnemyMonOriginalDVs so that LoadEnemyMonData won't generate
; new DVs.
	set TRANSFORMED, [hl]
	ld hl, wTransformedEnemyMonOriginalDVs
	ld a, [wEnemyMonDVs]
	ld [hli], a
	ld a, [wEnemyMonDVs + 1]
	ld [hl], a

.skip6
	ld a, [wcf91]
	push af
	ld a, [wEnemyMonSpecies2]
	ld [wcf91], a
	ld a, [wEnemyMonLevel]
	ld [wCurEnemyLVL], a
	callfar LoadEnemyMonData
	pop af
	ld [wcf91], a
	pop hl
	pop af
	ld [hld], a
	dec hl
	pop af
	ld [hld], a
	pop af
	ld [hl], a
	ld a, [wEnemyMonSpecies]
	ld [wCapturedMonSpecies], a
	ld [wcf91], a
	ld [wd11e], a
	ld a, [wBattleType]
	cp BATTLE_TYPE_OLD_MAN ; is this the old man battle?
	jp z, .oldManCaughtMon ; if so, don't give the player the caught Pokémon
	cp BATTLE_TYPE_PIKACHU
	jp z, .oldManCaughtMon ; same with Pikachu battle
	ld hl, ItemUseBallText05
	call PrintText

; Add the caught Pokémon to the Pokédex.
	predef IndexToPokedex
	ld a, [wd11e]
	dec a
	ld c, a
	ld b, FLAG_TEST
	ld hl, wPokedexOwned
	predef FlagActionPredef
	ld a, c
	push af
	ld a, [wd11e]
	dec a
	ld c, a
	ld b, FLAG_SET
	predef FlagActionPredef
	pop af

	and a ; was the Pokémon already in the Pokédex?
	jr nz, .skipShowingPokedexData ; if so, don't show the Pokédex data

	ld hl, ItemUseBallText06
	call PrintText
	call ClearSprites
	ld a, [wEnemyMonSpecies]
	ld [wd11e], a
	predef ShowPokedexData

.skipShowingPokedexData
	ld a, $1
	ld [wd49c], a
	ld a, $85
	ld [wPikachuMood], a
	ld a, [wPartyCount]
	cp PARTY_LENGTH ; is party full?
	jr z, .sendToBox
	xor a ; PLAYER_PARTY_DATA
	ld [wMonDataLocation], a
	call ClearSprites
	ld hl, .emptyString
	call PrintText
	call AddPartyMon
	jr .done

.sendToBox
	call ClearSprites
	call SendNewMonToBox
	ld hl, ItemUseBallText07
	CheckEvent EVENT_MET_BILL
	jr nz, .printTransferredToPCText
	ld hl, ItemUseBallText08
.printTransferredToPCText
	call PrintText
; new, print a warning message if the box is now full
	ld a, [wBoxCount]
	cp MONS_PER_BOX
	jr nz, .vanilla
	ld hl, TheBoxIsNowFull
	call PrintText
.vanilla
; back to vanilla
	jr .done

.oldManCaughtMon
	ld hl, ItemUseBallText05

.printMessage
	call PrintText
	call ClearSprites

.done
	ld a, [wBattleType]
	and a ; is this the old man battle?
	ret nz ; if so, don't remove a ball from the bag

; Remove a ball from the bag.
	ld hl, wNumBagItems
	inc a
	ld [wItemQuantity], a
	jp RemoveItemFromInventory

.emptyString
	db "@"

ItemUseBallText00:
;"It dodged the thrown ball!"
;"This pokemon can't be caught"
	text_far _ItemUseBallText00
	text_end
ItemUseBallText01:
;"You missed the pokemon!"
	text_far _ItemUseBallText01
	text_end
ItemUseBallText02:
;"Darn! The pokemon broke free!"
	text_far _ItemUseBallText02
	text_end
ItemUseBallText03:
;"Aww! It appeared to be caught!"
	text_far _ItemUseBallText03
	text_end
ItemUseBallText04:
;"Shoot! It was so close too!"
	text_far _ItemUseBallText04
	text_end
ItemUseBallText05:
;"All right! {MonName} was caught!"
;play sound
	text_far _ItemUseBallText05
	sound_caught_mon
	text_promptbutton
	text_end
ItemUseBallText07:
;"X was transferred to Bill's PC"
	text_far _ItemUseBallText07
	text_end
ItemUseBallText08:
;"X was transferred to ???'s PC" ; edited
	text_far _ItemUseBallText08
	text_end

TheBoxIsNowFull: ; new
	text_far _TheBoxIsNowFull
	text_end

ItemUseBallText06:
;"New DEX data will be added..."
;play sound
	text_far _ItemUseBallText06
	sound_dex_page_added
	text_promptbutton
	text_end

ItemUseTownMap:
	ld a, [wIsInBattle]
	and a
	jp nz, ItemUseNotTime
	farjp DisplayTownMap

ItemUseBicycle:
	ld a, [wIsInBattle]
	and a
	jp nz, ItemUseNotTime
	ld a, [wWalkBikeSurfState]
	ld [wWalkBikeSurfStateCopy], a
	cp 2 ; is the player surfing?
	jp z, ItemUseNotTime
	dec a ; is player already bicycling?
	jr nz, .tryToGetOnBike
.getOffBike
	call ItemUseReloadOverworldData
	xor a
	ld [wWalkBikeSurfState], a ; change player state to walking
	ld a, $00
	ld [wPikachuSpawnState], a
	call PlayDefaultMusic ; play walking music
	ld hl, GotOffBicycleText
	jp PrintText

.tryToGetOnBike
	call IsBikeRidingAllowed
	jp nc, NoCyclingAllowedHere
	call ItemUseReloadOverworldData
	xor a ; no keys pressed
	ldh [hJoyHeld], a ; current joypad state
	ld a, $1
	ld [wWalkBikeSurfState], a ; change player state to bicycling
	call PlayDefaultMusic ; play bike riding music
	xor a
	ld [wWalkBikeSurfState], a
	ld hl, GotOnBicycleText
	call PrintText
	ld a, $1
	ld [wWalkBikeSurfState], a
	ret

; used for Surf out-of-battle effect
ItemUseSurfboard:
	ld a, [wWalkBikeSurfState]
	ld [wWalkBikeSurfStateCopy], a
	cp 2 ; is the player already surfing?
	jr z, .tryToStopSurfing
.tryToSurf
	call IsNextTileShoreOrWater
	jp nc, SurfingAttemptFailed
	ld hl, TilePairCollisionsWater
	call CheckForTilePairCollisions
	jp c, SurfingAttemptFailed
.surf
	call .makePlayerMoveForward
	ld hl, wd730
	set 7, [hl]
	ld a, 2
	ld [wWalkBikeSurfState], a ; change player state to surfing
	call PlayDefaultMusic ; play surfing music
	ld hl, SurfingGotOnText
	jp PrintText

.tryToStopSurfing
	xor a
	ldh [hSpriteIndexOrTextID], a
	ld d, 16 ; talking range in pixels (normal range)
	call IsSpriteInFrontOfPlayer2
	res 7, [hl]
	ldh a, [hSpriteIndexOrTextID]
	and a ; is there a sprite in the way?
	jr nz, .cannotStopSurfing
	ld hl, TilePairCollisionsWater
	call CheckForTilePairCollisions
	jr c, .cannotStopSurfing
	ld a, [wTileInFrontOfPlayer]
	ld c, a
	call IsTilePassable
	jr nc, .stopSurfing
.cannotStopSurfing
	ld hl, SurfingNoPlaceToGetOffText
	jp PrintText

.stopSurfing
	call .makePlayerMoveForward
	ld a, $3
	ld [wPikachuSpawnState], a
	ld hl, wPikachuOverworldStateFlags
	set 5, [hl]
	ld hl, wd730
	set 7, [hl]
	xor a
	ld [wWalkBikeSurfState], a ; change player state to walking
	dec a
	ld [wJoyIgnore], a
	call PlayDefaultMusic ; play walking music
	call GBPalWhiteOutWithDelay3
	jp LoadWalkingPlayerSpriteGraphics

; uses a simulated button press to make the player move forward
.makePlayerMoveForward
	ld a, [wPlayerDirection] ; direction the player is going
	bit PLAYER_DIR_BIT_UP, a
	ld b, D_UP
	jr nz, .storeSimulatedButtonPress
	bit PLAYER_DIR_BIT_DOWN, a
	ld b, D_DOWN
	jr nz, .storeSimulatedButtonPress
	bit PLAYER_DIR_BIT_LEFT, a
	ld b, D_LEFT
	jr nz, .storeSimulatedButtonPress
	ld b, D_RIGHT
.storeSimulatedButtonPress
	ld a, b
	ld [wSimulatedJoypadStatesEnd], a
	xor a
	ld [wWastedByteCD39], a
	inc a
	ld [wSimulatedJoypadStatesIndex], a
	ret

SurfingGotOnText:
	text_far _SurfingGotOnText
	text_end

SurfingNoPlaceToGetOffText:
	text_far _SurfingNoPlaceToGetOffText
	text_end

ItemUsePokedex:
	predef_jump ShowPokedexMenu

ItemUseEvoStone:
	ld a, [wIsInBattle]
	and a
	jp nz, ItemUseNotTime
	ld a, [wWhichPokemon]
	push af
	ld a, [wcf91]
	ld [wEvoStoneItemID], a
	push af
	ld a, EVO_STONE_PARTY_MENU
	ld [wPartyMenuTypeOrMessageID], a
	ld a, $ff
	ld [wUpdateSpritesEnabled], a
	call DisplayPartyMenu
	ld a, [wcf91]
	ld [wLoadedMon], a
	pop bc
	jr c, .canceledItemUse
	ld a, b
	ld [wcf91], a
	call Func_d85d
	jr nc, .noEffect
	callfar IsThisPartymonStarterPikachu_Party
	jr nc, .notPlayerPikachu
	ld e, $1b
	callfar PlayPikachuSoundClip
	ld a, [wWhichPokemon]
	ld hl, wPartyMonNicks
	call GetPartyMonName
	ld hl, RefusingText
	call PrintText
	ld a, $4
	ld [wd49c], a
	ld a, $82
	ld [wPikachuMood], a
	jr .canceledItemUse

.notPlayerPikachu
	ld a, SFX_HEAL_AILMENT
	call PlaySoundWaitForCurrent
	call WaitForSoundToFinish
	ld a, $01
	ld [wForceEvolution], a
	callfar TryEvolvingMon ; try to evolve pokemon
	pop af
	ld [wWhichPokemon], a
	ld hl, wNumBagItems
	ld a, 1 ; remove 1 stone
	ld [wItemQuantity], a
	jp RemoveItemFromInventory

.noEffect
	call ItemUseNoEffect
.canceledItemUse
	xor a
	ld [wActionResultOrTookBattleTurn], a ; item not used
	pop af
	call ReloadMapData ; needed to expand tileset?
	ret

Func_d85d: ; from suloku
	ld hl, EvosMovesPointerTable
	ld b, 0
	ld a, [wLoadedMonSpecies]
	dec a
	add a
	rl b
	ld c, a
	add hl, bc
	ld de, wEvosMoves
	ld a, BANK(EvosMovesPointerTable)
	ld bc, 2
	call FarCopyData ;wEvosMoves has the address to evomoves list
	ld hl, wEvosMoves
	ld a, [hli]
	ld h, [hl]
	ld l, a ;at this point hl has the address for this pokémon's evomoves list
.nextEvoEntry
	push hl ;stack start address for evolution moves (this will be later updated with the next entry)
	ld de, wEvosMoves
	ld a, BANK(EvosMovesPointerTable)
	ld bc, EVOLUTION_SIZE ;4 bytes, as currently the biggest entry for an evolution is 4 bytes
	call FarCopyData ;wEvosMoves now has a copy of first evo entry (4 bytes, to handle terminator, 3 byte evo methods (level, trade) and 4 byte evo methods (item)
	ld hl, wEvosMoves
.checkEvolutionsLoop ; loop through the pokemon's evolution entries
	ld a, [hli]
	and a ; reached terminator?
	jr nz, .noTerminator
	pop hl
	jr z, .cannotEvolveWithUsedStone
.noTerminator
	cp EV_ITEM
	jp z, .compareItem ; is it an item evolution?
.handleEvoMethods
	pop hl;load address of current evo entry to hl, as we are going to update it
		  ; here is were subsecuent cp $4, cp $5, cp $6 etc should go and adding further jumps and increases of hl if an evolution method that has 5 bytes or more are added
	jr c, .next3byteEvo ; in case new evolution methods that use 4 byte are defined, the previous cp EV_ITEM should have set the carry flag as Evolution types in pokemon_data_constants.asm are re-arranged so first we have evo methods that use 3 bytes, then ones that use 4 bytes, EV_ITEM being the first, so any evo method with index < EV_ITEMS is handled as having 3 bytes, and the others as 4 bytes (if there were more than EV_ITEM)
.next4byteEvo
	inc hl ; remember, hl has current evo entry, so if this is as 4 evo entry we need to increase the address by 4
.next3byteEvo ; only increase 3 times for 3 byte evolutions
	inc hl
	inc hl
	inc hl ;hl now holds the address to the next evo entry
	jr .nextEvoEntry ;we have the address, load next entry to wEvosMoves
.compareItem
	ld b, [hl]
	ld a, [wEvoStoneItemID] ; the stone the player used
	cp b ; does the player's stone match this evolution entry's stone?
	pop hl; not the corret stone, load address of current evo entry to hl and increase it before loading next entry
	jr nz, .next4byteEvo
	scf
	ret
.cannotEvolveWithUsedStone
	and a
	ret

RefusingText:
	text_far _RefusingText
	text_end

ItemUseVitamin:
	ld a, [wIsInBattle]
	and a
	jp nz, ItemUseNotTime

ItemUseMedicine:
	ld a, [wPartyCount]
	and a
	jp z, Func_e4bf
	ld a, [wWhichPokemon]
	push af
	ld a, [wcf91]
	push af
	ld a, USE_ITEM_PARTY_MENU
	ld [wPartyMenuTypeOrMessageID], a
	ld a, $ff
	ld [wUpdateSpritesEnabled], a
	ld a, [wPseudoItemID]
	and a ; using Softboiled?
	jr z, .notUsingSoftboiled
; if using softboiled
	call GoBackToPartyMenu
	jr .getPartyMonDataAddress
.notUsingSoftboiled
	call DisplayPartyMenu
.getPartyMonDataAddress
	jp c, .canceledItemUse
	ld hl, wPartyMons
	ld bc, wPartyMon2 - wPartyMon1
	ld a, [wWhichPokemon]
	call AddNTimes
	ld a, [wWhichPokemon]
	ld [wUsedItemOnWhichPokemon], a
	ld d, a
	ld a, [wcf91]
	ld e, a
	ld [wd0b5], a
	pop af
	push af
	cp CALCIUM + 1
	jr nc, .noHappinessBoost
	push hl
	push de
	callabd_ModifyPikachuHappiness PIKAHAPPY_USEDITEM
	pop de
	pop hl
.noHappinessBoost
	pop af
	ld [wcf91], a
	pop af
	ld [wWhichPokemon], a
	ld a, [wPseudoItemID]
	and a ; using Softboiled?
	jr z, .checkItemType
; if using softboiled
	ld a, [wWhichPokemon]
	cp d ; is the pokemon trying to use softboiled on itself?
	jr z, ItemUseMedicine ; if so, force another choice
.checkItemType
	ld a, [wcf91]

	; new, custom ugly code cause i don't feel like reordering items
	cp LEGEND_CANDY
	jp z, .useVitamin
	cp CHEAT_CANDY
	jp z, .useVitamin
	cp PERFECTER
	jp z, .useVitamin
	cp CHROMOGENE
	jp z, .useVitamin

	cp REVIVE
	jr nc, .healHP ; if it's a Revive or Max Revive
	cp FULL_HEAL
	jr z, .cureStatusAilment ; if it's a Full Heal
	cp HP_UP
	jp nc, .useVitamin ; if it's a vitamin or Rare Candy
	cp FULL_RESTORE
	jr nc, .healHP ; if it's a Full Restore or one of the potions
; fall through if it's one of the status-specific healing items
.cureStatusAilment
	ld bc, wPartyMon1Status - wPartyMon1
	add hl, bc ; hl now points to status
	ld a, [wcf91]
	lb bc, ANTIDOTE_MSG, 1 << PSN
	cp ANTIDOTE
	jr z, .checkMonStatus
	lb bc, BURN_HEAL_MSG, 1 << BRN
	cp BURN_HEAL
	jr z, .checkMonStatus
	lb bc, ICE_HEAL_MSG, 1 << FRZ
	cp ICE_HEAL
	jr z, .checkMonStatus
	lb bc, AWAKENING_MSG, SLP_MASK
	cp AWAKENING
	jr z, .checkMonStatus
	lb bc, PARALYZ_HEAL_MSG, 1 << PAR
	cp PARLYZ_HEAL
	jr z, .checkMonStatus
	lb bc, FULL_HEAL_MSG, $ff ; Full Heal
.checkMonStatus
	ld a, [hl] ; pokemon's status
	and c ; does the pokemon have a status ailment the item can cure?
	jp z, .healingItemNoEffect
; if the pokemon has a status the item can heal
	xor a
	ld [hl], a ; remove the status ailment in the party data
	ld a, b
	ld [wPartyMenuTypeOrMessageID], a ; the message to display for the item used
	ld a, [wPlayerMonNumber]
	cp d ; is pokemon the item was used on active in battle?
	jp nz, .doneHealing
; if it is active in battle
	xor a
	ld [wBattleMonStatus], a ; remove the status ailment in the in-battle pokemon data
	push hl
	ld hl, wPlayerBattleStatus3
	res BADLY_POISONED, [hl] ; heal Toxic status
	pop hl
	ld bc, wPartyMon1Stats - wPartyMon1Status
	add hl, bc ; hl now points to party stats
	ld de, wBattleMonStats
	ld bc, NUM_STATS * 2
	call CopyData ; copy party stats to in-battle stat data
	predef DoubleOrHalveSelectedStats
	jp .doneHealing

.healHP
	inc hl ; hl = address of current HP
	ld a, [hli]
	ld b, a
	ld [wHPBarOldHP+1], a
	ld a, [hl]
	ld c, a
	ld [wHPBarOldHP], a ; current HP stored at wHPBarOldHP (2 bytes, big-endian)
	or b
	jr nz, .notFainted
.fainted
	ld a, [wcf91]
	cp REVIVE
	jr z, .updateInBattleFaintedData
	cp MAX_REVIVE
	jr z, .updateInBattleFaintedData
	jp .healingItemNoEffect

.updateInBattleFaintedData
	ld a, [wWhichPokemon]
	push af
	ld a, [wUsedItemOnWhichPokemon]
	ld [wWhichPokemon], a
	push hl
	push de
	push bc
	callfar RespawnOverworldPikachu
	pop bc
	pop de
	pop hl
	pop af
	ld [wWhichPokemon], a

	ld a, [wIsInBattle]
	and a
	jr z, .compareCurrentHPToMaxHP
	push hl
	push de
	push bc
	ld a, [wUsedItemOnWhichPokemon]
	ld c, a
	ld hl, wPartyFoughtCurrentEnemyFlags
	ld b, FLAG_TEST
	predef FlagActionPredef
	ld a, c
	and a
	jr z, .next
	ld a, [wUsedItemOnWhichPokemon]
	ld c, a
	ld hl, wPartyGainExpFlags
	ld b, FLAG_SET
	predef FlagActionPredef
.next
	pop bc
	pop de
	pop hl
	jr .compareCurrentHPToMaxHP

.notFainted
	ld a, [wcf91]
	cp REVIVE
	jp z, .healingItemNoEffect
	cp MAX_REVIVE
	jp z, .healingItemNoEffect
.compareCurrentHPToMaxHP
	push hl
	push bc
	ld bc, wPartyMon1MaxHP - (wPartyMon1HP + 1)
	add hl, bc ; hl now points to max HP
	pop bc
	ld a, [hli]
	cp b
	jr nz, .skipComparingLSB ; no need to compare the LSB's if the MSB's don't match
	ld a, [hl]
	cp c
.skipComparingLSB
	pop hl
	jr nz, .notFullHP
.fullHP ; if the pokemon's current HP equals its max HP
	ld a, [wcf91]
	cp FULL_RESTORE
	jp nz, .healingItemNoEffect
	inc hl
	inc hl
	ld a, [hld] ; status ailment
	and a ; does the pokemon have a status ailment?
	jp z, .healingItemNoEffect
	ld a, FULL_HEAL
	ld [wcf91], a
	dec hl
	dec hl
	dec hl
	jp .cureStatusAilment

.notFullHP ; if the pokemon's current HP doesn't equal its max HP
	xor a
	ld [wLowHealthAlarm], a ;disable low health alarm
	ld [wChannelSoundIDs + CHAN5], a
	push hl
	push de
	ld bc, wPartyMon1MaxHP - (wPartyMon1HP + 1)
	add hl, bc ; hl now points to max HP
	ld a, [hli]
	ld [wHPBarMaxHP+1], a
	ld a, [hl]
	ld [wHPBarMaxHP], a ; max HP stored at wHPBarMaxHP (2 bytes, big-endian)
	ld a, [wPseudoItemID]
	and a ; using Softboiled?
	jp z, .notUsingSoftboiled2
; if using softboiled
	ld hl, wHPBarMaxHP
	ld a, [hli]
	push af
	ld a, [hli]
	push af
	ld a, [hli]
	push af
	ld a, [hl]
	push af
	ld hl, wPartyMon1MaxHP
	ld a, [wWhichPokemon]
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	ld a, [hli]
	ld [wHPBarMaxHP + 1], a
	ldh [hDividend], a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	ldh [hDividend + 1], a
	ld a, 5
	ldh [hDivisor], a
	ld b, 2 ; number of bytes
	call Divide ; get 1/5 of max HP of pokemon that used Softboiled
	ld bc, (wPartyMon1HP + 1) - (wPartyMon1MaxHP + 1)
	add hl, bc ; hl now points to LSB of current HP of pokemon that used Softboiled
; subtract 1/5 of max HP from current HP of pokemon that used Softboiled
	ldh a, [hQuotient + 3]
	push af
	ld b, a
	ld a, [hl]
	ld [wHPBarOldHP], a
	sub b
	ld [hld], a
	ld [wHPBarNewHP], a
	ldh a, [hQuotient + 2]
	ld b, a
	ld a, [hl]
	ld [wHPBarOldHP+1], a
	sbc b
	ld [hl], a
	ld [wHPBarNewHP+1], a
	hlcoord 4, 1
	ld a, [wWhichPokemon]
	ld bc, 2 * SCREEN_WIDTH
	call AddNTimes ; calculate coordinates of HP bar of pokemon that used Softboiled
	ld a, SFX_HEAL_HP
	call PlaySoundWaitForCurrent
	ldh a, [hUILayoutFlags]
	set 0, a
	ldh [hUILayoutFlags], a
	ld a, $02
	ld [wHPBarType], a
	predef UpdateHPBar2 ; animate HP bar decrease of pokemon that used Softboiled
	ldh a, [hUILayoutFlags]
	res 0, a
	ldh [hUILayoutFlags], a
	pop af
	ld b, a ; store heal amount (1/5 of max HP)
	ld hl, wHPBarOldHP + 1
	pop af
	ld [hld], a
	pop af
	ld [hld], a
	pop af
	ld [hld], a
	pop af
	ld [hl], a
	jr .addHealAmount

.notUsingSoftboiled2
	ld a, [wcf91]
	cp SODA_POP
	ld b, 60 ; Soda Pop heal amount
	jr z, .addHealAmount
	ld b, 80 ; Lemonade heal amount
	jr nc, .addHealAmount
	cp FRESH_WATER
	ld b, 50 ; Fresh Water heal amount
	jr z, .addHealAmount
	cp SUPER_POTION
	ld b, 200 ; Hyper Potion heal amount
	jr c, .addHealAmount
	ld b, 50 ; Super Potion heal amount
	jr z, .addHealAmount
	ld b, 20 ; Potion heal amount
.addHealAmount
	pop de
	pop hl
	ld a, [hl]
	add b
	ld [hld], a
	ld [wHPBarNewHP], a
	ld a, [hl]
	ld [wHPBarNewHP+1], a
	jr nc, .noCarry
	inc [hl]
	ld a, [hl]
	ld [wHPBarNewHP + 1], a
.noCarry
	push de
	inc hl
	ld d, h
	ld e, l ; de now points to current HP
	ld hl, (wPartyMon1MaxHP + 1) - (wPartyMon1HP + 1)
	add hl, de ; hl now points to max HP
	ld a, [wcf91]
	cp REVIVE
	jr z, .setCurrentHPToHalfMaxHP
	ld a, [hld]
	ld b, a
	ld a, [de]
	sub b
	dec de
	ld b, [hl]
	ld a, [de]
	sbc b
	jr nc, .setCurrentHPToMaxHp ; if current HP exceeds max HP after healing
	ld a, [wcf91]
	cp HYPER_POTION
	jr c, .setCurrentHPToMaxHp ; if using a Full Restore or Max Potion
	cp MAX_REVIVE
	jr z, .setCurrentHPToMaxHp ; if using a Max Revive
	jr .updateInBattleData

.setCurrentHPToHalfMaxHP
	dec hl
	dec de
	ld a, [hli]
	srl a
	ld [de], a
	ld [wHPBarNewHP+1], a
	ld a, [hl]
	rr a
	inc de
	ld [de], a
	ld [wHPBarNewHP], a
	dec de
	jr .doneHealingPartyHP

.setCurrentHPToMaxHp
	ld a, [hli]
	ld [de], a
	ld [wHPBarNewHP+1], a
	inc de
	ld a, [hl]
	ld [de], a
	ld [wHPBarNewHP], a
	dec de
.doneHealingPartyHP ; done updating the pokemon's current HP in the party data structure
	ld a, [wcf91]
	cp FULL_RESTORE
	jr nz, .updateInBattleData
	ld bc, wPartyMon1Status - (wPartyMon1MaxHP + 1)
	add hl, bc
	xor a
	ld [hl], a ; remove the status ailment in the party data
.updateInBattleData
	ld h, d
	ld l, e
	pop de
	ld a, [wPlayerMonNumber]
	cp d ; is pokemon the item was used on active in battle?
	jr nz, .calculateHPBarCoords
; copy party HP to in-battle HP
	ld a, [hli]
	ld [wBattleMonHP], a
	ld a, [hld]
	ld [wBattleMonHP + 1], a
	ld a, [wcf91]
	cp FULL_RESTORE
	jr nz, .calculateHPBarCoords
	xor a
	ld [wBattleMonStatus], a ; remove the status ailment in the in-battle pokemon data
.calculateHPBarCoords
	ld hl, wShadowOAMSprite36
	ld bc, 2 * SCREEN_WIDTH
	inc d
.calculateHPBarCoordsLoop
	add hl, bc
	dec d
	jr nz, .calculateHPBarCoordsLoop
	jr .doneHealing

.healingItemNoEffect
	call ItemUseNoEffect
	jp .done

.doneHealing
	ld a, [wPseudoItemID]
	and a ; using Softboiled?
	jr nz, .skipRemovingItem ; no item to remove if using Softboiled
	push hl
	call RemoveUsedItem
	pop hl
.skipRemovingItem
	ld a, [wcf91]
	cp FULL_RESTORE
	jr c, .playStatusAilmentCuringSound
	cp FULL_HEAL
	jr z, .playStatusAilmentCuringSound
	ld a, SFX_HEAL_HP
	call PlaySoundWaitForCurrent
	ldh a, [hUILayoutFlags]
	set 0, a
	ldh [hUILayoutFlags], a
	ld a, $02
	ld [wHPBarType], a
	predef UpdateHPBar2 ; animate the HP bar lengthening
	ldh a, [hUILayoutFlags]
	res 0, a
	ldh [hUILayoutFlags], a
	ld a, REVIVE_MSG
	ld [wPartyMenuTypeOrMessageID], a
	ld a, [wcf91]
	cp REVIVE
	jr z, .showHealingItemMessage
	cp MAX_REVIVE
	jr z, .showHealingItemMessage
	ld a, POTION_MSG
	ld [wPartyMenuTypeOrMessageID], a
	jr .showHealingItemMessage

.playStatusAilmentCuringSound
	ld a, SFX_HEAL_AILMENT
	call PlaySoundWaitForCurrent
.showHealingItemMessage
	xor a
	ldh [hAutoBGTransferEnabled], a
	call ClearScreen
	dec a
	ld [wUpdateSpritesEnabled], a
	call RedrawPartyMenu ; redraws the party menu and displays the message
	ld a, 1
	ldh [hAutoBGTransferEnabled], a
	ld c, 50
	call DelayFrames
	call WaitForTextScrollButtonPress
	jr .done

.canceledItemUse
	xor a
	ld [wActionResultOrTookBattleTurn], a ; item use failed
	pop af
	pop af
.done
	ld a, [wPseudoItemID]
	and a ; using Softboiled?
	ret nz ; if so, return
	call GBPalWhiteOut
	call z, RunDefaultPaletteCommand
	ld a, [wIsInBattle]
	and a
	ret nz
	jp ReloadMapData

.useVitamin
	push hl
	ld a, [hl]
	ld [wd0b5], a
	ld [wd11e], a
	ld bc, wPartyMon1Level - wPartyMon1
	add hl, bc ; hl now points to level
	ld a, [hl] ; a = level
	ld [wCurEnemyLVL], a ; store level
	call GetMonHeader
	push de
	ld a, d
	ld hl, wPartyMonNicks
	call GetPartyMonName
	pop de
	pop hl
	ld a, [wcf91]
	cp RARE_CANDY
	jp z, .useRareCandy
	cp LEGEND_CANDY     ; new
	jp z, .useRareCandy ; new
	cp CHEAT_CANDY      ; new
	jp z, .useRareCandy ; new
	push hl

; PERFECTER code, beginning ----------------------------------------------------

	cp PERFECTER
	jr nz, .notPerfecterCode

; check if everything has already been maxed out
	push hl
	ld bc, wPartyMon1HPExp - wPartyMon1
	add hl, bc ; hl now points to stat experience
	ld a, $FF
	cp [hl]	; load max hp exp
	jr nz, .canBeUsed
	inc hl
	cp [hl]
	jr nz, .canBeUsed
	inc hl
	cp [hl]	; load max attack exp
	jr nz, .canBeUsed
	inc hl
	cp [hl]
	jr nz, .canBeUsed
	inc hl
	cp [hl]	; load max defense exp
	jr nz, .canBeUsed
	inc hl
	cp [hl]
	jr nz, .canBeUsed
	inc hl
	cp [hl]	; load max speed exp
	jr nz, .canBeUsed
	inc hl
	cp [hl]
	jr nz, .canBeUsed
	inc hl
	cp [hl]	; load max special exp
	jr nz, .canBeUsed
	inc hl
	cp [hl]
	jr nz, .canBeUsed
	pop hl

	push hl
	ld bc, wPartyMon1DVs - wPartyMon1
	add hl, bc ; hl now points to DVs
	ld a, $FF
	cp [hl] ; is the first byte of their DVs maxed?
	jr nz, .canBeUsed
	inc hl
	cp [hl] ; is the second byte of their DVs maxed?
	jr nz, .canBeUsed
	pop hl ; ???
	jp ItemUseMedicine.vitaminNoEffect

.canBeUsed
	pop hl ; by trials and errors :')

	pop hl ; by trials and errors :')

; max out STATS exp
	push hl
	ld bc, wPartyMon1HPExp - wPartyMon1
	add hl, bc ; hl now points to stat experience
	ld a, $FF
	ld [hli], a	; load max hp exp
	ld [hli], a
	ld [hli], a	; load max attack exp
	ld [hli], a
	ld [hli], a	; load max defense exp
	ld [hli], a
	ld [hli], a	; load max speed exp
	ld [hli], a
	ld [hli], a	; load max special exp
	ld [hli], a
	pop hl

; max out DVs
	push hl
	ld bc, wPartyMon1DVs - wPartyMon1
	add hl, bc ; hl now points to DVs
	ld a, $FF
	cp [hl] ; is the first byte of their DVs maxed?
	ld [hli], a ; set first byte of DVs to max
	ld [hl], a  ; set second byte of DVs to max
	pop hl

.endOfPerfecter
	call .recalculateStats

	ld a, SFX_HEAL_AILMENT
	call PlaySound
	ld hl, PerfecterHasBeenUsedText
	call PrintText
.perfTest
	jp RemoveUsedItem

.notPerfecterCode
	ld a, [wcf91] ; new, to ensure a contains the right stuff

; PERFECTER code, end ----------------------------------------------------------

; CHROMOGENE code, beginning ---------------------------------------------------

	cp CHROMOGENE
	jr nz, .notChromogeneCode
; it's actually the Chromogene
;	push hl
	ld bc, wPartyMon1CatchRate - wPartyMon1
	add hl, bc ; hl now points to catch rate, aka shiny-ness
	ld a, [hl]
	and a
	jr z, .notShiny
; the mon is shiny, we de-shiny-fy it
	xor a
	ld [hl], a
	jr .concludeChromogene
.notShiny
	ld a, 1
	ld [hl], a
.concludeChromogene
	pop hl ; trying
	ld a, SFX_HEAL_AILMENT
	call PlaySound
	ld hl, ChromogeneHasBeenUsedText
	call PrintText
.chromoTest
	jp RemoveUsedItem
.notChromogeneCode
	ld a, [wcf91] ; to ensure a contains the right stuff

; CHROMOGENE code, end ---------------------------------------------------------

	sub HP_UP
	add a
	ld bc, wPartyMon1HPExp - wPartyMon1
	add hl, bc
	add l
	ld l, a
	jr nc, .noCarry2
	inc h
.noCarry2
	ld a, 10
	ld b, a
	ld a, [hl] ; a = MSB of stat experience of the appropriate stat
	cp 100 ; is there already at least 25600 (256 * 100) stat experience?
	jr nc, .vitaminNoEffect ; if so, vitamins can't add any more
	add b ; add 2560 (256 * 10) stat experience
	jr nc, .noCarry3 ; a carry should be impossible here, so this will always jump
	ld a, 255
.noCarry3
	ld [hl], a
	pop hl
	call .recalculateStats
	ld hl, VitaminStats
	ld a, [wcf91]
	sub HP_UP - 1
	ld c, a
.statNameLoop ; loop to get the address of the name of the stat the vitamin increases
	dec c
	jr z, .gotStatName
.statNameInnerLoop
	ld a, [hli]
	ld b, a
	ld a, $50
	cp b
	jr nz, .statNameInnerLoop
	jr .statNameLoop

.gotStatName
	ld de, wStringBuffer
	ld bc, 10
	call CopyData ; copy the stat's name to wStringBuffer
	ld a, SFX_HEAL_AILMENT
	call PlaySound
	ld hl, VitaminStatRoseText
	call PrintText
	jp RemoveUsedItem

.vitaminNoEffect
	pop hl
	ld hl, VitaminNoEffectText
	call PrintText
	call ReloadMapData ; needed to expand tileset?
	jp GBPalWhiteOut

.recalculateStats
	ld bc, wPartyMon1Stats - wPartyMon1
	add hl, bc
	ld d, h
	ld e, l ; de now points to stats
	ld bc, (wPartyMon1Exp + 2) - wPartyMon1Stats
	add hl, bc ; hl now points to LSB of experience
	ld b, 1
	jp CalcStats ; recalculate stats
.useRareCandy
	push hl
	ld bc, wPartyMon1Level - wPartyMon1
	add hl, bc ; hl now points to level
	ld a, [hl] ; a = level
	cp MAX_LEVEL
	jr z, .vitaminNoEffect ; can't raise level above 100
	cp MAX_LEVEL_2 ; new
	jr z, .vitaminNoEffect ; new

	; new code for LEGEND_CANDY
	ld a, [wcf91] ; a contains the item ID, and if we are here, should be only a RARE or a LEGEND or a CHEAT candy
	cp LEGEND_CANDY
	jr z, .legendaryCandyCode
	ld a, [hl] ; a = level
	inc a
	jr .continueVanillaCandy
.legendaryCandyCode
	ld a, MAX_LEVEL
.continueVanillaCandy

	ld [hl], a ; store incremented level
	ld [wCurEnemyLVL], a
	push hl
	push de
	ld d, a
	callfar CalcExperience ; calculate experience for next level and store it at hExperience
	pop de
	pop hl
	ld bc, wPartyMon1Exp - wPartyMon1Level
	add hl, bc ; hl now points to MSB of experience
; update experience to minimum for new level
	ldh a, [hExperience]
	ld [hli], a
	ldh a, [hExperience + 1]
	ld [hli], a
	ldh a, [hExperience + 2]
	ld [hl], a
	pop hl
	ld a, [wWhichPokemon]
	push af
	ld a, [wcf91]
	push af
	push de
	push hl
	ld bc, wPartyMon1MaxHP - wPartyMon1
	add hl, bc ; hl now points to MSB of max HP
	ld a, [hli]
	ld b, a
	ld c, [hl]
	pop hl
	push bc
	push hl
	call .recalculateStats
	pop hl
	ld bc, (wPartyMon1MaxHP + 1) - wPartyMon1
	add hl, bc ; hl now points to LSB of max HP
	pop bc
	ld a, [hld]
	sub c
	ld c, a
	ld a, [hl]
	sbc b
	ld b, a ; bc = the amount of max HP gained from leveling up
; add the amount gained to the current HP
	ld de, (wPartyMon1HP + 1) - wPartyMon1MaxHP
	add hl, de ; hl now points to LSB of current HP
	ld a, [hl]
	add c
	ld [hld], a
	ld a, [hl]
	adc b
	ld [hl], a
	ld a, RARE_CANDY_MSG
	ld [wPartyMenuTypeOrMessageID], a
	call RedrawPartyMenu
	pop de
	ld a, d
	ld [wWhichPokemon], a
	ld a, e
	ld [wd11e], a
	xor a ; PLAYER_PARTY_DATA
	ld [wMonDataLocation], a
	call LoadMonData
	ld d, $01
	callfar PrintStatsBox ; display new stats text box
	call WaitForTextScrollButtonPress ; wait for button press
	xor a ; PLAYER_PARTY_DATA
	ld [wMonDataLocation], a
	predef LearnMoveFromLevelUp ; learn level up move, if any

	xor a
	ld [wForceEvolution], a
	callabd_ModifyPikachuHappiness PIKAHAPPY_LEVELUP
	ld a, [wWhichPokemon]
	push af
	ld a, [wUsedItemOnWhichPokemon]
	ld [wWhichPokemon], a
	callfar RespawnOverworldPikachu ; evolve pokemon, if appropriate
	pop af
	ld [wWhichPokemon], a

	callfar TryEvolvingMon
	ld a, $01
	ld [wUpdateSpritesEnabled], a
	pop af
	ld [wcf91], a
	pop af
	ld [wWhichPokemon], a
; new code for CHEAT_CANDY
	ld a, [wcf91] ; a contains the item ID
	cp CHEAT_CANDY
	ret z
; back to vanilla
	jp RemoveUsedItem

VitaminStatRoseText:
	text_far _VitaminStatRoseText
	text_end

VitaminNoEffectText:
	text_far _VitaminNoEffectText
	text_end

INCLUDE "data/battle/stat_names.asm"

ItemUseBait:
	ld hl, ThrewBaitText
	call PrintText
	ld hl, wEnemyMonActualCatchRate ; catch rate
	srl [hl] ; halve catch rate
	jr nz, .continueVanilla	; new
	ld [hl], 1				; new, catch rate cannot be less than 1
.continueVanilla			; new
	ld a, BAIT_ANIM
	ld hl, wSafariBaitFactor ; bait factor
	ld de, wSafariEscapeFactor ; escape factor
	jr BaitRockCommon

ItemUseRock:
	ld hl, ThrewRockText
	call PrintText
	ld hl, wEnemyMonActualCatchRate ; catch rate
	ld a, [hl]
	add a ; double catch rate
	jr nc, .noCarry
	ld a, $ff
	jr .noCarry2		; new
.noCarry
	add a				; new, double again the catch rate, to "mirror" the 4-2 behaviour of the baits
	jr nc, .noCarry2	; new
	ld a, $ff			; new
.noCarry2				; new
	ld [hl], a
	ld a, ROCK_ANIM
	ld hl, wSafariEscapeFactor ; escape factor
	ld de, wSafariBaitFactor ; bait factor

BaitRockCommon:
	ld [wAltAnimationID], a ; edited
	xor a
	ld [wAnimationType], a
	ldh [hWhoseTurn], a
	ld [de], a ; zero escape factor (for bait), zero bait factor (for rock)
.randomLoop ; loop until a random number less than 5 is generated
	call Random
	and 7
	cp 5
	jr nc, .randomLoop
	inc a ; increment the random number, giving a range from 1 to 5 inclusive
	ld b, a
	ld a, [hl]
	add b ; increase bait factor (for bait), increase escape factor (for rock)
	jr nc, .noCarry
	ld a, $ff
.noCarry
	ld [hl], a
	predef MoveAnimation ; do animation
	ld c, 70
	jp DelayFrames

ThrewBaitText:
	text_far _ThrewBaitText
	text_end

ThrewRockText:
	text_far _ThrewRockText
	text_end

; also used for Dig out-of-battle effect
ItemUseEscapeRope:
	ld a, [wIsInBattle]
	and a
	jr nz, .notUsable
	ld a, [wCurMap]
	cp AGATHAS_ROOM
	jr z, .notUsable
	cp BILLS_HOUSE
	jr z, .notUsable
	cp POKEMON_FAN_CLUB
	jr z, .notUsable
	ld a, [wCurMapTileset]
	ld b, a
	ld hl, EscapeRopeTilesets
.loop
	ld a, [hli]
	cp $ff
	jr z, .notUsable
	cp b
	jr nz, .loop
	ld hl, wd732
	set 3, [hl]
	set 6, [hl]
	call Func_1510
	ld hl, wd72e
	res 4, [hl]
	ResetEvent EVENT_IN_SAFARI_ZONE
	xor a
	ld [wNumSafariBalls], a
	ld [wSafariZoneGateCurScript], a
	inc a
	ld [wEscapedFromBattle], a
	ld [wActionResultOrTookBattleTurn], a ; item used
	ld a, [wPseudoItemID]
	and a ; using Dig?
	ret nz ; if so, return
	call ItemUseReloadOverworldData
	ld c, 30
	call DelayFrames
	jp RemoveUsedItem

.notUsable
	jp ItemUseNotTime

INCLUDE "data/tilesets/escape_rope_tilesets.asm"

ItemUseRepel:
	ld b, 100

ItemUseRepelCommon:
	ld a, [wIsInBattle]
	and a
	jp nz, ItemUseNotTime
	ld a, b
	ld [wRepelRemainingSteps], a
	jp PrintItemUseTextAndRemoveItem

; handles X Accuracy item
ItemUseXAccuracy:
	ld a, [wIsInBattle]
	and a
	jp z, ItemUseNotTime
	ld hl, wPlayerBattleStatus2
	set USING_X_ACCURACY, [hl] ; X Accuracy bit
	callabd_ModifyPikachuHappiness PIKAHAPPY_USEDXITEM
	jp PrintItemUseTextAndRemoveItem

; This function is bugged and never works. It always jumps to ItemUseNotTime.
; The Card Key is handled in a different way.
ItemUseCardKey:
;	xor a               ; edited, commented out as unused
;	ld [wUnusedD71F], a ; edited, commented out as unused
	call GetTileAndCoordsInFrontOfPlayer
	ld a, [GetTileAndCoordsInFrontOfPlayer]
	cp $18
	jr nz, .next0
	ld hl, CardKeyTable1
	jr .next1

.next0
	cp $24
	jr nz, .next2
	ld hl, CardKeyTable2
	jr .next1

.next2
	cp $5e
	jp nz, ItemUseNotTime
	ld hl, CardKeyTable3
.next1
	ld a, [wCurMap]
	ld b, a
.loop
	ld a, [hli]
	cp -1
	jp z, ItemUseNotTime
	cp b
	jr nz, .nextEntry1
	ld a, [hli]
	cp d
	jr nz, .nextEntry2
	ld a, [hli]
	cp e
	jr nz, .nextEntry3
	ld a, [hl]
;	ld [wUnusedD71F], a ; edited, commented out as unused
	jr .done

.nextEntry1
	inc hl
.nextEntry2
	inc hl
.nextEntry3
	inc hl
	jr .loop

.done
	ld hl, ItemUseText00
	call PrintText
	ld hl, wd728
	set 7, [hl]
	ret

INCLUDE "data/events/card_key_coords.asm"

ItemUsePokedoll:
	ld a, [wIsInBattle]
	dec a
	jp nz, ItemUseNotTime
	ld a, $01
	ld [wEscapedFromBattle], a
	jp PrintItemUseTextAndRemoveItem

ItemUseGuardSpec:
	ld a, [wIsInBattle]
	and a
	jp z, ItemUseNotTime

	ld a, [wWhichPokemon]
	push af
	ld a, [wPlayerMonNumber]
	ld [wWhichPokemon], a
	callabd_ModifyPikachuHappiness PIKAHAPPY_USEDXITEM
	pop af
	ld [wWhichPokemon], a

	ld hl, wPlayerBattleStatus2
	set PROTECTED_BY_MIST, [hl] ; Mist bit
	jp PrintItemUseTextAndRemoveItem

ItemUseSuperRepel:
	ld b, 200
	jp ItemUseRepelCommon

ItemUseMaxRepel:
	ld b, 250
	jp ItemUseRepelCommon

ItemUseDireHit:
	ld a, [wIsInBattle]
	and a
	jp z, ItemUseNotTime

	ld a, [wWhichPokemon]
	push af
	ld a, [wPlayerMonNumber]
	ld [wWhichPokemon], a
	callabd_ModifyPikachuHappiness PIKAHAPPY_USEDXITEM
	pop af
	ld [wWhichPokemon], a

	ld hl, wPlayerBattleStatus2
	set GETTING_PUMPED, [hl] ; Focus Energy bit
	jp PrintItemUseTextAndRemoveItem

ItemUseXStat:
	ld a, [wIsInBattle]
	and a
	jr nz, .inBattle
	call ItemUseNotTime
	ld a, 2
	ld [wActionResultOrTookBattleTurn], a ; item not used
	ret

.inBattle
	ld hl, wPlayerMoveNum
	ld a, [hli]
	push af ; save [wPlayerMoveNum]
	ld a, [hl]
	push af ; save [wPlayerMoveEffect]
	push hl
	ld a, [wcf91]
	sub X_ATTACK - ATTACK_UP1_EFFECT
	ld [hl], a ; store player move effect
	call PrintItemUseTextAndRemoveItem
	ld a, XSTATITEM_ANIM ; X stat item animation ID
	ld [wPlayerMoveNum], a
	ld [wAltAnimationID], a ; new
	call LoadScreenTilesFromBuffer1 ; restore saved screen
	call Delay3
	xor a
	ldh [hWhoseTurn], a ; set turn to player's turn
	farcall StatModifierUpEffect ; do stat increase move

	ld a, [wWhichPokemon]
	push af
	ld a, [wPlayerMonNumber]
	ld [wWhichPokemon], a
	callabd_ModifyPikachuHappiness PIKAHAPPY_USEDXITEM
	pop af
	ld [wWhichPokemon], a

	pop hl
	pop af
	ld [hld], a ; restore [wPlayerMoveEffect]
	pop af
	ld [hl], a ; restore [wPlayerMoveNum]
	ret

ItemUsePokeflute:
	ld a, [wIsInBattle]
	and a
	jp nz, .inBattle
; if not in battle
	call ItemUseReloadOverworldData
	ld a, [wCurMap]
	cp ROUTE_12
	jr nz, .notRoute12
	CheckEvent EVENT_BEAT_ROUTE12_SNORLAX
	jr nz, .noSnorlaxOrPikachuOrMachampToWakeUp
; if the player hasn't beaten Route 12 Snorlax
	ld hl, Route12SnorlaxFluteCoords
	call ArePlayerCoordsInArray
	jr nc, .noSnorlaxOrPikachuOrMachampToWakeUp
	ld hl, PlayedFluteHadEffectText
	call PrintText
	SetEvent EVENT_FIGHT_ROUTE12_SNORLAX
	ret

.notRoute12
	cp ROUTE_16
	jr nz, .notRoute16
	CheckEvent EVENT_BEAT_ROUTE16_SNORLAX
	jr nz, .noSnorlaxOrPikachuOrMachampToWakeUp
; if the player hasn't beaten Route 16 Snorlax
	ld hl, Route16SnorlaxFluteCoords
	call ArePlayerCoordsInArray
	jr nc, .noSnorlaxOrPikachuOrMachampToWakeUp
	ld hl, PlayedFluteHadEffectText
	call PrintText
	SetEvent EVENT_FIGHT_ROUTE16_SNORLAX
	ret

.notRoute16
	cp PEWTER_POKECENTER
	jr nz, .notPewterPokecenter ; edited
	call CheckPikachuFollowingPlayer
	jr z, .noSnorlaxOrPikachuOrMachampToWakeUp
	callfar IsPikachuRightNextToPlayer
	jr nc, .noSnorlaxOrPikachuOrMachampToWakeUp
	ld hl, PlayedFluteHadEffectText
	call PrintText
	call ItemUseReloadOverworldData
	ldpikaemotion e, PikachuEmotion26
	callfar PlaySpecificPikachuEmotion
	ret

.notPewterPokecenter ; new
	cp VERMILION_CITY
	jr nz, .noSnorlaxOrPikachuOrMachampToWakeUp ; wrong city
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE
	jr z, .noSnorlaxOrPikachuOrMachampToWakeUp ; Machamp hasn't finished building yet
	ld hl, VermilionMachampFluteCoords
	call ArePlayerCoordsInArray
	jr nc, .noSnorlaxOrPikachuOrMachampToWakeUp
	ld hl, PlayedFluteHadEffectText
	call PrintText
	ld hl, MachampAnnoyedText
	call PrintText
	ret

.noSnorlaxOrPikachuOrMachampToWakeUp ; edited label name
	ld hl, PlayedFluteNoEffectText
	jp PrintText

.inBattle
	xor a
	ld [wWereAnyMonsAsleep], a
	ld b, ~SLP_MASK
	ld hl, wPartyMon1Status
	call WakeUpEntireParty
	ld a, [wIsInBattle]
	dec a ; is it a trainer battle?
	jr z, .skipWakingUpEnemyParty
; if it's a trainer battle
	ld hl, wEnemyMon1Status
	call WakeUpEntireParty
.skipWakingUpEnemyParty
	ld hl, wBattleMonStatus
	ld a, [hl]
	and b ; remove Sleep status
	ld [hl], a
	ld hl, wEnemyMonStatus
	ld a, [hl]
	ld c, a
	and b ; remove Sleep status
	ld [hl], a
	ld a, c
	and SLP_MASK
	jr z, .asm_e063
	ld a, $1
	ld [wWereAnyMonsAsleep], a
.asm_e063
	call LoadScreenTilesFromBuffer2 ; restore saved screen
	ld a, [wWereAnyMonsAsleep]
	and a ; were any pokemon asleep before playing the flute?
	ld hl, PlayedFluteNoEffectText
	jp z, PrintText ; if no pokemon were asleep
; if some pokemon were asleep
	ld hl, PlayedFluteHadEffectText
	call PrintText
	ld a, [wLowHealthAlarm]
	and $80
	jr nz, .skipMusic
	call WaitForSoundToFinish ; wait for sound to end
	farcall Music_PokeFluteInBattle ; play in-battle pokeflute music
.musicWaitLoop ; wait for music to finish playing
	ld a, [wChannelSoundIDs + CHAN7]
	and a ; music off?
	jr nz, .musicWaitLoop
.skipMusic
	ld hl, FluteWokeUpText
	jp PrintText

; wakes up all party pokemon
; INPUT:
; hl must point to status of first pokemon in party (player's or enemy's)
; b must equal ~SLP
; [wWereAnyMonsAsleep] should be initialized to 0
; OUTPUT:
; [wWereAnyMonsAsleep]: set to 1 if any pokemon were asleep
WakeUpEntireParty:
	ld de, 44
	ld c, 6
.loop
	ld a, [hl]
	push af
	and SLP_MASK
	jr z, .notAsleep
	ld a, 1
	ld [wWereAnyMonsAsleep], a ; indicate that a pokemon had to be woken up
.notAsleep
	pop af
	and b ; remove Sleep status
	ld [hl], a
	add hl, de
	dec c
	jr nz, .loop
	ret

Route12SnorlaxFluteCoords:
	dbmapcoord  9, 62 ; one space West of Snorlax
	dbmapcoord 10, 61 ; one space North of Snorlax
	dbmapcoord 10, 63 ; one space South of Snorlax
	dbmapcoord 11, 62 ; one space East of Snorlax
	db -1 ; end

Route16SnorlaxFluteCoords:
	dbmapcoord 27, 10 ; one space East of Snorlax
	dbmapcoord 25, 10 ; one space West of Snorlax
	db -1 ; end

VermilionMachampFluteCoords: ; new
	dbmapcoord 33, 11 ; one space North of Machamp
	dbmapcoord 32, 12 ; one space West of Machamp
	db -1 ; end

MachampAnnoyedText: ; new
	text_far _MachampAnnoyedText
	text_end

PlayedFluteNoEffectText:
	text_far _PlayedFluteNoEffectText
	text_end

FluteWokeUpText:
	text_far _FluteWokeUpText
	text_end

PlayedFluteHadEffectText:
	text_far _PlayedFluteHadEffectText
	text_promptbutton
	text_asm
	ld a, [wIsInBattle]
	and a
	jr nz, .done
; play out-of-battle pokeflute music
	call StopAllMusic
	ld a, SFX_POKEFLUTE
	ld c, BANK(SFX_Pokeflute)
	call PlayMusic
.musicWaitLoop ; wait for music to finish playing
	ld a, [wChannelSoundIDs + CHAN3]
	cp SFX_POKEFLUTE
	jr z, .musicWaitLoop
	call PlayDefaultMusic ; start playing normal music again
.done
	jp TextScriptEnd ; end text

ItemUseCoinCase:
	ld a, [wIsInBattle]
	and a
	jp nz, ItemUseNotTime
	ld hl, CoinCaseNumCoinsText
	jp PrintText

CoinCaseNumCoinsText:
	text_far _CoinCaseNumCoinsText
	text_end

ItemUseOldRod:
	call FishingInit
	jp c, ItemUseNotTime
	lb bc, 5, MAGIKARP
	; new, to improve rods (Obsidian Fishing Guru) - begin
	CheckEvent EVENT_ENHANCED_RODS
	jr z, .setBite
	lb bc, 15, MAGIKARP
.setBite
	; new, to improve rods (Obsidian Fishing Guru) - end
	ld a, $1 ; set bite
	jr RodResponse

ItemUseGoodRod:
	call FishingInit
	jp c, ItemUseNotTime
.RandomLoop
	; new, to improve rods (Obsidian Fishing Guru) - begin
	CheckEvent EVENT_ENHANCED_RODS
	jr z, .notEnhancedRod
	call Random
	and %1
	ld hl, GoodRodMons_Enhanced
	jr .readMonInfo
.notEnhancedRod
	; new, to improve rods (Obsidian Fishing Guru) - end
	call Random
	srl a
	jr c, .SetBite
	and %11
	cp 2
	jr nc, .RandomLoop
	; choose which monster appears
	ld hl, GoodRodMons
.readMonInfo ; new, to improve rods (Obsidian Fishing Guru)
	add a
	ld c, a
	ld b, 0
	add hl, bc
	ld b, [hl]
	inc hl
	ld c, [hl]
	and a
.SetBite
	ld a, 0
	rla
	xor 1
	jr RodResponse

INCLUDE "data/wild/good_rod.asm"

ItemUseSuperRod:
	call FishingInit
	jp c, ItemUseNotTime
	callfar ReadSuperRodData
	ld c, e
	ld b, d
	ld a, $2
	ld [wRodResponse], a
	ld a, c
	and a ; are there fish in the map?
	jr z, DoNotGenerateFishingEncounter ; if not, do not generate an encounter

	; new, increased fishing chances with Super Rod and to improve rods (Obsidian Fishing Guru)
	CheckEvent EVENT_ENHANCED_RODS
	jr nz, .enhancedRods
	call Random
	cp 192 ; about 75% of 255
	jr .storeResult
.enhancedRods
	call Random
	cp 230 ; about 90% of 255
.storeResult
	ld a, $1
	ld [wRodResponse], a
	jr c, RodResponse ; get a respose if there's a carry, i.e. if a-192[230] is negative, i.e. if a<192[230], i.e. 75[90]%

	xor a
	ld [wRodResponse], a
	jr DoNotGenerateFishingEncounter

RodResponse:
	ld [wRodResponse], a

	dec a ; is there a bite?
	jr nz, DoNotGenerateFishingEncounter
	; if yes, store level and species data
	ld a, 1
	ld [wMoveMissed], a
	ld a, b ; level
	ld [wCurEnemyLVL], a
	ld a, c ; species
	ld [wCurOpponent], a
	callfar RollForShiny ; new, for the shiny

DoNotGenerateFishingEncounter:
	ld hl, wWalkBikeSurfState
	ld a, [hl] ; store the value in a
	push af
	push hl
	ld [hl], 0
	farcall FishingAnim
	pop hl
	pop af
	ld [hl], a
	ret

; checks if fishing is possible and if so, runs initialization code common to all rods
; unsets carry if fishing is possible, sets carry if not
FishingInit:
	ld a, [wIsInBattle]
	and a
	jr z, .notInBattle
	scf ; can't fish during battle
	ret

.notInBattle
	call IsNextTileShoreOrWater
	jr nc, .cannotFish
	ld a, [wWalkBikeSurfState]
	cp 2 ; Surfing?
	jr z, .cannotFish
	call ItemUseReloadOverworldData
	ld hl, ItemUseText00
	call PrintText
	ld a, SFX_HEAL_AILMENT
	call PlaySound
	ld a, $2
	ld [wd49c], a
	ld a, $81
	ld [wPikachuMood], a
	ld c, 80
	call DelayFrames
	and a
	ret

.cannotFish
	scf ; can't fish when surfing
	ret

ItemUseOaksParcel:
	jp ItemUseNotYoursToUse

ItemUseItemfinder:
	ld a, [wIsInBattle]
	and a
	jp nz, ItemUseNotTime
	call ItemUseReloadOverworldData
	farcall HiddenItemNear ; check for hidden items
	ld hl, ItemfinderFoundNothingText
	jr nc, .printText ; if no hidden items
	ld c, 4
.loop
	ld a, SFX_HEALING_MACHINE
	call PlaySoundWaitForCurrent
	ld a, SFX_PURCHASE
	call PlaySoundWaitForCurrent
	dec c
	jr nz, .loop
	ld hl, ItemfinderFoundItemText
.printText
	jp PrintText

ItemfinderFoundItemText:
	text_far _ItemfinderFoundItemText
	text_end

ItemfinderFoundNothingText:
	text_far _ItemfinderFoundNothingText
	text_end

ItemUsePPUp:
	ld a, [wIsInBattle]
	and a
	jp nz, ItemUseNotTime

ItemUsePPRestore:
	ld a, [wWhichPokemon]
	push af
	ld a, [wcf91]
	ld [wPPRestoreItem], a
.chooseMon
	xor a
	ld [wUpdateSpritesEnabled], a
	ld a, USE_ITEM_PARTY_MENU
	ld [wPartyMenuTypeOrMessageID], a
	call DisplayPartyMenu
	jr nc, .chooseMove
	jp .itemNotUsed

.chooseMove
	ld a, [wIsInBattle]
	and a
	jr z, .usePPItem
	ld a, [wWhichPokemon]
	ld b, a
	ld a, [wPlayerMonNumber]
	cp b
	jr nz, .usePPItem
	ld a, [wPlayerBattleStatus3]
	bit TRANSFORMED, a
	jr z, .usePPItem
	call ItemUseNotTime
	jp .itemNotUsed

.usePPItem
	ld a, [wPPRestoreItem]
	cp ELIXER
	jp nc, .useElixir ; if Elixir or Max Elixir
	ld a, $02
	ld [wMoveMenuType], a
	ld hl, RaisePPWhichTechniqueText
	ld a, [wPPRestoreItem]
	cp ETHER ; is it a PP Up?
	jr c, .printWhichTechniqueMessage ; if so, print the raise PP message
	ld hl, RestorePPWhichTechniqueText ; otherwise, print the restore PP message
.printWhichTechniqueMessage
	call PrintText
	xor a
	ld [wPlayerMoveListIndex], a
	callfar MoveSelectionMenu ; move selection menu
	ld a, 0
	ld [wPlayerMoveListIndex], a
	jr nz, .chooseMon
	ld hl, wPartyMon1Moves
	ld bc, wPartyMon2 - wPartyMon1
	call GetSelectedMoveOffset
	push hl
	ld a, [hl]
	ld [wd11e], a
	call GetMoveName
	call CopyToStringBuffer
	pop hl
	ld a, [wPPRestoreItem]
	cp ETHER
	jr nc, .useEther ; if Ether or Max Ether
.usePPUp
	ld bc, wPartyMon1PP - wPartyMon1Moves
	add hl, bc
	ld a, [hl] ; move PP
	cp 3 << 6 ; have 3 PP Ups already been used?
	jr c, .PPNotMaxedOut
	ld hl, PPMaxedOutText
	call PrintText
	jr .chooseMove

.PPNotMaxedOut
	ld a, [hl]
	add 1 << 6 ; increase PP Up count by 1
	ld [hl], a
	ld a, 1 ; 1 PP Up used
	ld [wd11e], a
	call RestoreBonusPP ; add the bonus PP to current PP
	ld a, SFX_HEAL_AILMENT
	call PlaySound
	ld hl, PPIncreasedText
	call PrintText
.done
	pop af
	ld [wWhichPokemon], a
	call GBPalWhiteOut
	call RunDefaultPaletteCommand
	jp RemoveUsedItem

.afterRestoringPP ; after using a (Max) Ether/Elixir
	ld a, [wWhichPokemon]
	ld b, a
	ld a, [wPlayerMonNumber]
	cp b ; is the pokemon whose PP was restored active in battle?
	jr nz, .skipUpdatingInBattleData
	ld hl, wPartyMon1PP
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	ld de, wBattleMonPP
	ld bc, 4
	call CopyData ; copy party data to in-battle data
.skipUpdatingInBattleData
	ld a, SFX_HEAL_AILMENT
	call PlaySound
	ld hl, PPRestoredText
	call PrintText
	jr .done

.useEther
	call .restorePP
	jr nz, .afterRestoringPP
	jp .noEffect

; unsets zero flag if PP was restored, sets zero flag if not
; however, this is bugged for Max Ethers and Max Elixirs (see below)
.restorePP
	xor a ; PLAYER_PARTY_DATA
	ld [wMonDataLocation], a
	call GetMaxPP
	ld hl, wPartyMon1Moves
	ld bc, wPartyMon2 - wPartyMon1
	call GetSelectedMoveOffset
	ld bc, wPartyMon1PP - wPartyMon1Moves
	add hl, bc ; hl now points to move's PP
	ld a, [wMaxPP]
	ld b, a
	ld a, [wPPRestoreItem]
	cp MAX_ETHER
	jr z, .fullyRestorePP
	ld a, [hl] ; move PP
	and %00111111 ; lower 6 bit bits store current PP
	cp b ; does current PP equal max PP?
	ret z ; if so, return
	add 10 ; increase current PP by 10
; b holds the max PP amount and b will hold the new PP amount.
; So, if the new amount meets or exceeds the max amount,
; cap the amount to the max amount by leaving b unchanged.
; Otherwise, store the new amount in b.
	cp b ; does the new amount meet or exceed the maximum?
	jr nc, .storeNewAmount
	ld b, a
.storeNewAmount
	ld a, [hl] ; move PP
	and %11000000 ; PP Up counter bits
	add b
	ld [hl], a
	ret

.fullyRestorePP
	ld a, [hl] ; move PP
; Note that this code has a bug. It doesn't mask out the upper two bits, which
; are used to count how many PP Ups have been used on the move. So, Max Ethers
; and Max Elixirs will not be detected as having no effect on a move with full
; PP if the move has had any PP Ups used on it.
	cp b ; does current PP equal max PP?
	ret z
	jr .storeNewAmount

.useElixir
; decrement the item ID so that ELIXER becomes ETHER and MAX_ELIXER becomes MAX_ETHER
	ld hl, wPPRestoreItem
	dec [hl]
	dec [hl]
	xor a
	ld hl, wCurrentMenuItem
	ld [hli], a
	ld [hl], a ; zero the counter for number of moves that had their PP restored
	ld b, 4
; loop through each move and restore PP
.elixirLoop
	push bc
	ld hl, wPartyMon1Moves
	ld bc, wPartyMon2 - wPartyMon1
	call GetSelectedMoveOffset
	ld a, [hl]
	and a ; does the current slot have a move?
	jr z, .nextMove
	call .restorePP
	jr z, .nextMove
; if some PP was restored
	ld hl, wTileBehindCursor ; counter for number of moves that had their PP restored
	inc [hl]
.nextMove
	ld hl, wCurrentMenuItem
	inc [hl]
	pop bc
	dec b
	jr nz, .elixirLoop
	ld a, [wTileBehindCursor]
	and a ; did any moves have their PP restored?
	jp nz, .afterRestoringPP
.noEffect
	call ItemUseNoEffect
.itemNotUsed
	call GBPalWhiteOut
	call RunDefaultPaletteCommand
	pop af
	xor a
	ld [wActionResultOrTookBattleTurn], a ; item use failed
	ret

RaisePPWhichTechniqueText:
	text_far _RaisePPWhichTechniqueText
	text_end

RestorePPWhichTechniqueText:
	text_far _RestorePPWhichTechniqueText
	text_end

PPMaxedOutText:
	text_far _PPMaxedOutText
	text_end

PPIncreasedText:
	text_far _PPIncreasedText
	text_end

PPRestoredText:
	text_far _PPRestoredText
	text_end

; for items that can't be used from the Item menu
UnusableItem:
	jp ItemUseNotTime

ItemUseTMHM:
	ld a, [wIsInBattle]
	and a
	jp nz, ItemUseNotTime
	ld a, [wcf91]
	sub TM01 ; underflows below 0 for HM items (before TM items)
	push af
	jr nc, .skipAdding
	add NUM_TMS + NUM_HMS ; adjust HM IDs to come after TM IDs
.skipAdding
	inc a
	ld [wd11e], a
	predef TMToMove ; get move ID from TM/HM ID
	ld a, [wd11e]
	ld [wUniQuizAnswer], a ; new, testing
	ld [wMoveNum], a
	call GetMoveName
	ld a, ITEM_NAME			; new, if you decide not to use the machine, change the list type back to item list. FIXES THE TM CRASH BUG! Thanks Zangoose! + Pigeon edit, it was on another line, still had some edge cases of crash
    ld [wNameListType], a	; new, if you decide not to use the machine, change the list type back to item list. FIXES THE TM CRASH BUG! Thanks Zangoose! + Pigeon edit, it was on another line, still had some edge cases of crash
	call CopyToStringBuffer
	pop af
	ld hl, BootedUpTMText
	jr nc, .printBootedUpMachineText
	ld hl, BootedUpHMText
.printBootedUpMachineText
	call PrintText
	ld hl, TeachMachineMoveText
	call PrintText
	hlcoord 14, 7
	lb bc, 8, 15
	ld a, TWO_OPTION_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID ; yes/no menu
	ld a, [wCurrentMenuItem]
	and a
	jr z, .useMachine
	ld a, 2
	ld [wActionResultOrTookBattleTurn], a ; item not used
	ret

.useMachine
	ld a, [wWhichPokemon]
	push af
	ld a, [wcf91]
	push af
.chooseMon
	ld hl, wStringBuffer
	ld de, wTempMoveNameBuffer
	ld bc, 14
	call CopyData ; save the move name because DisplayPartyMenu will overwrite it
	ld a, $ff
	ld [wUpdateSpritesEnabled], a
	ld a, TMHM_PARTY_MENU
	ld [wPartyMenuTypeOrMessageID], a
	call DisplayPartyMenu
	push af
	ld hl, wTempMoveNameBuffer
	ld de, wStringBuffer
	ld bc, 14
	call CopyData
	pop af
	jr nc, .checkIfAbleToLearnMove
; if the player canceled teaching the move
	pop af
	pop af
	call GBPalWhiteOutWithDelay3
	call ClearSprites
	call RunDefaultPaletteCommand
	jp LoadScreenTilesFromBuffer1 ; restore saved screen
.checkIfAbleToLearnMove
	predef CanLearnTM ; check if the pokemon can learn the move
	push bc
	ld a, [wWhichPokemon]
	ld hl, wPartyMonNicks
	call GetPartyMonName
	pop bc
	ld a, c
	and a ; can the pokemon learn the move?
	jr nz, .checkIfAlreadyLearnedMove
; if the pokemon can't learn the move
	ld a, SFX_DENIED
	call PlaySoundWaitForCurrent
	ld hl, MonCannotLearnMachineMoveText
	call PrintText
	jr .chooseMon

.checkIfAlreadyLearnedMove
	callfar CheckIfMoveIsKnown ; check if the pokemon already knows the move
	jr c, .chooseMon
	predef LearnMove ; teach move
	ld a, [wWhichPokemon]
	ld d, a
	pop af
	ld [wcf91], a
	pop af
	ld [wWhichPokemon], a
	ld a, b
	and a
	ret z

	ld a, [wWhichPokemon]
	push af
	ld a, d
	ld [wWhichPokemon], a
	callabd_ModifyPikachuHappiness PIKAHAPPY_USEDTMHM
	callfar IsThisPartymonStarterPikachu_Party
	jr nc, .notTeachingThunderboltOrThunderToPikachu
	ld a, [wcf91]
	cp TM_THUNDERBOLT ; are we teaching thunderbolt to the player pikachu?
	jr z, .teachingThunderboltOrThunderToPlayerPikachu
	cp TM_THUNDER ; are we teaching thunder then?
	jr nz, .notTeachingThunderboltOrThunderToPikachu
.teachingThunderboltOrThunderToPlayerPikachu
	ld a, $5
	ld [wd49c], a
	ld a, $85
	ld [wPikachuMood], a
.notTeachingThunderboltOrThunderToPikachu
	pop af
	ld [wWhichPokemon], a

	ld a, [wcf91]
	call IsItemHM
	ret c
	jp RemoveUsedItem

BootedUpTMText:
	text_far _BootedUpTMText
	text_end

BootedUpHMText:
	text_far _BootedUpHMText
	text_end

TeachMachineMoveText:
	text_far _TeachMachineMoveText
	text_end

MonCannotLearnMachineMoveText:
	text_far _MonCannotLearnMachineMoveText
	text_end

PrintItemUseTextAndRemoveItem:
	ld hl, ItemUseText00
	call PrintText
	ld a, SFX_HEAL_AILMENT
	call PlaySound
	call WaitForTextScrollButtonPress ; wait for button press

RemoveUsedItem:
	ld hl, wNumBagItems
	ld a, 1 ; one item
	ld [wItemQuantity], a
	jp RemoveItemFromInventory

ItemUseNoEffect:
	ld hl, ItemUseNoEffectText
	jr ItemUseFailed

ItemUseNotTime:
	ld hl, ItemUseNotTimeText
	jr ItemUseFailed

ItemUseNotYoursToUse:
	ld hl, ItemUseNotYoursToUseText
	jr ItemUseFailed

Func_e4bf:
	ld a, $2
	ld [wActionResultOrTookBattleTurn], a
	ld hl, DontHavePokemonText
	jp PrintText

ThrowBallAtTrainerMon:
	call RunDefaultPaletteCommand
	call LoadScreenTilesFromBuffer1 ; restore saved screen
	call Delay3
	ld a, TOSS_ANIM
	ld [wAltAnimationID], a ; edited
	predef MoveAnimation ; do animation
	ld hl, ThrowBallAtTrainerMonText1
	call PrintText
	ld hl, ThrowBallAtTrainerMonText2
	call PrintText
	jr RemoveUsedItem

ThrowMasterBallAtMissingno: ; new
	call RunDefaultPaletteCommand
	call LoadScreenTilesFromBuffer1 ; restore saved screen
	call Delay3
	ld a, TOSS_ANIM
	ld [wAltAnimationID], a ; edited
	predef MoveAnimation ; do animation
	ld hl, ThrowMasterBallAtMissingnoText1
	call PrintText
	ld hl, ThrowMasterBallAtMissingnoText2
	call PrintText
	jr RemoveUsedItem

NoCyclingAllowedHere:
	ld hl, NoCyclingAllowedHereText
	jr ItemUseFailed

BoxFullCannotThrowBall:
	ld hl, BoxFullCannotThrowBallText
	jr ItemUseFailed

SurfingAttemptFailed:
	ld hl, NoSurfingHereText

ItemUseFailed:
	xor a
	ld [wActionResultOrTookBattleTurn], a ; item use failed
	jp PrintText

ItemUseNotTimeText:
	text_far _ItemUseNotTimeText
	text_end

ItemUseNotYoursToUseText:
	text_far _ItemUseNotYoursToUseText
	text_end

ItemUseNoEffectText:
	text_far _ItemUseNoEffectText
	text_end

ThrowBallAtTrainerMonText1:
	text_far _ThrowBallAtTrainerMonText1
	text_end

ThrowBallAtTrainerMonText2:
	text_far _ThrowBallAtTrainerMonText2
	text_end

ThrowMasterBallAtMissingnoText1: ; new
	text_far _ThrowMasterBallAtMissingnoText1
	text_end

ThrowMasterBallAtMissingnoText2: ; new
	text_far _ThrowMasterBallAtMissingnoText2
	text_end

NoCyclingAllowedHereText:
	text_far _NoCyclingAllowedHereText
	text_end

NoSurfingHereText:
	text_far _NoSurfingHereText
	text_end

BoxFullCannotThrowBallText:
	text_far _BoxFullCannotThrowBallText
	text_end

DontHavePokemonText:
	text_far _DontHavePokemonText
	text_end

ItemUseText00:
	text_far _ItemUseText001
	text_low
	text_far _ItemUseText002
	text_end

GotOnBicycleText:
	text_far _GotOnBicycleText1
	text_low
	text_far _GotOnBicycleText2
	text_end

GotOffBicycleText:
	text_far _GotOffBicycleText1
	text_low
	text_far _GotOffBicycleText2
	text_end

; restores bonus PP (from PP Ups) when healing at a pokemon center
; also, when a PP Up is used, it increases the current PP by one PP Up bonus
; INPUT:
; [wWhichPokemon] = index of pokemon in party
; [wCurrentMenuItem] = index of move (when using a PP Up)
RestoreBonusPP:
	ld hl, wPartyMon1Moves
	ld bc, wPartyMon2 - wPartyMon1
	ld a, [wWhichPokemon]
	call AddNTimes
	push hl
	ld de, wNormalMaxPPList - 1
	predef LoadMovePPs ; loads the normal max PP of each of the pokemon's moves to wNormalMaxPPList
	pop hl
	ld c, wPartyMon1PP - wPartyMon1Moves
	ld b, 0
	add hl, bc ; hl now points to move 1 PP
	ld de, wNormalMaxPPList
	ld b, 0 ; initialize move counter to zero
; loop through the pokemon's moves
.loop
	inc b
	ld a, b
	cp 5 ; reached the end of the pokemon's moves?
	ret z ; if so, return
	ld a, [wUsingPPUp]
	dec a ; using a PP Up?
	jr nz, .skipMenuItemIDCheck
; if using a PP Up, check if this is the move it's being used on
	ld a, [wCurrentMenuItem]
	inc a
	cp b
	jr nz, .nextMove
.skipMenuItemIDCheck
	ld a, [hl]
	and %11000000 ; have any PP Ups been used?
	call nz, AddBonusPP ; if so, add bonus PP
.nextMove
	inc hl
	inc de
	jr .loop

; adds bonus PP from PP Ups to current PP
; 1/5 of normal max PP (capped at 7) is added for each PP Up
; INPUT:
; [de] = normal max PP
; [hl] = move PP
AddBonusPP:
	push bc
	ld a, [de] ; normal max PP of move
	ldh [hDividend + 3], a
	xor a
	ldh [hDividend], a
	ldh [hDividend + 1], a
	ldh [hDividend + 2], a
	ld a, 5
	ldh [hDivisor], a
	ld b, 4
	call Divide
	ld a, [hl] ; move PP
	ld b, a
	swap a
	and %00001111
	srl a
	srl a
	ld c, a ; c = number of PP Ups used
.loop
	ldh a, [hQuotient + 3]
	cp 8 ; is the amount greater than or equal to 8?
	jr c, .addAmount
	ld a, 7 ; cap the amount at 7
.addAmount
	add b
	ld b, a
	ld a, [wUsingPPUp]
	dec a ; is the player using a PP Up right now?
	jr z, .done ; if so, only add the bonus once
	dec c
	jr nz, .loop
.done
	ld [hl], b
	pop bc
	ret

; gets max PP of a pokemon's move (including PP from PP Ups)
; INPUT:
; [wWhichPokemon] = index of pokemon within party/box
; [wMonDataLocation] = pokemon source
; 00: player's party
; 01: enemy's party
; 02: current box
; 03: daycare
; 04: player's in-battle pokemon
; [wCurrentMenuItem] = move index
; OUTPUT:
; [wMaxPP] = max PP
GetMaxPP:
	ld a, [wMonDataLocation]
	and a
	ld hl, wPartyMon1Moves
	ld bc, wPartyMon2 - wPartyMon1
	jr z, .sourceWithMultipleMon
	ld hl, wEnemyMon1Moves
	dec a
	jr z, .sourceWithMultipleMon
	ld hl, wBoxMon1Moves
	ld bc, wBoxMon2 - wBoxMon1
	dec a
	jr z, .sourceWithMultipleMon
	ld hl, wDayCareMonMoves
	dec a
	jr z, .sourceWithOneMon
	ld hl, wBattleMonMoves ; player's in-battle pokemon
.sourceWithOneMon
	call GetSelectedMoveOffset2
	jr .next

.sourceWithMultipleMon
	call GetSelectedMoveOffset
.next
	ld a, [hl]
	dec a
	push hl
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld de, wcd6d
	ld a, BANK(Moves)
	call FarCopyData
	ld de, wcd6d + 5 ; PP is byte 5 of move data
	ld a, [de]
	ld b, a ; b = normal max PP
	pop hl
	push bc
	ld bc, wPartyMon1PP - wPartyMon1Moves ; PP offset if not player's in-battle pokemon data
	ld a, [wMonDataLocation]
	cp 4 ; player's in-battle pokemon?
	jr nz, .addPPOffset
	ld bc, wBattleMonPP - wBattleMonMoves ; PP offset if player's in-battle pokemon data
.addPPOffset
	add hl, bc
	ld a, [hl] ; a = current PP
	and %11000000 ; get PP Up count
	pop bc
	or b ; place normal max PP in 6 lower bits of a
	ld h, d
	ld l, e
	inc hl ; hl = wcd73
	ld [hl], a
	xor a ; add the bonus for the existing PP Up count
	ld [wUsingPPUp], a
	call AddBonusPP ; add bonus PP from PP Ups
	ld a, [hl]
	and %00111111 ; mask out the PP Up count
	ld [wMaxPP], a ; store max PP
	ret

GetSelectedMoveOffset:
	ld a, [wWhichPokemon]
	call AddNTimes

GetSelectedMoveOffset2:
	ld a, [wCurrentMenuItem]
	ld c, a
	ld b, 0
	add hl, bc
	ret

; confirms the item toss and then tosses the item
; INPUT:
; hl = address of inventory (either wNumBagItems or wNumBoxItems)
; [wcf91] = item ID
; [wWhichPokemon] = index of item within inventory
; [wItemQuantity] = quantity to toss
; OUTPUT:
; clears carry flag if the item is tossed, sets carry flag if not
TossItem_::
	push hl
	ld a, [wcf91]
	call IsItemHM
	pop hl
	jr c, .tooImportantToToss
	push hl
	call IsKeyItem_
	ld a, [wIsKeyItem]
	pop hl
	and a
	jr nz, .tooImportantToToss
	push hl
	ld a, [wcf91]
	ld [wd11e], a
	call GetItemName
	call CopyToStringBuffer
	ld hl, IsItOKToTossItemText
	call PrintText
	hlcoord 14, 7
	lb bc, 8, 15
	ld a, TWO_OPTION_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID ; yes/no menu
	ld a, [wMenuExitMethod]
	cp CHOSE_SECOND_ITEM
	pop hl
	scf
	ret z ; return if the player chose No
; if the player chose Yes
	push hl
	ld a, [wWhichPokemon]
	call RemoveItemFromInventory
	ld a, [wcf91]
	ld [wd11e], a
	call GetItemName
	call CopyToStringBuffer
	ld hl, ThrewAwayItemText
	call PrintText
	pop hl
	and a
	ret

.tooImportantToToss
	push hl
	ld hl, TooImportantToTossText
	call PrintText
	pop hl
	scf
	ret

ThrewAwayItemText:
	text_far _ThrewAwayItemText
	text_end

IsItOKToTossItemText:
	text_far _IsItOKToTossItemText
	text_end

TooImportantToTossText:
	text_far _TooImportantToTossText
	text_end

; checks if an item is a key item
; INPUT:
; [wcf91] = item ID
; OUTPUT:
; [wIsKeyItem] = result
; 00: item is not key item
; 01: item is key item
IsKeyItem_::
	ld a, $01
	ld [wIsKeyItem], a
	ld a, [wcf91]
	cp HM01 ; is the item an HM or TM?
	jr nc, .checkIfItemIsHM
; if the item is not an HM or TM
	push af
	ld hl, KeyItemFlags
	ld de, wBuffer
	ld bc, 15 ; only 11 bytes are actually used ; this needs to be edited if I end up with more than 120 items?
	ASSERT 15 >= (NUM_ITEMS + 7) / 8
	call CopyData
	pop af
	dec a
	ld c, a
	ld hl, wBuffer
	ld b, FLAG_TEST
	predef FlagActionPredef
	ld a, c
	and a
	ret nz
.checkIfItemIsHM
	ld a, [wcf91]
	call IsItemHM
	ret c
	xor a
	ld [wIsKeyItem], a
	ret

INCLUDE "data/items/key_items.asm"

SendNewMonToBox:
	ld de, wBoxCount
	ld a, [de]
	inc a
	ld [de], a
	ld a, [wcf91]
	ld [wd0b5], a
	ld c, a
.loop
	inc de
	ld a, [de]
	ld b, a
	ld a, c
	ld c, b
	ld [de], a
	cp $ff
	jr nz, .loop
	call GetMonHeader
	ld hl, wBoxMonOT
	ld bc, NAME_LENGTH
	ld a, [wBoxCount]
	dec a
	jr z, .skip
	dec a
	call AddNTimes
	push hl
	ld bc, NAME_LENGTH
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, [wBoxCount]
	dec a
	ld b, a
.loop2
	push bc
	push hl
	ld bc, NAME_LENGTH
	call CopyData
	pop hl
	ld d, h
	ld e, l
	ld bc, -NAME_LENGTH
	add hl, bc
	pop bc
	dec b
	jr nz, .loop2
.skip
	ld hl, wPlayerName
	ld de, wBoxMonOT
	ld bc, NAME_LENGTH
	call CopyData
	ld a, [wBoxCount]
	dec a
	jr z, .skip2
	ld hl, wBoxMonNicks
	ld bc, NAME_LENGTH
	dec a
	call AddNTimes
	push hl
	ld bc, NAME_LENGTH
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, [wBoxCount]
	dec a
	ld b, a
.loop3
	push bc
	push hl
	ld bc, NAME_LENGTH
	call CopyData
	pop hl
	ld d, h
	ld e, l
	ld bc, -NAME_LENGTH
	add hl, bc
	pop bc
	dec b
	jr nz, .loop3
.skip2
	ld hl, wBoxMonNicks
	ld a, NAME_MON_SCREEN
	ld [wNamingScreenType], a
	predef AskName
	ld a, [wBoxCount]
	dec a
	jr z, .skip3
	ld hl, wBoxMons
	ld bc, wBoxMon2 - wBoxMon1
	dec a
	call AddNTimes
	push hl
	ld bc, wBoxMon2 - wBoxMon1
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, [wBoxCount]
	dec a
	ld b, a
.loop4
	push bc
	push hl
	ld bc, wBoxMon2 - wBoxMon1
	call CopyData
	pop hl
	ld d, h
	ld e, l
	ld bc, wBoxMon1 - wBoxMon2
	add hl, bc
	pop bc
	dec b
	jr nz, .loop4
.skip3
	ld a, [wEnemyMonLevel]
	ld [wEnemyMonBoxLevel], a
	ld hl, wEnemyMon
	ld de, wBoxMon1
	ld bc, wEnemyMonDVs - wEnemyMon
	call CopyData
	ld hl, wPlayerID
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
	push de
	ld a, [wCurEnemyLVL]
	ld d, a
	callfar CalcExperience
	pop de
	ldh a, [hExperience]
	ld [de], a
	inc de
	ldh a, [hExperience + 1]
	ld [de], a
	inc de
	ldh a, [hExperience + 2]
	ld [de], a
	inc de
	xor a
	ld b, NUM_STATS * 2
.loop5
	ld [de], a
	inc de
	dec b
	jr nz, .loop5
	ld hl, wEnemyMonDVs
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ld hl, wEnemyMonPP
	ld b, NUM_MOVES
.loop6
	ld a, [hli]
	inc de
	ld [de], a
	dec b
	jr nz, .loop6
	ld a, [wOpponentMonShiny]
	ld [wBoxMon1CatchRate], a
	ret

; checks if the tile in front of the player is a shore or water tile
; used for surfing and fishing
; unsets carry if it is, sets carry if not
IsNextTileShoreOrWater::
	ld a, [wCurMapTileset]
	ld hl, WaterTilesets
	ld de, 1
	call IsInArray ; does the current map allow surfing?
	ret nc ; if not, return
	ld hl, WaterTile
	ld a, [wCurMapTileset]
	cp SHIP_PORT ; Vermilion Dock tileset
	jr z, .skipShoreTiles ; if it's the Vermilion Dock tileset
	cp GYM ; eastern shore tile in Safari Zone
	jr z, .skipShoreTiles
	cp DOJO ; usual eastern shore tile
	jr z, .skipShoreTiles
	ld hl, ShoreTiles
.skipShoreTiles
	ld a, [wTileInFrontOfPlayer]
	ld de, $1
	call IsInArray
	ret

INCLUDE "data/tilesets/water_tilesets.asm"

; shore tiles
ShoreTiles:
	db $48, $32, $66 ; last one is new, custom for Cinnabar Volcano
WaterTile:
	db $14
	db $ff ; terminator

; reloads map view and processes sprite data
; for items that cause the overworld to be displayed
ItemUseReloadOverworldData:
	call LoadCurrentMapView
	jp UpdateSprites

; creates a list at wBuffer of maps where the mon in [wd11e] can be found.
; this is used by the pokedex to display locations the mon can be found on the map.
FindWildLocationsOfMon:
	ld hl, WildDataPointers
; new for sevii
	CheckEvent EVENT_IN_SEVII
	jr z, .continue
	ld hl, WildDataPointers_Sevii
.continue
; back to vanilla
	ld de, wBuffer
	ld c, $0
.loop
	inc hl
	ld a, [hld]
	inc a
	jr z, .done
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hli]
	and a
	call nz, CheckMapForMon ; land
	ld a, [hli]
	and a
	call nz, CheckMapForMon ; water
	pop hl
	inc hl
	inc hl
	inc c
	jr .loop
.done
	ld a, $ff ; list terminator
	ld [de], a
	ret

CheckMapForMon:
	inc hl
	ld b, NUM_WILDMONS
.loop
	ld a, [wd11e]
	cp [hl]
	jr nz, .nextEntry
	ld a, c
	ld [de], a
	inc de
; new, to make this function more efficient and fix the Tentacool bug
	inc hl
	ret
; back to vanilla
.nextEntry
	inc hl
	inc hl
	dec b
	jr nz, .loop
	dec hl
	ret

PerfecterHasBeenUsedText: ; new
	text_far _PerfecterHasBeenUsedText
	text_end

ChromogeneHasBeenUsedText: ; new
	text_far _ChromogeneHasBeenUsedText
	text_end
