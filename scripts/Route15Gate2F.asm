Route15Gate2F_Script:
	call EnableAutoTextBoxDrawing
	ld de, Route15Gate2F_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

Route15Gate2F_ScriptPointers:
	dw Route15Gate2FScript0
	dw Route15Gate2FScript1

Route15Gate2FScript0:
	ret

Route15Gate2FScript1:
	ld a, ARTICUNO
	ld [wcf91], a
	call PlayCry
	callfar DisplayMonFrontSpriteInBox
	xor a
	ldh [hAutoBGTransferEnabled], a
	call RestoreOverworld
; script handling
	xor a
	ld [wCurMapScript], a
	ret

Route15Gate2F_TextPointers:
	dw Route15GateUpstairsText1
	dw Route15GateUpstairsTextArticuno ; new
	dw Route15GateUpstairsText2

Route15GateUpstairsText1:
	text_asm
	CheckEvent EVENT_GOT_EXP_ALL
	jr nz, .got_item
	ld a, 50
	ldh [hOaksAideRequirement], a
	ld a, EXP_ALL
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
	SetEvent EVENT_GOT_EXP_ALL
.got_item
	ld hl, Route15GateUpstairsText_4968c
	call PrintText
.no_item
	jp TextScriptEnd

Route15GateUpstairsText_4968c:
	text_far _Route15GateUpstairsText_4968c
	text_end

Route15GateUpstairsText2:
	text_asm
	ld hl, Route15GateUpstairsText_49698
	jp GateUpstairsScript_PrintIfFacingUp

Route15GateUpstairsText_49698:
	text_far _Route15GateUpstairsText_49698
	text_end

; new ===========================================

Route15GateUpstairsTextArticuno:
	text_asm
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_UP
	jr nz, .terminate
; we do are facing UP
	CheckEvent EVENT_PLACED_ALL_ORBS_IN_RECESSES
	jr nz, .ArticunoSummoned
; Articuno not summoned yet
	ld hl, Route15GateUpstairsText_Articuno_1
	jr .printAndEnd
.ArticunoSummoned
	CheckHideShowExtra HS_ARTICUNO ; z flag if is SHOW, nz if is HIDE
	jr z, .ArticunoNotCaught
; Articuno summoned and caught
	ld hl, Route15GateUpstairsText_Articuno_3
	jr .printAndEnd
.ArticunoNotCaught
	ld hl, Route15GateUpstairsText_Articuno_2
	call PrintText
; script handling
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd
.printAndEnd
	call PrintText
.terminate
	jp TextScriptEnd

Route15GateUpstairsText_Articuno_3:
	text_far _Route15GateUpstairsText_Articuno_3
	text_end

Route15GateUpstairsText_Articuno_2:
	text_far _Route15GateUpstairsText_Articuno_2
	text_end

Route15GateUpstairsText_Articuno_1:
	text_far _Route15GateUpstairsText_Articuno_1
	text_end

RestoreOverworld:
	call LoadCurrentMapView
	jp UpdateSprites
