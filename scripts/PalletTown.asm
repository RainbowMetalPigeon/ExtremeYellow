PalletTown_Script:
	CheckEvent EVENT_GOT_POKEBALLS_FROM_OAK
	jr z, .next
	SetEvent EVENT_PALLET_AFTER_GETTING_POKEBALLS
.next
	call EnableAutoTextBoxDrawing
	ld hl, PalletTown_ScriptPointers
	ld a, [wPalletTownCurScript]
	jp CallFunctionInTable

PalletTown_ScriptPointers:
	dw PalletTownScript0
	dw PalletTownScript1
	dw PalletTownScript2
	dw PalletTownScript3
	dw PalletTownScript4
	dw PalletTownScript5
	dw PalletTownScript6
	dw PalletTownScript7
	dw PalletTownScript8
	dw PalletTownScript9

PalletTownScript0:
	CheckEvent EVENT_FOLLOWED_OAK_INTO_LAB
	ret nz
	ld a, [wYCoord]
	cp 0 ; is player at north exit?
	ret nz
	ResetEvent EVENT_PLAYER_AT_RIGHT_EXIT_TO_PALLET_TOWN
	ld a, [wXCoord]
	cp 10
	jr z, .asm_18e40
	SetEventReuseHL EVENT_PLAYER_AT_RIGHT_EXIT_TO_PALLET_TOWN
.asm_18e40
	xor a
	ldh [hJoyHeld], a
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a
	call StopAllMusic
	ld a, BANK(Music_MeetProfOak)
	ld c, a
	ld a, MUSIC_MEET_PROF_OAK ; "oak appears" music
	call PlayMusic
	SetEvent EVENT_OAK_APPEARED_IN_PALLET

	; trigger the next script
	ld a, 1
	ld [wPalletTownCurScript], a
	ret

PalletTownScript1:
	ld a, ~(A_BUTTON | B_BUTTON)
	ld [wJoyIgnore], a
	xor a
	ld [wcf0d], a
	ld a, 1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $FF
	ld [wJoyIgnore], a
	ld hl, wSprite01StateData2MapY
	ld a, 8
	ld [hli], a ; SPRITESTATEDATA2_MAPY
	ld a, 14
	ld [hl], a ; SPRITESTATEDATA2_MAPX
	ld a, HS_PALLET_TOWN_OAK
	ld [wMissableObjectIndex], a
	predef ShowObject

	; trigger the next script
	ld a, $2
	ld [wSprite01StateData1MovementStatus], a
	ld a, SPRITE_FACING_UP
	ld [wSprite01StateData1FacingDirection], a
	ld a, 2
	ld [wPalletTownCurScript], a
	ret

PalletTownScript2:
	call Delay3
	ld a, 0
	ld [wYCoord], a
	ld a, 1
	ldh [hNPCPlayerRelativePosPerspective], a
	ld a, 1
	swap a
	ldh [hNPCSpriteOffset], a
	predef CalcPositionOfPlayerRelativeToNPC
	ld hl, hNPCPlayerYDistance
	dec [hl]
	predef FindPathToPlayer ; load Oak's movement into wNPCMovementDirections2
	ld de, wNPCMovementDirections2
	ld a, 1 ; oak
	ldh [hSpriteIndex], a
	call MoveSprite

	; trigger the next script
	ld a, 3
	ld [wPalletTownCurScript], a
	ret

PalletTownScript3:
	ld a, [wd730]
	bit 0, a
	ret nz
	ld a, ~(A_BUTTON | B_BUTTON)
	ld [wJoyIgnore], a
	ld a, 1
	ld [wcf0d], a
	ld a, $2
	ld [wSprite01StateData1MovementStatus], a
	ld a, SPRITE_FACING_UP
	ld [wSprite01StateData1FacingDirection], a
	ld a, 1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	; oak faces the horizontally adjacent patch of grass to face pikachu
	ld a, $FF
	ld [wJoyIgnore], a
	ld a, $2
	ld [wSprite01StateData1MovementStatus], a
	CheckEvent EVENT_PLAYER_AT_RIGHT_EXIT_TO_PALLET_TOWN
	ld a, SPRITE_FACING_RIGHT
	jr z, .asm_18f01
	ld a, SPRITE_FACING_LEFT
.asm_18f01
	ld [wSprite01StateData1FacingDirection], a

	; trigger the next script
	ld a, 4
	ld [wPalletTownCurScript], a
	ret

