Route2AllGates_Script:
	RPTextChooser Route2AllGates_TextPointers, Route2AllGates_TextPointers_Rocket
	call EnableAutoTextBoxDrawing
	ld hl, Route2AllGates_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

Route2AllGates_ScriptPointers:
	dw Route2AllGates_Null ; 0
	dw Route2AllGates_PostBattle ; 1

Route2AllGates_Null:
	ret

Route2AllGates_TextPointers:
	; Route 2 Gate
	dw Route2GateText1
	dw Route2GateText2
	; Viridian Forest South Gate
	dw ViridianForestEntranceText1
	dw ViridianForestEntranceText2
	; Viridian Forest South Gate
	dw ViridianForestExitText1
	dw ViridianForestExitText2

Route2AllGates_TextPointers_Rocket:
	; Route 2 Gate
	dw Route2GateText1_RP ; Flash AID
	dw GenericNPCText_RocketPath
	; Viridian Forest South Gate
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	; Viridian Forest South Gate
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath

Route2GateText1:
	text_asm
	CheckEvent EVENT_GOT_HM05
	jr nz, .got_item
	ld a, 10
	ldh [hOaksAideRequirement], a
	ld a, HM_FLASH
	ldh [hOaksAideRewardItem], a
	ld [wd11e], a
	call GetItemName
	ld hl, wcd6d
	ld de, wOaksAideRewardItemName
	ld bc, ITEM_NAME_LENGTH
	call CopyData
	predef OaksAideScript
	ldh a, [hOaksAideResult]
	cp OAKS_AIDE_GOT_ITEM
	jr nz, .no_item
	SetEvent EVENT_GOT_HM05
.got_item
	ld hl, Route2GateText_5d616
	call PrintText
.no_item
	jp TextScriptEnd

Route2GateText_5d616:
	text_far _Route2GateText_5d616
	text_end

Route2GateText2:
	text_far _Route2GateText2
	text_end

ViridianForestEntranceText1:
	text_far _ViridianForestEntranceText1
	text_end

ViridianForestEntranceText2:
	text_far _ViridianForestEntranceText2
	text_end

ViridianForestExitText1:
	text_far _ViridianForestExitText1
	text_end

ViridianForestExitText2:
	text_far _ViridianForestExitText2
	text_end

; new for RP ========================

Route2GateText1_RP:
	text_asm
	CheckEvent EVENT_GOT_HM05
	ld hl, Route2GateText1_RP_PostHM
	jr nz, .printAndEnd
	CheckEvent EVENT_RP_BEAT_HM05_AID
	jr nz, .giveHM05
; set up the battle
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_SCIENTIST
	ld [wCurOpponent], a
	ld a, 19
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
;	ld hl, TerrainTutorDefeatText
;	ld de, TerrainTutorDefeatText
;	call SaveEndBattleTextPointers ; unnecessary in RP?
	ld a, 1
	ld [wCurMapScript], a
	ld hl, Route2GateText1_RP_MustStopYou
	jr .printAndEnd
.giveHM05
	ld hl, Route2GateText1_RP_TakeThis
	call PrintText
	lb bc, HM_FLASH, 1
	call GiveItem
	jr nc, .bagFull
	SetEvent EVENT_GOT_HM05
	ld hl, Route2GateText1_RP_ObtainItem
	jr .printAndEnd
.bagFull
	ld hl, Route2GateText1_RP_BagFull
.printAndEnd
	call PrintText
	jp TextScriptEnd

Route2GateText1_RP_PostHM:
	text_far _Route2GateText1_RP_PostHM
	text_end

Route2GateText1_RP_MustStopYou:
	text_far _Route2GateText1_RP_MustStopYou
	text_end

Route2GateText1_RP_TakeThis:
	text_far _Route2GateText1_RP_TakeThis
	text_end

Route2GateText1_RP_ObtainItem:
	text_far _ReceivedHM01Text
	sound_get_key_item
	text_end

Route2GateText1_RP_BagFull:
	text_far _Route2GateText1_RP_BagFull
	text_end

Route2AllGates_PostBattle:
	ld a, [wIsInBattle]
	cp $ff
	jp z, Route2AllGatesResetScripts
	ld a, $f0
	ld [wJoyIgnore], a
; we won
	SetEvent EVENT_RP_BEAT_HM05_AID
	xor a
	ld [wJoyIgnore], a
	ld a, 1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	; fallthrough
Route2AllGatesResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret
