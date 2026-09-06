ObsidianWarehouseFinal_Script:
	RPTextChooser ObsidianWarehouseFinal_TextPointers, ObsidianWarehouseFinal_TextPointers_Rocket
	call EnableAutoTextBoxDrawing
	ld hl, ObsidianWarehouseFinalTrainerHeaders
	ld de, ObsidianWarehouseFinal_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

ObsidianWarehouseFinal_ScriptPointers:
	dw ObsidianWarehouseFinalScript0
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle_Custom
	dw ObsidianWarehouseFinalScript_JessieJamesMovement1
	dw ObsidianWarehouseFinalScript_JessieJamesMovement2
	dw ObsidianWarehouseFinalScript_JessieJamesFight
	dw ObsidianWarehouseFinalScript_JessieJamesVictory
	; for RP
	dw ObsidianWarehouseFinalScript_PostBattleBlue ; 7
	dw ObsidianWarehouseFinalScript_TriggerCadreBattle1 ; 8
	dw ObsidianWarehouseFinalScript_TriggerCadreBattle2 ; 9
	dw ObsidianWarehouseFinalScript_TriggerCadreBattle3 ; 10
	dw ObsidianWarehouseFinalScript_TriggerCadreBattle4 ; 11
	dw ObsidianWarehouseFinalScript_PostCadreBattles ; 12

ObsidianWarehouseFinal_TextPointers:
	dw ObsidianWarehouseFinalText1 ; proxies for J&J
	dw ObsidianWarehouseFinalText2 ; proxies for J&J
	dw ObsidianWarehouseFinalText3
	dw ObsidianWarehouseFinalText4
	dw ObsidianWarehouseFinalText5
	dw ObsidianWarehouseFinalText6
	dw ObsidianWarehouseFinalText7 ; Giovanni
	; only for RP
	dw ObsidianWarehouseFinalText1 ; Blue, unused
	dw ObsidianWarehouseFinalText1 ; Proton, unused
	dw ObsidianWarehouseFinalText1 ; Petrel, unused
	dw ObsidianWarehouseFinalText1 ; Ariana, unused
	dw ObsidianWarehouseFinalText1 ; Archer, unused
	; scripts
	dw ObsidianWarehouseFinalText9_JessieJames1 ; 13
	dw ObsidianWarehouseFinalText10_JessieJames2 ; 14
	dw ObsidianWarehouseFinalText11_JessieJames4 ; 15

ObsidianWarehouseFinal_TextPointers_Rocket:
	dw ObsidianWarehouseFinalText1_RP ; James
	dw ObsidianWarehouseFinalText2_RP ; Jessie
	dw ObsidianWarehouseFinalText3_RP ; Proton
	dw ObsidianWarehouseFinalText4_RP ; Petrel
	dw ObsidianWarehouseFinalText5_RP ; Ariana
	dw ObsidianWarehouseFinalText6_RP ; Archer
	dw ObsidianWarehouseFinalText7 ; Giovanni (unnecessary)
	; only for RP
	dw ObsidianWarehouseFinalText8_RP ; 8, Blue
	dw ObsidianWarehouseFinalText9_RP ; 9 Proton
	dw ObsidianWarehouseFinalText10_RP ; 10, Petrel
	dw ObsidianWarehouseFinalText11_RP ; 11, Ariana
	dw ObsidianWarehouseFinalText12_RP ; 12, Archer
	; scripts
	dw ObsidianWarehouseFinalText9_Blue1 ; 13
	dw ObsidianWarehouseFinalText_CadresStart ; 14
	dw ObsidianWarehouseFinalText_CadresEnd1 ; 15
	dw ObsidianWarehouseFinalText_CadresEnd2 ; 16

; ================= scripts, beginning =================

EndTrainerBattle_Custom:
	call EndTrainerBattle ; no need to do any shenanigans to go above 200? Not even a special case in EndTrainerBattle in home/trainers.asm?
	                      ; in the original tutorial, https://github.com/pret/pokered/wiki/Trainers-are-not-Pokemon, special case for Tower 7F
						  ; but that is weirdly handled in pokered, so I think I'm in the clear here?
	ld a, [wYCoord]
	cp 1
	ret nz
