ObsidianWarehouseFinal_Script:
	call EnableAutoTextBoxDrawing
	ld hl, ObsidianWarehouseFinalTrainerHeaders
	ld de, ObsidianWarehouseFinal_ScriptPointers
	ld a, [wObsidianWarehouseFinalCurScript]
	call ExecuteCurMapScriptInTable
	ld [wObsidianWarehouseFinalCurScript], a
	ret

ObsidianWarehouseFinal_ScriptPointers:
	dw ObsidianWarehouseFinalScript0
;	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle_Custom ; TBV
	dw ObsidianWarehouseFinalScript_JessieJamesMovement1 ; TBV
	dw ObsidianWarehouseFinalScript_JessieJamesMovement2 ; TBV
	dw ObsidianWarehouseFinalScript_JessieJamesFight ; TBV
	dw ObsidianWarehouseFinalScript_JessieJamesVictory ; TBV

ObsidianWarehouseFinal_TextPointers:
	dw ObsidianWarehouseFinalText1 ; proxies for J&J?
	dw ObsidianWarehouseFinalText2 ; proxies for J&J?
	dw ObsidianWarehouseFinalText3
	dw ObsidianWarehouseFinalText4
	dw ObsidianWarehouseFinalText5
	dw ObsidianWarehouseFinalText6
	dw ObsidianWarehouseFinalText7 ; Giovanni?
	dw ObsidianWarehouseFinalText8_JessieJames1
	dw ObsidianWarehouseFinalText9_JessieJames2
	dw ObsidianWarehouseFinalText10_JessieJames3
	dw ObsidianWarehouseFinalText11_JessieJames4

; ================= scripts, beginning =================

EndTrainerBattle_Custom:
	call EndTrainerBattle ; no need to do any shenanigans to go above 200? Not even a special case in EndTrainerBattle in home/trainers.asm?
	                      ; in the original tutorial, https://github.com/pret/pokered/wiki/Trainers-are-not-Pokemon, special case for Tower 7F
						  ; but that is weirdly handled in pokered, so I think I'm in the clear here?
	ld a, [wYCoord]
	cp 1
	ret nz
	ld a, [wIsInBattle]
	cp $ff
	jp z, ObsidianWarehouseFinalScript_ResetScript
	ld a, $7
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	; hide Obsidian Rockets, Fuchsia Rocket, and show Obsidian citizens, as well as people in Fuchsia Meeting Room
	call GBFadeOutToBlack

	call HideNPCsAfterObsidianGiovanni
	call HideExtraNPCsAfterObsidianGiovanni
;	call ShowNPCsAfterObsidianGiovanni ; unnecessary right now, so not written
	call ShowExtraNPCsAfterObsidianGiovanni
	SetEvent EVENT_SPOKEN_WITH_KOGA_IN_MEETING_ROOM ; just in case we cleared Obsidian before speaking with Koga

	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
	jp TextScriptEnd

ObsidianWarehouseFinalScript_ResetScript:
	xor a
	ld [wJoyIgnore], a
ObsidianWarehouseFinalScript_ChangeScript:
	ld [wObsidianWarehouseFinalCurScript], a
	ld [wCurMapScript], a
	ret

ObsidianWarehouseFinalScript_HideObjectExtra:
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ret

ObsidianWarehouseFinalScript0:
IF DEF(_DEBUG)
	call DebugPressedOrHeldB
	ret nz
ENDC
	CheckEvent EVENT_BEAT_OBSIDIAN_WAREHOUSE_FINAL_JESSIEJAMES
	call z, ObsidianWarehouseFinalScript_JessieJamesTrigger
	jp CheckFightingMapTrainers ; TBV - seems ok
	ret

ObsidianWarehouseFinalScript_JessieJamesTrigger:
	ld a, [wYCoord]
	cp 17
	ret nz
.checkpoint
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
	ld a, $8
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	xor a
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, $3 ; TBV
	call ObsidianWarehouseFinalScript_ChangeScript
	ret

ObsidianWarehouseFinalScript_JessieJamesMovement1:
	ld a, [wXCoord]
	cp $4 ; $5, $6
	jr z, .playerX4
	cp $5
	jr z, .playerX5
; if it's neither 4 or 5, must be 6, walk-through-walla aside
;.playerX6
	ld de, ObsidianWarehouseFinalData_JamesX6
	jr .continueWithJamesMovement
.playerX5
	ld de, ObsidianWarehouseFinalData_JamesX5
	jr .continueWithJamesMovement
.playerX4
	ld de, ObsidianWarehouseFinalData_JamesX4
.continueWithJamesMovement
	ld a, $1
	ldh [hSpriteIndexOrTextID], a
	call MoveSprite
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, $4
	call ObsidianWarehouseFinalScript_ChangeScript
	ret

