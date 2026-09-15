Func_EntryPerson::
	ld a, [wYCoord]
	cp 4
	jr nz, .not_right_of_scientist
	ld a, [wXCoord]
	cp 13
	jp z, .behind_counter
	jr .check_ticket

.not_right_of_scientist
	cp $3
	jr nz, .not_behind_counter
	ld a, [wXCoord]
	cp 12
	jp z, .behind_counter
.not_behind_counter
	CheckEvent EVENT_BOUGHT_MUSEUM_TICKET
	jr nz, .already_bought_ticket
	ld hl, Museum1FText_PleaseGoOtherSide
	call PrintText
	jp .done

.check_ticket
	CheckEvent EVENT_BOUGHT_MUSEUM_TICKET
	jr z, .no_ticket
.already_bought_ticket
	ld hl, Museum1FText_TakeTime
	call PrintText
	jp .done

.no_ticket
	ld a, $13
	ld [wTextBoxID], a
	call DisplayTextBoxID
	xor a
	ldh [hJoyHeld], a
	ld hl, Museum1FText_50YenWannCome
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .deny_entry
	xor a
	ldh [hMoney], a
	ldh [hMoney + 1], a
	ld a, $50
	ldh [hMoney + 2], a
	call HasEnoughMoney
	jr nc, .buy_ticket
	ld hl, Museum1FText_NotEnoughMoney
	call PrintText
	jp .deny_entry

.buy_ticket
	ld hl, Museum1FText_Thanks
	call PrintText
	SetEvent EVENT_BOUGHT_MUSEUM_TICKET
	xor a
	ld [wPriceTemp], a
	ld [wPriceTemp + 1], a
	ld a, $50
	ld [wPriceTemp + 2], a
	ld hl, wPriceTemp + 2
	ld de, wPlayerMoney + 2
	ld c, 3
	predef SubBCDPredef
	ld a, $13
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld a, SFX_PURCHASE
	call PlaySoundWaitForCurrent
	call WaitForSoundToFinish
	jr .allow_entry

.deny_entry
	ld hl, Museum1FText_ComeAgain
	call PrintText
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	ld a, D_DOWN | B_BUTTON ; edited to fix Pikachu blocker
	ld [wSimulatedJoypadStatesEnd], a
	call StartSimulatingJoypadStates
	call UpdateSprites
	jr .done

.allow_entry
	ld a, $1
	ld [wMuseum1FCurScript], a
	jr .done

.behind_counter
	ld hl, Museum1FText_CantSneak
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	cp 0
	jr nz, .explain_amber
	ld hl, Museum1FText_CinnabarLab
	call PrintText
	jr .done

.explain_amber
	ld hl, Museum1FText_AmberIs
	call PrintText
.done
	ret

Museum1FText_ComeAgain:
	text_far _Museum1FText_ComeAgain
	text_end

Museum1FText_50YenWannCome:
	text_far _Museum1FText_50YenWannCome
	text_end

Museum1FText_Thanks:
	text_far _Museum1FText_Thanks
	text_end

Museum1FText_NotEnoughMoney:
	text_far _Museum1FText_NotEnoughMoney
	text_end

Museum1FText_CantSneak:
	text_far _Museum1FText_CantSneak
	text_end

Museum1FText_CinnabarLab:
	text_far _Museum1FText_CinnabarLab
	text_end

Museum1FText_AmberIs:
	text_far _Museum1FText_AmberIs
	text_end

Museum1FText_PleaseGoOtherSide:
	text_far _Museum1FText_PleaseGoOtherSide
	text_end

Museum1FText_TakeTime:
	text_far _Museum1FText_TakeTime
	text_end

Func_PrintPraise::
	ld hl, Museum1FText_Praise
	call PrintText
	ret

Museum1FText_Praise:
	text_far _Museum1FText_Praise
	text_end

Func_GiveAmber::
	CheckEvent EVENT_GOT_OLD_AMBER
	jr nz, .got_item
	ld hl, Museum1FText_TakeThisToLab
	call PrintText
	lb bc, OLD_AMBER, 1
	call GiveItem
	jr nc, .bag_full
	SetEvent EVENT_GOT_OLD_AMBER
	ld a, HS_OLD_AMBER
	ld [wMissableObjectIndex], a
	predef HideObject
	ld hl, ReceivedOldAmberText
	jr .done
.bag_full
	ld hl, Museum1FText_NoSpace
	jr .done
.got_item
	ld hl, Museum1FText_SshGetAmberChecked
.done
	call PrintText
	ret

Museum1FText_TakeThisToLab:
	text_far _Museum1FText_TakeThisToLab
	text_end

ReceivedOldAmberText:
	text_far _ReceivedOldAmberText
	sound_get_item_1
	text_end

Museum1FText_SshGetAmberChecked:
	text_far _Museum1FText_SshGetAmberChecked
	text_end

Museum1FText_NoSpace:
	text_far _Museum1FText_NoSpace
	text_end

Func_PrintProud::
	ld hl, Museum1FText_WeAreProud
	call PrintText
	ret

Museum1FText_WeAreProud:
	text_far _Museum1FText_WeAreProud
	text_end

Func_PrintAmberIsClear::
	ld hl, Museum1FText_AmberClearGold
	call PrintText
	ret

Museum1FText_AmberClearGold:
	text_far _Museum1FText_AmberClearGold
	text_end

; new for RP ====================

Func_EntryPerson_RP::
	ld a, [wYCoord]
	cp 3
	jr z, .behind_counter
	cp 5
	jr z, .not_behind_counter
	ld a, [wXCoord]
	cp 13
	jr z, .behind_counter
.not_behind_counter
	ld hl, Museum1FText_RP_NotBehindCounter
	jr .printAndEnd
.behind_counter
	ld hl, Museum1FText_RP_BehindCounter
.printAndEnd
	jp PrintText

Func_NoOurAmber_RP::
	ld hl, Museum1FText_RP_NoOurAmber_Before
	CheckEvent EVENT_GOT_OLD_AMBER
	jr z, .printAndEnd
	ld hl, Museum1FText_RP_NoOurAmber_After
.printAndEnd
	jp PrintText

Func_TakeAmber_RP::
	ld hl, Museum1FText_RP_NiceAmber
	call PrintText
	lb bc, OLD_AMBER, 1
	call GiveItem
	jr nc, .bag_full
; actually take it
	SetEvent EVENT_GOT_OLD_AMBER
	ld a, HS_OLD_AMBER
	ld [wMissableObjectIndex], a
	predef HideObject
	ld hl, Museum1FText_RP_StoleAmber
	jr .printAndEnd
.bag_full
	ld hl, Museum1FText_RP_NoSpace
.printAndEnd
	jp PrintText

Museum1FText_RP_NotBehindCounter:
	text_far _Museum1FText_RP_NotBehindCounter
	text_end

Museum1FText_RP_BehindCounter:
	text_far _Museum1FText_RP_BehindCounter
	text_end

Museum1FText_RP_NiceAmber:
	text_far _Museum1FText_RP_NiceAmber
	text_end

Museum1FText_RP_StoleAmber:
	text_far _Museum1FText_RP_StoleAmber
	sound_get_item_1
	text_end

Museum1FText_RP_NoSpace:
	text_far _BagFullText_RP
	text_end

Museum1FText_RP_NoOurAmber_Before:
	text_far _Museum1FText_RP_NoOurAmber_Before
	text_end

Museum1FText_RP_NoOurAmber_After:
	text_far _Museum1FText_RP_NoOurAmber_After
	text_end
