SeviiEightIslandCave_Script:
	call EnableAutoTextBoxDrawing
	ld de, SeviiEightCave_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

; scripts ==========================================

SeviiEightCave_ScriptPointers:
	dw SeviiEightIslandCaveScript_0 ;  0
	dw SeviiEightIslandCaveScript_PostBattleVsSuujero ;  1
	dw SeviiEightIslandCaveScript_ShowAndMoveBlue ;  2
	dw SeviiEightIslandCaveScript_WaitAndFixBlue ;  3
	dw SeviiEightIslandCaveScript_BlueFirstDialogueAndShowAndMovePink ;  4
	dw SeviiEightIslandCaveScript_WaitAndFixPink ;  5
	dw SeviiEightIslandCaveScript_PinkFirstDialogue ;  6
	dw SeviiEightIslandCaveScript_SuujeroSaysBattleRoyal1 ; 7
	dw SeviiEightIslandCaveScript_SuujeroSaysBattleRoyal2 ; 8
	dw SeviiEightIslandCaveScript_SuujeroSaysBattleRoyal3 ; 9
	dw SeviiEightIslandCaveScript_StartBlueBattle ; 10
	dw SeviiEightIslandCaveScript_StartPinkBattle ; 11
	dw SeviiEightIslandCaveScript_PostPinkBattle ; 12
	dw SeviiEightIslandCaveScript_BlueDialoguesPreGoAway ; 13
	dw SeviiEightIslandCaveScript_BlueGoesAway ; 14
	dw SeviiEightIslandCaveScript_WaitAndHideBluePinkDialoguesPreGoAway ; 15
	dw SeviiEightIslandCaveScript_PinkGoesAway ; 16
	dw SeviiEightIslandCaveScript_WaitAndHidePink ; 17

SeviiEightIslandCaveScript_0: ; 0
	ret

SeviiEightIslandCaveScript_PostBattleVsSuujero: ; 1
	ret ; TBE

SeviiEightIslandCaveScript_ShowAndMoveBlue: ; 2
; dialogues
	ld a, 4
	call PrintScriptText_SafetyWrapper
; turn player
	ld a, SPRITE_FACING_DOWN
	ld [wSpritePlayerStateData1FacingDirection], a
; show and move Blue
	ld a, HS_SEVII_EIGHT_ISLAND_CAVE_BLUE
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld de, SeviiEightIslandCave_BlueMovementsIn
	ld a, 2
	ldh [hSpriteIndex], a
	call MoveSprite
; script handling
	ld a, 3
	ld [wCurMapScript], a
	ret

SeviiEightIslandCaveScript_WaitAndFixBlue: ; 3
; wait for Blue movements
	ld a, [wd730]
	bit 0, a
	ret nz
; fix Blue facings
	ld a, 2
	ldh [hSpriteIndex], a
	lb bc, STAY, RIGHT
	call ChangeSpriteMovementBytes ; new from Engeze
; turn player
	ld a, SPRITE_FACING_LEFT
	ld [wSpritePlayerStateData1FacingDirection], a
; script handling
	ld a, 4
	ld [wCurMapScript], a
	ret

SeviiEightIslandCaveScript_BlueFirstDialogueAndShowAndMovePink: ; 4
; dialogues
	ld a, 5
	call PrintScriptText_SafetyWrapper
; turn player
	ld a, SPRITE_FACING_DOWN
	ld [wSpritePlayerStateData1FacingDirection], a
; dialogues
	ld a, 6
	call PrintScriptText_SafetyWrapper
; show and move Pink
	ld a, HS_SEVII_EIGHT_ISLAND_CAVE_PINK
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld de, SeviiEightIslandCave_PinkMovementsIn
	ld a, 3
	ldh [hSpriteIndex], a
	call MoveSprite
; script handling
	ld a, 5
	ld [wCurMapScript], a
	ret

SeviiEightIslandCaveScript_WaitAndFixPink: ; 5
; wait for Pink movements
	ld a, [wd730]
	bit 0, a
	ret nz
; turn player
	ld a, SPRITE_FACING_RIGHT
	ld [wSpritePlayerStateData1FacingDirection], a
; fix Pink facings
	ld a, 3
	ldh [hSpriteIndex], a
	lb bc, STAY, LEFT
	call ChangeSpriteMovementBytes ; new from Engeze
; script handling
	ld a, 6
	ld [wCurMapScript], a
	ret

