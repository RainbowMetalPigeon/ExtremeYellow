SilphCo11F_Script:
	RPTextChooser SilphCo11F_TextPointers, SilphCo11F_TextPointers_Rocket
	call SilphCo11Script_HandleDoors
	call EnableAutoTextBoxDrawing
	ld hl, SilphCo11TrainerHeaders
	ld de, SilphCo11F_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

SilphCo11Script_HandleDoors:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
	call SilphCo11Script_HandleSpecialDoor ; new
	ld hl, SilphCo11GateCoords
	call SilphCo11Script_6214f
	call SilphCo11Script_6217b
	CheckEvent EVENT_SILPH_CO_11_UNLOCKED_DOOR
	ret nz
	ld a, $20
	ld [wNewTileBlockID], a
	lb bc, 6, 3
	predef ReplaceTileBlock
	ret

SilphCo11GateCoords:
	dbmapcoord  3,  6
	db -1 ; end

SilphCo11Script_6214f:
	push hl
	ld hl, wCardKeyDoorY
	ld a, [hli]
	ld b, a
	ld a, [hl]
	ld c, a
	xor a
	ldh [hUnlockedSilphCoDoors], a
	pop hl
.asm_62143
	ld a, [hli]
	cp $ff
	jr z, .asm_6215f
	push hl
	ld hl, hUnlockedSilphCoDoors
	inc [hl]
	pop hl
	cp b
	jr z, .asm_62154
	inc hl
	jr .asm_62143
.asm_62154
	ld a, [hli]
	cp c
	jr nz, .asm_62143
	ld hl, wCardKeyDoorY
	xor a
	ld [hli], a
	ld [hl], a
	ret
.asm_6215f
	xor a
	ldh [hUnlockedSilphCoDoors], a
	ret

SilphCo11Script_6217b:
	ldh a, [hUnlockedSilphCoDoors]
	and a
	ret z
	SetEvent EVENT_SILPH_CO_11_UNLOCKED_DOOR
	ret

SilphCo11Script_HandleSpecialDoor: ; new
	CheckEvent EVENT_BEAT_SILPH_CO_GIOVANNI
	ret nz
	ld a, $41
	ld [wNewTileBlockID], a
	lb bc, 4, 6
	predef_jump ReplaceTileBlock

SilphCo11Script_OpenSpecialDoor: ; new
	ld a, $03
	ld [wNewTileBlockID], a
	lb bc, 4, 6
	predef_jump ReplaceTileBlock

SilphCo11Script_ResetScripts:
	xor a
	ld [wJoyIgnore], a
SilphCo11Script_ScriptChanger:
	ld [wCurMapScript], a
	ret

SilphCo11F_ScriptPointers:
	dw SilphCo11Script0
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw SilphCo11Script3
	dw SilphCo11Script4
	dw SilphCo11Script5
	dw SilphCo11Script6
	dw SilphCo11Script7
	dw SilphCo11Script8
	dw SilphCo11Script9
	dw SilphCo11Script10
	dw SilphCo11Script11
	dw SilphCo11Script12
	dw SilphCo11Script13
	dw SilphCo11Script14
	; new for RP
	dw SilphCo11Script15 ; non-fight with JJ
	dw SilphCo11Script16 ; post-fight with Giovanni

SilphCo11Script0:
IF DEF(_DEBUG)
	call DebugPressedOrHeldB
	ret nz
ENDC
; new for RP
	CheckEvent EVENT_ROCKET_PATH
	jr z, .notRP
	CheckEvent EVENT_BEAT_SILPH_CO_11F_TRAINER_0
	call z, SilphCo11Script_TriggerJessieAndJames
	ret
.notRP
; BTV
	CheckEvent EVENT_BEAT_SILPH_CO_11F_TRAINER_0
	call z, SilphCo11Script_TriggerJessieAndJames
	CheckEvent EVENT_782
	ret nz
	CheckEvent EVENT_BEAT_SILPH_CO_GIOVANNI
	call z, SilphCo11Script_TriggerGiovanni
	ret

SilphCo11Script_TriggerGiovanni:
	ld hl, CoordsData_TriggerGiovanni
	call ArePlayerCoordsInArray
	jp nc, CheckFightingMapTrainers
	ld a, [wCoordIndex]
	ld [wcf0d], a
	xor a
	ldh [hJoyHeld], a
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, $3
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $3
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld de, MovementData_62216
	call MoveSprite
	ld a, $4
	call SilphCo11Script_ScriptChanger
	ret

CoordsData_TriggerGiovanni:
	dbmapcoord  6, 13
	dbmapcoord  7, 12
	db -1 ; end

MovementData_62216:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

SilphCo11Script_621ff:
	ld [wPlayerMovingDirection], a
	ld a, b
	ld [wSprite03StateData1FacingDirection], a
	ld a, $2
	ld [wSprite03StateData1MovementStatus], a
	ret

SilphCo11Script3:
	ld a, [wIsInBattle]
	cp $ff
	jp z, SilphCo11Script_ResetScripts
; we won
	ld a, [wcf0d]
	cp $1
	jr z, .asm_6223c
	ld a, PLAYER_DIR_LEFT
	ld b, SPRITE_FACING_RIGHT
	jr .asm_62240
.asm_6223c
	ld a, PLAYER_DIR_UP
	ld b, SPRITE_FACING_DOWN
.asm_62240
	call SilphCo11Script_621ff
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, 10 ; edited
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call GBFadeOutToBlack
	farcall SaffronCityHideRocketsShowCitizens
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
	SetEvent EVENT_BEAT_SILPH_CO_GIOVANNI
	call SilphCo11Script_OpenSpecialDoor ; new
	xor a
	ld [wJoyIgnore], a
	jp SilphCo11Script_ScriptChanger

