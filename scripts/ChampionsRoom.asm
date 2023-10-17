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

GaryScript0:
	ret

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
.temporary
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, GaryDefeatedText
	ld de, GaryVictoryText
	call SaveEndBattleTextPointers
	ld a, OPP_RIVAL3
	ld [wCurOpponent], a

	; select which team to use during the encounter
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE ; have we beaten the game at least once?
	jr z, .loadTeam1Number1 ; if not, proceed with loading the team number 1
	; if we did beat the game at least once, we need to check if it's the post-gym-leader-rematch team or not
	CheckEvent EVENT_BEAT_BROCK_REMATCH
	jr z, .loadTeam1Number3
	CheckEvent EVENT_BEAT_MISTY_REMATCH
	jr z, .loadTeam1Number3
	CheckEvent EVENT_BEAT_LT_SURGE_REMATCH
	jr z, .loadTeam1Number3
	CheckEvent EVENT_BEAT_ERIKA_REMATCH
	jr z, .loadTeam1Number3
	CheckEvent EVENT_BEAT_KOGA_REMATCH
	jr z, .loadTeam1Number3
	CheckEvent EVENT_BEAT_SABRINA_REMATCH
	jr z, .loadTeam1Number3
	CheckEvent EVENT_BEAT_BLAINE_REMATCH
	jr z, .loadTeam1Number3
	; if we arrived here, then it's post-game and post-gym-rematches
	jr .loadTeam1Number5
.loadTeam1Number1
	ld a, $1
	jr .continuePostLoadingTeam1
.loadTeam1Number3
	ld a, $3
	jr .continuePostLoadingTeam1
.loadTeam1Number5
	ld a, $5
.continuePostLoadingTeam1
	ld [wTrainerNo], a

	xor a
	ldh [hJoyHeld], a
	ld a, $b ; edited, to be changed if I rearrange all the scripts
	ld [wChampionsRoomCurScript], a
	ret

GaryScript2ndBattle:
	; new block to fix bug if blackout
	ld a, [wIsInBattle]
	cp $ff
	jp z, ResetGaryScript

	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	xor a
	ld [wJoyIgnore], a
	ld hl, wOptions
	res 7, [hl]  ; Turn on battle animations to make the battle feel more epic.
	ld a, $6
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call Delay3
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, GaryDefeatedText2ndBattle
	ld de, GaryVictoryText2ndBattle
	call SaveEndBattleTextPointers
	ld a, OPP_RIVAL3
	ld [wCurOpponent], a

	; select second Champion's team
	ld a, $2
	ld [wTrainerNo], a

	xor a
	ldh [hJoyHeld], a
	ld a, $3
	ld [wChampionsRoomCurScript], a
	ret

GaryScript3:
	ld a, [wIsInBattle]
	cp $ff
	jp z, ResetGaryScript
	call UpdateSprites
	SetEvent EVENT_BEAT_CHAMPION_RIVAL
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, $1
	ldh [hSpriteIndexOrTextID], a
	call GaryScript_760c8
	ld a, $1
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, $4
	ld [wChampionsRoomCurScript], a
	ret

GaryScript4:
	farcall Music_Cities1AlternateTempo
	ld a, $2
	ldh [hSpriteIndexOrTextID], a
	call GaryScript_760c8
	ld a, $2
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld de, OakEntranceAfterVictoryMovement
	ld a, $2
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, HS_CHAMPIONS_ROOM_OAK
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra ; edited, new HS function
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

GaryScript5:
	ld a, [wd730]
	bit 0, a
	ret nz
	ld a, PLAYER_DIR_LEFT
	ld [wPlayerMovingDirection], a
	ld a, $1
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_LEFT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	ld a, $2
	ldh [hSpriteIndex], a
	xor a ; SPRITE_FACING_DOWN
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	ld a, $3
	ldh [hSpriteIndexOrTextID], a
	call GaryScript_760c8
	ld a, $6
	ld [wChampionsRoomCurScript], a
	ret

GaryScript6:
	ld a, $2
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_RIGHT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	ld a, $4
	ldh [hSpriteIndexOrTextID], a
	call GaryScript_760c8
	ld a, $7
	ld [wChampionsRoomCurScript], a
	ret

GaryScript7:
	ld a, $2
	ldh [hSpriteIndex], a
	xor a ; SPRITE_FACING_DOWN
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	ld a, $5
	ldh [hSpriteIndexOrTextID], a
	call GaryScript_760c8
	ld de, OakExitGaryRoomMovement
	ld a, $2
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, $8
	ld [wChampionsRoomCurScript], a
	ret

OakExitGaryRoomMovement:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db -1 ; end

GaryScript8:
	ld a, [wd730]
	bit 0, a
	ret nz
	ld a, HS_CHAMPIONS_ROOM_OAK
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, $9
	ld [wChampionsRoomCurScript], a
	ret

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
	db D_LEFT, 1
	db -1 ; end

GaryScript10:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, $0
	ld [wChampionsRoomCurScript], a
	ret

GaryScript_760c8:
	ld a, $f0
	ld [wJoyIgnore], a
	call DisplayTextID
	ld a, $ff
	ld [wJoyIgnore], a
	ret

ChampionsRoom_TextPointers:
	dw GaryText1			; 1 - before first battle / why did I lose
	dw GaryText2			; 2 - simply Oak that calls you
	dw GaryText3			; 3 - Oak so you won, so long since you left w Pikachu
	dw GaryText4			; 4 -  Oak disappointed in Rival (sigh)
	dw GaryText5			; 5 - Oak come with me to HoF
	dw GaryText2ndBattle	; 6

GaryText1:
	text_asm
	CheckEvent EVENT_BEAT_CHAMPION_RIVAL
	ld hl, GaryChampionIntroText
	jr z, .printText
	ld hl, GaryText_76103
.printText
	call PrintText
	jp TextScriptEnd

GaryChampionIntroText:
	text_far _GaryChampionIntroText
	text_end

GaryDefeatedText:
	text_far _GaryDefeatedText
	text_end

GaryVictoryText:
	text_far _GaryVictoryText
	text_end

GaryText_76103:
	text_far _GaryText_76103
	text_end

GaryText2:
	text_far _GaryText2
	text_end

GaryText3:
	text_asm
	ld a, [wPlayerStarter]
	ld [wd11e], a
	call GetMonName
	ld hl, GaryText_76120
	call PrintText
	jp TextScriptEnd

GaryText_76120:
	text_far _GaryText_76120
	text_end

GaryText4:
	text_far _GaryText_76125
	text_end

GaryText5:
	text_far _GaryText_7612a
	text_end

; ------

GaryText2ndBattle:
	text_far _GaryText2ndBattle
	text_end

GaryDefeatedText2ndBattle:
	text_far _GaryDefeatedText2ndBattle
	text_end

GaryVictoryText2ndBattle:
	text_far _GaryVictoryText2ndBattle
	text_end
