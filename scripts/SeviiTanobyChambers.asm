SeviiTanobyChambers_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SeviiTanobyChambers_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

; scripts =========================================

SeviiTanobyChambers_ScriptPointers:
	dw SeviiTanobyChambers_Base ; 0
	dw SeviiTanobyChambers_PrintSuccessOneChamber ; 1
	dw SeviiTanobyChambers_RocketBeasts_MoveBeastsUp ; 2
	dw SeviiTanobyChambers_RocketBeasts_BeastsDialogues ; 3
	dw SeviiTanobyChambers_RocketBeasts_OrmPreBattle ; 4
	dw SeviiTanobyChambers_RocketBeasts_OrmBattle ; 5
	dw SeviiTanobyChambers_RocketBeasts_CarrBattle ; 6
	dw SeviiTanobyChambers_RocketBeasts_SirdPrePreBattle ; 7
	dw SeviiTanobyChambers_RocketBeasts_SirdPreBattle ; 8
	dw SeviiTanobyChambers_RocketBeasts_SirdBattle ; 9
	dw SeviiTanobyChambers_RocketBeasts_End ; 10
	
SeviiTanobyChambers_Base:
	CheckEvent EVENT_SEVII_BEAT_ROCKET_BEASTS_TANOBY
	ret nz
; Rocket Beasts encounter check
IF DEF(_DEBUG)
	call DebugPressedOrHeldB
	jr nz, .checkOtherEvents
ENDC
	ld hl, SeviiTanobyChambers_Coordinates_RocketBeastsScene
	call ArePlayerCoordsInArray ; sets carry if the coordinates are in the array, clears carry if not
	jr nc, .checkOtherEvents
; dialogue
	ld c, BANK(Music_MeetEvilTrainer)
	ld a, MUSIC_MEET_EVIL_TRAINER
	call PlayMusic
	ld a, 12
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
	ld a, 2
	ld [wCurMapScript], a
	ret

.checkOtherEvents
	CheckEvent EVENT_SEVII_UNLOCKED_TANOBY_CHAMBER_MAJOR
	ret nz
; check chamber 1 and then 6, as they are the "special" ones
	CheckEvent EVENT_SEVII_TANOBY_SOLVED_CHAMBER_1
	jr nz, .handleChamber6
; are we tracking time for Chamber1?
	CheckEvent EVENT_SEVII_TANOBY_TRACK_TIME
	jr z, .handleChamber6
; we are tracking time: if we move, reset the event (also if we use Dig/Escape Rope)
	ld hl, SeviiTanobyChambers_Chamber1_Coordinates
	call ArePlayerCoordsInArray ; sets carry if the coordinates are in the array, clears carry if not
	jr nc, .dontTrackTime
; we are still in the right spot: check if enough time passed
	CheckEvent EVENT_SEVII_TANOBY_TIME_PASSED
	ret z
; enough time passed
	SetEvent EVENT_SEVII_TANOBY_SOLVED_CHAMBER_1
	ResetEvent EVENT_SEVII_TANOBY_TRACK_TIME
	ld a, SFX_PUSH_BOULDER
	call PlaySound
	ld a, 7
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID
.dontTrackTime
	ResetEvent EVENT_SEVII_TANOBY_TRACK_TIME
	; fallthrough

.handleChamber6
	CheckEvent EVENT_SEVII_TANOBY_SOLVED_CHAMBER_6
	jp nz, .handleChamber2
; check if we started the path
	CheckEvent EVENT_SEVII_TANOBY_CHAMBER_6_STARTED_PATH
	ret z
; we did start, check step by step
.checkStep0 ; unnecessary but for symmetry
	CheckEvent EVENT_SEVII_TANOBY_TRACK_PATH_0
	jr z, .checkStep1
; initial location for this step?
	ld hl, SeviiTanobyChambers_Chamber6_Coordinates_Step0_Ini
	call ArePlayerCoordsInArray ; carry if yes
	ret c ; do nothing, we didn't move
; not initial location, check if correct next one
	ld hl, SeviiTanobyChambers_Chamber6_Coordinates_Step0_Fin
	call ArePlayerCoordsInArray ; carry if yes
	jp nc, ResetChamber6PathEvents
