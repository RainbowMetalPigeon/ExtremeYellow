CopycatsHouse1F_Script:
	RPTextChooser CopycatsHouse1F_TextPointers, CopycatsHouse1F_TextPointers_Rocket
	call EnableAutoTextBoxDrawing
	ld de, CopycatsHouse1F_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

; ===============================

CopycatsHouse1F_ScriptPointers:
	dw CopycatsHouse1FScript0
	dw CopycatsHouse1FScriptPostBattle

CopycatsHouse1FScript0:
	ret

CopycatsHouse1FScriptPostBattle:
	ld a, [wLevelScalingBackup]
	ld [wLevelScaling], a
	xor a
	ld [wCurMapScript], a
; check battle result
	ld a, [wIsInBattle]
	cp $ff
	jr z, .gotDefeated
; if you won
	xor a                            ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	SetEvent EVENT_DEFEATED_COPYCAT
	ld a, 4
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.gotDefeated
	ret

; ===============================

CopycatsHouse1F_TextPointers:
	dw CopycatsHouse1FText1 ; parent
	dw CopycatsHouse1FText2 ; parent
	dw CopycatsHouse1FText3 ; chansey
	; 2F
	dw CopycatsHouse2FText1 ; Copycat
	dw CopycatsHouse2FText2 ; Doduo
	dw CopycatsHouse2FText3 ; doll
	dw CopycatsHouse2FText4 ; doll
	dw CopycatsHouse2FText5 ; doll
	; signs
	dw CopycatsHouse2FText6 ; Switch
	dw CopycatsHouse2FText7 ; PC
	dw CopycatsHouse2FText8 ; new

CopycatsHouse1F_TextPointers_Rocket:
	dw GenericNPCText_RocketPath ; parent
	dw GenericNPCText_RocketPath ; parent
	dw CopycatsHouse1FText3 ; chansey
	; 2F
	dw CopycatsHouse2FText1_RP ; Copycat TBE
	dw CopycatsHouse2FText2 ; Doduo
	dw CopycatsHouse2FText3_RP ; doll
	dw CopycatsHouse2FText4_RP ; doll
	dw CopycatsHouse2FText5_RP ; doll
	; signs
	dw CopycatsHouse2FText6_RP ; Switch
	dw CopycatsHouse2FText7 ; PC
	dw CopycatsHouse2FText8_RP

CopycatsHouse1FText1:
	text_far _CopycatsHouse1FText1
	text_end

CopycatsHouse1FText2:
	text_far _CopycatsHouse1FText2
	text_end

CopycatsHouse1FText3:
	text_far _CopycatsHouse1FText3
	text_asm
	ld a, CHANSEY
	call PlayCry
	jp TextScriptEnd

; 2F ----------------------------------

CopycatsHouse2FText1: ; edited
	text_asm
	CheckEvent EVENT_GOT_TM31
	jr nz, .got_item
	CheckEvent EVENT_DEFEATED_COPYCAT
	jr nz, .defatedCopycatButNotGotTMYet
	ld a, TRUE
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, CopycatsHouse2FText_5ccd4
	call PrintText
	ld b, POKE_DOLL
	call IsItemInBag
	jp z, .done
	ld hl, TM31PreReceiveText
	call PrintText
; backup the current Level Scaling option choice to restore it after the battle
	ld a, [wLevelScaling]
	ld [wLevelScalingBackup], a
	ld a, 1
	ld [wLevelScaling], a
; set up the battle
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, CopycatText_PostBattleText
	ld de, CopycatText_PostBattleText
	call SaveEndBattleTextPointers
	ld a, OPP_PSYCHIC_TR
	ld [wCurOpponent], a
	ld a, 5
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	xor a
	ldh [hJoyHeld], a
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd
.defatedCopycatButNotGotTMYet
	ld hl, PostBattleAndGiveTMText
	call PrintText
	lb bc, TM_MIMIC, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, ReceivedTM31Text
	call PrintText
	SetEvent EVENT_GOT_TM31
	jr .done
.bag_full
	ld hl, TM31NoRoomText
	call PrintText
	jr .done
.got_item
	ld hl, TM31ExplanationText2
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .rematchRefused
	ld hl, CopycatsHouse2FText_BattleAccepted
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, CopycatText_PostBattleText2
	ld de, CopycatText_PostBattleText2
	call SaveEndBattleTextPointers
	ld a, OPP_PSYCHIC_TR
	ld [wCurOpponent], a
	ld a, 5
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	xor a
	ldh [hJoyHeld], a
	jr .done
.rematchRefused
	ld hl, CopycatsHouse2FText_BattleRefused
	call PrintText
.done
	jp TextScriptEnd

CopycatsHouse2FText_5ccd4:
	text_far _CopycatsHouse2FText_5ccd4
	text_end