SilphCo11Script4:
	ld a, [wd730]
	bit 0, a
	ret nz
	ld a, $3
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, [wcf0d]
	cp $1
	jr z, .asm_62284
	ld a, PLAYER_DIR_LEFT
	ld b, SPRITE_FACING_RIGHT
	jr .asm_62288
.asm_62284
	ld a, PLAYER_DIR_UP
	ld b, SPRITE_FACING_DOWN
.asm_62288
	call SilphCo11Script_621ff
	call Delay3
	xor a
	ld [wJoyIgnore], a
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, SilphCo10Text_62528
	ld de, SilphCo10Text_62528
	call SaveEndBattleTextPointers
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
	ld a, $3
	jp SilphCo11Script_ScriptChanger

SilphCo11Script_TriggerJessieAndJames:
	ld a, [wYCoord]
	cp $3
	ret nz
	ld a, [wXCoord]
	cp $4
	ret nc
	ResetEvents EVENT_780, EVENT_781
	ld a, [wXCoord]
	cp $3
	jr z, .asm_622c3
	SetEventReuseHL EVENT_780
	ld a, [wXCoord]
	cp $2
	jr z, .asm_622c3
	ResetEventReuseHL EVENT_780
	SetEventReuseHL EVENT_781
.asm_622c3
	call StopAllMusic
	ld c, BANK(Music_MeetJessieJames)
	ld a, MUSIC_MEET_JESSIE_JAMES
	call PlayMusic
	xor a
	ldh [hJoyHeld], a
	ld a, $fc
	ld [wJoyIgnore], a
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
; new for RP
	CheckEvent EVENT_ROCKET_PATH
	ld a, 10
	jr nz, .dialogueFound
	ld a, 11 ; edited
.dialogueFound
; BTV
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	xor a
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld a, $ff
	ld [wJoyIgnore], a
	SetEvent EVENT_782
	ld a, $5
	call SilphCo11Script_ScriptChanger
	ret

SilphCo11MovementData_622f5:
	db $5
	db $5
	db $5
	db $5
	db $5
	db $ff

SilphCo11MovementData_622fb:
	db $5
	db $5
	db $5
	db $5
	db $ff

SilphCo11MovementData_62300:
	db $5
	db $5
	db $5
	db $5
	db $ff

SilphCo11MovementData_62305:
	db $5
	db $5
	db $5
	db $5
	db $5
	db $ff

SilphCo11MovementData_6230b:
	db $5
	db $5
	db $6
	db $5
	db $5
	db $ff

SilphCo11MovementData_62311:
	db $5
	db $5
	db $5
	db $6
	db $5
	db $5
	db $ff

SilphCo11Script5:
	ld de, SilphCo11MovementData_622f5
	CheckEitherEventSet EVENT_780, EVENT_781
	and a
	jr z, .asm_6232d
	ld de, SilphCo11MovementData_62300
	cp $1
	jr z, .asm_6232d
	ld de, SilphCo11MovementData_6230b
.asm_6232d
	ld a, $4
	ldh [hSpriteIndexOrTextID], a
	call MoveSprite
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, $6
	call SilphCo11Script_ScriptChanger
	ret

SilphCo11Script6:
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, [wd730]
	bit 0, a
	ret nz
	; fallthrough
SilphCo11Script7:
	ld a, $2
	ld [wSprite04StateData1MovementStatus], a
	ld hl, wSprite04StateData1FacingDirection
	ld [hl], SPRITE_FACING_RIGHT
	CheckEitherEventSet EVENT_780, EVENT_781
	and a
	jr z, .asm_6235e
	ld [hl], SPRITE_FACING_UP
.asm_6235e
	call Delay3
	ld a, $fc
	ld [wJoyIgnore], a
	; fallthrough
SilphCo11Script8:
	ld de, SilphCo11MovementData_622fb
	CheckEitherEventSet EVENT_780, EVENT_781
	and a
	jr z, .asm_6237b
	ld de, SilphCo11MovementData_62305
	cp $1
	jr z, .asm_6237b
	ld de, SilphCo11MovementData_62311
.asm_6237b
	ld a, $6
	ldh [hSpriteIndexOrTextID], a
	call MoveSprite
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, $9
	call SilphCo11Script_ScriptChanger
	ret

SilphCo11Script9:
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, [wd730]
	bit 0, a
	ret nz
	ld a, $fc
	ld [wJoyIgnore], a
	; fallthrough
SilphCo11Script10:
	ld a, $2
	ld [wSprite06StateData1MovementStatus], a
	ld hl, wSprite06StateData1FacingDirection
	ld [hl], SPRITE_FACING_UP
	CheckEitherEventSet EVENT_780, EVENT_781
	and a
	jr z, .asm_623b1
	ld [hl], SPRITE_FACING_LEFT
.asm_623b1
	call Delay3
; new for RP
	CheckEvent EVENT_ROCKET_PATH
	jr z, .notRP
	ld a, 11
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, 15
	jp SilphCo11Script_ScriptChanger
.notRP
; BTV
	ld a, 12 ; edited
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	; fallthrough
SilphCo11Script11:
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, SilphCo11Text_624c2
	ld de, SilphCo11Text_624c2
	call SaveEndBattleTextPointers
	ld a, OPP_JESSIEJAMES ; edited
	ld [wCurOpponent], a
	ld a, 4 ; edited
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	xor a
	ldh [hJoyHeld], a
	ld [wJoyIgnore], a
	ld a, $c
	call SilphCo11Script_ScriptChanger
	ret