; we are in the correct next step: change active event
	ResetEvent EVENT_SEVII_TANOBY_TRACK_PATH_0
	SetEvent EVENT_SEVII_TANOBY_TRACK_PATH_1
	ret

.checkStep1
	CheckEvent EVENT_SEVII_TANOBY_TRACK_PATH_1
	jr z, .checkStep2
; initial location for this step?
	ld hl, SeviiTanobyChambers_Chamber6_Coordinates_Step1_Ini
	call ArePlayerCoordsInArray
	ret c ; do nothing, we didn't move
; not initial location, check if correct next one
	ld hl, SeviiTanobyChambers_Chamber6_Coordinates_Step1_Fin
	call ArePlayerCoordsInArray
	jp nc, ResetChamber6PathEvents
; we are in the correct next step: change active event
	ResetEvent EVENT_SEVII_TANOBY_TRACK_PATH_1
	SetEvent EVENT_SEVII_TANOBY_TRACK_PATH_2
	ret

.checkStep2
	CheckEvent EVENT_SEVII_TANOBY_TRACK_PATH_2
	jr z, .checkStep3
; initial location for this step?
	ld hl, SeviiTanobyChambers_Chamber6_Coordinates_Step2_Ini
	call ArePlayerCoordsInArray
	ret c ; do nothing, we didn't move
; not initial location, check if correct next one
	ld hl, SeviiTanobyChambers_Chamber6_Coordinates_Step2_Fin
	call ArePlayerCoordsInArray
	jp nc, ResetChamber6PathEvents
; we are in the correct next step: change active event
	ResetEvent EVENT_SEVII_TANOBY_TRACK_PATH_2
	SetEvent EVENT_SEVII_TANOBY_TRACK_PATH_3
	ret

.checkStep3
	CheckEvent EVENT_SEVII_TANOBY_TRACK_PATH_3
	jr z, .checkStep4
; initial location for this step?
	ld hl, SeviiTanobyChambers_Chamber6_Coordinates_Step3_Ini
	call ArePlayerCoordsInArray
	ret c ; do nothing, we didn't move
; not initial location, check if correct next one
	ld hl, SeviiTanobyChambers_Chamber6_Coordinates_Step3_Fin
	call ArePlayerCoordsInArray
	jp nc, ResetChamber6PathEvents
; we are in the correct next step: change active event
	ResetEvent EVENT_SEVII_TANOBY_TRACK_PATH_3
	SetEvent EVENT_SEVII_TANOBY_TRACK_PATH_4
	ret

.checkStep4
	CheckEvent EVENT_SEVII_TANOBY_TRACK_PATH_4
	jr z, .checkStep5
; initial location for this step?
	ld hl, SeviiTanobyChambers_Chamber6_Coordinates_Step4_Ini
	call ArePlayerCoordsInArray
	ret c ; do nothing, we didn't move
; not initial location, check if correct next one
	ld hl, SeviiTanobyChambers_Chamber6_Coordinates_Step4_Fin
	call ArePlayerCoordsInArray
	jp nc, ResetChamber6PathEvents
; we are in the correct next step: change active event
	ResetEvent EVENT_SEVII_TANOBY_TRACK_PATH_4
	SetEvent EVENT_SEVII_TANOBY_TRACK_PATH_5
	ret

.checkStep5
	CheckEvent EVENT_SEVII_TANOBY_TRACK_PATH_5
	jr z, .checkStep6
; initial location for this step?
	ld hl, SeviiTanobyChambers_Chamber6_Coordinates_Step5_Ini
	call ArePlayerCoordsInArray
	ret c ; do nothing, we didn't move
; not initial location, check if correct next one
	ld hl, SeviiTanobyChambers_Chamber6_Coordinates_Step5_Fin
	call ArePlayerCoordsInArray
	jp nc, ResetChamber6PathEvents
; we are in the correct next step: change active event
	ResetEvent EVENT_SEVII_TANOBY_TRACK_PATH_5
	SetEvent EVENT_SEVII_TANOBY_TRACK_PATH_6
	ret