SeviiEightIslandCaveScript_PinkFirstDialogue: ; 6
; dialogues
	ld a, 7
	call PrintScriptText_SafetyWrapper
; script handling
	ld a, 7
	ld [wCurMapScript], a
	ret

SeviiEightIslandCaveScript_SuujeroSaysBattleRoyal1: ; 7
; dialogues
	ld a, 8
	call PrintScriptText_SafetyWrapper
; script handling
	ld a, 8
	ld [wCurMapScript], a
	ret

SeviiEightIslandCaveScript_SuujeroSaysBattleRoyal2: ; 8
; fix Blue facings
	ld a, 2
	ldh [hSpriteIndex], a
	lb bc, STAY, UP
	call ChangeSpriteMovementBytes ; new from Engeze
	lb de, 2, SPRITE_FACING_UP
	callfar ChangeSpriteFacing ; new Pigeon approach
; fix Pink facings
	ld a, 3
	ldh [hSpriteIndex], a
	lb bc, STAY, UP
	call ChangeSpriteMovementBytes ; new from Engeze
	lb de, 3, SPRITE_FACING_UP
	callfar ChangeSpriteFacing ; new Pigeon approach
; turn player
	ld a, SPRITE_FACING_UP
	ld [wSpritePlayerStateData1FacingDirection], a
; script handling
	ld a, 9
	ld [wCurMapScript], a
	ret

SeviiEightIslandCaveScript_SuujeroSaysBattleRoyal3: ; 9
; dialogues
	ld a, 9
	call PrintScriptText_SafetyWrapper
; turn player
	ld a, SPRITE_FACING_LEFT
	ld [wSpritePlayerStateData1FacingDirection], a
; fix Blue facings
	ld a, 2
	ldh [hSpriteIndex], a
	lb bc, STAY, RIGHT
	call ChangeSpriteMovementBytes ; new from Engeze
	lb de, 2, SPRITE_FACING_RIGHT
	callfar ChangeSpriteFacing ; new Pigeon approach
; fix Pink facings
	ld a, 3
	ldh [hSpriteIndex], a
	lb bc, STAY, LEFT
	call ChangeSpriteMovementBytes ; new from Engeze
	lb de, 3, SPRITE_FACING_LEFT
	callfar ChangeSpriteFacing ; new Pigeon approach
; script handling
	ld a, 10
	ld [wCurMapScript], a
	ret

SeviiEightIslandCaveScript_StartBlueBattle: ; 10
; dialogues
	ld a, 10
	call PrintScriptText_SafetyWrapper
; set up battle vs Blue
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_RIVAL3
	ld [wCurOpponent], a
	ld a, 34
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, SeviiEightIslandCaveBlueDefeatedText
	ld de, SeviiEightIslandCaveBlueBeatYouText
	call SaveEndBattleTextPointers
; restore joypad control
	ld a, $0
	ld [wJoyIgnore], a
; script handling
	ld a, 11
	ld [wCurMapScript], a
	ret

SeviiEightIslandCaveScript_StartPinkBattle: ; 11
; did we lose?
	ld a, [wIsInBattle]
	cp $ff
	jp z, SeviiEightIslandCaveResetScripts
; dialogues
	ld a, 11
	call PrintScriptText_SafetyWrapper
; turn player
	ld a, SPRITE_FACING_RIGHT
	ld [wSpritePlayerStateData1FacingDirection], a
; dialogues
	ld a, 12
	call PrintScriptText_SafetyWrapper
; set up battle vs Pink
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_PINK
	ld [wCurOpponent], a
	ld a, 5
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, SeviiEightIslandCavePinkDefeatedText
	ld de, SeviiEightIslandCavePinkBeatYouText
	call SaveEndBattleTextPointers
; restore joypad control
	ld a, $0
	ld [wJoyIgnore], a
; script handling
	ld a, 12
	ld [wCurMapScript], a
	ret

SeviiEightIslandCaveScript_PostPinkBattle: ; 12
; did we lose?
	ld a, [wIsInBattle]
	cp $ff
	jp z, SeviiEightIslandCaveResetScripts
; set victory event
	SetEvent EVENT_EIGHT_ISLAND_CAVE_BEAT_BOTH_BLUE_AND_PINK
; dialogues
	ld a, 13
	call PrintScriptText_SafetyWrapper
; script handling
	ld a, 13
	ld [wCurMapScript], a
	ret