PalletTownScript4:
	; start the pikachu battle
	ld a, ~(A_BUTTON | B_BUTTON)
	ld [wJoyIgnore], a
	xor a
	ld [wListScrollOffset], a
	ld a, BATTLE_TYPE_PIKACHU
	ld [wBattleType], a
	ld a, STARTER_PIKACHU
	ld [wCurOpponent], a
	ld a, 5
	ld [wCurEnemyLVL], a

	; new, rolls for shiny
	callfar RollForShiny
	ld a, [wOpponentMonShiny]
	ld [wShinyStarterPikachu], a

	; trigger the next script
	ld a, 5
	ld [wPalletTownCurScript], a
	ret

PalletTownScript5:
	ld a, $2
	ld [wcf0d], a
	ld a, $1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $2
	ld [wSprite01StateData1MovementStatus], a
	ld a, SPRITE_FACING_UP
	ld [wSprite01StateData1FacingDirection], a
	ld a, $9 ; edited because Dark Guide
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $ff
	ld [wJoyIgnore], a

	; trigger the next script
	ld a, 6
	ld [wPalletTownCurScript], a
	ret

PalletTownScript6:
	xor a
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, $1
	ld [wSpriteIndex], a
	xor a
	ld [wNPCMovementScriptFunctionNum], a
	ld a, 1
	ld [wNPCMovementScriptPointerTableNum], a
	ldh a, [hLoadedROMBank]
	ld [wNPCMovementScriptBank], a

	; trigger the next script
	ld a, 7
	ld [wPalletTownCurScript], a
	ret

PalletTownScript7:
	ld a, [wNPCMovementScriptPointerTableNum]
	and a ; is the movement script over?
	ret nz

	; trigger the next script
	ld a, 8
	ld [wPalletTownCurScript], a
	ret

PalletTownScript8:
	CheckEvent EVENT_DAISY_WALKING
	jr nz, .next
	CheckBothEventsSet EVENT_GOT_TOWN_MAP, EVENT_ENTERED_BLUES_HOUSE, 1
	jr nz, .next
	SetEvent EVENT_DAISY_WALKING
	ld a, HS_DAISY_SITTING
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_DAISY_WALKING
	ld [wMissableObjectIndex], a
	predef_jump ShowObject
.next
	CheckEvent EVENT_GOT_POKEBALLS_FROM_OAK
	ret z
	SetEvent EVENT_PALLET_AFTER_GETTING_POKEBALLS_2
PalletTownScript9:
	ret

PalletTown_TextPointers:
	dw PalletTownText1
	dw PalletTownText2
	dw PalletTownText3
	dw PalletTownTextDarkGuide ; can't be bothered to rename everything lol
	; signs from here onward
	dw PalletTownText4
	dw PalletTownText5
	dw PalletTownText6
	dw PalletTownText7
	dw PalletTownText8

PalletTownText1:
	text_asm
	ld a, [wcf0d]
	and a
	jr nz, .next
	ld a, 1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, OakAppearsText
	jr .done
.next
	dec a
	jr nz, .asm_18fd3
	ld hl, OakWalksUpText
	jr .done

.asm_18fd3
	ld hl, PalletTownText_19002
.done
	call PrintText
	jp TextScriptEnd

OakAppearsText:
	text_far _OakAppearsText
	text_asm
	ld c, 10
	call DelayFrames
	ld a, PLAYER_DIR_DOWN
	ld [wPlayerMovingDirection], a
	ld a, 0
	ld [wEmotionBubbleSpriteIndex], a ; player's sprite
	ld a, EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
	jp TextScriptEnd

OakWalksUpText:
	text_far _OakWalksUpText
	text_end

PalletTownText_19002:
	text_far _OakWhewText
	text_end

PalletTownText8:
	text_far _OakGrassText
	text_end

PalletTownText2: ; girl
	text_far _PalletTownText2
	text_end

PalletTownText3: ; fat man
	text_far _PalletTownText3
	text_end

PalletTownText4: ; sign by lab
	text_far _PalletTownText4
	text_end

PalletTownText5: ; sign by fence
IF DEF(_DEBUG)
	text_asm

	ld a, VIRIDIAN_CITY
	ld b, a
	ld e, 13
	ld d, 4
	predef CheckIfSpecificHiddenItemHasBeenFound ; d Y, e X, b MAP ; nz flag if found
	ld hl, PalletTownText_502b
	jr nz,     .printAndEnd
; not found
	ld hl, PalletTownText6
.printAndEnd
	call PrintText
	jp TextScriptEnd

PalletTownText_502b:
;	text_decimal wWhichPewterGuy, 1, 3
;	text "bit"
	text "FOUND!"
	done
ELSE
	text_far _PalletTownText5
	text_end
ENDC

