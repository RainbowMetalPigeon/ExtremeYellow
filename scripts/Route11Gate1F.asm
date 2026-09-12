Route11Gate1F_Script:
	RPTextChooser Route11Gate1F_TextPointers, Route11Gate1F_TextPointers_Rocket
	call EnableAutoTextBoxDrawing
	ld de, Route11Gate1F_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

Route11Gate1F_ScriptPointers: ;  new
	dw Route11Gate1F_Null ; 0
	dw Route11Gate1F_PostBattle ; 1

Route11Gate1F_Null:
	ret

Route11Gate1F_TextPointers:
	dw Route11GateText1
	; 2F
	dw Route11GateUpstairsText1
	dw Route11GateUpstairsText2 ; ITEMFINDER AID
	; signs
	dw Route11GateUpstairsText3
	dw Route11GateUpstairsText4

Route11Gate1F_TextPointers_Rocket:
	dw GenericNPCText_RocketPath
	; 2F
	dw GenericNPCText_RocketPath
	dw Route11GateUpstairsText2_RP ; ITEMFINDER AID
	; signs
	dw Route11GateUpstairsText3
	dw Route11GateUpstairsText4

Route11GateText1:
	text_far _Route11GateText1
	text_end

Route11GateUpstairsText1:
	text_asm
	ld a, TRADE_FOR_TOUNGY ; edited
	ld [wWhichTrade], a
	predef DoInGameTradeDialogue
Route11GateUpstairsScriptEnd:
	jp TextScriptEnd

Route11GateUpstairsText2:
	text_asm
	CheckEvent EVENT_GOT_ITEMFINDER, 1
	jr c, .got_item
	ld a, 30
	ldh [hOaksAideRequirement], a
	ld a, ITEMFINDER
	ldh [hOaksAideRewardItem], a
	ld [wd11e], a
	call GetItemName
	ld h, d
	ld l, e
	ld de, wOaksAideRewardItemName
	ld bc, ITEM_NAME_LENGTH
	call CopyData
	predef OaksAideScript
	ldh a, [hOaksAideResult]
	dec a ; OAKS_AIDE_GOT_ITEM?
	jr nz, .no_item
	SetEvent EVENT_GOT_ITEMFINDER
.got_item
	ld hl, Route11GateUpstairsText_494a3
	call PrintText
.no_item
	jr Route11GateUpstairsScriptEnd

Route11GateUpstairsText_494a3:
	text_far _Route11GateUpstairsText_494a3
	text_end

Route11GateUpstairsText3:
	text_asm
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_UP
	jp nz, GateUpstairsScript_PrintIfFacingUp
	CheckEvent EVENT_BEAT_ROUTE12_SNORLAX
	ld hl, BinocularsSnorlaxText
	jr z, .print
	ld hl, BinocularsNoSnorlaxText
.print
	call PrintText
	jp TextScriptEnd

BinocularsSnorlaxText:
	text_far _BinocularsSnorlaxText
	text_end

BinocularsNoSnorlaxText:
	text_far _BinocularsNoSnorlaxText
	text_end

Route11GateUpstairsText4:
	text_asm
	ld hl, Route11GateUpstairsText_494d5
	jp GateUpstairsScript_PrintIfFacingUp

Route11GateUpstairsText_494d5:
	text_far _Route11GateUpstairsText_494d5
	text_end

; new for RP ========================

Route11GateUpstairsText2_RP:
	text_asm
	CheckEvent EVENT_GOT_ITEMFINDER
	ld hl, Route11Gate1FText1_RP_PostHM
	jr nz, .printAndEnd
	CheckEvent EVENT_RP_BEAT_ITEMFINDER_AID
	jr nz, .giveHM05
; set up the battle
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_SCIENTIST
	ld [wCurOpponent], a
	ld a, 21
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld a, 1
	ld [wCurMapScript], a
	ld hl, Route11Gate1FText1_RP_MustStopYou
	jr .printAndEnd
.giveHM05
	ld hl, Route11Gate1FText1_RP_TakeThis
	call PrintText
	lb bc, ITEMFINDER, 1
	call GiveItem
	jr nc, .bagFull
	SetEvent EVENT_GOT_ITEMFINDER
	ld hl, Route11Gate1FText1_RP_ObtainItem
	jr .printAndEnd
.bagFull
	ld hl, Route11Gate1FText1_RP_BagFull
.printAndEnd
	call PrintText
	jp TextScriptEnd

Route11Gate1FText1_RP_PostHM:
	text_far _RouteAnyGateText1_RP_PostHM
	text_end

Route11Gate1FText1_RP_MustStopYou:
	text_far _RouteAnyGateText1_RP_MustStopYou
	text_end

Route11Gate1FText1_RP_TakeThis:
	text_far _RouteAnyGateText1_RP_TakeThis
	text_end

Route11Gate1FText1_RP_ObtainItem:
	text_far _ReceivedHM01Text
	sound_get_key_item
	text_end

Route11Gate1FText1_RP_BagFull:
	text_far _RouteAnyGateText1_RP_BagFull
	text_end

Route11Gate1F_PostBattle:
	ld a, [wIsInBattle]
	cp $ff
	jp z, Route11Gate1FResetScripts
	ld a, $f0
	ld [wJoyIgnore], a
; we won
	SetEvent EVENT_RP_BEAT_ITEMFINDER_AID
	xor a
	ld [wJoyIgnore], a
	ld a, 3
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	; fallthrough
Route11Gate1FResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret
