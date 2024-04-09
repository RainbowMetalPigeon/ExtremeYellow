ChampionsRoom_Script:
	call EnableAutoTextBoxDrawing
	ld hl, ChampionsRoom_ScriptPointers
	ld a, [wChampionsRoomCurScript]
	call CallFunctionInTable
	ret

ResetGaryScript:
	xor a
	ld [wJoyIgnore], a
	ld [wChampionsRoomCurScript], a
	ret

ChampionsRoom_ScriptPointers:
	dw GaryScript0
	dw GaryScript1
	dw GaryScript2
	dw GaryScript3
	dw GaryScript4
	dw GaryScript5
	dw GaryScript6
	dw GaryScript7
	dw GaryScript8
	dw GaryScript9
	dw GaryScript10
	dw GaryScript2ndBattle ; $b

; ==================================

GaryScript0:
	ret

; ==================================

GaryScript1:
	ld a, $ff
	ld [wJoyIgnore], a
	ld hl, wSimulatedJoypadStatesEnd
	ld de, GaryEntrance_RLEMovement
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
	ld a, $2
	ld [wChampionsRoomCurScript], a
	ret

GaryEntrance_RLEMovement:
	db D_UP, 1
	db D_RIGHT, 1
	db D_UP, 3
	db -1 ; end

; ==================================

GaryScript2:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	xor a
	ld [wJoyIgnore], a
	ld hl, wOptions
	res 7, [hl]  ; Turn on battle animations to make the battle feel more epic.
	ld a, $1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call Delay3
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld a, OPP_RIVAL3
	ld [wCurOpponent], a

	; select which team to use during the encounter
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE ; have we beaten the game at least once?
	jr z, .loadTeamNumber1 ; if not, proceed with loading the team number 1
	; if we did beat the game at least once, we need to check if it's the post-gym-leader-rematch team or not
	CheckEvent EVENT_BEAT_ALL_GYMS_REMATCH
	jr z, .loadTeamNumber3
	; if we arrived here, then it's post-game and post-gym-rematches
	jr .loadTeamNumber5
.loadTeamNumber1
	ld hl, GaryDefeatedText_BG
	ld de, GaryVictoryText_BG
	call SaveEndBattleTextPointers
	ld a, $1
	jr .continuePostLoadingTeam1
.loadTeamNumber3
	ld hl, GaryDefeatedText_AG_BGR
	ld de, GaryVictoryText_AG_BGR
	call SaveEndBattleTextPointers
	ld a, $3
	jr .continuePostLoadingTeam1
.loadTeamNumber5
	ld hl, GaryDefeatedText_AG_AGR
	ld de, GaryVictoryText_AG_AGR
	call SaveEndBattleTextPointers
	ld a, $5
.continuePostLoadingTeam1
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200

	xor a
	ldh [hJoyHeld], a
	ld a, $b ; edited, to be changed if I rearrange all the scripts
	ld [wChampionsRoomCurScript], a
	ret

; ==================================

GaryScript2ndBattle:
	ld a, [wIsInBattle]
	cp $ff
	jp z, ResetGaryScript

	xor a                            ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	xor a
	ld [wJoyIgnore], a

	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE
	jr z, .firstTimeAtLeague
	; we are here if it's post-game. We need to display the question for the second battle,
	; and if we agree, we choose the team depending on the rematches with the gym leaders
	ld a, $7 ; all the other checks and text displaying are left to this text
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	jr .postTextNotFirstTimeAtLeague
.firstTimeAtLeague
	ld a, $6
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld hl, GaryDefeatedText2ndBattle_BG
	ld de, GaryVictoryText2ndBattle_BG
	call SaveEndBattleTextPointers
	ld a, $2
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	call Delay3
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld a, OPP_RIVAL3
	ld [wCurOpponent], a

.postTextNotFirstTimeAtLeague
	xor a
	ldh [hJoyHeld], a
	ld a, $3
	ld [wChampionsRoomCurScript], a
	ret

; ==================================

