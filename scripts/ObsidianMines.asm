ObsidianMines_Script:
	RPTextChooser ObsidianMines_TextPointers, ObsidianMines_TextPointers_Rocket
	call EnableAutoTextBoxDrawing
	ld hl, ObsidianMinesTrainerHeaders
	ld de, ObsidianMines_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
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
    ld a, HS_ROUTE_12_HIKER
    ld [wMissableObjectIndex], a
    predef ShowObject
	call UpdateSprites
	ld a, SFX_GO_OUTSIDE
	call PlaySound
	call Delay3
	call GBFadeInFromBlack
	xor a
	ld [wCurMapScript], a
	ret

ObsidianMines_TextPointers:
	dw ObsidianMinesText1 ; trainer
	dw ObsidianMinesText2
	dw ObsidianMinesText3
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText

ObsidianMines_TextPointers_Rocket:
	dw ObsidianMinesText1
	dw GenericNPCText_RocketPath
	dw ObsidianMinesText3_RP ; TBE
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText

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

; new for RP =================================

ObsidianMinesText3_RP:
	text_asm
	CheckEvent EVENT_OBTAIN_MAP_PIECE_4_RESCUED_TRAVELER
	ld hl, ObsidianMinesText3_RP_PostMap
	jr nz, .printAndEnd
; we didn't get the map; did we get the nugget? If not, first time we speak or the bag was full
	CheckEvent EVENT_RP_STOLE_BIG_NUGGET_OBSIDIAN_HIKER
	jr nz, .tryGetMapPiece
; we didn't even get the nugget
	ld hl, ObsidianMinesText3_RP_StealNugget
	call PrintText
	lb bc, BIG_NUGGET, 1
	call GiveItem
	jr nc, .bagFull
; bag is not full
	SetEvent EVENT_RP_STOLE_BIG_NUGGET_OBSIDIAN_HIKER
	ld hl, ObsidianMinesText3_RP_StoleNugget
	call PrintText
.tryGetMapPiece
	ld hl, ObsidianMinesText3_RP_StealMap
	call PrintText
	CheckEvent EVENT_OBTAIN_ANY_MAP_PIECE
	jr nz, .setMapPieceEvent
; first piece we ever obtain, we need to try to give the item as well
.tryGivingMap
	lb bc, MYSTERY_MAP, 1
	call GiveItem
	jr nc, .bagFull
; actually give map
.setMapPieceEvent
	SetEvent EVENT_OBTAIN_MAP_PIECE_4_RESCUED_TRAVELER
	SetEvent EVENT_OBTAIN_ANY_MAP_PIECE
	ld hl, ObsidianMinesText3_RP_StoleMap
	jr .printAndEnd
.bagFull
	ld hl, ObsidianMinesText3_RP_BagFull
.printAndEnd
	call PrintText
	jp TextScriptEnd

ObsidianMinesText3_RP_StealNugget:
	text_far _ObsidianMinesText3_RP_StealNugget
	text_end

ObsidianMinesText3_RP_StoleNugget:
	text_far _ObsidianMinesText3_RP_StoleNugget
	sound_get_item_1
	text_end

ObsidianMinesText3_RP_StealMap:
	text_far _ObsidianMinesText3_RP_StealMap
	text_end

ObsidianMinesText3_RP_StoleMap:
	text_far _ObsidianMinesText3_RP_StoleMap
	sound_get_key_item
	text_end

ObsidianMinesText3_RP_PostMap:
	text_far _ObsidianMinesText3_RP_PostMap
	text_end

ObsidianMinesText3_RP_BagFull:
	text_far _BagFullText_RP
	text_end