SilphCo11Script12:
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, [wIsInBattle]
	cp $ff
	jp z, SilphCo11Script_ResetScripts
; we won
	xor a                            ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	ld a, $2
	ld [wSprite04StateData1MovementStatus], a
	ld [wSprite06StateData1MovementStatus], a
	xor a
	ld [wSprite04StateData1FacingDirection], a
	ld [wSprite06StateData1FacingDirection], a
	ld a, $fc
	ld [wJoyIgnore], a
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld a, 13 ; edited
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	xor a
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	call StopAllMusic
	ld c, BANK(Music_MeetJessieJames)
	ld a, MUSIC_MEET_JESSIE_JAMES
	call PlayMusic
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, $d
	call SilphCo11Script_ScriptChanger
	ret

SilphCo11Script13:
	ld a, $ff
	ld [wJoyIgnore], a
	call GBFadeOutToBlack
	ld a, HS_SILPH_CO_11F_JAMES
	call SilphCo11Script_HideObject
	ld a, HS_SILPH_CO_11F_JESSIE
	call SilphCo11Script_HideObject
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
	ld a, $e
	call SilphCo11Script_ScriptChanger
	ret

SilphCo11Script14:
	call PlayDefaultMusic
	xor a
	ldh [hJoyHeld], a
	ld [wJoyIgnore], a
	ResetEvent EVENT_782
	SetEventReuseHL EVENT_BEAT_SILPH_CO_11F_TRAINER_0
	ld a, $0
	call SilphCo11Script_ScriptChanger
	ret

SilphCo11Script_6245e:
	ld [wMissableObjectIndex], a
	predef ShowObject
	call UpdateSprites
	call Delay3
	ret

SilphCo11Script_HideObject:
	ld [wMissableObjectIndex], a
	predef HideObject
	ret

SilphCo11F_TextPointers:
	dw SilphCo11Text1 ; President
	dw SilphCo11Text2 ; Secretary
	dw SilphCo11Text3 ; Giovanni
	dw SilphCo11Text4 ; James
	dw SilphCo11Text5 ; Rocket
	dw SilphCo11Text6 ; Jessie
	dw SilphCo11TextBadgeMachine ; new
	; signs
	dw SilphCo11SignText1 ; new
	dw SilphCo11SignText2 ; new
	; scripts
	dw SilphCo11Text7  ; 10 ; post-Battle Giovanni
	dw SilphCo11Text8  ; 11 ; JJ stop you
	dw SilphCo11Text9  ; 12 ; JJ second dialogue
	dw SilphCo11Text10 ; 13 ; JJ last dialogue

SilphCo11F_TextPointers_Rocket:
	dw SilphCo11Text1_RP ; President
	dw SilphCo11Text2_RP ; Secretary
	dw SilphCo11TextGiovanni_RP ; Giovanni
	dw SilphCo11Text4 ; James
	dw SilphCo11Text5 ; Rocket
	dw SilphCo11Text6 ; Jessie
	dw SilphCo11TextBadgeMachine
	; signs
	dw SilphCo11SignText1
	dw SilphCo11SignText2
	; scripts
	dw SilphCo11ScriptText1_RP ; 10
	dw SilphCo11ScriptText2_RP ; 11
	dw SilphCo11ScriptText3_RP ; 12
	dw SilphCo11ScriptText4_RP ; 13
	dw SilphCo11ScriptText5_RP ; 14
	dw SilphCo11ScriptText6_RP ; 15
	dw SilphCo11ScriptText7_RP ; 16
	dw SilphCo11ScriptText8_RP ; 17

SilphCo11TrainerHeaders:
	def_trainers 5
SilphCo11TrainerHeader0:
	trainer EVENT_BEAT_SILPH_CO_11F_TRAINER_1, 3, SilphCo11Trainer1BattleText, SilphCo11Trainer1EndBattleText, SilphCo11Trainer1AfterBattleText
	db -1 ; end

SilphCo11Text4:
SilphCo11Text6:
SilphCo11Text8:
	text_far _SilphCoJessieJamesText1
	text_asm
	ld c, 10
	call DelayFrames
	ld a, $4
	ld [wPlayerMovingDirection], a
	ld a, $0
	ld [wEmotionBubbleSpriteIndex], a
	ld a, EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
	ld c, 20
	call DelayFrames
	jp TextScriptEnd

SilphCo11Text9:
	text_far _SilphCoJessieJamesText2
	text_end

SilphCo11Text_624c2:
	text_far _SilphCoJessieJamesText3
	text_end

SilphCo11Text10:
	text_far _SilphCoJessieJamesText4
	text_asm
	ld c, 64
	call DelayFrames
	jp TextScriptEnd

SilphCo11Text1:
	text_asm
	CheckEvent EVENT_GOT_MASTER_BALL
	jp nz, .got_item
	ld hl, SilphCoPresidentText
	call PrintText
	lb bc, MASTER_BALL, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, ReceivedSilphCoMasterBallText
	call PrintText
	SetEvent EVENT_GOT_MASTER_BALL
	jr .done
.bag_full
	ld hl, SilphCoMasterBallNoRoomText
	call PrintText
	jr .done
.got_item
	ld hl, SilphCo10Text_6231c
	call PrintText
.done
	jp TextScriptEnd

SilphCoPresidentText:
	text_far _SilphCoPresidentText
	text_end

ReceivedSilphCoMasterBallText:
	text_far _ReceivedSilphCoMasterBallText
	sound_get_key_item
	text_end

SilphCo10Text_6231c:
	text_far _SilphCo10Text_6231c
	text_end

SilphCoMasterBallNoRoomText:
	text_far _SilphCoMasterBallNoRoomText
	text_end