GaryScript3:
	ld a, [wIsInBattle]
	cp $ff
	jp z, ResetGaryScript

	xor a                            ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	call UpdateSprites
	SetEvent EVENT_BEAT_CHAMPION_RIVAL

	; new, set the flag for the supervictory, if appropriate
	CheckEvent EVENT_BEAT_ALL_GYMS_REMATCH
	jr z, .continue
	CheckEvent EVENT_ENGAGED_CHAMPION_FINAL_REMATCH
	jr z, .continue
	SetEvent EVENT_BEAT_CHAMPION_FINAL_REMATCH ; this makes the SS Anne return, which in turn allows to battle PIGEON (eheh)
	; also spawn another tourist
	ld a, HS_LUNAR_SHRINE_TOURIST_4
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
.continue
	; back to vanilla code

	ld a, $f0
	ld [wJoyIgnore], a
	ld a, $1
	ldh [hSpriteIndexOrTextID], a
	call GaryScript_f0JoyIgnoreDisplayTextffJoyIgnore
	ld a, $1
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, $4
	ld [wChampionsRoomCurScript], a
	ret

; ==================================

GaryScript4: ; Oak calls you and walks towards you
	farcall Music_Cities1AlternateTempo
; Oak calls you two
	ld a, $2
	ldh [hSpriteIndexOrTextID], a
	call GaryScript_f0JoyIgnoreDisplayTextffJoyIgnore
; prepare Oak for movement?
	ld a, $2
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
; Oak walks upward
	ld de, OakEntranceAfterVictoryMovement
	ld a, $2
	ldh [hSpriteIndex], a
	call MoveSprite
; Show Oak (interesting that it's done now and not before the movement)
	ld a, HS_CHAMPIONS_ROOM_OAK
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra ; edited, new HS function
; new, Blue facing downward, testing
	ld a, $1
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_DOWN
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
; load next script
	ld a, $5
	ld [wChampionsRoomCurScript], a
	ret

OakEntranceAfterVictoryMovement:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db -1 ; end

; ==================================

; all changes of direction and talkings here, pre-postgame only
GaryScript5:
	ld a, [wd730]
	bit 0, a
	ret nz
; player facing Oak
	ld a, PLAYER_DIR_LEFT
	ld [wPlayerMovingDirection], a
; Blue facing Oak
	ld a, $1
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_LEFT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
; Oak facing Rival
	ld a, $2
	ldh [hSpriteIndex], a
	ld a,  SPRITE_FACING_RIGHT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
; load script 6 for post-game interactions
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE
	jr z, .notPostGame ; if not, continue with end-game stuff
; if yes, load post-game script
	ld a, $6
	ld [wChampionsRoomCurScript], a
	ret
.notPostGame ; --------------------
; Oak & Rival talk
	ld a, $3
	ldh [hSpriteIndexOrTextID], a
	call GaryScript_f0JoyIgnoreDisplayTextffJoyIgnore
; Oak facing Player
	ld a, $2
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_DOWN
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
; Oak talks
	ld a, $4
	ldh [hSpriteIndexOrTextID], a
	call GaryScript_f0JoyIgnoreDisplayTextffJoyIgnore
; Oak facing Rival
	ld a, $2
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_RIGHT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
; Oak and Rival talk
	ld a, $0b
	ldh [hSpriteIndexOrTextID], a
	call GaryScript_f0JoyIgnoreDisplayTextffJoyIgnore
; let the hug sink in for a bit... :)
	ld c, 200 ; feel about right :)
	call DelayFrames
; load next script
	ld a, $7
	ld [wChampionsRoomCurScript], a
	ret

; ==================================

; all changes of direction and talkings here, postgame only
GaryScript6:
; Oak talks
	ld a, $0c
	ldh [hSpriteIndexOrTextID], a
	call GaryScript_f0JoyIgnoreDisplayTextffJoyIgnore
; load next script
	ld a, $7
	ld [wChampionsRoomCurScript], a
	ret

; ==================================

GaryScript7: ; Oak faces and talks to Player and then leaves the room for the HoF
; Blue facing Oak (why is it even necessary to re-state this?)
	ld a, $1
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_LEFT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
; Oak facing Player
	ld a, $2
	ldh [hSpriteIndex], a
	xor a ; SPRITE_FACING_DOWN
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
; Oak talks
	ld a, $5
	ldh [hSpriteIndexOrTextID], a
	call GaryScript_f0JoyIgnoreDisplayTextffJoyIgnore