SeviiEightIslandCaveScript_BlueDialoguesPreGoAway: ; 13
; turn player
	ld a, SPRITE_FACING_UP
	ld [wSpritePlayerStateData1FacingDirection], a
; dialogues
	ld a, 14
	call PrintScriptText_SafetyWrapper
; script handling
	ld a, 14
	ld [wCurMapScript], a
	ret

SeviiEightIslandCaveScript_BlueGoesAway: ; 14
; turn player
	ld a, SPRITE_FACING_LEFT
	ld [wSpritePlayerStateData1FacingDirection], a
; dialogues
	ld a, 15
	call PrintScriptText_SafetyWrapper
; turn player
	ld a, SPRITE_FACING_DOWN
	ld [wSpritePlayerStateData1FacingDirection], a
; Blue goes away
	ld de, SeviiEightIslandCave_BlueMovementsOut
	ld a, 2
	ldh [hSpriteIndex], a
	call MoveSprite
; script handling
	ld a, 15
	ld [wCurMapScript], a
	ret

SeviiEightIslandCaveScript_WaitAndHideBluePinkDialoguesPreGoAway: ; 15
; wait for Blue movements
	ld a, [wd730]
	bit 0, a
	ret nz
	ld a, HS_SEVII_EIGHT_ISLAND_CAVE_BLUE
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
; turn player
	ld a, SPRITE_FACING_RIGHT
	ld [wSpritePlayerStateData1FacingDirection], a
; restore joypad control
	ld a, $0
	ld [wJoyIgnore], a
; dialogues
	ld a, 16
	call PrintScriptText_SafetyWrapper
; script handling
	ld a, 16
	ld [wCurMapScript], a
	ret

SeviiEightIslandCaveScript_PinkGoesAway: ; 16
; turn player
	ld a, SPRITE_FACING_DOWN
	ld [wSpritePlayerStateData1FacingDirection], a
; Pink goes away
	ld de, SeviiEightIslandCave_PinkMovementsOut
	ld a, 3
	ldh [hSpriteIndex], a
	call MoveSprite
; script handling
	ld a, 17
	ld [wCurMapScript], a
	ret

SeviiEightIslandCaveScript_WaitAndHidePink: ; 17
; wait for Pink movements
	ld a, [wd730]
	bit 0, a
	ret nz
	ld a, HS_SEVII_EIGHT_ISLAND_CAVE_PINK
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
; turn player
	ld a, SPRITE_FACING_UP
	ld [wSpritePlayerStateData1FacingDirection], a
; restore joypad control
	ld a, $0
	ld [wJoyIgnore], a
; dialogues
	ld a, 17
	call PrintScriptText_SafetyWrapper
; script handling
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

SeviiEightIslandCaveResetScripts:
	ld a, HS_SEVII_EIGHT_ISLAND_CAVE_BLUE
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld a, HS_SEVII_EIGHT_ISLAND_CAVE_PINK
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

SeviiEightIslandCave_BlueMovementsIn:
SeviiEightIslandCave_PinkMovementsIn:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db -1 ; end

SeviiEightIslandCave_BlueMovementsOut:
SeviiEightIslandCave_PinkMovementsOut:
	db NPC_FAST_MOVEMENT_DOWN
	db NPC_FAST_MOVEMENT_DOWN
	db NPC_FAST_MOVEMENT_DOWN
	db NPC_FAST_MOVEMENT_DOWN
	db NPC_FAST_MOVEMENT_DOWN
	db -1 ; end

; input: a = text ID
PrintScriptText_SafetyWrapper:
	ldh [hSpriteIndexOrTextID], a
; restore joypad control
	ld a, $0
	ld [wJoyIgnore], a
; dialogue
	call DisplayTextID
; block joypad control
	ld a, $ff
	ld [wJoyIgnore], a
	ret

; texts ===========================================

