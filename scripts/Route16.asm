Route16_Script:
	call EnableAutoTextBoxDrawing
	ld hl, Route16TrainerHeaders
	ld de, Route16_ScriptPointers
	ld a, [wRoute16CurScript]
	call ExecuteCurMapScriptInTable
	ld [wRoute16CurScript], a
	ret

Route16Script_59946:
	xor a
	ld [wJoyIgnore], a
	ld [wRoute16CurScript], a
	ld [wCurMapScript], a
	ret

Route16_ScriptPointers:
	dw Route16Script0
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw Route16Script3
	dw Route16Script4 ; new, trigger battle vs Rival
	dw Route16Script5 ; new
	dw Route16Script6 ; new
	dw Route16Script7 ; new
	dw Route16Script8 ; new
	dw Route16Script9 ; new

AroundSnorlaxRoute16Coords: ; new
	dbmapcoord 27, 10
	db -1 ; end

Route16Script0:
; new, for Rival Snorlax battle
; we need to: NOT have faced this rival already; be around Snorlax; have the flute in the bag
	CheckEvent EVENT_FACED_SNORLAX_RIVAL
	jp nz, .vanillaCode
	ld hl, AroundSnorlaxRoute16Coords
	call ArePlayerCoordsInArray
	jr nz, .vanillaCode
	ld b, POKE_FLUTE
	call IsItemInBag
	jr z, .vanillaCode
; if we are here, we begin triggering the battle vs the rival
; walking code
	ld a, [wWalkBikeSurfState]
	and a
	jr z, .walking
	call StopAllMusic
.walking
	ld a, 16
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; Pikachu scared and hide
	call CheckPikachuFollowingPlayer
	jr nz, .notFollowingPikachu
	ld a, $f
	ld [wEmotionBubbleSpriteIndex], a
	ld a, EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
	call DisablePikachuOverworldSpriteDrawing
.notFollowingPikachu
	ld c, BANK(Music_MeetRival)
	ld a, MUSIC_MEET_RIVAL
	call PlayMusic
	xor a
	ldh [hJoyHeld], a
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, HS_ROUTE_16_RIVAL
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld a, PLAYER_DIR_RIGHT ; TBC
	ld [wPlayerMovingDirection], a
	ld de, Route16FMovements1
	ld a, 8 ; index of Rival's sprite
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, $4 ; TBC
	ld [wRoute16CurScript], a
	ld [wCurMapScript], a
	ret
.vanillaCode
; back to vanilla
	CheckEventHL EVENT_BEAT_ROUTE16_SNORLAX
	jp nz, CheckFightingMapTrainers
	CheckEventReuseHL EVENT_FIGHT_ROUTE16_SNORLAX
	ResetEventReuseHL EVENT_FIGHT_ROUTE16_SNORLAX
	jp z, CheckFightingMapTrainers
	ld a, $b ; =11, edited, +1 because rival
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, SNORLAX
	ld [wCurOpponent], a
	ld a, 30
	ld [wCurEnemyLVL], a
	ld a, HS_ROUTE_16_SNORLAX
	ld [wMissableObjectIndex], a
	predef HideObject
	call UpdateSprites
	ld a, $3
	ld [wRoute16CurScript], a
	ld [wCurMapScript], a
	ret

Route16FMovements1: ; new
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_LEFT
	db -1 ; end

Route16Script3:
	ld a, [wIsInBattle]
	cp $ff
	jp z, Route16Script_59946
	call UpdateSprites
	ld a, [wBattleResult]
	cp $2
	jr z, .asm_599a8
	ld a, $c ; =12, edited, +1 because rival
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.asm_599a8
	SetEvent EVENT_BEAT_ROUTE16_SNORLAX
	call Delay3
	ld a, $0
	ld [wRoute16CurScript], a
	ld [wCurMapScript], a
	ret

; ----------------------------------------------