SilphCo11Text2:
	text_far _SilphCo11Text2
	text_end

SilphCo11Text3:
	text_far _SilphCo11Text3
	text_end

SilphCo10Text_62528:
	text_far _SilphCo10Text_62330
	text_end

SilphCo11Text7:
	text_far _SilphCo10Text_62335
	text_end

SilphCo11Text5:
	text_asm
	ld hl, SilphCo11TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

SilphCo11Trainer1BattleText:
	text_far _SilphCo11BattleText2
	text_end

SilphCo11Trainer1EndBattleText:
	text_far _SilphCo11EndBattleText2
	text_end

SilphCo11Trainer1AfterBattleText:
	text_far _SilphCo11AfterBattleText2
	text_end

; new -------------------------------------

SilphCo11SignText1:
	text_far _SilphCo11SignText1
	text_end

SilphCo11SignText2:
	text_asm
	ld hl, SilphCo11SignText2_1
	call PrintText
	ld a, PORYGON
	call DisplayPokedex
	jp TextScriptEnd

SilphCo11SignText2_1:
	text_far _SilphCo11SignText2_1
	text_end

SilphCo11TextBadgeMachine:
	text_asm
; count badges
	callfar CountHowManyBadges ; d contains the number of badges
	ld a, d
	cp 8
	ld hl, SilphCo11TextBadgeMachine_NotEnoughBadges
	jp nz, .printAndEnd
; we have all the badges
	ld hl, SilphCo11TextBadgeMachine_EnoughBadges
	call PrintText

; check if we have the right mons for Venustoise
	ld d, VENUSAUR
	callfar CheckIfOneGivenMonIsInParty
	ld hl, SilphCo11TextBadgeMachine_Nope
	jr nc, .checkForThuFiZer
	ld d, BLASTOISE
	callfar CheckIfOneGivenMonIsInParty
	ld hl, SilphCo11TextBadgeMachine_Nope
	jr nc, .checkForThuFiZer
	jp .mergeVenustoise

; check if we have the right mons for Thu-Fi-Zer
.checkForThuFiZer
	ld d, ARTICUNO
	callfar CheckIfOneGivenMonIsInParty
	ld hl, SilphCo11TextBadgeMachine_Nope
	jp nc, .printAndEnd
	ld d, ZAPDOS
	callfar CheckIfOneGivenMonIsInParty
	ld hl, SilphCo11TextBadgeMachine_Nope
	jp nc, .printAndEnd
	ld d, MOLTRES
	callfar CheckIfOneGivenMonIsInParty
	ld hl, SilphCo11TextBadgeMachine_Nope
	jp nc, .printAndEnd

; merge Thu-Fi-Zer
	ld hl, SilphCo11TextBadgeMachine_WantThuFiZer
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ld hl, SilphCo11TextBadgeMachine_NotNow
	jp nz, .printAndEnd
; remove and give
	call PlayFusionEffects
	xor a
	ld [wUniQuizAnswer], a
	ld [wRemoveMonFromBox], a
	SetEvent EVENT_FUSION_MACHINE_SHINY
	SetEvent EVENT_FUSION_MACHINE_DELTA
	ld d, ARTICUNO
	callfar CheckIfOneGivenMonIsInPartyAndLoadIndex
	call StoreHighestLevel
	call CheckIfMonIsShinyOrDelta
	call RemovePokemon
	ld d, ZAPDOS
	callfar CheckIfOneGivenMonIsInPartyAndLoadIndex
	call StoreHighestLevel
	call CheckIfMonIsShinyOrDelta
	call RemovePokemon
	ld d, MOLTRES
	callfar CheckIfOneGivenMonIsInPartyAndLoadIndex
	call StoreHighestLevel
	call CheckIfMonIsShinyOrDelta
	call RemovePokemon
	ld a, [wUniQuizAnswer]
	ld c, a
	ld b, THU_FI_ZER
	call GivePokemon
	jr .done

; we have VENUSAUR and BLASTOISE, ask if we want to merge them
.mergeVenustoise
	ld hl, SilphCo11TextBadgeMachine_WantVenustoise
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ld hl, SilphCo11TextBadgeMachine_NotNow
	jr nz, .printAndEnd
; remove and give
	call PlayFusionEffects
	xor a
	ld [wUniQuizAnswer], a
	ld [wRemoveMonFromBox], a
	SetEvent EVENT_FUSION_MACHINE_SHINY
	SetEvent EVENT_FUSION_MACHINE_DELTA
	ld d, VENUSAUR
	callfar CheckIfOneGivenMonIsInPartyAndLoadIndex
	call StoreHighestLevel
	call CheckIfMonIsShinyOrDelta
	call RemovePokemon
	ld d, BLASTOISE
	callfar CheckIfOneGivenMonIsInPartyAndLoadIndex
	call StoreHighestLevel
	call CheckIfMonIsShinyOrDelta
	call RemovePokemon
	ld a, [wUniQuizAnswer]
	ld c, a
	ld b, VENUSTOISE
	call GivePokemon
	jr .done
.printAndEnd
	call PrintText
.done
	ResetEvent EVENT_FUSION_MACHINE_SHINY
	ResetEvent EVENT_FUSION_MACHINE_DELTA
	jp TextScriptEnd

SilphCo11TextBadgeMachine_WantThuFiZer:
	text_far _SilphCo11TextBadgeMachine_WantThuFiZer
	text_end

SilphCo11TextBadgeMachine_WantVenustoise:
	text_far _SilphCo11TextBadgeMachine_WantVenustoise
	text_end

SilphCo11TextBadgeMachine_NotNow:
	text_far _SilphCo11TextBadgeMachine_NotNow
	text_end