.checkStep6
	CheckEvent EVENT_SEVII_TANOBY_TRACK_PATH_6
	jr z, .checkStep7
; initial location for this step?
	ld hl, SeviiTanobyChambers_Chamber6_Coordinates_Step6_Ini
	call ArePlayerCoordsInArray
	ret c ; do nothing, we didn't move
; not initial location, check if correct next one
	ld hl, SeviiTanobyChambers_Chamber6_Coordinates_Step6_Fin
	call ArePlayerCoordsInArray
	jp nc, ResetChamber6PathEvents
; we are in the correct next step: change active event
	ResetEvent EVENT_SEVII_TANOBY_TRACK_PATH_6
	SetEvent EVENT_SEVII_TANOBY_TRACK_PATH_7
	ret

.checkStep7
;	CheckEvent EVENT_SEVII_TANOBY_TRACK_PATH_7 ; no need: it must be here, or else there's a bug
; initial location for this step?
	ld hl, SeviiTanobyChambers_Chamber6_Coordinates_Step7_Ini
	call ArePlayerCoordsInArray
	ret c ; do nothing, we didn't move
; not initial location, check if correct next one
	ld hl, SeviiTanobyChambers_Chamber6_Coordinates_Step7_Fin
	call ArePlayerCoordsInArray
	jp nc, ResetChamber6PathEvents
; we are in the correct final step: set this chamber's event
	SetEvent EVENT_SEVII_TANOBY_SOLVED_CHAMBER_6
	ld a, 1
	ld [wCurMapScript], a
	ret

.handleChamber2
	CheckEvent EVENT_SEVII_TANOBY_SOLVED_CHAMBER_2
	ret z
.handleChamber3
	CheckEvent EVENT_SEVII_TANOBY_SOLVED_CHAMBER_3
	ret z
.handleChamber4
	CheckEvent EVENT_SEVII_TANOBY_SOLVED_CHAMBER_4
	ret z
.handleChamber5
	CheckEvent EVENT_SEVII_TANOBY_SOLVED_CHAMBER_5
	ret z
; all Chambers solved
	SetEvent EVENT_SEVII_UNLOCKED_TANOBY_CHAMBER_MAJOR
	callfar ShakeScreen
	ld a, 11
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call PlayDefaultMusic
	; TBE
	ret

SeviiTanobyChambers_Chamber6_Coordinates_Step0_Ini:
	dbmapcoord 62,  9
	db -1
SeviiTanobyChambers_Chamber6_Coordinates_Step0_Fin:
	dbmapcoord 63,  9
	db -1

SeviiTanobyChambers_Chamber6_Coordinates_Step1_Ini:
	dbmapcoord 63,  9
	db -1
SeviiTanobyChambers_Chamber6_Coordinates_Step1_Fin:
	dbmapcoord 64,  9
	db -1

SeviiTanobyChambers_Chamber6_Coordinates_Step2_Ini:
	dbmapcoord 64,  9
	db -1
SeviiTanobyChambers_Chamber6_Coordinates_Step2_Fin:
	dbmapcoord 65,  9
	db -1

SeviiTanobyChambers_Chamber6_Coordinates_Step3_Ini:
	dbmapcoord 65,  9
	db -1
SeviiTanobyChambers_Chamber6_Coordinates_Step3_Fin:
	dbmapcoord 65, 10
	db -1

SeviiTanobyChambers_Chamber6_Coordinates_Step4_Ini:
	dbmapcoord 65, 10
	db -1
SeviiTanobyChambers_Chamber6_Coordinates_Step4_Fin:
	dbmapcoord 65, 11
	db -1

SeviiTanobyChambers_Chamber6_Coordinates_Step5_Ini:
	dbmapcoord 65, 11
	db -1
SeviiTanobyChambers_Chamber6_Coordinates_Step5_Fin:
	dbmapcoord 64, 11
	db -1

SeviiTanobyChambers_Chamber6_Coordinates_Step6_Ini:
	dbmapcoord 64, 11
	db -1
SeviiTanobyChambers_Chamber6_Coordinates_Step6_Fin:
	dbmapcoord 63, 11
	db -1

SeviiTanobyChambers_Chamber6_Coordinates_Step7_Ini:
	dbmapcoord 63, 11
	db -1