SeviiEightIslandCave_TextPointers:
	dw SeviiEightIslandCaveText1 ; Suujero
	dw SeviiEightIslandCaveText2 ; Blue
	dw SeviiEightIslandCaveText3 ; Pink
	; scripts
	dw SeviiEightIslandCaveTextScript4  ;  4, Blue arrives
	dw SeviiEightIslandCaveTextScript5  ;  5, Blue dialogue
	dw SeviiEightIslandCaveTextScript6  ;  6, Pink arrives
	dw SeviiEightIslandCaveTextScript7  ;  7, Pink dialogue
	dw SeviiEightIslandCaveTextScript8  ;  8, Suujero battle royal 1
	dw SeviiEightIslandCaveTextScript9  ;  9, Suujero battle royal 2
	dw SeviiEightIslandCaveTextScript10 ; 10, Blue battle
	dw SeviiEightIslandCaveTextScript11 ; 11, post Blue battle
	dw SeviiEightIslandCaveTextScript12 ; 12, Pink battle
	dw SeviiEightIslandCaveTextScript13 ; 13, post Pink battle
	dw SeviiEightIslandCaveTextScript14 ; 14, Suujero comments
	dw SeviiEightIslandCaveTextScript15 ; 15, Blue goes away
	dw SeviiEightIslandCaveTextScript16 ; 16, Pink goes away
	dw SeviiEightIslandCaveTextScript17 ; 17, Suujero comment

; Suujero ------------------------------------

SeviiEightIslandCaveText1:
	text_asm
	ld hl, SeviiEightIslandCaveText1_Intro
	call PrintText

	CheckEvent EVENT_EIGHT_ISLAND_CAVE_BEAT_BOTH_BLUE_AND_PINK
	jr nz, .postBattleDialogue
; load next script
	ld a, 2
	ld [wCurMapScript], a
	jp .done

.postBattleDialogue
	call SuujeroRewardChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .limitBreaker
	dec a
	jr z, .ultimateBattle
	dec a
	jr z, .anyPokemon

; decline
	ld hl, SeviiEightIslandCaveText1_Declined
	call PrintText
	jp .done

.limitBreaker
	ld hl, SeviiEightIslandCaveText1_OptedForLimitBreaker
	call PrintText
	lb bc, LIMIT_BREAKER, 1
	call GiveItem
	jr nc, .bagFull
	ld hl, SeviiEightIslandCaveText1_ReceivedLimitBreaker
	call PrintText
	jr .resetSages
.bagFull
	ld hl, SeviiEightIslandCaveText1_BagFull
	jr .printAndEnd

.ultimateBattle
	ld hl, SeviiEightIslandCaveText1_OptedForUltimateBattle
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, wOptions
	res 7, [hl] ; turn on battle animations
	set 6, [hl] ; battle style set
	call Delay3
	ld a, OPP_SUUJERO
	ld [wCurOpponent], a
	ld a, 1
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, SeviiEightIslandCaveSuujeroDefeatedText
	ld de, SeviiEightIslandCaveSuujeroBeatYouText
	call SaveEndBattleTextPointers
; apply evil entry Hazards
	ld a, 1
	ld [wUniQuizAnswer+6], a ; rocks
	ld [wUniQuizAnswer+9], a ; web
	inc a
	ld [wUniQuizAnswer+8], a ; toxic spikes
	inc a
	ld [wUniQuizAnswer+7], a ; spikes
; load next script
;	ld a, 1 ; TBE
;	ld [wCurMapScript], a
	jr .done

.anyPokemon
	ld hl, SeviiEightIslandCaveText1_OptedForAnyPokemon
	call PrintText
	call SaveScreenTilesToBuffer1
	callfar ShowAttackdexMenu ; ShowChoicedexMenu
	call LoadScreenTilesFromBuffer1

.resetSages
	ResetEvent EVENT_DEFEATED_SEVII_SAGE_ICHINO
	ResetEvent EVENT_DEFEATED_SEVII_SAGE_NIUE
	ResetEvent EVENT_DEFEATED_SEVII_SAGE_SANTRE
	ResetEvent EVENT_DEFEATED_SEVII_SAGE_YOTTRO
	ResetEvent EVENT_DEFEATED_SEVII_SAGE_GONQUE
	ResetEvent EVENT_DEFEATED_SEVII_SAGE_ROKUSEI
	ResetEvent EVENT_DEFEATED_SEVII_SAGE_NANETTE
	; TBE: else? warp you out and close the cave again?
	ld hl, SeviiEightIslandCaveText1_Done
.printAndEnd
	call PrintText
.done
	jp TextScriptEnd


SeviiEightIslandCaveText1_ReceivedLimitBreaker:
	text_far _SeviiEightIslandCaveText1_ReceivedLimitBreaker
	sound_get_key_item
	text_end

SeviiEightIslandCaveText1_BagFull:
	text_far _SeviiEightIslandCaveText1_BagFull
	text_end

SeviiEightIslandCaveText1_OptedForLimitBreaker:
	text_far _SeviiEightIslandCaveText1_OptedForLimitBreaker
	text_end