SilphCo11TextBadgeMachine_NotEnoughBadges:
	text_far _SilphCo11TextBadgeMachine_NotEnoughBadges
	text_end

SilphCo11TextBadgeMachine_EnoughBadges:
	text_far _SilphCo11TextBadgeMachine_EnoughBadges
	text_end

SilphCo11TextBadgeMachine_Nope:
	text_far _SilphCo11TextBadgeMachine_Nope
	text_end

; input: [wWhichPokemon]
; output: store highest level in [wUniQuizAnswer]
StoreHighestLevel:
    ld a, [wWhichPokemon]
    ld hl, wPartyMon1Level
    ld bc, wPartyMon2 - wPartyMon1
    call AddNTimes
	ld a, [wUniQuizAnswer]
	ld b, a
    ld a, [hl]
	cp b
	ret c
	ld [wUniQuizAnswer], a
	ret

; input: [wWhichPokemon]
CheckIfMonIsShinyOrDelta:
    ld a, [wWhichPokemon]
    ld hl, wPartyMon1CatchRate
    ld bc, wPartyMon2 - wPartyMon1
    call AddNTimes
    ld a, [hl]
	bit BIT_MON_SHINY, a
	jr nz, .noResetShinyness
	push hl
	ResetEvent EVENT_FUSION_MACHINE_SHINY
	pop hl
.noResetShinyness
    ld a, [hl]
	bit BIT_MON_DELTA, a
	ret nz
	ResetEvent EVENT_FUSION_MACHINE_DELTA
	ret

PlayFusionEffects:
	call GBFadeOutToBlack
	ld a, SFX_TELEPORT_EXIT_1
	call PlaySound
	call GBFadeOutToWhite
	ld a, SFX_TELEPORT_ENTER_1
	call PlaySound
	call GBFadeInFromBlack
	ld a, SFX_TELEPORT_EXIT_2
	call PlaySound
	call GBFadeInFromWhite
	ld a, SFX_TELEPORT_ENTER_2
	call PlaySound
	ret

; new for RP =============================

SilphCo11ScriptText1_RP:
	text_far _SilphCo11ScriptText1_RP
	text_end

SilphCo11ScriptText2_RP:
	text_far _SilphCo11ScriptText2_RP
	text_end

SilphCo11ScriptText3_RP:
	text_far _SilphCo11ScriptText3_RP
	text_end

SilphCo11Script15:
	ld a, 12
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, 13
	jp SilphCo11Script_ScriptChanger

SilphCo11Text1_RP:
	text_far _SilphCo11Text1_RP
	text_end

SilphCo11Text2_RP:
	text_far _SilphCo11Text2_RP
	text_end

SilphCo11TextGiovanni_RP: ; TBE
	text_asm
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE
	jp z, .notChampionYet
; we are champion; check if we have a Mewtwo or not
	ld hl, SilphCo11TextGiovanni_RP_ChampionGreatDoYouHaveMewtwo
	call PrintText
	ld d, MMEWTWOY
	callfar CheckIfOneGivenMonIsInParty
	jr nc, .checkMMewtwoX
	ld d, MMEWTWOY
	ld a, 10
	ld [wTrainerNo], a
	jr .commonRemove
.checkMMewtwoX
	ld d, MMEWTWOX
	callfar CheckIfOneGivenMonIsInParty
	jr nc, .checkMewtwo
	ld d, MMEWTWOX
	ld a, 9
	ld [wTrainerNo], a
	jr .commonRemove
.checkMewtwo
	ld d, MEWTWO
	callfar CheckIfOneGivenMonIsInParty
	jr nc, .checkArmMewtwo
	ld d, MEWTWO
	ld a, 8
	ld [wTrainerNo], a
	jr .commonRemove
.checkArmMewtwo
	ld d, ARM_MEWTWO
	callfar CheckIfOneGivenMonIsInParty
	ld hl, SilphCo11TextGiovanni_RP_NoMewtwos
	jp nc, .printAndEnd
	ld d, ARM_MEWTWO
	ld a, 7
	ld [wTrainerNo], a
.commonRemove
	ld a, [wPartyCount]
	dec a
	ld hl, SilphCo11TextGiovanni_RP_GetAnotherMon
	jp z, .printAndEnd
; we have enough mons
	xor a
	ld [wRemoveMonFromBox], a
	callfar CheckIfOneGivenMonIsInPartyAndLoadIndex
	call RemovePokemon
	ld hl, SilphCo11TextGiovanni_RP_YouDidItMyTeamIsComplete
	call PrintText
	ld hl, SilphCo11TextGiovanni_RP_NowBegone
	call PrintText
; set up battle
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_GIOVANNI
	ld [wCurOpponent], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, SilphCo11FGiovanniRPDefeatText
	ld de, SilphCo11FGiovanniRPDefeatText
	call SaveEndBattleTextPointers
	SetEvent EVENT_RP_USE_VANILLA_BATTLE_MESSAGES
; load next script
	ld a, 16
	ld [wCurMapScript], a
	jp TextScriptEnd
.notChampionYet
	CheckEvent EVENT_RP_GAVE_BERSERK_GENE
	ld hl, SilphCo11TextGiovanni_RP_GoBecomeChampion
	jp nz, .printAndEnd
	CheckEvent EVENT_RP_GAVE_BIRBS_TO_GIOVANNI
	jr nz, .checkBerserkGene
	CheckEvent EVENT_GOT_HM03
	jr nz, .checkBadges
; not gotten Surf yet
	SetEvent EVENT_BEAT_SILPH_CO_GIOVANNI
	call SilphCo11Script_OpenSpecialDoor