PalletTownText6: ; sign by Red's house
	text_far _PalletTownText6
	text_end

PalletTownText7: ; sign by Blue's house
	text_far _PalletTownText7
	text_end

; new ----------------------

PalletTownTextDarkGuide:
	text_asm
	ld hl, DarkGuideHints_Intro
	call PrintText
	xor a
	ld [wCurrentMenuItem], a
	ld [wListScrollOffset], a
.kindaLoop
	ld hl, DarkGuideHints_Question
	call PrintText
	ld hl, DarkGuideHintList
	call LoadItemList
	ld hl, wItemList
	ld a, l
	ld [wListPointer], a
	ld a, h
	ld [wListPointer + 1], a
	xor a
	ld [wPrintItemPrices], a
	ld [wMenuItemToSwap], a
	ld a, SPECIALLISTMENU
	ld [wListMenuID], a
	call DisplayListMenuID
	jr c, .kindaExit
	ld hl, TextPointers_Hints
	ld a, [wcf91]
	sub DARKGUIDE_HINT_1
	add a
	ld d, $0
	ld e, a
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
	jr .kindaLoop
.kindaExit
	xor a
	ld [wListScrollOffset], a
	ld hl, DarkGuideHints_Outro
	call PrintText
	jp TextScriptEnd

DarkGuideHintList:
	db 8 ; #
	db DARKGUIDE_HINT_1
	db DARKGUIDE_HINT_2
	db DARKGUIDE_HINT_3
	db DARKGUIDE_HINT_4
	db DARKGUIDE_HINT_5
	db DARKGUIDE_HINT_6
	db DARKGUIDE_HINT_7
	db DARKGUIDE_HINT_8
	db -1 ; end

DarkGuideHints_Intro:
	text_far _DarkGuideHints_Intro
	text_end

DarkGuideHints_Question:
	text_far _DarkGuideHints_Question
	text_end

DarkGuideHints_Outro:
	text_far _DarkGuideHints_Outro
	text_end

TextPointers_Hints:
	dw DarkGuideHints_Hint1
	dw DarkGuideHints_Hint2
	dw DarkGuideHints_Hint3
	dw DarkGuideHints_Hint4
	dw DarkGuideHints_Hint5
	dw DarkGuideHints_Hint6
	dw DarkGuideHints_Hint7
	dw DarkGuideHints_Hint8

WantMoreDetails:
	ld hl, WantMoreDetailsText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ret

WantExplicitSolution:
	ld hl, WantExplicitSolutionText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ret

WantMoreDetailsText:
	text_far _WantMoreDetailsText
	text_end

WantExplicitSolutionText:
	text_far _WantExplicitSolutionText
	text_end

; -------

DarkGuideHints_Hint1:
	text_asm
	ld hl, DarkGuideHints_Hint1_Base
	call PrintText
	call WantMoreDetails
	jr nz, .doneExplaining
	ld hl, DarkGuideHints_Hint1_Details
	call PrintText
	call WantExplicitSolution
	jr nz, .doneExplaining
	ld hl, DarkGuideHints_Hint1_Solution
	call PrintText
.doneExplaining
	jp TextScriptEnd

DarkGuideHints_Hint1_Base:
	text_far _DarkGuideHints_Hint1_Base
	text_end

DarkGuideHints_Hint1_Details:
	text_far _DarkGuideHints_Hint1_Details
	text_end

DarkGuideHints_Hint1_Solution:
	text_far _DarkGuideHints_Hint1_Solution
	text_end

; -------

DarkGuideHints_Hint2:
	text_asm
	ld hl, DarkGuideHints_Hint2_Base
	call PrintText
	call WantMoreDetails
	jr nz, .doneExplaining
	ld hl, DarkGuideHints_Hint2_Details
	call PrintText
	call WantExplicitSolution
	jr nz, .doneExplaining
	ld hl, DarkGuideHints_Hint2_Solution
	call PrintText
.doneExplaining
	jp TextScriptEnd

DarkGuideHints_Hint2_Base:
	text_far _DarkGuideHints_Hint2_Base
	text_end

DarkGuideHints_Hint2_Details:
	text_far _DarkGuideHints_Hint2_Details
	text_end

DarkGuideHints_Hint2_Solution:
	text_far _DarkGuideHints_Hint2_Solution
	text_end

; -------

DarkGuideHints_Hint3:
	text_asm
	ld hl, DarkGuideHints_Hint3_Base
	call PrintText
	call WantMoreDetails
	jr nz, .doneExplaining
	ld hl, DarkGuideHints_Hint3_Details
	call PrintText
	call WantExplicitSolution
	jr nz, .doneExplaining
	ld hl, DarkGuideHints_Hint3_Solution
	call PrintText