SeviiTanobyChambers_Chamber6_Coordinates_Step7_Fin:
	dbmapcoord 62, 11
	db -1

SeviiTanobyChambers_Chamber1_Coordinates:
	dbmapcoord  2,  9
	db -1 ; end

SeviiTanobyChambers_PrintSuccessOneChamber:
	ld a, SFX_PUSH_BOULDER
	call PlaySound
	ld a, 10
	ldh [hSpriteIndexOrTextID], a
	xor a
	ld [wCurMapScript], a
	jp DisplayTextID

ResetChamber6PathEvents:
	ld a, SFX_DENIED
	call PlaySound
	ResetEvent EVENT_SEVII_TANOBY_CHAMBER_6_STARTED_PATH
	ResetEvent EVENT_SEVII_TANOBY_TRACK_PATH_0
	ResetEvent EVENT_SEVII_TANOBY_TRACK_PATH_1
	ResetEvent EVENT_SEVII_TANOBY_TRACK_PATH_2
	ResetEvent EVENT_SEVII_TANOBY_TRACK_PATH_3
	ResetEvent EVENT_SEVII_TANOBY_TRACK_PATH_4
	ResetEvent EVENT_SEVII_TANOBY_TRACK_PATH_5
	ResetEvent EVENT_SEVII_TANOBY_TRACK_PATH_6
	ResetEvent EVENT_SEVII_TANOBY_TRACK_PATH_7
	ret

; Rocket Beasts scripts =========================

SeviiTanobyChambers_Coordinates_RocketBeastsScene:
	dbmapcoord 78,  7
	db -1 ; end

SeviiTanobyChambers_RocketBeasts_MoveBeastsUp:
; wait for player to have moved
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
; show and move Beasts
	ld a, HS_SEVII_TANOBY_CHAMBERS_ORM
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld de, SeviiTanobyChambers_RocketBeastsMovements
	ld a, 1
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, HS_SEVII_TANOBY_CHAMBERS_CARR
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld de, SeviiTanobyChambers_RocketBeastsMovements
	ld a, 2
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, HS_SEVII_TANOBY_CHAMBERS_SIRD
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld de, SeviiTanobyChambers_RocketBeastsMovements
	ld a, 3
	ldh [hSpriteIndex], a
	call MoveSprite
; script handling
	ld a, 3
	ld [wCurMapScript], a
	ret
	
SeviiTanobyChambers_RocketBeastsMovements:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
SeviiTanobyChambers_RocketBeastsMovements_Orm:
SeviiTanobyChambers_RocketBeastsMovements_Sird:
	db NPC_MOVEMENT_UP
	db -1 ; end

SeviiTanobyChambers_RocketBeasts_BeastsDialogues:
; wait for Beasts movements
	ld a, [wd730]
	bit 0, a
	ret nz
; fix Beasts facings
	ld a, 1
	ldh [hSpriteIndex], a
	lb bc, STAY, UP
	call ChangeSpriteMovementBytes ; new from Engeze
	ld a, 2
	ldh [hSpriteIndex], a
	lb bc, STAY, UP
	call ChangeSpriteMovementBytes ; new from Engeze
	ld a, 3
	ldh [hSpriteIndex], a
	lb bc, STAY, UP
	call ChangeSpriteMovementBytes ; new from Engeze
; dialogues
	ld a, 13
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, 14
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, 15
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; Orm moves up
	ld de, SeviiTanobyChambers_RocketBeastsMovements_Orm
	ld a, 1
	ldh [hSpriteIndex], a
	call MoveSprite
; script handling
	ld a, 4
	ld [wCurMapScript], a
	ret

SeviiTanobyChambers_RocketBeasts_OrmPreBattle:
; wait for Orm movements
	ld a, [wd730]
	bit 0, a
	ret nz
; turn Orm and player
	ld a, SPRITE_FACING_LEFT
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, 1
	ldh [hSpriteIndex], a
	lb bc, STAY, RIGHT
	call ChangeSpriteMovementBytes ; new from Engeze
; script handling
	ld a, 5
	ld [wCurMapScript], a
	ret
	
