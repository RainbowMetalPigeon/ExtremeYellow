SaffronClimbClub_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SaffronClimbClub_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

; scripts =========================================

SaffronClimbClub_ScriptPointers:
	dw SaffronClimbClub_0 ; 0
	dw SaffronClimbClub_1 ; 1
	dw SaffronClimbClub_2 ; 2

SaffronClimbClub_0:
	CheckEvent EVENT_GOT_HM07
	ret nz
	ld hl, SaffronClimbClub_GuideBlockage_Coordinates
	call ArePlayerCoordsInArray ; sets carry if the coordinates are in the array, clears carry if not
	ret nc
; turn guard and player and display dialogue
	ld a, SPRITE_FACING_LEFT
	ld [wSpritePlayerStateData1FacingDirection], a
	lb bc, STAY, RIGHT
	ld a, 1
	ldh [hSpriteIndex], a
	call ChangeSpriteMovementBytes
	lb de, 1, SPRITE_FACING_RIGHT
	callfar ChangeSpriteFacing ; new Pigeon approach
	ld a, 1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; load next script
	ld a, 1
	ld [wCurMapScript], a
	ret

SaffronClimbClub_GuideBlockage_Coordinates:
	dbmapcoord  9, 17
	db -1 ; end

SaffronClimbClub_1:
; check if we set the event in the dialogue
	CheckEvent EVENT_GOT_HM07
	jr z, .noHM
; if yes, we're good -> script=0
	jp SaffronClimbClubResetScripts
.noHM
; if not, walk the player down by 1
	ld a, $ff
	ld [wJoyIgnore], a
	ld hl, wSimulatedJoypadStatesEnd
	ld de, SaffronClimbClubPushAway_RLEMovement
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
; load next script
	ld a, 2
	ld [wCurMapScript], a
	ret

SaffronClimbClubPushAway_RLEMovement:
	db D_DOWN, 1
	db -1 ; end

SaffronClimbClub_2:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	xor a
	ld [wJoyIgnore], a
; player finished moving
	; fallthrough
SaffronClimbClubResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

; texts =========================================

SaffronClimbClub_TextPointers:
	dw SaffronClimbClubText1 ; 1 Guide
	dw SaffronClimbClubText2 ; 2 Hiker
	dw SaffronClimbClubText3 ; 3 Hiker
	dw SaffronClimbClubText4 ; 4 Hiker
	dw SaffronClimbClubText5 ; 5 Hiker
	dw PickUpItemText ; 6
	dw PickUpItemText ; 7
	dw PickUpItemText ; 8
	; scripts
;	dw SaffronClimbClubScriptText1 ; 9

SaffronClimbClubText1:
	text_asm
	CheckEvent EVENT_GOT_HM07
	ld hl, SaffronClimbClubText1_After
	jr nz, .printAndEnd
; not got HM yet
	ld hl, SaffronClimbClubText1_Before
	call PrintText
; do we have the invitation?
	ld b, CC_INVITE
	call IsItemInBag ; set zero flag if item isn't in player's bag
	ld hl, SaffronClimbClubText1_NoInviteSorryCiao
	jr z, .printAndEnd
; we have it in bag
	ld hl, SaffronClimbClubText1_OhWelcomeHaveThis
	call PrintText
	ld a, CC_INVITE
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	lb bc, HM_ROCK_CLIMB, 1
	call GiveItem
	SetEvent EVENT_GOT_HM07
	ld hl, SaffronClimbClubText1_GotHM07
.printAndEnd
	call PrintText
	jp TextScriptEnd

SaffronClimbClubText1_OhWelcomeHaveThis:
	text_far _SaffronClimbClubText1_OhWelcomeHaveThis
	text_end

SaffronClimbClubText1_GotHM07:
	text_far _SaffronClimbClubText1_GotHM07
	sound_get_key_item
	text_end

SaffronClimbClubText1_NoInviteSorryCiao:
	text_far _SaffronClimbClubText1_NoInviteSorryCiao
	text_end

SaffronClimbClubText1_Before:
	text_far _SaffronClimbClubText1_Before
	text_end

SaffronClimbClubText1_After:
	text_far _SaffronClimbClubText1_After
	text_end

SaffronClimbClubText2:
	text_far _SaffronClimbClubText2
	text_end

SaffronClimbClubText3:
	text_far _SaffronClimbClubText3
	text_end

SaffronClimbClubText4:
	text_far _SaffronClimbClubText4
	text_end

SaffronClimbClubText5:
	text_far _SaffronClimbClubText5
	text_end