; Oak walks towards HoF
	ld de, OaksExitGaryRoomMovement
	ld a, $2
	ldh [hSpriteIndex], a
	call MoveSprite
; Blue walks towards HoF (oh cute, they walk together :3)
	ld de, OaksExitGaryRoomMovement
	ld a, $1
	ldh [hSpriteIndex], a
	call MoveSprite
; load nextr script
	ld a, $8
	ld [wChampionsRoomCurScript], a
	ret

OaksExitGaryRoomMovement:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db -1 ; end

; ==================================

GaryScript8: ; hide the Oaks
	ld a, [wd730]
	bit 0, a
	ret nz
; hide Oak
	ld a, HS_CHAMPIONS_ROOM_OAK
	ld [wMissableObjectIndex], a
	predef HideObjectExtra ; edited, new HS function
; hide Rival
	ld a, HS_CHAMPIONS_ROOM_RIVAL
	ld [wMissableObjectIndex], a
	predef HideObjectExtra ; edited, new HS function
; load next script
	ld a, $9
	ld [wChampionsRoomCurScript], a
	ret

; ==================================

GaryScript9:
	ld a, $ff
	ld [wJoyIgnore], a
	ld hl, wSimulatedJoypadStatesEnd
	ld de, WalkToHallOfFame_RLEMovment
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
	ld a, $a
	ld [wChampionsRoomCurScript], a
	ret

WalkToHallOfFame_RLEMovment:
	db D_UP, 4
;	db D_LEFT, 1 ; not needed anymore, but makes the HoF movements flow better?
	db -1 ; end

; ==================================

GaryScript10:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, $0
	ld [wChampionsRoomCurScript], a
	ret

; ==================================

GaryScript_f0JoyIgnoreDisplayTextffJoyIgnore:
	ld a, $f0
	ld [wJoyIgnore], a
	call DisplayTextID
	ld a, $ff
	ld [wJoyIgnore], a
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ChampionsRoom_TextPointers: ; goddess, the order is such a mess xD
	dw GaryText1				; 1 - before/after first battle(s, including rematches)
	dw GaryText2				; 2 - simply Oak that calls you
	dw GaryText3				; 3 - Oak compliments Rival, Rival embarassed
	dw GaryText4				; 4 - Oak compliments Player, Rival silent
	dw GaryText5				; 5 - Oak come with me to HoF
	dw GaryText2ndBattle_BG		; 6 - second battle, before post game
	dw GaryText2ndBattle_AG		; 7 - second battle, post game, asking if we want to do it
	dw GaryText2ndBattle_AG_BGL	; 8 - second battle accepted, before gym leaders' rematches
	dw GaryText2ndBattle_AG_AGL	; 9 - second battle accepted, after gym leaders' rematches
	dw GaryText2ndBattle_AG_Refused	; 0a - second battle refused
	dw GaryText6                ; 0b - long emotional conversation between Oak and Rival
	dw GaryText7				; 0c - Oak compliments Rival and Player for having repeated their achievements

; ==================================

GaryText1:
	text_asm
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE
	jr nz, .postGame
	; first time at the League
	CheckEvent EVENT_BEAT_CHAMPION_RIVAL
	ld hl, GaryChampionIntroText_BG
	jr z, .printText
	ld hl, GaryText_OWPostDefeat_BG
	jr .printText
.postGame
	CheckEvent EVENT_BEAT_ALL_GYMS_REMATCH
	jr nz, .postGymRematches
	; post game, but gym rematches not completed
	CheckEvent EVENT_BEAT_CHAMPION_RIVAL
	ld hl, GaryChampionIntroText_AG_BGR
	jr z, .printText
	ld hl, GaryText_OWPostDefeat_AG_BGR
	jr .printText
.postGymRematches
	; post game and gym rematches completed
	CheckEvent EVENT_BEAT_CHAMPION_RIVAL
	ld hl, GaryChampionIntroText_AG_AGR
	jr z, .printText
	ld hl, GaryText_OWPostDefeat_AG_AGR
	jr .printText