ObsidianWarehouseFinalScript_JessieJamesMovement2:
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, [wd730]
	bit 0, a
	ret nz

	ld a, $2
	ld [wSprite01StateData1MovementStatus], a
	ld hl, wSprite01StateData1FacingDirection

	ld a, [wXCoord]
	cp $4 ; $5, $6
	jr z, .playerX4
	cp $5
	jr z, .playerX5
; if it's neither 4 or 5, must be 6, walk-through-walla aside
.playerX6 ; TBE
	ld [hl], SPRITE_FACING_RIGHT
	ld de, ObsidianWarehouseFinalData_JessieX6
	jr .continueWithJessieMovement
.playerX5
	ld [hl], SPRITE_FACING_RIGHT
	ld de, ObsidianWarehouseFinalData_JessieX5
	jr .continueWithJessieMovement
.playerX4
	ld [hl], SPRITE_FACING_DOWN
	ld de, ObsidianWarehouseFinalData_JessieX4

.continueWithJessieMovement
	ld a, $2
	ldh [hSpriteIndexOrTextID], a
	call MoveSprite
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, $5
	call ObsidianWarehouseFinalScript_ChangeScript
	ret

ObsidianWarehouseFinalData_JamesX6:
	db $7 ; TBV
ObsidianWarehouseFinalData_JessieX4:
ObsidianWarehouseFinalData_JamesX5:
	db $4
ObsidianWarehouseFinalData_JamesX4:
ObsidianWarehouseFinalData_JessieX5:
	db $4
	db $4
	db $4
	db $4
	db $ff

ObsidianWarehouseFinalData_JessieX6:
	db $7 ; TBV
	db $4
	db $4
	db $4
	db $4
	db $ff

ObsidianWarehouseFinalScript_JessieJamesFight:
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, [wd730]
	bit 0, a
	ret nz

	ld a, $2
	ld [wSprite02StateData1MovementStatus], a
	ld hl, wSprite02StateData1FacingDirection

	ld a, [wXCoord]
	cp $4 ; $5, $6
	jr z, .playerX4
	cp $5
	jr z, .playerX5
.playerX6
.playerX5
	ld [hl], SPRITE_FACING_DOWN
	jr .continueWithJessieJamesFight
.playerX4
	ld [hl], SPRITE_FACING_LEFT
.continueWithJessieJamesFight

	call Delay3
	ld a, $fc
	ld [wJoyIgnore], a
	ld a, $9 ; TBV
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, ObsidianWarehouseFinalText10_JessieJames3
	ld de, ObsidianWarehouseFinalText10_JessieJames3
	call SaveEndBattleTextPointers
	ld a, OPP_ROCKET
	ld [wCurOpponent], a
	ld a, $32
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	xor a
	ldh [hJoyHeld], a
	ld [wJoyIgnore], a
	ld a, $6 ; TBV
	call ObsidianWarehouseFinalScript_ChangeScript
	ret

ObsidianWarehouseFinalScript_JessieJamesVictory:
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, [wIsInBattle]
	cp $ff
	jp z, ObsidianWarehouseFinalScript_ResetScript ; TBV
	xor a                            ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	ld a, $2
	ld [wSprite01StateData1MovementStatus], a
	ld [wSprite02StateData1MovementStatus], a
	xor a
	ld [wSprite01StateData1FacingDirection], a
	ld [wSprite02StateData1FacingDirection], a
	ld a, $fc
	ld [wJoyIgnore], a
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld a, $b ; TBV
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
; fallthrough
	ld a, $ff
	ld [wJoyIgnore], a
	call GBFadeOutToBlack
	ld a, HS_OBSIDIAN_WAREHOUSE_FINAL_JAMES
	call ObsidianWarehouseFinalScript_HideObjectExtra
	ld a, HS_OBSIDIAN_WAREHOUSE_FINAL_JESSIE
	call ObsidianWarehouseFinalScript_HideObjectExtra
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
; fallthrough
	call PlayDefaultMusic
	xor a
	ldh [hJoyHeld], a
	ld [wJoyIgnore], a
	SetEvent EVENT_BEAT_OBSIDIAN_WAREHOUSE_FINAL_JESSIEJAMES
	ld a, $0
	call ObsidianWarehouseFinalScript_ChangeScript
	ret

; ----------------- hide/show functions -----------------

HideNPCsAfterObsidianGiovanni:
	ld hl, NPCsToHide
.hideLoop
	ld a, [hli]
	cp $ff ; have we run out of NPCs to hide?
	ret z ; if so, we're done
	push hl
	ld [wMissableObjectIndex], a
	predef HideObject
	pop hl
	jr .hideLoop

NPCsToHide:
	db HS_OBSIDIAN_WAREHOUSE_TRAINER_1
	db HS_OBSIDIAN_WAREHOUSE_TRAINER_2
	db HS_OBSIDIAN_WAREHOUSE_TRAINER_3
	db HS_OBSIDIAN_WAREHOUSE_TRAINER_4
	db HS_NUGGET_BRIDGE_GUY ; previously hidden right after helping Bill
	db $ff

