Route22_Script:
; new
	ld hl, wCurrentMapScriptFlags
	bit 6, [hl]
	res 6, [hl]
	call nz, Handle2ndRivalBattle
	ld hl, wCurrentMapScriptFlags
	bit 4, [hl]
	res 4, [hl]
	call nz, Handle2ndRivalBattle
; back to vanilla
	call EnableAutoTextBoxDrawing
	ld hl, Route22_ScriptPointers
	ld a, [wCurMapScript] ; edited
	jp CallFunctionInTable

Handle2ndRivalBattle: ; new
	CheckEvent EVENT_2ND_ROUTE22_RIVAL_BATTLE_BEATEN
	ret nz ; do nothing if we already beaten the 2nd R22 rival
	callfar CountHowManyBadges ; d=#badges
	ld a, d
	cp 8
	ret nz ; do nothing if we don't have 8 badges
	ld a, HS_ROUTE_22_RIVAL_2
	ld [wMissableObjectIndex], a
	predef ShowObject
	SetEvents EVENT_2ND_ROUTE22_RIVAL_BATTLE, EVENT_ROUTE22_RIVAL_WANTS_BATTLE ; set up the vanilla event flags if we have 8 badges
	ret

Route22_ScriptPointers:
	dw Route22Script0
	dw Route22Script1
	dw Route22Script2
	dw Route22Script3
	dw Route22Script4
	dw Route22Script5
	dw Route22Script6
	dw Route22Script7

Route22Script_50ece:
Route22Script7:
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
;Route22Script7:
	ret

Route22Script_50ed6:
	ld a, OPP_RIVAL1
	ld [wCurOpponent], a
	ld a, $2
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	ret

Route22Script_50ee1:
	ld a, OPP_RIVAL2
	ld [wCurOpponent], a
	ld a, $4				; edited
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	ret

Route22MoveRivalSprite:
	ld de, Route22RivalMovementData
	ld a, [wcf0d]
	cp $1
	jr z, .asm_50ef1
	inc de
.asm_50ef1
	call MoveSprite
	ld a, SPRITE_FACING_RIGHT
	ldh [hSpriteFacingDirection], a
	jp SetSpriteFacingDirectionAndDelay

Route22RivalMovementData:
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db -1 ; end

Route22Script0:
	CheckEvent EVENT_ROUTE22_RIVAL_WANTS_BATTLE
	ret z
	ld hl, .Route22RivalBattleCoords
	call ArePlayerCoordsInArray
	ret nc
	ld a, [wCoordIndex]
	ld [wcf0d], a
	xor a
	ldh [hJoyHeld], a
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, PLAYER_DIR_LEFT
	ld [wPlayerMovingDirection], a
	CheckEvent EVENT_1ST_ROUTE22_RIVAL_BATTLE
	jr nz, .firstRivalBattle
	CheckEventReuseA EVENT_2ND_ROUTE22_RIVAL_BATTLE ; is this the rival at the end of the game?
	jp nz, Route22Script_5104e
	ret

.Route22RivalBattleCoords
	dbmapcoord 29,  8 ; edited
	dbmapcoord 29,  9 ; edited
	db -1 ; end

.firstRivalBattle
	ld a, $1
	ld [wEmotionBubbleSpriteIndex], a
	xor a ; EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
	ld a, [wWalkBikeSurfState]
	and a
	jr z, .asm_50f4e
	call StopAllMusic
.asm_50f4e
	ld c, BANK(Music_MeetRival)
	ld a, MUSIC_MEET_RIVAL
	call PlayMusic
	ld a, $1
	ldh [hSpriteIndex], a
	call Route22MoveRivalSprite
	ld a, $1
	ld [wCurMapScript], a
	ret

Route22Script1:
	ld a, [wd730]
	bit 0, a
	ret nz
	ld a, [wcf0d]
	cp $1
	jr nz, .asm_50f78
	ld a, PLAYER_DIR_DOWN
	ld [wPlayerMovingDirection], a
	ld a, SPRITE_FACING_UP
	jr .asm_50f7a