; not by Giovanni
	ld a, [wIsInBattle]
	cp $ff
	jp z, ObsidianWarehouseFinalScript_ResetScript
; we won
	ld a, 7 ; Giovanni's text
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
	CheckEvent EVENT_ROCKET_PATH
	jr z, .notRP
; RP
	CheckEvent EVENT_RP_BEAT_OBSIDIAN_CADRES
	jp nz, CheckFightingMapTrainers ; actually unnecessary in RP because no actual "seeing" trainers
	CheckEvent EVENT_RP_KILLED_GIOVANNI
	jp z, CheckFightingMapTrainers
; unnecessary to check the coordinates, because it happens immediately as soon as we arrive
	ld a, 8
	ld [wCurMapScript], a
	ret
.notRP
	CheckEvent EVENT_BEAT_OBSIDIAN_WAREHOUSE_FINAL_JESSIEJAMES
	call z, ObsidianWarehouseFinalScript_JessieJamesTrigger
	jp CheckFightingMapTrainers

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
	ld a, 13
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
; if it's neither 4 or 5, must be 6, walk-through-walls aside
.playerX6
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
	ld a, 14
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, ObsidianWarehouseFinalText10_JessieJames3
	ld de, ObsidianWarehouseFinalText10_JessieJames3
	call SaveEndBattleTextPointers
	ld a, OPP_JESSIEJAMES ; edited
	ld [wCurOpponent], a
	ld a, 5
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
	ld a, 15
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
ObsidianWarehouseFinalText2:
	text_far _ObsidianWarehouseFinalText1
	text_end

ObsidianWarehouseFinalText9_JessieJames1:
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

ObsidianWarehouseFinalText10_JessieJames2:
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

; new for RP ================================================

ObsidianWarehouseFinalText1_RP:
	text_asm
	CheckEvent EVENT_RP_BEAT_OBSIDIAN_BLUE
	ld hl, ObsidianWarehouseFinalText1_RP_After
	jr nz, .printAndEnd
	ld hl, ObsidianWarehouseFinalText1_RP_Before
.printAndEnd
	call PrintText
	jp TextScriptEnd

ObsidianWarehouseFinalText1_RP_Before:
	text_far _ObsidianWarehouseFinalText1_RP_Before
	text_end

ObsidianWarehouseFinalText1_RP_After:
	text_far _ObsidianWarehouseFinalText1_RP_After
	text_end

ObsidianWarehouseFinalText2_RP:
	text_asm
	CheckEvent EVENT_RP_BEAT_OBSIDIAN_BLUE
	ld hl, ObsidianWarehouseFinalText2_RP_After
	jr nz, .printAndEnd
	ld hl, ObsidianWarehouseFinalText2_RP_Before
.printAndEnd
	call PrintText
	jp TextScriptEnd

ObsidianWarehouseFinalText2_RP_Before:
	text_far _ObsidianWarehouseFinalText2_RP_Before
	text_end

ObsidianWarehouseFinalText2_RP_After:
	text_far _ObsidianWarehouseFinalText2_RP_After
	text_end

ObsidianWarehouseFinalText3_RP:
	text_asm
	CheckEvent EVENT_RP_BEAT_OBSIDIAN_BLUE
	ld hl, ObsidianWarehouseFinalText3_RP_After
	jr nz, .printAndEnd
	ld hl, ObsidianWarehouseFinalText3_RP_Before
.printAndEnd
	call PrintText
	jp TextScriptEnd

ObsidianWarehouseFinalText3_RP_Before:
	text_far _ObsidianWarehouseFinalText3_RP_Before
	text_end

ObsidianWarehouseFinalText3_RP_After:
	text_far _ObsidianWarehouseFinalText3_RP_After
	text_end

ObsidianWarehouseFinalText4_RP:
	text_asm
	CheckEvent EVENT_RP_BEAT_OBSIDIAN_BLUE
	ld hl, ObsidianWarehouseFinalText4_RP_After
	jr nz, .printAndEnd
	ld hl, ObsidianWarehouseFinalText4_RP_Before