; dialogue 1 good job take this
	ld hl, SilphCo11TextGiovanni_RP_GoodJobTakeThis
	call PrintText
; try to give Surf
	lb bc, HM_SURF, 1
	call GiveItem
	jr c, .bagNotFull
; bag full
	ld hl, SilphCo11TextGiovanni_RP_NoRoom
	jp .printAndEnd
.bagNotFull
	callfar OpenUpSouthObsidianBridge
	SetEvent EVENT_GOT_HM03
	ld hl, SilphCo11TextGiovanni_RP_GotItem
	call PrintText
; dialogue 2 discussing with president for ball and badge machine -> lore for Mewtwo and THU_FI_ZER
	ld hl, SilphCo11TextGiovanni_RP_LoreDrop
	call PrintText
; dialogue 3 badge quest
	ld hl, SilphCo11TextGiovanni_RP_BadgeQuest
	call PrintText
; dialogue 4 oh if you need mons go poaching in Safari
	ld hl, SilphCo11TextGiovanni_RP_Poaching
	jp .printAndEnd

; check if we brought the BERSERK_GENE to Giovanni
.checkBerserkGene
	ld hl, SilphCo11TextGiovanni_RP_DidYouBringGene
	call PrintText
	ld b, BERSERK_GENE
	call IsItemInBag
	ld hl, SilphCo11TextGiovanni_RP_NoGene
	jp z, .printAndEnd
; we have the Gene, give it to Giovanni
	ld a, BERSERK_GENE
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	SetEvent EVENT_RP_GAVE_BERSERK_GENE
	ld hl, SilphCo11TextGiovanni_RP_PlayerGivesGene
	call PrintText
	ld hl, SilphCo11TextGiovanni_RP_MewtwoIsThereGoChampion
	call PrintText
; obtain badge
	ld hl, wObtainedBadges
	set BIT_EARTHBADGE, [hl]
	ld hl, SilphCo11TextGiovanni_RP_GotEarthBadge
	call PrintText
	ld hl, SilphCo11TextGiovanni_RP_NowGoBecomeChampion
	jp .printAndEnd

; consecutive checks for the 7 badges to give STEAL_BALL
.checkBadges

	ld a, [wRPStealBallsForBadges]
	cp %01111111
	jr nz, .notAllBadges

; we got all badges, now check for the birbs
	ld hl, SilphCo11TextGiovanni_RP_BroughtAllBadges
	call PrintText

	ld d, ARTICUNO
	callfar CheckIfOneGivenMonIsInParty
	ld hl, SilphCo11TextGiovanni_RP_NotAllBirbs
	jp nc, .printAndEnd
	ld d, ZAPDOS
	callfar CheckIfOneGivenMonIsInParty
	ld hl, SilphCo11TextGiovanni_RP_NotAllBirbs
	jp nc, .printAndEnd
	ld d, MOLTRES
	callfar CheckIfOneGivenMonIsInParty
	ld hl, SilphCo11TextGiovanni_RP_NotAllBirbs
	jp nc, .printAndEnd

; we have all birbs
	ld hl, SilphCo11TextGiovanni_RP_YesAllBirbs
	call PrintText
; check if we have at least 4 pokemon total
	ld a, [wPartyCount]
	cp 4
	ld hl, SilphCo11TextGiovanni_RP_GetAnotherMon
	jp c, .printAndEnd
; give the birbs to Giovanni
	ld hl, SilphCo11TextGiovanni_RP_GimmeTheBirbs
	call PrintText
	xor a
	ld [wRemoveMonFromBox], a
	ld d, ARTICUNO
	callfar CheckIfOneGivenMonIsInPartyAndLoadIndex
	call RemovePokemon
	ld d, ZAPDOS
	callfar CheckIfOneGivenMonIsInPartyAndLoadIndex
	call RemovePokemon
	ld d, MOLTRES
	callfar CheckIfOneGivenMonIsInPartyAndLoadIndex
	call RemovePokemon
	ld hl, SilphCo11TextGiovanni_RP_PlayerGivesBirbs
	call PrintText
	SetEvent EVENT_RP_GAVE_BIRBS_TO_GIOVANNI

; be told to fetch the BERSERK_GENE
	ld hl, SilphCo11TextGiovanni_RP_FujiToldUs
	jp .printAndEnd

.notAllBadges
	ld hl, SilphCo11TextGiovanni_RP_DoYouHaveNewBadgesForMe
	call PrintText

.checkBOULDER
	ld hl, wRPStealBallsForBadges
	bit BIT_BOULDERBADGE, [hl]
	jr nz, .checkCASCADE
    ld hl, wObtainedBadges
	bit BIT_BOULDERBADGE, [hl]
	jr z, .checkCASCADE
	; this badge is new
	ld hl, SilphCo11TextGiovanni_RP_NewBadgeWellDone
	call PrintText
	call TryToRewardStealBall
	jp nc, .printAndEnd ; bag full
	ld hl, wRPStealBallsForBadges
	set BIT_BOULDERBADGE, [hl]
	jp .done

.checkCASCADE
	ld hl, wRPStealBallsForBadges
	bit BIT_CASCADEBADGE, [hl]
	jr nz, .checkTHUNDER
    ld hl, wObtainedBadges
	bit BIT_CASCADEBADGE, [hl]
	jr z, .checkTHUNDER
	; this badge is new
	ld hl, SilphCo11TextGiovanni_RP_NewBadgeWellDone
	call PrintText
	call TryToRewardStealBall
	jp nc, .printAndEnd ; bag full
	ld hl, wRPStealBallsForBadges
	set BIT_CASCADEBADGE, [hl]
	jp .done

