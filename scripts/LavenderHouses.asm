LavenderHouses_Script:
	call EnableAutoTextBoxDrawing
	ret

LavenderHouses_TextPointers:
	; Fuji house
	dw LavenderHouse1Text1
	dw LavenderHouse1Text2
	dw LavenderHouse1Text3
	dw LavenderHouse1Text4
	dw LavenderHouse1Text5
	dw LavenderHouse1Text6
	; Cubone house
	dw LavenderHouse2Text1
	dw LavenderHouse2Text2
	; Name rater house
	dw NameRaterText1

; Fuji house -----------------------------

LavenderHouse1Text1:
	text_asm
	CheckEvent EVENT_RESCUED_MR_FUJI
	jr nz, .rescued_mr_fuji
	ld hl, LavenderHouse1Text_1d8d1
	call PrintText
	jr .done
.rescued_mr_fuji
	ld hl, LavenderHouse1Text_1d8d6
	call PrintText
.done
	jp TextScriptEnd

LavenderHouse1Text_1d8d1:
	text_far _LavenderHouse1Text_1d8d1
	text_end

LavenderHouse1Text_1d8d6:
	text_far _LavenderHouse1Text_1d8d6
	text_end

LavenderHouse1Text2:
	text_asm
	CheckEvent EVENT_RESCUED_MR_FUJI
	jr nz, .rescued_mr_fuji
	ld hl, LavenderHouse1Text_1d8f4
	call PrintText
	jr .done
.rescued_mr_fuji
	ld hl, LavenderHouse1Text_1d8f9
	call PrintText
.done
	jp TextScriptEnd

LavenderHouse1Text_1d8f4:
	text_far _LavenderHouse1Text_1d8f4
	text_end

LavenderHouse1Text_1d8f9:
	text_far _LavenderHouse1Text_1d8f9
	text_end

LavenderHouse1Text3:
	text_far _LavenderHouse1Text3
	text_asm
	ld a, PSYDUCK
	call PlayCry
	jp TextScriptEnd

LavenderHouse1Text4:
	text_far _LavenderHouse1Text4
	text_asm
	ld a, NIDORINO
	call PlayCry
	jp TextScriptEnd

LavenderHouse1Text5:
	text_asm
	CheckEvent EVENT_GOT_POKE_FLUTE
	jr nz, .got_item_flute
	ld hl, LavenderHouse1Text_1d94c
	call PrintText
	lb bc, POKE_FLUTE, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, ReceivedFluteText
	call PrintText
	SetEvent EVENT_GOT_POKE_FLUTE
	jr .done
.got_item_flute
	CheckEvent EVENT_GOT_FUJI_MEGA_STONE_X
	jr nz, .got_item_mstonex
	ld hl, LavenderHouse1Text_MegaStone
	call PrintText
	lb bc, MEGA_STONE_X, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, ReceivedMegaStoneXText
	call PrintText
	SetEvent EVENT_GOT_FUJI_MEGA_STONE_X
	jr .done
.bag_full
	ld hl, FluteOrStoneNoRoomText
	call PrintText
	jr .done
.got_item_mstonex
	ld hl, MrFujiAfterFluteAndStoneText
	call PrintText
.done
	jp TextScriptEnd

LavenderHouse1Text_1d94c:
	text_far _LavenderHouse1Text_1d94c
	text_end

LavenderHouse1Text_MegaStone: ; new
	text_far _LavenderHouse1Text_MegaStone
	text_end

ReceivedFluteText:
	text_far _ReceivedFluteText
	sound_get_key_item
	text_far _FluteExplanationText
	text_end

ReceivedMegaStoneXText:
	text_far _ReceivedFluteText
	sound_get_item_2
	text_far _MegaStoneXExplanationText
	text_end

FluteOrStoneNoRoomText:
	text_far _FluteOrStoneNoRoomText
	text_end

MrFujiAfterFluteAndStoneText:
	text_far _MrFujiAfterFluteAndStoneText
	text_end

LavenderHouse1Text6:
	text_far _LavenderHouse1Text6
	text_end

; Cubone house -----------------------------

LavenderHouse2Text1:
	text_far _LavenderHouse2Text1
	text_asm
	ld a, CUBONE
	call PlayCry
	jp TextScriptEnd