Route16Script4: ; new
	ld a, [wd730] ; bit 0: NPC being moved by script
	bit 0, a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, 8 ; Rival's text ID, pre-battle
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld hl, wd72d ; nobody knows what it does lol
	set 6, [hl]
	set 7, [hl]
	ld hl, Route16RivalText_Win ; text if player wins
	ld de, Route16RivalText_Lose ; text if player loses
	call SaveEndBattleTextPointers
	ld a, OPP_RIVAL2
	ld [wCurOpponent], a
	ld a, 5
	ld [wTrainerNo], a
	xor a
	ldh [hJoyHeld], a
	call Route16Script_RivalFacingLeft
	SetEvent EVENT_FACED_SNORLAX_RIVAL
	ld a, 5
	ld [wRoute16CurScript], a
	ld [wCurMapScript], a
	ret

Route16Script5: ; new
	ld a, [wIsInBattle]
	cp $ff
	jp z, Route16Script_ResetIfLoseVsRival
; stuff to do if we defeat the rival
	call Route16Script_RivalFacingLeft
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, 13 ; Rival's text ID
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $ff ; testing
	ld [wJoyIgnore], a
	call Route16Script_RivalFacingRight
	ld a, $6
	ld [wRoute16CurScript], a
	ld [wCurMapScript], a
	ret

Route16Script6: ; new
	call StopAllMusic
	farcall Music_RivalAlternateStart
	ld a, 8 ; Rival's sprite ID
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld de, Route16FMovements2
	call MoveSprite
	ld a, $7
	ld [wRoute16CurScript], a
	ld [wCurMapScript], a
	ret

Route16Script7: ; new
	ld a, [wd730] ; bit 0: NPC being moved by script
	bit 0, a
	ret nz
	call Route16Script_RivalFacingRight
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, 14 ; Rival's text ID
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call Route16Script_RivalFacingRight
	ld a, $8
	ld [wRoute16CurScript], a
	ld [wCurMapScript], a
	ret

Route16Script8: ; new
	call Route16Script_RivalFacingRight
	call Route16Script_RivalFacingLeft
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, 15 ; Rival's text ID
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, 8 ; Rival's sprite ID
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld de, Route16FMovements3
	call MoveSprite
	ld a, $9
	ld [wRoute16CurScript], a
	ld [wCurMapScript], a
	ret

Route16Script9: ; new
	ld a, [wd730]
	bit 0, a
	ret nz
	ld a, HS_ROUTE_16_RIVAL
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_ROUTE_12_SNORLAX
	ld [wMissableObjectIndex], a
	predef HideObject
	SetEvent EVENT_BEAT_ROUTE12_SNORLAX ; necessary only to avoid using pokeflute in front of "nowhere"
	xor a
	ld [wJoyIgnore], a
	call PlayDefaultMusic
; Show Pikachu
	call CheckPikachuFollowingPlayer
	jr nz, .notFollowingPikachu
	ld a, $1
	ld [wPikachuSpawnState], a
	call EnablePikachuOverworldSpriteDrawing
.notFollowingPikachu
	ld a, $0
	ld [wRoute16CurScript], a
	ld [wCurMapScript], a
	ret

Route16FMovements2: ; new
	db NPC_MOVEMENT_RIGHT
	db -1 ; end

Route16FMovements3: ; new
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db -1 ; end

Route16Script_ResetIfLoseVsRival: ; new
	xor a
	ld [wJoyIgnore], a
	ld [wRoute16CurScript], a
	ld [wCurMapScript], a
	ld a, HS_ROUTE_16_SNORLAX
	ld [wMissableObjectIndex], a
	predef_jump HideObject

Route16Script_RivalFacingLeft:
	ld a, 8
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_LEFT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay ; face object
	ret

Route16Script_RivalFacingRight:
	ld a, 8
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_RIGHT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay ; face object
	ret

; ==============================================

Route16_TextPointers:
	dw Route16Text1
	dw Route16Text2
	dw Route16Text3
	dw Route16Text4
	dw Route16Text5
	dw Route16Text6
	dw Route16Text7
	dw Route16TextRival ; new
	dw Route16Text8 ; sign
	dw Route16Text9 ; sign
	dw Route16Text10 ; Snorlax-related text
	dw Route16Text11 ; Snorlax-related text
	dw Route16TextRivalPostBattle1 ; new, ID=13
	dw Route16TextRivalPostBattle2 ; new, ID=14
	dw Route16TextRivalPostBattle3 ; new, ID=15
	dw Route16TextRivalStop ; new, ID=16