SeviiTanobyChambers_RocketBeasts_OrmBattle:
	ld a, $0
	ld [wJoyIgnore], a
; dialogue
	ld a, 16
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; set up battle
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_ORM
	ld [wCurOpponent], a
	ld a, 2
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, SeviiTanobyChambersOrmDefeatText
	ld de, SeviiTanobyChambersOrmDefeatText
	call SaveEndBattleTextPointers
; script handling
	ld a, 6
	ld [wCurMapScript], a
	ret

SeviiTanobyChambers_RocketBeasts_CarrBattle:
	ld a, [wIsInBattle]
	cp $ff
	jp z, SeviiTanobyChambersResetScripts
	ld a, $f0
	ld [wJoyIgnore], a
; we won, turn player
	ld a, SPRITE_FACING_DOWN
	ld [wSpritePlayerStateData1FacingDirection], a
; dialogue
	ld a, 17
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; set up battle
	xor a
	ld [wJoyIgnore], a
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_CARR
	ld [wCurOpponent], a
	ld a, 2
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, SeviiTanobyChambersCarrDefeatText
	ld de, SeviiTanobyChambersCarrDefeatText
	call SaveEndBattleTextPointers
; script handling
	ld a, 7
	ld [wCurMapScript], a
	ret

SeviiTanobyChambers_RocketBeasts_SirdPrePreBattle:
	ld a, [wIsInBattle]
	cp $ff
	jp z, SeviiTanobyChambersResetScripts
	ld a, $f0
	ld [wJoyIgnore], a
; Sird moves up
	ld de, SeviiTanobyChambers_RocketBeastsMovements_Sird
	ld a, 3
	ldh [hSpriteIndex], a
	call MoveSprite
; script handling
	ld a, 8
	ld [wCurMapScript], a
	ret

SeviiTanobyChambers_RocketBeasts_SirdPreBattle:
; wait for Sird movements
	ld a, [wd730]
	bit 0, a
	ret nz
; turn Sird and player
	ld a, SPRITE_FACING_RIGHT
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, 3
	ldh [hSpriteIndex], a
	lb bc, STAY, LEFT
	call ChangeSpriteMovementBytes ; new from Engeze
; script handling
	ld a, 9
	ld [wCurMapScript], a
	ret

SeviiTanobyChambers_RocketBeasts_SirdBattle:
	xor a
	ld [wJoyIgnore], a
; dialogue
	ld a, 18
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; set up battle
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_SIRD
	ld [wCurOpponent], a
	ld a, 2
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, SeviiTanobyChambersSirdDefeatText
	ld de, SeviiTanobyChambersSirdDefeatText
	call SaveEndBattleTextPointers
; script handling
	ld a, 10
	ld [wCurMapScript], a
	ret

SeviiTanobyChambers_RocketBeasts_End:
	ld a, [wIsInBattle]
	cp $ff
	jp z, SeviiTanobyChambersResetScripts
	ld a, $f0
	ld [wJoyIgnore], a
; last dialogue
	ld a, 19
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; hide sprites
	SetEvent EVENT_SEVII_BEAT_ROCKET_BEASTS_TANOBY
	call GBFadeOutToBlack
	ld a, HS_SEVII_TANOBY_CHAMBERS_ORM
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld a, HS_SEVII_TANOBY_CHAMBERS_CARR
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld a, HS_SEVII_TANOBY_CHAMBERS_SIRD
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
	; fallthrough

SeviiTanobyChambersResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

; texts =========================================

