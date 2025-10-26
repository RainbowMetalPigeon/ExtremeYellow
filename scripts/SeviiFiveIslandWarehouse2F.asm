SeviiFiveIslandWarehouse2F_Script:
	call SeviiFiveIslandWarehouse2FSetDoorBlock
	call EnableAutoTextBoxDrawing
	ld hl, SeviiFiveIslandWarehouse2FTrainerHeaders
	ld de, SeviiFiveIslandWarehouse2F_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

SeviiFiveIslandWarehouse2FSetDoorBlock:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
; check door 1
	CheckEvent EVENT_SEVII_FIVE_ISLAND_WAREHOUSE_BF_OPENED_DOOR_1
	jr nz, .doorsOpen1
	ld a, $5F ; door block ID
	jr .replaceBlock1
.doorsOpen1
	ld a, $0E ; clear floor block ID
.replaceBlock1
	ld [wNewTileBlockID], a
	lb bc,  8,  6
	predef ReplaceTileBlock
; check door 4
	CheckEvent EVENT_SEVII_FIVE_ISLAND_WAREHOUSE_BF_OPENED_DOOR_4
	jr nz, .doorsOpen2
	ld a, $5F ; door block ID
	jr .replaceBlock2
.doorsOpen2
	ld a, $0E ; clear floor block ID
.replaceBlock2
	ld [wNewTileBlockID], a
	lb bc,  3,  2
	predef_jump ReplaceTileBlock

; scripts ===============================

SeviiFiveIslandWarehouse2F_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw SeviiFiveIslandWarehouse2F_Script3
	dw SeviiFiveIslandWarehouse2F_Script4

SeviiFiveIslandWarehouse2F_Script3:
	ld a, [wIsInBattle]
	cp $ff
	jp z, SeviiFiveIslandWarehouse2FResetScripts
	ld a, $f0
	ld [wJoyIgnore], a
; we won
	ld a, 17
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; hide Carr and all other rockets
	call GBFadeOutToBlack
	call HideNPCsAfterSeviiWarehouseCarr
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
; show appropriate Pink and dialogues
	ld a, [wYCoord]
	cp 5
	ld a, HS_SEVII_FIVE_ISLAND_WAREHOUSE_2F_PINK_AFTER_2
	jr z, .spawnSouthPink
; spawn North Pink
	ld a, HS_SEVII_FIVE_ISLAND_WAREHOUSE_2F_PINK_AFTER_1
.spawnSouthPink
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld a, 18
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; hide Pikachu
	call CheckPikachuFollowingPlayer
	jr nz, .notFollowingPikachu
	call DisablePikachuOverworldSpriteDrawing
.notFollowingPikachu
; walk Pink
; determine which movement to apply depending on player's position
	ld a, [wYCoord]
	cp 5
	ld de, SeviiWarehousePinkIfPlayerUpMovements
	jr z, .playerUp
	cp 6
	ld de, SeviiWarehousePinkIfPlayerMidMovements
	jr z, .playerDown
	ld de, SeviiWarehousePinkIfPlayerDownMovements
.playerDown
	push de
	ld a, 3
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_UP
	ld [wSpritePlayerStateData1FacingDirection], a
	jr .movePink
.playerUp
	push de
	ld a, 4
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_DOWN
	ld [wSpritePlayerStateData1FacingDirection], a
.movePink
	pop de
	call MoveSprite
; load next script
	ld a, 4
	ld [wCurMapScript], a
	ret

SeviiWarehousePinkIfPlayerUpMovements:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db -1 ; end

SeviiWarehousePinkIfPlayerDownMovements:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
SeviiWarehousePinkIfPlayerMidMovements:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

HideNPCsAfterSeviiWarehouseCarr:
	ld hl, NPCsToHidePostCarr
.hideLoop
	ld a, [hli]
	cp $ff ; have we run out of NPCs to hide?
	ret z ; if so, we're done
	push hl
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	pop hl
	jr .hideLoop

NPCsToHidePostCarr:
	db HS_SEVII_FIVE_ISLAND_WAREHOUSE_BF_ROCKET_1
	db HS_SEVII_FIVE_ISLAND_WAREHOUSE_BF_ROCKET_2
	db HS_SEVII_FIVE_ISLAND_WAREHOUSE_1F_ROCKET_1
	db HS_SEVII_FIVE_ISLAND_WAREHOUSE_1F_ROCKET_2
	db HS_SEVII_FIVE_ISLAND_WAREHOUSE_2F_CARR
	db HS_SEVII_FIVE_ISLAND_WAREHOUSE_2F_PINK_BEFORE
	db HS_SEVII_FIVE_ISLAND_WAREHOUSE_2F_PINK_ROCKET_1
	db HS_SEVII_FIVE_ISLAND_WAREHOUSE_2F_PINK_ROCKET_2
	db $ff

SeviiFiveIslandWarehouse2F_Script4:
; wait for Pink to have moved
	ld a, [wd730]
	bit 0, a
	ret nz