Route16TrainerHeaders:
	def_trainers
Route16TrainerHeader0:
	trainer EVENT_BEAT_ROUTE_16_TRAINER_0, 3, Route16BattleText1, Route16EndBattleText1, Route16AfterBattleText1
Route16TrainerHeader1:
	trainer EVENT_BEAT_ROUTE_16_TRAINER_1, 2, Route16BattleText2, Route16EndBattleText2, Route16AfterBattleText2
Route16TrainerHeader2:
	trainer EVENT_BEAT_ROUTE_16_TRAINER_2, 2, Route16BattleText3, Route16EndBattleText3, Route16AfterBattleText3
Route16TrainerHeader3:
	trainer EVENT_BEAT_ROUTE_16_TRAINER_3, 2, Route16BattleText4, Route16EndBattleText4, Route16AfterBattleText4
Route16TrainerHeader4:
	trainer EVENT_BEAT_ROUTE_16_TRAINER_4, 2, Route16BattleText5, Route16EndBattleText5, Route16AfterBattleText5
Route16TrainerHeader5:
	trainer EVENT_BEAT_ROUTE_16_TRAINER_5, 4, Route16BattleText6, Route16EndBattleText6, Route16AfterBattleText6
	db -1 ; end

Route16Text1:
	text_asm
	ld hl, Route16TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

Route16BattleText1:
	text_far _Route16BattleText1
	text_end

Route16EndBattleText1:
	text_far _Route16EndBattleText1
	text_end

Route16AfterBattleText1:
	text_far _Route16AfterBattleText1
	text_end

Route16Text2:
	text_asm
	ld hl, Route16TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

Route16BattleText2:
	text_far _Route16BattleText2
	text_end

Route16EndBattleText2:
	text_far _Route16EndBattleText2
	text_end

Route16AfterBattleText2:
	text_far _Route16AfterBattleText2
	text_end

Route16Text3:
	text_asm
	ld hl, Route16TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

Route16BattleText3:
	text_far _Route16BattleText3
	text_end

Route16EndBattleText3:
	text_far _Route16EndBattleText3
	text_end

Route16AfterBattleText3:
	text_far _Route16AfterBattleText3
	text_end

Route16Text4:
	text_asm
	ld hl, Route16TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

Route16BattleText4:
	text_far _Route16BattleText4
	text_end

Route16EndBattleText4:
	text_far _Route16EndBattleText4
	text_end

Route16AfterBattleText4:
	text_far _Route16AfterBattleText4
	text_end

Route16Text5:
	text_asm
	ld hl, Route16TrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

Route16BattleText5:
	text_far _Route16BattleText5
	text_end

Route16EndBattleText5:
	text_far _Route16EndBattleText5
	text_end

Route16AfterBattleText5:
	text_far _Route16AfterBattleText5
	text_end

Route16Text6:
	text_asm
	ld hl, Route16TrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

Route16BattleText6:
	text_far _Route16BattleText6
	text_end

Route16EndBattleText6:
	text_far _Route16EndBattleText6
	text_end

Route16AfterBattleText6:
	text_far _Route16AfterBattleText6
	text_end

Route16Text7:
	text_far _Route16Text7
	text_end

Route16Text10:
	text_far _Route16Text10
	text_end

Route16Text11:
	text_far _Route16Text11
	text_end

Route16Text8:
	text_far _Route16Text8
	text_end

Route16Text9:
	text_far _Route16Text9
	text_end

Route16TextRival: ; new
	text_far _Route12TextRival
	text_end

Route16TextRivalPostBattle1: ; new
	text_far _Route12TextRivalPostBattle1
	text_end

Route16TextRivalPostBattle2: ; new
	text_far _Route12TextRivalPostBattle2
	text_end

Route16TextRivalPostBattle3: ; new
	text_far _Route12TextRivalPostBattle3
	text_end

Route16RivalText_Win: ; new
	text_far _Route12RivalText_Win
	text_end

Route16RivalText_Lose: ; new
	text_far _Route12RivalText_Lose
	text_end

Route16TextRivalStop: ; new
	text_far _Route12TextRivalStop
	text_end