SeviiEightIslandCaveText1_OptedForUltimateBattle:
	text_far _SeviiEightIslandCaveText1_OptedForUltimateBattle
	text_end

SeviiEightIslandCaveText1_OptedForAnyPokemon:
	text_far _SeviiEightIslandCaveText1_OptedForAnyPokemon
	text_end

SeviiEightIslandCaveText1_Declined:
	text_far _SeviiEightIslandCaveText1_Declined
	text_end

SeviiEightIslandCaveSuujeroDefeatedText:
	text_far _SeviiEightIslandCaveSuujeroDefeatedText
	text_end

SeviiEightIslandCaveSuujeroBeatYouText:
	text_far _SeviiEightIslandCaveSuujeroBeatYouText
	text_end

SeviiEightIslandCaveText1_Done:
	text_far _SeviiEightIslandCaveText1_Done
	text_end

SeviiEightIslandCaveText1_Intro:
	text_far _SeviiEightIslandCaveText1_Intro
	text_end

SuujeroRewardChoice:
	call SaveScreenTilesToBuffer1
	ld a, SUUJERO_CHOICES_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld hl, wTopMenuItemY
	ld a, 5
	ld [hli], a ; top menu item Y
	ld a, 6
	ld [hli], a ; top menu item X
	xor a
	ld [hli], a ; current menu item ID
	inc hl
	ld a, 3 ; number of options - 1?
	ld [hli], a ; wMaxMenuItem
	ld a, B_BUTTON | A_BUTTON
	ld [hli], a ; wMenuWatchedKeys
	xor a
	ld [hl], a ; wLastMenuItem
	call HandleMenuInput
	bit BIT_B_BUTTON, a
	jr nz, .decline ; if B was pressed
; A was pressed
	call PlaceUnfilledArrowMenuCursor
	ld a, [wCurrentMenuItem]
	jp LoadScreenTilesFromBuffer1
.decline
	ld a, 3
	ld [wCurrentMenuItem], a
	jp LoadScreenTilesFromBuffer1

; Blue and Pink ------------------------

SeviiEightIslandCaveText2:
	text_far _SeviiEightIslandCaveText2
	text_end

SeviiEightIslandCaveText3:
	text_far _SeviiEightIslandCaveText3
	text_end

; ----

SeviiEightIslandCaveTextScript4:
	text_far _SeviiEightIslandCaveTextScript4
	text_end

SeviiEightIslandCaveTextScript5:
	text_far _SeviiEightIslandCaveTextScript5
	text_end

SeviiEightIslandCaveTextScript6:
	text_far _SeviiEightIslandCaveTextScript6
	text_end

SeviiEightIslandCaveTextScript7:
	text_far _SeviiEightIslandCaveTextScript7
	text_end

SeviiEightIslandCaveTextScript8:
	text_far _SeviiEightIslandCaveTextScript8
	text_end

SeviiEightIslandCaveTextScript9:
	text_far _SeviiEightIslandCaveTextScript9
	text_end

SeviiEightIslandCaveTextScript10:
	text_far _SeviiEightIslandCaveTextScript10
	text_end

SeviiEightIslandCaveTextScript11:
	text_far _SeviiEightIslandCaveTextScript11
	text_end

SeviiEightIslandCaveTextScript12:
	text_far _SeviiEightIslandCaveTextScript12
	text_end

SeviiEightIslandCaveTextScript13:
	text_far _SeviiEightIslandCaveTextScript13
	text_end

SeviiEightIslandCaveTextScript14:
	text_far _SeviiEightIslandCaveTextScript14
	text_end

SeviiEightIslandCaveTextScript15:
	text_far _SeviiEightIslandCaveTextScript15
	text_end

SeviiEightIslandCaveTextScript16:
	text_far _SeviiEightIslandCaveTextScript16
	text_end

SeviiEightIslandCaveTextScript17:
	text_far _SeviiEightIslandCaveTextScript17
	text_end

; ----

SeviiEightIslandCaveBlueDefeatedText:
	text_far _SeviiEightIslandCaveBlueDefeatedText
	text_end

SeviiEightIslandCaveBlueBeatYouText:
	text_far _SeviiEightIslandCaveBlueBeatYouText
	text_end

SeviiEightIslandCavePinkDefeatedText:
	text_far _SeviiEightIslandCavePinkDefeatedText
	text_end

SeviiEightIslandCavePinkBeatYouText:
	text_far _SeviiEightIslandCavePinkBeatYouText
	text_end