LavenderHouse2Text2:
	text_asm
	CheckEvent EVENT_RESCUED_MR_FUJI
	jr nz, .rescued_mr_fuji
	ld hl, LavenderHouse2Text_1d9dc
	call PrintText
	jr .done
.rescued_mr_fuji
	ld hl, LavenderHouse2Text_1d9e1
	call PrintText
.done
	jp TextScriptEnd

LavenderHouse2Text_1d9dc:
	text_far _LavenderHouse2Text_1d9dc
	text_end

LavenderHouse2Text_1d9e1:
	text_far _LavenderHouse2Text_1d9e1
	text_end

; Name rater house -----------------------------


NameRaterText1:
	text_asm
	call SaveScreenTilesToBuffer2
	ld hl, NameRaterText_1dab3
	call NameRaterScript_1da15
	jr nz, .asm_1daae
	ld hl, NameRaterText_1dab8
	call PrintText
	xor a
	ld [wPartyMenuTypeOrMessageID], a
	ld [wUpdateSpritesEnabled], a
	ld [wMenuItemToSwap], a
	call DisplayPartyMenu
	push af
	call GBPalWhiteOutWithDelay3
	call RestoreScreenTilesAndReloadTilePatterns
	call LoadGBPal
	pop af
	jr c, .asm_1daae
	call GetPartyMonName2
; new, to handle MISSINGNO, shouldn't need push-pop
	ld a, [wWhichPokemon]
	ld c, a
	ld b, 0
	ld hl, wPartySpecies
	add hl, bc
	ld a, [hl] ; species
	cp MISSINGNO
	jp z, .cantHandleThisMon
; back to vanilla
	call NameRaterScript_1da20
	ld hl, NameRaterText_1dad1
	jr c, .asm_1daa8
	call ReloadTilesetTilePatterns ; new, to expand tileset
	ld hl, NameRaterText_1dabd
	call NameRaterScript_1da15
	jr nz, .asm_1daae
	ld hl, NameRaterText_1dac2
	call PrintText
	farcall DisplayNameRaterScreen
	call ReloadTilesetTilePatterns ; new, to expand tileset
	jr c, .asm_1daae
	ld hl, NameRaterText_1dac7
.asm_1daa8
	call PrintText
	jp TextScriptEnd
.asm_1daae
	ld hl, NameRaterText_1dacc
	jr .asm_1daa8
.cantHandleThisMon ; new
	ld hl, NameRaterText_cantHandleThisMon
	jr .asm_1daa8

NameRaterText_1dab3:
	text_far _NameRaterText_1dab3
	text_end

NameRaterText_1dab8:
	text_far _NameRaterText_1dab8
	text_end

NameRaterText_1dabd:
	text_far _NameRaterText_1dabd
	text_end

NameRaterText_1dac2:
	text_far _NameRaterText_1dac2
	text_end

NameRaterText_1dac7:
	text_far _NameRaterText_1dac7
	text_end

NameRaterText_1dacc:
	text_far _NameRaterText_1dacc
	text_end

NameRaterText_1dad1:
	text_far _NameRaterText_1dad1
	text_end

NameRaterText_cantHandleThisMon: ; new
	text_far _DayCareCantTakeThisMon ; same as Day Care
	text_end

NameRaterScript_1da15:
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ret

NameRaterScript_1da20:
	callfar IsThisPartymonStarterPikachu_Party ; sets carry flag if it's Starter Pikachu ; new
	jr c, .canRename ; new
	ld hl, wPartyMonOT
	ld bc, NAME_LENGTH
	ld a, [wWhichPokemon]
	call AddNTimes
	ld de, wPlayerName
	ld c, NAME_LENGTH
	call .asm_1da47
	jr c, .asm_1da52
	ld hl, wPartyMon1OTID
	ld bc, wPartyMon2 - wPartyMon1
	ld a, [wWhichPokemon]
	call AddNTimes
	ld de, wPlayerID
	ld c, $2
.asm_1da47
	ld a, [de]
	cp [hl]
	jr nz, .asm_1da52
	inc hl
	inc de
	dec c
	jr nz, .asm_1da47
.canRename ; new label
	and a
	ret
.asm_1da52 ; cannot rename
	scf
	ret