; turn Pink if appropriate
	ld a, [wYCoord]
	cp 6
	jr z, .noTurnPink
; determine which Pink to turn
	cp 5
	lb de, 4, SPRITE_FACING_LEFT
	jr z, .turnPink
	lb de, 3, SPRITE_FACING_LEFT
.turnPink
	callfar ChangeSpriteFacing ; new Pigeon approach
	ld a, SPRITE_FACING_RIGHT
	ld [wSpritePlayerStateData1FacingDirection], a
.noTurnPink
; Pink dialogue
	xor a
	ld [wJoyIgnore], a
	ld a, 19
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; hide Pink and spawn them in their house
	call GBFadeOutToBlack
	ld a, HS_SEVII_FIVE_ISLAND_WAREHOUSE_2F_PINK_AFTER_1
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld a, HS_SEVII_FIVE_ISLAND_WAREHOUSE_2F_PINK_AFTER_2
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld a, HS_SEVII_FOUR_ISLAND_HOUSE_PINK
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
; respawn Pikachu
	call CheckPikachuFollowingPlayer
	jr nz, .notFollowingPikachu
	ld a, $1
	ld [wPikachuSpawnState], a
	call EnablePikachuOverworldSpriteDrawing
.notFollowingPikachu
	SetEvent EVENT_SEVII_CLEARED_CHRONO_WAREHOUSE
; load next script
; fallthrough only for last script
SeviiFiveIslandWarehouse2FResetScripts:
	xor a
	ld [wCurMapScript], a
	ret

; texts ===============================

SeviiFiveIslandWarehouse2F_TextPointers:
	dw SeviiFiveIslandWarehouse2FText1 ; Carr
	dw SeviiFiveIslandWarehouse2FText2 ; Pink before-end
	dw SeviiFiveIslandWarehouse2FText3 ; Pink after-end
	dw SeviiFiveIslandWarehouse2FText4 ; Pink after-end
	dw SeviiFiveIslandWarehouse2FText5 ; rocket (fight)
	dw SeviiFiveIslandWarehouse2FText6 ; rocket (fainted)
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw SeviiFiveIslandWarehouse2FSignText1 ; statue
	dw SeviiFiveIslandWarehouse2FSignText2 ; statue
	dw SeviiFiveIslandWarehouse2FSignText3 ; door 1
	dw SeviiFiveIslandWarehouse2FSignText4 ; door 1
	dw SeviiFiveIslandWarehouse2FSignText5 ; door 4
	dw SeviiFiveIslandWarehouse2FSignText6 ; door 4
	; scripts
	dw SeviiFiveIslandWarehouse2FScriptText1 ; 17
	dw SeviiFiveIslandWarehouse2FScriptText2 ; 18
	dw SeviiFiveIslandWarehouse2FScriptText3 ; 19

SeviiFiveIslandWarehouse2FTrainerHeaders:
	def_trainers 5
SeviiFiveIslandWarehouse2FTrainerHeader1:
	trainer EVENT_BEAT_SEVII_FIVE_ISLAND_WAREHOUSE_2F_TRAINER_1, 0, SeviiFiveIslandWarehouse2FBattleText1, SeviiFiveIslandWarehouse2FEndBattleText1, SeviiFiveIslandWarehouse2FAfterBattleText1
	db -1 ; end

SeviiFiveIslandWarehouse2FText1: ; CARR
	text_asm
	ld c, BANK(Music_MeetEvilTrainer)
	ld a, MUSIC_MEET_EVIL_TRAINER
	call PlayMusic
; Carr last pre-battle dialogue and start battle
	ld hl, SeviiFiveIslandWarehouse2FText1_Inner
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_CARR
	ld [wCurOpponent], a
	ld a, 1
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, SeviiFiveIslandWarehouse2FCarrDefeatText
	ld de, SeviiFiveIslandWarehouse2FCarrDefeatText
	call SaveEndBattleTextPointers
; load next script
	ld a, 3
	ld [wCurMapScript], a
	jp TextScriptEnd

SeviiFiveIslandWarehouse2FText1_Inner:
	text_far _SeviiFiveIslandWarehouse2FText1_Inner
	text_end

SeviiFiveIslandWarehouse2FCarrDefeatText:
	text_far _SeviiFiveIslandWarehouse2FCarrDefeatText
	text_end

SeviiFiveIslandWarehouse2FText2: ; PINK before-end
	text_far _SeviiFiveIslandWarehouse2FText2
	text_end

SeviiFiveIslandWarehouse2FText3:
SeviiFiveIslandWarehouse2FText4:
	text_far _SeviiFiveIslandWarehouse2FText3
	text_end

SeviiFiveIslandWarehouse2FText5:
	text_asm
	ld hl, SeviiFiveIslandWarehouse2FTrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

SeviiFiveIslandWarehouse2FBattleText1:
	text_far _SeviiFiveIslandWarehouse2FBattleText1
	text_end

SeviiFiveIslandWarehouse2FEndBattleText1:
	text_far _SeviiFiveIslandWarehouse2FEndBattleText1
	text_end