SeviiTanobyChambers_TextPointers:
	dw SeviiTanobyChambersText1
	dw SeviiTanobyChambersText2
	dw SeviiTanobyChambersText3
	; signs
	dw SeviiTanobyChambersSignText1
	dw SeviiTanobyChambersSignText2
	dw SeviiTanobyChambersSignText3
	dw SeviiTanobyChambersSignText4
	dw SeviiTanobyChambersSignText5
	dw SeviiTanobyChambersSignText6
	; scripts
	dw SeviiTanobyChambersScriptText1  ; 10 : Solved one Chamber
	dw SeviiTanobyChambersScriptText2  ; 11 : Solved all Chambers
	dw SeviiTanobyChambersScriptText3  ; 12 : Beasts 1st dialogue
	dw SeviiTanobyChambersScriptText4  ; 13 : Beasts 2nd dialogue
	dw SeviiTanobyChambersScriptText5  ; 14 : Beasts 3rd dialogue
	dw SeviiTanobyChambersScriptText6  ; 15 : Beasts 4th dialogue
	dw SeviiTanobyChambersScriptText7  ; 16 : Beasts Orm pre-battle dialogue
	dw SeviiTanobyChambersScriptText8  ; 17 : Beasts Carr pre-battle dialogue
	dw SeviiTanobyChambersScriptText9  ; 18 : Beasts Sird pre-battle dialogue
	dw SeviiTanobyChambersScriptText10 ; 19 : Beasts final dialogue

SeviiTanobyChambersSignText1:
	text_asm
	CheckEvent EVENT_SEVII_TANOBY_SOLVED_CHAMBER_1
	jr nz, .skipSetup
	xor a
	ld [wUniQuizAnswer], a
	SetEvent EVENT_SEVII_TANOBY_TRACK_TIME
.skipSetup
	callfar LoadFontTilePatternsBraille
	ld hl, SeviiTanobyChambersSignText1_Inner
	call PrintText
	jp TextScriptEnd

SeviiTanobyChambersSignText1_Inner:
	text_far _SeviiTanobyChambersSignText1
	text_end

; --------------------------------------------

SeviiTanobyChambersSignText2:
	text_asm
	callfar LoadFontTilePatternsBraille
	ld hl, SeviiTanobyChambersSignText2_Inner
	call PrintText
	CheckEvent EVENT_SEVII_TANOBY_SOLVED_CHAMBER_2
	jr nz, .done
; we haven't solved this room yet, check party
	call CheckIfStartersPlusMewtwoInParty
	jr nc, .done
; we have a proper team
	SetEvent EVENT_SEVII_TANOBY_SOLVED_CHAMBER_2
	ld a, 1
	ld [wCurMapScript], a
.done
	jp TextScriptEnd

SeviiTanobyChambersSignText2_Inner:
	text_far _SeviiTanobyChambersSignText2
	text_end

; --------------------------------------------

SeviiTanobyChambersSignText3:
	text_asm
	callfar LoadFontTilePatternsBraille
	ld hl, SeviiTanobyChambersSignText3_Inner
	call PrintText
	jp TextScriptEnd

SeviiTanobyChambersSignText3_Inner:
	text_far _SeviiTanobyChambersSignText3
	text_end

; --------------------------------------------

SeviiTanobyChambersSignText4:
	text_asm
	callfar LoadFontTilePatternsBraille
	ld hl, SeviiTanobyChambersSignText4_Inner
	call PrintText
	jp TextScriptEnd

SeviiTanobyChambersSignText4_Inner:
	text_far _SeviiTanobyChambersSignText4
	text_end

; --------------------------------------------

SeviiTanobyChambersSignText5:
	text_asm
	callfar LoadFontTilePatternsBraille
	ld hl, SeviiTanobyChambersSignText5_Inner
	call PrintText
	jp TextScriptEnd

SeviiTanobyChambersSignText5_Inner:
	text_far _SeviiTanobyChambersSignText5
	text_end

; --------------------------------------------

SeviiTanobyChambersSignText6:
	text_asm
	CheckEvent EVENT_SEVII_TANOBY_SOLVED_CHAMBER_6
	jr nz, .skipSetup
; setup
	SetEvent EVENT_SEVII_TANOBY_CHAMBER_6_STARTED_PATH
	SetEvent EVENT_SEVII_TANOBY_TRACK_PATH_0
.skipSetup
	callfar LoadFontTilePatternsBraille
	ld hl, SeviiTanobyChambersSignText6_Inner
	call PrintText
	jp TextScriptEnd

SeviiTanobyChambersSignText6_Inner:
	text_far _SeviiTanobyChambersSignText6
	text_end

; =========================================