.asm_50f78
	ld a, SPRITE_FACING_RIGHT
.asm_50f7a
	ldh [hSpriteFacingDirection], a
	ld a, $1
	ldh [hSpriteIndex], a
	call SetSpriteFacingDirectionAndDelay
	xor a
	ld [wJoyIgnore], a
	ld a, $1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, Route22RivalDefeatedText1
	ld de, Route22Text_511bc
	call SaveEndBattleTextPointers
	call Route22Script_50ed6
	ld a, $2
	ld [wCurMapScript], a
	ret

Route22RivalDefeatedText1:
	text_far _Route22RivalDefeatedText1
	text_end

Route22Text_511bc:
	text_far _Route22Text_511bc
	text_end

Route22Script2:
	ld a, [wIsInBattle]
	cp $ff
	jp z, Route22Script_50ece
	xor a							; new, to go beyond 200
	ld [wIsTrainerBattle], a		; new, to go beyond 200
	ld a, [wSpritePlayerStateData1FacingDirection]
	and a ; cp SPRITE_FACING_DOWN
	jr nz, .notDown
	ld a, SPRITE_FACING_UP
	jr .done
.notDown
	ld a, SPRITE_FACING_RIGHT
.done
	ldh [hSpriteFacingDirection], a
	ld a, $1
	ldh [hSpriteIndex], a
	call SetSpriteFacingDirectionAndDelay
	ld a, $f0
	ld [wJoyIgnore], a
	SetEvent EVENT_BEAT_ROUTE22_RIVAL_1ST_BATTLE
	ld a, $1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call StopAllMusic
	farcall Music_RivalAlternateStart
	ld a, [wcf0d]
	cp $1
	jr nz, .asm_50fff
	call Route22Script_51008
	jr .asm_51002
.asm_50fff
	call Route22Script_5100d
.asm_51002
	ld a, $3
	ld [wCurMapScript], a
	ret

Route22Script_51008:
	ld de, Route22RivalExitMovementData1
	jr Route22MoveRival1

Route22Script_5100d:
	ld de, Route22RivalExitMovementData2
Route22MoveRival1:
	ld a, $1
	ldh [hSpriteIndex], a
	jp MoveSprite

Route22RivalExitMovementData1:
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

Route22RivalExitMovementData2:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

Route22Script3:
	ld a, [wd730]
	bit 0, a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, HS_ROUTE_22_RIVAL_1
	ld [wMissableObjectIndex], a
	predef HideObject
	call PlayDefaultMusic
	ResetEvents EVENT_1ST_ROUTE22_RIVAL_BATTLE, EVENT_ROUTE22_RIVAL_WANTS_BATTLE
	ld a, $0
	ld [wCurMapScript], a
	ret

Route22Script_5104e:
	ld a, $2
	ld [wEmotionBubbleSpriteIndex], a
	xor a ; EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
	ld a, [wWalkBikeSurfState]
	and a
	jr z, .skipYVisibilityTesta
	call StopAllMusic
.skipYVisibilityTesta
	call StopAllMusic
	farcall Music_RivalAlternateTempo
	ld a, $2
	ldh [hSpriteIndex], a
	call Route22MoveRivalSprite
	ld a, $4
	ld [wCurMapScript], a
	ret

Route22Script4:
	ld a, [wd730]
	bit 0, a
	ret nz
	ld a, $2
	ldh [hSpriteIndex], a
	ld a, [wcf0d]
	cp $1
	jr nz, .asm_510a1
	ld a, PLAYER_DIR_DOWN
	ld [wPlayerMovingDirection], a
	ld a, SPRITE_FACING_UP
	jr .asm_510a8
.asm_510a1
	ld a, PLAYER_DIR_LEFT
	ld [wPlayerMovingDirection], a
	ld a, SPRITE_FACING_RIGHT
.asm_510a8
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	xor a
	ld [wJoyIgnore], a
	ld a, $2
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, Route22RivalDefeatedText2
	ld de, Route22Text_511d0
	call SaveEndBattleTextPointers
	call Route22Script_50ee1
	ld a, $5
	ld [wCurMapScript], a
	ret

