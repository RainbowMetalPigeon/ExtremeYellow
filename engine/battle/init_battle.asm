InitBattle::
	ld a, [wCurOpponent]
	and a
	jr z, DetermineWildOpponent

InitOpponent:
	ld a, [wCurOpponent]
	ld [wcf91], a
	ld [wEnemyMonSpecies2], a
	jr InitBattleCommon

DetermineWildOpponent:
	ld a, [wd732]
	bit 1, a
	jr z, .notDebug
	ldh a, [hJoyHeld]
	bit BIT_B_BUTTON, a
	ret nz
.notDebug
	ld a, [wNumberOfNoRandomBattleStepsLeft]
	and a
	ret nz
	callfar TryDoWildEncounter
	ret nz
InitBattleCommon:
	ld a, [wMapPalOffset]
	push af
	ld hl, wLetterPrintingDelayFlags
	ld a, [hl]
	push af
	res 1, [hl]
	call InitBattleVariables
	ld a, [wIsTrainerBattle]	; new to go beyond 200
	and a						; new to go beyond 200
	jp z, InitWildBattle		; new to go beyond 200
	ld a, [wEnemyMonSpecies2]
	sub OPP_ID_OFFSET           ; still relevant?
;	jp c, InitWildBattle		; commented to go beyond 200
	ld [wTrainerClass], a
	callfar GetTrainerInformation ; edited because moved out of home
; new, to handle Copycat's full copy team
	ld a, [wCurMap]
	cp COPYCATS_HOUSE_1F
	jr nz, .normalReading
	CheckEvent EVENT_GOT_TM31
	jr z, .normalReading
	callfar ReadTrainer_CopyPlayersTeam
	jr .continueFromCopycat
.normalReading
	callfar ReadTrainer
.continueFromCopycat
; back to vanilla
	callfar DoBattleTransitionAndInitBattleVariables
	call _LoadTrainerPic
	xor a
	ld [wEnemyMonSpecies2], a
	ldh [hStartTileID], a
	dec a
	ld [wAICount], a
	hlcoord 12, 0
	predef CopyUncompressedPicToTilemap
	ld a, $ff
	ld [wEnemyMonPartyPos], a
	ld a, $2
	ld [wIsInBattle], a

; Is this a major story battle?
	ld a, [wLoneAttackNo]
	and a
	jp z, _InitBattleCommon
	callabd_ModifyPikachuHappiness PIKAHAPPY_GYMLEADER ; useless since already in bank3d
	jp _InitBattleCommon

InitWildBattle:
	ld a, $1
	ld [wIsInBattle], a
	callfar LoadEnemyMonData
	callfar DoBattleTransitionAndInitBattleVariables
	ld a, [wCurOpponent]
	cp RESTLESS_SOUL
	jr z, .isGhost
	callfar IsGhostBattle
	jp nz, .isNoGhost
.isGhost
; new, to handle Haunted House
	callfar IsCurrentMapHauntedHouse
	jp nz, .vanilla
	call Random
	cp 85
	jr nc, .notFossilAerodactyl
; load Fossil Aerodactyl info
	ld hl, wMonHSpriteDim
	ld a, $77
	ld [hli], a   ; write sprite dimensions
	ld bc, FossilAerodactylPic
	ld a, c
	ld [hli], a   ; write front sprite pointer
	ld [hl], b
	ld hl, wEnemyMonNick  ; set name to "FOSSIL A."
	ld a, "F"
	ld [hli], a
	ld a, "O"
	ld [hli], a
	ld a, "S"
	ld [hli], a
	ld a, "S"
	ld [hli], a
	ld a, "I"
	ld [hli], a
	ld a, "L"
	ld [hli], a
	ld a, " "
	ld [hli], a
	ld a, "A"
	ld [hli], a
	ld a, "."
	ld [hli], a
	ld [hl], "@"
	ld a, [wcf91]
	push af
	ld a, FOSSIL_AERODACTYL
	ld [wcf91], a
	ld de, vFrontPic
	call LoadMonFrontSprite ; load fossil sprite
	pop af
	ld [wcf91], a
	jp .spriteLoaded
.notFossilAerodactyl ; if not Fossil Aerodactyl, check if Fossil Kabutops or Ghost
	cp 170
	jr nc, .vanilla
