; edited to make the Coin Case not a physical object
Func_f1f31::
	CheckEvent EVENT_GOT_COIN_CASE
	jr nz, .got_item
	ld hl, CeladonDinerText_491a7
	call PrintText
	SetEvent EVENT_GOT_COIN_CASE
	ld hl, ReceivedCoinCaseText
	call PrintText
	call WaitForTextScrollButtonPress
	ld hl, CoinCaseExplanationText
	jr .printAndEnd
.got_item
	ld hl, CeladonDinerText_491b7
.printAndEnd
	call PrintText
	ret

CeladonDinerText_491a7:
	text_far _CeladonDinerText_491a7
	text_end

ReceivedCoinCaseText:
	text_far _ReceivedCoinCaseText
	sound_get_key_item
	text_end

CoinCaseExplanationText: ; new
	text_far _CoinCaseExplanationText
	text_end

CeladonDinerText_491b7:
	text_far _CeladonDinerText_491b7
	text_end