.printText
	call PrintText
	jp TextScriptEnd

; --------

GaryChampionIntroText_BG:
	text_far _GaryChampionIntroText_BG
	text_end

GaryText_OWPostDefeat_BG:
	text_far _GaryText_OWPostDefeat_BG
	text_end

GaryDefeatedText_BG:
	text_far _GaryDefeatedText_BG
	text_end

GaryVictoryText_BG:
	text_far _GaryVictoryText_BG
	text_end

; --------

GaryChampionIntroText_AG_BGR:
	text_far _GaryChampionIntroText_AG_BGR
	text_end

GaryText_OWPostDefeat_AG_BGR:
	text_far _GaryText_OWPostDefeat_AG_BGR
	text_end

GaryDefeatedText_AG_BGR:
	text_far _GaryDefeatedText_AG_BGR
	text_end

GaryVictoryText_AG_BGR:
	text_far _GaryVictoryText_AG_BGR
	text_end

; --------

GaryChampionIntroText_AG_AGR:
	text_far _GaryChampionIntroText_AG_AGR
	text_end

GaryText_OWPostDefeat_AG_AGR:
	text_far _GaryText_OWPostDefeat_AG_AGR
	text_end

GaryDefeatedText_AG_AGR:
	text_far _GaryDefeatedText_AG_AGR
	text_end

GaryVictoryText_AG_AGR:
	text_far _GaryVictoryText_AG_AGR
	text_end

; ==================================

GaryText2:
	text_far _GaryText2
	text_end

; ==================================

GaryText3:
	text_asm
	ld hl, GaryText3_OakCompliment
	call PrintText
	ld hl, GaryText3_RivalEmbarassed
	call PrintText
	jp TextScriptEnd

; --------

GaryText3_OakCompliment:
	text_far _GaryText3_OakCompliment
	text_end

GaryText3_RivalEmbarassed:
	text_far _GaryText3_RivalEmbarassed
	text_end

; ==================================

GaryText4:
	text_asm
	ld hl, GaryText4_OakAcknowledgePlayer
	call PrintText
	ld hl, GaryText4_RivalSore
	call PrintText
	jp TextScriptEnd

GaryText4_OakAcknowledgePlayer:
	text_far _GaryText4_OakAcknowledgePlayer
	text_end

GaryText4_RivalSore:
	text_far _GaryText4_RivalSore
	text_end

; ==================================

GaryText6:
	text_asm
	ld hl, GaryText6_OakScoldsRival
	call PrintText
	ld c, 20 ; testing
	call DelayFrames
	ld hl, GaryText6_RivalGrudge
	call PrintText
	ld c, 20 ; testing
	call DelayFrames
	ld hl, GaryText6_OakAmaze
	call PrintText
	ld c, 20 ; testing
	call DelayFrames
	ld hl, GaryText6_RivalUnbelief
	call PrintText
	ld c, 20 ; testing
	call DelayFrames
	ld hl, GaryText6_OakSorrow
	call PrintText
	ld c, 20 ; testing
	call DelayFrames
	ld hl, GaryText6_RivalSobbing
	call PrintText
	ld c, 20 ; testing
	call DelayFrames
	ld hl, GaryText6_OakHug
	call PrintText
	jp TextScriptEnd

GaryText6_OakScoldsRival:
	text_far _GaryText6_OakScoldsRival
	text_end

GaryText6_RivalGrudge:
	text_far _GaryText6_RivalGrudge
	text_end

GaryText6_OakAmaze:
	text_far _GaryText6_OakAmaze
	text_end

GaryText6_RivalUnbelief:
	text_far _GaryText6_RivalUnbelief
	text_end

GaryText6_OakSorrow:
	text_far _GaryText6_OakSorrow
	text_end

GaryText6_RivalSobbing:
	text_far _GaryText6_RivalSobbing
	text_end

GaryText6_OakHug:
	text_far _GaryText6_OakHug
	text_end

; ==================================