; load Fossil Kabutops info
	ld hl, wMonHSpriteDim
	ld a, $66
	ld [hli], a   ; write sprite dimensions
	ld bc, FossilKabutopsPic
	ld a, c
	ld [hli], a   ; write front sprite pointer
	ld [hl], b
	ld hl, wEnemyMonNick  ; set name to "FOSSIL K."
	ld a, "F"
	ld [hli], a
	ld a, "O"
	ld [hli], a
	ld a, "S"
	ld [hli], a
	ld a, "S"
	ld [hli], a
	ld a, "I"
	ld [hli], a
	ld a, "L"
	ld [hli], a
	ld a, " "
	ld [hli], a
	ld a, "K"
	ld [hli], a
	ld a, "."
	ld [hli], a
	ld [hl], "@"
	ld a, [wcf91]
	push af
	ld a, FOSSIL_KABUTOPS
	ld [wcf91], a
	ld de, vFrontPic
	call LoadMonFrontSprite ; load fossil sprite
	pop af
	ld [wcf91], a
	jr .spriteLoaded
.vanilla ; load Ghost info
; back to vanilla
	ld hl, wMonHSpriteDim
	ld a, $66
	ld [hli], a   ; write sprite dimensions
	ld bc, GhostPic
	ld a, c
	ld [hli], a   ; write front sprite pointer
	ld [hl], b
	ld hl, wEnemyMonNick  ; set name to "GHOST"
	ld a, "G"
	ld [hli], a
	ld a, "H"
	ld [hli], a
	ld a, "O"
	ld [hli], a
	ld a, "S"
	ld [hli], a
	ld a, "T"
	ld [hli], a
	ld [hl], "@"
	ld a, [wcf91]
	push af
	ld a, MON_GHOST
	ld [wcf91], a
	ld de, vFrontPic
	call LoadMonFrontSprite ; load ghost sprite
	pop af
	ld [wcf91], a
	jr .spriteLoaded
.isNoGhost
	ld de, vFrontPic
	call LoadMonFrontSprite ; load mon sprite
.spriteLoaded
	xor a
	ld [wTrainerClass], a
	ldh [hStartTileID], a
	hlcoord 12, 0
	predef CopyUncompressedPicToTilemap

; common code that executes after init battle code specific to trainer or wild battles
_InitBattleCommon:
	ld b, SET_PAL_BATTLE_BLACK
	call RunPaletteCommand
	callfar SlidePlayerAndEnemySilhouettesOnScreen
	xor a
	ldh [hAutoBGTransferEnabled], a
	ld hl, .emptyString
	call PrintText
	call SaveScreenTilesToBuffer1
	call ClearScreen
	ld a, $98
	ldh [hAutoBGTransferDest + 1], a
	ld a, $1
	ldh [hAutoBGTransferEnabled], a
	call Delay3
	ld a, $9c
	ldh [hAutoBGTransferDest + 1], a
	call LoadScreenTilesFromBuffer1
	hlcoord 9, 7
	lb bc, 5, 10
	call ClearScreenArea
	hlcoord 1, 0
	lb bc, 4, 10
	call ClearScreenArea
	call ClearSprites
	ld a, [wIsInBattle]
	dec a ; is it a wild battle?
	ld hl, DrawEnemyHUDAndHPBar
	ld b, BANK(DrawEnemyHUDAndHPBar)
	call z, Bankswitch ; draw enemy HUD and HP bar if it's a wild battle
	callfar StartBattle
	callfar EndOfBattle
	pop af
	ld [wLetterPrintingDelayFlags], a
	pop af
	ld [wMapPalOffset], a
	ld a, [wSavedTileAnimations]
	ldh [hTileAnimations], a
	scf
	ret
.emptyString
	db "@"

