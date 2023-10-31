ObsidianMines_Script:
	call EnableAutoTextBoxDrawing
	ld hl, ObsidianMinesTrainerHeaders
	ld de, ObsidianMines_ScriptPointers
	ld a, [wObsidianMinesCurScript]
	call ExecuteCurMapScriptInTable
	ld [wObsidianMinesCurScript], a
	ret

ObsidianMines_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw ScriptTest ; $03

ScriptTest:
	call GBFadeOutToBlack
    ld a, HS_OBSIDIAN_MINES_LOST_HIKER
    ld [wMissableObjectIndex], a
    predef HideObjectExtra
	call UpdateSprites
	ld a, SFX_GO_OUTSIDE
	call PlaySound
	call Delay3
	call GBFadeInFromBlack
	xor a
	ld [wObsidianMinesCurScript], a
	ld [wCurMapScript], a
	ret

ObsidianMines_TextPointers:
	dw ObsidianMinesText1
	dw ObsidianMinesText2
	dw ObsidianMinesText3
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	text_end

; ----------------------------------

ObsidianMinesTrainerHeaders:
	def_trainers
ObsidianMinesTrainerHeader0:
	trainer EVENT_BEAT_OBSIDIAN_MINES_TRAINER_0, 2, ObsidianMinesBattleText1, ObsidianMinesEndBattleText1, ObsidianMinesAfterBattleText1
	db -1 ; end

ObsidianMinesText1:
	text_asm
	ld hl, ObsidianMinesTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

ObsidianMinesBattleText1:
	text_far _ObsidianMinesBattleText1
	text_end

ObsidianMinesEndBattleText1:
	text_far _ObsidianMinesEndBattleText1
	text_end

ObsidianMinesAfterBattleText1:
	text_far _ObsidianMinesAfterBattleText1
	text_end

; ----------------------------------

ObsidianMinesText2: ; relax
	text_asm
	ld hl, ObsidianMinesText2_1
	call PrintText
	jp TextScriptEnd

ObsidianMinesText2_1:
	text_far _ObsidianMinesText2_1
	text_end
	
ObsidianMinesText3: ; panic, escape rope
	text_asm
	ld hl, ObsidianMinesText3_Intro
	call PrintText
	ld b, ESCAPE_ROPE
	call IsItemInBag
	jr z, .noEscapeRope
; we have an ESCAPE_ROPE in the inventory
	ld hl, ObsidianMinesText3_CouldGiveRope
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .asshole
; we are not titanic pieces of shit
	ld hl, ObsidianMinesText3_ThanksHereGift
	call PrintText
	lb bc, BIG_NUGGET, 1
	call GiveItem
	jr nc, .bagFull
; bag is not full
	ld a, ESCAPE_ROPE
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	ld hl, ObsidianMinesText3_ThanksATon
	call PrintText

	ld a, 3
	ld [wObsidianMinesCurScript], a
	ld [wCurMapScript], a
	
	jp TextScriptEnd
.noEscapeRope
	ld hl, ObsidianMinesText3_NoRope
	call PrintText
	jp TextScriptEnd
.asshole
	ld hl, ObsidianMinesText3_Asshole
	call PrintText
	jp TextScriptEnd
.bagFull
	ld hl, ObsidianMinesText3_BagFull
	call PrintText
	jp TextScriptEnd

ObsidianMinesText3_Intro:
	text_far _ObsidianMinesText3_Intro
	text_end

ObsidianMinesText3_CouldGiveRope:
	text_far _ObsidianMinesText3_CouldGiveRope
	text_end

ObsidianMinesText3_ThanksHereGift:
	text_far _ObsidianMinesText3_ThanksHereGift
	text_end

ObsidianMinesText3_ThanksATon:
	text_far _ObsidianMinesText3_ThanksATon
	text_end

ObsidianMinesText3_NoRope:
	text_far _ObsidianMinesText3_NoRope
	text_end

ObsidianMinesText3_Asshole:
	text_far _ObsidianMinesText3_Asshole
	text_end

ObsidianMinesText3_BagFull:
	text_far _ObsidianMinesText3_BagFull
	text_end