GaryText7:
	text_asm
	ld hl, GaryText7_OakYouDidItAgain
	call PrintText
	jp TextScriptEnd

GaryText7_OakYouDidItAgain:
	text_far _GaryText7_OakYouDidItAgain
	text_end

; ==================================

GaryText5:
	text_asm
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE
	jr nz, .postGame
	ld hl, GaryText5_OakLetsCelebrate
	jr .printText
.postGame
	ld hl, GaryText5_OakLetsCelebrate_AG
.printText
	call PrintText
	jp TextScriptEnd

GaryText5_OakLetsCelebrate:
	text_far _GaryText5_OakLetsCelebrate
	text_end

GaryText5_OakLetsCelebrate_AG:
	text_far _GaryText5_OakLetsCelebrate_AG
	text_end

; ==================================

GaryText2ndBattle_BG:
	text_far _GaryText2ndBattle_BG
	text_end

GaryDefeatedText2ndBattle_BG:
	text_far _GaryDefeatedText2ndBattle_BG
	text_end

GaryVictoryText2ndBattle_BG:
	text_far _GaryVictoryText2ndBattle_BG
	text_end

; --------

GaryText2ndBattle_AG: ; beefy text that is de facto the script handling the second fight, it's all here to avoid the need to press A twice to advance
	text_asm
	ld hl, GaryText2ndBattle_AG_txtPointer
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem] ; YES=0, NO=1
	and a ; z flag set if a=0=YES, so if we go for the second battle
	jr z, .yesSecondBattleOptional ; if we accept to do the second battle
	ld hl, GaryText2ndBattle_AG_Refused
	call PrintText
	jp .noSecondBattle ; if we refuse to do the second battle
.yesSecondBattleOptional
	; select which team to use during the encounter
	; if we did beat the game at least once, we need to check if it's the post-gym-leader-rematch team or not
	CheckEvent EVENT_BEAT_ALL_GYMS_REMATCH
	jr z, .loadTeamNumber4
	; if we arrived here, then it's post-game and post-gym-rematches
	jr .loadTeamNumber6
.loadTeamNumber4
	ld hl, GaryText2ndBattle_AG_BGL
	call PrintText
	ld hl, GaryDefeatedText2ndBattle_AG_BGL
	ld de, GaryVictoryText2ndBattle_AG_BGL
	call SaveEndBattleTextPointers
	ld a, $4
	ld [wTrainerNo], a
	jr .finishSettingBattleParameters
.loadTeamNumber6
	SetEvent EVENT_ENGAGED_CHAMPION_FINAL_REMATCH ; new, testing
	ld hl, GaryText2ndBattle_AG_AGL
	call PrintText
	ld hl, GaryDefeatedText2ndBattle_AG_AGL
	ld de, GaryVictoryText2ndBattle_AG_AGL
	call SaveEndBattleTextPointers
	ld a, $6
	ld [wTrainerNo], a
.finishSettingBattleParameters
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	call Delay3
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld a, OPP_RIVAL3
	ld [wCurOpponent], a
.noSecondBattle
	jp TextScriptEnd

GaryText2ndBattle_AG_txtPointer: ; what an abomination I did lol
	text_far _GaryText2ndBattle_AG
	text_end

GaryText2ndBattle_AG_Refused:
	text_far _GaryText2ndBattle_AG_Refused
	text_end

; --------

GaryText2ndBattle_AG_BGL:
	text_far _GaryText2ndBattle_AG_BGL
	text_end

GaryDefeatedText2ndBattle_AG_BGL:
	text_far _GaryDefeatedText2ndBattle_AG_BGL
	text_end

GaryVictoryText2ndBattle_AG_BGL:
	text_far _GaryVictoryText2ndBattle_AG_BGL
	text_end

; --------

GaryText2ndBattle_AG_AGL:
	text_far _GaryText2ndBattle_AG_AGL
	text_end

GaryDefeatedText2ndBattle_AG_AGL:
	text_far _GaryDefeatedText2ndBattle_AG_AGL
	text_end

GaryVictoryText2ndBattle_AG_AGL:
	text_far _GaryVictoryText2ndBattle_AG_AGL
	text_end