_LoadTrainerPic:
; wd033-wd034 contain pointer to pic
	ld a, [wTrainerPicPointer]
	ld e, a
	ld a, [wTrainerPicPointer + 1]
	ld d, a ; de contains pointer to trainer pic
	        ; but we perform a number of checks down there to see if it needs to be overwritten
	ld a, [wLinkState]
	and a
	jp nz, .playerLikeSprite ; new

	; new, random picture selection between the 4 "color names" for Battle Facility trainer
	ld a, [wTrainerClass]
	cp BF_TRAINER
	jr nz, .notMultiSpriteTrainer
	ld a, [wBattleFacilityOpponentTrainerSprite] ; edited
	cp 0
	jr z, .randomNumber0
	cp 1
	jr z, .randomNumber1
	cp 2
	jr z, .randomNumber2
	; cp 3 is redundant
	ld a, BANK(GreenPicFront)
	ld de, GreenPicFront
	jp .loadSprite
.randomNumber0
	ld a, BANK(Rival3Pic)
	ld de, Rival3Pic
	jp .loadSprite
.randomNumber1
	ld a, BANK(RedPicFront)
	ld de, RedPicFront
	jp .loadSprite
.randomNumber2
	ld a, BANK(YellowPicFront)
	ld de, YellowPicFront
	jp .loadSprite
.notMultiSpriteTrainer ; new

/*
; now check if it's one of the Rocket Admins
	ld a, [wTrainerClass]
	cp ROCKET
	jr nz, .notAdmin
	ld a, [wTrainerNo]
	cp $33 ; edited, for the Rocket executives
	jr c, .notAdmin
	cp $37 ; for the Rocket siblings in Lunar Shrine
	jr nc, .notAdmin
	cp $35
	ld a, BANK(RocketAdminFPic) ; M and F are in the same bank
	jr z, .Ariana
	; not Ariana
	ld de, RocketAdminMPic
	jp .loadSprite
.Ariana
	ld de, RocketAdminFPic
	jr .loadSprite
.notAdmin
*/

; now check if it's one of the special COOLTRAINER (pseudo manga protagonists)
	ld a, [wTrainerClass] ; this is unnecessary, isn't it?
	cp COOLTRAINER
	jr nz, .notPseudoMangaProtagonists
	ld a, [wTrainerNo]
	cp 64 ; pseudo-Green
	jr z, .pseudoGreen
	cp 65 ; pseudo-Red
	jr z, .pseudoRed
	cp 67 ; pseudo-Yellow
	jr z, .pseudoYellow
	cp 66 ; pseudo-Blue
	jr z, .pseudoBlue
	jr .notPseudoMangaProtagonists
.pseudoGreen
	ld a, BANK(GreenPicFront)
	ld de, GreenPicFront
	jr .loadSprite
.pseudoRed
	ld a, BANK(RedPicFront)
	ld de, RedPicFront
	jr .loadSprite
.pseudoYellow
	ld a, BANK(YellowPicFront)
	ld de, YellowPicFront
	jr .loadSprite
.pseudoBlue
	ld a, BANK(Rival3Pic)
	ld de, Rival3Pic
	jr .loadSprite
.notPseudoMangaProtagonists

; now check if it's Copycat battle
	ld a, [wCurMap]
	cp COPYCATS_HOUSE_1F
	jr nz, .notCopycat
	ld a, [wPlayerGender] ; 00 = male, 01 = female, 02 = enby
	and a ; = cp 0
	jr z, .maleTrainerPic
	cp 1
	jr z, .femaleTrainerPic
	ld a, BANK(YellowPicFront)
	ld de, YellowPicFront
	jr .loadSprite
.femaleTrainerPic
	ld a, BANK(GreenPicFront)
	ld de, GreenPicFront
	jr .loadSprite
.maleTrainerPic
	ld a, BANK(RedPicFront)
	ld de, RedPicFront
	jr .loadSprite
.notCopycat

; now check if it's one of the trainers that need bank "Pics 6b" but is otherwise normally handled
; this means from DIVER to TRAVELER (but it requires a double check) and MISSINGNO_T
	ld a, [wTrainerClass]
	cp DIVER
	jr c, .notNewNormalClasses
; now check if it's rematch vs Traveler
	cp TRAVELER
	jr nz, .notTraveler
	ld a, [wTrainerNo]
	cp 2 ; second team, rematch
	jr nz, .notTraveler ; if not the rematch, load default (5-ball) pic normally
	ld de, Traveler2Pic
.notTraveler
	ld a, BANK("Pics 6b") ; non-vanilla trainers' pics
	jr .loadSprite