SeviiFiveIslandWarehouse2FAfterBattleText1:
	text_far _SeviiFiveIslandWarehouse2FAfterBattleText1
	text_end

SeviiFiveIslandWarehouse2FText6:
	text_far _SeviiFiveIslandWarehouse2FText6
	text_end

SeviiFiveIslandWarehouse2FSignText1:
	text_far _SeviiFiveIslandWarehouse2FSignText1
	text_end

SeviiFiveIslandWarehouse2FSignText2:
	text_far _SeviiFiveIslandWarehouse2FSignText2
	text_end

SeviiFiveIslandWarehouse2FSignText3:
SeviiFiveIslandWarehouse2FSignText4:
	text_asm
	CheckEvent EVENT_SEVII_FIVE_ISLAND_WAREHOUSE_BF_OPENED_DOOR_1
	ld hl, SeviiFiveIslandWarehouse2FSignTextDoor_DoorIsOpen
	jr nz, .printAndEnd
; require password
	call SaveScreenTilesToBuffer2
	ld hl, SeviiFiveIslandWarehouse2FSignTextDoor_RequiresPassword
	call PrintText
	call WaitForTextScrollButtonPress
	farcall DisplayUniQuizScreen
.checkTheAnswer
	ld a, [wUniQuizAnswer]
	cp "G"
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+1]
	cp "R"
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+2]
	cp "A"
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+3]
	cp "S"
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+4]
	cp "P"
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+5]
	cp "@"
	jr z, .rightAnswer
.wrongAnswer
	ld a, SFX_DENIED
	call PlaySound
	ld hl, SeviiFiveIslandWarehouse2FSignTextDoor_Wrong
	jr .printAndEnd
.rightAnswer
	ld a, SFX_GO_INSIDE
	call PlaySound
	SetEvent EVENT_SEVII_FIVE_ISLAND_WAREHOUSE_BF_OPENED_DOOR_1
	ld a, $0E ; clear floor block ID
	ld [wNewTileBlockID], a
	lb bc,  8,  6
	predef ReplaceTileBlock
	ld hl, SeviiFiveIslandWarehouse2FSignTextDoor_Right
.printAndEnd
	call PrintText
.done
	jp TextScriptEnd

SeviiFiveIslandWarehouse2FSignTextDoor_RequiresPassword:
	text_far _SeviiFiveIslandWarehouse_InsertPassword
	text_end

SeviiFiveIslandWarehouse2FSignTextDoor_Wrong:
	text_far _SeviiFiveIslandWarehouse_WrongPassword
	text_end

SeviiFiveIslandWarehouse2FSignTextDoor_Right:
	text_far _SeviiFiveIslandWarehouse_CorrectPassword
	text_end

SeviiFiveIslandWarehouse2FSignTextDoor_DoorIsOpen:
	text_far _SeviiFiveIslandWarehouse_DoorIsOpen
	text_end

SeviiFiveIslandWarehouse2FSignText5:
SeviiFiveIslandWarehouse2FSignText6:
	text_asm
	CheckEvent EVENT_SEVII_FIVE_ISLAND_WAREHOUSE_BF_OPENED_DOOR_4
	ld hl, SeviiFiveIslandWarehouse2FSignTextDoor_DoorIsOpen
	jr nz, .printAndEnd
; require key
	ld b, PASSEPARTOUT
	call IsItemInBag ; set zero flag if item isn't in player's bag
	jr nz, .havePassepartout
; no key
	ld hl, SeviiFiveIslandWarehouse2FSignTextDoor_NeedsKey
	jr .printAndEnd
.havePassepartout
; let's open the door and remove the PASSEPARTOUT
	ld a, SFX_GO_INSIDE
	call PlaySound
	ld a, PASSEPARTOUT
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	SetEvent EVENT_SEVII_FIVE_ISLAND_WAREHOUSE_BF_OPENED_DOOR_4
	ld a, $0E ; clear floor block ID
	ld [wNewTileBlockID], a
	lb bc,  3,  2
	predef ReplaceTileBlock
	ld hl, SeviiFiveIslandWarehouse2FSignTextDoor_HaveKey
.printAndEnd
	call PrintText
.done
	jp TextScriptEnd

SeviiFiveIslandWarehouse2FSignTextDoor_NeedsKey:
	text_far _SeviiFiveIslandWarehouse2FSignTextDoor_NeedsKey
	text_end
	
SeviiFiveIslandWarehouse2FSignTextDoor_HaveKey:
	text_far _SeviiFiveIslandWarehouse2FSignTextDoor_HaveKey
	text_end

SeviiFiveIslandWarehouse2FScriptText1:
	text_far _SeviiFiveIslandWarehouse2FScriptText1
	text_end

SeviiFiveIslandWarehouse2FScriptText2:
	text_far _SeviiFiveIslandWarehouse2FScriptText2
	text_end

SeviiFiveIslandWarehouse2FScriptText3:
	text_far _SeviiFiveIslandWarehouse2FScriptText3
	text_end