Route22RivalDefeatedText2:
	text_far _Route22RivalDefeatedText2
	text_end

Route22Text_511d0:
	text_far _Route22Text_511d0
	text_end

Route22Script5:
	ld a, [wIsInBattle]
	cp $ff
	jp z, Route22Script_50ece
	xor a								; new, to go beyond 200
	ld [wIsTrainerBattle], a			; new, to go beyond 200
	ld a, $2
	ldh [hSpriteIndex], a
	ld a, [wcf0d]
	cp $1
	jr nz, .asm_510fb
	ld a, PLAYER_DIR_DOWN
	ld [wPlayerMovingDirection], a
	ld a, SPRITE_FACING_UP
	jr .asm_51102
.asm_510fb
	ld a, PLAYER_DIR_LEFT
	ld [wPlayerMovingDirection], a
	ld a, SPRITE_FACING_RIGHT
.asm_51102
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	ld a, $f0
	ld [wJoyIgnore], a
	SetEvent EVENT_BEAT_ROUTE22_RIVAL_2ND_BATTLE
; new
	ld a, HS_LUNAR_SHRINE_TOURIST_1
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
; back to vanilla
	ld a, $2
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call StopAllMusic
	farcall Music_RivalAlternateStartAndTempo
	ld a, [wcf0d]
	cp $1
	jr nz, .asm_51134
	call Route22Script_5113d
	jr .asm_51137
.asm_51134
	call Route22Script_51142
.asm_51137
	ld a, $6
	ld [wCurMapScript], a
	ret

Route22Script_5113d:
	ld de, MovementData_5114c
	jr Route22MoveRival2

Route22Script_51142:
	ld de, MovementData_5114d
Route22MoveRival2:
	ld a, $2
	ldh [hSpriteIndex], a
	jp MoveSprite

MovementData_5114c:
	db NPC_MOVEMENT_LEFT
MovementData_5114d:
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_LEFT
	db -1 ; end

Route22Script6:
	ld a, [wd730]
	bit 0, a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, HS_ROUTE_22_RIVAL_2
	ld [wMissableObjectIndex], a
	predef HideObject
	call PlayDefaultMusic
	ResetEvents EVENT_2ND_ROUTE22_RIVAL_BATTLE, EVENT_ROUTE22_RIVAL_WANTS_BATTLE
	SetEvent EVENT_2ND_ROUTE22_RIVAL_BATTLE_BEATEN ; new
	ld a, $7
	ld [wCurMapScript], a
	ret

Route22_TextPointers:
	dw Route22Text1
	dw Route22Text2
	dw Route22CoinCaseMeowthText ; new, Coin-Case Meowth
	dw PickUpItemText ; new
	dw Route22RandomizedPokemonGiverText ; new
	dw Route22FrontGateText

Route22Text1:
	text_asm
	farcall Func_f1b27
	jp TextScriptEnd

Route22Text2:
	text_asm
	farcall Func_f1b47
	jp TextScriptEnd

Route22FrontGateText: ; edited
	text_far _Route22FrontGateText
	text_end

; new =============================================

Route22CoinCaseMeowthText:
	text_far _Route30CoinCaseMeowthText_Miao
	text_asm
	ld a, MEOWTH
	call PlayCry
	call WaitForSoundToFinish
	call WaitForTextScrollButtonPress
	
	call GBFadeOutToBlack

	ld a, HS_ROUTE_22_COIN_CASE_MEOWTH
	ld [wMissableObjectIndex], a
	predef HideObject

	SetEvent EVENT_GOT_COIN_CASE

	xor a
	ldh [hUnusedCoinsByte], a
	ldh [hCoins], a
	ld a, $10
	ldh [hCoins + 1], a
	ld de, wPlayerCoins + 1
	ld hl, hCoins + 1
	ld c, $2
	predef AddBCDPredef
	
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack

	ld hl, ReceivedCoinCaseText
	call PrintText

	ld hl, CoinCaseStillHasCoinsText
	call PrintText

	ld hl, CoinCaseExplanationText
	call PrintText

	jp TextScriptEnd