.checkTHUNDER
	ld hl, wRPStealBallsForBadges
	bit BIT_THUNDERBADGE, [hl]
	jr nz, .checkRAINBOW
    ld hl, wObtainedBadges
	bit BIT_THUNDERBADGE, [hl]
	jr z, .checkRAINBOW
	; this badge is new
	ld hl, SilphCo11TextGiovanni_RP_NewBadgeWellDone
	call PrintText
	call TryToRewardStealBall
	jp nc, .printAndEnd ; bag full
	ld hl, wRPStealBallsForBadges
	set BIT_THUNDERBADGE, [hl]
	jp .done

.checkRAINBOW
	ld hl, wRPStealBallsForBadges
	bit BIT_RAINBOWBADGE, [hl]
	jr nz, .checkSOUL
    ld hl, wObtainedBadges
	bit BIT_RAINBOWBADGE, [hl]
	jr z, .checkSOUL
	; this badge is new
	ld hl, SilphCo11TextGiovanni_RP_NewBadgeWellDone
	call PrintText
	call TryToRewardStealBall
	jr nc, .printAndEnd ; bag full
	ld hl, wRPStealBallsForBadges
	set BIT_RAINBOWBADGE, [hl]
	jr .done

.checkSOUL
	ld hl, wRPStealBallsForBadges
	bit BIT_SOULBADGE, [hl]
	jr nz, .checkMARSH
    ld hl, wObtainedBadges
	bit BIT_SOULBADGE, [hl]
	jr z, .checkMARSH
	; this badge is new
	ld hl, SilphCo11TextGiovanni_RP_NewBadgeWellDone
	call PrintText
	call TryToRewardStealBall
	jr nc, .printAndEnd ; bag full
	ld hl, wRPStealBallsForBadges
	set BIT_SOULBADGE, [hl]
	jr .done

.checkMARSH
	ld hl, wRPStealBallsForBadges
	bit BIT_MARSHBADGE, [hl]
	jr nz, .checkVOLCANO
    ld hl, wObtainedBadges
	bit BIT_MARSHBADGE, [hl]
	jr z, .checkVOLCANO
	; this badge is new
	ld hl, SilphCo11TextGiovanni_RP_NewBadgeWellDone
	call PrintText
	call TryToRewardStealBall
	jr nc, .printAndEnd ; bag full
	ld hl, wRPStealBallsForBadges
	set BIT_MARSHBADGE, [hl]
	jr .done

.checkVOLCANO
	ld hl, wRPStealBallsForBadges
	bit BIT_VOLCANOBADGE, [hl]
	jr nz, .noNewBadges
    ld hl, wObtainedBadges
	bit BIT_VOLCANOBADGE, [hl]
	jr z, .noNewBadges
	; this badge is new
	ld hl, SilphCo11TextGiovanni_RP_NewBadgeWellDone
	call PrintText
	call TryToRewardStealBall
	jr nc, .printAndEnd ; bag full
	ld hl, wRPStealBallsForBadges
	set BIT_VOLCANOBADGE, [hl]
	jr .done

.noNewBadges
	ld hl, SilphCo11TextGiovanni_RP_ComeBackWhenHaveBadges
.printAndEnd
	call PrintText
.done
	jp TextScriptEnd

TryToRewardStealBall:
	lb bc, STEAL_BALL, 1
	call GiveItem
	jr nc, .bagFull
	ld hl, SilphCo11TextGiovanni_RP_GotItem
	call PrintText
	scf
	ret
.bagFull
	ld hl, SilphCo11TextGiovanni_RP_NoRoom
	ret

SilphCo11Script16:
	ld a, [wIsInBattle]
	cp $ff
	jp z, SilphCo11Script_ResetScripts
; we won
	SetEvent EVENT_RP_KILLED_GIOVANNI
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, 13
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; kill Giovanni
    call GBFadeOutToWhite
	ld c, BANK(SFX_Push_Boulder_1)
	ld a, SFX_PUSH_BOULDER
	call PlayMusic
    call GBFadeInFromWhite
	call StopMusic
	ld a, 14
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
    call GBFadeOutToWhite
	ld c, BANK(SFX_Push_Boulder_1)
	ld a, SFX_PUSH_BOULDER
	call PlayMusic
    call GBFadeInFromWhite
	ld a, 15
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
    call GBFadeOutToBlack
    ld c, 30
    call DelayFrames
	ld c, BANK(SFX_Push_Boulder_1)
	ld a, SFX_PUSH_BOULDER
	call PlayMusic
    ld c, 30
    call DelayFrames
    call GBFadeInFromBlack
	ld a, 16
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
    call GBFadeOutToBlack
    ld c, 60
    call DelayFrames
	ld c, BANK(SFX_Push_Boulder_1)
	ld a, SFX_PUSH_BOULDER
	call PlayMusic
    ld c, 60
    call DelayFrames
    call GBFadeInFromBlack
	ld a, 17
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
    call GBFadeOutToBlack
    ld c, 180
    call DelayFrames
	ld c, BANK(SFX_Push_Boulder_1)
	ld a, SFX_PUSH_BOULDER
	call PlayMusic
	ld a, HS_SILPH_CO_11F_1
	ld [wMissableObjectIndex], a
	predef HideObject
	call UpdateSprites
    ld c, 240
    call DelayFrames
    call GBFadeInFromBlack
    ld c, 120
    call DelayFrames
	call SilphCo11Script_ResetScripts
