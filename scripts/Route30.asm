Route30_Script:
	call EnableAutoTextBoxDrawing
	ret

Route30_TextPointers:
	dw BoulderText
	dw Route30CoinCaseMeowthText ; Meowth
	; signs
	dw Route30SignText1

Route30SignText1:
	text_far _Route30SignText1
	text_end

Route30CoinCaseMeowthText:
	text_far _Route30CoinCaseMeowthText_Miao
	text_asm
	ld a, MEOWTH
	call PlayCry
	call WaitForSoundToFinish
	call WaitForTextScrollButtonPress
	
	call GBFadeOutToBlack

	ld a, HS_ROUTE_30_COIN_CASE_MEOWTH
	ld [wMissableObjectIndex], a
	predef HideObjectExtra

	ld a, HS_PEWTER_CITY_COIN_CASE_MEOWTH
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra

	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack

	ld hl, Route30CoinCaseMeowthText_HintNext
	call PrintText

	jp TextScriptEnd

Route30CoinCaseMeowthText_HintNext:
	text_far _Route30CoinCaseMeowthText_HintNext
	text_end