ReceivedCoinCaseText:
	text_far _ReceivedCoinCaseText
	sound_get_key_item
	text_end

CoinCaseStillHasCoinsText:
	text_far _CoinCaseStillHasCoinsText
	text_end

CoinCaseExplanationText:
	text_far _CoinCaseExplanationText
	text_end

; new =============================================

Route22RandomizedPokemonGiverText:
	text_asm

; did we receive already the 2nd randomized mon?
	CheckEvent EVENT_RECEIVED_RANDOMIZED_POKEMON_2
	ld hl, Route22RandomizedPokemonGiverText_NothingMore
	jp nz, .printAndEnd

; did we receive the 1st?
	CheckEvent EVENT_RECEIVED_RANDOMIZED_POKEMON_1
	jr z, .giveRandomizedMon1

; we received the first, but not the second
; check if we are able: beat MISSINGNO and TRAVELER
	CheckEvent EVENT_DEFEATED_MISSINGNO
	ld hl, Route22RandomizedPokemonGiverText_NotReadyForSecond
	jp z, .printAndEnd
	CheckEvent EVENT_BEAT_INTERDIMENSIONAL_TRAVELER
	ld hl, Route22RandomizedPokemonGiverText_NotReadyForSecond
	jp z, .printAndEnd
; we are ready to receive the second random mon

.RNGLoopType1_2
	call Random
	cp 18
	jr nc, .RNGLoopType1_2
	ld hl, ListTypes
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wRandomizedMon2_Type1], a

	ld hl, Route22RandomizedPokemonGiverText_IntroSecond
	call PrintText

.RNGLoopType2_2
	call Random
	cp 18
	jr nc, .RNGLoopType2_2
	ld hl, ListTypes
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wRandomizedMon2_Type2], a

	ld hl, Route22RandomizedPokemonGiverText_AreYouSure
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ld hl, Route22RandomizedPokemonGiverText_ComeBackWhenReady
	jr nz, .printAndEnd

.RNGLoopPokemon_2
; generate a random number between 0 and len(ListBasePokemon_OnlyLegendaries)-1
	call Random
	cp 14 ; 13+1
	jr nc, .RNGLoopPokemon_2
; a contains a valid number, now we need to access the a-th element of the list we decided about earlier
	ld hl, ListBasePokemon_OnlyLegendaries
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld b, a

	SetEvent EVENT_GIVING_RANDOM_MON
	ld c, 95
	call GivePokemon ; pokemon b at level c
	SetEvent EVENT_RECEIVED_RANDOMIZED_POKEMON_2
	jr .conclude

.giveRandomizedMon1 ; -------------------

.RNGLoopType1
	call Random
	cp 18
	jr nc, .RNGLoopType1
	ld hl, ListTypes
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wRandomizedMon1_Type1], a
	
	ld hl, Route22RandomizedPokemonGiverText_IntroFirst
	call PrintText

.RNGLoopType2
	call Random
	cp 18
	jr nc, .RNGLoopType2
	ld hl, ListTypes
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wRandomizedMon1_Type2], a

	ld hl, Route22RandomizedPokemonGiverText_AreYouSure
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ld hl, Route22RandomizedPokemonGiverText_ComeBackWhenReady
	jr nz, .printAndEnd

.RNGLoopPokemon
; generate a random number between 0 and len(ListBasePokemon_NoLegendaries)-1
	call Random
	cp 72 ; 71+1
	jr nc, .RNGLoopPokemon
; a contains a valid number, now we need to access the a-th element of the list we decided about earlier
	ld hl, ListBasePokemon_NoLegendaries
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld b, a

	SetEvent EVENT_GIVING_RANDOM_MON
	ld c, 5
	call GivePokemon ; pokemon b at level c
	SetEvent EVENT_RECEIVED_RANDOMIZED_POKEMON_1
.conclude
	ld hl, Route22RandomizedPokemonGiverText_Enjoy
.printAndEnd
	call PrintText
	jp TextScriptEnd