.printAndEnd
	call PrintText
	jp TextScriptEnd

ObsidianWarehouseFinalText4_RP_Before:
	text_far _ObsidianWarehouseFinalText4_RP_Before
	text_end

ObsidianWarehouseFinalText4_RP_After:
	text_far _ObsidianWarehouseFinalText4_RP_After
	text_end

ObsidianWarehouseFinalText5_RP:
	text_asm
	CheckEvent EVENT_RP_BEAT_OBSIDIAN_BLUE
	ld hl, ObsidianWarehouseFinalText5_RP_After
	jr nz, .printAndEnd
	ld hl, ObsidianWarehouseFinalText5_RP_Before
.printAndEnd
	call PrintText
	jp TextScriptEnd

ObsidianWarehouseFinalText5_RP_Before:
	text_far _ObsidianWarehouseFinalText5_RP_Before
	text_end

ObsidianWarehouseFinalText5_RP_After:
	text_far _ObsidianWarehouseFinalText5_RP_After
	text_end

ObsidianWarehouseFinalText6_RP:
	text_asm
	CheckEvent EVENT_ALREADY_REWARDED_ORB_OBSIDIAN_SCIENTIST ; abused
	ld hl, ObsidianWarehouseFinalText6_RP_AfterOrb
	jr nz, .printAndEnd
	CheckEvent EVENT_RP_BEAT_OBSIDIAN_BLUE
	ld hl, ObsidianWarehouseFinalText6_RP_BeforeBlue
	jr z, .printAndEnd
; Beat Blue but not Orb yet: first time or bag full
	ld hl, ObsidianWarehouseFinalText6_RP_AfterBlue
	call PrintText
	lb bc, FIRE_ORB, 1
	call GiveItem
	jr nc, .bagFull
	SetEvent EVENT_ALREADY_REWARDED_ORB_OBSIDIAN_SCIENTIST
	ld hl, ObsidianWarehouseFinalText6_RP_AfterBlue_ReceivedIceOrb
	jr .printAndEnd
.bagFull
	ld hl, ObsidianWarehouseFinalText6_RP_AfterBlue_BagFull
.printAndEnd
	call PrintText
	jp TextScriptEnd

ObsidianWarehouseFinalText6_RP_BeforeBlue:
	text_far _ObsidianWarehouseFinalText6_RP_BeforeBlue
	text_end

ObsidianWarehouseFinalText6_RP_AfterBlue:
	text_far _ObsidianWarehouseFinalText6_RP_AfterBlue
	text_end

ObsidianWarehouseFinalText6_RP_AfterOrb:
	text_far _ObsidianWarehouseFinalText6_RP_AfterOrb
	text_end

ObsidianWarehouseFinalText6_RP_AfterBlue_ReceivedIceOrb:
	text_far _ReceivedHM01Text
	sound_get_key_item
	text_end

ObsidianWarehouseFinalText6_RP_AfterBlue_BagFull:
	text_far _ObsidianWarehouseFinalText6_RP_AfterBlue_BagFull
	text_end

ObsidianWarehouseFinalText8_RP:
	text_asm
	ld hl, ObsidianWarehouseFinalText8_RP_PreBattle
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_RIVAL2
	ld [wCurOpponent], a
	ld a, 3
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, ObsidianWarehouseFinalBlue_VictoryText
	ld de, ObsidianWarehouseFinalBlue_DefeatText
	call SaveEndBattleTextPointers
	SetEvent EVENT_RP_USE_VANILLA_BATTLE_MESSAGES
	ld a, 7
	ld [wCurMapScript], a
	jp TextScriptEnd

ObsidianWarehouseFinalText8_RP_PreBattle:
	text_far _ObsidianWarehouseFinalText8_RP_PreBattle
	text_end

ObsidianWarehouseFinalBlue_VictoryText:
	text_far _ObsidianWarehouseFinalBlue_VictoryText
	text_end

ObsidianWarehouseFinalBlue_DefeatText:
	text_far _ObsidianWarehouseFinalBlue_DefeatText
	text_end

