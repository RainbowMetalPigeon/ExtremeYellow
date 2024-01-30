BillsHousePC:
	call EnableAutoTextBoxDrawing
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_UP
	ret nz
	CheckEvent EVENT_LEFT_BILLS_HOUSE_AFTER_HELPING
	jr nz, .displayBillsHousePokemonList
	CheckEventReuseA EVENT_USED_CELL_SEPARATOR_ON_BILL
	jr nz, .displayBillsHouseMonitorText
	CheckEventReuseA EVENT_BILL_SAID_USE_CELL_SEPARATOR
	jr nz, .doCellSeparator
.displayBillsHouseMonitorText
	tx_pre_jump BillsHouseMonitorText
.doCellSeparator
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	tx_pre BillsHouseInitiatedText
	ld c, 32
	call DelayFrames
	ld a, SFX_TINK
	call PlaySound
	call WaitForSoundToFinish
	ld c, 80
	call DelayFrames
	ld a, SFX_SHRINK
	call PlaySound
	call WaitForSoundToFinish
	ld c, 48
	call DelayFrames
	ld a, SFX_TINK
	call PlaySound
	call WaitForSoundToFinish
	ld c, 32
	call DelayFrames
	ld a, SFX_GET_ITEM_1
	call PlaySound
	call WaitForSoundToFinish
	call PlayDefaultMusic
	SetEvent EVENT_USED_CELL_SEPARATOR_ON_BILL
	ret
.displayBillsHousePokemonList
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	tx_pre BillsHousePokemonList
	ret

BillsHouseMonitorText::
	text_far _BillsHouseMonitorText
	text_end

BillsHouseInitiatedText::
	text_far _BillsHouseInitiatedText
	text_promptbutton
	text_asm
	call StopAllMusic
	ld c, 16
	call DelayFrames
	ld a, SFX_SWITCH
	call PlaySound
	call WaitForSoundToFinish
	ld c, 60
	call DelayFrames
	jp TextScriptEnd

BillsHousePokemonList:: ; edited
	text_asm
	call SaveScreenTilesToBuffer1
	ld hl, BillsHousePokemonListText1
	call PrintText
	xor a
	ld [wListScrollOffset], a ; not used?
	ld [wMenuItemOffset], a ; not used
	ld [wCurrentMenuItem], a
	ld [wLastMenuItem], a
.billsPokemonLoop
	ld hl, wd730
	set 6, [hl] ; bit 6: print text with no delay between each letter
	ld hl, BillsHousePokemonListText2
	call PrintText
	call SaveScreenTilesToBuffer2
	ld hl, BillsPcEevolutionsList
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
	jr c, .cancel
	ld a, [wcf91]
	sub BILLSPC_EEVOLUTION_EEVEE
	add EEVEE
; these checks are kinda redundant tbh, I could just check if jr z, SYLVEON + 1 I think?
	cp EEVEE
	jr c, .cancel
	cp SYLVEON + 1
	jr nc, .cancel
	jr .displayPokedex
.displayPokedex
	call DisplayPokedex
	call LoadScreenTilesFromBuffer2
	jr .billsPokemonLoop
.cancel
	ld hl, wd730
	res 6, [hl]
	call LoadScreenTilesFromBuffer2
	jp TextScriptEnd

BillsPcEevolutionsList:
	db 9 ; #
	db BILLSPC_EEVOLUTION_EEVEE
	db BILLSPC_EEVOLUTION_VAPOREON
	db BILLSPC_EEVOLUTION_JOLTEON
	db BILLSPC_EEVOLUTION_FLAREON
	db BILLSPC_EEVOLUTION_ESPEON
	db BILLSPC_EEVOLUTION_UMBREON
	db BILLSPC_EEVOLUTION_LEAFEON
	db BILLSPC_EEVOLUTION_GLACEON
    db BILLSPC_EEVOLUTION_SYLVEON
	db -1 ; end

BillsHousePokemonListText1:
	text_far _BillsHousePokemonListText1
	text_end

BillsHousePokemonListText2:
	text_far _BillsHousePokemonListText2
	text_end