HideExtraNPCsAfterObsidianGiovanni:
	ld hl, NPCsToHideExtra
.hideLoop
	ld a, [hli]
	cp $ff ; have we run out of NPCs to hide?
	ret z ; if so, we're done
	push hl
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	pop hl
	jr .hideLoop

NPCsToHideExtra:
	db HS_OBSIDIAN_ISLAND_ROCKET_1
	db HS_OBSIDIAN_ISLAND_ROCKET_2
	db HS_OBSIDIAN_ISLAND_ROCKET_3
	db HS_OBSIDIAN_ISLAND_SLAVE_1
	db HS_OBSIDIAN_ISLAND_SLAVE_2
	db HS_ROUTE_28_ROCKET_1
	db HS_ROUTE_28_ROCKET_2
	db HS_ROUTE_28_ROCKET_3
	db HS_ROUTE_28_ROCKET_4
	db HS_FUCHSIA_CITY_ROCKET_SAFARI
	db HS_OBSIDIAN_WAREHOUSE_FINAL_ADMIN_1
	db HS_OBSIDIAN_WAREHOUSE_FINAL_ADMIN_2
	db HS_OBSIDIAN_WAREHOUSE_FINAL_ADMIN_3
	db HS_OBSIDIAN_WAREHOUSE_FINAL_ADMIN_4
	db HS_OBSIDIAN_WAREHOUSE_FINAL_GIOVANNI
	db HS_CELADON_CHIEF_HOUSE_1
	db HS_CELADON_CHIEF_HOUSE_2
	db HS_CELADON_CHIEF_HOUSE_3
	db HS_FUCHSIA_MEETING_ROOM_BEFORE_1
	db HS_FUCHSIA_MEETING_ROOM_BEFORE_2
	db HS_FUCHSIA_MEETING_ROOM_BEFORE_3
	db HS_FUCHSIA_MEETING_ROOM_BEFORE_KOGA ; just in case we cleared Obsidian before speaking with Koga
	db $ff

ShowExtraNPCsAfterObsidianGiovanni:
	ld hl, NPCsToShowExtra
.hideLoop
	ld a, [hli]
	cp $ff ; have we run out of NPCs to show?
	ret z ; if so, we're done
	push hl
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra ; NB: they must all be in the Extra HS section, otherwise I need to duplicate this function
	pop hl
	jr .hideLoop

NPCsToShowExtra:
	db HS_OBSIDIAN_ISLAND_SCIENTIST_1
	db HS_OBSIDIAN_ISLAND_SCIENTIST_2
	db HS_OBSIDIAN_ISLAND_OFFICIER
	db HS_OBSIDIAN_ISLAND_CITIZEN_1
	db HS_OBSIDIAN_ISLAND_CITIZEN_2
	db HS_OBSIDIAN_ISLAND_CITIZEN_3
	db HS_OBSIDIAN_ISLAND_CITIZEN_4
	db HS_OBSIDIAN_POKECENTER_NPC_1
	db HS_OBSIDIAN_POKECENTER_NPC_2
	db HS_FUCHSIA_MEETING_ROOM_AFTER_1
	db HS_FUCHSIA_MEETING_ROOM_AFTER_2
	db HS_FUCHSIA_MEETING_ROOM_AFTER_3
	db HS_FUCHSIA_GYM_KOGA ; just in case we cleared Obsidian before speaking with Koga
	db HS_ROUTE_28_CITIZEN_1
	db HS_ROUTE_28_CITIZEN_2
	db HS_ROUTE_28_CITIZEN_3
	db HS_ROUTE_28_CITIZEN_4
	db HS_ROUTE_27_CITIZEN_1
	db HS_ROUTE_27_CITIZEN_2
	db HS_ROUTE_27_CITIZEN_3
	db HS_ROUTE_27_CITIZEN_4
	db HS_ROUTE_27_CITIZEN_5
	db HS_ROUTE_27_CITIZEN_6
	db $ff

; ================= scripts, end =================

ObsidianWarehouseFinalTrainerHeaders:
	def_trainers 3
ObsidianWarehouseFinalTrainerHeader0:
	trainer EVENT_BEAT_OBSIDIAN_WAREHOUSE_FINAL_TRAINER_0, 2, ObsidianWarehouseFinalBattleText1, ObsidianWarehouseFinalEndBattleText1, ObsidianWarehouseFinalAfterBattleText1
ObsidianWarehouseFinalTrainerHeader1:
	trainer EVENT_BEAT_OBSIDIAN_WAREHOUSE_FINAL_TRAINER_1, 2, ObsidianWarehouseFinalBattleText2, ObsidianWarehouseFinalEndBattleText2, ObsidianWarehouseFinalAfterBattleText2