ObsidianWarehouseFinalText9_Blue1:
	text_far _ObsidianWarehouseFinalText9_Blue1
	text_end

ObsidianWarehouseFinalScript_PostBattleBlue:
	ld a, [wIsInBattle]
	cp $ff
	jp z, ObsidianWarehouseFinalScript_ResetScript
	ld a, $f0
	ld [wJoyIgnore], a
; we won
	SetEvent EVENT_RP_BEAT_OBSIDIAN_BLUE
	xor a
	ld [wJoyIgnore], a
	ld a, 13
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; hide Blue and Hideout Giovanni (and Mines guard)
	call GBFadeOutToBlack
	ld a, HS_OBSIDIAN_WAREHOUSE_FINAL_BLUE
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld a, HS_OBSIDIAN_ISLAND_ROCKET_1
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld a, HS_ROCKET_HIDEOUT_B4F_GIOVANNI
	ld [wMissableObjectIndex], a
	predef HideObject
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
; if also beat Pink in Chrono, open Silph
	CheckEvent EVENT_RP_BEAT_PINK_CHRONO_WAREHOUSE
	jp z, ObsidianWarehouseFinalScript_ResetScript
	SetEvent EVENT_RP_UNLOCKED_SILPH
	jp ObsidianWarehouseFinalScript_ResetScript

; post-Giovanni's death -----------------------------------

ObsidianWarehouseFinalScript_TriggerCadreBattle1:
; print dialogue
	ld a, 14
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; exclamation bubble
	ld a, 0
	ld [wEmotionBubbleSpriteIndex], a
	ld a, EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
; fade out
	call GBFadeOutToBlack
; show cadres
	ld a, HS_OBSIDIAN_WAREHOUSE_FINAL_PROTON2
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld a, HS_OBSIDIAN_WAREHOUSE_FINAL_PETREL2
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld a, HS_OBSIDIAN_WAREHOUSE_FINAL_ARIANA2
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld a, HS_OBSIDIAN_WAREHOUSE_FINAL_ARCHER2
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
; fade in
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
; dialogue Proton
	ld a, 9
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; set up battle
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_PROTON
	ld [wCurOpponent], a
	ld a, 3
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, ObsidianWarehouseFinalProtonDefeatText
	ld de, ObsidianWarehouseFinalProtonDefeatText
	call SaveEndBattleTextPointers
	SetEvent EVENT_RP_USE_VANILLA_BATTLE_MESSAGES
; handle script
	ld a, 9
	ld [wCurMapScript], a
	ret

ObsidianWarehouseFinalScript_TriggerCadreBattle2:
; check if we lost
	ld a, [wIsInBattle]
	cp $ff
	jp z, ObsidianWarehouseFinalScript_ResetScript
; we won
	xor a
	ld [wJoyIgnore], a
; dialogue Petrel
	ld a, 10
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; set up battle
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_PETREL
	ld [wCurOpponent], a
	ld a, 3
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, ObsidianWarehouseFinalPetrelDefeatText
	ld de, ObsidianWarehouseFinalPetrelDefeatText
	call SaveEndBattleTextPointers
	SetEvent EVENT_RP_USE_VANILLA_BATTLE_MESSAGES
; handle script
	ld a, 10
	ld [wCurMapScript], a
	ret

ObsidianWarehouseFinalScript_TriggerCadreBattle3:
; check if we lost
	ld a, [wIsInBattle]
	cp $ff
	jp z, ObsidianWarehouseFinalScript_ResetScript
; we won
	xor a
	ld [wJoyIgnore], a
; dialogue Ariana
	ld a, 11
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; set up battle
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_ARIANA
	ld [wCurOpponent], a
	ld a, 3
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, ObsidianWarehouseFinalArianaDefeatText
	ld de, ObsidianWarehouseFinalArianaDefeatText
	call SaveEndBattleTextPointers
	SetEvent EVENT_RP_USE_VANILLA_BATTLE_MESSAGES
; handle script
	ld a, 11
	ld [wCurMapScript], a
	ret