; roll credits and respawn in Pallet
	ld a, HS_PALLET_TOWN_DARK_GUIDE
	ld [wMissableObjectIndex], a
	predef ShowObject
	SetEvent EVENT_RP_CREDITS
	call GBPalWhiteOutWithDelay3
	call ClearSprites
	xor a
	ld [wUpdateSpritesEnabled], a
	callfar PostHallOfFamePC_Credits
	ld a, PALLET_TOWN
	ld [wLastBlackoutMap], a
	farcall SaveSAVtoSRAM
	ld b, 5
.delayLoop
	ld c, 600 / 5
	call DelayFrames
	dec b
	jr nz, .delayLoop
	call WaitForTextScrollButtonPress
	call PlayDefaultMusic
	jp Init

; ----------------------------------------------------

SilphCo11TextGiovanni_RP_GotItem:
	text_far _ReceivedHM01Text
	sound_get_key_item
	text_end

SilphCo11TextGiovanni_RP_GoodJobTakeThis:
	text_far _SilphCo11TextGiovanni_RP_GoodJobTakeThis
	text_end

SilphCo11TextGiovanni_RP_NoRoom:
	text_far _SilphCo11TextGiovanni_RP_NoRoom
	text_end

SilphCo11TextGiovanni_RP_LoreDrop:
	text_far _SilphCo11TextGiovanni_RP_LoreDrop
	text_end

SilphCo11TextGiovanni_RP_BadgeQuest:
	text_far _SilphCo11TextGiovanni_RP_BadgeQuest
	text_end

SilphCo11TextGiovanni_RP_Poaching:
	text_far _SilphCo11TextGiovanni_RP_Poaching
	text_end

SilphCo11TextGiovanni_RP_DoYouHaveNewBadgesForMe:
	text_far _SilphCo11TextGiovanni_RP_DoYouHaveNewBadgesForMe
	text_end

SilphCo11TextGiovanni_RP_NewBadgeWellDone:
	text_far _SilphCo11TextGiovanni_RP_NewBadgeWellDone
	text_end

SilphCo11TextGiovanni_RP_ComeBackWhenHaveBadges:
	text_far _SilphCo11TextGiovanni_RP_ComeBackWhenHaveBadges
	text_end

SilphCo11TextGiovanni_RP_BroughtAllBadges:
	text_far _SilphCo11TextGiovanni_RP_BroughtAllBadges
	text_end

SilphCo11TextGiovanni_RP_NotAllBirbs:
	text_far _SilphCo11TextGiovanni_RP_NotAllBirbs
	text_end

SilphCo11TextGiovanni_RP_GoBecomeChampion:
	text_far _SilphCo11TextGiovanni_RP_GoBecomeChampion
	text_end

SilphCo11TextGiovanni_RP_DidYouBringGene:
	text_far _SilphCo11TextGiovanni_RP_DidYouBringGene
	text_end

SilphCo11TextGiovanni_RP_NoGene:
	text_far _SilphCo11TextGiovanni_RP_NoGene
	text_end

SilphCo11TextGiovanni_RP_PlayerGivesGene:
	text_far _SilphCo11TextGiovanni_RP_PlayerGivesGene
	text_end

SilphCo11TextGiovanni_RP_MewtwoIsThereGoChampion:
	text_far _SilphCo11TextGiovanni_RP_MewtwoIsThereGoChampion
	text_end

SilphCo11TextGiovanni_RP_GotEarthBadge:
	text_far _SilphCo11TextGiovanni_RP_GotEarthBadge
	sound_get_key_item
	text_end

SilphCo11TextGiovanni_RP_NowGoBecomeChampion:
	text_far _SilphCo11TextGiovanni_RP_NowGoBecomeChampion
	text_end

SilphCo11TextGiovanni_RP_FujiToldUs:
	text_far _SilphCo11TextGiovanni_RP_FujiToldUs
	text_end

SilphCo11TextGiovanni_RP_PlayerGivesBirbs:
	text_far _SilphCo11TextGiovanni_RP_PlayerGivesBirbs
	text_end

SilphCo11TextGiovanni_RP_GimmeTheBirbs:
	text_far _SilphCo11TextGiovanni_RP_GimmeTheBirbs
	text_end

SilphCo11TextGiovanni_RP_GetAnotherMon:
	text_far _SilphCo11TextGiovanni_RP_GetAnotherMon
	text_end

SilphCo11TextGiovanni_RP_YesAllBirbs:
	text_far _SilphCo11TextGiovanni_RP_YesAllBirbs
	text_end

SilphCo11TextGiovanni_RP_ChampionGreatDoYouHaveMewtwo:
	text_far _SilphCo11TextGiovanni_RP_ChampionGreatDoYouHaveMewtwo
	text_end

SilphCo11TextGiovanni_RP_NoMewtwos:
	text_far _SilphCo11TextGiovanni_RP_NoMewtwos
	text_end

SilphCo11TextGiovanni_RP_YouDidItMyTeamIsComplete:
	text_far _SilphCo11TextGiovanni_RP_YouDidItMyTeamIsComplete
	text_end

SilphCo11TextGiovanni_RP_NowBegone:
	text_far _SilphCo11TextGiovanni_RP_NowBegone
	text_end

SilphCo11FGiovanniRPDefeatText:
	text_far _SilphCo11FGiovanniRPDefeatText
	text_end

SilphCo11ScriptText4_RP:
	text_far _SilphCo11ScriptText4_RP
	text_end

SilphCo11ScriptText5_RP:
	text_far _SilphCo11ScriptText5_RP
	text_end

SilphCo11ScriptText6_RP:
	text_far _SilphCo11ScriptText6_RP
	text_end

SilphCo11ScriptText7_RP:
	text_far _SilphCo11ScriptText7_RP
	text_end

SilphCo11ScriptText8_RP:
	text_far _SilphCo11ScriptText8_RP
	text_end