ObsidianWarehouseFinalTrainerHeader2:
	trainer EVENT_BEAT_OBSIDIAN_WAREHOUSE_FINAL_TRAINER_2, 2, ObsidianWarehouseFinalBattleText3, ObsidianWarehouseFinalEndBattleText3, ObsidianWarehouseFinalAfterBattleText3
ObsidianWarehouseFinalTrainerHeader3:
	trainer EVENT_BEAT_OBSIDIAN_WAREHOUSE_FINAL_TRAINER_3, 4, ObsidianWarehouseFinalBattleText4, ObsidianWarehouseFinalEndBattleText4, ObsidianWarehouseFinalAfterBattleText4
ObsidianWarehouseFinalTrainerHeader4:
	trainer EVENT_BEAT_OBSIDIAN_WAREHOUSE_FINAL_TRAINER_4, 1, ObsidianWarehouseFinalBattleText5, ObsidianWarehouseFinalEndBattleText5, ObsidianWarehouseFinalAfterBattleText5
	db -1 ; end

; ================= texts, beginning =================

; ----------------- Jessie & James -----------------

ObsidianWarehouseFinalText1:
	text_far _ObsidianWarehouseFinalText1
	text_end

ObsidianWarehouseFinalText2:
	text_far _ObsidianWarehouseFinalText2
	text_end

ObsidianWarehouseFinalText8_JessieJames1:
	text_far _ObsidianWarehouseFinalJessieJamesText1
	text_asm
	ld c, 10
	call DelayFrames
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a
	ld a, $0
	ld [wEmotionBubbleSpriteIndex], a
	ld a, EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
	ld c, 20
	call DelayFrames
	jp TextScriptEnd

ObsidianWarehouseFinalText9_JessieJames2:
	text_far _ObsidianWarehouseFinalJessieJamesText2
	text_end

ObsidianWarehouseFinalText10_JessieJames3:
	text_far _ObsidianWarehouseFinalJessieJamesText3
	text_end

ObsidianWarehouseFinalText11_JessieJames4:
	text_far _ObsidianWarehouseFinalJessieJamesText4
	text_end

; ----------------- Executives -----------------

ObsidianWarehouseFinalText3:
	text_asm
	ld hl, ObsidianWarehouseFinalTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

ObsidianWarehouseFinalBattleText1:
	text_far _ObsidianWarehouseFinalBattleText1
	text_end

ObsidianWarehouseFinalEndBattleText1:
	text_far _ObsidianWarehouseFinalEndBattleText1
	text_end

ObsidianWarehouseFinalAfterBattleText1:
	text_far _ObsidianWarehouseFinalAfterBattleText1
	text_end

ObsidianWarehouseFinalText4:
	text_asm
	ld hl, ObsidianWarehouseFinalTrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

ObsidianWarehouseFinalBattleText2:
	text_far _ObsidianWarehouseFinalBattleText2
	text_end

ObsidianWarehouseFinalEndBattleText2:
	text_far _ObsidianWarehouseFinalEndBattleText2
	text_end

ObsidianWarehouseFinalAfterBattleText2:
	text_far _ObsidianWarehouseFinalAfterBattleText2
	text_end

ObsidianWarehouseFinalText5:
	text_asm
	ld hl, ObsidianWarehouseFinalTrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

ObsidianWarehouseFinalBattleText3:
	text_far _ObsidianWarehouseFinalBattleText3
	text_end

ObsidianWarehouseFinalEndBattleText3:
	text_far _ObsidianWarehouseFinalEndBattleText3
	text_end

ObsidianWarehouseFinalAfterBattleText3:
	text_far _ObsidianWarehouseFinalAfterBattleText3
	text_end

ObsidianWarehouseFinalText6:
	text_asm
	ld hl, ObsidianWarehouseFinalTrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

ObsidianWarehouseFinalBattleText4:
	text_far _ObsidianWarehouseFinalBattleText4
	text_end

ObsidianWarehouseFinalEndBattleText4:
	text_far _ObsidianWarehouseFinalEndBattleText4
	text_end

ObsidianWarehouseFinalAfterBattleText4:
	text_far _ObsidianWarehouseFinalAfterBattleText4
	text_end

; ----------------- Giovanni -----------------

ObsidianWarehouseFinalText7:
	text_asm
	ld hl, ObsidianWarehouseFinalTrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

ObsidianWarehouseFinalBattleText5:
	text_far _ObsidianWarehouseFinalBattleText5
	text_end

ObsidianWarehouseFinalEndBattleText5:
	text_far _ObsidianWarehouseFinalEndBattleText5
	text_end

ObsidianWarehouseFinalAfterBattleText5:
	text_far _ObsidianWarehouseFinalAfterBattleText5
	text_end