TM31PreReceiveText:
	text_far _TM31PreReceiveText
	text_end

ReceivedTM31Text:
	text_far _ReceivedTM31Text
	sound_get_item_1
TM31ExplanationText1:
	text_far _TM31ExplanationText1
;	text_waitbutton
	text_end

TM31ExplanationText2:
	text_far _TM31ExplanationText2
	text_end

TM31NoRoomText:
	text_far _TM31NoRoomText
	text_waitbutton
	text_end

CopycatsHouse2FText2:
	text_far _CopycatsHouse2FText2
	text_end

CopycatsHouse2FText5:
CopycatsHouse2FText4:
CopycatsHouse2FText3:
CopycatsHouse2FText8: ; new
	text_far _CopycatsHouse2FText3
	text_end

CopycatsHouse2FText6:
	text_far _CopycatsHouse2FText6
	text_end

CopycatsHouse2FText7:
	text_asm
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_UP
	ld hl, CopycatsHouse2FText_5cd1c
	jr nz, .notUp
	ld hl, CopycatsHouse2FText_5cd17
.notUp
	call PrintText
	jp TextScriptEnd

CopycatsHouse2FText_5cd17:
	text_far _CopycatsHouse2FText_5cd17
	text_end

CopycatsHouse2FText_5cd1c:
	text_far _CopycatsHouse2FText_5cd1c
	text_end

PostBattleAndGiveTMText: ; new
	text_far _PostBattleAndGiveTMText
	text_end

CopycatText_PostBattleText: ; new
	text_far _CopycatText_PostBattleText
	text_end

CopycatText_PostBattleText2: ; new
	text_far _CopycatText_PostBattleText2
	text_end

CopycatsHouse2FText_BattleRefused: ; new
	text_far _CopycatsHouse2FText_BattleRefused
	text_end

CopycatsHouse2FText_BattleAccepted: ; new
	text_far _CopycatsHouse2FText_BattleAccepted
	text_end

; new for RP ===============================

CopycatsHouse2FText1_RP:
	text_asm
	CheckEvent EVENT_GOT_TM31
	ld hl, CopycatsHouse2FText1_RP_TMAlreadyGot
	jr nz, .printAndEnd
	CheckEvent EVENT_DEFEATED_COPYCAT
	jr nz, .defatedCopycatButNotGotTMYet
; copycat not faced yet
	ld a, TRUE
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, CopycatsHouse2FText1_RP_PreBattle
	call PrintText
; backup the current Level Scaling option choice to restore it after the battle
	ld a, [wLevelScaling]
	ld [wLevelScalingBackup], a
	ld a, 1
	ld [wLevelScaling], a
; set up the battle
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, CopycatText_PostBattleText_RP
	ld de, CopycatText_PostBattleText_RP
	call SaveEndBattleTextPointers
	SetEvent EVENT_RP_USE_VANILLA_BATTLE_MESSAGES
	ld a, OPP_PSYCHIC_TR
	ld [wCurOpponent], a
	ld a, 5
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	xor a
	ldh [hJoyHeld], a
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd
.defatedCopycatButNotGotTMYet
	ld hl, CopycatsHouse2FText1_RP_GiveTM
	call PrintText
	lb bc, TM_MIMIC, 1
	call GiveItem
	jr nc, .bagFull
; actually get the TM
	SetEvent EVENT_GOT_TM31
	ld hl, CopycatsHouse2FText1_RP_ReceivedTM
	jr .printAndEnd
.bagFull
	ld hl, CopycatsHouse2FText1_RP_BagFull
.printAndEnd
	call PrintText
	jp TextScriptEnd

CopycatsHouse2FText1_RP_TMAlreadyGot:
	text_far _CopycatsHouse2FText1_RP_TMAlreadyGot
	text_end

CopycatsHouse2FText1_RP_PreBattle:
	text_far _CopycatsHouse2FText1_RP_PreBattle
	text_end

CopycatText_PostBattleText_RP:
	text_far _CopycatText_PostBattleText_RP
	text_end

CopycatsHouse2FText1_RP_GiveTM:
	text_far _CopycatsHouse2FText1_RP_GiveTM
	text_end

CopycatsHouse2FText1_RP_BagFull:
	text_far _BagFullText_RP
	text_end

CopycatsHouse2FText1_RP_ReceivedTM:
	text_far _ReceivedTM31Text
	sound_get_item_1
	text_end

CopycatsHouse2FText6_RP:
	text_far _CopycatsHouse2FText6_RP
	text_end

CopycatsHouse2FText5_RP:
CopycatsHouse2FText4_RP:
CopycatsHouse2FText3_RP:
CopycatsHouse2FText8_RP:
	text_far _CopycatsHouse2FText3_RP
	text_end