Route22RandomizedPokemonGiverText_Enjoy:
	text_far _Route22RandomizedPokemonGiverText_Enjoy
	text_end

Route22RandomizedPokemonGiverText_NotReadyForSecond:
	text_far _Route22RandomizedPokemonGiverText_NotReadyForSecond
	text_end

Route22RandomizedPokemonGiverText_NothingMore:
	text_far _Route22RandomizedPokemonGiverText_NothingMore
	text_end

Route22RandomizedPokemonGiverText_IntroFirst:
	text_far _Route22RandomizedPokemonGiverText_IntroFirst
	text_end

Route22RandomizedPokemonGiverText_IntroSecond:
	text_far _Route22RandomizedPokemonGiverText_IntroSecond
	text_end

Route22RandomizedPokemonGiverText_AreYouSure:
	text_far _Route22RandomizedPokemonGiverText_AreYouSure
	text_end

Route22RandomizedPokemonGiverText_ComeBackWhenReady:
	text_far _Route22RandomizedPokemonGiverText_ComeBackWhenReady
	text_end
	
ListTypes: ; 18: [0,17]
	db NORMAL
	db FIGHTING
	db FLYING
	db POISON
	db GROUND
	db ROCK
	db BUG
	db GHOST
	db STEEL
	db FIRE
	db WATER
	db GRASS
	db ELECTRIC
	db PSYCHIC_TYPE
	db ICE
	db DRAGON
	db DARK
	db FAIRY
	db -1

ListBasePokemon_NoLegendaries: ; 72: [0,71]
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
	db FARFETCHD ; base & fully
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
	db PINSIR ; base & fully
	db TAUROS ; base & fully
	db MAGIKARP
	db LAPRAS ; base & fully
	db DITTO ; base & fully
	db EEVEE
	db PORYGON
	db OMANYTE
	db KABUTO
	db AERODACTYL ; base & fully
	db MUNCHLAX
	db DRATINI
	db -1

ListBasePokemon_OnlyLegendaries: ; 14: [0,13]
	db MEW
	db VENUSTOISE
	db MELMETAL
	db THU_FI_ZER
	db ARM_MEWTWO
	db ARTICUNO
	db ZAPDOS
	db MOLTRES
	db MZYGARDE
	db UNECROZMA
	db MRAYQUAZA
	db EETERNATUS
	db ARCEUS
	db MISSINGNO
	db -1

/*
BUTTERFREE
WIGGLYTUFF
PARASECT
VENOMOTH
GOLDUCK
FARFETCHD
DEWGONG
MUK
HYPNO
KINGLER
ELECTRODE
MAROWAK
WEEZING
SEAKING
DITTO

RATICATE
FEAROW
ARBOK
SANDSLASH
NINETALES
CROBAT
VILEPLUME
ARCANINE
POLIWRATH
GOLEM
RAPIDASH
DODRIO
HITMONLEE
LICKILICKY
MR_MIME

OMASTAR
KABUTOPS
TENTACRUEL
SLOWKING
CLOYSTER
TANGROWTH
KLEAVOR
ELECTIVIRE
MAGMORTAR
NIDOQUEEN
NIDOKING
DUGTRIO
PERSIAN
ANNIHILAPE
MAGNEZONE
EXEGGUTOR
RHYPERIOR
BLISSEY
KINGDRA
JYNX
TAUROS
LAPRAS
SNORLAX
VAPOREON
PORYGONZ
MACHAMP

PINSIR
BEEDRILL
CLEFABLE
AERODACTYL
VENUSAUR
CHARIZARD
BLASTOISE
ALAKAZAM
SLOWBRO
GENGAR
STEELIX
STARMIE
GYARADOS
DRAGONITE
PIDGEOT
RAICHU
KANGASKHAN
VICTREEBEL
SCIZOR


MEW
VENUSTOISE
MELMETAL
THU_FI_ZER
MEWTWO
ARTICUNO
ZAPDOS
MOLTRES

MZYGARDE
UNECROZMA
MRAYQUAZA
EETERNATUS
ARCEUS

MISSINGNO
*/