ObsidianWarehouseFinalScript_TriggerCadreBattle4:
; check if we lost
	ld a, [wIsInBattle]
	cp $ff
	jp z, ObsidianWarehouseFinalScript_ResetScript
; we won
	xor a
	ld [wJoyIgnore], a
; dialogue Archer
	ld a, 12
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; set up battle
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_ARCHER
	ld [wCurOpponent], a
	ld a, 3
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, ObsidianWarehouseFinalArcherDefeatText
	ld de, ObsidianWarehouseFinalArcherDefeatText
	call SaveEndBattleTextPointers
	SetEvent EVENT_RP_USE_VANILLA_BATTLE_MESSAGES
; handle script
	ld a, 12
	ld [wCurMapScript], a
	ret

ObsidianWarehouseFinalScript_PostCadreBattles:
; check if we lost
	ld a, [wIsInBattle]
	cp $ff
	jp z, ObsidianWarehouseFinalScript_ResetScript
; we won
	SetEvent EVENT_RP_BEAT_OBSIDIAN_CADRES
	SetEvent EVENT_SS_ANNE_RETURNED
	xor a
	ld [wJoyIgnore], a
; dialogue
	ld a, 15
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; flash
    call GBFadeOutToWhite
	ld c, BANK(SFX_Push_Boulder_1)
	ld a, SFX_PUSH_BOULDER
	call PlayMusic
    call GBFadeInFromWhite
; dialogue
	ld a, 16
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; fade black and hide cadres
    call GBFadeOutToBlack
    ld c, 30
    call DelayFrames
	ld c, BANK(SFX_Push_Boulder_1)
	ld a, SFX_PUSH_BOULDER
	call PlayMusic
	call WaitForSoundToFinish
	ld c, BANK(SFX_Push_Boulder_1)
	ld a, SFX_PUSH_BOULDER
	call PlayMusic
    ld c, 30
    call DelayFrames
	ld a, HS_OBSIDIAN_WAREHOUSE_FINAL_PROTON2
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld a, HS_OBSIDIAN_WAREHOUSE_FINAL_PETREL2
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld a, HS_OBSIDIAN_WAREHOUSE_FINAL_ARIANA2
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld a, HS_OBSIDIAN_WAREHOUSE_FINAL_ARCHER2
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	call UpdateSprites
    call GBFadeInFromBlack
;	ld c, BANK(Music_Dungeon1)
;	ld a, MUSIC_DUNGEON1
;	call PlayMusic
	call PlayDefaultMusic
; handle script
	jp ObsidianWarehouseFinalScript_ResetScript

ObsidianWarehouseFinalText_CadresStart:
	text_far _ObsidianWarehouseFinalText_CadresStart
	text_end

ObsidianWarehouseFinalText9_RP:
	text_far _ObsidianWarehouseFinalText9_RP
	text_end

ObsidianWarehouseFinalProtonDefeatText:
	text_far _ObsidianWarehouseFinalProtonDefeatText
	text_end

ObsidianWarehouseFinalText10_RP:
	text_far _ObsidianWarehouseFinalText10_RP
	text_end

ObsidianWarehouseFinalPetrelDefeatText:
	text_far _ObsidianWarehouseFinalPetrelDefeatText
	text_end

ObsidianWarehouseFinalText11_RP:
	text_far _ObsidianWarehouseFinalText11_RP
	text_end

ObsidianWarehouseFinalArianaDefeatText:
	text_far _ObsidianWarehouseFinalArianaDefeatText
	text_end

ObsidianWarehouseFinalText12_RP:
	text_far _ObsidianWarehouseFinalText12_RP
	text_end

ObsidianWarehouseFinalArcherDefeatText:
	text_far _ObsidianWarehouseFinalArcherDefeatText
	text_end

ObsidianWarehouseFinalText_CadresEnd1:
	text_far _ObsidianWarehouseFinalText_CadresEnd1
	text_end

ObsidianWarehouseFinalText_CadresEnd2:
	text_far _ObsidianWarehouseFinalText_CadresEnd2
	text_end
