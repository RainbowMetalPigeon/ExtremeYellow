SeviiDottedHole_Script:
	call EnableAutoTextBoxDrawing
	ld de, SeviiDottedHole_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

; scripts ====================================

SeviiDottedHole_ScriptPointers:
	dw SeviiDottedHoleScript0
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw SeviiDottedHoleScript3
	dw SeviiDottedHoleScript4
	dw SeviiDottedHoleScript5
	dw SeviiDottedHoleScript6
	dw SeviiDottedHoleScript7
	dw SeviiDottedHoleScript8
	dw SeviiDottedHoleScript9
	dw SeviiDottedHoleScript10

SeviiDottedHoleScript0:
	CheckEvent EVENT_SEVII_BEAT_ROCKETS_DOTTED_HOLE
	ret nz
	ld hl, SeviiDottedHole_Coordinates_RocketAdminsScene
	call ArePlayerCoordsInArray ; sets carry if the coordinates are in the array, clears carry if not
	ret nc
; dialogue
	ld c, BANK(Music_MeetEvilTrainer)
	ld a, MUSIC_MEET_EVIL_TRAINER
	call PlayMusic
	ld a, 10
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; Player moves down
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, D_DOWN | B_BUTTON ; edited to fix Pikachu blocker
	ld [wSimulatedJoypadStatesEnd], a
	ld a, 1
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
; script handling
	ld a, 3
	ld [wCurMapScript], a
	ret

SeviiDottedHole_Coordinates_RocketAdminsScene:
	dbmapcoord 10,  8
	db -1 ; end

SeviiDottedHoleScript3:
; wait for player to have moved
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
; show and move Jessie
	ld a, HS_SEVII_DOTTED_HOLE_JESSIE_1
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld de, SeviiDottedHole_JessieMovements
	ld a, 2
	ldh [hSpriteIndex], a
	call MoveSprite
; script handling
	ld a, 4
	ld [wCurMapScript], a
	ret

SeviiDottedHole_JessieMovements:
	db NPC_FAST_MOVEMENT_UP
	db NPC_FAST_MOVEMENT_LEFT
	db NPC_FAST_MOVEMENT_LEFT
	db NPC_FAST_MOVEMENT_LEFT
	db NPC_FAST_MOVEMENT_LEFT
	db NPC_FAST_MOVEMENT_UP
	db NPC_FAST_MOVEMENT_UP
	db NPC_FAST_MOVEMENT_UP
	db NPC_FAST_MOVEMENT_RIGHT
	db NPC_FAST_MOVEMENT_RIGHT
	db NPC_FAST_MOVEMENT_RIGHT
	db -1 ; end

SeviiDottedHoleScript4:
; wait for Jessie movements
	ld a, [wd730]
	bit 0, a
	ret nz
; fix Jessie facings
	ld a, 2
	ldh [hSpriteIndex], a
	lb bc, STAY, RIGHT
	call ChangeSpriteMovementBytes ; new from Engeze
; script handling
	ld a, 5
	ld [wCurMapScript], a
	ret

SeviiDottedHoleScript5:
; show and move James
	ld a, HS_SEVII_DOTTED_HOLE_JAMES_1
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld de, SeviiDottedHole_JamesMovements
	ld a, 3
	ldh [hSpriteIndex], a
	call MoveSprite
; script handling
	ld a, 6
	ld [wCurMapScript], a
	ret

SeviiDottedHole_JamesMovements:
	db NPC_FAST_MOVEMENT_UP
	db NPC_FAST_MOVEMENT_RIGHT
	db NPC_FAST_MOVEMENT_RIGHT
	db NPC_FAST_MOVEMENT_RIGHT
	db NPC_FAST_MOVEMENT_RIGHT
	db NPC_FAST_MOVEMENT_UP
	db NPC_FAST_MOVEMENT_UP
	db NPC_FAST_MOVEMENT_UP
	db NPC_FAST_MOVEMENT_LEFT
	db NPC_FAST_MOVEMENT_LEFT
	db NPC_FAST_MOVEMENT_LEFT
	db -1 ; end