.doneExplaining
	jp TextScriptEnd

DarkGuideHints_Hint3_Base:
	text_far _DarkGuideHints_Hint3_Base
	text_end

DarkGuideHints_Hint3_Details:
	text_far _DarkGuideHints_Hint3_Details
	text_end

DarkGuideHints_Hint3_Solution:
	text_far _DarkGuideHints_Hint3_Solution
	text_end

; -------

DarkGuideHints_Hint4:
	text_asm
	ld hl, DarkGuideHints_Hint4_Base
	call PrintText
	call WantMoreDetails
	jr nz, .doneExplaining
	ld hl, DarkGuideHints_Hint4_Details
	call PrintText
	call WantExplicitSolution
	jr nz, .doneExplaining
	ld hl, DarkGuideHints_Hint4_Solution
	call PrintText
.doneExplaining
	jp TextScriptEnd

DarkGuideHints_Hint4_Base:
	text_far _DarkGuideHints_Hint4_Base
	text_end

DarkGuideHints_Hint4_Details:
	text_far _DarkGuideHints_Hint4_Details
	text_end

DarkGuideHints_Hint4_Solution:
	text_far _DarkGuideHints_Hint4_Solution
	text_end

; -------

DarkGuideHints_Hint5:
	text_asm
	ld hl, DarkGuideHints_Hint5_Base
	call PrintText
	call WantMoreDetails
	jr nz, .doneExplaining
	ld hl, DarkGuideHints_Hint5_Details
	call PrintText
	call WantExplicitSolution
	jr nz, .doneExplaining
	ld hl, DarkGuideHints_Hint5_Solution
	call PrintText
.doneExplaining
	jp TextScriptEnd

DarkGuideHints_Hint5_Base:
	text_far _DarkGuideHints_Hint5_Base
	text_end

DarkGuideHints_Hint5_Details:
	text_far _DarkGuideHints_Hint5_Details
	text_end

DarkGuideHints_Hint5_Solution:
	text_far _DarkGuideHints_Hint5_Solution
	text_end

; -------

DarkGuideHints_Hint6:
	text_asm
	ld hl, DarkGuideHints_Hint6_Base
	call PrintText
	call WantMoreDetails
	jr nz, .doneExplaining
	ld hl, DarkGuideHints_Hint6_Details
	call PrintText
	call WantExplicitSolution
	jr nz, .doneExplaining
	ld hl, DarkGuideHints_Hint6_Solution
	call PrintText
.doneExplaining
	jp TextScriptEnd

DarkGuideHints_Hint6_Base:
	text_far _DarkGuideHints_Hint6_Base
	text_end

DarkGuideHints_Hint6_Details:
	text_far _DarkGuideHints_Hint6_Details
	text_end

DarkGuideHints_Hint6_Solution:
	text_far _DarkGuideHints_Hint6_Solution
	text_end

; -------

DarkGuideHints_Hint7:
	text_asm
	ld hl, DarkGuideHints_Hint7_Base
	call PrintText
	call WantMoreDetails
	jr nz, .doneExplaining
	ld hl, DarkGuideHints_Hint7_Details
	call PrintText
	call WantExplicitSolution
	jr nz, .doneExplaining
	ld hl, DarkGuideHints_Hint7_Solution
	call PrintText
.doneExplaining
	jp TextScriptEnd

DarkGuideHints_Hint7_Base:
	text_far _DarkGuideHints_Hint7_Base
	text_end

DarkGuideHints_Hint7_Details:
	text_far _DarkGuideHints_Hint7_Details
	text_end

DarkGuideHints_Hint7_Solution:
	text_far _DarkGuideHints_Hint7_Solution
	text_end

; -------

DarkGuideHints_Hint8:
	text_asm
	ld hl, DarkGuideHints_Hint8_Base
	call PrintText
	call WantMoreDetails
	jr nz, .doneExplaining
	ld hl, DarkGuideHints_Hint8_Details
	call PrintText
	call WantExplicitSolution
	jr nz, .doneExplaining
	ld hl, DarkGuideHints_Hint8_Solution
	call PrintText
.doneExplaining
	jp TextScriptEnd

DarkGuideHints_Hint8_Base:
	text_far _DarkGuideHints_Hint8_Base
	text_end

DarkGuideHints_Hint8_Details:
	text_far _DarkGuideHints_Hint8_Details
	text_end

DarkGuideHints_Hint8_Solution:
	text_far _DarkGuideHints_Hint8_Solution
	text_end