.notNewNormalClasses
; back to normal code

	ld a, BANK("Pics 6") ; this is where all the vanilla trainer pics are (not counting Red's)
	jr .loadSprite ; edited
.playerLikeSprite ; new
	ld a, BANK(RedPicFront)
.loadSprite
	call UncompressSpriteFromDE
	ld de, vFrontPic
	ld a, $77
	ld c, a
	jp LoadUncompressedSpriteData

LoadMonBackPic:
; Assumes the monster's attributes have
; been loaded with GetMonHeader.
; new, to scramble sprites if MissingNo is in the team, except MissingNo's itself
	ld d, MISSINGNO
	callfar CheckIfOneGivenMonIsInParty ; carry flag if yes
	ld a, 0
	jr nc, .noMissingNo
; MissingNo is in the team: is the active mon MISSINGNO itself?
	ld a, [wBattleMonSpecies]
	cp MISSINGNO
	ld a, 0
; if yes, don't scramble its backsprite
	jr z, .noMissingNo
; otherwise, scramble it
	ld a, 1
.noMissingNo
	ld [wSpriteFlipped], a
; back to vanilla
	ld a, [wBattleMonSpecies]
	ld [wcf91], a
	hlcoord 1, 5
	lb bc, 7, 8
	call ClearScreenArea
	ld hl, wMonHBackSprite - wMonHeader
	call UncompressMonSprite
	predef ScaleSpriteByTwo
	ld de, vBackPic
	call InterlaceMergeSpriteBuffers ; combine the two buffers to a single 2bpp sprite
	ld hl, vSprites
	ld de, vBackPic
	ld c, (2*SPRITEBUFFERSIZE)/16 ; count of 16-byte chunks to be copied
	ldh a, [hLoadedROMBank]
	ld b, a
	jp CopyVideoData

; animates the mon "growing" out of the pokeball
AnimateSendingOutMon:
	ld a, [wPredefHL]
	ld h, a
	ld a, [wPredefHL + 1]
	ld l, a
	ldh a, [hStartTileID]
	ldh [hBaseTileID], a
	ld b, $4c
; new, to handle mid-battle evolution
	ld a, [wIsEvolvingMidBattle]
	and a
	jr nz, .notInBattle
; back to vanilla
	ld a, [wIsInBattle]
	and a
	jr z, .notInBattle
	add b
	ld [hl], a
	call Delay3
	ld bc, -(SCREEN_WIDTH * 2 + 1)
	add hl, bc
	ld a, 1
	ld [wDownscaledMonSize], a
	lb bc, 3, 3
	predef CopyDownscaledMonTiles
	ld c, 4
	call DelayFrames
	ld bc, -(SCREEN_WIDTH * 2 + 1)
	add hl, bc
	xor a
	ld [wDownscaledMonSize], a
	lb bc, 5, 5
	predef CopyDownscaledMonTiles
	ld c, 5
	call DelayFrames
	ld bc, -(SCREEN_WIDTH * 2 + 1)
	jr .next
.notInBattle
	ld bc, -(SCREEN_WIDTH * 6 + 3)
.next
	add hl, bc
	ldh a, [hBaseTileID]
	add $31
	jr CopyUncompressedPicToHL

CopyUncompressedPicToTilemap:
	ld a, [wPredefHL]
	ld h, a
	ld a, [wPredefHL + 1]
	ld l, a
	ldh a, [hStartTileID]
CopyUncompressedPicToHL::
	lb bc, 7, 7
	ld de, SCREEN_WIDTH
	push af
	ld a, [wSpriteFlipped]
	and a
	jr nz, .flipped
	pop af
.loop
	push bc
	push hl
.innerLoop
	ld [hl], a
	add hl, de
	inc a
	dec c
	jr nz, .innerLoop
	pop hl
	inc hl
	pop bc
	dec b
	jr nz, .loop
	ret

.flipped
	push bc
	ld b, 0
	dec c
	add hl, bc
	pop bc
	pop af
.flippedLoop
	push bc
	push hl
.flippedInnerLoop
	ld [hl], a
	add hl, de
	inc a
	dec c
	jr nz, .flippedInnerLoop
	pop hl
	dec hl
	pop bc
	dec b
	jr nz, .flippedLoop
	ret