SeviiDottedHoleScript6:
; wait for James movements
	ld a, [wd730]
	bit 0, a
	ret nz
; fix Jessie facings
	ld a, 2
	ldh [hSpriteIndex], a
	lb bc, STAY, RIGHT
	call ChangeSpriteMovementBytes ; new from Engeze
; fix Jessie facings
	ld a, 3
	ldh [hSpriteIndex], a
	lb bc, STAY, LEFT
	call ChangeSpriteMovementBytes ; new from Engeze
; restore joypad control
	ld a, $0
	ld [wJoyIgnore], a
; dialogue JJ
	ld a, 11
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; dialogue Admins
	ld a, 12
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; exclamation marks
	ld a, 0
	ld [wEmotionBubbleSpriteIndex], a
	ld a, EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
	ld a, 2
	ld [wEmotionBubbleSpriteIndex], a
	ld a, EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
	ld a, 3
	ld [wEmotionBubbleSpriteIndex], a
	ld a, EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
; fade black, hide JJ1, show JJ2, hide Pikachu, show everyone else
	call GBFadeOutToBlack
	ld a, HS_SEVII_DOTTED_HOLE_JESSIE_1
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld a, HS_SEVII_DOTTED_HOLE_JAMES_1
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld a, HS_SEVII_DOTTED_HOLE_JESSIE_2
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld a, HS_SEVII_DOTTED_HOLE_JAMES_2
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld a, HS_SEVII_DOTTED_HOLE_PROTON
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld a, HS_SEVII_DOTTED_HOLE_PETREL
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld a, HS_SEVII_DOTTED_HOLE_ARIANA
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld a, HS_SEVII_DOTTED_HOLE_ARCHER
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	call CheckPikachuFollowingPlayer
	jr nz, .notFollowingPikachu
	call DisablePikachuOverworldSpriteDrawing
.notFollowingPikachu
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
; dialogue(s)
	ld a, 13
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; set up battle 1
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_PROTON
	ld [wCurOpponent], a
	ld a, 2
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, SeviiDottedHoleProtonDefeatText
	ld de, SeviiDottedHoleProtonDefeatText
	call SaveEndBattleTextPointers
; script handling
	ld a, 7
	ld [wCurMapScript], a
	ret

SeviiDottedHoleScript7:
; did we lose?
	ld a, [wIsInBattle]
	cp $ff
	jp z, SeviiDottedHoleResetScripts
; dialogue(s)
	ld a, 14
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; set up battle 2
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_PETREL
	ld [wCurOpponent], a
	ld a, 2
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, SeviiDottedHolePetrelDefeatText
	ld de, SeviiDottedHolePetrelDefeatText
	call SaveEndBattleTextPointers
; script handling
	ld a, 8
	ld [wCurMapScript], a
	ret

SeviiDottedHoleScript8:
; did we lose?
	ld a, [wIsInBattle]
	cp $ff
	jp z, SeviiDottedHoleResetScripts
; dialogue(s)
	ld a, 15
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; set up battle 3
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_ARIANA
	ld [wCurOpponent], a
	ld a, 2
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, SeviiDottedHoleArianaDefeatText
	ld de, SeviiDottedHoleArianaDefeatText
	call SaveEndBattleTextPointers
; script handling
	ld a, 9
	ld [wCurMapScript], a
	ret

SeviiDottedHoleScript9:
; did we lose?
	ld a, [wIsInBattle]
	cp $ff
	jp z, SeviiDottedHoleResetScripts
; dialogue(s)
	ld a, 16
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; set up battle 4
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_ARCHER
	ld [wCurOpponent], a
	ld a, 2
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, SeviiDottedHoleArcherDefeatText
	ld de, SeviiDottedHoleArcherDefeatText
	call SaveEndBattleTextPointers
; script handling
	ld a, 10
	ld [wCurMapScript], a
	ret

SeviiDottedHoleScript10:
; did we lose?
	ld a, [wIsInBattle]
	cp $ff
	jp z, SeviiDottedHoleResetScripts