; c flag if proper team
CheckIfStartersPlusMewtwoInParty:
; Bulba
	ld d, BULBASAUR
	callfar CheckIfOneGivenMonIsInParty ; d contains the Pokemon you want to check ; sets carry flag if found
	jr c, .checkChar
	ld d, IVYSAUR
	callfar CheckIfOneGivenMonIsInParty
	jr c, .checkChar
	ld d, VENUSAUR
	callfar CheckIfOneGivenMonIsInParty
	jr c, .checkChar
	ld d, MVENUSAUR
	callfar CheckIfOneGivenMonIsInParty
	jr c, .checkChar
	ld d, VENUSTOISE
	callfar CheckIfOneGivenMonIsInParty
	ret nc
; Char
.checkChar
	ld d, CHARMANDER
	callfar CheckIfOneGivenMonIsInParty
	jr c, .checkSqui
	ld d, CHARMELEON
	callfar CheckIfOneGivenMonIsInParty
	jr c, .checkSqui
	ld d, CHARIZARD
	callfar CheckIfOneGivenMonIsInParty
	jr c, .checkSqui
	ld d, MCHARZARDX
	callfar CheckIfOneGivenMonIsInParty
	jr c, .checkSqui
	ld d, MCHARZARDY
	callfar CheckIfOneGivenMonIsInParty
	ret nc
; Squi
.checkSqui
	ld d, SQUIRTLE
	callfar CheckIfOneGivenMonIsInParty
	jr c, .checkPika
	ld d, WARTORTLE
	callfar CheckIfOneGivenMonIsInParty
	jr c, .checkPika
	ld d, BLASTOISE
	callfar CheckIfOneGivenMonIsInParty
	jr c, .checkPika
	ld d, MBLASTOISE
	callfar CheckIfOneGivenMonIsInParty
	jr c, .checkPika
	ld d, VENUSTOISE
	callfar CheckIfOneGivenMonIsInParty
	ret nc
; Pikachu
.checkPika
	ld d, PIKACHU
	callfar CheckIfOneGivenMonIsInParty
	ret nc
; Eevee
	ld d, EEVEE
	callfar CheckIfOneGivenMonIsInParty
	ret nc
; Mewtwo
	ld d, MEWTWO
	callfar CheckIfOneGivenMonIsInParty
	ret c
	ld d, MMEWTWOX
	callfar CheckIfOneGivenMonIsInParty
	ret c
	ld d, MMEWTWOY
	callfar CheckIfOneGivenMonIsInParty
	ret

; --------------------------------------------

SeviiTanobyChambersScriptText1:
	text_far _SeviiTanobyChambersScriptText1
	text_end

SeviiTanobyChambersScriptText2:
	text_far _SeviiTanobyChambersScriptText2
	text_end
	
; Rocket Beasts texts ==============================

SeviiTanobyChambersText1:
SeviiTanobyChambersText2:
SeviiTanobyChambersText3:
	text_far _SeviiTanobyChambersText1
	text_end

SeviiTanobyChambersScriptText3:
	text_far _SeviiTanobyChambersScriptText3
	text_end

SeviiTanobyChambersScriptText4:
	text_far _SeviiTanobyChambersScriptText4
	text_end

SeviiTanobyChambersScriptText5:
	text_far _SeviiTanobyChambersScriptText5
	text_end

SeviiTanobyChambersScriptText6:
	text_far _SeviiTanobyChambersScriptText6
	text_end

SeviiTanobyChambersScriptText7:
	text_far _SeviiTanobyChambersScriptText7
	text_end

SeviiTanobyChambersScriptText8:
	text_far _SeviiTanobyChambersScriptText8
	text_end

SeviiTanobyChambersScriptText9:
	text_far _SeviiTanobyChambersScriptText9
	text_end

SeviiTanobyChambersScriptText10:
	text_far _SeviiTanobyChambersScriptText10
	text_end

SeviiTanobyChambersOrmDefeatText:
	text_far _SeviiTanobyChambersOrmDefeatText
	text_end
	
SeviiTanobyChambersCarrDefeatText:
	text_far _SeviiTanobyChambersCarrDefeatText
	text_end
	
SeviiTanobyChambersSirdDefeatText:
	text_far _SeviiTanobyChambersSirdDefeatText
	text_end
	