; dialogues
	ld a, 17
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; hide everyone
	call GBFadeOutToBlack
	ld a, HS_SEVII_DOTTED_HOLE_JESSIE_2
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld a, HS_SEVII_DOTTED_HOLE_JAMES_2
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld a, HS_SEVII_DOTTED_HOLE_PROTON
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld a, HS_SEVII_DOTTED_HOLE_PETREL
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld a, HS_SEVII_DOTTED_HOLE_ARIANA
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld a, HS_SEVII_DOTTED_HOLE_ARCHER
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
; set event
	SetEvent EVENT_SEVII_BEAT_ROCKETS_DOTTED_HOLE
	; fallthrough
SeviiDottedHoleResetScripts:
	call CheckPikachuFollowingPlayer
	jr nz, .notFollowingPikachu
	ld a, $1
	ld [wPikachuSpawnState], a
	call EnablePikachuOverworldSpriteDrawing
.notFollowingPikachu
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

; -------------------------

SeviiDottedHoleTrainerHeaders:
	def_trainers
SeviiDottedHoleMeltanTrainerHeader:
	trainer EVENT_BEAT_MELTAN, 0, SeviiDottedHoleMeltanBattleText, SeviiDottedHoleMeltanBattleText, SeviiDottedHoleMeltanBattleText
	db -1 ; end

SeviiDottedHoleInitStaticEncounterBattle:
	call TalkToTrainer
	jp TextScriptEnd

SeviiDottedHoleMeltanText:
	text_asm
	ld hl, SeviiDottedHoleMeltanTrainerHeader
	jr SeviiDottedHoleInitStaticEncounterBattle

SeviiDottedHoleMeltanBattleText:
	text_far _SeviiDottedHoleMeltanBattleText
	text_asm
	ld a, MELTAN
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

; texts ====================================

SeviiDottedHole_TextPointers:
	dw SeviiDottedHoleMeltanText ; Meltan
	dw SeviiDottedHoleTextProxy
	dw SeviiDottedHoleTextProxy
	dw SeviiDottedHoleTextProxy
	dw SeviiDottedHoleTextProxy
	dw SeviiDottedHoleTextProxy
	dw SeviiDottedHoleTextProxy
	dw SeviiDottedHoleTextProxy
	dw SeviiDottedHoleTextProxy ; 9
	; scripts
	dw SeviiDottedHoleTextScript1  ; 10
	dw SeviiDottedHoleTextScript2  ; 11
	dw SeviiDottedHoleTextScript3  ; 12
	dw SeviiDottedHoleTextScript4  ; 13
	dw SeviiDottedHoleTextScript5  ; 14
	dw SeviiDottedHoleTextScript6  ; 15
	dw SeviiDottedHoleTextScript7  ; 16
	dw SeviiDottedHoleTextScript8  ; 17

SeviiDottedHoleTextProxy:
	text_far _SeviiDottedHoleText1
	text_end

SeviiDottedHoleTextScript1:
	text_far _SeviiDottedHoleTextScript1
	text_end

SeviiDottedHoleTextScript2:
	text_far _SeviiDottedHoleTextScript2
	text_end

SeviiDottedHoleTextScript3:
	text_far _SeviiDottedHoleTextScript3
	text_end

SeviiDottedHoleTextScript4:
	text_far _SeviiDottedHoleTextScript4
	text_end

SeviiDottedHoleTextScript5:
	text_far _SeviiDottedHoleTextScript5
	text_end

SeviiDottedHoleTextScript6:
	text_far _SeviiDottedHoleTextScript6
	text_end

SeviiDottedHoleTextScript7:
	text_far _SeviiDottedHoleTextScript7
	text_end

SeviiDottedHoleTextScript8:
	text_far _SeviiDottedHoleTextScript8
	text_end

SeviiDottedHoleProtonDefeatText:
	text_far _SeviiDottedHoleProtonDefeatText
	text_end

SeviiDottedHolePetrelDefeatText:
	text_far _SeviiDottedHolePetrelDefeatText
	text_end

SeviiDottedHoleArianaDefeatText:
	text_far _SeviiDottedHoleArianaDefeatText
	text_end

SeviiDottedHoleArcherDefeatText:
	text_far _SeviiDottedHoleArcherDefeatText
	text_end
